Return-Path: <bpf+bounces-48304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C65A06697
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 21:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 386D73A6284
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 20:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1788E202F79;
	Wed,  8 Jan 2025 20:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="SJsOsnfy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72BF1DFE06
	for <bpf@vger.kernel.org>; Wed,  8 Jan 2025 20:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736369184; cv=none; b=nLQ0NepweH2k8zuSaIwdutK1ifrtmkUQnevltu+dJ7T+h4MFcL8NYGF13YWPLCdwmJg0QQN3DHA6VU/RwsEqRnlGC9dDZxMykomanOLVLzm2q4ZE6YetiJLxgC7vcjfrwN5luT4bZGdzANXZaCepIpbJ3QfWFBB0xC48D/E1VSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736369184; c=relaxed/simple;
	bh=FQVN7XXGCosP66UzdRPdRl8CLFlxI5VV10/B8HKx/KQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=qirAaI1sOfxojh+Qr56l6IVEIgErsWv3BwjI9Eh7sMk7g9+RoydCWll10lNEi/Hb3mdK3hTDVu4G6P1zXPoWBct5j/ZIFkfn/0QkNy9s6wtX9sLU65HMjYcVclZgCtOqfxLiu1kxtzYN5WhRmkBUU3la+9tCe73mOGFByNVNVf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=SJsOsnfy; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43622267b2eso3058335e9.0
        for <bpf@vger.kernel.org>; Wed, 08 Jan 2025 12:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1736369181; x=1736973981; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3mh7Yl+kb2Efe0hrm7fy1uM3PnAAMORDqvyVc1CSxa4=;
        b=SJsOsnfy+g62dmHcBrzD1T6n+6HianP1/DOWwmUuNvfA7wkULLsJ5v2IKin+DaHj41
         N/5JFZMir0t7LcVE+kHGnLz+54dU6AGdgQ4j6hrd/y5QNIfig6LpvNEjfcuo9gHg345j
         X1ZLDEZZdc/3yP+zsDJV+t9ijhqkkOYSopkONtnd+YQ03GqsxctjSvCT1xZ69UPJDbVq
         qpgcA49j+6ZLVIme585sQoQqjUMn8W25YnRfha/OhdO0sHA7ahHGdaFBnW4/lOXxRlhq
         2W85zPKQSOFKystW8JMxWhDpXpZ+EGp9JF7OB7l8ikXZmaDuNn/obcV+QRPu9mqBFKsZ
         Xo2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736369181; x=1736973981;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3mh7Yl+kb2Efe0hrm7fy1uM3PnAAMORDqvyVc1CSxa4=;
        b=PGxFdnqo6tLEIQwzYF3TzbF17cWItbNaT+Px3SAQv3iA2qfixCrmNcpj4Ez4iDnyXe
         DnK6lV5I+jnwbe3C9Vsae60slK1ggyX1fzV7dg2P3LRzBVr7w2zTwuEJ6sPZmOxaSyhE
         Mc89MGVCIMEnNiHYU5nd/74JY4IK6/A9U2ewh2pIhpUvN9f4T3Cd1VJjlHOmCkhpfThQ
         TMBEdGUKZmkimUYHGoWpnrm29jpuYN1CVgRKaUyhDvhhPlNyYBH7IGHx0Ydzbc3lO7Ko
         dK3aXtIaKqXpvDOrtzMzKPNN4GLeY18q1ItcKgeDmlwq/KmF+LYnNRI/y66jrxRFwsIJ
         Jwow==
X-Forwarded-Encrypted: i=1; AJvYcCVMxR8lzBl/sBNYc52wa1VocJVbSNxz5vroXB/qxXMn+zV232Te9y/tM9OZn4ByaHX9JTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDdQykv7aNSiVZBz/xWbTFFfhzt1hGIIpn6fYRpH/TghvSHEVR
	nlqSE7M3ePErDWJ9bPW/qR6AulcUYiHqe7r/3hr4iLF7GEWh+nh7n5tsb1R/NT4=
X-Gm-Gg: ASbGnctpcZAzoGdYD9x4GtUuEhyJqhqnaledI3tOJk7WC/DCzlig6PWEG8CUpTkLU3D
	XE7FQwGzeBFlVkxHPNNKYTrhNx+cbKGLbhgTNKlAIljGjBMAUp4/CZS10M1OlHp45QFD0hfDZO8
	NkoMkwX/M1VusnpP3ujBpEkTHyTilx5SFUkmJE17X/6W7HIXXajG0b6noVIt09yubrvfQkQ3Im1
	6XHNC+FK3GsNe49IGfbidDAdrWy22j/Rs93ahcld04=
X-Google-Smtp-Source: AGHT+IGMadmWg07fsHs+82ZjWmi3TIICnIAYCCJN2tS8RFDo4nRSPZk8z0TndrPIk5URTaLiW6Ggvg==
X-Received: by 2002:a7b:c315:0:b0:434:ffb2:f9df with SMTP id 5b1f17b1804b1-436e26adf94mr40327325e9.17.1736369181280;
        Wed, 08 Jan 2025 12:46:21 -0800 (PST)
Received: from localhost ([2a09:bac5:3213:16a0::241:2f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2dc0069sm33262435e9.11.2025.01.08.12.46.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 12:46:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Jan 2025 21:46:19 +0100
Message-Id: <D6WZI57R29GS.37Z8R92TTJJUG@cloudflare.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "John Fastabend" <john.fastabend@gmail.com>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "KP Singh" <kpsingh@kernel.org>, "Stanislav
 Fomichev" <sdf@fomichev.me>, "Hao Luo" <haoluo@google.com>, "Jiri Olsa"
 <jolsa@kernel.org>, <kernel-team@cloudflare.com>
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Test r0 and ref lifetime
 after BPF-BPF call with abnormal return
From: "Arthur Fabre" <afabre@cloudflare.com>
X-Mailer: aerc 0.17.0
References: <20250106171709.2832649-1-afabre@cloudflare.com>
 <20250106171709.2832649-3-afabre@cloudflare.com>
 <f2b4420265b118f9aaaa329f86a5b52d48200281.camel@gmail.com>
In-Reply-To: <f2b4420265b118f9aaaa329f86a5b52d48200281.camel@gmail.com>

On Mon Jan 6, 2025 at 9:34 PM CET, Eduard Zingerman wrote:
> On Mon, 2025-01-06 at 18:15 +0100, Arthur Fabre wrote:
[...]
> > +#define TEST(NAME, CALLEE) \
> > +	SEC("socket")					\
> > +	__description("r0: " #NAME)	\
> > +	__failure __msg("math between ctx pointer and register with unbounded=
 min value") \
> > +	__naked int check_abnormal_ret_r0_##NAME(void)	\
> > +	{						\
> > +		asm volatile("				\
> > +		r6 =3D r1;				\
> > +		r2 =3D r10;				\
> > +		r2 +=3D -8;				\
> > +		call " #CALLEE ";			\
> > +		r6 +=3D r0;				\
> > +		r0 =3D 0;					\
> > +		exit;					\
> > +	"	:					\
> > +		:					\
> > +		: __clobber_all);			\
> > +	}						\
> > +							\
> > +	SEC("socket")					\
> > +	__description("ref: " #NAME)	\
> > +	__failure __msg("math between ctx pointer and register with unbounded=
 min value") \
> > +	__naked int check_abnormal_ret_ref_##NAME(void)	\
> > +	{						\
> > +		asm volatile("				\
> > +		r6 =3D r1;				\
> > +		r7 =3D r10;				\
> > +		r7 +=3D -8;				\
> > +		r2 =3D r7;				\
> > +		call " #CALLEE ";			\
> > +		r0 =3D *(u64*)(r7 + 0);			\
> > +		r6 +=3D r0;				\
> > +		exit;					\
> > +	"	:					\
> > +		:					\
> > +		: __clobber_all);			\
> > +	}
>
> Nit: I think having both cases is an overkill, as both effectively
>      test if branching occur.

Fair enough, I can drop the reference tests.

> [...]
>
> > +struct {
> > +	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
> > +	__uint(max_entries, 1);
> > +	__uint(key_size, sizeof(int));
> > +	__array(values, void(void));
> > +} map_prog SEC(".maps") =3D {
> > +	.values =3D {
> > +		[0] =3D (void *)&dummy_prog,
> > +	},
> > +};
> > +
> > +static __noinline __used
> > +int callee_tail_call(struct __sk_buff *skb, __u64 *foo)
> > +{
> > +	bpf_tail_call(skb, &map_prog, 0);
> > +	*foo =3D 1;
> > +	return 0;
> > +}
>
> Nit: I'd also add a test where invalid action is taken
>      after bpf_tail_call inside the callee,
>      just to make sure that both branches are explored.

Good idea, I'll add that in and resend. Thanks for the feedback!

>
> > +
> > +SEC("socket")
> > +__description("r0 not set by tail_call")
> > +__failure __msg("R0 !read_ok")
> > +int check_abnormal_ret_tail_call_fail(struct __sk_buff *skb)
> > +{
> > +	return bpf_tail_call(skb, &map_prog, 0);
> > +}
> > +
> > +char _license[] SEC("license") =3D "GPL";


