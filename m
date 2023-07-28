Return-Path: <bpf+bounces-6196-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC547766D3B
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 14:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A9521C21577
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 12:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAA7125CA;
	Fri, 28 Jul 2023 12:30:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9227012B9B
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 12:30:10 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD721FF5
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 05:30:05 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-313e742a787so1415172f8f.1
        for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 05:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690547404; x=1691152204;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xj8IIGFmsGdfdG8PMHJ1A45/KAXgex+79w8xMr6y/2s=;
        b=sXxJ72cmiD3v1fBC7IqnvpWz+QQm0tGdfqnQAeJ+ETqjOBWV5lb+CgvQBIaN/QdpYd
         IHmZ3g/tgXeNIUXN+avxCTNUErgVdw8H47mrW5eC8yn1fmj8dV0qHq1pIxdH9nFcQqDM
         +A4LNbaHHgazijozCfo+beeyMG42XWAA/CnbdKoZGavis9JV9gsPfwyvAqgHFmFsnA72
         rD6u9w/ftE03oGUoF7pMKXDhXhnyXzXEZGSmi018WlBCSCZFNfaH5rZAyu9Trsz/rXyt
         WDirI+86NNc9V58W/Aoy1nGgF7izdtq6j81lyv12o7IUH/0PL0FrC8NrZW20555C2aeI
         y3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690547404; x=1691152204;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xj8IIGFmsGdfdG8PMHJ1A45/KAXgex+79w8xMr6y/2s=;
        b=YyWEu78aQf7z2Oop8OTcI7dvxq3XxaZMpxjty2LOl7olhHAftjGxFiuScdq5xAUN4L
         Ilofi2PHn2WXluTpNOyUlRM/Qf19OAH8gP3p7fjGHC14EIvMvWBY42OxEMbiupwm4PLn
         2qpPMt0bzMgbNXfBGAPK0YZxs1sxcfqPVsUyrwK2gk37AD0+JhyCpMnpb4Ux4Y921XH2
         xjdctHR/w4O1BuSJYZg+t9R0AqH28mHIwRC5b1uqzwVduJc94lO8+avl/i2usUhQAQ6S
         fSQdxDRdcc9F5bZ6MsVZOixkxzYw3gVTW2YZeo87aSop6sh/q3LJEKlh62ISGbPJoLNf
         iasQ==
X-Gm-Message-State: ABy/qLab6axJCNm1GSi/l1+viP1rorXFbTe+QtIjT2rzY37KH0XHM2Tk
	TC1i/uV8ibwCKUOivhYJW7Q=
X-Google-Smtp-Source: APBJJlG/Taf0t/5MAvgO7ggMVoSuTVngt1QvniRTNI3h8u27qXDw89BJ+SL/OBEFtvGrEMXb+Fls2A==
X-Received: by 2002:adf:ed4f:0:b0:316:f4b9:a952 with SMTP id u15-20020adfed4f000000b00316f4b9a952mr4432678wro.31.1690547403461;
        Fri, 28 Jul 2023 05:30:03 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id y18-20020a5d6212000000b003143c6e09ccsm4756610wru.16.2023.07.28.05.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 05:30:02 -0700 (PDT)
Message-ID: <95da56aa3554ac687d4ebb5401dac23819fe72f7.camel@gmail.com>
Subject: Re: Question: CO-RE-enabled PT_REGS macros give strange results
From: Eduard Zingerman <eddyz87@gmail.com>
To: yonghong.song@linux.dev, Alan Maguire <alan.maguire@oracle.com>, Timofei
	Pushkin <pushkin.td@gmail.com>, Alexei Starovoitov <ast@kernel.org>
Cc: bpf@vger.kernel.org
Date: Fri, 28 Jul 2023 15:30:01 +0300
In-Reply-To: <84b63263-8dca-4e74-d440-a21c4c17da91@linux.dev>
References: 
	<CAChPKzs_QBghSBfxMtTZoAsaRgwBK9dRXuXZg+tg2=wz=AuGgg@mail.gmail.com>
	 <3d26842f-86a4-e897-44c2-00c55fadb64a@oracle.com>
	 <CAChPKztZ9kaNw-PkhEq4UKidjVgKNnwLPKzYvLc6BcOOUtvEkQ@mail.gmail.com>
	 <883961c3-3ea2-2253-4976-aa5e20870820@oracle.com>
	 <51d510b9-fbbd-d30a-9a01-e77c84db52a5@oracle.com>
	 <49c9170f7dd0d3e78a12570ae422bce553a1e236.camel@gmail.com>
	 <308bfec7-38d7-9dcd-3130-5602658db47f@oracle.com>
	 <8dd70c47d4f395ad5dd3b1da9e77221125eb9146.camel@gmail.com>
	 <4067a5cebe3df5b5cf436b27479a7c9a065d69a0.camel@gmail.com>
	 <84b63263-8dca-4e74-d440-a21c4c17da91@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 2023-07-27 at 20:03 -0700, Yonghong Song wrote:
>=20
> On 7/26/23 4:39 PM, Eduard Zingerman wrote:
> > On Wed, 2023-07-26 at 23:03 +0300, Eduard Zingerman wrote:
> > [...]
> > > > > It looks like `PT_REGS_IP_CORE` macro should not be defined throu=
gh
> > > > > bpf_probe_read_kernel(). I'll dig through commit history tomorrow=
 to
> > > > > understand why is it defined like that now.
> > > > >   help
> > > >=20
> > > > If I recall the rationale was to allow the macros to work for both
> > > > BPF programs that can do direct dereference (fentry, fexit, tp_btf =
etc)
> > > > and for kprobe-style that need to use bpf_probe_read_kernel().
> > > > Not sure if it would be worth having variants that are purely
> > > > dereference-based, since we can just use PT_REGS_IP() due to
> > > > the __builtin_preserve_access_index attributes applied in vmlinux.h=
.
> > >=20
> > > Sorry, need a bit more time, thanks for the context.
> >=20
> > The PT_REGS_*_CORE macros were added by Andrii Nakryiko in [1].
> > Stated intent there is to use those macros for raw tracepoint
> > programs. Such programs have `struct pt_regs` as a parameter.
> > Contexts of type `struct pt_regs` are *not* subject to rewrite by
> > convert_ctx_access(), so it is valid to use PT_REGS_*_CORE for such
> > programs.
> >=20
> > However, `struct pt_regs` is also a part of `struct
> > bpf_perf_event_data`. Latter is used as a context parameter for
> > "perf_event" programs and is a subject to rewrite by
> > convert_ctx_access(). Thus, PT_REGS_*_CORE macros can't be used for
> > such programs (because these macro are implemented through
> > bpf_probe_read_kernel() of which convert_ctx_access() is not aware).
> >=20
> > If `struct pt_regs` is defined with `preserve_access_index` attribute
> > CO-RE relocations are generated for both PT_REGS_IP_CORE and
> > PT_REGS_IP invocations. So, there is no real need to use *_CORE
> > variants in combination with `struct bpf_perf_event_data` to have all
> > CO-RE benefits, e.g.:
> >=20
> >    $ cat bpf.c
> >    #include "vmlinux.h"
> >    // ...
> >    SEC("perf_event")
> >    int do_test(struct bpf_perf_event_data *ctx) {
> >      return PT_REGS_IP(&ctx->regs);
> >    }
> >    // ...
> >    $ llvm-objdump --no-show-raw-insn -rd bpf.o
> >    ...
> >    0000000000000000 <do_test>:
> >           0: r0 =3D *(u64 *)(r1 + 0x80)
> >              0000000000000000:  CO-RE <byte_off> [11] struct bpf_perf_e=
vent_data::regs.ip (0:0:16)
> >           1: exit
> >=20
> > [1] b8ebce86ffe6 ("libbpf: Provide CO-RE variants of PT_REGS macros")
> >=20
> > ---
> >=20
> > I think the following should be done:
> > - Timofei's code should use PT_REGS_IP and make sure that `struct
> >    pt_regs` has preserve_access_index annotation (e.g. use vmlinux.h);
> > - verifier should be adjusted to report error when
> >    bpf_probe_read_kernel() (and similar) are used to read from "fake"
> >    contexts.
>=20
> The func prototype of bpf_probe_read_kernel() is
>=20
> BPF_CALL_3(bpf_probe_read_kernel, void *, dst, u32, size,
>             const void *, unsafe_ptr)
> {
>          return bpf_probe_read_kernel_common(dst, size, unsafe_ptr);
> }
>=20
> Notice the argument name is 'unsafe_ptr'. So there is no checking
> in verifier for this argument. Some users may take advantage of this
> to initialize the 'dst' with 0 by providing an illegal address.

On the one hand yes, but on the other hand the address of context
parameter like bpf_perf_event_data is a kind of fake, it does not exist.
It would be meaningful to use bpf_probe_read_kernel() for this address
only if someone knows the layout of the internal verifier structure
`bpf_perf_event_data_kern` and wants to access it.
Tbh, this appears to be a "footgun".

>=20
>=20
> > - (maybe?) update PT_REGS_*_CORE to use `__builtin_preserve_access_inde=
x`
> >    (to allow usage with `bpf_perf_event_data` context).
> >=20
> > [...]
> >=20


