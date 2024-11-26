Return-Path: <bpf+bounces-45635-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 327A29D9D98
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 19:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E433C284B9B
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 18:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0A41DDC11;
	Tue, 26 Nov 2024 18:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATE5/KjV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C79C7E782
	for <bpf@vger.kernel.org>; Tue, 26 Nov 2024 18:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732646667; cv=none; b=MdYRNbKRVzIzmgO1D0GYMtXEvvS2O4l8KmbyjJc05vtltSSitAcO/a9h4/iAKXd0oFavHm2On2XReYjZpakQTSmbMk9es7eP4uxQuS7x7o2p+7rCYhxHIc+bVvR3T7rhmoATm/BNJCSmU88fOSzrPGUdGiSYtoLmOVU3Ikp1se0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732646667; c=relaxed/simple;
	bh=PGxDq0w5odPzixZkjrPDo5lMaBjtCJ4LKe9udp91j/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iE1CITJ0ACthtmJRKrD+jOsggybMxi2Exuz13ZioHDh1UIi4lNf3G2TwNtZKHktoFAtZdFL/1S2tJAeMqUmYUckRqpU6wdRsJmG/7OFybfy+qI2wplUGp17fL778XSKEeVoVfI0JyhGSVmDQmKs1dysivwTP+kiVhF9gVYMogmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATE5/KjV; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7fc340eb006so2045390a12.0
        for <bpf@vger.kernel.org>; Tue, 26 Nov 2024 10:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732646665; x=1733251465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIYZdwhQqK3wr3qMDizwPT22tgxZk/SgB61fe/nUJk4=;
        b=ATE5/KjVDRrgoBZKju1A5nNVvaJuz9S5B/m0E/9l+HneG8ShA1RAkIS6IiTweDzcza
         Ii73DWkfSmbp/j8lJ7aHQ8enYMGMPt5CkGpFqGE1Fq5pErG62E6+zuIyF5OUo30cKtRY
         WFgzuMYIG4RFKAQnSo+dMClwQUjT1ZPedDeLFCInnKZaXyiZ9MgSFB47V8U1uwsFyxS7
         ReqvenFZSM4BEP8PL5nmEiNZMPdlLZWRa4FaHlIfG2vLerUH0uaQmEulFRkUPBoAamfS
         w+ufktzt9/VJUDgCMIo9C8nEQ+GAsTAf7iMr2JcQc4WYvPmLp9rHqMaETOiUpfuZfFMh
         lyqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732646665; x=1733251465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pIYZdwhQqK3wr3qMDizwPT22tgxZk/SgB61fe/nUJk4=;
        b=aDZnEpl7VCfvweVzcBZ75ppXxTOJJ6OwK79BubvmwstXLf16+zKdq8T5QY0mYl7OAt
         HJBIropY0ZWzxAQ0F04YiU/2R/ZqYCHENiH3YgyuAe6svXkMz2W+hA/oNPFIOjAb6xdo
         FkjrfVHhtk6wAGB3ak7H5ZsYdWbTZGic5jOQTs88G8QwZpKfPqMNR0OZozKbd5zaMAuA
         SbFnwADCxXEgLN1DaQ5GxJHYCrEMh3M56m2OAswvE4Nfu/9lrR+Mv8Ml36z3BEJuAIbH
         flriloHwDHZJKiQu4iA1jkV7MDy5vjs1by0bWg+0lVbBPLhdQj/gQ93yBBaBRPNKhhX5
         WWhg==
X-Gm-Message-State: AOJu0Yx606J0OgKH63SPnQRrN9L27sHd8zdgW0mbJk6mvJZU/0uMVrOw
	YzLWcb1awh1MwL1YizoiZkLm1m17Qh5JNCU8fG0GoqEP8/Ub+3+ldssRbBo1ANMVLTUw4W3WX3A
	icvp6MwUCIxr+8vMov5ic9gx6Vu61pvJK
X-Gm-Gg: ASbGnctMLNU+6rbaNyAbdhhqttftI4JMHr8aacML99ICWn7aMNRmYYsz7ve0QHm1NFr
	vvvX4uk/X6C9lLl6szpr/MUUR73cqJrAeQq+M6rGWnEAE2L0=
X-Google-Smtp-Source: AGHT+IFTFmlyTsJdPTNk6WUyJdxEwxaJZlrj7O4AyyHDiDhz6WFN6MUImlnN6pDoqmmYhTOcNN34MeVuac+9yBAJtn0=
X-Received: by 2002:a05:6300:8a0d:b0:1e0:c855:dc38 with SMTP id
 adf61e73a8af0-1e0e0bafd14mr401674637.28.1732646665303; Tue, 26 Nov 2024
 10:44:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119101552.505650-1-aspsk@isovalent.com> <20241119101552.505650-3-aspsk@isovalent.com>
In-Reply-To: <20241119101552.505650-3-aspsk@isovalent.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 26 Nov 2024 10:44:13 -0800
Message-ID: <CAEf4BzbLSMWz8KiM=qr9e5u7Qr_f6QT2imDBo8ZGTK7g03jVQw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/6] bpf: move map/prog compatibility checks
To: Anton Protopopov <aspsk@isovalent.com>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 2:17=E2=80=AFAM Anton Protopopov <aspsk@isovalent.c=
om> wrote:
>
> Move some inlined map/prog compatibility checks from the
> resolve_pseudo_ldimm64() function to the dedicated
> check_map_prog_compatibility() function. Call the latter function
> from the add_used_map_from_fd() function directly.
>
> This simplifies code and optimizes logic a bit, as before these
> changes the check_map_prog_compatibility() function was executed on
> every map usage, which doesn't make sense, as it doesn't include any
> per-instruction checks, only map type vs. prog type.
>
> (This patch also simplifies a consequent patch which will call the
> add_used_map_from_fd() function from another code path.)
>
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> ---
>  kernel/bpf/verifier.c | 101 +++++++++++++++++++-----------------------
>  1 file changed, 46 insertions(+), 55 deletions(-)
>

LGTM, I think this is a good improvement. As far as I can tell the
laziness of all those checks are preserved and shouldn't interfere
with the dead code elimination and CO-RE

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1c4ebb326785..8e034a22aa2a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19064,6 +19064,12 @@ static bool is_tracing_prog_type(enum bpf_prog_t=
ype type)
>         }
>  }
>

[...]

