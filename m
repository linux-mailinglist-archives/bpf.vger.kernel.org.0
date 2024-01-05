Return-Path: <bpf+bounces-19125-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A30825643
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 16:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3CAC281295
	for <lists+bpf@lfdr.de>; Fri,  5 Jan 2024 15:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2C62E3F3;
	Fri,  5 Jan 2024 15:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9Vp3fQb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7AF2DF87
	for <bpf@vger.kernel.org>; Fri,  5 Jan 2024 15:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55692ad81e3so1831877a12.1
        for <bpf@vger.kernel.org>; Fri, 05 Jan 2024 07:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704466899; x=1705071699; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s93w6c9lejCAACKBzXsviPSdy6Rf5GyqrNGTM64w9dk=;
        b=X9Vp3fQbzgkJDR9DvtGzC3TZ9HlwjNguOa3ecxPvjjeggekb+lJpuBQ1xhL6soMlTL
         fPqgjOQEw2TAVX+xrMlUICfKdCp6KgN7MGlvEXjxChM7ydscYD9nhIQr4YIbd1cZaL2O
         /tJrFslG5Z4nGbhhjm2QXRij3sNG7UA5cAlewaw31BDSnHrMk38+UGLdkbVbhnbFEb0a
         UibZo5dD7LJG8g73rIEWH+LUIuQr4KKcEZsQaHD/2QQX3iDX3OjF8zlvpG79UKu92hTl
         ZLfViYdu+vGWrsUL3cfNywpwxn9AW+pqO+MI7r436nZHl73bmk03Kh2AIGpUcDWMeEvg
         RCHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704466899; x=1705071699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s93w6c9lejCAACKBzXsviPSdy6Rf5GyqrNGTM64w9dk=;
        b=l4vli0wrNkFUNfAJhK4FclMITx8iR7YG6DGtTyB/u3aNU95DrUobJVL0Nq1mlZ9wRc
         Fja2PRxAVNxnqRCTCsLxnanZFD6voTEG7k206EIHYjPQNd+SInGlc0h+oNFYKCyLwlyH
         z2VUn9I+CF538ZeZVrO4Tod/+e4MSf3ELTkI1jhUfmMXqCeYKEogC301m+qvZCScn5gd
         BkSJffwv10WLf7eZ4qNy60p7oAeXl/F5PTiSTDqwLMBCtsnYVf7WKE7ayspT0Kxp6Buj
         BD31eN0ddwNDSrtJA35VEv1EBWVT8tTfNyKCVypCwGyIL/2cs2qtHQNrJ/3MS00HbrLp
         FMiA==
X-Gm-Message-State: AOJu0YxO+uZtcU5H2/UBtKnoQ9vyP9y5CeLNWiMGTLeh/3imGC9O3R7X
	/eVRb7JkJtgU7sDnboJNtV5jxHRguDw=
X-Google-Smtp-Source: AGHT+IH4qQ2U1Bxw/+wUzwXANFtPw4fiyRw5QCN2+MjgM7oJO0k9+aiQ1OFCGh0WvQzXgQjR/wjzqQ==
X-Received: by 2002:a17:907:c9a5:b0:a22:ebf2:1edc with SMTP id uj37-20020a170907c9a500b00a22ebf21edcmr933472ejc.16.1704466899038;
        Fri, 05 Jan 2024 07:01:39 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id z11-20020a17090665cb00b00a26f6be432asm956336ejn.70.2024.01.05.07.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 07:01:38 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 5 Jan 2024 16:01:37 +0100
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Quentin Monnet <quentin@isovalent.com>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org
Subject: Re: [PATCH] bpftool: Add missing libgen.h for basename()
Message-ID: <ZZgZ0cxEa7HvSUF6@krava>
References: <ZZYgMYmb_qE94PUB@kernel.org>
 <ZZZ7hgqlYjNJOynA@krava>
 <ZZakH8LluKodXql-@kernel.org>
 <ZZasL_pO09Zt3R4e@kernel.org>
 <ZZfCX7tcM0RnuHJT@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZfCX7tcM0RnuHJT@krava>

On Fri, Jan 05, 2024 at 09:48:31AM +0100, Jiri Olsa wrote:
> On Thu, Jan 04, 2024 at 10:01:35AM -0300, Arnaldo Carvalho de Melo wrote:
> 
> SNIP
> 
> >    9    51.66 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-17) , clang version 11.1.0 (Amazon Linux 2 11.1.0-1.amzn2.0.2) flex 2.5.37
> >   10    60.77 amazonlinux:2023              : Ok   gcc (GCC) 11.4.1 20230605 (Red Hat 11.4.1-2) , clang version 15.0.7 (Amazon Linux 15.0.7-3.amzn2023.0.1) flex 2.6.4
> >   11    61.29 amazonlinux:devel             : Ok   gcc (GCC) 11.3.1 20221121 (Red Hat 11.3.1-4) , clang version 15.0.6 (Amazon Linux 15.0.6-3.amzn2023.0.2) flex 2.6.4
> >   12    74.72 archlinux:base                : Ok   gcc (GCC) 13.2.1 20230801 , clang version 16.0.6 flex 2.6.4
> > 
> > / $ grep -B8 -A2 -w basename /usr/include/string.h
> > #ifdef _GNU_SOURCE
> > #define	strdupa(x)	strcpy(alloca(strlen(x)+1),x)
> > int strverscmp (const char *, const char *);
> > char *strchrnul(const char *, int);
> > char *strcasestr(const char *, const char *);
> > void *memrchr(const void *, int, size_t);
> > void *mempcpy(void *, const void *, size_t);
> > #ifndef __cplusplus
> > char *basename();
> > #endif
> > #endif
> > / $ cat /etc/os-release
> > NAME="Alpine Linux"
> > ID=alpine
> > VERSION_ID=3.19.0
> > PRETTY_NAME="Alpine Linux v3.19"
> > HOME_URL="https://alpinelinux.org/"
> > BUG_REPORT_URL="https://gitlab.alpinelinux.org/alpine/aports/-/issues"
> > / $
> > 
> > Weird, they had it and now removed the _GNU_SOURCE bits (edge is their
> > devel distro, like rawhide is for fedora, tumbleweed for opensuse, etc).
> 
> let's see, I asked them in here: https://gitlab.alpinelinux.org/alpine/aports/-/issues/15643

it got removed in musl libc recently:
  https://git.musl-libc.org/cgit/musl/commit/?id=725e17ed6dff4d0cd22487bb64470881e86a92e7

so perhaps switching to POSIX version of basename is the easiest way out?

jirka

