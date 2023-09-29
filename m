Return-Path: <bpf+bounces-11136-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 378E17B3BB1
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 23:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E732B282056
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 21:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AE366DEC;
	Fri, 29 Sep 2023 21:01:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8DF8F4A
	for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 21:01:01 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2AE1A7
	for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 14:00:59 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-32615eaa312so713284f8f.2
        for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 14:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696021257; x=1696626057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=187HD4gBn36XDqZJcZdh6OqPHZPxl2IR6ZKEs5lHtAU=;
        b=dkQUsDKGs6L17EJovzqwdAlnDjlr4oO8ss5q3YxWs27xwfdMKGRaQBbtH7YShVlPJr
         ovYzGyrwigr8mnhZzH9/UzVbcBOB7bbsWwxrjyIcaqaaCjOj+VfhzYq8HIPCVzq5GpZL
         rRI1ADuE1i4GglmFZpnBzjtXH9v9anqDUDiEqF6aNgFVXhtHZEO8eR1M94pSu6XFeBGP
         XFEzY6ByOxiOVGz+QoQgwNtUQhsqoMqVlemuvrovYZa9n3l9DbRDysg9mU2RcBL3YdB1
         6saVeOMH40BZZGHMV/XzpKTdsGELP/Hv2Gfj+oCKMMe10wRnzb3wFHVlyyMbxfEEP72h
         qBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696021257; x=1696626057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=187HD4gBn36XDqZJcZdh6OqPHZPxl2IR6ZKEs5lHtAU=;
        b=ji9yBsKv45yDlLHZs4/0Bposgrn3mXWPsK2+JW0NHPBynra+SpIH3KzgSe9FgCaOeL
         fmzQxsPsGWl7QwKtSOnHXPTcgGZ6GJJ04AxxxF5nkv/PM6FBiWG7aG+kr/0tESqh9XPg
         Bl0BTTV22pjZ3Eigw3bZF2GC3IivTRExA52Wql/J4Nw8wRHG7OZdSJVjdKwtCaPQ2TI4
         HoBmP1B0b5oIZWoUT1LAzgDbXOFM8UguSWB7g7Ov8AbYV9CIJ1IpAn+f1Hk53ynG6T6s
         IsE/eV2G/z2bZcLF+kiMg8VSAwH4YnPvGZQgHcCI285Wpt9EQNzIkVji/1mufl7vsBP3
         ATMQ==
X-Gm-Message-State: AOJu0YzQTvEesArRHcSzMfeDpVLyGG9Fj1pbvX7maFZp/sPke+MG9DXy
	TnFqsUAMYy4V0kekieR4GSoUORKVnaYnXAiameE=
X-Google-Smtp-Source: AGHT+IEn5b33M5VNWmFOfShYcwTQtHJHZl8Azr+27+en/odENn1umR5EQxSbtqCOR/mg0cTW/5by6jAa30JiFNep9AE=
X-Received: by 2002:adf:d0c1:0:b0:320:28e:b638 with SMTP id
 z1-20020adfd0c1000000b00320028eb638mr4758101wrh.36.1696021257331; Fri, 29 Sep
 2023 14:00:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230908133923.2675053-1-houtao@huaweicloud.com>
 <20230908133923.2675053-4-houtao@huaweicloud.com> <97b0615e-a541-4856-ba70-be39bdcd8a8f@roeck-us.net>
 <CAJM55Z_76dsTxVEfaxif5H7Rdg_AQmjuscNuB2tLbZoVsWdgEQ@mail.gmail.com> <CA+V-a8u8EcFP_PmFB_KJ2t-x9Xn6EsFKeNR3AnfHse9OqApDkw@mail.gmail.com>
In-Reply-To: <CA+V-a8u8EcFP_PmFB_KJ2t-x9Xn6EsFKeNR3AnfHse9OqApDkw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 29 Sep 2023 14:00:45 -0700
Message-ID: <CAADnVQ+wyrfc0HDFZNh8KB=L8Hd-gNTCjzr=WhQbaGjVt7TKJQ@mail.gmail.com>
Subject: Re: [PATCH bpf 3/4] bpf: Ensure unit_size is matched with slab cache
 object size
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>, Guenter Roeck <linux@roeck-us.net>, 
	Hou Tao <houtao@huaweicloud.com>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, 
	Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Hou Tao <houtao1@huawei.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 29, 2023 at 1:24=E2=80=AFPM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
>
> On Fri, Sep 29, 2023 at 7:52=E2=80=AFPM Emil Renner Berthing
> <emil.renner.berthing@canonical.com> wrote:
> >
> > Guenter Roeck wrote:
> > > Hi,
> > >
> > > On Fri, Sep 08, 2023 at 09:39:22PM +0800, Hou Tao wrote:
> > > > From: Hou Tao <houtao1@huawei.com>
> > > >
> > > > Add extra check in bpf_mem_alloc_init() to ensure the unit_size of
> > > > bpf_mem_cache is matched with the object_size of underlying slab ca=
che.
> > > > If these two sizes are unmatched, print a warning once and return
> > > > -EINVAL in bpf_mem_alloc_init(), so the mismatch can be found early=
 and
> > > > the potential issue can be prevented.
> > > >
> > > > Suggested-by: Alexei Starovoitov <ast@kernel.org>
> > > > Signed-off-by: Hou Tao <houtao1@huawei.com>
> > >
> > > With this patch in place, I see the following backtrace on riscv syst=
ems.
> > >
> > > [    2.953088] bpf_mem_cache[0]: unexpected object size 128, expect 9=
6
> > > [    2.953481] WARNING: CPU: 0 PID: 1 at kernel/bpf/memalloc.c:507 bp=
f_mem_alloc_init+0x326/0x32e
> > > [    2.953645] Modules linked in:
> > > [    2.953736] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.6.0-rc2-00=
244-g27bbf45eae9c #1
> > > [    2.953790] Hardware name: riscv-virtio,qemu (DT)
> > > [    2.953855] epc : bpf_mem_alloc_init+0x326/0x32e
> > > [    2.953891]  ra : bpf_mem_alloc_init+0x326/0x32e
> > > [    2.953909] epc : ffffffff8016cbd2 ra : ffffffff8016cbd2 sp : ff20=
00000000bd20
> > > [    2.953920]  gp : ffffffff81c39298 tp : ff60000002e80040 t0 : 0000=
000000000000
> > > [    2.953930]  t1 : ffffffffbbbabbc3 t2 : 635f6d656d5f6670 s0 : ff20=
00000000bdc0
> > > [    2.953940]  s1 : ffffffff8121c7da a0 : 0000000000000037 a1 : ffff=
ffff81a93048
> > > [    2.953949]  a2 : 0000000000000010 a3 : 0000000000000001 a4 : 0000=
000000000000
> > > [    2.953959]  a5 : 0000000000000000 a6 : ffffffff81c4fe08 a7 : 0000=
000000000000
> > > [    2.953968]  s2 : 000000000000000b s3 : 0000000000000000 s4 : 0000=
000000000000
> > > [    2.953977]  s5 : 0000000000000000 s6 : 0000000000000100 s7 : ff5f=
fffffffd3128
> > > [    2.953986]  s8 : ffffffff81c3d1f8 s9 : 0000000000000060 s10: 0000=
000000000000
> > > [    2.953996]  s11: 0000000000000060 t3 : 0000000065a61b33 t4 : 0000=
000000000009
> > > [    2.954005]  t5 : ffffffffde180000 t6 : ff2000000000bb08
> > > [    2.954014] status: 0000000200000120 badaddr: 0000000000000000 cau=
se: 0000000000000003
> > > [    2.954047] [<ffffffff8016cbd2>] bpf_mem_alloc_init+0x326/0x32e
> > > [    2.954087] [<ffffffff80e11426>] bpf_global_ma_init+0x1c/0x30
> > > [    2.954097] [<ffffffff8000285e>] do_one_initcall+0x5c/0x238
> > > [    2.954105] [<ffffffff80e011ae>] kernel_init_freeable+0x29a/0x30e
> > > [    2.954115] [<ffffffff80c0312c>] kernel_init+0x1e/0x112
> > > [    2.954124] [<ffffffff80003d82>] ret_from_fork+0xa/0x1c
> > >
> > > Copying riscv maintainers and mailing list for feedback / comments.
> >
> > If it makes a difference I also see this with 6.6-rc3 on my Nezha board
> > (Allwinner D1), but not on my VisionFive 2 (JH7110) running the same ke=
rnel.
> >
>
> Adding one more RISC-V board (Renesas RZ/Five) to list where I see this i=
ssue:

Could you please help test the proposed fix:
https://patchwork.kernel.org/project/netdevbpf/patch/20230928101558.2594068=
-1-houtao@huaweicloud.com/

