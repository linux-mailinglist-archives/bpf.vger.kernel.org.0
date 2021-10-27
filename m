Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9E943C5DA
	for <lists+bpf@lfdr.de>; Wed, 27 Oct 2021 10:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241129AbhJ0JBF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 27 Oct 2021 05:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241127AbhJ0JA6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Oct 2021 05:00:58 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA87C061220
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 01:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:To:From:Date:Message-ID:Sender:Reply-To:Cc:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=eYPAZo+0FtCg9b7QXUoJ4s5MyxJv/uR6aBOezIPDLiE=; b=L+qFuQSO8I+0+PNsjiX+Mrvzxt
        uiLkbJHSVRbQnGuRl60jOuquh0IEptlZS9oKjmfPsOTT4GrT9HsugnLNHtW0LCcvTXAH1QHvqeHp2
        5mvmIgUzyHRs7EZ5+4KrWk3x3GIIDW6cenbv/yDxlmi9frUp+X8X9axrOSqtJzJG12V6tBK0LfX/a
        84NuctHxoYq8PJa1orrRpgb/fCrOzdCvED3DooJK+oK/aQfzJqa1Sc4fpVLUpdFDqCD5GJqb/f+BP
        WZgx+iY1uQcW1ZLoOa30f9209mBGjLfS1UWm4bNbvelXBhlWZqeoGW4dGFhYQCc9k8LD5XzBXRzFL
        jSeJZaIA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfelT-00CWWK-5N
        for bpf@vger.kernel.org; Wed, 27 Oct 2021 08:58:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B79B9301998
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 10:58:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A7BA3236E43D9; Wed, 27 Oct 2021 10:58:20 +0200 (CEST)
Message-ID: <20211027085520.992974471@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 27 Oct 2021 10:52:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     bpf@vger.kernel.org
Subject: [PATCH bpf-next 14/17] x86/alternative: Add debug prints to apply_retpolines()
References: <20211027085243.008677168@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make sure we can see the text changes when booting with
'debug-alternative'.

Example output:

 [ ] SMP alternatives: retpoline at: __traceiter_initcall_level+0x1f/0x30 (ffffffff8100066f) len: 5 to: __x86_indirect_thunk_rax+0x0/0x20
 [ ] SMP alternatives: ffffffff82603e58: [2:5) optimized NOPs: ff d0 0f 1f 00
 [ ] SMP alternatives: ffffffff8100066f: orig: e8 cc 30 00 01
 [ ] SMP alternatives: ffffffff8100066f: repl: ff d0 0f 1f 00

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/alternative.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -492,9 +492,15 @@ void __init_or_module noinline apply_ret
 			continue;
 		}
 
+		DPRINTK("retpoline at: %pS (%px) len: %d to: %pS",
+			addr, addr, insn.length,
+			addr + insn.length + insn.immediate.value);
+
 		len = patch_retpoline(addr, &insn, bytes);
 		if (len == insn.length) {
 			optimize_nops(bytes, len);
+			DUMP_BYTES(((u8*)addr),  len, "%px: orig: ", addr);
+			DUMP_BYTES(((u8*)bytes), len, "%px: repl: ", addr);
 			text_poke_early(addr, bytes, len);
 		}
 	}


