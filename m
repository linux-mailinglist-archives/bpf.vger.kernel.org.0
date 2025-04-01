Return-Path: <bpf+bounces-55050-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D79A776A5
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 10:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22A953A6DEA
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 08:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45401EB1B4;
	Tue,  1 Apr 2025 08:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cWjLRqC6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D271E834F
	for <bpf@vger.kernel.org>; Tue,  1 Apr 2025 08:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743496938; cv=none; b=fYzsb++Zsf+zVIdxA9H0Y/azVeLk9Fbc5D7kouRPSlPjE4jspvI99AutJO1hpgMFjpl4jl92RH8jrT3kbhNtiAGszMvoclRQBz86wTBdbnn5Np9UZeUynxgIhnnGHKqq9CTYsvXB4pd/dfxTiyNg2KAlyqFg07e6TUgGzUgJp8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743496938; c=relaxed/simple;
	bh=YZaFGvCMIQsb9PiOlDNBsJxEnKn9JVZ42AOxSWiOBio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKwcokewTpJg3/8z/UzmHN+zTihUk6zy8EqOlZ6wAAF50R5fX0iQzjCaLfCcsSKkCsAFLJSbryRGUBszN7mpUVdvIfYo2HqwuFF2BbwUmfO7g/2QMpmPmV4EItJBgf7p+MsuyF3nIVcSf8n9hKTq0E6TteT1ixLjubWqVqTK4Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cWjLRqC6; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9eb1eso1255962a12.0
        for <bpf@vger.kernel.org>; Tue, 01 Apr 2025 01:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743496934; x=1744101734; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T/o5XWa4l5gUPNjznvgYeaHUgYy/EIx7woUA0k2Kxd4=;
        b=cWjLRqC6ixAcOGJxfdXoRS/I/MNJGbf9o/JnezkRCs3AG96uJ82EBjOxUYA8+L/sGH
         mASoRU4SsCfzTcGB/uBGcvRRBgPdCIbp/IDmqaCQbLZLj5UgO/kkKm2vJF5jKE2pvBAE
         zvygyzQQQMOGsnhlEO8glXA/R9LYo0TTtaDR1T5o7l/5m4VtUknK3admVC7nAkbUu6DH
         rtKuJD2lDZ96P3v/6lLr0JHa9Uf0xmoXp3ckz3kiSAbZ+0isarp9Pn579pZHy80bNYce
         lI7sp6/czGmbzuJwCSV/GPrgPH6ny8DJU0p9uVgpD67GgRxWkY8UhkgiXpXiyyzl8F+Z
         TLnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743496934; x=1744101734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/o5XWa4l5gUPNjznvgYeaHUgYy/EIx7woUA0k2Kxd4=;
        b=ATI4bnhx+lf6jqzhfyMoWv9QcNszDeVOCPH7Fl8FsqOdEkh/d7qI7Zxj86AwYzYnmZ
         IhkcXKxmrzyLQBoZ3JbHJBnpJYX3PxSxeOPKNXgxrutG0TItWKyjmiBgHGVx1cHeXJ8T
         uTW2LroaK9E+5e1oFI4wd+QttWc0orqDMd0U8ASUnIFJSie1AVx2W6RjZJLXMhIeYC4s
         ALcAUH+tPah/y2sLeUUkLO5gMZmJLPS33dvzK9MAIztDSjxkyqwAb9z8V0FxdUc0gOD3
         WzzG2xQ9xDxDSGjoshl+wDOZT5CJAFMZBcNf+1mwsKnlaJMF10PNY4KMCTgzrWRnGSl8
         xvWA==
X-Forwarded-Encrypted: i=1; AJvYcCUeVUs8VxwYfBtL5PkRJIoxj//M6Vfl/Pr4t6lA6yHtH2LAyad6UA/Eio/2Kdv93TjCdTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoKD7yG7573umHEjtzpRtv7UcTC51FUYSm3co+ohf2x6PcuOtS
	Ep8hDD5trXEHZTDbFimA1v9EqThEp4xwxyZcNzthRKH/271ddLAH3UI+jpahLpE=
X-Gm-Gg: ASbGncuHAuQ/HM0EUn/RuuPhhOszId+TJAumBlGKWzknWP5VVUqt3O9bgYy21tTxM/p
	3R7z858P2u3v4no1dD7JvyBanzWWLG5Oo9OKbaUE1SV2Knus8t5POnPseDO7x5TnVGX3rlEsf6M
	RCHrVTyt51HiPTIReB2d5aXu+BLZcVH3FW04djPjXn5lLAcP8KZeeNGWQQUygiTiXGn5rRWYP/j
	Us9KnMK/hUUZ/rTJRGv7OGz+T6ZTAJmexoXhtQSW13bHyZDMZYpXqTW5VJUe27MW01orZ+5Edfo
	cUXneAB09MKzfWXuGteYEM1yj8h91zMtegR18POvIaEiow==
X-Google-Smtp-Source: AGHT+IE4hKhywGcQobvbzoNbXf8Bq4/ZS+8/xXWXD5AUQUwrxFzCZds5ecBjzn/9IMrH/IQA23YLQg==
X-Received: by 2002:a05:6402:84f:b0:5e7:87ea:b18c with SMTP id 4fb4d7f45d1cf-5edf6033e1amr9834137a12.15.1743496934489;
        Tue, 01 Apr 2025 01:42:14 -0700 (PDT)
Received: from localhost ([193.86.92.181])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5edc16d5077sm6779970a12.32.2025.04.01.01.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 01:42:14 -0700 (PDT)
Date: Tue, 1 Apr 2025 10:42:13 +0200
From: Michal Hocko <mhocko@suse.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, bpf@vger.kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
	akpm@linux-foundation.org, peterz@infradead.org, vbabka@suse.cz,
	bigeasy@linutronix.de, rostedt@goodmis.org, shakeel.butt@linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: Fix try_alloc_pages
Message-ID: <Z-um5bWEjfmH5XHT@tiehlicka>
References: <20250401032336.39657-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401032336.39657-1-alexei.starovoitov@gmail.com>

On Mon 31-03-25 20:23:36, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Fix an obvious bug. try_alloc_pages() should set_page_refcounted.
> 
> Fixes: 97769a53f117 ("mm, bpf: Introduce try_alloc_pages() for opportunistic page allocation")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
> 
> As soon as I fast forwarded and rerun the tests the bug was
> seen immediately.
> I'm completely baffled how I managed to lose this hunk.
> I'm pretty sure I manually tested various code paths of
> trylock logic with CONFIG_DEBUG_VM=y.
> Pure incompetence :(

I believe Vlastimil is right. This seems to be an unfortunate mismatch
in the final tree when this got merged.
-- 
Michal Hocko
SUSE Labs

