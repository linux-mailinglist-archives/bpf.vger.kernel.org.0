Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FADC13DDC9
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2020 15:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgAPOoh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Jan 2020 09:44:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:35140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbgAPOoh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jan 2020 09:44:37 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1260208C3;
        Thu, 16 Jan 2020 14:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579185876;
        bh=2GiHt6Ui+3fyNaUuixY123hCFx4jIohDN/TnvjbfZ9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VkAsTcJE9TkApHfIPMOeCvK3rX5XNfQGJ9D8ZzNHMDJfP2l40UzQYqbiM1WoDtuzH
         oM2i9ssA8li9UsG3enlltazIeneNiyRux0HeAPr0iphBI+B3qvq4oCf7tSUGHuC/eo
         ZlJUuFj6izpSiwR3IHWj34C8apFdOPtrTG0bbMys=
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
Subject: [RFT PATCH 02/13] kprobes: Remove redundant arch_disarm_kprobe() call
Date:   Thu, 16 Jan 2020 23:44:30 +0900
Message-Id: <157918586979.29301.15267608912757298568.stgit@devnote2>
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

Fix to remove redundant arch_disarm_kprobe() call in
force_unoptimize_kprobe(). This arch_disarm_kprobe()
will be done if the kprobe is optimized but disabled,
but that means the kprobe (optprobe) is unused
(unoptimizing) state.
In that case, unoptimize_kprobe() puts it in freeing_list
and kprobe_optimizer automatically disarm it. So this
arch_disarm_kprobe() is redundant.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/kprobes.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 52b05ab9c323..a2c755e79be7 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -674,8 +674,6 @@ static void force_unoptimize_kprobe(struct optimized_kprobe *op)
 	lockdep_assert_cpus_held();
 	arch_unoptimize_kprobe(op);
 	op->kp.flags &= ~KPROBE_FLAG_OPTIMIZED;
-	if (kprobe_disabled(&op->kp))
-		arch_disarm_kprobe(&op->kp);
 }
 
 /* Unoptimize a kprobe if p is optimized */

