Return-Path: <bpf+bounces-76095-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC94CA5B74
	for <lists+bpf@lfdr.de>; Fri, 05 Dec 2025 00:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 199AC31209AD
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 23:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9DE2DC77D;
	Thu,  4 Dec 2025 23:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJosdkqV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C3B158535;
	Thu,  4 Dec 2025 23:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764892348; cv=none; b=UsRkrurSJ6RFZv7nHPpb4Z1+6XZ3RQuBWkQWZA0JbiR26dt+FlMiDsk9oRi8DStN03nA5eklGMgE1B7ul5Q2El/IMjqEi0w2QA6LS4NTPpoxI274GBH5K11n7202Kse2h07d7svdv/dj4GWoOgFpqZJUEKPmvvciGi6cwc1e+T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764892348; c=relaxed/simple;
	bh=1D+F7dPoHEcSFSabTbVyWSbchGothNwsY8rGrFi0P3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxI9K7LtH+0bchKf6pyWud0FuoOj7KRamLR62dMQngXxNH8NPsgAOmT9U6figTVaPVRyL+83Zm+BLBcsY2kxKbLyQ3VXNEKoQ5xTi7/schMufnxL3I28MN3kwhmZAZSlc5e6dUW0s1tleIMjXuQo+Ljltb+J/Dsg9xW+0sHv/iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJosdkqV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B1E5C4CEFB;
	Thu,  4 Dec 2025 23:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764892347;
	bh=1D+F7dPoHEcSFSabTbVyWSbchGothNwsY8rGrFi0P3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bJosdkqVjnHffBHKojHQx2pF3WGdPAvFV3sjzjIdhAjx09CO745DvXhGsz+tMqdf8
	 d6kwcxPmFcpMOxRH8K66YSH8KTtDApj3yRSX056iniIobRrl0gWzuIP2gZ993VR3b9
	 ikFO2KcyAEuHRSK9whrA1b1XRZ1e2YSYe2tpypak//YDOs7HOLvrW5udT/4O1pG6Q+
	 kzKxe33lfXaP8nCTqNM+ZH2Tb/JqfW8N4EOewZ3Q34Qk6O+VmVzFPaseBkUyPNw33B
	 EhJD+3OMnMgdWG20vyJPkabOrDenOYbcDFWAe9unsr+YnQ1IRVh+IvBcWMOC3EJaD3
	 tquWotKUFb/5A==
Date: Thu, 4 Dec 2025 15:52:24 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Quentin Monnet <qmo@kernel.org>,
	bpf@vger.kernel.org, James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/2] tools/build: Add a feature test for libopenssl
Message-ID: <aTIeuLOcc6c7RWUz@google.com>
References: <20251203232924.1119206-1-namhyung@kernel.org>
 <CAP-5=fU=G75jpsG-X6pa8_rdKapxVc615CqvcdSPBFesj02D6A@mail.gmail.com>
 <aTGz9kFQk2xNvsbC@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aTGz9kFQk2xNvsbC@x1>

On Thu, Dec 04, 2025 at 01:16:54PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Dec 03, 2025 at 04:34:56PM -0800, Ian Rogers wrote:
> > On Wed, Dec 3, 2025 at 3:29 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > >
> > > It's used by bpftool and the kernel build.  Let's add a feature test so
> > > that perf can decide what to do based on the availability.
> > 
> > It seems strange to add a feature test that bpftool is missing and
> > then use it only in the perf build. The signing of bpf programs isn't
> 
> It is strange indeed, I agree that since we don't use BPF signing at
> this point in the perf BPf skels, then we could just bootstrap a bpftool
> without such feature and continue building the existing features.
> 
> Adding the bpftool maintainer to the CC list, Quentin?

I've already talked to Quentin and they want libopenssl as a
requirement.

https://lore.kernel.org/linux-perf-users/e44f70bf-8f50-4a4b-97b8-eaf988aabced@kernel.org/

Thanks,
Namhyung


> > something I think we need for skeleton support in perf. I like the
> > feature test, could we add it and use it in bpftool? The only two
> > functions using openssl appear to be:
> > 
> >   __u32 register_session_key(const char *key_der_path)
> >   int bpftool_prog_sign(struct bpf_load_and_run_opts *opts)
> > 
> > so we can do the whole feature test then #ifdef HAVE_FEATURE... stub
> > static inline versions of the functions game?
> > 
> > Perhaps we only need the bootstrap version of bpftool in perf and we
> > can just avoid dependencies that way. Looking at bpftool's build I see
> > that sign.o/c with those functions in is part of the bootstrap version
> > of bpftool :-(
> > 
> > Thanks,
> > Ian
> > 
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >  tools/build/Makefile.feature          | 6 ++++--
> > >  tools/build/feature/Makefile          | 8 ++++++--
> > >  tools/build/feature/test-all.c        | 5 +++++
> > >  tools/build/feature/test-libopenssl.c | 7 +++++++
> > >  4 files changed, 22 insertions(+), 4 deletions(-)
> > >  create mode 100644 tools/build/feature/test-libopenssl.c
> > >
> > > diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> > > index fc6abe369f7373c5..bc6d85bad379321b 100644
> > > --- a/tools/build/Makefile.feature
> > > +++ b/tools/build/Makefile.feature
> > > @@ -99,7 +99,8 @@ FEATURE_TESTS_BASIC :=                  \
> > >          libzstd                                \
> > >          disassembler-four-args         \
> > >          disassembler-init-styled       \
> > > -        file-handle
> > > +        file-handle                    \
> > > +        libopenssl
> > >
> > >  # FEATURE_TESTS_BASIC + FEATURE_TESTS_EXTRA is the complete list
> > >  # of all feature tests
> > > @@ -147,7 +148,8 @@ FEATURE_DISPLAY ?=              \
> > >           lzma                   \
> > >           bpf                   \
> > >           libaio                        \
> > > -         libzstd
> > > +         libzstd               \
> > > +         libopenssl
> > >
> > >  #
> > >  # Declare group members of a feature to display the logical OR of the detection
> > > diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> > > index 7c90e0d0157ac9b1..3fd5ad0db2109778 100644
> > > --- a/tools/build/feature/Makefile
> > > +++ b/tools/build/feature/Makefile
> > > @@ -67,12 +67,13 @@ FILES=                                          \
> > >           test-libopencsd.bin                   \
> > >           test-clang.bin                                \
> > >           test-llvm.bin                         \
> > > -         test-llvm-perf.bin   \
> > > +         test-llvm-perf.bin                    \
> > >           test-libaio.bin                       \
> > >           test-libzstd.bin                      \
> > >           test-clang-bpf-co-re.bin              \
> > >           test-file-handle.bin                  \
> > > -         test-libpfm4.bin
> > > +         test-libpfm4.bin                      \
> > > +         test-libopenssl.bin
> > >
> > >  FILES := $(addprefix $(OUTPUT),$(FILES))
> > >
> > > @@ -381,6 +382,9 @@ endif
> > >  $(OUTPUT)test-libpfm4.bin:
> > >         $(BUILD) -lpfm
> > >
> > > +$(OUTPUT)test-libopenssl.bin:
> > > +       $(BUILD) -lssl
> > > +
> > >  $(OUTPUT)test-bpftool-skeletons.bin:
> > >         $(SYSTEM_BPFTOOL) version | grep '^features:.*skeletons' \
> > >                 > $(@:.bin=.make.output) 2>&1
> > > diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
> > > index eb346160d0ba0e2f..1488bf6e607836e5 100644
> > > --- a/tools/build/feature/test-all.c
> > > +++ b/tools/build/feature/test-all.c
> > > @@ -142,6 +142,10 @@
> > >  # include "test-libtraceevent.c"
> > >  #undef main
> > >
> > > +#define main main_test_libopenssl
> > > +# include "test-libopenssl.c"
> > > +#undef main
> > > +
> > >  int main(int argc, char *argv[])
> > >  {
> > >         main_test_libpython();
> > > @@ -173,6 +177,7 @@ int main(int argc, char *argv[])
> > >         main_test_reallocarray();
> > >         main_test_libzstd();
> > >         main_test_libtraceevent();
> > > +       main_test_libopenssl();
> > >
> > >         return 0;
> > >  }
> > > diff --git a/tools/build/feature/test-libopenssl.c b/tools/build/feature/test-libopenssl.c
> > > new file mode 100644
> > > index 0000000000000000..168c45894e8be687
> > > --- /dev/null
> > > +++ b/tools/build/feature/test-libopenssl.c
> > > @@ -0,0 +1,7 @@
> > > +#include <openssl/ssl.h>
> > > +#include <openssl/opensslv.h>
> > > +
> > > +int main(void)
> > > +{
> > > +       return SSL_library_init();
> > > +}
> > > --
> > > 2.52.0.177.g9f829587af-goog
> > >

