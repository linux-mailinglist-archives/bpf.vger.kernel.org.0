Return-Path: <bpf+bounces-11129-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FC97B3B37
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 22:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 4D3B1283005
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 20:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D137767276;
	Fri, 29 Sep 2023 20:24:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE85020F9
	for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 20:24:05 +0000 (UTC)
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA600136
	for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 13:24:03 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-49a319c9e17so4155083e0c.1
        for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 13:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696019043; x=1696623843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B6PCqiNutQ7Cqf0eyWPuayppp5jZuxmcxFu7IC/VLAU=;
        b=iDyOYQLgY3uw8/ZUPdn+TeGavcnWGwL6Vo6Yo2Ugtu6jedHCV6YuYimGIbHRW6Dijg
         KFslEwjpa21Fqv836c5eY7p2btZYuE/3IC+wYHfXOK0OUUfgarXNxiFaVsp+4KIbxPyw
         c4pQNFH8EcFfXfro7DIl3bDsNvY0BiUu7gfwvXUO4su0jwvAO63pqI6myEXw32IRNTSc
         oXP0DXCZeLlCkoZqX+6xFaP5adU02kbi4NmICtICjrddxjAl4ZlwnZd7PJ1vGbeTfO62
         VVycL712SiLGYawSNt6kVlLN2fTFeqkE0YYxjpl3QmpAMQR9IntXy1q3izUty1KiivFn
         URZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696019043; x=1696623843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B6PCqiNutQ7Cqf0eyWPuayppp5jZuxmcxFu7IC/VLAU=;
        b=tQsccIxDe0ieg8p56JED7ExIIpsRqPSBMw/+1xTMP5vpzUNIt/AmbY1XilcZLnQQxv
         0K6rCqhoU89UfCwf50IGvU5tgqN+qMOS0avUYOBkGbXSUitUBlH3hT5zaylrgCpTCCQO
         wqBmI2A0DM0TiolguAL9XPOGPRcV8Umi47bKrw+fOGygxIx+xx8OPONuwKi4kqj2i5Iq
         iHDnIk9ozk8kU59bOwCdppCg+RKJ77TNa6Ybfz3jTnMuvVLYmhJvIWZlOxi9mov6ePYV
         RH65ZU4XDPk4RdvyABiNA7x2aLXixwzaFcR8EWTo+hq1/1LH5tkLiaTjaUJFpVGFcv9h
         TgQQ==
X-Gm-Message-State: AOJu0Yw4WbloOt4Shv+R3uE9zn1m4qRIlHUqpl4H7Ubd+8jl7NveYPTO
	mQi2jTRSN6HFgHCpAgSCQR86HRFVGpWjnefHm/g=
X-Google-Smtp-Source: AGHT+IHYsN/RXo9Rch7azsPNXzHQyJ6X52Vjs9GkNTf4OkuWFoQPKpgP3433rpfbgay3/kHN2x11328wUkLpu85Dh1E=
X-Received: by 2002:a1f:49c5:0:b0:496:b3b7:5d4c with SMTP id
 w188-20020a1f49c5000000b00496b3b75d4cmr4093308vka.16.1696019042929; Fri, 29
 Sep 2023 13:24:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230908133923.2675053-1-houtao@huaweicloud.com>
 <20230908133923.2675053-4-houtao@huaweicloud.com> <97b0615e-a541-4856-ba70-be39bdcd8a8f@roeck-us.net>
 <CAJM55Z_76dsTxVEfaxif5H7Rdg_AQmjuscNuB2tLbZoVsWdgEQ@mail.gmail.com>
In-Reply-To: <CAJM55Z_76dsTxVEfaxif5H7Rdg_AQmjuscNuB2tLbZoVsWdgEQ@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Fri, 29 Sep 2023 21:23:36 +0100
Message-ID: <CA+V-a8u8EcFP_PmFB_KJ2t-x9Xn6EsFKeNR3AnfHse9OqApDkw@mail.gmail.com>
Subject: Re: [PATCH bpf 3/4] bpf: Ensure unit_size is matched with slab cache
 object size
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	houtao1@huawei.com, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 29, 2023 at 7:52=E2=80=AFPM Emil Renner Berthing
<emil.renner.berthing@canonical.com> wrote:
>
> Guenter Roeck wrote:
> > Hi,
> >
> > On Fri, Sep 08, 2023 at 09:39:22PM +0800, Hou Tao wrote:
> > > From: Hou Tao <houtao1@huawei.com>
> > >
> > > Add extra check in bpf_mem_alloc_init() to ensure the unit_size of
> > > bpf_mem_cache is matched with the object_size of underlying slab cach=
e.
> > > If these two sizes are unmatched, print a warning once and return
> > > -EINVAL in bpf_mem_alloc_init(), so the mismatch can be found early a=
nd
> > > the potential issue can be prevented.
> > >
> > > Suggested-by: Alexei Starovoitov <ast@kernel.org>
> > > Signed-off-by: Hou Tao <houtao1@huawei.com>
> >
> > With this patch in place, I see the following backtrace on riscv system=
s.
> >
> > [    2.953088] bpf_mem_cache[0]: unexpected object size 128, expect 96
> > [    2.953481] WARNING: CPU: 0 PID: 1 at kernel/bpf/memalloc.c:507 bpf_=
mem_alloc_init+0x326/0x32e
> > [    2.953645] Modules linked in:
> > [    2.953736] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.6.0-rc2-0024=
4-g27bbf45eae9c #1
> > [    2.953790] Hardware name: riscv-virtio,qemu (DT)
> > [    2.953855] epc : bpf_mem_alloc_init+0x326/0x32e
> > [    2.953891]  ra : bpf_mem_alloc_init+0x326/0x32e
> > [    2.953909] epc : ffffffff8016cbd2 ra : ffffffff8016cbd2 sp : ff2000=
000000bd20
> > [    2.953920]  gp : ffffffff81c39298 tp : ff60000002e80040 t0 : 000000=
0000000000
> > [    2.953930]  t1 : ffffffffbbbabbc3 t2 : 635f6d656d5f6670 s0 : ff2000=
000000bdc0
> > [    2.953940]  s1 : ffffffff8121c7da a0 : 0000000000000037 a1 : ffffff=
ff81a93048
> > [    2.953949]  a2 : 0000000000000010 a3 : 0000000000000001 a4 : 000000=
0000000000
> > [    2.953959]  a5 : 0000000000000000 a6 : ffffffff81c4fe08 a7 : 000000=
0000000000
> > [    2.953968]  s2 : 000000000000000b s3 : 0000000000000000 s4 : 000000=
0000000000
> > [    2.953977]  s5 : 0000000000000000 s6 : 0000000000000100 s7 : ff5fff=
fffffd3128
> > [    2.953986]  s8 : ffffffff81c3d1f8 s9 : 0000000000000060 s10: 000000=
0000000000
> > [    2.953996]  s11: 0000000000000060 t3 : 0000000065a61b33 t4 : 000000=
0000000009
> > [    2.954005]  t5 : ffffffffde180000 t6 : ff2000000000bb08
> > [    2.954014] status: 0000000200000120 badaddr: 0000000000000000 cause=
: 0000000000000003
> > [    2.954047] [<ffffffff8016cbd2>] bpf_mem_alloc_init+0x326/0x32e
> > [    2.954087] [<ffffffff80e11426>] bpf_global_ma_init+0x1c/0x30
> > [    2.954097] [<ffffffff8000285e>] do_one_initcall+0x5c/0x238
> > [    2.954105] [<ffffffff80e011ae>] kernel_init_freeable+0x29a/0x30e
> > [    2.954115] [<ffffffff80c0312c>] kernel_init+0x1e/0x112
> > [    2.954124] [<ffffffff80003d82>] ret_from_fork+0xa/0x1c
> >
> > Copying riscv maintainers and mailing list for feedback / comments.
>
> If it makes a difference I also see this with 6.6-rc3 on my Nezha board
> (Allwinner D1), but not on my VisionFive 2 (JH7110) running the same kern=
el.
>

Adding one more RISC-V board (Renesas RZ/Five) to list where I see this iss=
ue:
[    0.268936] ------------[ cut here ]------------
[    0.268953] bpf_mem_cache[0]: unexpected object size 128, expect 96
[    0.268993] WARNING: CPU: 0 PID: 1 at kernel/bpf/memalloc.c:507
bpf_mem_alloc_init+0x306/0x30e
[    0.269026] Modules linked in:
[    0.269038] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
6.6.0-rc3-00091-g6acfe6a7c746 #538
[    0.269049] Hardware name: Renesas SMARC EVK based on r9a07g043f01 (DT)
[    0.269054] epc : bpf_mem_alloc_init+0x306/0x30e
[    0.269066]  ra : bpf_mem_alloc_init+0x306/0x30e
[    0.269077] epc : ffffffff8010e7ac ra : ffffffff8010e7ac sp :
ffffffc80000bd30
[    0.269084]  gp : ffffffff81506d08 tp : ffffffd801938000 t0 :
ffffffff81419e40
[    0.269090]  t1 : ffffffffffffffff t2 : 2d2d2d2d2d2d2d2d s0 :
ffffffc80000bdd0
[    0.269096]  s1 : 000000000000000b a0 : 0000000000000037 a1 :
0000000200000020
[    0.269102]  a2 : 0000000000000000 a3 : 0000000000000001 a4 :
0000000000000000
[    0.269107]  a5 : 0000000000000000 a6 : 0000000000000000 a7 :
0000000000000000
[    0.269112]  s2 : 0000000000000000 s3 : 0000000000000000 s4 :
0000000000000100
[    0.269118]  s5 : ffffffff815081f8 s6 : ffffffff8153f610 s7 :
0000000000000060
[    0.269124]  s8 : 0000000000000060 s9 : ffffffd836fd2770 s10:
ffffffff80e18dd8
[    0.269130]  s11: 0000000000000000 t3 : ffffffff8151e174 t4 :
ffffffff8151e174
[    0.269135]  t5 : ffffffff8151e150 t6 : ffffffff8151e1b8
[    0.269140] status: 0000000200000120 badaddr: 0000000000000000
cause: 0000000000000003
[    0.269147] [<ffffffff8010e7ac>] bpf_mem_alloc_init+0x306/0x30e
[    0.269160] [<ffffffff80a0f3e4>] bpf_global_ma_init+0x1c/0x30
[    0.269174] [<ffffffff8000212c>] do_one_initcall+0x58/0x19c
[    0.269186] [<ffffffff80a00ffc>] kernel_init_freeable+0x200/0x26a
[    0.269203] [<ffffffff809195a4>] kernel_init+0x1e/0x10a
[    0.269213] [<ffffffff800035ee>] ret_from_fork+0xa/0x1c
[    0.269224] ---[ end trace 0000000000000000 ]---
[    0.281983] debug_vm_pgtable: [debug_vm_pgtable         ]:
Validating architecture page table helpers

Cheers,
Prabhakar

