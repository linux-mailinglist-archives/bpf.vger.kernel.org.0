Return-Path: <bpf+bounces-53926-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C180A5E643
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 22:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AAF47AE944
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 21:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4BC1EF0B5;
	Wed, 12 Mar 2025 21:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cM4ooXJ9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B677D1EE005
	for <bpf@vger.kernel.org>; Wed, 12 Mar 2025 21:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741813485; cv=none; b=as6HWs666z2cEUrSoNHe/FxXf+9ZO53bTSSlii/rjQPsK8Ps2n40Xv7jCrx/ftn9CJ4GnR/whzeWYBHVKr5D6pVPa7MvuRjc8gwoNfP4GliL/gVvmn6wuy6nTW3v+NI9Yvj7U9qs8SbISYn6VrU4uvLd9Ob7C/caXklxj9uoOas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741813485; c=relaxed/simple;
	bh=Ot0S7PtwawZf3AV7XLRs4qgCTdhjXmhj0iYA5pT0WQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a7yZDkBTHewZw8j8Ow5MeavDPZfeu2/wF23KM/Sl438xLjniWr/FXf0iposcKppIS0SW/OdST2fNj3alkd0rjJJZjLySwBlNmmpfkxMGEfriVanpGgvavwNx/r2c6ksXAFBixifAs9L2Tdp/hBYP9UHo7pPXHsmvNl9TWgtKJmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cM4ooXJ9; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2242ac37caeso11685ad.1
        for <bpf@vger.kernel.org>; Wed, 12 Mar 2025 14:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741813482; x=1742418282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/NYFOGJx3+utedM/+JCynhnYYN1+cS/l3CV1O7uUWI=;
        b=cM4ooXJ9gvYqcJ/XrO6LDQ3KryrwmSBO1HyUvcZS61JWEZNzhzULnonecB9KSUu31i
         rMKlff2mt81hRppWsSvFJ4YECBAFk1AZmv91vFSgM+fzJIiTmeHE2Y/10xyCP5mDXlLO
         C37hhbNgGfJym/1xtFRgBwc7iDEG/+klFVmQonEjdaOlHtcl6rm9qnlyjXnY+R6iiUYU
         U4xFZQnE268Bytlt5qCcCAZExmlhFAcLC4uxh9GHzQJJtKKeQ9Lh642xRaj0BEvlg5FW
         mES+4ayvZi76ZtkOK6weW7hRsQT+BTxmeYkqfAvqQug9JmtFNZOyuWDOrOhKNNY+RzBn
         QeJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741813482; x=1742418282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y/NYFOGJx3+utedM/+JCynhnYYN1+cS/l3CV1O7uUWI=;
        b=iR9uL3eUDGvl3ThNVAboP9UwtblzcUeRu+vEYilYn3unU/7Wy7HXSBJztTklWMosS/
         okS3fMnz/vu2za2qLWCyltMop7T9606+benKVNzXqYdK9VyJBA//1dJAyBRlHdVHczs/
         1fUXDIKO65HoGkoIQLm0p3yQxfeqXpjAN7NMmGyzytJjQiRkSDVL3qsqGmOwLoO0SuG/
         2fkFy+vHiCSgZEFxiyjNBMJvJEJfiPtLKH8nPEZn/OMC8C68S1B1xgzrdaY++6+7pdQS
         4/MfveFL9tA4NCVkMsW8eeXFX9LEXTSyoXkjmi/SM0kTeEz7UH9kzFfBQWWJFD04Uln3
         7mgg==
X-Forwarded-Encrypted: i=1; AJvYcCW1QAsMSgf7b1FvI/T79S1r9NRrvPkIEctgIbh+hHW3t7bYenxjIDx2f9EaMZghx0ynNlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBSzM4qCttqjWV3xvjObGeZeYwiBJkoQ1qEqT5xTFvdGSRPM5I
	kbnmCPv3ury2WjXeyiWcSYxfmKYRGa+odTgGwWO8ISMRJWLPkKtzCAL+goihcci+CslRH5xTzZ8
	DfhD0W4OcQAON9nB/AP8t/Ofg6ulrEnD62sA2
X-Gm-Gg: ASbGnctP1KlYttUNtK46vrhY1oWS+vwMqzx51CCMhr5FeuWyN00YrZM0YZB8Ro4CpLK
	igvH0qGd1sakdBOCKLdCLVg7cGWcTDICqErVmQyZLR//cXqYxg13b8jpajIR+1aRXXbYQl2kZKo
	wSxNSB2jJ12p6PpjuHdUmvh8IAnpHhIvLwgci4sEE92XAn0nuz8mMWBWc=
X-Google-Smtp-Source: AGHT+IG2QAgZZb2P1DnYtlbmBhHsH8IbYPaNLVy98uYUpBgu/L7LIECGJjf1D4pL5sBwMndKUFhgflstMybnPkqFZnA=
X-Received: by 2002:a17:903:2311:b0:216:21cb:2e14 with SMTP id
 d9443c01a7336-225c5b9ad33mr436225ad.21.1741813481661; Wed, 12 Mar 2025
 14:04:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122062332.577009-1-irogers@google.com> <Z5K712McgLXkN6aR@google.com>
 <CAP-5=fX2n4nCTcSXY9+jU--X010hS9Q-chBWcwEyDzEV05D=FQ@mail.gmail.com> <CAP-5=fUHLP-vtktodVuvMEbOd+TfQPPndkajT=WNf3Mc4VEZaA@mail.gmail.com>
In-Reply-To: <CAP-5=fUHLP-vtktodVuvMEbOd+TfQPPndkajT=WNf3Mc4VEZaA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 12 Mar 2025 14:04:30 -0700
X-Gm-Features: AQ5f1Jrj8FttoWaX-jdga6H02EOp221HMf8mceTcXqVwlpfEOeFP0rT3a1IwFQk
Message-ID: <CAP-5=fV_z+Ev=wDt+QDwx8GTNXNQH30H5KXzaUXQBOG1Mb8hJg@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] Support dynamic opening of capstone/llvm remove BUILD_NONDISTRO
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Aditya Gupta <adityag@linux.ibm.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Changbin Du <changbin.du@huawei.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Li Huafei <lihuafei1@huawei.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andi Kleen <ak@linux.intel.com>, Chaitanya S Prakash <chaitanyas.prakash@arm.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, Song Liu <song@kernel.org>, bpf@vger.kernel.org, 
	Daniel Xu <dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 10:06=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Thu, Jan 23, 2025 at 3:36=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> > On Thu, Jan 23, 2025 at 1:59=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > > I like changes up to this in general.  Let me take a look at the
> > > patches.
>
> So it would be nice to make progress with this series given some level
> of happiness, I don't see any actions currently on the patch series as
> is. If I may be so bold as to recap the issues that have come up:
>
> 1) Andi Kleen mentions that dlopen is inferior to linking against
> libraries and those libraries aren't a memory overhead if unused.
>
> I agree but pointed-out the data center use case means that saving
> size on binaries can be important to some (me). We've also been trying
> to reduce perf's dependencies for distributions as perf dragging in
> say the whole of libLLVM can be annoying for making minimal
> distributions that contain perf. Perhaps somebody (Arnaldo?) more
> involved with distributions can confirm or deny the distribution
> problem, I'm hoping it is self-evident.
>
> 2) Namhyung Kim was uncomfortable with the code defining
> types/constants that were in header files as the two may drift over
> time
>
> I agree but in the same way as a function name is an ABI for dlysym,
> the types/constants are too. Yes a header file may change, but in
> doing so the ABI has changed and so it would be an incompatible change
> and everything would be broken. We'd need to fix the code for this,
> say as we did when libbpf moved to version 1.0, but using a header
> file would only weakly guard against this problem. The problem with
> including the header files is that then the build either breaks
> without the header or we need to support a no linking against a
> library and not using dlopen case. I suspect a lot of distributions
> wouldn't understand the build subtlety in this, the necessary build
> options and things installed, and we'd end up not using things like
> libLLVM even when it is known to be a large performance win. I also
> hope one day we can move from parsing text out of forked commands, as
> it is slower and more brittle, to just directly using libraries.
> Making dlopen the fallback (probably with a warning on failure) seems
> like the right direction for this except we won't get it if we need to
> drag in extra dependency header files for the build to succeed (well
> we could have a no library or dlopen option, but then we'd probably
> find distributions packaging this and things like perf annotate
> getting broken as they don't even know how to dlopen a library).
>
> 3) Namhyung Kim (and I) also raises that the libcapstone patch can be
> smaller by dropping the print_capstone_detail support on x86
>
> Note, given the similarity between capstone and libLLVM for
> disassembly, it is curious that only capstone gives the extra detail.
>
> I agree. Given the capstone disassembly output will be compromised we
> should warn for this, probably in Makefile.config to avoid running
> afoul of -Werror. It isn't clear that having a warning is a good move
> given the handful of structs needed to support print_capstone_detail.
> I'd prefer to keep the structs so that we haven't got a warning that
> looks like it needs cleaning up.
>
> 4) Namhyung Kim raised concerns over #if placement
>
> Namhyung raised that he'd prefer:
> ```
> #if HAVE_LIBCAPSTONE_SUPPORT
> // lots of code
> #else
> // lots of code
> #endif
> ```
> rather than the #ifs being inside or around individual functions. I
> raised that the large #ifs is a problem in the current code as you
> lose context when trying to understand a function. You may look at a
> function but not realize it isn't being used because of a #if 10s or
> 100s of lines above. Namhyung raised that the large #ifs is closer to
> kernel style, I disagreed as I think kernel style is only doing this
> when it stubs out a bunch of API functions, not when more context
> would be useful. Hopefully as the person writing the patches the style
> choice I've made can be respected.
>
> 5) Daniel Xu raised issues with the removal of libbfd for Rust
> support, as the code implies libbfd C++ demangling is a pre-requisite
> of legacy rust symbol demangling
>
> A separate patch was posted adding Rust v0 symbol demangling with no
> libbfd dependency:
> https://lore.kernel.org/lkml/20250129193037.573431-1-irogers@google.com/
> The legacy support should work with the non-libbfd demanglers as
> that's what we have today. We should really clean up Rust demangling
> and have tests. This is blocked on the Rust community responding to:
> https://github.com/rust-lang/rust/issues/60705

Ping.

Thanks,
Ian

