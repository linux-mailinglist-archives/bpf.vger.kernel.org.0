Return-Path: <bpf+bounces-76051-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49156CA4873
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 17:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5250B3063F7D
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 16:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D09C30171F;
	Thu,  4 Dec 2025 16:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2s3rbB/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5D021D3CA;
	Thu,  4 Dec 2025 16:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764865019; cv=none; b=brt6YVlzcWDqqN1v5juNHVK7P/4f/yTzV34ckqH/+MH0LgnR2ddGKlo5BqBE5GAKaiF/opbt7FoHEZA0qnFFMwApgv76ZruAeTC2tJKAKIW36pMrK7ac3VhCWuW9kv/etzuhQa0gKV+RAVrtbCtqviiKBaB7xJl7qiB64pM8qIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764865019; c=relaxed/simple;
	bh=w+bnQF747FRQPyfTU7XxB1/U2YspG4WLg9S8Pf1uVqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e004Fgo4rq7u3/D/UCYoSiF3XJC78TSJzh/PapNxyB3cfLjt6gNWmMlc1jVXd/PupUAbWyZ/CCUmsaZCrtX4qi+FgKIuAaVNGrXeESmbKDZAoWEivnefcLNg3jLHUX5V9D8aEP1P17hGe4LhH7OGxIxs6ARnvfA22HABDTeZkOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2s3rbB/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C30DC4CEFB;
	Thu,  4 Dec 2025 16:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764865018;
	bh=w+bnQF747FRQPyfTU7XxB1/U2YspG4WLg9S8Pf1uVqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N2s3rbB/RF8vdWIZapqNzqzkjCbLI4ZNFJ79pf5Iaq7dPT4R1zjOT3WQmTpcGKFtf
	 z4V50sC8cCxGEXYRnMOFCuqGZ+/7eb9UQJdg6jZKM3i7oK2XGHV110BUH9is7plmSN
	 FMpoVIHqfKDLS/EsWJFcN1yavMFOfosZo8I2PhR5K6FGcVa3dyjvEEQXuO/5Mm71Zr
	 ySwO+AaZ0IdggFbintKdMh5L0AyXpqURBMf7/rLeNwzEWnzu7gUvk3GcoaKAEGmSi4
	 LLIkg6dLcYnfmza5DHXL3MtH50ULa+s7l3xFxOvkyC4L05Qv/reSoR9BMDtkxfiiEv
	 tGgCzXMKAMb+Q==
Date: Thu, 4 Dec 2025 13:16:54 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Quentin Monnet <qmo@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	bpf@vger.kernel.org, James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/2] tools/build: Add a feature test for libopenssl
Message-ID: <aTGz9kFQk2xNvsbC@x1>
References: <20251203232924.1119206-1-namhyung@kernel.org>
 <CAP-5=fU=G75jpsG-X6pa8_rdKapxVc615CqvcdSPBFesj02D6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU=G75jpsG-X6pa8_rdKapxVc615CqvcdSPBFesj02D6A@mail.gmail.com>

On Wed, Dec 03, 2025 at 04:34:56PM -0800, Ian Rogers wrote:
> On Wed, Dec 3, 2025 at 3:29 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > It's used by bpftool and the kernel build.  Let's add a feature test so
> > that perf can decide what to do based on the availability.
> 
> It seems strange to add a feature test that bpftool is missing and
> then use it only in the perf build. The signing of bpf programs isn't

It is strange indeed, I agree that since we don't use BPF signing at
this point in the perf BPf skels, then we could just bootstrap a bpftool
without such feature and continue building the existing features.

Adding the bpftool maintainer to the CC list, Quentin?

- Arnaldo

> something I think we need for skeleton support in perf. I like the
> feature test, could we add it and use it in bpftool? The only two
> functions using openssl appear to be:
> 
>   __u32 register_session_key(const char *key_der_path)
>   int bpftool_prog_sign(struct bpf_load_and_run_opts *opts)
> 
> so we can do the whole feature test then #ifdef HAVE_FEATURE... stub
> static inline versions of the functions game?
> 
> Perhaps we only need the bootstrap version of bpftool in perf and we
> can just avoid dependencies that way. Looking at bpftool's build I see
> that sign.o/c with those functions in is part of the bootstrap version
> of bpftool :-(
> 
> Thanks,
> Ian
> 
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/build/Makefile.feature          | 6 ++++--
> >  tools/build/feature/Makefile          | 8 ++++++--
> >  tools/build/feature/test-all.c        | 5 +++++
> >  tools/build/feature/test-libopenssl.c | 7 +++++++
> >  4 files changed, 22 insertions(+), 4 deletions(-)
> >  create mode 100644 tools/build/feature/test-libopenssl.c
> >
> > diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> > index fc6abe369f7373c5..bc6d85bad379321b 100644
> > --- a/tools/build/Makefile.feature
> > +++ b/tools/build/Makefile.feature
> > @@ -99,7 +99,8 @@ FEATURE_TESTS_BASIC :=                  \
> >          libzstd                                \
> >          disassembler-four-args         \
> >          disassembler-init-styled       \
> > -        file-handle
> > +        file-handle                    \
> > +        libopenssl
> >
> >  # FEATURE_TESTS_BASIC + FEATURE_TESTS_EXTRA is the complete list
> >  # of all feature tests
> > @@ -147,7 +148,8 @@ FEATURE_DISPLAY ?=              \
> >           lzma                   \
> >           bpf                   \
> >           libaio                        \
> > -         libzstd
> > +         libzstd               \
> > +         libopenssl
> >
> >  #
> >  # Declare group members of a feature to display the logical OR of the detection
> > diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> > index 7c90e0d0157ac9b1..3fd5ad0db2109778 100644
> > --- a/tools/build/feature/Makefile
> > +++ b/tools/build/feature/Makefile
> > @@ -67,12 +67,13 @@ FILES=                                          \
> >           test-libopencsd.bin                   \
> >           test-clang.bin                                \
> >           test-llvm.bin                         \
> > -         test-llvm-perf.bin   \
> > +         test-llvm-perf.bin                    \
> >           test-libaio.bin                       \
> >           test-libzstd.bin                      \
> >           test-clang-bpf-co-re.bin              \
> >           test-file-handle.bin                  \
> > -         test-libpfm4.bin
> > +         test-libpfm4.bin                      \
> > +         test-libopenssl.bin
> >
> >  FILES := $(addprefix $(OUTPUT),$(FILES))
> >
> > @@ -381,6 +382,9 @@ endif
> >  $(OUTPUT)test-libpfm4.bin:
> >         $(BUILD) -lpfm
> >
> > +$(OUTPUT)test-libopenssl.bin:
> > +       $(BUILD) -lssl
> > +
> >  $(OUTPUT)test-bpftool-skeletons.bin:
> >         $(SYSTEM_BPFTOOL) version | grep '^features:.*skeletons' \
> >                 > $(@:.bin=.make.output) 2>&1
> > diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
> > index eb346160d0ba0e2f..1488bf6e607836e5 100644
> > --- a/tools/build/feature/test-all.c
> > +++ b/tools/build/feature/test-all.c
> > @@ -142,6 +142,10 @@
> >  # include "test-libtraceevent.c"
> >  #undef main
> >
> > +#define main main_test_libopenssl
> > +# include "test-libopenssl.c"
> > +#undef main
> > +
> >  int main(int argc, char *argv[])
> >  {
> >         main_test_libpython();
> > @@ -173,6 +177,7 @@ int main(int argc, char *argv[])
> >         main_test_reallocarray();
> >         main_test_libzstd();
> >         main_test_libtraceevent();
> > +       main_test_libopenssl();
> >
> >         return 0;
> >  }
> > diff --git a/tools/build/feature/test-libopenssl.c b/tools/build/feature/test-libopenssl.c
> > new file mode 100644
> > index 0000000000000000..168c45894e8be687
> > --- /dev/null
> > +++ b/tools/build/feature/test-libopenssl.c
> > @@ -0,0 +1,7 @@
> > +#include <openssl/ssl.h>
> > +#include <openssl/opensslv.h>
> > +
> > +int main(void)
> > +{
> > +       return SSL_library_init();
> > +}
> > --
> > 2.52.0.177.g9f829587af-goog
> >

