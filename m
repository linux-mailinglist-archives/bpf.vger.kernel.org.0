Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1EC613DDE5
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2020 15:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbgAPOpx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Jan 2020 09:45:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:36446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729044AbgAPOpv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jan 2020 09:45:51 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E9012072B;
        Thu, 16 Jan 2020 14:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579185951;
        bh=GC3qzfU4RX1GrYAWYtC4PLg6M7nTBzDNTdRDeUAklZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E/znIrFkYEWN52lPe+FGFD9cSZ2z7hr5vSzaV/1SYfYu0VOcWucHeSlx+eMBg0j2K
         bzps6ycMdb6JsC4uwXLp/2ey4IOKz3j5mh1ISS0DooCMiQcELzM22/QdZkT9pTu8jn
         eq1muBO5De5QqSBZiXKvQmC73wwHAzG45ZbRt0a0=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Brendan Gregg <brendan.d.gregg@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     mhiramat@kernel.org, Ingo Molnar <mingo@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "David S . Miller" <davem@davemloft.net>, paulmck@kernel.org,
        joel@joelfernandes.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Subject: [RFT PATCH 09/13] kprobes: Free kprobe_insn_page asynchronously
Date:   Thu, 16 Jan 2020 23:45:46 +0900
Message-Id: <157918594575.29301.16307406359272775745.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157918584866.29301.6941815715391411338.stgit@devnote2>
References: <157918584866.29301.6941815715391411338.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Free the kprobe_insn_page data structure asynchronously
using call_rcu().

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/kprobes.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index a9114923da4c..60ffc9d54d87 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -87,6 +87,7 @@ static LIST_HEAD(kprobe_blacklist);
  */
 struct kprobe_insn_page {
 	struct list_head list;
+	struct rcu_head rcu;
 	kprobe_opcode_t *insns;		/* Page of instruction slots */
 	struct kprobe_insn_cache *cache;
 	int nused;
@@ -192,6 +193,13 @@ kprobe_opcode_t *__get_insn_slot(struct kprobe_insn_cache *c)
 	return slot;
 }
 
+static void free_kprobe_insn_page(struct rcu_head *head)
+{
+	struct kprobe_insn_page *kip = container_of(head, typeof(*kip), rcu);
+
+	kfree(kip);
+}
+
 /* Return 1 if all garbages are collected, otherwise 0. */
 static int collect_one_slot(struct kprobe_insn_page *kip, int idx)
 {
@@ -206,9 +214,8 @@ static int collect_one_slot(struct kprobe_insn_page *kip, int idx)
 		 */
 		if (!list_is_singular(&kip->list)) {
 			list_del_rcu(&kip->list);
-			synchronize_rcu();
 			kip->cache->free(kip->insns);
-			kfree(kip);
+			call_rcu(&kip->rcu, free_kprobe_insn_page);
 		}
 		return 1;
 	}

