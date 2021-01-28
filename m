Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB3A307B5A
	for <lists+bpf@lfdr.de>; Thu, 28 Jan 2021 17:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbhA1Qvx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jan 2021 11:51:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34281 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232692AbhA1Qvv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 28 Jan 2021 11:51:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611852624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r33CpG98rw/mr6rLy4ACeQ8mouSsHQS8jL40ZLPrdjc=;
        b=UqsO80PUjG/JQlJovlBLZKnbQExo4kuIpRkw52vHTraNLKjfr2pTJtzSzLDp0wjJO1XPhn
        dQ90NtcX5xh8CxZ+6ILfYzvyFWfAGkx8c8HXbn+ssY23hEZ2i0TFw405QaSksGax1sgO65
        PRa24tesaXHWOww2K2UT4juP9frmwKI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-H4bP6a7rNJaQIZhk8G-ODA-1; Thu, 28 Jan 2021 11:50:20 -0500
X-MC-Unique: H4bP6a7rNJaQIZhk8G-ODA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D4DF1081B38;
        Thu, 28 Jan 2021 16:50:18 +0000 (UTC)
Received: from treble (ovpn-120-118.rdu2.redhat.com [10.10.120.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 967C95C1BB;
        Thu, 28 Jan 2021 16:50:16 +0000 (UTC)
Date:   Thu, 28 Jan 2021 10:50:14 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Masami Hiramatsu <masami.hiramatsu@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: kprobes broken since 0d00449c7a28 ("x86: Replace ist_enter()
 with nmi_enter()")
Message-ID: <20210128165014.xc77qtun6fl2qfun@treble>
References: <25cd2608-03c2-94b8-7760-9de9935fde64@suse.com>
 <20210128001353.66e7171b395473ef992d6991@kernel.org>
 <20210128002452.a79714c236b69ab9acfa986c@kernel.org>
 <a35a6f15-9ab1-917c-d443-23d3e78f2d73@suse.com>
 <20210128103415.d90be51ec607bb6123b2843c@kernel.org>
 <20210128123842.c9e33949e62f504b84bfadf5@gmail.com>
 <e8bae974-190b-f247-0d89-6cea4fd4cc39@suse.com>
 <eb1ec6a3-9e11-c769-84a4-228f23dc5e23@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb1ec6a3-9e11-c769-84a4-228f23dc5e23@suse.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 28, 2021 at 06:45:56PM +0200, Nikolay Borisov wrote:
> On 28.01.21 г. 18:12 ч., Nikolay Borisov wrote:
> > On 28.01.21 г. 5:38 ч., Masami Hiramatsu wrote:
> >> Hi,
> > 
> > <snip>
> >>
> >> Alexei, could you tell me what is the concerning situation for bpf?
> > 
> > Another data point masami is that this affects bpf kprobes which are
> > entered via int3, alternatively if the kprobe is entered via
> > kprobe_ftrace_handler it works as expected. I haven't been able to
> > determine why a particular bpf probe won't use ftrace's infrastructure
> > if it's put at the beginning of the function.  An alternative call chain
> > is :
> > 
> >  => __ftrace_trace_stack
> >  => trace_call_bpf
> >  => kprobe_perf_func
> >  => kprobe_ftrace_handler
> >  => 0xffffffffc095d0c8
> >  => btrfs_validate_metadata_buffer
> >  => end_bio_extent_readpage
> >  => end_workqueue_fn
> >  => btrfs_work_helper
> >  => process_one_work
> >  => worker_thread
> >  => kthread
> >  => ret_from_fork
> > 
> >>
> 
> I have a working theory why I'm seeing this. My kernel (broken) was
> compiled with retpolines off and with the gcc that comes with ubuntu
> (both 9 and 10:
> gcc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0
> gcc-10 (Ubuntu 10.2.0-5ubuntu1~20.04) 10.2.0
> )
> 
> this results in CFI being enabled so functions look like:
> 0xffffffff81493890 <+0>: endbr64
> 0xffffffff81493894 <+4>: callq  0xffffffff8104d820 <__fentry__>
> 
> i.e fentry's thunk is not the first instruction on the function hence
> it's not going through the optimized ftrace handler. Instead it's using
> int3 which is broken as ascertained.
> 
> After testing with my testcase I confirm that with cfi off and
> __fentry__ being the first entry bpf starts working. And indeed, even
> with CFI turned on if I use a probe like :
> 
> bpftrace -e 'kprobe:btrfs_sync_file+4 {printf("kprobe: %s\n",
> kstack());}' &>bpf-output &
> 
> 
> it would be placed on the __fentry__ (and not endbr64) hence it works.
> So perhaps a workaround outside of bpf could essentially detect this
> scenario and adjust the probe to be on the __fentry__ and not preceding
> instruction if it's detected to be endbr64 ?

For now (and the foreseeable future), CET isn't enabled in the kernel.
So that endbr64 shouldn't be there in the first place.  I can make a
proper patch in a bit.

diff --git a/Makefile b/Makefile
index e0af7a4a5598..5ccc4cdf1fb5 100644
--- a/Makefile
+++ b/Makefile
@@ -948,11 +948,8 @@ KBUILD_CFLAGS   += $(call cc-option,-Werror=designated-init)
 # change __FILE__ to the relative path from the srctree
 KBUILD_CPPFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
 
-# ensure -fcf-protection is disabled when using retpoline as it is
-# incompatible with -mindirect-branch=thunk-extern
-ifdef CONFIG_RETPOLINE
+# Intel CET isn't enabled in the kernel
 KBUILD_CFLAGS += $(call cc-option,-fcf-protection=none)
-endif
 
 # include additional Makefiles when needed
 include-y			:= scripts/Makefile.extrawarn

