Return-Path: <bpf+bounces-66196-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA32FB2F7AC
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 14:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C6BC3AC760
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 12:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA2A1E9B08;
	Thu, 21 Aug 2025 12:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5aAZW9x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052C81EDA0B
	for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 12:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755778622; cv=none; b=KvfPPbUu2GCPIyXYw9BT5wOA7GqhSAeWiiyNpfdbUuns/lCpTeiu/nhrqbmntVkJOgRBugkYKvzTWLKTm0d33+sSYJcl7Xidmv3AZvZpicTe04cvHMYrVBfQ3WrpRuhKOtf750UMZQSuK3Le9DQ0O/UQbsdMf8Ya5M2JIwoV3OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755778622; c=relaxed/simple;
	bh=YrjoTJI6JBY5AbzUyt1qMwTNNmqXTVMk5uzwMU1ycus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g5zt52V/mnQvwvErcmrXY/shtYlVV2QUHHzhuGYtFHgr6Vg628l3lfQD0Yo9UY/xn9G+O2KPRiJ/xeRCPDefzNnsENxEf9OPYyZw+XrI1pJeFeW68ODj5ebUCxxN+LcyE7B7CqrtPB5zSYb0SmZSQHG2jMXjgzV4AirssIePpCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5aAZW9x; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-32326bd4f4dso766925a91.1
        for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 05:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755778620; x=1756383420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqamakcfwHFPLKt58TYCPYhTXg3ZUi1tEP08t5AyrIw=;
        b=M5aAZW9xR+ZjduY3GwD8tpcygpML64TreRG2risOWmFUaj9ArnaSDf2g29OGEB5h2H
         pNKKMly7Eitk1whpT38SAvxJmW6Lr8UDj9RnsrXMw1J9B+14hmXUX5hm1Hd8npcdw9wS
         gQOXEYWbD2xQWR8i/NmhRM5xBIifYN/XMkgAdmeQkexJwvMroCGf+h23u1TeeinwKGwI
         /Uxgl8cyMH12dnzj+x8GnVkYhcsMg8vtHPFghRhsraRArDnDnT+W4iM3v++uGTllk+zr
         DayD4tq0iL0lOYXV/6/0qnuuoCrkSJdEc8E1s0+w/DZ6y8W/UbqxcCiwT6j8kFLdyg7f
         df6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755778620; x=1756383420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OqamakcfwHFPLKt58TYCPYhTXg3ZUi1tEP08t5AyrIw=;
        b=gyif3fIUmNzLFFY+xyNtlg1pSdSMn2FjKunJcPXOaPS5bvGFY7IV8dMEZtoTGAbHzv
         ei8igDjNYZFOK1N+94w6MSKuyFvHbJeeNYC89GaD7iPXzuTEhENnp5nh1CWbmriNsYNS
         fyyRAQgurp/JSFN9+shMPeqCl4FfGv0wxmsF22VJ0apE35aHTEEenEdkIok0cVejJmB3
         1ZPZnNKG/DaoLAIGcjtCTWKkSSThNGLVCWVCHiMd52SVSkdMFZuLBvi8gHCM5tRSdbGm
         OvGsf29g2xoy4JdnHK7UagrcnDDmuyVfG8rqbYVLz2kfcfXEMZUY8VyDD3DwLYRU3Vha
         JgIw==
X-Gm-Message-State: AOJu0Ywnb+i6zSLKdx8soNTe1ZyG8ZPgoA0/Lq+RfmnjoNEtbFORkqc6
	KZUj4Bc0z7Y3uBdbq7fqFu2uH4eRGPaaGf6fWlL7eOELlxLB2TFbGZxL
X-Gm-Gg: ASbGncvubf/ZlB85RSsQPhvvBjHupxM75gpvqhJCwkuMzRezVDQXxUCey+jt8XplPM1
	a0SVpT5+ubqVwIg/JG9c269EpJm6ejoWPjecmvGSZjwccVnKYcXGV2dbyCl/kNp9sG4xaUR3GW2
	KOY8lqP7rhbtMexUxhgRMmkxCQsYS94WO4NIfKtcbOviyG5DTGTKV/fMHzcSl6fPYYnNhShwtud
	RaLXT7C74PelAfs6/nNQtz0qi/UY45CnRZS+rhybDvbWU5GIHj2oWn1hF+Xz7Tvw+Zo4YlUbW4W
	eIC4aY7/KhRlv4A5HR4gAA05fSRpu59iCT8fbiutaCXIntqBGD9Z/G91Hc1HaL+lh20i0Y4fdb9
	Lyu/gJET1PFVhqc7WMNLL55rTJUU2GjhIJj5QoioG
X-Google-Smtp-Source: AGHT+IFioRcTnWkaN7vAuc6OYhbDDtjv9XBvPVRvGl/yn3M6ZYsZBYGGu9dMLWHG+nZcFAestbB/xQ==
X-Received: by 2002:a17:90b:3d09:b0:31e:f30f:6d3b with SMTP id 98e67ed59e1d1-324eecf9b08mr2759366a91.2.1755778620068;
        Thu, 21 Aug 2025 05:17:00 -0700 (PDT)
Received: from devbox.. ([43.132.141.28])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324f2c48337sm1745442a91.25.2025.08.21.05.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 05:16:59 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: chenhuacai@kernel.org,
	yangtiezhu@loongson.cn,
	jianghaoran@kylinos.cn,
	duanchenghao@kylinos.cn,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	vincent.mc.li@gmail.com
Cc: bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH 3/3] LoongArch: BPF: No support of struct argument in trampoline programs
Date: Thu, 21 Aug 2025 09:10:03 +0000
Message-ID: <20250821091003.404870-4-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250821091003.404870-1-hengqi.chen@gmail.com>
References: <20250821091003.404870-1-hengqi.chen@gmail.com>
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
index 6754e5231ece..a87f51f5b708 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1516,6 +1516,12 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
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



