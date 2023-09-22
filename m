Return-Path: <bpf+bounces-10654-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8B17AB97C
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 20:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 9D4901F23569
	for <lists+bpf@lfdr.de>; Fri, 22 Sep 2023 18:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F3643A80;
	Fri, 22 Sep 2023 18:43:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9F81E501
	for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 18:43:36 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C428A9
	for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 11:43:35 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c5bf7871dcso22530785ad.1
        for <bpf@vger.kernel.org>; Fri, 22 Sep 2023 11:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695408215; x=1696013015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mGwEs4lwD/Q6PpJtqh3vxLJbwSG8QN19oMXykCTRdOU=;
        b=ngc99EL4d/5XkjnkK3Gt2GZ2siloVss1Yjx+ZYPFQGcyQQa/mtWMPz4nkEjDOJCbYW
         /bxLD2PoXuOF7I23oMoBUAG7K0W4iKuFbbV5BQ9I1lTY2MXx+S/Bbj0Vof3chu7FTWbt
         WlIeDWAT/k2CLMvdgI+DAX7fB5ufaW7YMkVW4DJCU9j6MzSqFe516CsX8N33ANJoJtTz
         jIGHYDCLe9u9aO4BRCMx3Oc6rRmugPSRJBUhE8XAx6uSMk7/FLwZ8AXUa2YDucSmnHXu
         2AzV2+DCXZicEI2/fpB44e98wXlPaPQ4WoLslGWqszbj5i9KIH0VukKhH8THF6086tKV
         7TIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695408215; x=1696013015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mGwEs4lwD/Q6PpJtqh3vxLJbwSG8QN19oMXykCTRdOU=;
        b=IPqj9+nSA0DzePRSPO3rTk2Il9CvG9yrl+/rzxOxF3nimup5bpvEiI0EKUtM9onsPo
         HtBXFLL1rj0iskSZnpBaUWG3n96BfTuRIA9qtAkeuxMKsD9IMQ/qGUgvJl3GuVV5f6X0
         GyL3sSSnDgCDf43XknGCOFUT1XCWy2GXUFuIttbNyaHBZHAoaHO/Zwn9K/3z+hFG6LJ/
         NDAvgmPNZ0cDD7RN7QOcslX8k0MhpRP5YRSrmCw9AuTgxIQ2Avxo3+eYBT8udgtrsegT
         rNrbj19XZeXzwHqFaualW8ywpEC3NTqoNk2Eg+RY3lR1VmliHuJpMU3TKs1edslLlDnQ
         xKoQ==
X-Gm-Message-State: AOJu0Yyyhd/+v3gl5wts5cp556ormigpLN4J3eQfDCBRqMa3xw05V1dm
	o7YvPMduO0n01aZY8l2Gvac1V7lvaTk=
X-Google-Smtp-Source: AGHT+IGfnwzfn6fy1YyhVOl95t1Ws+pb3Tna3+/4OEDy7OO3vLRjz0evZlUYL3YRd7eQLtVtwWYQTw==
X-Received: by 2002:a17:902:e74f:b0:1c4:e69:42c3 with SMTP id p15-20020a170902e74f00b001c40e6942c3mr372887plf.43.1695408214726;
        Fri, 22 Sep 2023 11:43:34 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c20-20020a170902c1d400b001b03a1a3151sm3842793plc.70.2023.09.22.11.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 11:43:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 22 Sep 2023 11:43:32 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	houtao1@huawei.com, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org
Subject: Re: [PATCH bpf 3/4] bpf: Ensure unit_size is matched with slab cache
 object size
Message-ID: <97b0615e-a541-4856-ba70-be39bdcd8a8f@roeck-us.net>
References: <20230908133923.2675053-1-houtao@huaweicloud.com>
 <20230908133923.2675053-4-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908133923.2675053-4-houtao@huaweicloud.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On Fri, Sep 08, 2023 at 09:39:22PM +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Add extra check in bpf_mem_alloc_init() to ensure the unit_size of
> bpf_mem_cache is matched with the object_size of underlying slab cache.
> If these two sizes are unmatched, print a warning once and return
> -EINVAL in bpf_mem_alloc_init(), so the mismatch can be found early and
> the potential issue can be prevented.
> 
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Hou Tao <houtao1@huawei.com>

With this patch in place, I see the following backtrace on riscv systems.

[    2.953088] bpf_mem_cache[0]: unexpected object size 128, expect 96
[    2.953481] WARNING: CPU: 0 PID: 1 at kernel/bpf/memalloc.c:507 bpf_mem_alloc_init+0x326/0x32e
[    2.953645] Modules linked in:
[    2.953736] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.6.0-rc2-00244-g27bbf45eae9c #1
[    2.953790] Hardware name: riscv-virtio,qemu (DT)
[    2.953855] epc : bpf_mem_alloc_init+0x326/0x32e
[    2.953891]  ra : bpf_mem_alloc_init+0x326/0x32e
[    2.953909] epc : ffffffff8016cbd2 ra : ffffffff8016cbd2 sp : ff2000000000bd20
[    2.953920]  gp : ffffffff81c39298 tp : ff60000002e80040 t0 : 0000000000000000
[    2.953930]  t1 : ffffffffbbbabbc3 t2 : 635f6d656d5f6670 s0 : ff2000000000bdc0
[    2.953940]  s1 : ffffffff8121c7da a0 : 0000000000000037 a1 : ffffffff81a93048
[    2.953949]  a2 : 0000000000000010 a3 : 0000000000000001 a4 : 0000000000000000
[    2.953959]  a5 : 0000000000000000 a6 : ffffffff81c4fe08 a7 : 0000000000000000
[    2.953968]  s2 : 000000000000000b s3 : 0000000000000000 s4 : 0000000000000000
[    2.953977]  s5 : 0000000000000000 s6 : 0000000000000100 s7 : ff5ffffffffd3128
[    2.953986]  s8 : ffffffff81c3d1f8 s9 : 0000000000000060 s10: 0000000000000000
[    2.953996]  s11: 0000000000000060 t3 : 0000000065a61b33 t4 : 0000000000000009
[    2.954005]  t5 : ffffffffde180000 t6 : ff2000000000bb08
[    2.954014] status: 0000000200000120 badaddr: 0000000000000000 cause: 0000000000000003
[    2.954047] [<ffffffff8016cbd2>] bpf_mem_alloc_init+0x326/0x32e
[    2.954087] [<ffffffff80e11426>] bpf_global_ma_init+0x1c/0x30
[    2.954097] [<ffffffff8000285e>] do_one_initcall+0x5c/0x238
[    2.954105] [<ffffffff80e011ae>] kernel_init_freeable+0x29a/0x30e
[    2.954115] [<ffffffff80c0312c>] kernel_init+0x1e/0x112
[    2.954124] [<ffffffff80003d82>] ret_from_fork+0xa/0x1c

Copying riscv maintainers and mailing list for feedback / comments.

Thanks,
Guenter

