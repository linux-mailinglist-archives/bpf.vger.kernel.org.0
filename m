Return-Path: <bpf+bounces-69258-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17224B927BA
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 19:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32CB61904E3B
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 17:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216493168FB;
	Mon, 22 Sep 2025 17:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqsapKxD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9EA944F
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 17:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758563503; cv=none; b=UJKwxzBBicwBa0V2UGmxXMBAvW0pGPwdkEVTzaZ1dM7vjq+4ExtRKB7geKCeLGMczluGiKPjpfrIHNSSQ3R2VzUlNm2gdAURg8YWB1NsjvqcVjaeHGK7JxYrgG78QI9faMvxU69Ub9MrciysN7wBxa7/HMdrYxq5Lnw+f8KZ3HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758563503; c=relaxed/simple;
	bh=SQbJ63UiXKfvQf2cDgzKOD2MadvCiE5SXr0RWoDxNiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VartnW1abMtCy+HrUHq//dXxpwLMvhgrTn92AhF/M1necfWvG5NYhrYZF6yvvk6LKoS2yRQutHpfpWKg+kdoT2JLKuHBIRz7CwtnfN4Ajh2c6GReeLtySuuGWUkmkO+0GoIfoy3IKPOSobSF8wdBt0q8XEWVkI1datiOmowfo/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqsapKxD; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-ea5bafdfea3so4679822276.0
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 10:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758563501; x=1759168301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNhbDqEZemd4OEZbaMDZZJn1QcvJOY3gKIH2LA1yh9Y=;
        b=ZqsapKxDirpEDzg3UkDBzmwVhKHEyOb1M+Kt1VzJ/rjc/FJM4DuvjVeOGnCbMVicCs
         1itxH+e5WhovPe6wdglsiGpHiF+KN7bb3LlJdc09E+7w4OnPLP7Cm8py1FGyNwJ2sTGQ
         28kOObXS2Dy54G5+drOHenO/JPz1DoVpR6kLbIYHsfOXnPD5dTIAC4AcJ/K1V1vR+CLM
         826r57NDolDNZLMycPpxI5JZKfBj0xriOElijmal5oTpq0RirPJE4RuYNj/ZN1OdERDq
         1UETBlzH9aNme0lkBj6TqKjfQ3ozePN53ZCGtP+PRfwbNQFB5kLPH/4hmz0GQXzQKotb
         jzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758563501; x=1759168301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNhbDqEZemd4OEZbaMDZZJn1QcvJOY3gKIH2LA1yh9Y=;
        b=QiyunCaYIF9jXpEvzCpY6EHy3VCoerHM8J6cEeBvw2BWnbOJg4fWg/8JvwWW/WJGK0
         jBQSP462PbfQ/OYvggfzgiaKi2trAdN5aZQSGw23UCp/FvbxTd4yV8j0EDWFUfkdVyIj
         UbdgyPIYvLtgTs7lv9K+n0np0Wa3zaYOrEmhyeaxEN0EzMxnfNYrZTSHbkh1D4cWyae/
         VSd05Z+n6EVCksS8n6VxNL2jtJjXlRthPzpJBl3Wwc0gMCtEEfUsNXgINO04ImsfAtiV
         6x5jyzA2uhIojcEsXSPvJNTRDY23ZqRQr2QjhcuGmIvDWRPPQT4+AvqwP0r2fcDV6uzQ
         cKzA==
X-Forwarded-Encrypted: i=1; AJvYcCWwd2nUX2iSj3vC61WS38UKXsts5SOw/OIgLFlFCRB+S+sn79Pe1pe9MtcaitKDN/ZpkVA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn6s1uvXxzAdgXWsE+n/c+M4qvI6bmCULp9S1tCFQgwwhZkC1H
	Cra8MJKiaV97FCmcIlpT9T0QhSqKp+yCaYyLM1WPbHNGbfLglSFkUAYTOCLTJZUaD2OBfqoyHzl
	ZrxkNjBMMrrj99Xh92s3KXGUX3CzX1kI=
X-Gm-Gg: ASbGncuOgg7Ir+YBW9GT0TJqRXEZz1qVKGzYsGF2tCiacbdwbNB30zyEMz8qMxgSCUF
	t8j0FwfCKBwRcFAX0x2Xnp5w5FEE1Cenuv5eM1gg445V72IX4waeHE+7cO2d7XWAmxlfPgl0L6U
	RAXD163SVTuhvLgKfYzfbBLEN10hDnLGuE++plQjetVZqFJKvg6PnyRmTy7i9hi/D6iZMSNIQYF
	fMDMRjDbknOxu6QpuD2/g0=
X-Google-Smtp-Source: AGHT+IGHOhrpN1lUQpQk5kWDkZH8pO7att2cpJSy4rXbSanAz6B+3hAZpVyAd2nNq/tj/BHBNtrrqT7ew/6hng0N/Ak=
X-Received: by 2002:a05:690e:2416:b0:635:35a0:c5a0 with SMTP id
 956f58d0204a3-63535a0c7f1mr4487259d50.0.1758563500999; Mon, 22 Sep 2025
 10:51:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915225857.3024997-1-ameryhung@gmail.com> <b67f9d89-72e0-4c6d-b89b-87ac5443ba2e@gmail.com>
 <0eb722b9-bad9-43b4-a8a7-6f91f926e9f5@gmail.com>
In-Reply-To: <0eb722b9-bad9-43b4-a8a7-6f91f926e9f5@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 22 Sep 2025 10:51:29 -0700
X-Gm-Features: AS18NWBn9ZM3J7rAcYprmeTu6gzX3lsSh8_IXEZf-X_nUypiwWXdzxCDhVMlKqg
Message-ID: <CAMB2axMCmf9qFp4mRoeQZC2VQQmA4zLQtsBgCpXkXKaAQQNgSw@mail.gmail.com>
Subject: Re: [PATCH net v2 0/2] Fix generating skb from non-linear xdp_buff
 for mlx5
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, kuba@kernel.org, 
	martin.lau@kernel.org, noren@nvidia.com, dtatulea@nvidia.com, 
	saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com, cpaasch@openai.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 21, 2025 at 4:24=E2=80=AFAM Tariq Toukan <ttoukan.linux@gmail.c=
om> wrote:
>
>
>
> On 16/09/2025 16:52, Tariq Toukan wrote:
> >
> >
> > On 16/09/2025 1:58, Amery Hung wrote:
> >> v1 -> v2
> >>    - Simplify truesize calculation (Tariq)
> >>    - Narrow the scope of local variables (Tariq)
> >>    - Make truesize adjustment conditional (Tariq)
> >>
> >> v1
> >>    - Separate the set from [0] (Dragos)
> >>    - Split legacy RQ and striding RQ fixes (Dragos)
> >>    - Drop conditional truesize and end frag ptr update (Dragos)
> >>    - Fix truesize calculation in striding RQ (Dragos)
> >>    - Fix the always zero headlen passed to __pskb_pull_tail() that
> >>      causes kernel panic (Nimrod)
> >>
> >>    Link: https://lore.kernel.org/bpf/20250910034103.650342-1-
> >> ameryhung@gmail.com/
> >>
> >> ---
> >>
> >> Hi all,
> >>
> >> This patchset, separated from [0], contains fixes to mlx5 when handlin=
g
> >> non-linear xdp_buff. The driver currently generates skb based on
> >> information obtained before the XDP program runs, such as the number o=
f
> >> fragments and the size of the linear data. However, the XDP program ca=
n
> >> actually change them through bpf_adjust_{head,tail}(). Fix the bugs
> >> bygenerating skb according to xdp_buff after the XDP program runs.
> >>
> >> [0] https://lore.kernel.org/bpf/20250905173352.3759457-1-
> >> ameryhung@gmail.com/
> >>
> >> ---
> >>
> >> Amery Hung (2):
> >>    net/mlx5e: RX, Fix generating skb from non-linear xdp_buff for lega=
cy
> >>      RQ
> >>    net/mlx5e: RX, Fix generating skb from non-linear xdp_buff for
> >>      striding RQ
> >>
> >>   .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 47 +++++++++++++++--=
--
> >>   1 file changed, 38 insertions(+), 9 deletions(-)
> >>
> >
> > Thanks for your patches.
> > They LGTM.
> >
> > As these are touching a sensitive area, I am taking them into internal
> > functional and perf testing.
> > I'll update with results once completed.
> >
>
> Initial testing passed.
> Thanks for your patches.

Thanks for testing and the review!

>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
>

