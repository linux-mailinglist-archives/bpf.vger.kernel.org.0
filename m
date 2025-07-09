Return-Path: <bpf+bounces-62845-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD2DAFF504
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 00:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD9C6641839
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 22:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C85123A9BD;
	Wed,  9 Jul 2025 22:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJxigi8k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873E6801;
	Wed,  9 Jul 2025 22:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752101642; cv=none; b=cmFcHbbF9DZb6wOmgHSN+CHngToDtZsl38/Na5ug6bRUHQ7s4+QwPbk5CNaeWVOxs8TXuoZIsX7er8DyLdf4VX/tTq+/LrQ5kMb995gQWVPlxWuJET8Ol0/Xz5LwdX6JT9CcVARIeuKuPCSkWwvMd7snscGytRAVdv5ybznAnGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752101642; c=relaxed/simple;
	bh=Ck7M9kjFGroRgtLiIjkzu/4Z/tLPPWCGWsdGNFjqJ3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TrbE6tMufm+QHTunwiOXbsrERyxi68EvlkkItnegflMe2TeOu1DKtx7n/7VX7e9C82IGBVvIBwYMN3xaTJnymog3mYhY+tzoDEqTuBa41GA0nTsk6+/fFCJ1meRxqVkvuabiopcdYrkOZqWpRC/kwLo98auw+xXGZYlZZbOV1ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJxigi8k; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a582e09144so273514f8f.1;
        Wed, 09 Jul 2025 15:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752101639; x=1752706439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9iJnt4WkpfToovTZMYNbYtyMvKSLn0aTix0qiRAhhs=;
        b=MJxigi8kc9x/gSPcu0shR/8vV8WS+mHrXaxAw3ON6oy5oUfGR6nfaAq1VLgBVKn4wj
         OLoDZBOyDFGmC4WVGByWCmIihfMJiV/cg+rYovZNWxyspfksTLEQ+5nLfiNnKaG+CzNG
         bTT8cT4KpwmYDXy2NKpVYYLEoo1ZHXGUc2ZW6WS0jYJIE4CpKQzTElboxzXJkwmUQZPP
         C8PjJ+4PDNyI3iLWqCvPt5tgh21IXVeCKDBtfwhx+bQq6lGbKv/M02fOSVIQvwb/uYyG
         tUWleXqLrBbLqwQ36JyVQDH3gkXjvszU30H+Zxd7xp525vT3euTRdLpGrl6pz/6KrprE
         /yZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752101639; x=1752706439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N9iJnt4WkpfToovTZMYNbYtyMvKSLn0aTix0qiRAhhs=;
        b=qEL+iSCp+tkaXNKcYIVfCUSYKfadNf6F20moPYJiTnbUBmAsYZFsWD0jniMIlQKApf
         52sQoGVgc01S927LLtb9nsCXNNYUBo5arkpcwvoh4d/zyMRrQmct1ozkO4SbZ3BuJAjk
         Y4RUxh7kS6B9b5IXO3tb0rAazOBqbSFF5/i556H3WyGrJkchz8okHHb4V2C6tgMF7kkz
         H6E5wPPBLjEsLkI5RDADLyzsp/crDks9e/k/dWRawCRcrls2X7XibwWAs0Jbwic5kMb/
         XybVrpVL6mO/dXHGIk3XzWbrkHgEah49vLL0WFhBb+jZCO0R9VW20imob5l2R9a9gPt0
         Bz5g==
X-Forwarded-Encrypted: i=1; AJvYcCUe0PPrbvg8HaynizY/ZxXLoxU8gqhBFnj6CyoJVWpuG8A/riW3rPR3cJMh7Z4e18Oqyg75Cj/Lbq2nvdKBsN0=@vger.kernel.org, AJvYcCWP2rMJZoJcjtEiBDqZvLo3MFTodZABUC+Kz0WgsqYZC+n8fgzaLjMvHGt4Txl4idXAVTI=@vger.kernel.org, AJvYcCWbLlRG1VjJFymXWNh0kkeaaeKaLNGF9VTlamiJLc6RtSQgRJhuGjAacwmLIts8fSmJzsOebQ/hPWniOhGbfBU=@vger.kernel.org, AJvYcCXF/lOcQs6bVr5QqSPUe41qPHD1X7C7juyC32t7MGo0chA9HM3jcKD7w9dvpX3bpJmDWVLFl69QOdeY4AJH@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv9nEC6/nrhsQbqqw38oTtMjSZiAxqC+bT9qiR+q7ZDkAgkHUU
	I4pAs5Qhf6UjBiRfLFV22VHI93fgTxMR3fGNYl5tKjvNT+dsGN1RzAk74p8oCuJZV5Y4RHhmSSB
	xTzvERX7mgIFwL8BBdNDcUN6WI0i/1QNTUw==
X-Gm-Gg: ASbGncv9MwqPEQ/a040TLjUCnXjmJodcj7XJlCtnARj02+iKFnV06voW0/RSxeR7slB
	M4E1HGejUHqTKRtJNgue5nkb+gbflJRLFJ9ejBUZWATJnp0sVSJEGBCAy1B5sYnbwunpVQsItvz
	5O0JF/QC9BsJWFsKJ3IXl3bO1wV2WMwdQq+ydbVbO4Kl9u/5ttiptmRScCqrFUhf/a/Eh83O4Bu
	1haAc9mrJo=
X-Google-Smtp-Source: AGHT+IHDoCCRbQwoVIBCKCBT14ZzPnGvut13NQFhw59jUbLavByhjz0wHOG/UJnidp46oUKDyQonZwNPRHpvQmXcL5Q=
X-Received: by 2002:a05:6000:991:b0:3a4:e609:dc63 with SMTP id
 ffacd0b85a97d-3b5e867f6e4mr389008f8f.20.1752101638580; Wed, 09 Jul 2025
 15:53:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709172345.1031907-1-vitaly.wool@konsulko.se> <20250709172416.1031970-1-vitaly.wool@konsulko.se>
In-Reply-To: <20250709172416.1031970-1-vitaly.wool@konsulko.se>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 9 Jul 2025 15:53:47 -0700
X-Gm-Features: Ac12FXyuwwXk41iu49XWkmvEY5dPL8zCHicyZww6svC_W6iI9a-7d53GSWyAAdg
Message-ID: <CAADnVQ+bikqCO7D+5_rAtiJXv3F6xn=0_hgGH5CkoTPpdi8j6Q@mail.gmail.com>
Subject: Re: [PATCH v12 1/4] mm/vmalloc: allow to set node and align in vrealloc
To: Vitaly Wool <vitaly.wool@konsulko.se>
Cc: linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, 
	LKML <linux-kernel@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	rust-for-linux <rust-for-linux@vger.kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, linux-bcachefs@vger.kernel.org, 
	bpf <bpf@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 10:25=E2=80=AFAM Vitaly Wool <vitaly.wool@konsulko.s=
e> wrote:
>
>
> -void *vrealloc_noprof(const void *p, size_t size, gfp_t flags)
> +void *vrealloc_node_align_noprof(const void *p, size_t size, unsigned lo=
ng align,
> +                                gfp_t flags, int node)
>  {

imo this is a silly pattern to rename functions because they
got new arguments.
The names of the args are clear enough "align" and "node".
I see no point in adding the same suffixes to a function name.
In the future this function will receive another argument and
the function would be renamed again?!
"_noprof" suffix makes sense, since it's there for alloc_hooks,
but "_node_align_" is unnecessary.

