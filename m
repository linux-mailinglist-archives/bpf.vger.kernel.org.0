Return-Path: <bpf+bounces-42576-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCA39A5CE6
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 09:27:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AD5E1C21AE6
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 07:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AF41D14FD;
	Mon, 21 Oct 2024 07:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2Pbv+jw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494081D1736
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 07:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729495605; cv=none; b=SKzL6qcvDBSZ3YSCHmWVuzky4qEIt1CkX3bnrVeQeEO+fCEJ7kZGchzj1PSx8aAcMmn9K1itj+JCeYEkNrlLMct1/ZMttrY/Dnul1icqNpuZqVgyMNHrUNSM/zKDkodjmWB+ypSRj0fup9Z3Vv4yxLDQ3ELxk1yBHUuwC9p4fAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729495605; c=relaxed/simple;
	bh=H7/V+Ml1wTwtBZghI6BAWBrvKifImuJstGiFDeFvj2Q=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lEAfSGc/vqAqpaiiGZAdsHgWvQ2m3BnkNITpDQU5aFgGasMwprUCYbiXVs7XtpD3TuSTW81lB0cHcUq+pit0uRVhtbilNcc6k65tKtiwU39vAlNIE2R7xFAL7sDHl8CLMwhIfmKi/ekEEg5zMj+htD122M5EGEzAKg93E91F8/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2Pbv+jw; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4314f38d274so56807345e9.1
        for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 00:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729495601; x=1730100401; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oDWAGhYviO0vGlwua9x6jvK+W84LboMQpPDQC53yptk=;
        b=M2Pbv+jw07w2Rq4gV9YEfFl0dzYN9hoUWygqpwAFctZnBrYjbtWKrp2H91NOSDQBLy
         inz4UeK1MAnsgXUu+/f2Q0tcQqeow2YFk3zOvYnhbu5TipDCCsU06+wUo8ZxqyWy1Q/Y
         USXlsxr5cRKK/yVEO4j0stWBU3itgRp9fmoMyQZxujxFjduy0TfOUfTs49PRh8TrTyrZ
         TmKCcaGGTDrHGQtEBoUNVIAEqE4V9qkr2e3vWKYseSRXTOf9SYihTPZaTHqpxPdkS8XK
         CW4VnCavVk0iFI3F53NSRmZzbj9yxGSon/u2+RJZVHqO+oEMXtSAtWex/GRBjrSwkEfh
         CqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729495601; x=1730100401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDWAGhYviO0vGlwua9x6jvK+W84LboMQpPDQC53yptk=;
        b=QCpfIcamgay/X4cjyQkv93lnY/Yg0nph+PBkHMvEsfPkBSmzoXXH2nBJUZUJ+8AybT
         xSlwaZiE+0aDToTGqvCg1I5S+bqtJPCZ5kCjrjYNnHWdGX0vRwVP5Wle2Xu9V9nj83hF
         QVIya3/mElTMToPCj721BleibZzi2z5DF0s1FcgXEj50RQt1M+b+rPJtBT5AC8ZK9JCC
         2QXvHTGXctGg+NS8j8DaIm+krhVOdLBhM++D5uKpmXWz8XJ+eNWDnnRrrc2NL9/euXcB
         97tH+qdIsVR7j0sVHGTbHcspXGAmdHZgA+hIxyvtKSntYE+c3KFvO5kE6h+kg4dIFgV5
         m4Dw==
X-Forwarded-Encrypted: i=1; AJvYcCVnNWmIvajk23AxnD7nwkIbYIGJb3oXY/6JgnlB70QIfHpgHY51vrsKP4KVziO6nSbRuNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmBeQPnGTpX4z9BLgRbkAgu7uMbZyIh0XOw8bFYY6xY51m3GTS
	i9D4d6ggzHieGujP83tsLWwrJPIphNAXsL0oOvxLJIiKuBa6ZQ9I
X-Google-Smtp-Source: AGHT+IE7sigcvzlfJom5iHWndy/0udEOwHORIuYlHS6ZYhgb0OZssrdBwob7XWdqIjl1YO6RbkWY+w==
X-Received: by 2002:a5d:6550:0:b0:37d:43d4:88b7 with SMTP id ffacd0b85a97d-37ea21c3cedmr8496655f8f.3.1729495601202;
        Mon, 21 Oct 2024 00:26:41 -0700 (PDT)
Received: from krava (85-193-35-184.rib.o2.cz. [85.193.35.184])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a913704d2sm169807366b.119.2024.10.21.00.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 00:26:40 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 21 Oct 2024 09:26:37 +0200
To: Viktor Malik <vmalik@redhat.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: Disable warnings on
 unused flags for Clang builds
Message-ID: <ZxYCLTI0fhDIavBx@krava>
References: <cover.1729233447.git.vmalik@redhat.com>
 <370c84ee3a0e8627a09d89fff12f7a285565fb46.1729233447.git.vmalik@redhat.com>
 <ZxU86eN6kMrgmuaV@krava>
 <a05967e6-851f-4db8-9ec4-b910acaaf70f@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a05967e6-851f-4db8-9ec4-b910acaaf70f@redhat.com>

On Mon, Oct 21, 2024 at 08:20:39AM +0200, Viktor Malik wrote:
> On 10/20/24 19:24, Jiri Olsa wrote:
> > On Fri, Oct 18, 2024 at 08:49:01AM +0200, Viktor Malik wrote:
> >> There exist compiler flags supported by GCC but not supported by Clang
> >> (e.g. -specs=...). Currently, these cannot be passed to BPF selftests
> >> builds, even when building with GCC, as some binaries (urandom_read and
> >> liburandom_read.so) are always built with Clang and the unsupported
> >> flags make the compilation fail (as -Werror is turned on).
> >>
> >> Add -Wno-unused-command-line-argument to these rules to suppress such
> >> errors.
> >>
> >> This allows to do things like:
> >>
> >>     $ CFLAGS="-specs=/usr/lib/rpm/redhat/redhat-hardened-cc1" \
> >>       make -C tools/testing/selftests/bpf
> > 
> > hi,
> > might be my fedora setup, but this example gives me compile error below
> > even with the patch applied:
> > 
> >   EXT-OBJ  [test_progs] testing_helpers.o
> > In file included from testing_helpers.c:10:
> > disasm.h:11:10: fatal error: linux/stringify.h: No such file or directory
> >    11 | #include <linux/stringify.h>
> >       |          ^~~~~~~~~~~~~~~~~~~
> 
> Aren't you doing `make CFLAGS="..."` instead of `CFLAGS="..." make`? The
> difference is that the former overrides CFLAGS defined in selftests
> Makefile and therefore the include dirs are not correctly added.

right, I was doing that, thanks

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
> > 
> > jirka
> > 
> >>
> >> Without this patch, the compilation would fail with:
> >>
> >>     [...]
> >>     clang: error: argument unused during compilation: '-specs=/usr/lib/rpm/redhat/redhat-hardened-cc1' [-Werror,-Wunused-command-line-argument]
> >>     make: *** [Makefile:273: /bpf-next/tools/testing/selftests/bpf/liburandom_read.so] Error 1
> >>     [...]
> >>
> >> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> >> ---
> >>  tools/testing/selftests/bpf/Makefile | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> >> index 1fc7c38e56b5..3da1a61968b7 100644
> >> --- a/tools/testing/selftests/bpf/Makefile
> >> +++ b/tools/testing/selftests/bpf/Makefile
> >> @@ -273,6 +273,7 @@ $(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c liburandom
> >>  	$(Q)$(CLANG) $(CLANG_TARGET_ARCH) \
> >>  		     $(filter-out -static,$(CFLAGS) $(LDFLAGS)) \
> >>  		     $(filter %.c,$^) $(filter-out -static,$(LDLIBS)) \
> >> +		     -Wno-unused-command-line-argument \
> >>  		     -fuse-ld=$(LLD) -Wl,-znoseparate-code -Wl,--build-id=sha1 \
> >>  		     -Wl,--version-script=liburandom_read.map \
> >>  		     -fPIC -shared -o $@
> >> @@ -281,6 +282,7 @@ $(OUTPUT)/urandom_read: urandom_read.c urandom_read_aux.c $(OUTPUT)/liburandom_r
> >>  	$(call msg,BINARY,,$@)
> >>  	$(Q)$(CLANG) $(CLANG_TARGET_ARCH) \
> >>  		     $(filter-out -static,$(CFLAGS) $(LDFLAGS)) $(filter %.c,$^) \
> >> +		     -Wno-unused-command-line-argument \
> >>  		     -lurandom_read $(filter-out -static,$(LDLIBS)) -L$(OUTPUT) \
> >>  		     -fuse-ld=$(LLD) -Wl,-znoseparate-code -Wl,--build-id=sha1 \
> >>  		     -Wl,-rpath=. -o $@
> >> -- 
> >> 2.47.0
> >>
> > 
> 

