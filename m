Return-Path: <bpf+bounces-11124-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8817B3A3C
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 20:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 2C7F01C209ED
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 18:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7665642C12;
	Fri, 29 Sep 2023 18:51:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EB2849C
	for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 18:51:21 +0000 (UTC)
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA10193
	for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 11:51:17 -0700 (PDT)
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CCFA142186
	for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 18:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1696013474;
	bh=i6pIYXxuKoLZ+wKC1n3MFhboCA1+8vK/nAjASg++5Yw=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=eDxAys+Ysink1BQLCTA/Nf+HeTCsgIiIvu11e2BMIMXHB/BRf2cPWWGyJ/JtxgTfw
	 DBZeFMUT+tdON7PHQ1z48Lj+2leOsM20blG0mgv1nOKweaSGLWr3unHyQn90hdBTv0
	 KkEqN9y1uC/yglpgkHWD7nhhcsbmC7Xcr6IMk1ZFUinSzPFYBu+o+fDJlUVzzcpaGc
	 XTSqoX1TKXicP0SYy16D+FS5efPXqw+YhCYiaupEXG4hSbv8g3KF1oUpVoaIsbfHw2
	 WNa3T+lhWCeZw56aAGBDO8zxf1nezO7n7Dx7yb5qLz/ZG1BYLY3Xll73D3ClBi1St2
	 sRU2Pbv/MRxiA==
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-41957273209so92706041cf.3
        for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 11:51:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696013474; x=1696618274;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i6pIYXxuKoLZ+wKC1n3MFhboCA1+8vK/nAjASg++5Yw=;
        b=h2JWgT/0bI5/l0Gb8TE8e8tCt89yrpZOvultwmn9RKAZO13M5b0YxwlTKlxgYW71wr
         KilwasI1DWD2peISBd5bhG+Xca45OiWUrjUuNf1k5aMxRztSru+Lw1YXUvK2JDVwthik
         O9bjSl2JLelGz3D+dEjN7CEFWztbOXWtYU7fIpnB5wjBibqnkbSjmstpWcnckOAEvI3d
         EY0TFpb5Ar36ubu3JXZbKGySkm7ANrS6MtieXAUn+x8UFUMy19T2I/sPuXn0+rGgZ2Lr
         PA4ymzARSwWwJmf+4GZUIrTIVEXNogF8XCDAizTLJaFFdSWONaz0YsO8VLOYqF1vWqi8
         jUbQ==
X-Gm-Message-State: AOJu0YzzJw1aGYoKHuN/ydLDw90x9F+GRIgQLuhytkr2tO+gYdiUewzW
	itqJu8Ko274wk/y4sJpbWdEkGlVsTPpG8P2KkviZ3S03Oy1PjNKAOMZYcCqQs69bu8w/uwiqk9+
	HKit+JrClnBdjbgeG7AinRX/vevqUVtpN5TYgIeKKeKPbnw==
X-Received: by 2002:a05:622a:193:b0:417:971e:ab08 with SMTP id s19-20020a05622a019300b00417971eab08mr5281351qtw.57.1696013473894;
        Fri, 29 Sep 2023 11:51:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvKVEyJ5PLAcavdqqhKap9vmb55dkolv53ptgINfcTEGaJceTTjqdkxUQ13eAhgBISBQy+/B6F3dtn9PqEEPk=
X-Received: by 2002:a05:622a:193:b0:417:971e:ab08 with SMTP id
 s19-20020a05622a019300b00417971eab08mr5281325qtw.57.1696013473650; Fri, 29
 Sep 2023 11:51:13 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 29 Sep 2023 11:51:13 -0700
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <97b0615e-a541-4856-ba70-be39bdcd8a8f@roeck-us.net>
References: <20230908133923.2675053-1-houtao@huaweicloud.com>
 <20230908133923.2675053-4-houtao@huaweicloud.com> <97b0615e-a541-4856-ba70-be39bdcd8a8f@roeck-us.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Fri, 29 Sep 2023 11:51:13 -0700
Message-ID: <CAJM55Z_76dsTxVEfaxif5H7Rdg_AQmjuscNuB2tLbZoVsWdgEQ@mail.gmail.com>
Subject: Re: [PATCH bpf 3/4] bpf: Ensure unit_size is matched with slab cache
 object size
To: Guenter Roeck <linux@roeck-us.net>, Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	houtao1@huawei.com, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Guenter Roeck wrote:
> Hi,
>
> On Fri, Sep 08, 2023 at 09:39:22PM +0800, Hou Tao wrote:
> > From: Hou Tao <houtao1@huawei.com>
> >
> > Add extra check in bpf_mem_alloc_init() to ensure the unit_size of
> > bpf_mem_cache is matched with the object_size of underlying slab cache.
> > If these two sizes are unmatched, print a warning once and return
> > -EINVAL in bpf_mem_alloc_init(), so the mismatch can be found early and
> > the potential issue can be prevented.
> >
> > Suggested-by: Alexei Starovoitov <ast@kernel.org>
> > Signed-off-by: Hou Tao <houtao1@huawei.com>
>
> With this patch in place, I see the following backtrace on riscv systems.
>
> [    2.953088] bpf_mem_cache[0]: unexpected object size 128, expect 96
> [    2.953481] WARNING: CPU: 0 PID: 1 at kernel/bpf/memalloc.c:507 bpf_mem_alloc_init+0x326/0x32e
> [    2.953645] Modules linked in:
> [    2.953736] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.6.0-rc2-00244-g27bbf45eae9c #1
> [    2.953790] Hardware name: riscv-virtio,qemu (DT)
> [    2.953855] epc : bpf_mem_alloc_init+0x326/0x32e
> [    2.953891]  ra : bpf_mem_alloc_init+0x326/0x32e
> [    2.953909] epc : ffffffff8016cbd2 ra : ffffffff8016cbd2 sp : ff2000000000bd20
> [    2.953920]  gp : ffffffff81c39298 tp : ff60000002e80040 t0 : 0000000000000000
> [    2.953930]  t1 : ffffffffbbbabbc3 t2 : 635f6d656d5f6670 s0 : ff2000000000bdc0
> [    2.953940]  s1 : ffffffff8121c7da a0 : 0000000000000037 a1 : ffffffff81a93048
> [    2.953949]  a2 : 0000000000000010 a3 : 0000000000000001 a4 : 0000000000000000
> [    2.953959]  a5 : 0000000000000000 a6 : ffffffff81c4fe08 a7 : 0000000000000000
> [    2.953968]  s2 : 000000000000000b s3 : 0000000000000000 s4 : 0000000000000000
> [    2.953977]  s5 : 0000000000000000 s6 : 0000000000000100 s7 : ff5ffffffffd3128
> [    2.953986]  s8 : ffffffff81c3d1f8 s9 : 0000000000000060 s10: 0000000000000000
> [    2.953996]  s11: 0000000000000060 t3 : 0000000065a61b33 t4 : 0000000000000009
> [    2.954005]  t5 : ffffffffde180000 t6 : ff2000000000bb08
> [    2.954014] status: 0000000200000120 badaddr: 0000000000000000 cause: 0000000000000003
> [    2.954047] [<ffffffff8016cbd2>] bpf_mem_alloc_init+0x326/0x32e
> [    2.954087] [<ffffffff80e11426>] bpf_global_ma_init+0x1c/0x30
> [    2.954097] [<ffffffff8000285e>] do_one_initcall+0x5c/0x238
> [    2.954105] [<ffffffff80e011ae>] kernel_init_freeable+0x29a/0x30e
> [    2.954115] [<ffffffff80c0312c>] kernel_init+0x1e/0x112
> [    2.954124] [<ffffffff80003d82>] ret_from_fork+0xa/0x1c
>
> Copying riscv maintainers and mailing list for feedback / comments.

If it makes a difference I also see this with 6.6-rc3 on my Nezha board
(Allwinner D1), but not on my VisionFive 2 (JH7110) running the same kernel.

/Emil

