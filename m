Return-Path: <bpf+bounces-57950-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A29AB1F1D
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 23:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 662ABA07706
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 21:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B22025F961;
	Fri,  9 May 2025 21:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FotGgfyd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890CB231A21
	for <bpf@vger.kernel.org>; Fri,  9 May 2025 21:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746826659; cv=none; b=WZdQPMQ8UJnJtX9w9S5/8dKDw/RuOcRA5lnVV9spT4vqDicIal2L17p9xh5fUz7RCEEeqG9a5Zpf0FTxgsCo/XdqwslVwAPRyfDGexgpbMh+b1vuscvsgkXZ8iBrAgJAeuNd3E51Wtyuv6VwyURn/5A/F2GGuCOwqQDjneXGHHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746826659; c=relaxed/simple;
	bh=mFTo7P8rFrVjqvrhwM21tODlgv7pbk42ubeTJFB1MdI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KDMWI+dv3/7I5XWWPbHgEwKcRa9ipZANaLTbSpCxYH8WA/NmugIHBW7lTPmUY39UKTTEjDvDgYtK9E0LaBxUcsMa+zdEjplTF7Yqi6yVt4s214GI1A2LSk9goMHqzsY4bt+3GUyUQMn+pumLloCbQo6Z1laBepjgRr0oYGzzpsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FotGgfyd; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-30aa3980af5so3210222a91.0
        for <bpf@vger.kernel.org>; Fri, 09 May 2025 14:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746826657; x=1747431457; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ovxev8qi3tiyXOybK8CdZg4R4PYh1bE6BmClnW15vzc=;
        b=FotGgfydIsPflUFwM+ktbuQQw+gz4o34zhgWgW179qtv4Drr92aW4vlMZ/ax1orxwC
         eBV3iV6HB2XGBFHjMqGXBKU1a2cP3zJ4j0wWnVes4f/0BVWPpqDoAOVq5wR3R7I9oSnt
         6p4/dV7VvmCNWFR7/z7vny31rHTktaFXrNvhVWneaIaEq/CE1NBDbRm5MEjcaKxO4W2F
         VetcSu6aEGiD/xXbqS0SFOCtdDZ7ii+u/aNF7L8jJQD5SzGkgWd+1BLUP9QfJGf5ermU
         a/Qgh5QW1M0S4LNLilNPxDqNiybGVith9q7DeyKAd2dTLp3lkXDIJbK9nuBMs0w6yOFN
         7F+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746826657; x=1747431457;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ovxev8qi3tiyXOybK8CdZg4R4PYh1bE6BmClnW15vzc=;
        b=E2E0KMZC5xuoKX/Gx/nhS2NSCaTIOITsd6BSNt3W2ONEcBYj2fsB28fU0jBLMII3/T
         X8QSj+X8YJLdSfHrUoy7CrKy7K5TQRAW6PXRieHkECxDV8hXmjHS0DMhJCwldGvJvHPg
         BYtp+3uW+CmMs3LlxpKrZaIXcF8wc7tpeCctRtQYVg9eJRNTzQgjjYTJ02BwIlqPNUXe
         Zk2Tywr0RffpZAaerKhDpj/h1i9h4H/5FeImvh9ZfSsi134dL8TLnXOH06qfvELpXKL9
         W/sZbeUm8ulWrkUvA8NqYWrXsJGZvu6cv51sMYxEEtVioMMoNos9EzcCNOeIF5GnxUqf
         bOqw==
X-Gm-Message-State: AOJu0Yy4jo7Bav9Xa0kh+hYF8I6mKKxmfrHj4iEVZaYU2MUFQLUoKhHN
	V4TAXIbdLkwOMTz/vebSt6xKpHBf1EjjCdesuiqc9XrxrH4aeOnybTkvLw==
X-Gm-Gg: ASbGncv2iSPXIf8VQOnzrw/+3Ltz/m+BRjt9Q0bjhaUf445GJKBVlQo02DJdOsdJxnH
	yoZArfEQhzFNP0sJKL2iK3sR5w8z+hrE7hoImcE6A6MpmQNHZ4bMvsaetXYpZ6PJ2WE5Ah2rpKY
	e4q80B2vuFupJzPeySPF4MU1jSaVN0Vi/yMsuhtmC5aVTjQSpBUvLkNcc6KY/OawHU9tjoTBpQL
	uAQ6JgProfepquGON0hl5Qs1ecaWu2n+piileoXNXyxtytABPC3woMrV1KmjnGiMnIlCNplN7tb
	EMLjlxd03Oe8h5LUUT5V4uVjvW+hhvrmcMYGajtwTDSYwAzy0lFn+ZEuhA==
X-Google-Smtp-Source: AGHT+IG6RUlmpj9cLAOkLMIfXWeW8vFZQK77XAE05s30/O/V5JwuiZcFk6eDJjL2ofLec6d3vAG3nA==
X-Received: by 2002:a17:90b:1c05:b0:30a:2173:9f0b with SMTP id 98e67ed59e1d1-30c3d62e5b8mr7937767a91.28.1746826656653;
        Fri, 09 May 2025 14:37:36 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b234922e4ecsm1955172a12.8.2025.05.09.14.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 14:37:36 -0700 (PDT)
Message-ID: <e1bb9c33b8852e1d3575f7cefe50aca266a8ff2b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 3/4] bpf: Add kfuncs for read-only string
 operations
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Viktor Malik
	 <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann	 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau	 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song	 <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh	 <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo	 <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>
Date: Fri, 09 May 2025 14:37:34 -0700
In-Reply-To: <CAEf4BzZBB3rD0gfxq3ZC0_RuBjXHBMqdXxw3DcEyuYhmh7n5HA@mail.gmail.com>
References: <cover.1746598898.git.vmalik@redhat.com>
	 <19913411da8c08170d959207e28262efc0a5d813.1746598898.git.vmalik@redhat.com>
	 <CAEf4BzZBB3rD0gfxq3ZC0_RuBjXHBMqdXxw3DcEyuYhmh7n5HA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-05-09 at 11:20 -0700, Andrii Nakryiko wrote:

[...]

> > +/**
> > + * bpf_strchr - Find the first occurrence of a character in a string
> > + * @s: The string to be searched
> > + * @c: The character to search for
> > + *
> > + * Note that the %NUL-terminator is considered part of the string, and=
 can
> > + * be searched for.
> > + *
> > + * Return:
> > + * * const char * - Pointer to the first occurrence of @c within @s
> > + * * %NULL        - @c not found in @s
> > + * * %-EFAULT     - Cannot read @s
> > + * * %-E2BIG      - @s too large
> > + */
> > +__bpf_kfunc const char *bpf_strchr(const char *s, char c)
>=20
> so let's say we found the character, we return a pointer to it, and
> that memory goes away (because we never owned it, so we don't really
> know what and when will happen with it). Question, will verifier allow
> BPF program to dereference this pointer? If yes, that's a problem. But
> if not, then I'm not sure there is much point in returning a pointer.
>=20
>=20
> I'm just trying to imply that in BPF world integer-based APIs work
> better/safer, overall? For strings, we can switch any
> pointer-returning API to position-returning (or negative error) API
> and it would more or less naturally fit into BPF API surface, no?

Integer based API solves the problem with memory access but is not
really ergonomic. W/o special logic in verifier the returned int would
be unbounded, hence the user would have to compare it with string
length before using.

It looks like some verifier logic is necessary regardless of API being
integer or pointer based. In any case verifier needs additional rules
for each pointer type to adjust bounds on the return value or its refobj_id=
.


