Return-Path: <bpf+bounces-65920-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B56B2B025
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 20:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B18851B6027E
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 18:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391982D24A3;
	Mon, 18 Aug 2025 18:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Lgk5T4pE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290C032BF51
	for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 18:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755541416; cv=none; b=k9FpAnk/OxpsDgRUF6LlAvh5gtEv7nK39rMupN23xpB0+5jAIZtwkVH8Xbvqgx9XUBqGohEano6Kn9y4AJ+SIRN75eirGXpEn+PqJUxPkaehfaEJtPYaul+jQm4mMG9+R7vUcBBZcfFEGcNzfRb1p0c3TkGPoxM1nARzW2sDUeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755541416; c=relaxed/simple;
	bh=o5ANg99cngFK1z2paNVWzduyFXx7OHRbYdzjLYF4sR4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GTFJod18zKhggKLHj8xc55xC76myjM83TsRWG/l+RfP5JpDYPTgevoN8Ikj3V2dT81VjnIekxxbUaM89WYOcsldur+XjJCHAqHlzCoDXZP82wUznyxPZ97XFyYaSktShSiDGXZeLm0aIQLi6R88HDM1Xf6pj8tMrcdv+TF50r24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Lgk5T4pE; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-618896b3ff9so8779110a12.1
        for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 11:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1755541413; x=1756146213; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+ZTcdISe83BaeHj593XEWcMz30uuHoXQTWxMDez5msQ=;
        b=Lgk5T4pEKg9PW67oAiEXu7YPG0XVdrCqw6hVT65qUqUbAKepKakk3N194i12Jd4nFX
         XD+Cc3V6nf2XcRHrVeO5t2h1tYEKByrCIcSkUwdsz1p/ngCoARtdVc3lJymlF44x/UPj
         X3cpoIf5xeQOK6S01U0qKotLNYvqimfQDhety4J6mmIlzHyvIlS7hFAPC2Yd15REVpoF
         3V2sDFzgjpdIVeR7FLdklXBJMyNHdSWrLwrZwt+7Vc/UOps7culDCrgdjS68GOYRg6cz
         PcqAVK3TLCaEin0Gu7bRN+8Avq/qM6u/pwBm9Qs/DMMw+vmUzC4LDRRD0YgFGKV70MZe
         f2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755541413; x=1756146213;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ZTcdISe83BaeHj593XEWcMz30uuHoXQTWxMDez5msQ=;
        b=hdiCFjLha8SuQ6BJWg5HuE+HFCN/jWgwOyJ935z9xOUk9mi6v3//eIxg3b/s+UcP4q
         YTnT+VeYQIUyc1+DG5j6IM55WXuZ+Gca9VnFjgrEmH3BBhDrd0vGCCj5e4U7L5r+R9Xu
         CxucfXDxcbGsLwTCz3BoFDJ62I1cs4LWszH8VyymWFAwh63qAWZ9ICcxzs7c6gfm0v0x
         bDrDkW6HEhQ73HvVW8ISvMwvsVl53PNw0ung2IJRGo6IP2JWFD/q/SnCi//PxJNtAD2m
         VVAyBpV86gLiKYe3K1+INnjp5DWbRa8IDIyix79TwJn7hdVFS7juuFukEN3v8t67ir0z
         Tcvg==
X-Forwarded-Encrypted: i=1; AJvYcCUfaJXgXBbrEV8idmOkX2JEYXGioWjNVm5zBH4J58zRZ+GRltf6Bb2msx94f02WQZeNi9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjFveFQbYVhAQUbw6NVKuW7HEUK1NnAhEqmVPogHg/RMQ5K/5B
	0VM8ecihZQvg+sR/6KqXI++yxgxgmdY+EwSWXHyQ90SxbfJgyesMUxSN0kBkyb3Rlng=
X-Gm-Gg: ASbGncucQD5cPX3PZLCXmcGohAfsoO03AYbCUBbng/xFSplORcLLn/dK57dle/bneNM
	3cv9iHdeHTfcyoDZ/Er/icBrnEI3EP1HV0BeFs0TTpKA1A114GNBi+PgaImKFkcGm6QH2q5dN+U
	sQF9Vgu432f77Y8gwm2sVEzZ75EFaxOzsYN6mB2/lfeOl1d/eRPQJAiTyCdcr9d/U4eDjixx8Ib
	Rtpup3udANQkaAhSlpK2G9EKJN0c54gITaLVOfRSE9mpSxamw+n6QPUdiis3MOe6DQECZ3Z3RRI
	+HzEQQCp+CSZJBJ990d2AnYstXCTHWlFKbwWdsM33Q+233z1R5RS8Mltd/D5RnIbFqWbvJa7XDO
	ErsiCFljGJrr7Cf8=
X-Google-Smtp-Source: AGHT+IFmwNWaVTHlBu9YDfORnGsUddH7cG/DT0gI594sr5e5nblhk9BHDysuXmGVTQZbwJZqp1om5Q==
X-Received: by 2002:a05:6402:26cc:b0:613:5257:6cad with SMTP id 4fb4d7f45d1cf-61a755c29f6mr513323a12.11.1755541413359;
        Mon, 18 Aug 2025 11:23:33 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:ca])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a755d99bbsm282571a12.3.2025.08.18.11.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 11:23:32 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Nandakumar Edamana <nandakumar@nandakumar.co.in>
Cc: Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,
  bpf@vger.kernel.org
Subject: Re: [PATCH v2 bpf-next] bpf: improve the general precision of tnum_mul
In-Reply-To: <20250815140510.1287598-1-nandakumar@nandakumar.co.in>
	(Nandakumar Edamana's message of "Fri, 15 Aug 2025 19:35:10 +0530")
References: <20250815140510.1287598-1-nandakumar@nandakumar.co.in>
Date: Mon, 18 Aug 2025 20:23:31 +0200
Message-ID: <87tt24zdy4.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Aug 15, 2025 at 07:35 PM +0530, Nandakumar Edamana wrote:

[...]

> @@ -155,6 +163,14 @@ struct tnum tnum_intersect(struct tnum a, struct tnum b)
>  	return TNUM(v & ~mu, mu);
>  }
>  
> +struct tnum tnum_union(struct tnum a, struct tnum b)
> +{
> +	u64 v = a.value & b.value;
> +	u64 mu = (a.value ^ b.value) | a.mask | b.mask;
> +
> +	return TNUM(v & ~mu, mu);
> +}
> +

Not sure I follow. So if I have two tnums that represent known contants,
say a=(v=0b1010, m=0) and b=(v=0b0101, m=0), then their union is an
unknown u=(v=0b0000, m=0b1111)?

Full disclosure - I didn't read through the paper. The routine doesn't
seem to appear there, though.

