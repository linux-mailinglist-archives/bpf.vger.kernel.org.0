Return-Path: <bpf+bounces-22215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5C285900C
	for <lists+bpf@lfdr.de>; Sat, 17 Feb 2024 15:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 165F51C20F43
	for <lists+bpf@lfdr.de>; Sat, 17 Feb 2024 14:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18747B3C1;
	Sat, 17 Feb 2024 14:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQxJTNEQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD62A6A012
	for <bpf@vger.kernel.org>; Sat, 17 Feb 2024 14:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708179764; cv=none; b=ojB5YuTeDTMZT9UJx2ThD6zUOUrLSg2cxPr5Tuw3D5uvojH6nOh7T3+1K5MQOkfudnmjD9qlRz4A2uycIzpK9XS47/4b0s8GoZdp2yZbqwt3sR7ZfRFh+hxICp1utYYEw6AvLQOfFvRcnOq0p8MN3LyEP6us0gFeVPDKyJBzi/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708179764; c=relaxed/simple;
	bh=VcMLIF8Q6ahOuZble/9U0MmipeRj/zgJxTULtR0muYg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R87lBZX1uSF6OhqwWRovdGtxR8Bq1Q/WgfTus4db9Zrez55NZV7n9hnIEmW223QOZ20ecpbv5UppWWxS4KqQB1rACmUY6/+5f3K9qGgtRXWh+UA6LPEFJCYkhrSyzSiR9OHYxHC31bv1GXOgd1IhTAJmLSY7XUy5zQNI2Rbhir0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQxJTNEQ; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55ad2a47b7aso4079199a12.3
        for <bpf@vger.kernel.org>; Sat, 17 Feb 2024 06:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708179761; x=1708784561; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tYhRAJYP8s0DEnSJECrmTd21liNyoWYsDQJDTva1gNM=;
        b=FQxJTNEQWmGni9gLwaulv2JUq0AFNUBGH0LL1pj/yE3f81Ej6PpyZ3Os5EJuM0E975
         PowLBafaSf7FPx2cyoiKesVIXb3RfV6lVukZsy9CsvqLbuVrTkcq161j/Wt0j6VA74as
         wKSy1i6kkrT35uZY0aeR7yGbDp9MBAw+1grv9IiUNLiW0JHvIwfJaTWptw6DqpQRNYzZ
         MCTzAv/5heMRcnhxSrTdyGvc0aOHdUZlS0kPuQsKHxtP8RbD4msUyJT8+cEAnUX8wMs2
         jAEJ+pqPJafR4V7Wv1trzea2EFWOw1Z/jKjaWv5LX1tSb+LbrbUFJPOVm/N5JE2p3i8O
         o4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708179761; x=1708784561;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tYhRAJYP8s0DEnSJECrmTd21liNyoWYsDQJDTva1gNM=;
        b=hy3bYhT+jm6TLq07HDtea+2ElmTpGxC/cMRd/MqcSDHgZZ7oDzwyqRJDsgqFdnKfJx
         8FGTepAn9Op+wyUPfY09eCWTuzAKLMJLNpMdmXdFLb4GPjdZVal+J8tR7tHBW6wITYXc
         /EDUz770alx0xzmow6N8Ynlq1aPVs0cOXGc67UsAl4xxA9yrn9muvCwdglJglhNI4wjj
         LjfNGbY9WK5Dw2tTD28Ez3mwU3tv5lfnEvpBIvHTUL5zckLND3fhoVbN0ctNs4Atl2DP
         d0tbjC8wmXrwxeSPQCUf00hgc7fCFUYim14xYV3R8khxhz5PKq4CK84yzDeGPqiA3kVo
         Ay5A==
X-Gm-Message-State: AOJu0Yz5kmrGMpHMvQ2tYgLyiw/Iyh7F7+qN8F/YCwmclB4KwoCQNNoT
	Sgg9rS6wdG7kXJYMvHuWW8EPABQjP3Hp/vMWdOI2HKXpb6ncqT4y
X-Google-Smtp-Source: AGHT+IE6ZvN9tAc7JjyQ9v+yFloZ1p+gHOfhAJZVq1uonqdFHcy0zlKLdRF8R/S7KWtPLOKHn6BHoQ==
X-Received: by 2002:aa7:d354:0:b0:560:4e74:9cf8 with SMTP id m20-20020aa7d354000000b005604e749cf8mr5127393edr.34.1708179760970;
        Sat, 17 Feb 2024 06:22:40 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id ek23-20020a056402371700b0055edfb81384sm901540edb.60.2024.02.17.06.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 06:22:40 -0800 (PST)
Message-ID: <02780f953261e09bd5ec7023f16f45536b5b67f6.camel@gmail.com>
Subject: Re: [RFC PATCH v1 07/14] bpf: Use hidden subprog trampoline for
 bpf_throw
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>, David Vernet
 <void@manifault.com>, Tejun Heo <tj@kernel.org>, Raj Sahu <rjsu26@vt.edu>,
 Dan Williams <djwillia@vt.edu>,  Rishabh Iyer <rishabh.iyer@epfl.ch>,
 Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Date: Sat, 17 Feb 2024 16:22:39 +0200
In-Reply-To: <CAP01T7454ab6aUh_iE90qFLOUj+iL9uTUTy1Gbh1yzkh5-qrRw@mail.gmail.com>
References: <20240201042109.1150490-1-memxor@gmail.com>
	 <20240201042109.1150490-8-memxor@gmail.com>
	 <956ffbdd1998236db4c576606729303034fe121a.camel@gmail.com>
	 <CAP01T7454ab6aUh_iE90qFLOUj+iL9uTUTy1Gbh1yzkh5-qrRw@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-02-16 at 22:59 +0100, Kumar Kartikeya Dwivedi wrote:
[...]

> > Also, what do you think about the following hack:
> > - declare a hidden kfunc "bpf_throw_r(u64 r6, u64 r7, u64 r8, u64 r9)";
> > - replace all calls to bpf_throw() with calls to bpf_throw_r()
> >   (r1-r5 do not have to be preserved anyways).
> > Thus avoid necessity to introduce the trampoline.
> >=20
>=20
> I think we can do such a thing as well, but there are other tradeoffs.
>=20
> Do you mean that R6 to R9 would be copied to R1 to R5? We will have to
> special case such calls in each architecture's JIT, and add extra code
> to handle it, since fixups from the verifier would also need to pass
> the 6th argument, the cookie value to the bpf_throw call, which can't
> fit in the 5 argument limit for existing kfuncs. I did contemplate
> this solution but then decided against it for these reasons.
>=20
> One of the advantages of this bpf_throw_tramp stuff is that it does
> not increase code size for all callees, by doing the saving only when
> subprog is called. We can do something similar for bpf_throw_r, but it
> would be in architecture specific code in JIT or some arch_bpf_throw_r
> instead.
>=20
> Let me know if you suggested something different than what I understood a=
bove.

Forgot about cookie, however R6-R9 fit in R2-R5, so the cookie would be fin=
e.
arch_bpf_throw_r() that saves R6-R9 right after the call is probably
better than plain bpf register copying.

But you are correct that trampoline allows uniform processing in
arch_bpf_cleanup_frame_resource(), so it would be less C code to
implement this feature in the end.

