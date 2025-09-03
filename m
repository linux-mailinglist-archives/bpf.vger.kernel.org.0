Return-Path: <bpf+bounces-67281-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCF7B41E6B
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 14:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4DB97B96A9
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 12:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C533D987;
	Wed,  3 Sep 2025 12:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwPpWMaO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B321D2E427B
	for <bpf@vger.kernel.org>; Wed,  3 Sep 2025 12:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756901159; cv=none; b=pXlSvHNXZktOwAua0DquLsA1zxmFsq4GCQXJeioGFlYef/TKFhud2da5l7/2wtqYlSTx5IrFKe5VAxy2q40TtzdURgwkKLOM0nj5X0CHgQ9GxVEDUAqIg/x6mN31+8NgsnNdIZLJOLDfubkmHC+K9bKKMNQBIv7quRvXFrGL5dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756901159; c=relaxed/simple;
	bh=pvouYI3vmBVJiEH/fEoesdl+fmluw7ycvjYdCkdAWU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sJ37e8UDch+QVHXN1sujEwNpbuIYQnE4JbREBPzZhGNkwJjZ5mZ4HyVCEL5SpHZS5cK87gGRmpt0SrRZ/5lAY6kFk1+qSLWBZNTxf/HVdOk8e+Z18Fb/GbFv+HUWLBmOL3TxQ4y9Ft2nXtd6M/a4RODM/En54zYsFamfQoHgKeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwPpWMaO; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-77246079bc9so4264351b3a.3
        for <bpf@vger.kernel.org>; Wed, 03 Sep 2025 05:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756901157; x=1757505957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgWOdWZRtCDBRYSS9p3LugAEelK+NK48uslwvOCyM38=;
        b=AwPpWMaOH5eWt5k25nIuSkd1i8NA9nIM/Jwtm8Yvp8+1dp13pIv1Ny8CKJDkdkNLYt
         Ux50rZZJ6MK12JMSYlBQc7FxQDO6yvx618ri2PWIA5WTUZyXdMENtCtL9/NS0IT3SPEH
         dVUS9FZZLcNHMz7Yy6x3v2MsUNgz0omVqJRTbn7TMSDb36s6Ve1JITTTxTm2em1KGScU
         lfAYNT6SRorUBhpMomCoDQ3yMCw/HFurcTaiUVtyDzdbd2yXQmyj9uVPLgxt0v66DWgz
         DXUJyeF/uguE5YHDsHhw1D/CxYUVO4OZ7S/YZg+A6LZWuIr8lv61wy6Lm/4CD/MP6FSw
         QStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756901157; x=1757505957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XgWOdWZRtCDBRYSS9p3LugAEelK+NK48uslwvOCyM38=;
        b=oF5/+xraLAWBmgaAeyRvCDmH7vTf/A9HUQKy9Gm6ftMHOYmz5jf/tNOMj9La9qWnDw
         hu4wcPiDsBUTV4h6IenEt17CqPKbdxj5It/F5mIoEeHuw2qPOICVLNhKBPdaIxM1qbaA
         88E7g7yCRK990l7JqS5uo6Tic0Iq4+FdebppQmv9adyyyj0c/LT32ShPhKyOHin1Ixlk
         Uid/tAcKWfPiXwIp4Z9wBcJ4AXHOeBx50mbWvs3YYomCROT8/Lh8sA/Pxyx4o27fRiHX
         zHO0Y6it9tu0tefWewvimiL3Pib3Z8cmScepLttnzQnQ4aIKKH9I5LPwAfa0efk7YXi5
         XaLA==
X-Forwarded-Encrypted: i=1; AJvYcCVmBOUo1JPscc1RBVh8mqsM4mO677ImHEZmx5tcSUI/QY0ik8t1cjj948p8v5j+DTyhyKg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa4uZ9/w43oVd6Q0bD2vopX02E5RGWrtp1UMH0KSyXGZgwEuZu
	QNyTfs8n7vyE9imRC3YokQIAqHOXd62+Zs355usZ+n8oui0bNETbF/bl
X-Gm-Gg: ASbGncsVxorvj7tC2glRKmhT7LPLojszsaX6RJ1wUTrp3J5F9iaMAdb+Mt/pXEKxAwu
	y9Qq3/cfaS0jv2bsu/cDfOU1Hd52yZPGw3K8r3aLXFN4Ns7c8SqBKuP/IE/FtlL/NZJjYBBAu+U
	zlT+0+za8IW+MEnRlJg+94/QYLMBOYKUrncClx75nyQY0rsERgbLIc4704sOgWBuDWLJXl/FUNt
	/sLe/Itq1p8ZeYqYaI1lwzoHP2pSKxdnsYHOsWnB1TFUHEdGw5sQ54NwehV2KyVv5XozrNDi3Cu
	lTRntypy0HuoFsDIjq+mINC7/TXiixvK+mrRoPAWmlyPq6HXNaXhkKIGvr4Y7P3xkMNNXtBEaqK
	BKrPlKJj5aEbDPtqrRg9ekkjFYDWWvaHgJhuGpm4f
X-Google-Smtp-Source: AGHT+IGXMQgIfSvZFnKEiRNmakR/wRDr7ldLgxMm4Dr58aazA38CdfMUR7OM+rxqXKBB0ERFrqOtPg==
X-Received: by 2002:a05:6a00:1495:b0:770:56bf:ab5a with SMTP id d2e1a72fcca58-7723e36b526mr16296049b3a.19.1756901156919;
        Wed, 03 Sep 2025 05:05:56 -0700 (PDT)
Received: from devbox.. ([43.132.141.28])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a5014desm16615899b3a.92.2025.09.03.05.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 05:05:56 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: chenhuacai@kernel.org,
	yangtiezhu@loongson.cn,
	vincent.mc.li@gmail.com,
	hejinyang@loongson.cn
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH v4 3/8] LoongArch: BPF: No support of struct argument in trampoline programs
Date: Wed,  3 Sep 2025 07:01:08 +0000
Message-ID: <20250903070113.42215-4-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250903070113.42215-1-hengqi.chen@gmail.com>
References: <20250903070113.42215-1-hengqi.chen@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation does not support struct argument.
This cause a oops when running bpf selftest:

    $ ./test_progs -a tracing_struct
    CPU -1 Unable to handle kernel paging request at virtual address 0000000000000018, era == 90000000845659f4, ra == 90000000845659e8
    Oops[#1]:
    CPU -1 Unable to handle kernel paging request at virtual address 0000000000000018, era == 9000000085bef268, ra == 90000000844f3938
    rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
    rcu:     1-...0: (19 ticks this GP) idle=1094/1/0x4000000000000000 softirq=1380/1382 fqs=801
    rcu:     (detected by 0, t=5252 jiffies, g=1197, q=52 ncpus=4)
    Sending NMI from CPU 0 to CPUs 1:
    rcu: rcu_preempt kthread starved for 2495 jiffies! g1197 f0x0 RCU_GP_DOING_FQS(6) ->state=0x0 ->cpu=2
    rcu:     Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
    rcu: RCU grace-period kthread stack dump:
    task:rcu_preempt     state:I stack:0     pid:15    tgid:15    ppid:2      task_flags:0x208040 flags:0x00000800
    Stack : 9000000100423e80 0000000000000402 0000000000000010 90000001003b0680
            9000000085d88000 0000000000000000 0000000000000040 9000000087159350
            9000000085c2b9b0 0000000000000001 900000008704a000 0000000000000005
            00000000ffff355b 00000000ffff355b 0000000000000000 0000000000000004
            9000000085d90510 0000000000000000 0000000000000002 7b5d998f8281e86e
            00000000ffff355c 7b5d998f8281e86e 000000000000003f 9000000087159350
            900000008715bf98 0000000000000005 9000000087036000 900000008704a000
            9000000100407c98 90000001003aff80 900000008715c4c0 9000000085c2b9b0
            00000000ffff355b 9000000085c33d3c 00000000000000b4 0000000000000000
            9000000007002150 00000000ffff355b 9000000084615480 0000000007000002
            ...
    Call Trace:
    [<9000000085c2a868>] __schedule+0x410/0x1520
    [<9000000085c2b9ac>] schedule+0x34/0x190
    [<9000000085c33d38>] schedule_timeout+0x98/0x140
    [<90000000845e9120>] rcu_gp_fqs_loop+0x5f8/0x868
    [<90000000845ed538>] rcu_gp_kthread+0x260/0x2e0
    [<900000008454e8a4>] kthread+0x144/0x238
    [<9000000085c26b60>] ret_from_kernel_thread+0x28/0xc8
    [<90000000844f20e4>] ret_from_kernel_thread_asm+0xc/0x88

    rcu: Stack dump where RCU GP kthread last ran:
    Sending NMI from CPU 0 to CPUs 2:
    NMI backtrace for cpu 2 skipped: idling at idle_exit+0x0/0x4

Reject it for now.

Fixes: f9b6b41f0cf3 ("LoongArch: BPF: Add basic bpf trampoline support")
Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 arch/loongarch/net/bpf_jit.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 9155f9e725a1..7b7e449b9ea9 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1492,6 +1492,12 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	if (m->nr_args > LOONGARCH_MAX_REG_ARGS)
 		return -ENOTSUPP;
 
+	/* don't support struct argument */
+	for (i = 0; i < m->nr_args; i++) {
+		if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG)
+			return -ENOTSUPP;
+	}
+
 	if (flags & (BPF_TRAMP_F_ORIG_STACK | BPF_TRAMP_F_SHARE_IPMODIFY))
 		return -ENOTSUPP;
 
-- 
2.43.5


