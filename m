Return-Path: <bpf+bounces-19522-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F8F82D4F5
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 09:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2128D281ABD
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 08:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D057E63AE;
	Mon, 15 Jan 2024 08:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkbhZcyg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9B0F9EC;
	Mon, 15 Jan 2024 08:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40e779f0253so5992855e9.1;
        Mon, 15 Jan 2024 00:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705306833; x=1705911633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dmqRToETWwbrShoMFrJKx33TAguFGIp6Y4ctqqBPrjI=;
        b=NkbhZcygPGgmSUftnsrGt/m5ugCC/3hCh4Ha4fgyLOjWr/lorryLFz0BdRZkpI5DIj
         O3QCsMpZ65CfuUoEDslNv6VCAh4Y2HPJx8kaFHMuS3j71HkK3TMLvBLCD91ROd2FDqLn
         AjmGH8cZp6/id0GfLTzdlUV3jr86os0jLhZ/LwM1Upg3Z/8weGBaP/92QA5fGYpMvhAa
         /J6UyVs8AvTzMvffBWY6ZkQGkuOs9zKJD2MPEkfcrL6qGlm8lNB9S3T3Z40p66h71wtY
         Rl+hV8MGL5BXlNaEpDVLX4wbW6hjDD9kSFHQKrYjZLliwZMZBhbnbo3rBQEGjMlSLocX
         K2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705306833; x=1705911633;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dmqRToETWwbrShoMFrJKx33TAguFGIp6Y4ctqqBPrjI=;
        b=M8pd5DYB55tdWe4tfGWH/pIQtZVVv1sen7h+4Tp+TeCgZXOXLF/benrYW4ryxGlljg
         Fguor0q14taYk2vhZ5tw0+JOqayZ5sCQrlSUN57b86cthaHjrFjKDVfyFBlDz14V1YIK
         xZWJ7TdsTLonLtSUeICeA/jNfCximiUx1ZKJe2sJXajruaOZPEPtmsXaMmScgiFsrqEZ
         YALiQYnP779K35R1lgf6k3CyB2p4UTptXgbBk6d3+iomOEl13c2pAXvkyPYt8F5b78fx
         E+iwje9OPIQuO8IgeCimtBcR3a3dq5pDheQxz3w8VRwIDG3VehYNl1eJfTyS7MIXrcUi
         cWtQ==
X-Gm-Message-State: AOJu0YzYk+QMaZ4K3G4tidxKiZ6HeqBKzo61hfbx8Q5s3PHYW1n5Sgvd
	t51+rXYHdcIFwinhI74nOClj3e4PMg==
X-Google-Smtp-Source: AGHT+IGQTbsiEJggxWBpQTtpDVbHo5BO+tu+EPDgUlEzLPZiWhQOD9r3sEeg6gS0HOWniFPeUqNtMg==
X-Received: by 2002:a05:600c:524c:b0:40e:397e:16e7 with SMTP id fc12-20020a05600c524c00b0040e397e16e7mr2800231wmb.3.1705306833154;
        Mon, 15 Jan 2024 00:20:33 -0800 (PST)
Received: from staff-net-cx-3510.intern.ethz.ch (2001-67c-10ec-5784-8000--16b.net6.ethz.ch. [2001:67c:10ec:5784:8000::16b])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c19d100b0040e47dc2e8fsm14981194wmq.6.2024.01.15.00.20.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 Jan 2024 00:20:32 -0800 (PST)
From: Hao Sun <sunhao.th@gmail.com>
To: bpf@vger.kernel.org
Cc: willemb@google.com,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	linux-kernel@vger.kernel.org,
	Hao Sun <sunhao.th@gmail.com>
Subject: [PATCH v4 1/2] bpf: Reject variable offset alu on PTR_TO_FLOW_KEYS
Date: Mon, 15 Jan 2024 09:20:27 +0100
Message-ID: <20240115082028.9992-1-sunhao.th@gmail.com>
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
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
Changelogs:
	v3 -> v4: drop the success test in the second patch.
	v2 -> v3: format the second patch with proper number of tabs.
	v1 -> v2: add two test cases for the first patch.

 kernel/bpf/verifier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9507800026cf..bd1da0d3ebce 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12862,6 +12862,10 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
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


