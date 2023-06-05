Return-Path: <bpf+bounces-1842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9BF722C4D
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 18:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF743281360
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 16:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CCA2260D;
	Mon,  5 Jun 2023 16:15:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451DE1F954
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 16:15:07 +0000 (UTC)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25222CD
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 09:15:05 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b1b66a8fd5so36851181fa.0
        for <bpf@vger.kernel.org>; Mon, 05 Jun 2023 09:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685981703; x=1688573703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOUXwqacXQkcXW7ck8vleyyebiR6qJ9gwUunB4JAO7I=;
        b=THz/u2cN0aSjlj55ARunO6WZ1DJheHOnowJ8M8sHy6OwRTxGOITGSN30e3IXJEZXJb
         risYjM2YE9ts8RD7YuhKIwJbf60cjdjeAw9/NOJPQIBWjPSNUDAAmk8qIpXVRZ4gqvc3
         NGSIO3QcmG5gwJj2jnBKEnwcEdvUEuFL22s5OCVoruCqvTCh6WdT2DYHbFnzHecBsvYL
         rPaImTT/u02c+j0CnyU77DmnKKEtZ7aWVEFILAuEwIe2XHaVKf391G6e7UjrmXiTUpzz
         VAFXIg+G/WIfsLcS5zC61o1C4L3mK7aUeeIMhgnDiKDWdwsXQfG+iX5HEY2mFxmuPQ4p
         OpjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685981703; x=1688573703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JOUXwqacXQkcXW7ck8vleyyebiR6qJ9gwUunB4JAO7I=;
        b=ZkL7QBaZCbWYENsVAbT/VBTCe94R1wEin+PM59iNs4KVays/pI3xzQ6oNaBID4T3AV
         9RMDhK110KgiYkzWGIJny0r7hJhU3VG2nISTmBdEQhxSm3I79oBmEsmtPRxjzG7yYsEG
         Zdq84h6BG1MwDQ86idHV9YMo2XkwN5yuewMfhp0LgHJQIK5FRJ8dD5soHzJT90izdRBn
         Tx8ugDwZWIZBJ6bkZsM0hYtQyR4sEDIhNfMnIdbt+a45J3A/mW+nq90iaBZAXLJQI3ey
         aWHEVVj1PAkehgYwh2Qr+srJExXCp6a9Kl9IrsGU0SJnMy21dcMsZF8Z4tx/eJ9FNFMu
         AN+w==
X-Gm-Message-State: AC+VfDzSlh+xqEHcZyy946gE2Qfvuu6+M9C/cBt64G4G0ZkX0duLC+Js
	OVHeUlFmLbZW5zrWCjspEGTZh4Jca5ZAfpV1xIc=
X-Google-Smtp-Source: ACHHUZ5rZ5yqU/dxAbxyFc0PmxZKLepP6nJfOW6RT7yLUlQOhr2khxm+8J6zd/Sk9UexkvS7iCi87wAjA0pyLM0Nwzk=
X-Received: by 2002:a2e:87c7:0:b0:2ac:7d3b:6312 with SMTP id
 v7-20020a2e87c7000000b002ac7d3b6312mr4951282ljj.22.1685981703033; Mon, 05 Jun
 2023 09:15:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230531201936.1992188-1-alan.maguire@oracle.com>
 <20230531201936.1992188-2-alan.maguire@oracle.com> <20230601035354.5u56fwuundu6m7v2@MacBook-Pro-8.local>
 <89787945-c06c-1c41-655b-057c1a3d07dd@oracle.com> <CAADnVQ+2ZuX00MSxAXWcXmyc-dqYtZvGqJ9KzJpstv183nbPEA@mail.gmail.com>
 <CAEf4BzZaUEqYnyBs6OqX2_L_X=U4zjrKF9nPeyyKp7tRNVLMww@mail.gmail.com>
 <CAADnVQKbmAHTHk5YsH-t42BRz16MvXdRBdFmc5HFyCPijX-oNg@mail.gmail.com> <CAEf4BzamU4qTjrtoC_9zwx+DHyW26yq_HrevHw2ui-nqr6UF-g@mail.gmail.com>
In-Reply-To: <CAEf4BzamU4qTjrtoC_9zwx+DHyW26yq_HrevHw2ui-nqr6UF-g@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 5 Jun 2023 09:14:51 -0700
Message-ID: <CAADnVQ+_YeLZ0kmF+QueH_xE10=b-4m_BMh_-rct6S8TbpL0hw@mail.gmail.com>
Subject: Re: [RFC bpf-next 1/8] btf: add kind metadata encoding to UAPI
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Quentin Monnet <quentin@isovalent.com>, Mykola Lysenko <mykolal@fb.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 2, 2023 at 1:34=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> >
> > > > > >> +
> > > > > >> +struct btf_kind_meta {
> > > > > >> +    __u32 name_off;         /* kind name string offset */
> > >
> > > I'm not sure why we'd need to record this for every KIND? The tool
> > > that doesn't know about this new kind can't do much about it anyways,
> > > so whether it knows that this is "KIND_NEW_FANCY" or just its ID #123
> > > doesn't make much difference?
> >
> > The name is certainly more meaningful than 123.
> > bpftool output is consumed by humans who will be able to tell the diffe=
rence.
> > I'd keep the name here.
>
> Ok, it's fine. When I was originally proposing this compact metadata,
> I was trying to make it as minimal as possible, so adding 80 bytes
> just for string offset fields (plus a bunch of strings) felt like an
> unnecessary overhead. But it's not a big deal.

Exactly. It's just 4 * num_kinds bytes in and ~20 * num_kinds for
names, but it implements 'self description'.
Otherwise the names become an external knowledge and BTF is not self descri=
bed.


> >
> > > > > > and would bump the BTF_VERSION to 2 to make it a 'milestone'.
> > >
> > > Bumping BTF_VERSION to 2 automatically makes BTF incompatible with al=
l
> > > existing kernels (and potentially many tools that parse BTF). Given w=
e
> > > can actually extend BTF in backwards compatible way by just adding an
> > > optional two fields to btf_header + extra bytes for metadata sections=
,
> > > why making our lives harder by bumping this version?
> >
> > I fail to see how bumping the version makes it harder.
> > libbpf needs to sanitize meta* fields in the struct btf_header on
> > older kernels anway. At the same time sanitizing the version from 2 to
> > 1
> > in the same header is one extra line of code in libbpf.
> > What am I missing?
>
> So I checked libbpf code, and libbpf doesn't really check the version
> field. So for the most part this BTF_VERSION bump wouldn't matter for
> any tool that's based on libbpf's struct btf API. But if libbpf did
> check version (as it probably should have), then by upgrading to newer
> Clang that would emit BTF with this metadata (but no new fancy
> BTF_KIND_KERNEL_FUNC or anything like that), we automatically make
> such BTF incompatible with all those tools.
>
> Kernel is a bit different because it's extremely strict about BTF. I'm
> more worried about tools like bpftool (but we don't check BTF_VERSION
> there due to libbpf), llvm-objdump (when it supports BTF), etc.
>
> On the other hand, what do we gain by bumping this BTF_VERSION?

The version bump will be an indication that
v2 of BTF has enough info in the format for any tool/kernel to consume it.
With v2 we should make BTF_KIND_META description mandatory.
If we keep it as v1 then the presence of BTF_KIND_META would be
an indication of 'self described' format.
Which is also ok-ish, but seems less clean.
zero vs not-zero of meta_off in btf_header is pretty much v1 vs v2.

>
> We don't have variable-sized KINDs, unless you are proposing to use
> vlen as "number of bytes" of ID payload.

Exactly. I'm proposing BTF_KIND_CHECKSUM and use vlen for size.

> And another KIND is
> automatically breaking backwards compat for all existing tools.

No. That's the whole point of 'self described'.
New kinds will not be breaking.

> For no
> good reason. This whole metadata is completely optional right now for
> anything that's using libbpf for BTF parsing. But adding KIND_ID makes
> it not optional at all.

and that's the crux of our disagreement.
If BTF_KIND_META are optional it's just a glorified comment inside BTF and
not a new 'self described' format.
If it's just a comment I'd rather not add it to BTF.
Such debug info can go to BTF.ext or don't do it at all.

The self described BTF would mean that struct btf_kind_meta-s contain
enough info for tools to parse from now on.
Imagine we didn't need CRC right now.
The self described format lands and now we want to add CRC.
If we're saying: "let's add a few hard coded fields to struct btf_header
or struct btf_metadata" then we failed.
It's not a self described format if we still need to extend hard coded
structs.
The idea of self description is that struct btf_kind_meta-s describe
absolutely everything about BTF from now on.
Meaning that not only things like ENUM64 and FUNC with addresses
become new KINDs, but crc-s and everything else is a new kind too,
because that's the only thing that btf_kind_meta-s can describe.

> Not sure what new KIND gives us in this case. This ID (whether it's
> "crc:abcdef" or just "661866dbea52bfac7420cd35d0e502d4ccc11bb6" or
> whatever) can be used by all application as is for comparison, you
> don't need to understand how it is generated at all.

That's fine. tools don't need to parse it.
With BTF_KIND_CHECKSUM the tools will just compare vlen sized binary data.

> >
> > > This also has a good property that 0 means "no ID", which helps with
> > > the base BTF case. Current "__u32 crc;" doesn't have this property an=
d
> > > requires a flag.
> >
> > imo this crc addition is a litmus test for this self-described format.
> > If we cannot encode it as a new KIND* it means this self-described
> > idea is broken.
>
> We can, but this can be a straightforward and simple *opaque* string
> ID, so the new kind just seems unnecessary.

BTF_KIND_CHECKSUM can have a string in vlen part of it, but
it feels wrong to encode binary data as a string while everything else
in BTF is binary.

