Return-Path: <bpf+bounces-19321-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6D4829AAD
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 13:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65AC8B25D13
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 12:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1961D482FF;
	Wed, 10 Jan 2024 12:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRCt8dBu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B0547A55;
	Wed, 10 Jan 2024 12:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3376f71fcbbso2434324f8f.1;
        Wed, 10 Jan 2024 04:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704891212; x=1705496012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uoyz0fX05VFZUA0YqL9VDmTIjZubn+1o1Tubn/qOGIQ=;
        b=QRCt8dBuUo61U80x+UbI9iYm4wNqiKpKo/ZCFSlWEKoYZ3vVakTuJsl4TI238dfTLV
         Jl+VNIWdAdgYJP1D2srrJPsZ0B0jTB2rePpPzmjX2d856iopsGt0xe+LHlw0T7RCJTWs
         MLELwvE/mYGu4g9qtrwlBvuOsbjJ1/K0ThBbkZdNcSc6BGf1sXdKT5KAeUWD4Y+EGH0/
         PWzQMPzVpaZOew6qsW5V3nn/hcPlFSN/4L+sSefSXFn6u22MdKIw62BwWKqRBhYDrvBs
         ohAt/f71gVGRQP7+LYdLMUc8LZZUH9lIh0CZs7lC/3QcuVQEuU+Rl4BiVxlMDVC/3O/z
         8PYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704891212; x=1705496012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uoyz0fX05VFZUA0YqL9VDmTIjZubn+1o1Tubn/qOGIQ=;
        b=cywA7dD0ucZkBZywTH9QVp7quEVksLWdHjNJaTP7G1slr1IVzMUpD8kocS7U3cTTmg
         zxEWwHdFfb/OiHgvv79ECE1uXZnpkbekBuGCaKGYzNDRa5KXnWU62x09gFmt1UIpphZU
         /A0ODZDsYuFtu5aa/GfEQ+Wu6KOBtP2HmtQAAgSOg2qRMtHMiurfqWCcGfbZqGUgzmTS
         FvNCcgrbxm3ihlWxei62b325bodlVOh93/tBjEuDqa8a61fA4aN/VyVFbIShTk0JXbs/
         E5NWO7o5mvpaAivcdmbc5oom5kImDik5fTG9qjU+l0AVGdU2D4xJaDxkPeZVd8NkgwTE
         5Rfw==
X-Gm-Message-State: AOJu0YzoDx+Mib1jEI1CnPROOj9O+D7Dj0VmhtpmHnUQd/xvdtzJS1Wq
	+zZnyf8uVMQpWFDzqTDBiKPT1MGRmg==
X-Google-Smtp-Source: AGHT+IGIAb7J0lg1izF1tG7pKhpkLK3OW1M2akqGAPGYCtE+kNQFKuA/o+fJ7slq0pY6valFev7ekw==
X-Received: by 2002:a5d:5449:0:b0:336:905a:bf87 with SMTP id w9-20020a5d5449000000b00336905abf87mr357212wrv.69.1704891211635;
        Wed, 10 Jan 2024 04:53:31 -0800 (PST)
Received: from localhost.localdomain (46-253-188-135.dynamic.monzoon.net. [46.253.188.135])
        by smtp.gmail.com with ESMTPSA id k10-20020a5d524a000000b00336898daceasm4833238wrc.96.2024.01.10.04.53.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 10 Jan 2024 04:53:31 -0800 (PST)
From: Hao Sun <sunhao.th@gmail.com>
To: bpf@vger.kernel.org
Cc: ppenkov@google.com,
	willemb@google.com,
	ast@kernel.org,
	linux-kernel@vger.kernel.org,
	Hao Sun <sunhao.th@gmail.com>
Subject: [PATCH v2 1/2] bpf: Reject variable offset alu on PTR_TO_FLOW_KEYS
Date: Wed, 10 Jan 2024 13:53:16 +0100
Message-ID: <20240110125317.13742-1-sunhao.th@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For PTR_TO_FLOW_KEYS, check_flow_keys_access() only uses fixed off
for validation. However, variable offset ptr alu is not prohibited
for this ptr kind. So the variable offset is not checked.

The following prog is accepted:
func#0 @0
0: R1=ctx() R10=fp0
0: (bf) r6 = r1                       ; R1=ctx() R6_w=ctx()
1: (79) r7 = *(u64 *)(r6 +144)        ; R6_w=ctx() R7_w=flow_keys()
2: (b7) r8 = 1024                     ; R8_w=1024
3: (37) r8 /= 1                       ; R8_w=scalar()
4: (57) r8 &= 1024                    ; R8_w=scalar(smin=smin32=0,
smax=umax=smax32=umax32=1024,var_off=(0x0; 0x400))
5: (0f) r7 += r8
mark_precise: frame0: last_idx 5 first_idx 0 subseq_idx -1
mark_precise: frame0: regs=r8 stack= before 4: (57) r8 &= 1024
mark_precise: frame0: regs=r8 stack= before 3: (37) r8 /= 1
mark_precise: frame0: regs=r8 stack= before 2: (b7) r8 = 1024
6: R7_w=flow_keys(smin=smin32=0,smax=umax=smax32=umax32=1024,var_off
=(0x0; 0x400)) R8_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=1024,
var_off=(0x0; 0x400))
6: (79) r0 = *(u64 *)(r7 +0)          ; R0_w=scalar()
7: (95) exit

This prog loads flow_keys to r7, and adds the variable offset r8
to r7, and finally causes out-of-bounds access:

BUG: unable to handle page fault for address: ffffc90014c80038
...
Call Trace:
 <TASK>
 bpf_dispatcher_nop_func include/linux/bpf.h:1231 [inline]
 __bpf_prog_run include/linux/filter.h:651 [inline]
 bpf_prog_run include/linux/filter.h:658 [inline]
 bpf_prog_run_pin_on_cpu include/linux/filter.h:675 [inline]
 bpf_flow_dissect+0x15f/0x350 net/core/flow_dissector.c:991
 bpf_prog_test_run_flow_dissector+0x39d/0x620 net/bpf/test_run.c:1359
 bpf_prog_test_run kernel/bpf/syscall.c:4107 [inline]
 __sys_bpf+0xf8f/0x4560 kernel/bpf/syscall.c:5475
 __do_sys_bpf kernel/bpf/syscall.c:5561 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5559 [inline]
 __x64_sys_bpf+0x73/0xb0 kernel/bpf/syscall.c:5559
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x3f/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Fix this by rejecting ptr alu with variable offset on flow_keys.
Applying the patch makes the program rejected with "R7 pointer
arithmetic on flow_keys prohibited"

Fixes: d58e468b1112 ("flow_dissector: implements flow dissector BPF hook")
Signed-off-by: Hao Sun <sunhao.th@gmail.com>
---
 kernel/bpf/verifier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index adbf330d364b..65f598694d55 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12826,6 +12826,10 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 	}
 
 	switch (base_type(ptr_reg->type)) {
+	case PTR_TO_FLOW_KEYS:
+		if (known)
+			break;
+		fallthrough;
 	case CONST_PTR_TO_MAP:
 		/* smin_val represents the known value */
 		if (known && smin_val == 0 && opcode == BPF_ADD)
-- 
2.34.1


