Return-Path: <bpf+bounces-76008-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0AECA20BD
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 01:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C7DD030133E6
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 00:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B548BEEC3;
	Thu,  4 Dec 2025 00:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h977q/0H"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4B427707
	for <bpf@vger.kernel.org>; Thu,  4 Dec 2025 00:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764808511; cv=none; b=X26vCXrdVz99bVu93jJdk+gCWh5T5TG/sw3qMQW0TIDlP8HQ2iahj4L8NnQTWDexXJXonABicc+H0CY0p9NyRLEOrLr8oTXxhbddAlGJtmD5i/2C3/KPPWXtZOX+NfG4VT/ZU/xIlvPj0hJQ+E7mODFqTGjNW5qFeaLaxy92q1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764808511; c=relaxed/simple;
	bh=qgzowlqvozrCdDlDBPM5DsRKNURP5c6NQbJd24LpgBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h4K7zzSQVQNHCS9nGZVQsRpaA9i6t7+XCXRoZ7L3yAqKzgrRliiWwTNRJElbxRGTK+qQL/iCd2bNe75j5rS+FGc6iT2zNJWWXsopP9UF33KzswzhgdmPD3dqxYa8OVuyJy0lyKI8gXMA6QQBO2c1zkrqNKv2b+mrlfZBZhjO1xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h977q/0H; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2980343d9d1so42525ad.1
        for <bpf@vger.kernel.org>; Wed, 03 Dec 2025 16:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764808509; x=1765413309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8NxXfPbmZpTpe7Ihl25p9otWD958rJ0JpuGnfn0nEk=;
        b=h977q/0Hj8CwutoQ/JMmOldqtg3TzK5WKTvxid5W8wfAjwMZ05GRg80Px/zWdy8Bk4
         NWHqGL0yFh/ofJBsOHBxiCjQElCD3iCSxkRxQ7Ibn0Y/qW/AjQ9NK+EOB6a7WwonlyJg
         lO9LMHGVC6a9QZjP/aj5lrLf0AvDnAaQw+j+i3f6CFQVNjpNAQ5YJ0jtpohAYUrf8ndK
         0qvi5gjSIQmDqRp/r+obs13RpeJCEDx7agumCw7GcX8YtdflQMuFshAK4D9p+1o69z6c
         NsN6xCbhK3mam/ooFk7odwRXrtCwEBp8+5FXYoPwJyfzWqZiaSeeazJBz9Q8snSmGjYC
         TXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764808509; x=1765413309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z8NxXfPbmZpTpe7Ihl25p9otWD958rJ0JpuGnfn0nEk=;
        b=DCLZdYGTPXULOAZGWPebaFYx35Jb/uZW1nInySV/UfSbFNKzGB0rOEQvIJ3PEB3eBA
         2fMvUE2+mLLDvh/Qah1q1Dt7YjSEAPxrQbRyxpKhbUAu8J3VMJ97EEeKk/BqhMyAllcg
         ULNB1ID9000TXoV6th5aKV5WXrlGms3s4MTYNNOc/GD5ms2VdvyU8SsoakeG7Ts/d0l2
         lkvtGb5aWuV3RppCvSHJAHVOQIBDmyjuTqNbBuERN5D+YPDSYqyqn4/9PLiFNAz0ZX1I
         +LDSSe0kybLwRhdhc2iqT3NXEcIG7nV4NlposUJU7dVmY/v3B7h/rMbxEmNaKFFRkFZm
         4chQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZdm42Y7YaLHHRi1NosTtdgzlrCZySdpdpXojaS1g4fq+d/EQW7f5RXFW7qfIhmb2APNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwiIBrPwxmEUPyWvPNQe3Palg8K2UB9VQvnruDNhOGNnLKfbMv
	y5uphDZztyrSZpzfCDK9Pblkd/eL+nmnMUuir6Qup1kaKln1OnmjSbChVoWLrFqdjL49F+pCZ8p
	e0ZYLEkS4sZIHShnFIMXI4YGALJkknc+8nRhvgFnG
X-Gm-Gg: ASbGnctombfow7/H+tWgftsuAyIV9lt+GrZARvDxs98xak16jZr0tWb+EotvT4oxObL
	ml5CJCWfSpCe5xF+3CMwrNk7bpyLnZKYrrRf2XQlpBGotxnEKTUv+GRm25vWHYQCjYAfRMxJzrp
	zD9EU41iW2k+xLAT0rlEFU12eMdx65AuNosfWDHc7YzR6HUj19uqCX9WOTWGI11vpRu68hYvLAa
	RW8Job4DU9hukff+Gc2eaG1n7bdy5ZGUIZ5m5kqZ/lRMgV4bKEnV1oJZ2vLuA0ldeN4gMDE
X-Google-Smtp-Source: AGHT+IGtuTwFiqEVUPuFXsWaToyH66kacw06+zovttbjLZvSFsLj2aUpbFICoYLoW+5DcEZ1+naYSFaxz6aLt8bJaPw=
X-Received: by 2002:a17:902:e551:b0:290:cd63:e922 with SMTP id
 d9443c01a7336-29dacc202f9mr615265ad.15.1764808508741; Wed, 03 Dec 2025
 16:35:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203232924.1119206-1-namhyung@kernel.org>
In-Reply-To: <20251203232924.1119206-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 3 Dec 2025 16:34:56 -0800
X-Gm-Features: AWmQ_blAzZW_jsMqIr61VwXVVoWBHwRZTdy5zFilIW7cQO8zIwuVd0klRVGDF00
Message-ID: <CAP-5=fU=G75jpsG-X6pa8_rdKapxVc615CqvcdSPBFesj02D6A@mail.gmail.com>
Subject: Re: [PATCH 1/2] tools/build: Add a feature test for libopenssl
To: Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 3:29=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> It's used by bpftool and the kernel build.  Let's add a feature test so
> that perf can decide what to do based on the availability.

It seems strange to add a feature test that bpftool is missing and
then use it only in the perf build. The signing of bpf programs isn't
something I think we need for skeleton support in perf. I like the
feature test, could we add it and use it in bpftool? The only two
functions using openssl appear to be:

  __u32 register_session_key(const char *key_der_path)
  int bpftool_prog_sign(struct bpf_load_and_run_opts *opts)

so we can do the whole feature test then #ifdef HAVE_FEATURE... stub
static inline versions of the functions game?

Perhaps we only need the bootstrap version of bpftool in perf and we
can just avoid dependencies that way. Looking at bpftool's build I see
that sign.o/c with those functions in is part of the bootstrap version
of bpftool :-(

Thanks,
Ian

> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/build/Makefile.feature          | 6 ++++--
>  tools/build/feature/Makefile          | 8 ++++++--
>  tools/build/feature/test-all.c        | 5 +++++
>  tools/build/feature/test-libopenssl.c | 7 +++++++
>  4 files changed, 22 insertions(+), 4 deletions(-)
>  create mode 100644 tools/build/feature/test-libopenssl.c
>
> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index fc6abe369f7373c5..bc6d85bad379321b 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -99,7 +99,8 @@ FEATURE_TESTS_BASIC :=3D                  \
>          libzstd                                \
>          disassembler-four-args         \
>          disassembler-init-styled       \
> -        file-handle
> +        file-handle                    \
> +        libopenssl
>
>  # FEATURE_TESTS_BASIC + FEATURE_TESTS_EXTRA is the complete list
>  # of all feature tests
> @@ -147,7 +148,8 @@ FEATURE_DISPLAY ?=3D              \
>           lzma                   \
>           bpf                   \
>           libaio                        \
> -         libzstd
> +         libzstd               \
> +         libopenssl
>
>  #
>  # Declare group members of a feature to display the logical OR of the de=
tection
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index 7c90e0d0157ac9b1..3fd5ad0db2109778 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -67,12 +67,13 @@ FILES=3D                                          \
>           test-libopencsd.bin                   \
>           test-clang.bin                                \
>           test-llvm.bin                         \
> -         test-llvm-perf.bin   \
> +         test-llvm-perf.bin                    \
>           test-libaio.bin                       \
>           test-libzstd.bin                      \
>           test-clang-bpf-co-re.bin              \
>           test-file-handle.bin                  \
> -         test-libpfm4.bin
> +         test-libpfm4.bin                      \
> +         test-libopenssl.bin
>
>  FILES :=3D $(addprefix $(OUTPUT),$(FILES))
>
> @@ -381,6 +382,9 @@ endif
>  $(OUTPUT)test-libpfm4.bin:
>         $(BUILD) -lpfm
>
> +$(OUTPUT)test-libopenssl.bin:
> +       $(BUILD) -lssl
> +
>  $(OUTPUT)test-bpftool-skeletons.bin:
>         $(SYSTEM_BPFTOOL) version | grep '^features:.*skeletons' \
>                 > $(@:.bin=3D.make.output) 2>&1
> diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-al=
l.c
> index eb346160d0ba0e2f..1488bf6e607836e5 100644
> --- a/tools/build/feature/test-all.c
> +++ b/tools/build/feature/test-all.c
> @@ -142,6 +142,10 @@
>  # include "test-libtraceevent.c"
>  #undef main
>
> +#define main main_test_libopenssl
> +# include "test-libopenssl.c"
> +#undef main
> +
>  int main(int argc, char *argv[])
>  {
>         main_test_libpython();
> @@ -173,6 +177,7 @@ int main(int argc, char *argv[])
>         main_test_reallocarray();
>         main_test_libzstd();
>         main_test_libtraceevent();
> +       main_test_libopenssl();
>
>         return 0;
>  }
> diff --git a/tools/build/feature/test-libopenssl.c b/tools/build/feature/=
test-libopenssl.c
> new file mode 100644
> index 0000000000000000..168c45894e8be687
> --- /dev/null
> +++ b/tools/build/feature/test-libopenssl.c
> @@ -0,0 +1,7 @@
> +#include <openssl/ssl.h>
> +#include <openssl/opensslv.h>
> +
> +int main(void)
> +{
> +       return SSL_library_init();
> +}
> --
> 2.52.0.177.g9f829587af-goog
>

