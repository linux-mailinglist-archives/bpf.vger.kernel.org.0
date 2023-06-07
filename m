Return-Path: <bpf+bounces-2041-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E9C7270AE
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 23:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E54C41C20EDF
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 21:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD963B8BD;
	Wed,  7 Jun 2023 21:44:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E819D3AE79
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 21:43:59 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F881B0
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 14:43:58 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-977e0fbd742so568775266b.2
        for <bpf@vger.kernel.org>; Wed, 07 Jun 2023 14:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686174236; x=1688766236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MgOpriJYWCpUyTFnCc3VqHTvUy3C/4WfNeDsznwKzE0=;
        b=XRIztGK4GLKkoL6Nj27oAw0Iy8MinLLb+WgVd2Ah6jz5ulIa/9M6w4FcQ582INURYA
         kiFq6F7g3oAsZ3cdW13e5NiL2Ri1tZCdRmsFE/epZg1RQG2rEAFl6T+FeVG+3To0DeFq
         O+UZ3wTBGfClJDVIbWFqYVtFIXD8+ROhJLSqVIi4Ev9ggEyM0UjtMqn1IJ43qLtfpFy1
         9GjxGul/OyQdyGXQk7R9REdI5B0y7cDuVO8pbf0xYIMjswQhYBDVAsTunuBIrUeTX1dx
         GaEWdTEVVAMvIcY++thN2kWQt4RYbahQx9UUXBPSM3c8/NTOjVywWD+9gmoNYf+S1aa8
         hXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686174236; x=1688766236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MgOpriJYWCpUyTFnCc3VqHTvUy3C/4WfNeDsznwKzE0=;
        b=jjbDrURDQENeDXuTn72auCREVnkdO5x2lecF+C/5lG58jtBt2UTC+xxaq4aBYaP36H
         o/nC79zHrJ6cNNRuWa8j0/Dxr8klj94X0+Q7XY0jSG8qi4DiWxV129+TiuqkqP9dobYt
         DC8+MM7CEpMP4nK712VX1w9NcEzieMckxsRrr601sMjZaIAVEbBd1bzKjGWfNhP/YA6b
         HdsID3GYiWhBVUr0yoxlmMdrFr+Z0asH2EpENaB4RYpMiRMsT/DhwSX29SEmSE5Ta+uQ
         bvbtiFWNhtBYTIt6FJ3JliTVXFVo9sT+6feMMEEoAGt5G3UebfAJv/+Xod1P9rxvE1CW
         enUw==
X-Gm-Message-State: AC+VfDxzks9xe84xz93AYkVbESpTEB4Da3r3HP8CizIxKYa6zVgPjOK2
	Hj84r/9is6WTkPPDEeNGgkyQ453H6R9zR93gcD8=
X-Google-Smtp-Source: ACHHUZ7Vfefz7JsJ6aX7D2AddfDfdgPSX9PKXzin3OgE1LdO8RvKE0gcgoSLJ5AXc2WkzY0aXkITNrf+jLV7dam4evM=
X-Received: by 2002:a17:907:6d05:b0:969:f9e8:a77c with SMTP id
 sa5-20020a1709076d0500b00969f9e8a77cmr7297829ejc.64.1686174236560; Wed, 07
 Jun 2023 14:43:56 -0700 (PDT)
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
 <CAADnVQKbmAHTHk5YsH-t42BRz16MvXdRBdFmc5HFyCPijX-oNg@mail.gmail.com>
 <CAEf4BzamU4qTjrtoC_9zwx+DHyW26yq_HrevHw2ui-nqr6UF-g@mail.gmail.com>
 <CAADnVQ+_YeLZ0kmF+QueH_xE10=b-4m_BMh_-rct6S8TbpL0hw@mail.gmail.com>
 <CAEf4Bzbtptc9DUJ8peBU=xyrXxJFK5=rkr3gGRh05wwtnBZ==A@mail.gmail.com>
 <CAADnVQJAmYgR91WKJ_Jif6c3ja=OAmkMXoUO9sTnmp-xmnbVJQ@mail.gmail.com>
 <CAEf4BzYG2FFcM_0mkiARzKnYinQYHpWE8ct35Z==-Fsefv9oQw@mail.gmail.com> <CAADnVQJ712O0FeKQwUAG1+WvFTkX1FBNTb1v+frA7vNAkXLgqg@mail.gmail.com>
In-Reply-To: <CAADnVQJ712O0FeKQwUAG1+WvFTkX1FBNTb1v+frA7vNAkXLgqg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 7 Jun 2023 14:43:44 -0700
Message-ID: <CAEf4BzZ2x=RZUbORfUOxqC-oFPJ5EH1=uGxrzZGAa76d5saZ7w@mail.gmail.com>
Subject: Re: [RFC bpf-next 1/8] btf: add kind metadata encoding to UAPI
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
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

On Tue, Jun 6, 2023 at 6:16=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Jun 6, 2023 at 9:50=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > Agreed, I don't think we can ever make BTF dedup work reliably with
> > KINDs it doesn't understand. I wouldn't even try. I'd also say that
> > kernel should keep being strict about this (even if we add
> > "is-it-optional" field, kernel can't trust it). Libbpf and other
> > libraries will have to keep sanitizing BTF anyways.
>
> Good point. "it-is-optional" flag should be for user space only.
>
> > > If we go this simple route I'm fine with hard coded crc and base_crc
> > > fields. They probably should go to btf_header though.
> >
> > Yep, on btf_header fields. But I'd not hardcode "crc" name. If we are
> > doing them as strings (which I think we should instead of dooming them
> > to 32-bit integer crc32 value only), then can we just say generically
> > that it's either "id" or "checksum"?
> >
> > But I guess crc32 would be fine in practice as well. So not something
> > I strongly feel about.
>
> I still fail to see how generic string "id" helps.
> We have to standardize on a way to checksum BTF-s.
> Say, we pick crc32.
> pahole/clang would have to use the same algorithm.
> Then kernel during BTF_LOAD should check that crc32 matches
> to make sure btf data didn't get corrupted between its creation
> and loading into the kernel.
> Just like btrfs uses crc32 to make sure data doesn't get corrupted by dis=
k.
> libbpf doing sanitization would need to tweak crc32 too.
> So it's going to be hard coded semantics at every level.
> id and especially string id would be cumbersome for all these layers
> to deal with.

Ok, that's totally fine with me. For me this whole checksumming was
less about checksum and validating content of BTF wasn't corrupted. It
was more about making sure that split BTF matches base BTF. And for
that readers (libbpf, tools, etc) wouldn't recalculate checksums on
their own. They'd get those checksums/IDs and just compare them.
Whether it's opaque string or int is absolutely irrelevant for this
use case (which was the main one for me).

But as I said, I'm fine either way. Let's hard-code crc32, it's
simpler to generate for sure.

>
>
> > > We don't need "struct btf_metadata" as well.
> > > It's making things sound beyond what it actually is.
> > > btf_header can point to an array of struct btf_kind_description.
> > > As simple as it can get.
> >
> > Agreed. Still, it's a third section, and we should at least have a
> > count of those btf_kind_layout items somewhere.
>
> of course.
> In btf_header we have
>         __u32   type_off;       /* offset of type section       */
>         __u32   type_len;       /* length of type section       */
> I meant we add:
>         __u32   kind_layouts_off;
>         __u32   kind_layouts_len;

ok, sounds good

