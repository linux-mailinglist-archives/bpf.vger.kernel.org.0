Return-Path: <bpf+bounces-19457-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEA382C2A4
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 16:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46A41B23A41
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 15:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE776EB4C;
	Fri, 12 Jan 2024 15:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpIAopN0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B23A6DD1D;
	Fri, 12 Jan 2024 15:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e69b314e0so696495e9.1;
        Fri, 12 Jan 2024 07:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705072832; x=1705677632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uoyz0fX05VFZUA0YqL9VDmTIjZubn+1o1Tubn/qOGIQ=;
        b=WpIAopN0Hb9CXQDrliZnqkD+jzNE8pBnM8lIMH5kkMt5PgP5gFQkMpQ91rajY3mO+Q
         unVQ6ZHjmwETUTltJ2T2KfAkvvD/1L1TXDNlKAUC8kImIYRqRq2xoWB7a/pMTGRq6vhT
         4VIz9FnhkgeFSG0+Pm/g9OWMUrlJoq5ZmRA7U2Odtble+D6x915C40q0H7HXpFgxJaII
         HON5yGYhzvSomcjHpMtaMyvjX2vAAfItwo7VcZw/kaT57C7I9WU+TMJpBfoclZfgqibu
         yH0SZmvS7knHy9bQN98ndMxGTeQnWH6otfT2DTmhhriB4s5pVbP5Ujmo6WEcxBozsLP/
         sewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705072832; x=1705677632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uoyz0fX05VFZUA0YqL9VDmTIjZubn+1o1Tubn/qOGIQ=;
        b=m3/NVusqORLqnIq/Lwwj+GjwXDZNuyj+3RcoO/dXxIn7RUUHvIFORoxcSpLN75nPPu
         FYM8r9QtWHtKWUN3LSZtsAcaHPIobiMXueyX7P6n6dPAYRUnNsBA6hhBNq5ODGYmUrMT
         hhHCguzXYigbZBCdK1L8cjgqeo7wDvgf3IRCOcrSZVSq1E6ETu9UZ1crAR2NerFXb6T0
         qVxZAf/2BiDJwQKROYejnbVqQpjZAhtIKkw+pA8ZegFUT0MTmw085uUfznyvqqnAcrkQ
         FMePiWXPAHrzzgdmDgfolXA2i98pXHoPR83DToHD1LLdY2ueQq4PI4+FK5c6zZoIxwhK
         pXgw==
X-Gm-Message-State: AOJu0Yw+f2va5eMw+kPUq9Lo3bcWygTzqhszOru9R/bORPZaomngC9LX
	C5JKINdFB7LpJt13+IFijxj3vIKkkw==
X-Google-Smtp-Source: AGHT+IHHZeFyMpKhH/9NZUPYGoPS59noDveXdZGapwC4YE9+IpLbuXeeZXS1ZGK3B7Qz/X6uuuEBfw==
X-Received: by 2002:a05:600c:3381:b0:40e:427d:4b02 with SMTP id o1-20020a05600c338100b0040e427d4b02mr960326wmp.67.1705072832187;
        Fri, 12 Jan 2024 07:20:32 -0800 (PST)
Received: from staff-net-cx-3510.intern.ethz.ch (2001-67c-10ec-5784-8000--16b.net6.ethz.ch. [2001:67c:10ec:5784:8000::16b])
        by smtp.gmail.com with ESMTPSA id o23-20020a05600c511700b0040e4c1b0c14sm10157728wms.34.2024.01.12.07.20.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 12 Jan 2024 07:20:31 -0800 (PST)
From: Hao Sun <sunhao.th@gmail.com>
To: bpf@vger.kernel.org
Cc: willemb@google.com,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	linux-kernel@vger.kernel.org,
	Hao Sun <sunhao.th@gmail.com>
Subject: [PATCH v3 1/2] bpf: Reject variable offset alu on PTR_TO_FLOW_KEYS
Date: Fri, 12 Jan 2024 16:20:10 +0100
Message-ID: <20240112152011.6264-1-sunhao.th@gmail.com>
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


