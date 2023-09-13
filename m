Return-Path: <bpf+bounces-9941-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9563F79EFC4
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 19:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ABFD1C215CB
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 17:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813F31F93A;
	Wed, 13 Sep 2023 16:58:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A210AD52
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 16:58:42 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321D22D6A
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 09:58:41 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99c3c8adb27so9641366b.1
        for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 09:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694624319; x=1695229119; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VadLxhDMbKwpTMXWPGVMkS9C4pT+2hfSCzzlO0cS0YM=;
        b=Z2+fFQDIoWUXcbW1qvSOo5SDsPa36/PjMO5yYY0WUWCy0D129GMxgjEBYl5eyGcw+z
         9+05Wr71LcuXVYod2bkuHuo83PGz+DiydLZW+aBchFkVkw7N9I2yflKmHBPyB6mWvMva
         SnPM1G1S/QGqNz2HDhD4hgB7qH5pBBZnDsvVhIaE8KheBlKJgy7D0ve9Y83Zt4x44gCI
         VsRWqDS+1XvT/lbNFVGRlUb3Gc+oIEZD8Nk7tN5x48z4LV51TqqlRJLkWKynmcPk16d/
         9AO4sRr8EwaEGotrIRfZlikvdy16PEef78qtl/CKg0plnYTeaLEWdNxrvlz3jKazJXrr
         asUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694624319; x=1695229119;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VadLxhDMbKwpTMXWPGVMkS9C4pT+2hfSCzzlO0cS0YM=;
        b=rVPRSq71jL0cKyJQKW2Q66MNffY9B5Jf/kWGh0jiPNc2In30sqieQ/gKcsDiua8BgT
         6hiCqzfDc3gdugf9z5DrK811xkvAtRgExWB4zZ1Mv+zrNhnjS5fvoan1KkmRXqaC7liC
         XisxS+eti7qgMVKrvneDNt/HMrOPg/G/Eh1aJem7Njt8cfsxglg5qECxW2gRU7KfBb1t
         GV90I+nuknNLFIbWEjlYFX2TxE2GJka9Lyaw++U1T77wv9deIMhAIHUHPrY+IfNvxSLE
         WVTwvPv8SVuU7Sw43zVjrmKJrijmlrgpi2wUwzQavcEBXQNATte9/8PX2Z2Mpzn8u4CT
         fOmQ==
X-Gm-Message-State: AOJu0YwIGtyKIfHLwqmttcwqJ08MIEgW5snE4BnTNuniNRkDNsc8Mxtx
	xLjMz8Hpi66/zrGPb4vlwok=
X-Google-Smtp-Source: AGHT+IE6lu8LGrJwK+m9OTxD5agqjsgkXrRgR1iCteE07e46D3QahknDbWIl6Xc0knuZy5IJnIt5Fw==
X-Received: by 2002:a17:907:a079:b0:99c:a23b:b4f4 with SMTP id ia25-20020a170907a07900b0099ca23bb4f4mr2497453ejc.2.1694624319146;
        Wed, 13 Sep 2023 09:58:39 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id dx22-20020a170906a85600b0099d959f9536sm8813010ejb.12.2023.09.13.09.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 09:58:38 -0700 (PDT)
Message-ID: <2b1d1f9b3ee7f28e19404e45c7391d2d9e123c54.camel@gmail.com>
Subject: Re: [PATCH dwarves 0/3] dwarves: detect BTF kinds supported by
 kernel
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, acme@kernel.org
Cc: andrii.nakryiko@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
 jolsa@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com,  mykolal@fb.com, bpf@vger.kernel.org
Date: Wed, 13 Sep 2023 19:58:37 +0300
In-Reply-To: <20230913142646.190047-1-alan.maguire@oracle.com>
References: <20230913142646.190047-1-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-09-13 at 15:26 +0100, Alan Maguire wrote:
> > > > When a newer pahole is run on an older kernel, it often knows about=
 BTF
> > > > kinds that the kernel does not support, and adds them to the BTF
> > > > representation.  This is a problem because the BTF generated is the=
n
> > > > embedded in the kernel image.  When it is later read - possibly by
> > > > a different older toolchain or by the kernel directly - it is not u=
sable.
> > > >=20
> > > > The scripts/pahole-flags.sh script enumerates the various pahole op=
tions
> > > > available associated with various versions of pahole, but in the ca=
se
> > > > of an older kernel is the set of BTF kinds the _kernel_ can handle =
that
> > > > is of more importance.
> > > >=20
> > > > Because recent features such as BTF_KIND_ENUM64 are added by defaul=
t
> > > > (and only skipped if --skip_encoding_btf_* is set), BTF will be
> > > > created with these newer kinds that the older kernel cannot read.
> > > > This can be (and has been) fixed by stable-backporting --skip optio=
ns,
> > > > but this is cumbersome and would have to be done every time a new B=
TF kind
> > > > is introduced.
> > > >=20
> > > > So this series attempts to detect the BTF kinds supported by the
> > > > kernel/modules so that this can inform BTF encoding for older
> > > > kernels.  We look for BTF_KIND_MAX - either as an enumerated value
> > > > in vmlinux DWARF (patch 1) or as an enumerated value in base vmlinu=
x
> > > > BTF (patch 3).  Knowing this prior to encoding BTF allows us to spe=
cify
> > > > skip_encoding options to avoid having BTF with kinds the kernel its=
elf
> > > > will not understand.
> > > >=20
> > > > The aim is to minimize pain for older stable kernels when new BTF
> > > > kinds are introduced.  Kind encoding [1] can solve the parsing prob=
lem
> > > > with BTF, but this approach is intended to ensure generated BTF is
> > > > usable when newer pahole runs on older kernels.
> > > >=20
> > > > This approach requires BTF kinds to be defined via an enumerated ty=
pe,
> > > > which happened for 5.16 and later.  Older kernels than this used #d=
efines
> > > > so the approach will only work for 5.16 stable kernels and later cu=
rrently.
> > > >=20
> > > > With this change in hand, adding new BTF kinds becomes a bit simple=
r,
> > > > at least for the user of pahole.  All that needs to be done is to a=
dd
> > > > internal "skip_new_kind" booleans to struct conf_load and set them
> > > > in dwarves__set_btf_kind_max() if the detected maximum kind is less
> > > > than the kind in question - in other words, if the kernel does not =
know
> > > > about that kind.  In that case, we will not use it in encoding.
> > > >=20
> > > > The approach was tested on Linux 5.16 as released, i.e. prior to th=
e
> > > > backports adding --skip_encoding logic, and the BTF generated did n=
ot
> > > > contain kinds > BTF_KIND_MAX for the kernel (corresponding to
> > > > BTF_KIND_DECL_TAG in that case).

Hi Alan,

I tested this patch (by tweaking BTF_KIND_MAX value and comparing generated=
 BTF)
and it seems to work as intended. Left a few nitpicks.

Thanks,
Eduard


> > > >=20
> > > > Changes since RFC [2]:
> > > > =C2=A0- added --skip_autodetect_btf_kind_max to disable kind autode=
tection
> > > > =C2=A0=C2=A0=C2=A0(Jiri, patch 2)
> > > >=20
> > > > [1] https://lore.kernel.org/bpf/20230616171728.530116-1-alan.maguir=
e@oracle.com/
> > > > [2] https://lore.kernel.org/bpf/20230720201443.224040-1-alan.maguir=
e@oracle.com/
> > > >=20
> > > > Alan Maguire (3):
> > > > =C2=A0=C2=A0dwarves: auto-detect maximum kind supported by vmlinux
> > > > =C2=A0=C2=A0pahole: add --skip_autodetect_btf_kind_max to disable k=
ind autodetect
> > > > =C2=A0=C2=A0btf_encoder: learn BTF_KIND_MAX value from base BTF whe=
n generating
> > > > =C2=A0=C2=A0=C2=A0=C2=A0split BTF
> > > >=20
> > > > =C2=A0btf_encoder.c      | 37 +++++++++++++++++++++++++++++++++
> > > > =C2=A0btf_encoder.h      |  2 ++
> > > > =C2=A0dwarf_loader.c     | 52 +++++++++++++++++++++++++++++++++++++=
+++++++++
> > > > =C2=A0dwarves.h          |  3 +++
> > > > =C2=A0man-pages/pahole.1 |  4 ++++
> > > > =C2=A0pahole.c           | 10 +++++++++
> > > > =C2=A06 files changed, 108 insertions(+)
> > > >=20


