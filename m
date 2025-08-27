Return-Path: <bpf+bounces-66649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 098D7B380BA
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 13:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 916531B26520
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 11:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F93D34DCE3;
	Wed, 27 Aug 2025 11:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nI3m2nx+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C432F49F7
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 11:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756293593; cv=none; b=cz00d7nf7nXpi1twsEmCJbYF8Dq68CwYa48UGhs5OH2fcxktaKjQYRn2mKxEvsLXTLt86nVwDti1vDMJcKv1SPckhZUybmLWtJthVlYk8gRmhDGbJPF2NfZtimnZXapyjHYatDKCM0/6aWe/fjgyI7JUb3tdwr+7UdAGy5lq2C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756293593; c=relaxed/simple;
	bh=yHSDgi1Qf9GLhybcnjVhZnbU0unpf2VgIN/ZDmjE2EE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HA5bpNxHLRSBnsXVYWlVLnpQOsdLvCr/wH2MSQBbI+Hi+33uGJziIlJ3KoEon8Cse0Sm8Gaygm/d+i0xOOLT+5xn+gMkdRUcguo3uJy3LuPulnnWFJpx7ScSiVxr+u6tbqRWSpcsXZtEIlY0acgoh2i2uN7Le0fdZryRhasbSoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nI3m2nx+; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-321cfa7ad29so615572a91.1
        for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 04:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756293592; x=1756898392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WV5B7+M1QeZLHSg/ECAdc/Y6fwTVPknY3WPmdEU6CxY=;
        b=nI3m2nx+DhE57mVNu9M6QnArh6Hv05sRUw7UInxDec2rMzyBlUqCeG6LoOL6X9Hg8b
         FCkGoekQ22FxBjj+64yKFw87julBocZHr0VqK8R3y34FU1qij4751PqiGpjhwmKw6UW7
         9mWRV0xmU/FvYJmugt9gn+LGpr/+SYonsAA01KJAZhSA8RYMSapCqL/9+AfJvkdveIpZ
         caos4w87nB4p3y0wfaI+jvSNRr4Ko0U/CUViUdudwkEMNstBIBgholNEvHZjJJB6wYxa
         LaujkLXwOdNpiNva8/SrPxDMFkhqxHPQhw4FfWkuc7RVK8CwSL5PtrtSU72O5zQH/YdY
         lX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756293592; x=1756898392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WV5B7+M1QeZLHSg/ECAdc/Y6fwTVPknY3WPmdEU6CxY=;
        b=HkMCI6Gf/LWFHlZZLnwteSoTqmnM6PCRVHEn7yF8bw3CwYMmMJvFbhbjQ1CGavyN8Z
         qUZqs64vBkZJAjnU9aW/luhIVYnJgtrELcmsZG6jmzjQgUUGbHDWpKkNHqXGUITjbipk
         Gmjf5p1wDoLTqcl5gapwbu8t1ZRJScybxDO5VE9BWEr1TfHwTwZJeWKQPfUiZNPA384W
         ujyWmNWj7ffAiQpIF0JzdUc2n8M38BWFv1e/CnZ7FRE8S8L6b65KhU1IvZwFedwgDW+n
         fTcI+PPX86D20GNUDrPyxfDbMZS3FCMOQh0XU3psXJ64VEz2ZbHKvufliCPG8RxE+1JC
         uYAw==
X-Gm-Message-State: AOJu0Yzro536urB8h5dzhSrInjsAkGSZNTH/w6UF0He2PqupLAp2WVtE
	r4mM7YUfeolmVSE+dWI53ZnQFmKuRZNOygE4XLtibhR27HILJrrUBgX5
X-Gm-Gg: ASbGncs0kXxST5xfubUsJRkzT4G1d/N8hzdOP1sSmsrk7K6gRyvy1FD6XwSxfBthfD8
	M7joUJC/PIjLK1L/B3wdUm1rJpxsIA1IXdr2SxlzviJEJ7nHqI/y85+zLGxr4/ut2G5QIbBBXrS
	UA0taxKAf4nffIUn2NzcUH/+YWhvHaI4xpxospQEf5+IV/uUEQXZS8aN61JlebicpWhY2i6Tai2
	yCSW7fG/VyLI3jAj9tgD8AmvE8oYsUQk5n8KIB5+G+YcgkuyfhiXErLn2Svx7jDzE+FyOb0pNec
	x5/Pg5H4ajKxBaRbCifDfxjVUozK0CojDFESD9W/YuHh0CrrYYCwQJdLYnKrdUTTcJlN7qP2Bv/
	fRQtz3rrDucMil1Ml5CuKQRE0+o6rArN67+mipMJP
X-Google-Smtp-Source: AGHT+IGfxF9cJ3Lkj2hZ2O+9EnfpctZUJ6j5jfuIKVnEwz51XZgAfdOFoqHud7kKXEwN2KBfHWMkPw==
X-Received: by 2002:a17:90b:5350:b0:315:9624:37db with SMTP id 98e67ed59e1d1-3275085eab1mr5869532a91.3.1756293591401;
        Wed, 27 Aug 2025 04:19:51 -0700 (PDT)
Received: from devbox.. ([43.132.141.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276f8a3335sm1829729a91.13.2025.08.27.04.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 04:19:51 -0700 (PDT)
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
Subject: [PATCH v2 3/3] LoongArch: BPF: No support of struct argument in trampoline programs
Date: Wed, 27 Aug 2025 09:47:33 +0000
Message-ID: <20250827094733.426839-4-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827094733.426839-1-hengqi.chen@gmail.com>
References: <20250827094733.426839-1-hengqi.chen@gmail.com>
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
Acked-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Tested-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Tested-by: Vincent Li <vincent.mc.li@gmail.com>
Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 arch/loongarch/net/bpf_jit.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index c239e5ed0c92..66b102ed9874 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1514,6 +1514,12 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
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



