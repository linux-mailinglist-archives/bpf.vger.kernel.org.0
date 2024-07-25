Return-Path: <bpf+bounces-35631-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E740C93C167
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 14:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81BA6B227F8
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 12:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56472B9C8;
	Thu, 25 Jul 2024 12:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6auwvyr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EAC22089
	for <bpf@vger.kernel.org>; Thu, 25 Jul 2024 12:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721909033; cv=none; b=t+WVpE0SuuO03M/OEfajArGVnq5IfGcM/FAJd3euX9ZlQFCdESx/6iH2m3v2EiOSKH5WmSgrScokAWog+m6rmVmJi2LfXKgk0meGKzbWw0Vr/DDIWTxZI7qTPjCKc0yQCSlhEL1YTRbMtETyjiAx6VUfxP4CPsNh/JIr+qvRJwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721909033; c=relaxed/simple;
	bh=hgg5FImz2cDNdVFIWIYHi+xbzn+ms89XwY7GKXZdZVk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HESFWyhOfENeEzeZZPoW9GClJXYKeTkpgcQsGy7k769IAG2USgr6/hxgcEfLRE6EVVYR5ahm8TuHMi27xGgqR7NeE8kB2J1bqaDNvqPs4fCh4IHJ46nbjjbtEt09oQt36ws945uC1mKzs3NKkc/qBG4IaHC0Oyocgu621/hXHmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6auwvyr; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-428035c0bb2so5018595e9.1
        for <bpf@vger.kernel.org>; Thu, 25 Jul 2024 05:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721909030; x=1722513830; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D8zPWrHDS7vF+EvLgmltqmL71OguXyASyp/scEOek/I=;
        b=l6auwvyrnTzOIky5F99CtENr1/ACgAnFBzcdhnkZiURqOAa1yVa+J73Uf9eTNt3igJ
         2DvsD1vCF1S7ySyqVyjbb4etOUEI1Id5ovPUlqgZZkPN26uP3qHiGrqY3ElH7iAWY/p9
         mWT0K8hkNxe6Ama97/e8HcDczyIRgMY901wvuXNzhllnd3ptJprtnKL+55M/UkAu65we
         Vjy+LKDr0DMlXhOiDJRp9H4J/B9oc2hW1CcyWzIilFWYJdUvCeNCae76uo03Mh/UQAj5
         llNzRxaMoQm5WAPaT9cF9l7+OhxMQ61Kw2EUm4yky6ORCmFcsSBEola4bg8+Ar6EG6nY
         7eNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721909030; x=1722513830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8zPWrHDS7vF+EvLgmltqmL71OguXyASyp/scEOek/I=;
        b=H2yxYqhOOiy8J7ModQuGMPhQRL9lEd38Tjf5Bea6xtIbXjd/QL4ANCdBVISIEfFufN
         J1l3qtGYvuAwkgaBYx80mBL9RZ4iI/Kf76MqA4AM4ni1SqoPT/tyTIjefNQlrhB1z1tp
         BJEyA+5+Y13iJtKLPwVyAeRP2CDwq8D8TeSRXezX7DWXyJSagQkrvUydvJoer65zBsMD
         3Q3gIIOvT+cKj8JIlLcuqhEX6pAS3W1UGZiwg8agrlx+qkt/mRlXmlrMk/Q/W3WhpATv
         FOJd2dl2wLQo2fabCUmKRdnF6x0DN4lAoFNjH/fU1liFPh+idFhX/xSQmBPQNAJd1xdi
         RdIQ==
X-Gm-Message-State: AOJu0YzuvXi9WWIElRa/R7YVOSR/1ekW6U6EgjjG6UClH0ROb4r7qodk
	0Wr2wvBP6TAB29dTxwrI1wSvOUjfWAusERgojChkRnjneqAWk/Xr
X-Google-Smtp-Source: AGHT+IFS/vEZz/E0PTEIIQZKR17UrKx6WEv7e5WXfp9WA0FLEpgMW0DsWSig2jQ0r2aQvnJ2XXGt1A==
X-Received: by 2002:a05:600c:45d2:b0:426:5fa7:b495 with SMTP id 5b1f17b1804b1-42803b58877mr16727925e9.15.1721909029574;
        Thu, 25 Jul 2024 05:03:49 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42808457c7fsm16771625e9.32.2024.07.25.05.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 05:03:49 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 25 Jul 2024 14:03:47 +0200
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
	adobriyan@gmail.com, shakeel.butt@linux.dev, hannes@cmpxchg.org,
	ak@linux.intel.com, osandov@osandov.com, song@kernel.org
Subject: Re: [PATCH v2 bpf-next 01/10] lib/buildid: add single page-based
 file reader abstraction
Message-ID: <ZqI_I2iDLwNTJy4h@krava>
References: <20240724225210.545423-1-andrii@kernel.org>
 <20240724225210.545423-2-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724225210.545423-2-andrii@kernel.org>

On Wed, Jul 24, 2024 at 03:52:01PM -0700, Andrii Nakryiko wrote:

SNIP

> +static int freader_get_page(struct freader *r, u64 file_off)
> +{
> +	pgoff_t pg_off = file_off >> PAGE_SHIFT;
> +
> +	freader_put_page(r);
> +
> +	r->page = find_get_page(r->mapping, pg_off);
> +	if (!r->page)
> +		return -EFAULT;	/* page not mapped */
> +
> +	r->page_addr = kmap_local_page(r->page);
> +	r->file_off = file_off & PAGE_MASK;
> +
> +	return 0;
> +}
> +
> +static const void *freader_fetch(struct freader *r, u64 file_off, size_t sz)
> +{
> +	int err;
> +
> +	/* provided internal temporary buffer should be sized correctly */
> +	if (WARN_ON(r->buf && sz > r->buf_sz)) {
> +		r->err = -E2BIG;
> +		return NULL;
> +	}

what's the benefit of having err, would it be easier just to return
error pointer like ERR_PTR(-E2BIG)

SNIP

> +static void freader_cleanup(struct freader *r)
> +{
> +	freader_put_page(r);
> +}
> +
>  /*
>   * Parse build id from the note segment. This logic can be shared between
>   * 32-bit and 64-bit system, because Elf32_Nhdr and Elf64_Nhdr are
>   * identical.
>   */
> -static int parse_build_id_buf(unsigned char *build_id,
> -			      __u32 *size,
> -			      const void *note_start,
> -			      Elf32_Word note_size)
> +static int parse_build_id_buf(struct freader *r,
> +			      unsigned char *build_id, __u32 *size,
> +			      u64 note_offs, Elf32_Word note_size)
>  {
> -	Elf32_Word note_offs = 0, new_offs;
> +	const char note_name[] = "GNU";

could be static ?

SNIP

>  int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 buf_size)
>  {
> -	return parse_build_id_buf(build_id, NULL, buf, buf_size);
> +	struct freader r;
> +
> +	freader_init_from_mem(&r, buf, buf_size);
> +
> +	return parse_build_id_buf(&r, build_id, NULL, 0, buf_size);

could use a coment in here why freader_cleanup is not needed

jirka

>  }
>  
>  #if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID) || IS_ENABLED(CONFIG_VMCORE_INFO)
> -- 
> 2.43.0
> 
> 

