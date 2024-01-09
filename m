Return-Path: <bpf+bounces-19261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 122C6828919
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 16:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E9B828602D
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 15:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5272B39FEE;
	Tue,  9 Jan 2024 15:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ywhli+63"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBB439FE5;
	Tue,  9 Jan 2024 15:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33761e291c1so1773590f8f.0;
        Tue, 09 Jan 2024 07:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704814579; x=1705419379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uoyz0fX05VFZUA0YqL9VDmTIjZubn+1o1Tubn/qOGIQ=;
        b=Ywhli+630+H5SS8G8SdP1TgmtDG/N/PFkP2WGwB56asraV+ksNO+EQ+Nd63U29BAbU
         fSWUwniKDPXC92LKRHrteNS3OxqKE8EQmyz9ciQdzSl1/bSzQqMArWwl4MIDw80JhIF0
         c/Fnf+H+GpVfZx79mUQkH2XY1llzmOX3YX9f2zX2ndpK3KLJLjmqcII44z0j1yL0j+eO
         t67668S4U0KHxsGVPtEetlCLC3xyNDxQfi3sFop+epuH1ri4FJs4LLx56Say1DLzk2qY
         SU6zQH2ihIkCaUx5jVAxR61/E0gWEia9X41U1kOp4z3CcMJAZGuGkTyfeKSOVI3rA6/l
         PYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704814579; x=1705419379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uoyz0fX05VFZUA0YqL9VDmTIjZubn+1o1Tubn/qOGIQ=;
        b=JieGXoKZP7k3rk6YPPWHfixkbKRotT7DbtHPiIDd7T5qHFDza36BU4ezZtpMhsXh94
         VkfEbOz2hKMQvTqbTHEtqcJs8UtUgR0YcRhpKynwa/kI64NSETaar8OJ1t1QxYvWrrQ3
         R8zx/zjY89SgKzAMJIaQEN9RM+gkBS64XhivyMdqm4xqkOOc3xddjKpY93w34z72kqq4
         AAJLD9P1sG97NqMhmvhLIRS+qoFLkdmoEDUmVhe4ybcwQJ9ndUys46N5o+ygGkF13SsV
         N+K4hiQjw2N45pVVMOKStpg0wggSZBbvJXRqvXamIuXO6U6qtquzZ4ToAPCH6rZGaM67
         IHgQ==
X-Gm-Message-State: AOJu0YxCCM27bXFYGTlNNmxIZ0Nxzz+IUei2UEE3mjw0J83tqFy6OeDx
	ajb3sOuzaSQlh1JF3+i2dBhYW4IU1g==
X-Google-Smtp-Source: AGHT+IFF0m5AF5RduXEuT8dKBFZD9iSqrXMBvW+29jCDOiEUyuHNHIbAu0bVFq7vtE0jEW+OG0UyyA==
X-Received: by 2002:a5d:6349:0:b0:336:641d:626c with SMTP id b9-20020a5d6349000000b00336641d626cmr476091wrw.61.1704814578883;
        Tue, 09 Jan 2024 07:36:18 -0800 (PST)
Received: from staff-net-cx-3510.intern.ethz.ch (2001-67c-10ec-5784-8000--1bd.net6.ethz.ch. [2001:67c:10ec:5784:8000::1bd])
        by smtp.gmail.com with ESMTPSA id j25-20020adfb319000000b0033672cfca96sm2682295wrd.89.2024.01.09.07.36.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 09 Jan 2024 07:36:18 -0800 (PST)
From: Hao Sun <sunhao.th@gmail.com>
To: bpf@vger.kernel.org
Cc: ppenkov@google.com,
	willemb@google.com,
	ast@kernel.org,
	linux-kernel@vger.kernel.org,
	Hao Sun <sunhao.th@gmail.com>
Subject: [PATCH] bpf: Reject variable offset alu on PTR_TO_FLOW_KEYS
Date: Tue,  9 Jan 2024 16:36:09 +0100
Message-ID: <20240109153609.10185-1-sunhao.th@gmail.com>
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


