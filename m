Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72D2644D60
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2019 22:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfFMU0W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Jun 2019 16:26:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54868 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbfFMU0W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Jun 2019 16:26:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DC73580F79;
        Thu, 13 Jun 2019 20:26:19 +0000 (UTC)
Received: from treble (ovpn-121-232.rdu2.redhat.com [10.10.121.232])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 96F995D9C8;
        Thu, 13 Jun 2019 20:26:16 +0000 (UTC)
Date:   Thu, 13 Jun 2019 15:26:13 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kairui Song <kasong@redhat.com>, Alexei Starovoitov <ast@fb.com>,
        Song Liu <songliubraving@fb.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Getting empty callchain from perf_callchain_kernel()
Message-ID: <20190613202613.zt4rvxiqyaolvqpq@treble>
References: <20190522174517.pbdopvookggen3d7@treble>
 <20190522234635.a47bettklcf5gt7c@treble>
 <CACPcB9dRJ89YAMDQdKoDMU=vFfpb5AaY0mWC_Xzw1ZMTFBf6ng@mail.gmail.com>
 <20190523133253.tad6ywzzexks6hrp@treble>
 <CACPcB9fQKg7xhzhCZaF4UGi=EQs1HLTFgg-C_xJQaUfho3yMyA@mail.gmail.com>
 <20190523152413.m2pbnamihu3s2c5s@treble>
 <20190524085319.GE2589@hirez.programming.kicks-ass.net>
 <20190612030501.7tbsjy353g7l74ej@treble>
 <20190612085423.GE3436@hirez.programming.kicks-ass.net>
 <20190612145008.3l5iguuwk2termi4@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190612145008.3l5iguuwk2termi4@treble>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 13 Jun 2019 20:26:22 +0000 (UTC)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 12, 2019 at 09:50:08AM -0500, Josh Poimboeuf wrote:
> > Other than that, the same note as before, the 32bit JIT still seems
> > buggered, but I'm not sure you (or anybody else) cares enough about that
> > to fix it though. It seems to use ebp as its own frame pointer, which
> > completely defeats an unwinder.
> 
> I'm still trying to decide if I care about 32-bit.  It does indeed use
> ebp everywhere.  But I'm not sure if I want to poke the beehive...  Also
> factoring into the equation is the fact that I'll be on PTO next week
> :-)  If I have time in the next couple days then I may take a look.

32-bit actually looks much easier to fix than 64-bit was.  I haven't
tested it yet though, but I'll be gone next week so I'll just drop it
here in case anybody wants to try it.


diff --git a/arch/x86/net/bpf_jit_comp32.c b/arch/x86/net/bpf_jit_comp32.c
index b29e82f190c7..8c1de7786e49 100644
--- a/arch/x86/net/bpf_jit_comp32.c
+++ b/arch/x86/net/bpf_jit_comp32.c
@@ -169,6 +169,10 @@ static const u8 bpf2ia32[][2] = {
 #define src_hi	src[1]
 
 #define STACK_ALIGNMENT	8
+
+/* Size of callee-saved register space (except EBP) */
+#define CALLEE_SAVE_SIZE 12
+
 /*
  * Stack space for BPF_REG_1, BPF_REG_2, BPF_REG_3, BPF_REG_4,
  * BPF_REG_5, BPF_REG_6, BPF_REG_7, BPF_REG_8, BPF_REG_9,
@@ -176,13 +180,14 @@ static const u8 bpf2ia32[][2] = {
  */
 #define SCRATCH_SIZE 96
 
-/* Total stack size used in JITed code */
+/* Total stack size used in JITed code (except callee-saved) */
 #define _STACK_SIZE	(stack_depth + SCRATCH_SIZE)
 
 #define STACK_SIZE ALIGN(_STACK_SIZE, STACK_ALIGNMENT)
 
-/* Get the offset of eBPF REGISTERs stored on scratch space. */
-#define STACK_VAR(off) (off)
+/* Offset of eBPF REGISTERs stored in scratch space, relative to EBP */
+//FIXME: rename to EBP_OFFSET
+#define STACK_VAR(off) (off - CALLEE_SAVE_SIZE - SCRATCH_SIZE)
 
 /* Encode 'dst_reg' register into IA32 opcode 'byte' */
 static u8 add_1reg(u8 byte, u32 dst_reg)
@@ -1408,7 +1413,7 @@ struct jit_context {
 #define BPF_MAX_INSN_SIZE	128
 #define BPF_INSN_SAFETY		64
 
-#define PROLOGUE_SIZE 35
+#define PROLOGUE_SIZE 32
 
 /*
  * Emit prologue code for BPF program and check it's size.
@@ -1436,8 +1441,6 @@ static void emit_prologue(u8 **pprog, u32 stack_depth)
 
 	/* sub esp,STACK_SIZE */
 	EMIT2_off32(0x81, 0xEC, STACK_SIZE);
-	/* sub ebp,SCRATCH_SIZE+12*/
-	EMIT3(0x83, add_1reg(0xE8, IA32_EBP), SCRATCH_SIZE + 12);
 	/* xor ebx,ebx */
 	EMIT2(0x31, add_2reg(0xC0, IA32_EBX, IA32_EBX));
 
@@ -1470,18 +1473,21 @@ static void emit_epilogue(u8 **pprog, u32 stack_depth)
 	/* mov edx,dword ptr [ebp+off]*/
 	EMIT3(0x8B, add_2reg(0x40, IA32_EBP, IA32_EDX), STACK_VAR(r0[1]));
 
-	/* add ebp,SCRATCH_SIZE+12*/
-	EMIT3(0x83, add_1reg(0xC0, IA32_EBP), SCRATCH_SIZE + 12);
+	/* add esp, STACK_SIZE */
+	EMIT2_off32(0x81, 0xC4, STACK_SIZE);
+
+	/* pop ebx */
+	EMIT1(0x5b);
+	/* pop esi */
+	EMIT1(0x5e);
+	/* pop edi */
+	EMIT1(0x5f);
+	/* pop ebp */
+	EMIT1(0x5d);
 
-	/* mov ebx,dword ptr [ebp-12]*/
-	EMIT3(0x8B, add_2reg(0x40, IA32_EBP, IA32_EBX), -12);
-	/* mov esi,dword ptr [ebp-8]*/
-	EMIT3(0x8B, add_2reg(0x40, IA32_EBP, IA32_ESI), -8);
-	/* mov edi,dword ptr [ebp-4]*/
-	EMIT3(0x8B, add_2reg(0x40, IA32_EBP, IA32_EDI), -4);
+	/* ret */
+	EMIT1(0xC3);
 
-	EMIT1(0xC9); /* leave */
-	EMIT1(0xC3); /* ret */
 	*pprog = prog;
 }
 
