Return-Path: <bpf+bounces-67136-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E682B3F24A
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 04:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFAA8188735B
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 02:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E44F2DECAF;
	Tue,  2 Sep 2025 02:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOFRF0O9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AFC18C933
	for <bpf@vger.kernel.org>; Tue,  2 Sep 2025 02:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756780181; cv=none; b=SBz3O8ALjmaq7CGdAOXtvrubD1lTiB8MyCZ78wEkhMdMlbspAJnbNDZc/W34dc5IIpv0ubxCtc8tGwTYHW463J1En3YPHNwqXtfC5cUYnMYVCcdujOAzmwKm8Ga/JwC8Rm1YkeV0v3/aWAO3dCA/sOKp17lcVULPBnh4BaLcJQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756780181; c=relaxed/simple;
	bh=DjjZX/pgejpwWR/2eKWRDzzRzZFN/R1qa6YDbPSmSdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MGWlaTIX9GdHcEoL1oj0o2D7WuN2/gkTNsGeYu3Y6PAURxolwIlkFS50WrVwhfzVZvouzBaSixnn9v/mwxwy42q97T4S+VCNcruY/Bgj/WZG5iknDGbTbIRre8NclzXedigZrZextmJQputIFrfWIHSptgjvXpRZ8IRfawLjfAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lOFRF0O9; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3cf991e8b6aso2410197f8f.2
        for <bpf@vger.kernel.org>; Mon, 01 Sep 2025 19:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756780178; x=1757384978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mdrZ55XO7PbXT7C5gFHLgxoOSEnr/SxCctc6ETRxS0U=;
        b=lOFRF0O9NG8+flGJUnz8fjKexQ+eJ8aNQ/C3/4FT8dFT1W8wipiCmgj1gYhyMPIao0
         SzV85E/xlG8X7ABTIKJAcl04/U6ygJQz5sYMlClNf4I9WptZoJkpWI1gIqPdpobXxQPo
         Ez2u6bHlog5XnvlqH02XxPyo1W4Sv/p7KHcW9xXhaQ9k7DZ/HPJde+zgEntppT8fXBfc
         tAD3LEZSKr8BWSgDCy5YXvRPrJVHcKFfJU6+fDbN6H0fgiypOYm4C/LrgGmAK+ZzCCmT
         2Q6KsdJsGqI77x/DjEgLfewP+mKLRQO+QxnGCS+nOFGQI4W+qedT5CHQoW9bIVJHl6Xo
         zAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756780178; x=1757384978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mdrZ55XO7PbXT7C5gFHLgxoOSEnr/SxCctc6ETRxS0U=;
        b=f25uBo63eztrPGvThHRs7iO71Ny1d9LkYtt2zloQ1K4S31RPvz/YZ4meHsio3p7nc3
         U1UVjKsb0E/oshmoOkduNlKbtVOMgsvxtN1rsPbbmDLb178kSLvV0+ke0hh3QOMO31A5
         Amli+FJZEXAeXPDyOnLy/P/9NpPK1oxdrDZbD82O9vOtVCHk+zhTd9P8PNmxvrqMsVqv
         euqqnZqb+rNjk5b0ICJSgx8vei4+JOu48iOenSfSTSWXrevc+qwh+fHy6xPjc1TAMnjK
         vE9r7qqttd667xZEkI9NTE4MZBbwQNmX5Pn2WguC1rbmy2vlGrJQndc5wCeKWXs1/fta
         5FYA==
X-Gm-Message-State: AOJu0YzHkBZRC/h6873QhoqTH3/yiqfF8y9EWfHPe4vu0D8aUnYaskNd
	/oVcnVlgAHUmVLTUSJjxNk3vFhhYy+jVzkKmTKnXO8X8YuoZ8bpKwL9yTBr70M2UbDRev90F2H3
	nk/47JZNEaHI4J5WnwPscbp9k9QAo/ko=
X-Gm-Gg: ASbGncttB6Ta5s2xMZeaX8uI4xYhLAZXfn20imu7DwW9bEergVjCNdlAp3zCV9inC46
	uvH8RvHkALFffVfMCYHdzClO7Q97XD7zN33MRc5/l3JrE3ZNijLTDzE98s7caBQLCdf1q/Ebfyn
	Q8Nb5Z3/YNz1I0NAfXPf68lXhB5KCQD2H8BboVO5HrItLTwcePw0PE0QV7KgdZp3IEtT7XYGGkn
	FlkE1n/2qHjlRW2wqdWkf5r4E7SNJgcgeZF
X-Google-Smtp-Source: AGHT+IEZ+hPBWIEBQQ73QjHD1LqFtXVcVvWk0Pns/aBkV9VarG4H69hLhWY/lpyC+AvH4s+yj1d/vT1StxGgVYmYNDE=
X-Received: by 2002:a5d:5f4d:0:b0:3d5:a6a9:7d45 with SMTP id
 ffacd0b85a97d-3d5a6a98cb4mr4013023f8f.18.1756780178522; Mon, 01 Sep 2025
 19:29:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825131502.54269-1-leon.hwang@linux.dev> <20250825131502.54269-2-leon.hwang@linux.dev>
 <CAADnVQLdmjApwAbrGca2VLQ-SK-3EdQTyd0prEy0BQGrW4Fr6A@mail.gmail.com>
 <d7ca66b9-c8a5-47c4-9feb-d7814efcce0a@linux.dev> <CAADnVQKkEk=uZ6LBW2yXSAB2huYwpeOdDggaUAzd74_bs_6dcQ@mail.gmail.com>
 <DCHK6T0A6T94.9CMWYIYTG79@linux.dev>
In-Reply-To: <DCHK6T0A6T94.9CMWYIYTG79@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 1 Sep 2025 19:29:26 -0700
X-Gm-Features: Ac12FXx-9wJ-ggfrspUg8ZtkaGw35qVYMj_LXAhIxuBCkMeOAxcfSKNhFojw0wU
Message-ID: <CAADnVQ+FxdMBKb-sv3Mu04eCpsKwS7pieNSpUUvNRCDxVCr6KA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Introduce bpf_in_interrupt kfunc
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 8:12=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
>
> I do a PoC of adding bpf_in_interrupt() to bpf_experimental.h.

lgtm

> It works:
>
> extern bool CONFIG_PREEMPT_RT __kconfig __weak;
> #ifdef bpf_target_x86

what is bpf_target_x86 ?

> extern const int __preempt_count __ksym;
> #endif
>
> struct task_struct__preempt_rt {
>         int softirq_disable_cnt;
> } __attribute__((preserve_access_index));
>
> /* Description
>  *      Report whether it is in interrupt context. Only works on x86.

arm64 shouldn't be hard to support either.

>  */
> static inline int bpf_in_interrupt(void)
> {
> #ifdef bpf_target_x86
>         int pcnt;
>
>         pcnt =3D *(int *) bpf_this_cpu_ptr(&__preempt_count);
>         if (!CONFIG_PREEMPT_RT) {
>                 return pcnt & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_MASK);
>         } else {
>                 struct task_struct__preempt_rt *tsk;
>
>                 tsk =3D (void *) bpf_get_current_task_btf();
>                 return (pcnt & (NMI_MASK | HARDIRQ_MASK)) |
>                        (tsk->softirq_disable_cnt | SOFTIRQ_MASK);
>         }
> #else
>         return 0;
> #endif
> }
>
> However, I only test it for !PREEMPT_RT on x86.
>
> I'd like to respin the patchset by moving bpf_in_interrupt() to
> bpf_experimental.h.

I think the approach should work for PREEMPT_RT too.
Test it and send it.
imo this is better than a new kfunc.
Users can start using it right away without waiting for a new kernel.

