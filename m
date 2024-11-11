Return-Path: <bpf+bounces-44512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE539C3E89
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 13:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4B832846A4
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 12:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEE719CD0B;
	Mon, 11 Nov 2024 12:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBzsDgmM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D73A19C56C;
	Mon, 11 Nov 2024 12:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731328619; cv=none; b=R1SKqWvrB9ipzwpj9/tp3nEmxqOtIuL0AjukGGAfZ1NwDNzgqHPHNraFFjhqkUA7lYCFNLvFp6qoahNuLva9QayrY9HrTZajtI5IQ4vDak3zIiCRpTF/iojNb2Q4Cx/jzoxIdZvBJBYLkPxi9s17sbKU8kZYIE/1HKpFQNkRSaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731328619; c=relaxed/simple;
	bh=1sVMATZ+XHzhI8+EZUQums1C9tIjgrVA6aLaiEGhr3c=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=haa7Q/CKA8XwT+slfYHJKqPrNTCAjIsw2L++RE4FyrLmqCIyzTKESTLId5A9QzWoqh2DHOKNrTDWzykOxfvTbpd1YnuH1ZZn0ro2mzGX6tL4FD3c1CkPja/tSvveRA8Cei8rMDQ9SxkxiW2d0kvPFbJIyKNZJhhGl696S/1mygc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBzsDgmM; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9ec86a67feso783016466b.1;
        Mon, 11 Nov 2024 04:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731328615; x=1731933415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b46JJpzk9fLxJAjQq3bc85OciVgWHq7oFJZ0M84pMjA=;
        b=jBzsDgmM0wzl3gneBd8xvVlb1S4LrD6l83pTbRvKODMxYyBmtYe+YN1FmCZW+WIUrJ
         F3pCs4OaRCOjWBgQNWRlvH7RaXC9hcRTXfr14TLKvZImiBivkm24OAMt+82jrWrYZN9w
         WLevF6Ysja8PHa/HVoQWkTg3ZFnlyaVGq+znXaYSkRvLxTPQjPq8eu52B4gEiQh2TQmi
         KDqnvZZru6FA27+4V5YNYpFFG2cD8Ac+BmWL+DD5/5Si/lL6cVll3u/Y0wRVz7+bcXDJ
         UWSG0ZZ7fZvAQtjSm7j1WQxrj1CcbfRJSxSLgHC9ABfWR5cbROKEMXMU/8o6eWLfkxdZ
         xRHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731328615; x=1731933415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b46JJpzk9fLxJAjQq3bc85OciVgWHq7oFJZ0M84pMjA=;
        b=k16Z/+N0I9RtnViCH3Q1tKWJd1aPGo5pvqTqPGCe1BX4NxBebV6W90p3K068Ionb5x
         LkRSDmudkH/VQ6Wgla7dpjD9e9i2l/U65KO8Uc51zxL7Ghiop5p3mwlmSz42KcIHdlAE
         0TkScO8Er7Cc6059eGZDtaFwTPBRuCksvCxAKMNytE67vTgmOf0scZluF38LHys1tA9y
         5lc67/a86g2gbC2qVRooztYHLEXrPYW7UWtT2etLFi0olQH6Z749KQxDX2a6SFwsYE83
         KXSkEcoXN10v/2Dq+VNnNquIC4VWvqji3lp31lUg5Sw78iOszEclzshooOPDtxMawxZ5
         oTIg==
X-Forwarded-Encrypted: i=1; AJvYcCUiTU906HuO9OCBD3he/7D5H1h77J3BUiKJfRdxtMPxgefdvqTgYh2zMS9T/DfimNDzmVs=@vger.kernel.org, AJvYcCXOADK2s013CimRXSXYdBJdZ6R8sfJXR2wUXarKUX28OQetIKvPxd6eZPbIR8C8IPUaeXNWpwk/DA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz+j5lqhT+n3AxPCIsZtKupS3mTojdb2utBHF5Wikrazwedyg5
	rc8Gz1nJtzteWU8qZlMbXBxbzwZDiA3qgUD/EnIdmFFR4FARjbz8HxtlIw==
X-Google-Smtp-Source: AGHT+IFN4KR2uGUxhjK3BkyRsSM96rm6k/XIq4eBm1aBDVfcFjn4dis0roSa7C79TC/eOTb4DISHiw==
X-Received: by 2002:a17:907:6ea4:b0:a9a:515:1904 with SMTP id a640c23a62f3a-a9eeff0dc1bmr1281832066b.15.1731328615221;
        Mon, 11 Nov 2024 04:36:55 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a17624sm594371666b.24.2024.11.11.04.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 04:36:54 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 11 Nov 2024 13:36:52 +0100
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>,
	Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
	dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
	Song Liu <song@kernel.org>
Subject: Re: [PATCH dwarves 3/3] dwarf_loader: Check DW_OP_[GNU_]entry_value
 for possible parameter matching
Message-ID: <ZzH6ZDucO2nm9Y52@krava>
References: <20241108180508.1196431-1-yonghong.song@linux.dev>
 <20241108180524.1198900-1-yonghong.song@linux.dev>
 <31dea31e6f75916fdc078d433263daa6bb0bffdc.camel@gmail.com>
 <080794545d8eb3df3d6eba90ac621111ab7171f5.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <080794545d8eb3df3d6eba90ac621111ab7171f5.camel@gmail.com>

On Mon, Nov 11, 2024 at 12:01:13AM -0800, Eduard Zingerman wrote:
> On Sun, 2024-11-10 at 03:38 -0800, Eduard Zingerman wrote:
> 
> [...]
> 
> > Also, it appears there is some bug either in pahole or in libdw's
> > implementation of dwarf_getlocation(). When I try both your patch-set
> > and my variant there is a segfault once in a while:
> > 
> >   $ for i in $(seq 1 100); \
> >     do echo "---> $i"; \
> >        pahole -j --skip_encoding_btf_inconsistent_proto -J --btf_encode_detached=/dev/null vmlinux ; \
> >     done
> >   ---> 1
> >   ...
> >   ---> 71
> >   Segmentation fault (core dumped)
> >   ...
> > 
> > The segfault happens only when -j (multiple threads) is passed.
> > If pahole is built with sanitizers
> > (passing -DCMAKE_C_FLAGS="-fsanitize=undefined,address")
> > the stack trace looks as follows:
> 
> Did some additional research for these SEGFAULTs.
> Looks like all we are in trouble.
> 
> # TLDR
> 
> libdw is not supposed to be used in a concurrent context.
> libdw is a part of elfutils package, the configuration flag
> making API thread-safe is documented as experimental:
>   --enable-thread-safety  enable thread safety of libraries EXPERIMENTAL
> At-least Fedora 40 does not ship elfutils built with this flag set.
> This colours all current parallel DWARF decoding questionable.
> 
> # Why segfault happens
> 
> Any references to elfutils source code are for commit [1].
> The dwarf_getlocation() is one of a few libdw APIs that uses memory
> allocation internally. The function dwarf_getlocation.c:__libdw_intern_expression
> iterates over expression encodings in DWARF and allocates
> a set of objects of type `struct loclist` and `Dwarf_Op`.
> Pointers to allocated objects are put to a binary tree for caching,
> see dwarf_getlocation.c:660, the call to eu_tsearch() function.
> The eu_tsearch() is a wrapper around libc tsearch() function.
> This wrapper provides locking for the tree,
> but only if --enable-thread-safety was set during elfutils configuration.
> The SEGFAULT happens inside tsearch() call because binary tree is malformed, e.g.:
> 
>   Thread 8 "pahole" received signal SIGSEGV, Segmentation fault.
>   [Switching to Thread 0x7fffd9c006c0 (LWP 2630074)]
>   0x00007ffff7c5d200 in maybe_split_for_insert (...) at tsearch.c:228
>   228	      if (parentp != NULL && RED(DEREFNODEPTR(parentp)))
>   (gdb) bt
>   #0  0x00007ffff7c5d200 in maybe_split_for_insert (...) at tsearch.c:228
>   #1  0x00007ffff7c5d466 in __GI___tsearch (...) at tsearch.c:358
>   #2  __GI___tsearch (...) at tsearch.c:290
>   #3  0x000000000048f096 in __interceptor_tsearch ()
>   #4  0x00007ffff7f5c482 in __libdw_intern_expression (...) at dwarf_getlocation.c:660
>   #5  0x00007ffff7f5cf51 in getlocation (...) at dwarf_getlocation.c:678
>   #6  getlocation (...) at dwarf_getlocation.c:667
>   #7  dwarf_getlocation (..._ at dwarf_getlocation.c:708
>   #8  0x00000000005a2ee5 in parameter.new ()
>   #9  0x00000000005a0122 in die.process_function ()
>   #10 0x0000000000597efd in __die__process_tag ()
>   #11 0x0000000000595ad9 in die.process_unit ()
>   #12 0x0000000000595436 in die.process ()
>   #13 0x00000000005b0187 in dwarf_cus.process_cu ()
>   #14 0x00000000005afa38 in dwarf_cus.process_cu_thread ()
>   #15 0x00000000004c7b8d in asan_thread_start(void*) ()
>   #16 0x00007ffff7bda6d7 in start_thread (arg=<optimized out>) at pthread_create.c:447
>   #17 0x00007ffff7c5e60c in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:78
>   (gdb) p parentp
>   $1 = (node *) 0x50300079d2a0
>   (gdb) p *parentp
>   $2 = (node) 0x0
> 
> glibc provides a way to validate binary tree structure.
> For this misc/tsearch.c has to be changed to define DEBUGGING variable.
> (I used glibc 2.39 as provided by source rpm for Fedora 40 for experiments).
> If this is done and custom glibc is used for pahole execution,
> the following error is reported if '-j' flag is present:
> 
>   $ pahole -j --skip_encoding_btf_inconsistent_proto -J --btf_encode_detached=/home/eddy/work/tmp/my-new.btf vmlinux 
>   Fatal glibc error: tsearch.c:164 (check_tree_recurse): assertion failed: d_sofar == d_total
>   Fatal glibc error: tsearch.c:164 (check_tree_recurse): assertion failed: d_sofar == d_total
>   Aborted (core dumped)
> 
> Executing pahole using a custom-built libdw,
> built with --enable-thread-safety resolves the issue.

could we use libdw__lock around that? but I guess we use it on other
places as well..

jirka

> 
> [1] b2f225d6bff8 ("Consolidate and add files to clean target variables")
>     git://sourceware.org/git/elfutils.git
> 
> 

