Return-Path: <bpf+bounces-8676-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1776D788EF5
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 20:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 478ED1C20EE7
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 18:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E44218AF2;
	Fri, 25 Aug 2023 18:53:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D98B174F7
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 18:53:55 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513181BD2
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 11:53:54 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2bce552508fso18848901fa.1
        for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 11:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692989632; x=1693594432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTNsb8ZD5nYCip/qmAJsV2FZCF/nHIHZIkkwz3tv4Dw=;
        b=pb+g/Y6GZHZS+GGwxtAU4pQWV56mJqsoMgXzerBWSod+yCPbJAaYRjY9qvA3arNZKE
         fwl+kXu9Cd+Kpi8zHes91txNh+5av0nJ41Lo53A4bm0DJ7Qd6zCdgshWolKgkUvjuJd8
         P0SEI/r5nMlGpTOWV8Q79j+d9ZW08Gt77KjVv+guVC80Vjml1euwe5SpdkPGexgzFiBU
         2gEii/W6pTUtcoxfMBMAvVTI6B3BhjiJMzpgLZCL7OSRPZK7Ml6n6OeeVVRhuOS7tIAO
         /VBZQ22wHOx0nRPbo+FXXqGQ1yB5MS3fGzAa7oiwubLFjOpOfvhUOj5fGUDvoaP/Omhu
         1nJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692989632; x=1693594432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BTNsb8ZD5nYCip/qmAJsV2FZCF/nHIHZIkkwz3tv4Dw=;
        b=GVKAHO/7uHB2gMu33OBa1bwK7w6W3uWmb12qgRVpb7T0EvGTmW9dr57HXgMYnARNsX
         Fqvww1ollU2Glf8W2nJbu52OdDFBOLWr803iTaJQlLd3xtLb7yV4jA5ZLCIYKDtGAFD+
         9y+dTR05ne1ArJoBPofrI0951o40MJ7PQhc2kYVbTnK8h0VprSTemR6sxkIvNyIKLaE7
         7wGn2suDefBcYdGDNS14JUb8IrwFEYpzGmSbcXOEwUS+5tbVrDi4ZV0VJ3cbYFXMk2b0
         wrIkH/+Xu88MaL1euo4zSOcyoD0r+fqXPtYppGxlBs3PLho7B4tQMybH5dRk9grVodCq
         Nekw==
X-Gm-Message-State: AOJu0YzRG51mZawTvT8H+iy3/nAJr39D2R62Nd/xDQ+yZF/EECw/980r
	h2AEhJedesYZT6KkDe14lF6nUHwOraVbq/6IzbEVJQJgtgc=
X-Google-Smtp-Source: AGHT+IH1lj6IJ2Oqh5+YmwsxP5iRpd/0RsQY38qRwZGE8zdW9QCWIVhcsBNg/WB6zxnQUYsORFjwY63xRDe8TzYIxjM=
X-Received: by 2002:a2e:920b:0:b0:2bb:94e4:490 with SMTP id
 k11-20020a2e920b000000b002bb94e40490mr15845256ljg.23.1692989632311; Fri, 25
 Aug 2023 11:53:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87jztjmmy4.fsf@all.your.base.are.belong.to.us> <2f4f0dfc-ec06-8ac8-a56a-395cc2373def@linux.dev>
In-Reply-To: <2f4f0dfc-ec06-8ac8-a56a-395cc2373def@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 25 Aug 2023 11:53:41 -0700
Message-ID: <CAADnVQ+sthRd1CHtCNo=AKN7mXZEMkA5fS6zh-Ncbh8uC3FERQ@mail.gmail.com>
Subject: Re: WARNING: CPU: 3 PID: 261 at kernel/bpf/memalloc.c:342
To: Yonghong Song <yonghong.song@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Dave Marchevsky <davemarchevsky@meta.com>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	bpf <bpf@vger.kernel.org>, linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 25, 2023 at 8:28=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
>
> On 8/25/23 3:32 AM, Bj=C3=B6rn T=C3=B6pel wrote:
> > I'm chasing a workqueue hang on RISC-V/qemu (TCG), using the bpf
> > selftests on bpf-next 9e3b47abeb8f.
> >
> > I'm able to reproduce the hang by multiple runs of:
> >   | ./test_progs -a link_api -a linked_list
> > I'm currently investigating that.
> >
> > But! Sometimes (every blue moon) I get a warn_on_once hit:
> >   | ------------[ cut here ]------------
> >   | WARNING: CPU: 3 PID: 261 at kernel/bpf/memalloc.c:342 bpf_mem_refil=
l+0x1fc/0x206
> >   | Modules linked in: bpf_testmod(OE)
> >   | CPU: 3 PID: 261 Comm: test_progs-cpuv Tainted: G           OE    N =
6.5.0-rc5-01743-gdcb152bb8328 #2
> >   | Hardware name: riscv-virtio,qemu (DT)
> >   | epc : bpf_mem_refill+0x1fc/0x206
> >   |  ra : irq_work_single+0x68/0x70
> >   | epc : ffffffff801b1bc4 ra : ffffffff8015fe84 sp : ff2000000001be20
> >   |  gp : ffffffff82d26138 tp : ff6000008477a800 t0 : 0000000000046600
> >   |  t1 : ffffffff812b6ddc t2 : 0000000000000000 s0 : ff2000000001be70
> >   |  s1 : ff5ffffffffe8998 a0 : ff5ffffffffe8998 a1 : ff600003fef4b000
> >   |  a2 : 000000000000003f a3 : ffffffff80008250 a4 : 0000000000000060
> >   |  a5 : 0000000000000080 a6 : 0000000000000000 a7 : 0000000000735049
> >   |  s2 : ff5ffffffffe8998 s3 : 0000000000000022 s4 : 0000000000001000
> >   |  s5 : 0000000000000007 s6 : ff5ffffffffe8570 s7 : ffffffff82d6bd30
> >   |  s8 : 000000000000003f s9 : ffffffff82d2c5e8 s10: 000000000000ffff
> >   |  s11: ffffffff82d2c5d8 t3 : ffffffff81ea8f28 t4 : 0000000000000000
> >   |  t5 : ff6000008fd28278 t6 : 0000000000040000
> >   | status: 0000000200000100 badaddr: 0000000000000000 cause: 000000000=
0000003
> >   | [<ffffffff801b1bc4>] bpf_mem_refill+0x1fc/0x206
> >   | [<ffffffff8015fe84>] irq_work_single+0x68/0x70
> >   | [<ffffffff8015feb4>] irq_work_run_list+0x28/0x36
> >   | [<ffffffff8015fefa>] irq_work_run+0x38/0x66
> >   | [<ffffffff8000828a>] handle_IPI+0x3a/0xb4
> >   | [<ffffffff800a5c3a>] handle_percpu_devid_irq+0xa4/0x1f8
> >   | [<ffffffff8009fafa>] generic_handle_domain_irq+0x28/0x36
> >   | [<ffffffff800ae570>] ipi_mux_process+0xac/0xfa
> >   | [<ffffffff8000a8ea>] sbi_ipi_handle+0x2e/0x88
> >   | [<ffffffff8009fafa>] generic_handle_domain_irq+0x28/0x36
> >   | [<ffffffff807ee70e>] riscv_intc_irq+0x36/0x4e
> >   | [<ffffffff812b5d3a>] handle_riscv_irq+0x54/0x86
> >   | [<ffffffff812b6904>] do_irq+0x66/0x98
> >   | ---[ end trace 0000000000000000 ]---
> >
> > Code:
> >   | static void free_bulk(struct bpf_mem_cache *c)
> >   | {
> >   |   struct bpf_mem_cache *tgt =3D c->tgt;
> >   |   struct llist_node *llnode, *t;
> >   |   unsigned long flags;
> >   |   int cnt;
> >   |
> >   |   WARN_ON_ONCE(tgt->unit_size !=3D c->unit_size);
> >   | ...
> >
> > I'm not well versed in the memory allocator; Before I dive into it --
> > has anyone else hit it? Ideas on why the warn_on_once is hit?
>
> Maybe take a look at the patch
>    822fb26bdb55  bpf: Add a hint to allocated objects.
>
> In the above patch, we have
>
> +       /*
> +        * Remember bpf_mem_cache that allocated this object.
> +        * The hint is not accurate.
> +        */
> +       c->tgt =3D *(struct bpf_mem_cache **)llnode;
>
> I suspect that the warning may be related to the above.
> I tried the above ./test_progs command line (running multiple
> at the same time) and didn't trigger the issue.

Interesting. Thanks for the report.
I wasn't able to repo the warn either, but I can confirm that linked_list
test is super slow on the kernel with debugs on and may appear to "hang",
since it doesn't respond to key press for many seconds.

time ./test_progs -a linked_list
Summary: 1/132 PASSED, 0 SKIPPED, 0 FAILED

real    0m35.897s
user    0m1.860s
sys    0m32.105s

That's not normal.

Kumar, Dave,

do you have any suggestions?

