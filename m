Return-Path: <bpf+bounces-46915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9799F18F1
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 23:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE2797A03CC
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 22:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B05F1990D9;
	Fri, 13 Dec 2024 22:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibZyrK9t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E82A1DA4E
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 22:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734128243; cv=none; b=loSyReWN2y5fP4csHKf4csz7dG7dVV0ENVW0X9ZbW6tr/be1DKiVPhJ/v7dbliSt+cV7q6/XsL8WXwiAOElAJh+QhSRoEnqQM0kPJOmkl1IJ3EhdZbjncR8YTEcArLjsj7s4lAsuZpMH623tsjif/9Hb7r18iK2svyauBL4Ymcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734128243; c=relaxed/simple;
	bh=ezXD5JgQ5KUwM6eWHGbmG+9zqwVfY0ou+JWBAvwW6HU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=otM9i3HpFm2GUA5KRIc8QuKWCQ4JMtJQTSnBfKC+Lf2g+EPYkrXWI2HnEZKdknSn7L1k2g09kvsAiWQSeufXiIk3EImGOaPHoL23rm4KvAq2L8kD6+jU9y51Gb2tCKSl5W8+Bwwn4Af1pBA3PFYzP1pQ3DhX8ccv89cDMPmixzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ibZyrK9t; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7fcfb7db9bfso1702855a12.1
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 14:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734128241; x=1734733041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUBc/nwEQIuUE2wj9OqaeofjTTdUgXgJTWJzGO6yf2U=;
        b=ibZyrK9tZeu1B65duG2Y3I4ACtv8nAKzgYkiroJx5N+w7wZixVIlwN2gA6YeJM2amA
         Vw5XrjXFH5rv1iLg6FDlyQGOdB9Enb0Xq4a80d5ybxDcBks3v+9A032XanfT9pZXyX5r
         0UXjAtGpUtUzVtrjsa+NXVEuKMbrFIchgsv2okUP5Ti7lU4/VGVTuucoC60tKP5xZKht
         W9pc12VvhlZmFpppIdm1SzTQtpcHAeoZZ8H2g/IHvINfdmG6WpMiNnmVF1a0o5vjP4kR
         u7+Gc7ze3ggGfBr2bCl2j+V/XFJlxTzgbSMHX9AI8SInN1NKYy9PhJ2vO/CGrPjLxOky
         26Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734128241; x=1734733041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pUBc/nwEQIuUE2wj9OqaeofjTTdUgXgJTWJzGO6yf2U=;
        b=AK/V9bc0hZLZCDJGk3SqpLqVeC2AnX3mTYBDPh0jvjFCLc+w+eyhn4/ep4q1z6Vtb1
         mD2TYwmdNAhZkPq9VaHGlI3h5GUaRQK4CIifdUTPCktfT3og05lHFezjPTGwCRozOqiv
         mNLg6hxVzBC5Sj4H049X8x4Lq2Mg7gW9k8g05p7+Vp1yzqpfi8TGqwa0DXh8jgBIyR41
         ZMc7UhY/ek7Dk1HQQ5J7j+pl+7jEL7YN82Wr7fe28UENSM4R0bjDheQzuBsnlYLzLgdL
         G9Zk6N9Kw/XjBCdhnK3AzuEQzkxRbnSH/xUYx9Lk0W/Dx3u1s24apOc/5o7/IiHFHeP8
         Qi2w==
X-Gm-Message-State: AOJu0YwXJqb2B1Hy2tWqHuGjKP8e5MvBOuFShX+zYMqRg80AWvelUYiE
	V551vsRMTosDS6BE7B1W2qrnL/3L84dxojuLpQHkBi7thQjs/KeyUYyfsuCCdYx71cGKlB791z3
	kZ1qOHGNd8QkegYJ6C8Z+7THXjgfk5l3O
X-Gm-Gg: ASbGncvcnCRR/yqEO8Q1X1SA7clExQBI3OlDInL+TlyZIdk7/WNsMkXGRmEUPmvhyis
	ORVB2nzLe7WNdCs3mGEmj7Dmgds6j5fCM0RFJf/1kkOCDd6fvnT+htg==
X-Google-Smtp-Source: AGHT+IEoC3uoQY1AwuscxAB6acPJJSKtBm1RBwkDWVpxL9gkuqw4GC/1889EZ+3kMwyUzMSj8X2oRyWQFoMw6zXW9hw=
X-Received: by 2002:a17:90b:5284:b0:2ea:7329:43 with SMTP id
 98e67ed59e1d1-2f28fa54e60mr6171720a91.6.1734128241628; Fri, 13 Dec 2024
 14:17:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213130934.1087929-1-aspsk@isovalent.com> <20241213130934.1087929-4-aspsk@isovalent.com>
In-Reply-To: <20241213130934.1087929-4-aspsk@isovalent.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 13 Dec 2024 14:17:09 -0800
Message-ID: <CAEf4BzaxcMEsOUaQECNMczCzcM_SQzb0p5jh=NFHa4gSYRq19A@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 3/7] bpf: refactor check_pseudo_btf_id
To: Anton Protopopov <aspsk@isovalent.com>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 5:08=E2=80=AFAM Anton Protopopov <aspsk@isovalent.c=
om> wrote:
>
> Introduce a helper to add btfs to the env->used_maps array. Use it
> to simplify the check_pseudo_btf_id() function. This new helper will
> also be re-used in a consequent patch.
>
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> ---
>  kernel/bpf/verifier.c | 132 ++++++++++++++++++++++++------------------
>  1 file changed, 76 insertions(+), 56 deletions(-)
>

I think this is a great cleanup, thanks!

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 89bba0de853f..296765ffbdc5 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19218,50 +19218,68 @@ static int find_btf_percpu_datasec(struct btf *=
btf)
>         return -ENOENT;
>  }
>

[...]

