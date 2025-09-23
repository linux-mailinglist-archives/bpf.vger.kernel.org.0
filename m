Return-Path: <bpf+bounces-69317-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B429B94024
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 04:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6B7D440AB4
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 02:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A707713AD26;
	Tue, 23 Sep 2025 02:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HL82p8Ab"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A23111A8
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 02:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758594728; cv=none; b=hI7n7BEvtvINYlSi3lMTguFWBOGhh9Bl0EUQ/a9uj9/qjp4KUyW7el2TEukFMcXVY9nEKhBtFo7mlenZnXdHdaCmS0KpTzmFUDUWKR2ZQq2d2W18Ana2/9kTnPqkhpMX8MIietLKoGs0FBOV0RkqBz2UO7Pos3A4QFfnRJkg6do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758594728; c=relaxed/simple;
	bh=XLwIDfXhdZcScLV4roIj1BAh5I9hJbDXT3j5KgnB7bY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=InZERGw5OA3HVPzYFCI5UJrC3XpU9uG8KQqY+D8ldtJtUWS18UpgaWiU8d6yEzrYwviQR7mSGH+BF1HTwpUelepEtCu8Tz6GOcPZvdadMw2gjj3PPU0rbIykj4Nu8k2GPV/zpLsOXxrxNjpScj8SBzXW1LEad8LyLOT0vHWshSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HL82p8Ab; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ee12807d97so4320983f8f.0
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 19:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758594724; x=1759199524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uSm1C3xIMNqMaARGRlsuu14pK0WkBGuFOtJfwE/SmiU=;
        b=HL82p8AberJdZzU99RwnkI08yaw5mlUixKgl+YQwApewmXFaQKSk8LgesI3PKume0U
         RFYpVdyMsQz2H3DXHUtnhzp/MBTjJS4UYYBDXSm8CNS19fBZwBWQMYlv+M0ZbhJ3wxRB
         oKGaKWi/nD7dZrfbTlz3y/1N/RLSvUM+BovpKYUSrSBc4w7IJETIgPmc1PFqi23hPd96
         A1262dkB6HgGvYeTWHms+g/YB6jQEp5gkf/ttAovmMc1xmJMjzT0t4zxbal3vL5qogh0
         R8T/35eAp6spi7lm/XJHzzy355EgAjwQTAiKuZ1LOnJOMPULehn5M7gGaCb06Saqf79E
         Dgjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758594724; x=1759199524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uSm1C3xIMNqMaARGRlsuu14pK0WkBGuFOtJfwE/SmiU=;
        b=BlWpzNnP3JWHCNaHy6wh35aDTr/UWvg5hTWqvL+X1GcnbvThR9xYkdyQd9OKkAIYnc
         t1PoU26JUjEqGzy+bdSWGkARZ86eLWd1bbCPB7g5PKd2vKZNeZpGMU6cPlzSCXT2yKWf
         uLM2h2kGybwxA47KtUao5xyIGHfmWz8zi9n9G/AH3XQHih6L4/LeN0CFlgyIXzZpkyXu
         VCNsakixBLscQ8hvrb1fcPzDy4BTnB5EYip7otFqYJRKTHCXowMYga+xv88V6NmiSYSG
         fLkvXdIQK/uso+IJWlxnhV+k7EZjQL9perPbRHsBd9RcY4CgGaYEbsIVFSrXiNGv7Cme
         Ow2g==
X-Forwarded-Encrypted: i=1; AJvYcCULAPmfFEU6AA8deMF/kE8Ep7E9xMjsmzdHj5/Rlybn5twyoBJr2Q/oaWQWVOHnYRbfzwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJb03Ym40ON2cEQxux4CmYXOqk+wqAFuEuwE/XSBBUpHQSy0LG
	O/fsbKtihc91fUCG96ZamAYXG2rFpkpZ4omrIM4FRem5tFkj+OINQAATLuTzzE4ygYsqxKdD9EE
	o6RW4NTQNLQ2474CNZWhLTAG14ZdLSdo=
X-Gm-Gg: ASbGnct5nlV4vQtCa8S0gJ7x4RpVSuNtPIPr4j2Co//7hJYT123l/p3B6o1O1UOOHaA
	VpFOof+1ADQEUoNpoZslDU/GYp0JhNK77ziUo+K8oCRGX4jFaiXxRLbG6o2dQz0z7OtQm5Tofau
	SsULwm2klmShZorJlb5MqZHt09Y19XrI5EDsPcT+e5+8PyVntSpiOOXCC/q1JjjJMMA6XISv8b+
	DaZ1K4BIE3b1TS2OsQEj0sLVfDdKgR2qsWNFbn6
X-Google-Smtp-Source: AGHT+IGC5ugSM0+ruX9ahHjMhGD9q/ujlzpWpUcmjzVu7MjF8bUJE4lQuYAg/WNoRF0JvDivoxX+FzEfQHbYU6a5jd8=
X-Received: by 2002:a5d:5f54:0:b0:400:4507:474 with SMTP id
 ffacd0b85a97d-405c5bd861cmr564612f8f.18.1758594724379; Mon, 22 Sep 2025
 19:32:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250921160120.9711-1-kpsingh@kernel.org> <20250921160120.9711-5-kpsingh@kernel.org>
 <ee292661-0ffb-413e-be9c-eb21f5379688@kernel.org>
In-Reply-To: <ee292661-0ffb-413e-be9c-eb21f5379688@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 22 Sep 2025 19:31:53 -0700
X-Gm-Features: AS18NWBj_1tZdSxPOMlJ6h4rs0gk8W6ViM2Ui1g1kQuV_2g5MnnGomXTA_i-5wY
Message-ID: <CAADnVQ+S1i5wcW3FK9=KhpTr8nxSBCNCvvZvWShDouTbWt9eig@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 4/5] bpftool: Add support for signing BPF programs
To: Quentin Monnet <qmo@kernel.org>
Cc: KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Paul Moore <paul@paul-moore.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 4:24=E2=80=AFAM Quentin Monnet <qmo@kernel.org> wro=
te:
>
> 2025-09-21 18:01 UTC+0200 ~ KP Singh <kpsingh@kernel.org>
> > Two modes of operation being added:
> >
> > Add two modes of operation:
> >
> > * For prog load, allow signing a program immediately before loading. Th=
is
> >   is essential for command-line testing and administration.
> >
> >       bpftool prog load -S -k <private_key> -i <identity_cert> fentry_t=
est.bpf.o
> >
> > * For gen skeleton, embed a pre-generated signature into the C skeleton
> >   file. This supports the use of signed programs in compiled applicatio=
ns.
> >
> >       bpftool gen skeleton -S -k <private_key> -i <identity_cert> fentr=
y_test.bpf.o
> >
> > Generation of the loader program and its metadata map is implemented in
> > libbpf (bpf_obj__gen_loader). bpftool generates a skeleton that loads
> > the program and automates the required steps: freezing the map, creatin=
g
> > an exclusive map, loading, and running. Users can use standard libbpf
> > APIs directly or integrate loader program generation into their own
> > toolchains.
> >
> > Signed-off-by: KP Singh <kpsingh@kernel.org>
>
>
> Acked-by: Quentin Monnet <qmo@kernel.org>
>
> Thanks a lot!
>
>
> > ---
> >  .../bpf/bpftool/Documentation/bpftool-gen.rst |  13 +-
> >  .../bpftool/Documentation/bpftool-prog.rst    |  14 +-
> >  tools/bpf/bpftool/Makefile                    |   6 +-
> >  tools/bpf/bpftool/cgroup.c                    |   4 +
> >  tools/bpf/bpftool/gen.c                       |  68 +++++-
> >  tools/bpf/bpftool/main.c                      |  26 ++-
> >  tools/bpf/bpftool/main.h                      |  11 +
> >  tools/bpf/bpftool/prog.c                      |  29 ++-
> >  tools/bpf/bpftool/sign.c                      | 212 ++++++++++++++++++
> >  9 files changed, 372 insertions(+), 11 deletions(-)
> >  create mode 100644 tools/bpf/bpftool/sign.c
> >
> > diff --git a/tools/bpf/bpftool/Documentation/bpftool-gen.rst b/tools/bp=
f/bpftool/Documentation/bpftool-gen.rst
> > index ca860fd97d8d..d0a36f442db7 100644
> > --- a/tools/bpf/bpftool/Documentation/bpftool-gen.rst
> > +++ b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
> > @@ -16,7 +16,7 @@ SYNOPSIS
> >
> >  **bpftool** [*OPTIONS*] **gen** *COMMAND*
> >
> > -*OPTIONS* :=3D { |COMMON_OPTIONS| | { **-L** | **--use-loader** } }
> > +*OPTIONS* :=3D { |COMMON_OPTIONS| | { **-L** | **--use-loader** } | [ =
{ **-S** | **--sign** } {**-k** <private_key.pem>} **-i** <certificate.x509=
> ] }
> >
> >  *COMMAND* :=3D { **object** | **skeleton** | **help** }
> >
> > @@ -186,6 +186,17 @@ OPTIONS
> >      skeleton). A light skeleton contains a loader eBPF program. It doe=
s not use
> >      the majority of the libbpf infrastructure, and does not need libel=
f.
> >
> > +-S, --sign
> > +    For skeletons, generate a signed skeleton. This option must be use=
d with
> > +    **-k** and **-i**. Using this flag implicitly enables **--use-load=
er**.
> > +
> > +-k <private_key.pem>
> > +    Path to the private key file in PEM format, required for signing.
> > +
> > +-i <certificate.x509>
> > +    Path to the X.509 certificate file in PEM or DER format, required =
for
> > +    signing.
> > +
> >  EXAMPLES
> >  =3D=3D=3D=3D=3D=3D=3D=3D
> >  **$ cat example1.bpf.c**
> > diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/b=
pf/bpftool/Documentation/bpftool-prog.rst
> > index f69fd92df8d8..009633294b09 100644
> > --- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> > +++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
> > @@ -18,7 +18,7 @@ SYNOPSIS
> >
> >  *OPTIONS* :=3D { |COMMON_OPTIONS| |
> >  { **-f** | **--bpffs** } | { **-m** | **--mapcompat** } | { **-n** | *=
*--nomount** } |
> > -{ **-L** | **--use-loader** } }
> > +{ **-L** | **--use-loader** } | [ { **-S** | **--sign** } **-k** <priv=
ate_key.pem> **-i** <certificate.x509> ] }
>
>
> Perfect, thank you!
>
>
> >
> >  *COMMANDS* :=3D
> >  { **show** | **list** | **dump xlated** | **dump jited** | **pin** | *=
*load** |
> > @@ -248,6 +248,18 @@ OPTIONS
> >      creating the maps, and loading the programs (see **bpftool prog tr=
acelog**
> >      as a way to dump those messages).
> >
> > +-S, --sign
> > +    Enable signing of the BPF program before loading. This option must=
 be
> > +    used with **-k** and **-i**. Using this flag implicitly enables
> > +    **--use-loader**.
> > +
> > +-k <private_key.pem>
> > +    Path to the private key file in PEM format, required when signing.
> > +
> > +-i <certificate.x509>
> > +    Path to the X.509 certificate file in PEM or DER format, required =
when
> > +    signing.
> > +
> >  EXAMPLES
> >  =3D=3D=3D=3D=3D=3D=3D=3D
> >  **# bpftool prog show**
> > diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> > index 9e9a5f006cd2..586d1b2595d1 100644
> > --- a/tools/bpf/bpftool/Makefile
> > +++ b/tools/bpf/bpftool/Makefile
> > @@ -130,8 +130,8 @@ include $(FEATURES_DUMP)
> >  endif
> >  endif
> >
> > -LIBS =3D $(LIBBPF) -lelf -lz
> > -LIBS_BOOTSTRAP =3D $(LIBBPF_BOOTSTRAP) -lelf -lz
> > +LIBS =3D $(LIBBPF) -lelf -lz -lcrypto
> > +LIBS_BOOTSTRAP =3D $(LIBBPF_BOOTSTRAP) -lelf -lz -lcrypto
> >
> >  ifeq ($(feature-libelf-zstd),1)
> >  LIBS +=3D -lzstd
> > @@ -194,7 +194,7 @@ endif
> >
> >  BPFTOOL_BOOTSTRAP :=3D $(BOOTSTRAP_OUTPUT)bpftool
> >
> > -BOOTSTRAP_OBJS =3D $(addprefix $(BOOTSTRAP_OUTPUT),main.o common.o jso=
n_writer.o gen.o btf.o)
> > +BOOTSTRAP_OBJS =3D $(addprefix $(BOOTSTRAP_OUTPUT),main.o common.o jso=
n_writer.o gen.o btf.o sign.o)
> >  $(BOOTSTRAP_OBJS): $(LIBBPF_BOOTSTRAP)
> >
> >  OBJS =3D $(patsubst %.c,$(OUTPUT)%.o,$(SRCS)) $(OUTPUT)disasm.o
> > diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
> > index 944ebe21a216..ec356deb27c9 100644
> > --- a/tools/bpf/bpftool/cgroup.c
> > +++ b/tools/bpf/bpftool/cgroup.c
> > @@ -2,6 +2,10 @@
> >  // Copyright (C) 2017 Facebook
> >  // Author: Roman Gushchin <guro@fb.com>
> >
> > +#undef GCC_VERSION
> > +#ifndef _GNU_SOURCE
> > +#define _GNU_SOURCE
> > +#endif
> >  #define _XOPEN_SOURCE 500
> >  #include <errno.h>
> >  #include <fcntl.h>
> > diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> > index 67a60114368f..993c7d9484a4 100644
> > --- a/tools/bpf/bpftool/gen.c
> > +++ b/tools/bpf/bpftool/gen.c
>
> > @@ -1930,7 +1990,7 @@ static int do_help(int argc, char **argv)
> >               "       %1$s %2$s help\n"
> >               "\n"
> >               "       " HELP_SPEC_OPTIONS " |\n"
> > -             "                    {-L|--use-loader} }\n"
> > +             "                    {-L|--use-loader} | [ {-S|--sign } {=
-k} <private_key.pem> {-i} <certificate.x509> ]}\n"
>
>
> With regards to our discussion on v4 - Sorry, I had not realised
> removing the braces would make the sync test fail. ACK for keeping them
> until this is resolved in the test.
>
> As for the bash completion, I agree this should not block this series.
> Please make sure to follow-up with it. I think it should be as follows:

Quentin,
since you wrote the patch can you send it ?

