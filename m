Return-Path: <bpf+bounces-76100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E27CA638F
	for <lists+bpf@lfdr.de>; Fri, 05 Dec 2025 07:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 224003095240
	for <lists+bpf@lfdr.de>; Fri,  5 Dec 2025 06:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF752F49EC;
	Fri,  5 Dec 2025 06:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pHuXd/dZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B592E0B5C
	for <bpf@vger.kernel.org>; Fri,  5 Dec 2025 06:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764916086; cv=none; b=V1pH/mQ6bxtA/FiafGbet0WVE+K6D6hCo5wCEF3WkcBxlxusOz/zTxjTA+yqs3+xS8A96YdGG0b7MytdYwpyofz82Dst28UzUnmWNGw7q6eXkUqgfBiLThP8aCmIkmfDyQ3w4Llm7uH+qsId5h+vTBTpNsJpJQBHOc/STVvOA+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764916086; c=relaxed/simple;
	bh=adULTFJs+PSUaHBqyiXdOexnDuO5WUvtlbwYjEKqEDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jg3eDHC5rT+XLJgQqGbmCLxuIjN1TLhfNxjBm9fIiniorQi2JMAgraQI0jjGZSm91EMS/em83fvgCT0NGdg2dQw5cTNx0DpFObFytFhxifMSimvj5XkkBgWXt5gj9YsiSfvspXugDFwJ+1osfu12UY9p8d+KTX51aL08d18Et1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pHuXd/dZ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-297e13bf404so123625ad.0
        for <bpf@vger.kernel.org>; Thu, 04 Dec 2025 22:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764916084; x=1765520884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tg4C96At+RWmrCRevn4eUW4tb84Uz0A/jaW+5+zsACc=;
        b=pHuXd/dZqu1f80I1BA200mhLYYpjSV27zX9CcYZsTS3Bsuh+aZojihUIZFxiTgdtzz
         Hza0rm0MgsDtOQvTvLiPwyYkG9hF/PDQzHZ9XRsST3Jr5ZmG9sE3fIosPpwetBu3u9FZ
         ysVfQVLHkdwcGTINyQuRqVWCqPVd9VJHEfuanXtnBnF2NvOf2+Vhu7R77J6LTzkp2Rr4
         Xj91OhUw+3VO4RLx4LWnnjt28eDgKadTf3Ed/oSiXf7fQioi6xH0bMLcyojVo/YeS76X
         ca55hlD1qTqO/6x8AhsmpraSp9RHT9q1M+Sg8D0IPP8AkFX4ujgPCH5x1t+IIc26MOhP
         IWWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764916084; x=1765520884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tg4C96At+RWmrCRevn4eUW4tb84Uz0A/jaW+5+zsACc=;
        b=aSvInYYt5o3JGQt/xzw9i9rLRz1XUruuGMgk5oRklfz5imRpg5VmENax/r0uUCs4nG
         DNr26STO7u54MnBvyKp2AoRZ9bxrGSU5q/oYhNOkU4MjKFgBmUnerq3iXJ9ITowClTbc
         ybrR/ktj35ofmbK9AyPb3sW1hOljLiVHMJbQk9zzthTwJVSJjYLEzJRnHwujZ93DMn2A
         ioAl6VyYU0+n3juOD7ZQCrsa8vaCEadpu0goKyf7E+rCSP9X8WC4AfIS8DPhSAYqvNwt
         GExkx0VJeG0ugn3QW2HvlPbIzcojQ4kHgJXFKMz2jkQIMNfBIy/3r4koTq2nHn3WSKMl
         01Aw==
X-Gm-Message-State: AOJu0Yx5njkSb+Z3J2WRCCGISfeuPx0ZSgypGbaBRu2BA70gMMl3aM4Z
	86VZTGBjTKPKafvG/psyjj11wG9j00X1HcRakLovNHhuVh0Dh92KEqSDYp8Xxcl+aLRuzgK62B0
	wn5kTd8HqWFSfjLSsImg2rtDtYQgY3+lkyjA1UlzC
X-Gm-Gg: ASbGncuN+PRWgb5iTEI4Vg6lqUbPkRNZQkN10KGAPtXGR75iG1jRDxIupfGeuPzGdPA
	wn2rqpwGIvSLBOcrXSv1P9WiDY9v3T0AT/yugLpbf7Lr4cXkMGBKp2iiCZMSLizjKDBBAV/0IKn
	pCdL9oQjon8EsEJNgA5DSuJhHqnEvY08rpdUELcdtbYADgPGf/sqk+1Zor9vc7MjPB2kVBcnHLD
	uwv5M5BBsQBBEqkYQ5QOWdhB+z81wEDaKEYRABw862PAXQjGWV1bKqZnPVlsax96EC5wjpU
X-Google-Smtp-Source: AGHT+IEzdQMSmTTlL1R/SayPSxZPIRgwYRpGdZVhoUnbs+wQhJOMBVcFd9A2+p3++qaM3Vy1UWUZaycfA0EQ/3e8I3o=
X-Received: by 2002:a17:902:f34a:b0:297:eadc:3cd5 with SMTP id
 d9443c01a7336-29dd18b9b55mr296915ad.15.1764916084042; Thu, 04 Dec 2025
 22:28:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203232924.1119206-1-namhyung@kernel.org> <CAP-5=fU=G75jpsG-X6pa8_rdKapxVc615CqvcdSPBFesj02D6A@mail.gmail.com>
 <aTGz9kFQk2xNvsbC@x1> <aTIeuLOcc6c7RWUz@google.com>
In-Reply-To: <aTIeuLOcc6c7RWUz@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 4 Dec 2025 22:27:51 -0800
X-Gm-Features: AWmQ_bnFUoVvB3U83QQ-ImocuUOoXkpDxeZ4JyV4aOj0QLfTLFkmzXOBJbqxZNM
Message-ID: <CAP-5=fVRjs9Dw=_8B9NRkWxgZKn_yg5XEYXhc_UNi9HGz-R23Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] tools/build: Add a feature test for libopenssl
To: Namhyung Kim <namhyung@kernel.org>, Quentin Monnet <qmo@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: bpf@vger.kernel.org, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025 at 3:52=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Thu, Dec 04, 2025 at 01:16:54PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Wed, Dec 03, 2025 at 04:34:56PM -0800, Ian Rogers wrote:
> > > On Wed, Dec 3, 2025 at 3:29=E2=80=AFPM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > > >
> > > > It's used by bpftool and the kernel build.  Let's add a feature tes=
t so
> > > > that perf can decide what to do based on the availability.
> > >
> > > It seems strange to add a feature test that bpftool is missing and
> > > then use it only in the perf build. The signing of bpf programs isn't
> >
> > It is strange indeed, I agree that since we don't use BPF signing at
> > this point in the perf BPf skels, then we could just bootstrap a bpftoo=
l
> > without such feature and continue building the existing features.
> >
> > Adding the bpftool maintainer to the CC list, Quentin?
>
> I've already talked to Quentin and they want libopenssl as a
> requirement.
>
> https://lore.kernel.org/linux-perf-users/e44f70bf-8f50-4a4b-97b8-eaf988aa=
bced@kernel.org/

You can have libopenssl as a requirement and have a bootstrap bpftool
that doesn't require it, as the bootstrap version only provides
minimal features typically to just build bpftool. You can also have
libopenssl as a requirement and have a feature test that fails in the
bpftool build saying you are missing a requirement. Having the perf
build detect that a feature for the bpftool dependency is missing is
fine as we can then recommend installing bpftool or the missing
dependency, but doing this without bpftool also doing something just
seems inconsistent.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> > > something I think we need for skeleton support in perf. I like the
> > > feature test, could we add it and use it in bpftool? The only two
> > > functions using openssl appear to be:
> > >
> > >   __u32 register_session_key(const char *key_der_path)
> > >   int bpftool_prog_sign(struct bpf_load_and_run_opts *opts)
> > >
> > > so we can do the whole feature test then #ifdef HAVE_FEATURE... stub
> > > static inline versions of the functions game?
> > >
> > > Perhaps we only need the bootstrap version of bpftool in perf and we
> > > can just avoid dependencies that way. Looking at bpftool's build I se=
e
> > > that sign.o/c with those functions in is part of the bootstrap versio=
n
> > > of bpftool :-(
> > >
> > > Thanks,
> > > Ian
> > >
> > > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > > ---
> > > >  tools/build/Makefile.feature          | 6 ++++--
> > > >  tools/build/feature/Makefile          | 8 ++++++--
> > > >  tools/build/feature/test-all.c        | 5 +++++
> > > >  tools/build/feature/test-libopenssl.c | 7 +++++++
> > > >  4 files changed, 22 insertions(+), 4 deletions(-)
> > > >  create mode 100644 tools/build/feature/test-libopenssl.c
> > > >
> > > > diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.fe=
ature
> > > > index fc6abe369f7373c5..bc6d85bad379321b 100644
> > > > --- a/tools/build/Makefile.feature
> > > > +++ b/tools/build/Makefile.feature
> > > > @@ -99,7 +99,8 @@ FEATURE_TESTS_BASIC :=3D                  \
> > > >          libzstd                                \
> > > >          disassembler-four-args         \
> > > >          disassembler-init-styled       \
> > > > -        file-handle
> > > > +        file-handle                    \
> > > > +        libopenssl
> > > >
> > > >  # FEATURE_TESTS_BASIC + FEATURE_TESTS_EXTRA is the complete list
> > > >  # of all feature tests
> > > > @@ -147,7 +148,8 @@ FEATURE_DISPLAY ?=3D              \
> > > >           lzma                   \
> > > >           bpf                   \
> > > >           libaio                        \
> > > > -         libzstd
> > > > +         libzstd               \
> > > > +         libopenssl
> > > >
> > > >  #
> > > >  # Declare group members of a feature to display the logical OR of =
the detection
> > > > diff --git a/tools/build/feature/Makefile b/tools/build/feature/Mak=
efile
> > > > index 7c90e0d0157ac9b1..3fd5ad0db2109778 100644
> > > > --- a/tools/build/feature/Makefile
> > > > +++ b/tools/build/feature/Makefile
> > > > @@ -67,12 +67,13 @@ FILES=3D                                       =
   \
> > > >           test-libopencsd.bin                   \
> > > >           test-clang.bin                                \
> > > >           test-llvm.bin                         \
> > > > -         test-llvm-perf.bin   \
> > > > +         test-llvm-perf.bin                    \
> > > >           test-libaio.bin                       \
> > > >           test-libzstd.bin                      \
> > > >           test-clang-bpf-co-re.bin              \
> > > >           test-file-handle.bin                  \
> > > > -         test-libpfm4.bin
> > > > +         test-libpfm4.bin                      \
> > > > +         test-libopenssl.bin
> > > >
> > > >  FILES :=3D $(addprefix $(OUTPUT),$(FILES))
> > > >
> > > > @@ -381,6 +382,9 @@ endif
> > > >  $(OUTPUT)test-libpfm4.bin:
> > > >         $(BUILD) -lpfm
> > > >
> > > > +$(OUTPUT)test-libopenssl.bin:
> > > > +       $(BUILD) -lssl
> > > > +
> > > >  $(OUTPUT)test-bpftool-skeletons.bin:
> > > >         $(SYSTEM_BPFTOOL) version | grep '^features:.*skeletons' \
> > > >                 > $(@:.bin=3D.make.output) 2>&1
> > > > diff --git a/tools/build/feature/test-all.c b/tools/build/feature/t=
est-all.c
> > > > index eb346160d0ba0e2f..1488bf6e607836e5 100644
> > > > --- a/tools/build/feature/test-all.c
> > > > +++ b/tools/build/feature/test-all.c
> > > > @@ -142,6 +142,10 @@
> > > >  # include "test-libtraceevent.c"
> > > >  #undef main
> > > >
> > > > +#define main main_test_libopenssl
> > > > +# include "test-libopenssl.c"
> > > > +#undef main
> > > > +
> > > >  int main(int argc, char *argv[])
> > > >  {
> > > >         main_test_libpython();
> > > > @@ -173,6 +177,7 @@ int main(int argc, char *argv[])
> > > >         main_test_reallocarray();
> > > >         main_test_libzstd();
> > > >         main_test_libtraceevent();
> > > > +       main_test_libopenssl();
> > > >
> > > >         return 0;
> > > >  }
> > > > diff --git a/tools/build/feature/test-libopenssl.c b/tools/build/fe=
ature/test-libopenssl.c
> > > > new file mode 100644
> > > > index 0000000000000000..168c45894e8be687
> > > > --- /dev/null
> > > > +++ b/tools/build/feature/test-libopenssl.c
> > > > @@ -0,0 +1,7 @@
> > > > +#include <openssl/ssl.h>
> > > > +#include <openssl/opensslv.h>
> > > > +
> > > > +int main(void)
> > > > +{
> > > > +       return SSL_library_init();
> > > > +}
> > > > --
> > > > 2.52.0.177.g9f829587af-goog
> > > >

