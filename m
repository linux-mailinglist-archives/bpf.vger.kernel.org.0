Return-Path: <bpf+bounces-19170-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64317826162
	for <lists+bpf@lfdr.de>; Sat,  6 Jan 2024 21:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06D49B217BF
	for <lists+bpf@lfdr.de>; Sat,  6 Jan 2024 20:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A7FF50A;
	Sat,  6 Jan 2024 20:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXRaft2m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F44F9CD
	for <bpf@vger.kernel.org>; Sat,  6 Jan 2024 20:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e3ffe57e1so6583215e9.3
        for <bpf@vger.kernel.org>; Sat, 06 Jan 2024 12:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704571351; x=1705176151; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m4ucArU9cuznTcHPDzsiBgFcT6TkEHCcUOZqH5fJZ4M=;
        b=jXRaft2mPKLc3JvkfqcbRNttR4wNlyWu9sOGtaWA+0myD7EMRV/9rZABVQOYFnbgyn
         EiFnGwgpw2xmO3f6UUdFi85nvjtUxmdP14IXMRm9T4hFRx7NHvF/JW1HPCmmpzvlAVKs
         v6mNyRJQBsu/QmUULJs9PGhFUZG9JTJECsFN7rtyYghBmnni7w+mk2O8FSM8gNmDPoN1
         Svso1/j7bkdOuSNmTA4zxg1t611KYhMXA5+MEPgi0paVjAJ8BbSWElDvLKmL9hE4hQhu
         yh0a8rTKRFzhaIrxi2UcxsGNirIYGMDjstj4ShXyfdhvGue1gbrb9L93Ch8eU+jDnLsf
         svnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704571351; x=1705176151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4ucArU9cuznTcHPDzsiBgFcT6TkEHCcUOZqH5fJZ4M=;
        b=gDBOj7wi+Cq3N7kgJEY8qjOQqt4Nta27BZg5Qgf3QPY/yrh85EJPJMBOeD+jfwLl4D
         MYSWq6mNGW8AfFXiZ3K1+wrW/+bSoMgnUteoyoMkPFNbc2lNDMcE1Ga+ZBVJWksl65e6
         mmlCchJU5BmLgL/ZQxyc55M4h/GLGYYmMdn1AZSDXkoTzQ9uAQjy1mEKZNiY9gGTZLkC
         +o5oP/fO5pRj4dlxnrRvZEygpc2yQ9ly3mKCyI4XRCbvb7qFQD6JCLeCbn7QwATz8qt5
         so4hd8pWTolL9cCNub6FbKbDGUBvVvq8e7RYmAKQX5j7/Xs8vWZR08E5gegOBbJKWEyd
         AdBQ==
X-Gm-Message-State: AOJu0YwxKCrOvEPtX9tH5VyhMnczNPskq4UFh6vwq29DeZIrfB/FtIBv
	OuZqDbbXbGO5TDA9uZjGkek=
X-Google-Smtp-Source: AGHT+IEvB3+gROWrn99DYBg32gOEhju4BOREQetPrQ7vXrQN+vP9FbDyFA3FvWI79hKiRAoyu0jHOQ==
X-Received: by 2002:a7b:ce8f:0:b0:40e:42b0:b75d with SMTP id q15-20020a7bce8f000000b0040e42b0b75dmr250840wmj.42.1704571351404;
        Sat, 06 Jan 2024 12:02:31 -0800 (PST)
Received: from krava ([83.240.62.111])
        by smtp.gmail.com with ESMTPSA id k25-20020a05600c1c9900b0040d87b9eec7sm5586864wms.32.2024.01.06.12.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 12:02:30 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 6 Jan 2024 21:02:26 +0100
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Quentin Monnet <quentin@isovalent.com>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org
Subject: Re: [PATCH] bpftool: Add missing libgen.h for basename()
Message-ID: <ZZmx0rFDyIJxnPAi@krava>
References: <ZZYgMYmb_qE94PUB@kernel.org>
 <ZZZ7hgqlYjNJOynA@krava>
 <ZZakH8LluKodXql-@kernel.org>
 <ZZasL_pO09Zt3R4e@kernel.org>
 <ZZfCX7tcM0RnuHJT@krava>
 <ZZgZ0cxEa7HvSUF6@krava>
 <ZZhsPs00TI75RdAr@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZhsPs00TI75RdAr@kernel.org>

On Fri, Jan 05, 2024 at 05:53:18PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Jan 05, 2024 at 04:01:37PM +0100, Jiri Olsa escreveu:
> > On Fri, Jan 05, 2024 at 09:48:31AM +0100, Jiri Olsa wrote:
> > > On Thu, Jan 04, 2024 at 10:01:35AM -0300, Arnaldo Carvalho de Melo wrote:
> > > 
> > > SNIP
> > > 
> > > >    9    51.66 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-17) , clang version 11.1.0 (Amazon Linux 2 11.1.0-1.amzn2.0.2) flex 2.5.37
> > > >   10    60.77 amazonlinux:2023              : Ok   gcc (GCC) 11.4.1 20230605 (Red Hat 11.4.1-2) , clang version 15.0.7 (Amazon Linux 15.0.7-3.amzn2023.0.1) flex 2.6.4
> > > >   11    61.29 amazonlinux:devel             : Ok   gcc (GCC) 11.3.1 20221121 (Red Hat 11.3.1-4) , clang version 15.0.6 (Amazon Linux 15.0.6-3.amzn2023.0.2) flex 2.6.4
> > > >   12    74.72 archlinux:base                : Ok   gcc (GCC) 13.2.1 20230801 , clang version 16.0.6 flex 2.6.4
> > > > 
> > > > / $ grep -B8 -A2 -w basename /usr/include/string.h
> > > > #ifdef _GNU_SOURCE
> > > > #define	strdupa(x)	strcpy(alloca(strlen(x)+1),x)
> > > > int strverscmp (const char *, const char *);
> > > > char *strchrnul(const char *, int);
> > > > char *strcasestr(const char *, const char *);
> > > > void *memrchr(const void *, int, size_t);
> > > > void *mempcpy(void *, const void *, size_t);
> > > > #ifndef __cplusplus
> > > > char *basename();
> > > > #endif
> > > > #endif
> > > > / $ cat /etc/os-release
> > > > NAME="Alpine Linux"
> > > > ID=alpine
> > > > VERSION_ID=3.19.0
> > > > PRETTY_NAME="Alpine Linux v3.19"
> > > > HOME_URL="https://alpinelinux.org/"
> > > > BUG_REPORT_URL="https://gitlab.alpinelinux.org/alpine/aports/-/issues"
> > > > / $
> > > > 
> > > > Weird, they had it and now removed the _GNU_SOURCE bits (edge is their
> > > > devel distro, like rawhide is for fedora, tumbleweed for opensuse, etc).
> > > 
> > > let's see, I asked them in here: https://gitlab.alpinelinux.org/alpine/aports/-/issues/15643
> > 
> > it got removed in musl libc recently:
> >   https://git.musl-libc.org/cgit/musl/commit/?id=725e17ed6dff4d0cd22487bb64470881e86a92e7
> > 
> > so perhaps switching to POSIX version of basename is the easiest way out?
> 
> I think so, in all of perf we use the POSIX one, strdup'ing the arg,
> etc.
> 
> Something like the patch below?
> 
> - Arnaldo
> 
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index ee3ce2b8000d75d2..a5cc5938c3d7951e 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -7,6 +7,7 @@
>  #include <ctype.h>
>  #include <errno.h>
>  #include <fcntl.h>
> +#include <libgen.h>
>  #include <linux/err.h>
>  #include <stdbool.h>
>  #include <stdio.h>
> @@ -56,9 +57,10 @@ static bool str_has_suffix(const char *str, const char *suffix)
>  
>  static void get_obj_name(char *name, const char *file)
>  {
> -	/* Using basename() GNU version which doesn't modify arg. */
> -	strncpy(name, basename(file), MAX_OBJ_NAME_LEN - 1);
> -	name[MAX_OBJ_NAME_LEN - 1] = '\0';
> +	char file_copy[PATH_MAX];

ok, probably better then checking for strdup error

> +	/* Using basename() POSIX version to be more portable. */
> +	strncpy(file_copy, file, PATH_MAX - 1)[PATH_MAX - 1] = '\0';
> +	strncpy(name, basename(file_copy), MAX_OBJ_NAME_LEN - 1)[MAX_OBJ_NAME_LEN - 1] = '\0';

I've never used it like that.. had to zoom in twice ;-)
but extra line with that might be more readable

jirka

>  	if (str_has_suffix(name, ".o"))
>  		name[strlen(name) - 2] = '\0';
>  	sanitize_identifier(name);

