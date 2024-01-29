Return-Path: <bpf+bounces-20561-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0BE8403B9
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 12:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1A461C22955
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 11:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAB55B5D5;
	Mon, 29 Jan 2024 11:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SScxkPha"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1825EE60
	for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 11:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706527432; cv=none; b=Tpc7utmp3sXIBu/G8vSkcefMGQQtVWipsj6+VFo7kB0eewZBWU21veSH8waTXOzf4a+mIl8Svw21vmmwFxo2Ti7BiU9da+pnoQa5tdVSXalZR0Zyuo1tzhj9F15fTcAG/XdhgXNG28kqRirvB2jPvG/ciDi863Lug3zvR/HEUJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706527432; c=relaxed/simple;
	bh=bxPAtvG38TF9bmEpQeFJ3+AfORMwL9mswufwdw3z45o=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5svzE7JTONDDoe+6NHnHeFl+og7oWjEvzmPrFoqYLo8bCSvr8PakkbvseUo3iKL0zLJFTGzVRpCJp7MPjO5xuejx1LfjFkVfVn0VSk3Ja2WlWXcLpZAXEEeLYHRLMOxYcKESfBommyl8oSuEIhIMZA+zZwH9A4FnZHysFOpWD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SScxkPha; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33af2823edbso258607f8f.0
        for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 03:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706527428; x=1707132228; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cVhpfpZki7DBjvU1Wlxa3Rsj9oHZSUXQybVdngGu/fA=;
        b=SScxkPhaYC+fGpl1nR+X+laC5cqt8a/XadIIgmuCNVbNhB2EzBCsI3sOFGb+LaSWEE
         ykwSy8DZNWXAyvm0ZNverA2KTpFfRLpUAGCAfD6PYLbUdNQBP1IwT8k+Y4oly2D3+S+U
         7WYBeOPFoQA0XU1CLyqcWTHsYoOL9ggot4PTTcq6BW13BHYfKbkZ+ejfKqd7J6dfQato
         rfErO8JHJ7BZQdcShNhtL2B7duHS/mzTOr0ibrj74WCRCvcbwsETsA6Vql52sPGxbcEG
         7hghK/lK91xpjGNDt6kwEjpaEQ2EhgMfXXU6ddBaUCXZt0JI//u0NDukxmPFNpDfCRKH
         mUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706527428; x=1707132228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVhpfpZki7DBjvU1Wlxa3Rsj9oHZSUXQybVdngGu/fA=;
        b=QOlPr3kA3KFbBhKT6V0LLgqFVmyUHiOBNF4c9jk3jtQI1tqh6Hm2CVs+fG9A24fZjm
         Gxgo+Q4N407zJQbCP68LHhAAvxUyo0fFUGtw2zLrj7B3A63GnoL0ipcnj83T+GKX3L8e
         tyy7SSnXv5GIOJnKuQ0gCw5vd1n1LQE3AUTRQloiU+UL88VPe9mLDJ8EZZF4ih2vKl/y
         dStj6JKkcpe+1B87Dwr9WYFGf1KmyRU66GIfXZ3AYRfshC73aWaweocll5VJ8yJ6DsJF
         ideEYOfKh6oAXw+JC9ccYhuxSd4/h0WBbvwQhS6R42sluzs/SL2d4nFVum+NZFqRJXaD
         TV1Q==
X-Gm-Message-State: AOJu0YwK8K57ovIBQM26I5rl5jGNthODRhTUMMenu9km8QUGDBD7ZYSx
	VOGr1D4VSFgGt2g903HTJVMBpiQPYlY0D5YfYktqBshAHTSW6mHf
X-Google-Smtp-Source: AGHT+IFmDQCfC1huSICmCXj2r5sZpACRIXWEm0NhO9VJ/8zYjleMdOlwad0/gCOmi/9/dWZPu/C3yw==
X-Received: by 2002:a5d:5225:0:b0:336:6d62:7647 with SMTP id i5-20020a5d5225000000b003366d627647mr2661094wra.5.1706527428425;
        Mon, 29 Jan 2024 03:23:48 -0800 (PST)
Received: from krava (ip4-95-82-160-96.cust.nbox.cz. [95.82.160.96])
        by smtp.gmail.com with ESMTPSA id cl10-20020a5d5f0a000000b0033aeb20f5b8sm3454313wrb.13.2024.01.29.03.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 03:23:48 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 29 Jan 2024 12:23:44 +0100
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Quentin Monnet <quentin@isovalent.com>, Jiri Olsa <olsajiri@gmail.com>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org
Subject: Re: [PATCH] bpftool: Add missing libgen.h for basename()
Message-ID: <ZbeKwGG2kLqxIHRt@krava>
References: <ZZYgMYmb_qE94PUB@kernel.org>
 <ZZZ7hgqlYjNJOynA@krava>
 <ZZakH8LluKodXql-@kernel.org>
 <ZZasL_pO09Zt3R4e@kernel.org>
 <ZZfCX7tcM0RnuHJT@krava>
 <ZZgZ0cxEa7HvSUF6@krava>
 <ZZhsPs00TI75RdAr@kernel.org>
 <ZbPVcsAwjE1Mtv7C@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbPVcsAwjE1Mtv7C@kernel.org>

On Fri, Jan 26, 2024 at 12:53:22PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Jan 05, 2024 at 05:53:18PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Fri, Jan 05, 2024 at 04:01:37PM +0100, Jiri Olsa escreveu:
> > > On Fri, Jan 05, 2024 at 09:48:31AM +0100, Jiri Olsa wrote:
> > > > On Thu, Jan 04, 2024 at 10:01:35AM -0300, Arnaldo Carvalho de Melo wrote:
> > > > 
> > > > SNIP
> > > > 
> > > > >    9    51.66 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-17) , clang version 11.1.0 (Amazon Linux 2 11.1.0-1.amzn2.0.2) flex 2.5.37
> > > > >   10    60.77 amazonlinux:2023              : Ok   gcc (GCC) 11.4.1 20230605 (Red Hat 11.4.1-2) , clang version 15.0.7 (Amazon Linux 15.0.7-3.amzn2023.0.1) flex 2.6.4
> > > > >   11    61.29 amazonlinux:devel             : Ok   gcc (GCC) 11.3.1 20221121 (Red Hat 11.3.1-4) , clang version 15.0.6 (Amazon Linux 15.0.6-3.amzn2023.0.2) flex 2.6.4
> > > > >   12    74.72 archlinux:base                : Ok   gcc (GCC) 13.2.1 20230801 , clang version 16.0.6 flex 2.6.4
> > > > > 
> > > > > / $ grep -B8 -A2 -w basename /usr/include/string.h
> > > > > #ifdef _GNU_SOURCE
> > > > > #define	strdupa(x)	strcpy(alloca(strlen(x)+1),x)
> > > > > int strverscmp (const char *, const char *);
> > > > > char *strchrnul(const char *, int);
> > > > > char *strcasestr(const char *, const char *);
> > > > > void *memrchr(const void *, int, size_t);
> > > > > void *mempcpy(void *, const void *, size_t);
> > > > > #ifndef __cplusplus
> > > > > char *basename();
> > > > > #endif
> > > > > #endif
> > > > > / $ cat /etc/os-release
> > > > > NAME="Alpine Linux"
> > > > > ID=alpine
> > > > > VERSION_ID=3.19.0
> > > > > PRETTY_NAME="Alpine Linux v3.19"
> > > > > HOME_URL="https://alpinelinux.org/"
> > > > > BUG_REPORT_URL="https://gitlab.alpinelinux.org/alpine/aports/-/issues"
> > > > > / $
> > > > > 
> > > > > Weird, they had it and now removed the _GNU_SOURCE bits (edge is their
> > > > > devel distro, like rawhide is for fedora, tumbleweed for opensuse, etc).
> > > > 
> > > > let's see, I asked them in here: https://gitlab.alpinelinux.org/alpine/aports/-/issues/15643
> > > 
> > > it got removed in musl libc recently:
> > >   https://git.musl-libc.org/cgit/musl/commit/?id=725e17ed6dff4d0cd22487bb64470881e86a92e7
> > > 
> > > so perhaps switching to POSIX version of basename is the easiest way out?
> > 
> > I think so, in all of perf we use the POSIX one, strdup'ing the arg,
> > etc.
> > 
> > Something like the patch below?
> 
> Quentin, are you ok with this? Then I can send a formal patch.
> 
> Jiri, can I have your Acked-by?

yes, jirka

> 
> - Arnaldo
>  
> > diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> > index ee3ce2b8000d75d2..a5cc5938c3d7951e 100644
> > --- a/tools/bpf/bpftool/gen.c
> > +++ b/tools/bpf/bpftool/gen.c
> > @@ -7,6 +7,7 @@
> >  #include <ctype.h>
> >  #include <errno.h>
> >  #include <fcntl.h>
> > +#include <libgen.h>
> >  #include <linux/err.h>
> >  #include <stdbool.h>
> >  #include <stdio.h>
> > @@ -56,9 +57,10 @@ static bool str_has_suffix(const char *str, const char *suffix)
> >  
> >  static void get_obj_name(char *name, const char *file)
> >  {
> > -	/* Using basename() GNU version which doesn't modify arg. */
> > -	strncpy(name, basename(file), MAX_OBJ_NAME_LEN - 1);
> > -	name[MAX_OBJ_NAME_LEN - 1] = '\0';
> > +	char file_copy[PATH_MAX];
> > +	/* Using basename() POSIX version to be more portable. */
> > +	strncpy(file_copy, file, PATH_MAX - 1)[PATH_MAX - 1] = '\0';
> > +	strncpy(name, basename(file_copy), MAX_OBJ_NAME_LEN - 1)[MAX_OBJ_NAME_LEN - 1] = '\0';
> >  	if (str_has_suffix(name, ".o"))
> >  		name[strlen(name) - 2] = '\0';
> >  	sanitize_identifier(name);
> 
> -- 
> 
> - Arnaldo

