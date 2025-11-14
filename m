Return-Path: <bpf+bounces-74584-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D681C5F816
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 23:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB5484EEC7F
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 22:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B724E3557F3;
	Fri, 14 Nov 2025 22:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbC4Ux//"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEED306B08
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 22:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763158716; cv=none; b=X1ysXeue5vFY5JMEqwtB9o8fA7UhrjOqbwGqo9bFIMm5r5Ism5n3/FoqVU97G8oJGfsPKmFVHZ82R0HfRBBTt90u9/7GayCRR13/BTUttSo5qOo8+bqHTf78UuIdeE+jlLw88mHoppRwUsn6UtUf5BDPt8hAw3uxT16xwfo1yZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763158716; c=relaxed/simple;
	bh=a2vQJeHkjzy3oNOhQHjr6m34FajtYqzSAvzx5Vepf74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=own4yzkb013sfLB2bJXzD73enjDfNluVfnfXtwpg2SkGpyUyqA7Bl3fxaVpM9SDkqzwbRtA1KVM7O0CJ+IR4gu7cGCOcRQqnmfe5SS/ji0IOB1OsJhx8V6a/FxItL1JfYinjPT3GIJjfFU4DdRBfzTBgSv0I2E3HeDVnEd963XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbC4Ux//; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42b32a5494dso1466544f8f.2
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 14:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763158713; x=1763763513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/OZvrhBtDyT570GphwIAoT9B2h1KTbQG9QqyJoAQ0/A=;
        b=gbC4Ux//vzQdOAtxENv/LA4U9LXufI8W7RE0KMbTPl08U3nwWJD1pbobeQ/TH7TQru
         YGcWvmLNK1HflP29zsvXE7p49J20CIupzPwBa6zh0SRHeJ3STbKifDXPONyo3bGmcfpW
         bNeT5V4QJ+eEy7guGBar9WjCWjyF8kDnRtTDXRa6MCOqqKRMdrD8RnpO51kIUurzLfK4
         UrnBv1Y2bGeJGxi6xXsyD7jkMSUgPXSUe4nH1BkdNtdHFNLdlnul0GwpqMMU15s3rJ8e
         F7CfkzJDCRklRD1wiCcxyPM9Ly0cUL73nYnd32SaL2kg9Op2+aPKOMsZ2jkoKp/JTcs6
         zqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763158713; x=1763763513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/OZvrhBtDyT570GphwIAoT9B2h1KTbQG9QqyJoAQ0/A=;
        b=YpjO/9vLOeAPZ44UWpBXJGZimWQs5kUPqAL9fE7P+kmATNjd8hCGfwWNQAiBUWjkYv
         z8DGU13o/kiACIDlL0HYaH2KfT+vC40sQhmg9S6mNWDjRuzaFZUDz5eazhSN/v+FfLnA
         oY7zrwWSNF/yqTErO1B2OjHoGFehywi60Zn5wE5VNywhq27DTskmvgw1oVYmOfg5OLD+
         Hz4mqb0UTEJcej7sGOflprxDccUATHHjYrkyMZjso0jWQN/+D//P7wbQufL2xfTpGgON
         zVkTsVGOXXnkH5Y5JZNoWOWicEsiJCRUAHPAid9u9+oWO76D2MRpJ2DbCgpSLMZiHEf3
         8wYQ==
X-Gm-Message-State: AOJu0Yx6/Ibp52T32NeQspIV8XgqkJLO25UdHM248JQ6K094IFYXJnbN
	q5QDjVob3vE8yUy1hph7gxn+R0d/LkqyJ8MZss90FEA0oMQGBE6h+dHads6aebulyBT3mI1Zuuv
	D3dOvifKNwO83f0lTxg/KfB7OAFocPcE=
X-Gm-Gg: ASbGncsfajcKd17PUFNWkuggpqTzFuVxtZB9v8ZG/vOX/s2la3lvXHpuVQAkNzLAOmk
	qa9ixS4Zhs9w9G37WU7f9qQEC83qIXWSYfpmHsz0PpOUK+MH/NlbPiSftFIq5qqEwCI2IcLaU2N
	ypkosxkn4Q8FJLNnbBkorz1PBAE6XchecUrlOckgbZudBfgdsdmmI2QjAGAE5oNELuf/mkn1t0T
	FGnJ+s4slw32AqEFCly8xeWNDx583zj3y0iIe00iSd8wKAcAg+HKbQ71t8sZicL9AaMPIZQ9OLr
	m0IxOkaRRngnHUZoje5Q0QhYh+7c
X-Google-Smtp-Source: AGHT+IFfk3GBSyVGCw3Ur/dUCtR2uEcDdsvfUFTRc4URm59QC0L7fRIhSJOWavq4Igmz4kr3OkiMnVS7SpS5g/3v/5c=
X-Received: by 2002:a05:6000:430c:b0:42b:411b:e487 with SMTP id
 ffacd0b85a97d-42b593248dcmr4116506f8f.2.1763158713044; Fri, 14 Nov 2025
 14:18:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114111700.43292-1-puranjay@kernel.org> <20251114111700.43292-5-puranjay@kernel.org>
In-Reply-To: <20251114111700.43292-5-puranjay@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 14 Nov 2025 14:18:22 -0800
X-Gm-Features: AWmQ_bkToriq1kHg7PZZMHy80sx9YqXEUaIsQaKippfghW8nv7dyfU4BuH3eIOk
Message-ID: <CAADnVQLABi2vLBnUq3LAQS29nNySvq6ieBrMAKpB8EJ8D4XM-Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/4] selftests: bpf: test non-sleepable arena allocations
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Puranjay Mohan <puranjay12@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 3:17=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> +
> +       /* Allocate 2051 pages (more than 1024) at once to test the limit=
 of kmalloc_nolock() */
> +       pages =3D bpf_arena_alloc_pages(&arena, NULL, 2051, NUMA_NO_NODE,=
 0);

Please explain the choice of 2051 a bit better.
I think you wanted to do 3 steps and last one not aligned to 1024 ?

> +       if (!pages)
> +               return -1;
> +
> +       bpf_for(i, 0, 2051)
> +                       pages[i * PAGE_SIZE] =3D 123;
> +       bpf_for(i, 0, 2051)
> +                       if (pages[i * PAGE_SIZE] !=3D 123)
> +                               return i;
> +
> +       bpf_arena_free_pages(&arena, pages, 1025);

free less on purpose?

