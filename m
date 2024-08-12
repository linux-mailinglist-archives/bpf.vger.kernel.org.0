Return-Path: <bpf+bounces-36929-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EABC94F6D5
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 20:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE71B286CBD
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 18:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9167018C330;
	Mon, 12 Aug 2024 18:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0GaEkux"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EB12B9B7
	for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 18:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723488087; cv=none; b=BXRUTtTSyW7gbiEDPauSdICWOHGFMNTWfeD+jBbGiRZshWS1Iw0Y0M6N59jGRGnbmz0DzDY66oqdi32rHw36Z8qH/BIjFe6T0Dh9BlQ94+z8yua49Erw56zM6q41t6i9JQqRYC2+2PLlAW88VZ0T2dyNL5CQNJYpqEcS1qZmPvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723488087; c=relaxed/simple;
	bh=6F30E61f+uzuWzt9C7lxg+FPLdffS/KQz1YE4OOOgbw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VqZ6C+FhkcrVbKClB0yO6n/a8i94twdzLzBeMipv55Xoi3Z10e+GrWoh3um/CLiwQIiEh06MvdzNmkFQM62hy2BNdhEsD7ETMGB8BkDHwm5okqi/7+UlmOOlzRceHt5XrHhTpfDVoZJWVE+iO4titRKk65RTtgW/v/7nZEFjQ3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0GaEkux; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-6e7b121be30so2907499a12.1
        for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 11:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723488085; x=1724092885; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CCRCdFS26jf3zz9yHZLiINAfxoSIL1hysyHJ9011o6M=;
        b=g0GaEkuxM4XkX9F/1B+O7/QK8jk/6AKOLWME1iw6AQadhltTK3/LS7hZ9uQQID/x3O
         ql1pPD8+BPIjb4DrpoADothtJj738F7oq4tO96r5JHLbZ4MaP+PiybMwWI6h6FX0FJZB
         A6mIDexEkAuGfdwAEVM1IcxEg0F8hB/3hA13DwLRcxvF1dh3nD4Q6PTVdlY44LPS1AfK
         hxdPTEahZ1tKoT9oQyUBgvaR/BPSOYFfqp4U1cahDY3yu5SGUuFelfus89DH8cxGQ9sw
         57DWDop1kWr8uisxg/vmvRext6e+NtwJvtbWu5e2Kpc0ZWcupIJqaETldTr0H2d8AOu4
         Ds9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723488085; x=1724092885;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CCRCdFS26jf3zz9yHZLiINAfxoSIL1hysyHJ9011o6M=;
        b=J1FlupxEsPP4f6N6aMSUmtYi/ZBuOrgoJlJVNoklnD7mtJU62gTPY+2LmsDhvbdYDs
         0LOYdSbJNukdxdHNoSX/9Xz0O+sGMV9NxBDAWg18U1DR/23ueW2lnuuUprmgSxzCRKam
         G3fdflhMyH4YpX5+9txG9GiB4magLdPXp7Kdr2r5ThS/Ce0ti6YMuzWrjCWMnVOA/1VP
         CdV+WnzWPVTRN+JnGURxFqwCCdXrxi9Mpye/6GmBA71NdxWB78MerXQcmh8d6bjZHCqx
         fy8FoCUxFJI2IqmBa4VUo8txwfqDE+q8IDKeGY6LVFkaEuoJBKT6Tv7sXvza9jZVNYs1
         XFVQ==
X-Gm-Message-State: AOJu0YxjR8Kf7/PTUGPJTDd6jQQa19wlK3mOv8meg3NPDlo8v/GVwQf+
	rTzSwSZq4JEvlbgEhEEc8uLgBRsr4teGvJZjT+Y+uvNj7ohUjJme7TJ9ZUyX0io=
X-Google-Smtp-Source: AGHT+IEQN/nsPAHntwamI3cyyf/Ldd7tm7COcqUWot76NB1kbd0CVNLTTnAoM3kFO9Gtt/ZtbIR1LA==
X-Received: by 2002:a05:6a20:9d8e:b0:1c4:87b0:9157 with SMTP id adf61e73a8af0-1c8d74af5f4mr1393226637.22.1723488084850;
        Mon, 12 Aug 2024 11:41:24 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c697a734fdsm5326a12.93.2024.08.12.11.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 11:41:24 -0700 (PDT)
Message-ID: <bce93894f4db4f2d80d735fc35246e047b677ea8.camel@gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Fix a kernel verifier crash in stacksafe()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>,  Martin KaFai Lau
 <martin.lau@kernel.org>, Daniel Hodges <hodgesd@meta.com>
Date: Mon, 12 Aug 2024 11:41:19 -0700
In-Reply-To: <69654617-c97e-48cb-8317-15567a46365a@linux.dev>
References: <20240812052106.3980303-1-yonghong.song@linux.dev>
	 <ffac004eab4bfe98c5323a62c6e47b25354589bb.camel@gmail.com>
	 <CAADnVQ+-om1OWRyUvWoiVg5pKM7cxOCVw4wZqdZM1JTRTg4-5g@mail.gmail.com>
	 <d2ca7ec0b51fef86ef8cd71202ee5b6de7dc42cf.camel@gmail.com>
	 <CAADnVQJjY9NU7WBxUNqOnLEpm6KhgHL0M_YobQ=2ZjMUHq3_eA@mail.gmail.com>
	 <a4af06f9-5ea7-4541-90fd-1241043d5659@linux.dev>
	 <0b305ca5045a1adceec313b20f912f9666c1705c.camel@gmail.com>
	 <69654617-c97e-48cb-8317-15567a46365a@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-08-12 at 11:36 -0700, Yonghong Song wrote:

[...]

> Sorry, I copy-paste from 'git diff' result to my email window. Not sure
> why it caused the format issue after I sent out.

Sure, no problem

> Anyway, the following is the patch I suggested:
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index df3be12096cf..1906798f1a3d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -17338,10 +17338,13 @@ static bool stacksafe(struct bpf_verifier_env *=
env, struct bpf_func_state *old,
>           */
>          for (i =3D 0; i < old->allocated_stack; i++) {
>                  struct bpf_reg_state *old_reg, *cur_reg;
> +               bool cur_exceed_bound;
>  =20
>                  spi =3D i / BPF_REG_SIZE;
>  =20
> -               if (exact !=3D NOT_EXACT &&
> +               cur_exceed_bound =3D i >=3D cur->allocated_stack;

idk, I think C compiler would do this anyways,
to me the code is fine both with and without this additional variable.

> +
> +               if (exact !=3D NOT_EXACT && !cur_exceed_bound &&
>                      old->stack[spi].slot_type[i % BPF_REG_SIZE] !=3D
>                      cur->stack[spi].slot_type[i % BPF_REG_SIZE])
>                          return false;
> @@ -17363,7 +17366,7 @@ static bool stacksafe(struct bpf_verifier_env *en=
v, struct bpf_func_state *old,
>                  /* explored stack has more populated slots than current =
stack
>                   * and these slots were used
>                   */
> -               if (i >=3D cur->allocated_stack)
> +               if (cur_exceed_bound)
>                          return false;
>  =20
>                  /* 64-bit scalar spill vs all slots MISC and vice versa.
>=20



