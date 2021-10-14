Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F218542E2CA
	for <lists+bpf@lfdr.de>; Thu, 14 Oct 2021 22:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbhJNUa3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Oct 2021 16:30:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232172AbhJNUa1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Oct 2021 16:30:27 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43775603E5;
        Thu, 14 Oct 2021 20:28:21 +0000 (UTC)
Date:   Thu, 14 Oct 2021 16:28:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH 7/8] ftrace: Add multi direct modify interface
Message-ID: <20211014162819.5c85618b@gandalf.local.home>
In-Reply-To: <20211008091336.33616-8-jolsa@kernel.org>
References: <20211008091336.33616-1-jolsa@kernel.org>
        <20211008091336.33616-8-jolsa@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri,  8 Oct 2021 11:13:35 +0200
Jiri Olsa <jolsa@redhat.com> wrote:

> +	/*
> +	 * Shutdown the ops, change 'direct' pointer for each
> +	 * ops entry in direct_functions hash and startup the
> +	 * ops back again.
> +	 *
> +	 * Note there is no callback called for @ops object after
> +	 * this ftrace_shutdown call until ftrace_startup is called
> +	 * later on.
> +	 */
> +	err = ftrace_shutdown(ops, 0);
> +	if (err)
> +		goto out_unlock;

I believe I said before that we can do this by adding a stub ops that match
all the functions with the direct ops being modified. This will cause the
loop function to be called, which will call the direct function helper,
which will then call the direct function that is found. That is, there is
no "pause" in calling the direct callers. Either the old direct is called,
or the new one. When the function returns, all are calling the new one.

That is, instead of:

[ Changing direct call from my_direct_1 to my_direct_2 ]

  <traced_func>:
     call my_direct_1

 ||||||||||||||||||||
 vvvvvvvvvvvvvvvvvvvv

  <traced_func>:
     nop

 ||||||||||||||||||||
 vvvvvvvvvvvvvvvvvvvv

  <traced_func>:
     call my_direct_2


We have it do:

  <traced_func>:
     call my_direct_1

 ||||||||||||||||||||
 vvvvvvvvvvvvvvvvvvvv

  <traced_func>:
     call ftrace_caller


  <ftrace_caller>:
    [..]
    call ftrace_ops_list_func


ftrace_ops_list_func()
{
	ops->func() -> direct_helper -> set rax to my_direct_1 or my_direct_2
}

   call rax (to either my_direct_1 or my_direct_2

 ||||||||||||||||||||
 vvvvvvvvvvvvvvvvvvvv

  <traced_func>:
     call my_direct_2


I did this on top of this patch:

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 30120342176e..7ad1e8ae5855 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5561,8 +5561,12 @@ EXPORT_SYMBOL_GPL(unregister_ftrace_direct_multi);
  */
 int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
 {
-	struct ftrace_hash *hash = ops->func_hash->filter_hash;
+	struct ftrace_hash *hash;
 	struct ftrace_func_entry *entry, *iter;
+	static struct ftrace_ops tmp_ops = {
+		.func		= ftrace_stub,
+		.flags		= FTRACE_OPS_FL_STUB,
+	};
 	int i, size;
 	int err;
 
@@ -5572,21 +5576,22 @@ int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
 		return -EINVAL;
 
 	mutex_lock(&direct_mutex);
-	mutex_lock(&ftrace_lock);
+
+	/* Enable the tmp_ops to have the same functions as the direct ops */
+	ftrace_ops_init(&tmp_ops);
+	tmp_ops.func_hash = ops->func_hash;
+
+	err = register_ftrace_function(&tmp_ops);
+	if (err)
+		goto out_direct;
 
 	/*
-	 * Shutdown the ops, change 'direct' pointer for each
-	 * ops entry in direct_functions hash and startup the
-	 * ops back again.
-	 *
-	 * Note there is no callback called for @ops object after
-	 * this ftrace_shutdown call until ftrace_startup is called
-	 * later on.
+	 * Now the ftrace_ops_list_func() is called to do the direct callers.
+	 * We can safely change the direct functions attached to each entry.
 	 */
-	err = ftrace_shutdown(ops, 0);
-	if (err)
-		goto out_unlock;
+	mutex_lock(&ftrace_lock);
 
+	hash = ops->func_hash->filter_hash;
 	size = 1 << hash->size_bits;
 	for (i = 0; i < size; i++) {
 		hlist_for_each_entry(iter, &hash->buckets[i], hlist) {
@@ -5597,10 +5602,12 @@ int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
 		}
 	}
 
-	err = ftrace_startup(ops, 0);
+	/* Removing the tmp_ops will add the updated direct callers to the functions */
+	unregister_ftrace_function(&tmp_ops);
 
  out_unlock:
 	mutex_unlock(&ftrace_lock);
+ out_direct:
 	mutex_unlock(&direct_mutex);
 	return err;
 }
-- 
2.31.1

