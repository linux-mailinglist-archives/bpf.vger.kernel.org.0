Return-Path: <bpf+bounces-78207-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CA8D01554
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 08:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32E423007EC2
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 06:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A7433C52F;
	Thu,  8 Jan 2026 06:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrPRtbbR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2B633B6FD
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 06:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767855568; cv=none; b=fmyabjWL7UenTmBhAnXMJnYHgkUqoEV97JpScPay/9kj+MYDfQon7XBW1MvlX9/0zDl8vvy3C0WTEtccucNTikHfDEVFRAk1/xGoNcdR1p6J7vGVCujc9vTlDdeGkosdE4OKEKCBVaUGD6OGgt+i4/spMVRUuOGNlnUHXMGIjws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767855568; c=relaxed/simple;
	bh=IjEcv5v+U8j8G1xjMO4GWhEX/+yFeMwldk+4iEjdGTo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eeivBraTaW3Q/wFs60/01b03i+BY/pDKr1mlm/38H/sPmQyYNvfbaCKa3vwe33Lg7Dh8dChJA6Y8fy9g/7oGTng7TZXswPWodG64oo/IIc5nGz7Sc938TfO8Mp1WNiTHwEB/w080ttpbRLqr5AJ6EU+kaco7TqINV2hMn068j2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hrPRtbbR; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-bd1b0e2c1eeso2010780a12.0
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 22:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767855567; x=1768460367; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mUxhOekpcDTM0vEhuFnAbcAfHyhmPpnB+A4oywBSYn8=;
        b=hrPRtbbROPxopy5kZBHr9fs13aSRD+lEs8RMl9jjd+7SuGoU2yUpIMvHMBrcQUv4g0
         9bZQbszEaD0oXHeeK59IZiIPukyUs5N8Ja29px+6+JuMSQPNBFh2cqBxEwe7AdSxOWIr
         qw080L+zq72s/SxPIkOOWnNW12brB5sXbhpeko5oPlXZGSHbSrBD2S9aWeXtOH38Dpcn
         hkwZcNc9pl1ipJWIchpOcwFXmpQuADjUypC99k0/X2Kis/h2PGhudJVWZR1STvV4kFBv
         SvVbIjlVeRa1a/KozjnEycTBfQXgjw+waLl+2l0h6GjrDclhPKLKFUq1cc/zOJgX0XYw
         SNtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767855567; x=1768460367;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mUxhOekpcDTM0vEhuFnAbcAfHyhmPpnB+A4oywBSYn8=;
        b=lNVJaP3uDocF4D7jeM1AzZB6n08GDDO9cfR9gQvP8fkv3GGJhr3iyXbjwfYgaJEaE1
         aH5h1dGZA8GIDdKxdCIEVoHoAOcsiWY5KDu6okUjAMfDmZKnjb2Ocx7VSJfDytIWmu2v
         7Hp9A8gstNJ53s4Qe1BcufcNUpHdkTldm1pxBQ69uenzV/gG7AisqnCv8iFt7oeHW49F
         +m0I8FK2iPqoRrrfKZi242ZkjrDXApjiZRL0EAVbrgRFOC+Ia6Dr5KlKHw27F3iKbZ8V
         n2GU9Eoxmne0Xl2IPW4TmW+6WtgV/oITVKZESldJcM2D0S7KQgLDM0tvJDltwYfSmsqX
         /sOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHLNN9zzU47cmLT4L9qEnd1rwlQBGX2oVoZldlkr25ED7/fFjvtn2es6xJjUIWNtE2d7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRLS+aPo7AYxK9M9qZLEmDLnA9QxRuaIJ7MwJRMP5OplJ7hHG2
	Kv3bLW5DmaHhHjVZbBNIHu1K7EWdXqVO5ah9kguAZn6iCSA+N9e/Hy05
X-Gm-Gg: AY/fxX6/yCOyKvyqGZGgEM/IfQ/2/bLBO7m4iaqr91goEu9HEgZ1p/zazaKx/cbaXSQ
	axqW8m9U2m+FgBBHfyMbmznEj+7MSK2IdnrjNxeUdvw5206LkuqccGRv4EpH4MEgG+7l3CkmLvF
	YEzjPEajARCQE6OcC4MLyBJklH1sNNEOTz+XVudJAtFSuZzlP4PzKOaeyHBlXRe1OjNbEXgEECR
	qSk+y7/WcMgnIM4Uyka0fVia2u7LRTWtEDyyAO/ItVLYwFc83AobXFgkf7OdO/L0NTr474vEc+k
	8UkiLLonV+nywJfurqDgg09LNX+r0Pj+R8BAwAjI5s5l37uyskdEiGZgT0DvxkZU8pUI2R/TfZS
	sr1xQBcSo4kIfYawQOSqzbhHHMxswq4ZfJ2lOTkM9D2GGdefRZeP6+tcZwoS2c+7alC9HOD7t87
	50csXGru7f
X-Google-Smtp-Source: AGHT+IHQJSzDHLPktydQxaoHTqgghF6BQtrAMExDgXj7ZgqKb/BZIrfVts71iTzWfrOk4aQ5X8RbbA==
X-Received: by 2002:a05:6a20:9184:b0:350:7238:7e2b with SMTP id adf61e73a8af0-3898f88ef8emr4406039637.16.1767855566834;
        Wed, 07 Jan 2026 22:59:26 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cd469dsm69087555ad.94.2026.01.07.22.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 22:59:26 -0800 (PST)
Message-ID: <d64c1ff42310fc6c6284add088e598df078559cb.camel@gmail.com>
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Update expected output for
 sub64_partial_overflow test
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau	 <martin.lau@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko
 <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com
Date: Wed, 07 Jan 2026 22:59:23 -0800
In-Reply-To: <20260107203941.1063754-4-puranjay@kernel.org>
References: <20260107203941.1063754-1-puranjay@kernel.org>
	 <20260107203941.1063754-4-puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-01-07 at 12:39 -0800, Puranjay Mohan wrote:
> Update the expected regex pattern for the sub64_partial_overflow test.
> With BPF_SUB now supporting linked register tracking, the verifier
> output shows R3=3Dscalar(id=3D1-1) instead of R3=3Dscalar() because r3 is
> now tracked as linked to r0 with an offset of -1.
>=20
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---

W/o this patch selftests fail after patch #1, right?
We usually keep such test fixes in verifier patches.
Such that selftests are passing after each commit,
This makes any potential git bisect simpler.

>  tools/testing/selftests/bpf/progs/verifier_bounds.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/=
testing/selftests/bpf/progs/verifier_bounds.c
> index 411a18437d7e..560531404bce 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> @@ -1477,7 +1477,7 @@ __naked void sub64_full_overflow(void)
>  SEC("socket")
>  __description("64-bit subtraction, partial overflow, result in unbounded=
 reg")
>  __success __log_level(2)
> -__msg("3: (1f) r3 -=3D r2 {{.*}} R3=3Dscalar()")
> +__msg("3: (1f) r3 -=3D r2 {{.*}} R3=3Dscalar(id=3D1-1)")
>  __retval(0)
>  __naked void sub64_partial_overflow(void)
>  {

