Return-Path: <bpf+bounces-36885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C37094EBC9
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 13:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65C6EB21E2A
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 11:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF01175D27;
	Mon, 12 Aug 2024 11:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVJKzFUs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE19130495;
	Mon, 12 Aug 2024 11:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723462066; cv=none; b=hh75S1wno0+RThpxzc7rA/85+H70plTLgxtQ0E2zp24qpeFEXzoUR6EDLDRyTwaZoJPS8n5dj/WTjIW5dgQxtbtnz5Miu+i7TclGV3q1GtCSx1gk1aPP63w3/23v2FwzfDe7BNxbP2taH9jcaakbuzsX02UWLJbl03ZWPShOlpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723462066; c=relaxed/simple;
	bh=ooit3dZaQ+e3l32nFO4j0A0h1bDoLf39TQv9xh8BGOM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYaTSL0vut+iq7jzLHkw8ohxNrsdXQrkUCSjne+sa5Ur447ife8svaZce4bqH/8t2xfbsjklZsy9HZezA8zVsyuFtTlkmWQqyNpdQMrTMssYzR2OYuHQ1m9KrGGHm/0FjZvMYFYY6MQgS8VsArBsVtEe+CbBqHvfuOnVR7tqt54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVJKzFUs; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ef2d96164aso45171531fa.3;
        Mon, 12 Aug 2024 04:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723462063; x=1724066863; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5rP9Ak9DtV+I9TcrAkt11wwlp+7N6on6X5okyxjZfzo=;
        b=BVJKzFUsqAFgU4N88+4P9YYfUY/rBagoBu/aRkESuezYzIe5MQqq/ujQxqJI+Z9BMj
         QRdPuXxLGKaxpTCbVY+b+UWg7xT1E9TqQHcS23y9VlzoABxOwUsqHNGlUhzAUBAPjhwp
         X4CpHOsjrWJ9FOnCP6/5dBulpf/51mJeBk23F+eWAv5eDB/xJ6lMvSolOYaUd2tsDhmf
         vJpAwcKm23tY2m1AahpzhYg+FKLEFGPyO82puJBBHq1ydSblfYTlPMRciolluyWigyqX
         NRoKgKdQlxl6AQX/RMsced7HAbaA+iXpjgMZ5xQ+P0jrDmGa0ET6h8CPbI/1kTA9z0LE
         WOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723462063; x=1724066863;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5rP9Ak9DtV+I9TcrAkt11wwlp+7N6on6X5okyxjZfzo=;
        b=fmT3eC2dCtbgfmYrxIoONOqJ2eRyZ+nN6XqRkvxGvLn8RFlKA5g6GFpXTrZOxTmx+n
         TWC5c4mafEwN47Fvyp5upJeuuodDTEDuG52zVEjOfcKk8tvian7aXskthEfEbpL/nMa7
         zUzVJ7EmqLVLAvn5so9Nl1vYtpsw25ilXAoqNwdhuTSr5rR/ZOKMdT0qT3jgS/iXgYoy
         QzPWAt/SLay4tFLCMESvX894afQEZVvyygtV8pNf5Vpj+Jj6/JKKAx811I/7RTW1vJ+C
         VUVL50ToG4SxNrzp5XeTTIQY6vZ6uuT+57FPUlKpA+DwWd2d/DYwJaBmQi9VqiSsGBT5
         +00w==
X-Forwarded-Encrypted: i=1; AJvYcCWQK/SR9ejKPagfBO+SocrkJSCDAxc8EPzK/p63usiiuhzugJEsDeLpU3j+g8zELUzg4tOC4mccAJRf3J8MEsIs87PBJca9TxfBHufZFa5/Hb7fAMZ3gWM+7DE8vTTXOz/8
X-Gm-Message-State: AOJu0YyIZYXmgySVy6EzhEHrUEUZay0GdJR4QoGlD22UsAfzLOCEilgq
	M+5/EfU5NaGQ/B+/MExVloS9AnqbguVTmuf97qkiYe/2TS62MvvB
X-Google-Smtp-Source: AGHT+IH59p2KmjsWqa1/mGtSOgWx7EQhdMcbq3Fj2EapsCCsxlI0jkvSXiYceBvG9hIDlvH8Qq65PQ==
X-Received: by 2002:a05:6512:3989:b0:52e:9382:a36 with SMTP id 2adb3069b0e04-530ee993e35mr6229123e87.30.1723462062337;
        Mon, 12 Aug 2024 04:27:42 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd190ad256sm2030618a12.33.2024.08.12.04.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 04:27:41 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 12 Aug 2024 13:27:39 +0200
To: Sam James <sam@gentoo.org>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	Andrew Pinski <quic_apinski@quicinc.com>,
	Kacper =?utf-8?B?U8WCb21pxYRza2k=?= <kacper.slominski72@gmail.com>,
	Arsen =?utf-8?Q?Arsenovi=C4=87?= <arsen@gentoo.org>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] libbpf: workaround -Wmaybe-uninitialized false
 positive
Message-ID: <Zrnxq_har46fAntt@krava>
References: <12cec1262be71de5f1d9eae121b637041a5ae247.1723459079.git.sam@gentoo.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <12cec1262be71de5f1d9eae121b637041a5ae247.1723459079.git.sam@gentoo.org>

On Mon, Aug 12, 2024 at 11:37:59AM +0100, Sam James wrote:
> In `elf_close`, we get this with GCC 15 -O3 (at least):
> ```
> In function ‘elf_close’,
>     inlined from ‘elf_close’ at elf.c:53:6,
>     inlined from ‘elf_find_func_offset_from_file’ at elf.c:384:2:
> elf.c:57:9: warning: ‘elf_fd.elf’ may be used uninitialized [-Wmaybe-uninitialized]
>    57 |         elf_end(elf_fd->elf);
>       |         ^~~~~~~~~~~~~~~~~~~~
> elf.c: In function ‘elf_find_func_offset_from_file’:
> elf.c:377:23: note: ‘elf_fd.elf’ was declared here
>   377 |         struct elf_fd elf_fd;
>       |                       ^~~~~~
> In function ‘elf_close’,
>     inlined from ‘elf_close’ at elf.c:53:6,
>     inlined from ‘elf_find_func_offset_from_file’ at elf.c:384:2:
> elf.c:58:9: warning: ‘elf_fd.fd’ may be used uninitialized [-Wmaybe-uninitialized]
>    58 |         close(elf_fd->fd);
>       |         ^~~~~~~~~~~~~~~~~
> elf.c: In function ‘elf_find_func_offset_from_file’:
> elf.c:377:23: note: ‘elf_fd.fd’ was declared here
>   377 |         struct elf_fd elf_fd;
>       |                       ^~~~~~
> ```
> 
> In reality, our use is fine, it's just that GCC doesn't model errno
> here (see linked GCC bug). Suppress -Wmaybe-uninitialized accordingly
> by initializing elf_fd.elf to -1.
> 
> I've done this in two other functions as well given it could easily
> occur there too (same access/use pattern).
> 
> Link: https://gcc.gnu.org/PR114952
> Signed-off-by: Sam James <sam@gentoo.org>
> ---
> v3: Initialize to -1 instead of using a pragma.

it's false positive, but I wonder we could still add Fixes tag

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
> Range-diff against v2:
> 1:  8f5c3b173e4cb < -:  ------------- libbpf: workaround -Wmaybe-uninitialized false positive
> -:  ------------- > 1:  12cec1262be71 libbpf: workaround -Wmaybe-uninitialized false positive
> 
>  tools/lib/bpf/elf.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
> index c92e02394159e..00ea3f867bbc8 100644
> --- a/tools/lib/bpf/elf.c
> +++ b/tools/lib/bpf/elf.c
> @@ -374,7 +374,7 @@ long elf_find_func_offset(Elf *elf, const char *binary_path, const char *name)
>   */
>  long elf_find_func_offset_from_file(const char *binary_path, const char *name)
>  {
> -	struct elf_fd elf_fd;
> +	struct elf_fd elf_fd = { .fd = -1 };
>  	long ret = -ENOENT;
>  
>  	ret = elf_open(binary_path, &elf_fd);
> @@ -412,7 +412,7 @@ int elf_resolve_syms_offsets(const char *binary_path, int cnt,
>  	int err = 0, i, cnt_done = 0;
>  	unsigned long *offsets;
>  	struct symbol *symbols;
> -	struct elf_fd elf_fd;
> +	struct elf_fd elf_fd = { .fd = -1 };
>  
>  	err = elf_open(binary_path, &elf_fd);
>  	if (err)
> @@ -507,7 +507,7 @@ int elf_resolve_pattern_offsets(const char *binary_path, const char *pattern,
>  	int sh_types[2] = { SHT_SYMTAB, SHT_DYNSYM };
>  	unsigned long *offsets = NULL;
>  	size_t cap = 0, cnt = 0;
> -	struct elf_fd elf_fd;
> +	struct elf_fd elf_fd = { .fd = -1 };
>  	int err = 0, i;
>  
>  	err = elf_open(binary_path, &elf_fd);
> -- 
> 2.45.2
> 

