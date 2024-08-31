Return-Path: <bpf+bounces-38647-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB71966EE6
	for <lists+bpf@lfdr.de>; Sat, 31 Aug 2024 04:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FA281C220B0
	for <lists+bpf@lfdr.de>; Sat, 31 Aug 2024 02:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB453B192;
	Sat, 31 Aug 2024 02:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Klu0caKW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA221758F
	for <bpf@vger.kernel.org>; Sat, 31 Aug 2024 02:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725070462; cv=none; b=DaYrO+ZtZZWpNspCh2IjBlYk8VIeLk8bd+VhjoEPbED3nbV1U8wuaQPN3jP1UxRAlYoX/wWg/my0Bb1w7kmhcQKBEF56fCVt2xV3m0C70psd6XDw+q/euljUkiO32pDJxu4/wbbrLYliA4XDM7txbFc7BKuNkmnoX+swCi693fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725070462; c=relaxed/simple;
	bh=75HqIkJujdkOIL2qY9pXCBhgTD3eGe1aMaDcqP93LD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jNiK2NZzw3FTv3gE/T51BrkNe1CojCKEB6710tnfEEytZX4NltsYYumcWL6MtyuPYVM0D5JPN6QfT3ai4aICQOpeaAxB5pV3ChAm+E+kFESpbsaa7noIvD4PkZ9Zislr4Qx4QRYqTiFFZn1f6PgF/Y0X0j8Gyi3Sz1tTQ6bdvsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Klu0caKW; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4280ca0791bso20787335e9.1
        for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 19:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725070459; x=1725675259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75HqIkJujdkOIL2qY9pXCBhgTD3eGe1aMaDcqP93LD4=;
        b=Klu0caKW3GknPhHnnSrRGbS+A6kYgsbU6RWiqRkiza0QHWXfu2Dhn4CuFYlo+MTvAo
         6Q322nO+HpaEMwlnZPUZWD5A2PdrIyFhnUzaD0MBvn5Qu5H7HOwGblvSLcMp/YEaNPnN
         g0gFNsEpThylX5sLztjr1DJvSGmky50lWluQh6TNGJwaVRd82CLm1LDy8ooiEmLcb6fc
         6ERssx8ezEjQsFALQdg7HiDExbhHwHQJpg1UY/9QTu13nA/yYvewb2iwmuftATqqtsVP
         zhhQWA64C611lA9DGqw/zMSg2HnADraQpLAOWxu+ItnIg4WX+jrEL6C2hVeLRHarq4Q/
         aMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725070459; x=1725675259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=75HqIkJujdkOIL2qY9pXCBhgTD3eGe1aMaDcqP93LD4=;
        b=ZqfuX6n2ZcQ3b+ND08dfSYNZjLTpXlj5JN9UiidMm1B9MtcR5LaDG57nDysZShFQJi
         pULGAdvXLSJoPWB2D26OhPwaKJ0QlEBPr04HYyzJAo2phILfivtnNh+qdysEyfqLAHmr
         jUDnHDI9LsQwNtLFkoKjUBjxG26Iv+S8esOhjaTDHWTJ/Ye8VPMFeG4+J8nRhfGHMmka
         Q1+OUx4yKv6CXUiVB/6lbmM2sEG4jGTlUXIbgvt9GtiHZqVrvgfKN24ENwnRYCcD6F+N
         DJhVzXfGNI/oiVtw75g2aZiZnxCGzPCG8nyoCzB4Igz4Xpfcstgg43AYpq8h2bBIBxAZ
         rB4A==
X-Forwarded-Encrypted: i=1; AJvYcCVS20LdNvMgR/6BsT38uetXNjXhthV6eOSd0zBK2mbGSeecVh8aMI5/J1rjSog/5nC9CMI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKYAbWxbvebAy3j/48RN1/o3QkL86H+twsTqBI1ZCiuHdPscV0
	x1uwVDWmgTWzAlVyQ7Lpux7iPrwoM0tm8dkh+t8jrqGEKj0hZ88BKhUFMzotUkvHAWgFvIzhbc8
	NB3RuFHmZwJ6QnP9w9NAjnqDLUhw=
X-Google-Smtp-Source: AGHT+IHsvq8G/4YiFA9TTGteVs3goIpRpQt7SUVVDgD/g4iyJ0999x7AjfIr1QrxXPA5vK8Vqu7N6YiEBsUTyXSN4+s=
X-Received: by 2002:a05:600c:4fd3:b0:428:1007:6068 with SMTP id
 5b1f17b1804b1-42bb01fb0e4mr68390565e9.34.1725070459047; Fri, 30 Aug 2024
 19:14:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826224814.289034-1-inwardvessel@gmail.com>
 <20240826224814.289034-2-inwardvessel@gmail.com> <CAADnVQJp3Me_tXRs6Nupbi93bAj2D-sFuN-N7DMfKU=EtMu5ow@mail.gmail.com>
 <CAEf4BzaaZqiRGwK5=GHrd81HgtVbWfXOSWAeyorHgbCVjsv-jw@mail.gmail.com> <Zs91tK9dduFe1dIj@saturn>
In-Reply-To: <Zs91tK9dduFe1dIj@saturn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 30 Aug 2024 19:14:08 -0700
Message-ID: <CAADnVQJduHZsK8dpRxzD6cXqfrdjkmOd5CQD3yPH8s8NDD6CmA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: new btf kfunc hooks for tracepoint
 and perf event
To: JP Kobryn <inwardvessel@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Eddy Z <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 12:08=E2=80=AFPM JP Kobryn <inwardvessel@gmail.com>=
 wrote:
>
> With this change, anywhere we do
> register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &some_kfunc_set),
> BTF_KFUNC_HOOK_TRACING becomes allowed. So even if we never register the
> extra program types like PROG_TYPE_PERF_EVENT, we still allow them as a
> side effect since at runtime the program type mapping returns HOOK_TRACIN=
G.
> Any program type associated with this hook will be allowed even though no=
t
> explicitly registered.

Correct. kfuncs differentiate by type of their arguments.
prog_type -> helper was an old style when context was the only
thing we had. So we had to differentiate by prog_type.
kfuncs are currently register by prog_type too, but that will go away.
We're planning to do large refactoring in that area to satisfy
sched-ext requests. It's not the prog type that would allow or
disallow certain kfuncs but rather hook point plus custom flags.

