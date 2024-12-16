Return-Path: <bpf+bounces-47051-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B73509F37B6
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 18:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40356188DDEE
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 17:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69775206294;
	Mon, 16 Dec 2024 17:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="VxZ30YFi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38053161302
	for <bpf@vger.kernel.org>; Mon, 16 Dec 2024 17:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734370782; cv=none; b=hH4D8DViN5RgAPItkvrkHFtvqpAvg1HM5VGz7LQgqtNp+xrZz4Cq0qd+RXbKvJJ9zpVErS6LwsBLBL99BW5D2g4McJ9hXZblyT1K/bOSvPPaGoT9nAMEc2SM3nQQbq0EXCTReJck8ydVTXIo/a7w9IL1VNpdTve5IcUr6uECHHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734370782; c=relaxed/simple;
	bh=U+8znKEz2YfXhyTvIm83OodGYDQQxrY6mX+0gLUiNsE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ByrgZL4g4YjguvFMUP8T2xRQiHieAzsjT5tEEiAMiKrTsawImioqlTdtnVpsY/Hi1TGzd3P6jfEoxsYc8N0YoSstE4GAqQvthDd+vm1Iiht7oqzqLvi/pte1+iTs1as4Gy1GU9wl9e/npRya1rzxDNU7YKFR68Jc3YbqxWOBaws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=VxZ30YFi; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d3e6274015so7680204a12.0
        for <bpf@vger.kernel.org>; Mon, 16 Dec 2024 09:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1734370779; x=1734975579; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vq1wiAaMZvSDKgx7xAEMPkEv6TTMwkginHdh7T15Pg0=;
        b=VxZ30YFiuO6vDT+CzVFFgQfetj7S5HAlo/y92j0leCe0ChxRjSjY+tjKXfEc4PMVLE
         jnwYY8TkuBWtM9+knsp5+vQ2cjbh+W5T0mCPR1Fw8QhbpTuGMKNmJeev5dahZjQMPzja
         ADo3Ba+Sxb588qHQP/J/ps+BchC40/bIWASjCV/yYsGpxNKkBM35ma/G2p9YB4uX1Jt4
         1m8lIvTDvY6AGDseW0sOsrMsOIQBITlEQ7lxvZCVlp6vhFVlvFV4+2BGearmAXBn6Ghi
         lid/U633VuiWz8SDs+8svLSlJbemA4v5FshhJVaQDBXiARV1a3R5Dkfh3lm+etld34JW
         6/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734370779; x=1734975579;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vq1wiAaMZvSDKgx7xAEMPkEv6TTMwkginHdh7T15Pg0=;
        b=uplIUbH3qAFQ1H1m+pjfGHYNJi5GQ9b26a3/OreQ26eOPunam482mZU9Q22mQ4qMT4
         GNhLLEAUy3zJ9P0GCO7obQ1V3yEGaJbfw1zQTZRFUtHw5RPLOEHI32QyiXl5xi8et3A1
         8q8YPA/wwBOs9REhR7qkInUIpK92HiI948YCTuCendJ3tC/pNehqBuZ3TAgkF38vRWm7
         o8rL8fA3lkssCpPwFRnqGUovktyxs/pS+IrGyG6EJW6qLSH/M7dSKi6SXmIjETCeGSlO
         ENJSPS71DUhwG2TMb2JkvfNDmvSfmmt1l3ARZeLaNMLxm84YBoNWJY2ndeCNOl82dFVN
         auWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUc5DmMS6r4q6NMjLm57tWKe8XvZWk0H9TEtM9c2zBPkzf316f6P/eSUHQg2XbLzn4khio=@vger.kernel.org
X-Gm-Message-State: AOJu0YwraTwp8gUDnr6RXWM7WfwgmfIBqUQHFpgTSWWs6238JnRsAew1
	EZOPJwJLsEuKYX3xKRo6I+D7JH5BKAkFDM7v0SC0xjAeprqnJAFf/sCnHbt3k4M=
X-Gm-Gg: ASbGncsHzhcyYmpih14NVdtRflFlYCuOCgTxE+wL7uLGrc4BxDxa1WL/PdlAiYSWy+I
	IHV+mNsh6MxSYrEe15+QDG2AgRKbZqnkRwCiWkDZbY/uPUDjQXqJUF1ot4v1xDhRGv7m7Y1HlUc
	3qVmrun9yIusNimcmfU+XRVqZq02WnsN6BbyrM4byBsAv3dvleWy0YhpIDQGIkmTT8MCt1TQO3q
	CxVdFV8bWsen97yWguwNYUllLqnXxk27Pk9WbyBCw==
X-Google-Smtp-Source: AGHT+IFFEUnNWinE4X85+Cd8RAMuLtU0Dzy4ShkcFEcISQ4tgAqOEkSvBSfXerOh8Hdcj3z8GN5ocA==
X-Received: by 2002:a05:6402:2695:b0:5d2:728f:d5f8 with SMTP id 4fb4d7f45d1cf-5d7d40dbd9dmr521618a12.27.1734370779451;
        Mon, 16 Dec 2024 09:39:39 -0800 (PST)
Received: from localhost ([2a09:bac1:27c0:58::3b6:40])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d652ab50absm3382977a12.7.2024.12.16.09.39.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 09:39:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Dec 2024 18:39:36 +0100
Message-Id: <D6DB4NCLQZC9.I7DUNKR9RORW@bobby>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "John Fastabend" <john.fastabend@gmail.com>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "KP Singh" <kpsingh@kernel.org>, "Stanislav
 Fomichev" <sdf@fomichev.me>, "Hao Luo" <haoluo@google.com>, "Jiri Olsa"
 <jolsa@kernel.org>, <kernel-team@cloudflare.com>
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Test r0 bounds after BPF to
 BPF call with abnormal return
From: "Arthur Fabre" <afabre@cloudflare.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.8.2
References: <20241213212717.1830565-1-afabre@cloudflare.com>
 <20241213212717.1830565-3-afabre@cloudflare.com>
 <76401f4502366c2d9221758f9034aa7bb2d831a3.camel@gmail.com>
In-Reply-To: <76401f4502366c2d9221758f9034aa7bb2d831a3.camel@gmail.com>

On Sat Dec 14, 2024 at 12:55 AM CET, Eduard Zingerman wrote:
> On Fri, 2024-12-13 at 22:27 +0100, Arthur Fabre wrote:
[...]
> > +++ b/tools/testing/selftests/bpf/progs/verifier_abnormal_ret.c
> > @@ -0,0 +1,88 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/bpf.h>
> > +#include <bpf/bpf_helpers.h>
> > +#include "../../../include/linux/filter.h"
> > +#include "bpf_misc.h"
> > +
> > +#define TEST(NAME, CALLEE) \
> > +	SEC("socket")					\
> > +	__description("abnormal_ret: " #NAME)		\
> > +	__failure __msg("math between ctx pointer and register with unbounded=
 min value") \
> > +	__naked void check_abnormal_ret_##NAME(void)	\
> > +	{						\
>
> Nit: this one and 'callee_tail_call' could be plain C.
>
> > +		asm volatile("				\
> > +		r6 =3D r1;				\
> > +		call " #CALLEE ";			\
> > +		r6 +=3D r0;				\
> > +		r0 =3D 0;					\
> > +		exit;					\
> > +	"	:					\
> > +		:					\
> > +		: __clobber_all);			\
> > +	}
>
> [...]
>
> > +static __naked __noinline __used
> > +int callee_tail_call(void)
> > +{
> > +	asm volatile("					\
> > +	r2 =3D %[map_prog] ll;				\
> > +	r3 =3D 0;						\
> > +	call %[bpf_tail_call];				\
> > +	r0 =3D 0;						\
> > +	exit;						\
> > +"	:
> > +	: __imm(bpf_tail_call), __imm_addr(map_prog)
> > +	: __clobber_all);
> > +}
> > +
> > +char _license[] SEC("license") =3D "GPL";

Thanks for the review! Good point, I'll try to write them in C.

It might not be possible to do them both entirely: clang also doesn't
know that bpf_tail_call() can return, so it assumes the callee() will
return a constant r0. It sometimes optimizes branches / loads out
because of this.

