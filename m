Return-Path: <bpf+bounces-48005-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECC9A0317E
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 21:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69AE83A5BA6
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 20:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E081DFE22;
	Mon,  6 Jan 2025 20:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSUZI3YH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C4F1DFE18
	for <bpf@vger.kernel.org>; Mon,  6 Jan 2025 20:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736195664; cv=none; b=u6ZAbP01kyMzZXpTRVtJqN1TfY6TzQZpCn20Z3mKYiYCj0alqsmt5GVRH/HY05BUNMz5a2Bs+Lke5FpPlaXBylsHfkNz0oS8yK37Rc8bgUMSUQ725PmTBpwMtFuXhsAqQ0RrW/qGV0uxezi8GLu6OCVJ03HOehksa12z9W++y8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736195664; c=relaxed/simple;
	bh=3PEi1u991lUARaVW5pGo9dEzohAi3qsRVJ5V6Q7cjFk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NLtaWvoIhd/NI0lbtfIjXN68RvN/0fJWXJyQ00w6ofCU26J9FbvKetWzQS/0pqQs3vYGAXCGGPbsaK6FM1fCdCBo0d6R92E0xAZY0JKzGil39P1carM9Kc4QIhsEHcGY3GJrWbdacH1DZJF3QcX5EvuQYUQ/HCQhCDZJfepHiNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSUZI3YH; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21649a7bcdcso207698325ad.1
        for <bpf@vger.kernel.org>; Mon, 06 Jan 2025 12:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736195661; x=1736800461; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fY8/I7Beo0CtFIlze7ABHMBCALDKL8tDJlvM3J4CKYk=;
        b=OSUZI3YHxju7JR7e3NG/J81UmevGwJPOYBf4G48krm9srnLUnMf6PWJjKbd9kngLXU
         8qpWKcJTYI13L86yvBEHVQFADrwxKtAymYvj7MkHHwtGtM3dos+1XcDaEGtaNItup47+
         mdG8CmTP5EMPlEc1hUfETXuVsvHIJ7dlpyFxre4+JFIzkw3OHrXqh6VDW0848982bxfJ
         ukWRoCmAgGd15V1vwxhEZTNgrCEAr++h7Koj4Ux5W4w9UnetFGSt0ZwhIeKP7dxBCS9J
         f8FihW+1WI0nZHas8kDAgKdMJonEShmOH3KA/XF8+1ejAAFNKF/y7S+eGUoh3Dq8SHQM
         n6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736195661; x=1736800461;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fY8/I7Beo0CtFIlze7ABHMBCALDKL8tDJlvM3J4CKYk=;
        b=YiOXPVHmsUKZB4ghA9o7oWMKb6IB9SiD0zqB5QXv+hWNhuCtbndrQhjFTUvE68PFfW
         IKG1S/5f/X4iymIIOVJ6VTJno++4eOIVECpkZ/yg1i4JHjFXtTJTzDr3S9gA99Zf0t0v
         IQJDh+IQe2Y2PnH4rQ987AmTSqenZSPd8Bp+Co/2a1dcn7OV2DmnbuHXJMwAfq4pA7FL
         RehAbnQCkmatwB2nnboXvkdZkR3dPITZwDBrP09Uijknb+lsujhEZNmOtuiml7Eb2IuX
         UfVSebXBteEHIcbPIhmDOwG1/dZAML9P69tH3TkaHFtyWgdLouBwy3qXoACRITU+oybf
         M68g==
X-Forwarded-Encrypted: i=1; AJvYcCUvow/c5XLmUG8hcExEHWrm8A90wttP/51Ylsahwp26VVgkQ/4f3sgR/mZDt+SI2wyh/8c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy83bToUc5af0YupG38VByld2AYOzCwUIRsTORMZlx7baEyQrqi
	0MrXuCnZbpgSV2YhXpYVlXBkqZmUbDiZ3RlYyigdMbylkUnPX0Kn
X-Gm-Gg: ASbGncvYHnON3kHkW5qtsoje4TUOVDufgUCb0tGUA5qUQgysa7j7nbOcbrLT4JszQYh
	5oqNQZnouGw800TldXzno3o8kM3xDE/ee3KFRPmv4wvq952feu9U3XN6jVcBQWUEH75xzdJUNK3
	i8p5rMyUrKkIsIEangXFm5aZ+MTovBvtOaaBUiQzzt2/ZbN0I557yqVCuS0ZzJSSxBX3kwEXNrx
	sO+Eot5lFrhdbvibjVhV21fHoBMLStdf3vZ5blxgFMDYRz8r/blAA==
X-Google-Smtp-Source: AGHT+IHKG2n7Tobei7+bXc34izg0N/6yYjS3+eZCrqerela1TXBGz0Y8YQ0965Eaq6+yW6b7ArqPbw==
X-Received: by 2002:a17:903:1209:b0:215:af12:b61a with SMTP id d9443c01a7336-219e70dc4b5mr738955445ad.50.1736195660936;
        Mon, 06 Jan 2025 12:34:20 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ee06dd46sm39940713a91.36.2025.01.06.12.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 12:34:20 -0800 (PST)
Message-ID: <f2b4420265b118f9aaaa329f86a5b52d48200281.camel@gmail.com>
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Test r0 and ref lifetime
 after BPF-BPF call with abnormal return
From: Eduard Zingerman <eddyz87@gmail.com>
To: Arthur Fabre <afabre@cloudflare.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau	 <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>, Yonghong Song	 <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev	 <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	kernel-team@cloudflare.com
Date: Mon, 06 Jan 2025 12:34:16 -0800
In-Reply-To: <20250106171709.2832649-3-afabre@cloudflare.com>
References: <20250106171709.2832649-1-afabre@cloudflare.com>
	 <20250106171709.2832649-3-afabre@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-01-06 at 18:15 +0100, Arthur Fabre wrote:
> In all three cases where a callee can abnormally return (tail_call(),
> LD_ABS, and LD_IND), test the verifier doesn't know the bounds of:
>=20
> - r0 / what the callee returned.
> - References to the caller's stack passed to the callee.
>=20
> Additionally, ensure the tail_call fallthrough case can't access r0, as
> bpf_tail_call() returns nothing on failure.
>=20
> Signed-off-by: Arthur Fabre <afabre@cloudflare.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> +#define TEST(NAME, CALLEE) \
> +	SEC("socket")					\
> +	__description("r0: " #NAME)	\
> +	__failure __msg("math between ctx pointer and register with unbounded m=
in value") \
> +	__naked int check_abnormal_ret_r0_##NAME(void)	\
> +	{						\
> +		asm volatile("				\
> +		r6 =3D r1;				\
> +		r2 =3D r10;				\
> +		r2 +=3D -8;				\
> +		call " #CALLEE ";			\
> +		r6 +=3D r0;				\
> +		r0 =3D 0;					\
> +		exit;					\
> +	"	:					\
> +		:					\
> +		: __clobber_all);			\
> +	}						\
> +							\
> +	SEC("socket")					\
> +	__description("ref: " #NAME)	\
> +	__failure __msg("math between ctx pointer and register with unbounded m=
in value") \
> +	__naked int check_abnormal_ret_ref_##NAME(void)	\
> +	{						\
> +		asm volatile("				\
> +		r6 =3D r1;				\
> +		r7 =3D r10;				\
> +		r7 +=3D -8;				\
> +		r2 =3D r7;				\
> +		call " #CALLEE ";			\
> +		r0 =3D *(u64*)(r7 + 0);			\
> +		r6 +=3D r0;				\
> +		exit;					\
> +	"	:					\
> +		:					\
> +		: __clobber_all);			\
> +	}

Nit: I think having both cases is an overkill, as both effectively
     test if branching occur.

[...]

> +struct {
> +	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
> +	__uint(max_entries, 1);
> +	__uint(key_size, sizeof(int));
> +	__array(values, void(void));
> +} map_prog SEC(".maps") =3D {
> +	.values =3D {
> +		[0] =3D (void *)&dummy_prog,
> +	},
> +};
> +
> +static __noinline __used
> +int callee_tail_call(struct __sk_buff *skb, __u64 *foo)
> +{
> +	bpf_tail_call(skb, &map_prog, 0);
> +	*foo =3D 1;
> +	return 0;
> +}

Nit: I'd also add a test where invalid action is taken
     after bpf_tail_call inside the callee,
     just to make sure that both branches are explored.

> +
> +SEC("socket")
> +__description("r0 not set by tail_call")
> +__failure __msg("R0 !read_ok")
> +int check_abnormal_ret_tail_call_fail(struct __sk_buff *skb)
> +{
> +	return bpf_tail_call(skb, &map_prog, 0);
> +}
> +
> +char _license[] SEC("license") =3D "GPL";



