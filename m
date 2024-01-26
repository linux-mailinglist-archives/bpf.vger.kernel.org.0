Return-Path: <bpf+bounces-20408-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD22A83DE0D
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 16:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 894AE288C4B
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 15:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24981D530;
	Fri, 26 Jan 2024 15:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScQlk6k/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7621CD3F
	for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 15:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706284435; cv=none; b=enuVe+YM6XTRXU6mdV4kzXytQU0W7pi8YgQxTAN+Q8FQSmDo2+X8Z/dn5zKLzYX9NK6DGX+/JPJ2IyE/eP2fu2p3ExEE4x4km5SThTRo2VA44lGkvQ1Fqef3mg+Ep9+RIS9fzUnovMQMcHaeG+MaTNSTkkK4ZZdVsdbhY/zNv3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706284435; c=relaxed/simple;
	bh=k1MhHYqm58SwzlfoLrmOreE2A8izutRBK6OKlIYAStA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RsiBfgQuz84wGNo8idoPEKKZBtkWS/8ozYroYj5GJRqYgA5DbyaRBwZlMAUqZkC/PY59CH/M6Zfhc+fsRsk+x+KHpwQ3tDX2Oks86azCQGhxjwbA9EXf+tBynO8cOCz1iQpLFnCWVOSQYd37WQLmROa2LeDIUiOSqumkNzMLUgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScQlk6k/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5DAEC433C7;
	Fri, 26 Jan 2024 15:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706284434;
	bh=k1MhHYqm58SwzlfoLrmOreE2A8izutRBK6OKlIYAStA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ScQlk6k/8pKC/tfZdoDvlk9urCzQpTl1Z5I5HfqlrWmRYfTzowdUHQRyGoqzLjIT/
	 kL5CPhPAlwHnn8blg3cK1XWOcPC40sv4aRTCrthNTQSFFgpn0vNJ99yKM6k2clgFb9
	 /OU/ON5b5cbYPYThVb3TVJzoSBt+cDInOz0ohVQFLnP0/gzc8FHTzFESIxIBs2szVb
	 IEKZuMzR2k3x0lbzXknhHTb65BYzkmmMPAxq5kM03JOWtogt2UbNQDxmy6NEp/UCrz
	 cxHGshP9uZfZRavgUf+2X8h9SVOxvaZJYrjs4UhV0Cs3PiuaT6EPmE81cqNXUL0+XH
	 tpbVkU9xDK1fA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 561F740441; Fri, 26 Jan 2024 12:53:22 -0300 (-03)
Date: Fri, 26 Jan 2024 12:53:22 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Quentin Monnet <quentin@isovalent.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org
Subject: Re: [PATCH] bpftool: Add missing libgen.h for basename()
Message-ID: <ZbPVcsAwjE1Mtv7C@kernel.org>
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
X-Url: http://acmel.wordpress.com

Em Fri, Jan 05, 2024 at 05:53:18PM -0300, Arnaldo Carvalho de Melo escreveu:
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

Quentin, are you ok with this? Then I can send a formal patch.

Jiri, can I have your Acked-by?

- Arnaldo
 
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
> +	/* Using basename() POSIX version to be more portable. */
> +	strncpy(file_copy, file, PATH_MAX - 1)[PATH_MAX - 1] = '\0';
> +	strncpy(name, basename(file_copy), MAX_OBJ_NAME_LEN - 1)[MAX_OBJ_NAME_LEN - 1] = '\0';
>  	if (str_has_suffix(name, ".o"))
>  		name[strlen(name) - 2] = '\0';
>  	sanitize_identifier(name);

-- 

- Arnaldo

