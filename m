Return-Path: <bpf+bounces-56712-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0D1A9D03E
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 20:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAD7F4C3136
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 18:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D447215781;
	Fri, 25 Apr 2025 18:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBmwrLDc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCA32153D5
	for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 18:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745604621; cv=none; b=gXJlPCF+rkrTdQNb0DbzAIzKVL2FUuYP5NG25pLbc4lnkV3d0D5j042pYIWReMpZjbPVRvXHWSv9Rl2SaoskdHic6mt8+hbo5IBkqySrFJK80UAgChTNjf3Nw4bFIBiKHYYMW8SzdTUreYCgapyPEEHCb9Uu0Qm6NEaTGIpfDCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745604621; c=relaxed/simple;
	bh=lTH/nEftGcwo06DAPTV65Sif8PnUNiGwEjq8hsi5k1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UG70cYelMECGL6YBhXyx49jrfKfUvt7sPSmD3377fHMQLVJOY4wVaKJVYdOPxMGY//Ciyi3Gzqu58JmySaH/zujHrfb23BW0NLgmXWMpGLUBNGnzb2sgo0bIswjpimrvhdkSJIqvDpgqBWO6lsmjSuxob7/8P9bdNf2uxn8bw2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBmwrLDc; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso2691216b3a.2
        for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 11:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745604618; x=1746209418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOFM7jPcPPsq34cjtMbLj+AH4s29jpw8sBDYW2upHVo=;
        b=ZBmwrLDceaPYxC9bjDTs8SxCCz3zoUX7zNX9Q/WZrxd+lVYtPGWgPkdmPrbj/g59cv
         0KFunHq5DT1bO8eRdtyvsWAmnWob6mz/WQZd8B0smlN/kSnG9KGX9l4nI2FPm7CVBmvP
         rbpi2D4ZXczLbckpKg6yc4bQMEC1ydYxE/0v160k6W/wotrda2hGv+7ZHIgCldZ8U4J6
         5eqL2+FFcLjiwuN3Ghs5aoawrwfbdWzgbko64spd40QsRYpBAfL9RLLY3BeqX9GaBYzG
         Qbbz4xVgavXmV9UmpzTfzMgscBGoIJjwL3FPZz40w+Zp33XMqcwyLCV9cVbVGsB5YoIi
         QQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745604618; x=1746209418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOFM7jPcPPsq34cjtMbLj+AH4s29jpw8sBDYW2upHVo=;
        b=dEh0OP+ysMHC6eIcgJxh51nTSvhGMoLGUI4HfpFRzbFHU3DQXWVfdVgqnqNTAivWzI
         wgcAus5naMzQ/qTjqdyAxrL6lq1LfoPd+Eq6PyxABOx+vuzLNxhPZhBooBt+/VMyJgRS
         kYu+a86+KXp63s5hbIPOCX+pMqzKl4MhSA1KrE8ChBjk3HboWKDO1tfE7LFZavA2UdDi
         PDy/Re2gv1zP0BPKxBaN6ssxtyTosW9ERNWqx/kzWknEGUaBNeDdGsqp7E8S1Vd4TrVd
         oY09RuiBz8hKy8qtnyK6DFN6q1pJl0bokbY+zCFbz6VHTIKxKsgGEY0FGgTi0cRrF8Qt
         XRSA==
X-Gm-Message-State: AOJu0Yz+IUb/mS87pZ2IQ2DmZEV6DLG8UBg9UOOzSVyOJVlyQPzPdEPP
	3RT/SB+HAg6gfIO2rpIuEx/8zBkzeZr3ySMNtUHY5LCm6bFfA0Un/6O0nvXX3QqVD4pQTtCbk5m
	QdDQJGB/LA278VdJi8Wf8oIykErLTiLmC
X-Gm-Gg: ASbGncsmmOR1WPJYVLQGhS0CjU0prumxPlznaawg9KSQBQBseH6aS1dSJuJh82fZAQI
	3M8pOg+OJh9xFnVSHVzc00LEnleZae36SsSNroCsT9YLHs707ooc7n8Nj4JySvTdZ7DFc/X8d0i
	ipdJ5VNRFzvwMOlrNJNHjYXFrhCV/n+QBl9QjE0Q==
X-Google-Smtp-Source: AGHT+IEhiy5jqu/6mXzqfPBpePHoWWPL7Ftd5OSjnVlx7dTG49y8jvh1MNB2TPOREd5PpacvggJ+SxMbhnYnBQcYoQI=
X-Received: by 2002:a05:6a00:4611:b0:736:7270:4d18 with SMTP id
 d2e1a72fcca58-73fd77b21eemr4425355b3a.14.1745604617710; Fri, 25 Apr 2025
 11:10:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425125839.71346-1-mykyta.yatsenko5@gmail.com> <20250425125839.71346-2-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250425125839.71346-2-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 25 Apr 2025 11:10:04 -0700
X-Gm-Features: ATxdqUFQdJIAplvrrTmeEXmciN-_bHtrLXdMPSy3oYm0C6UImjgnah2WcJmQKpA
Message-ID: <CAEf4Bza4Rer7N0pzQ=L06PX7X6UN8ayXJvy9Au3ncmv8Ozj2CA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/4] helpers: make few bpf helpers public
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 5:59=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Make bpf_dynptr_slice_rdwr, bpf_dynptr_check_off_len and
> __bpf_dynptr_write available outside of the helpers.c by
> adding their prototypes into linux/include/bpf.h.
> These functions are going to be used from bpf_trace.c in the next
> patch of this series.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  include/linux/bpf.h  | 7 +++++++
>  kernel/bpf/helpers.c | 6 +++---
>  2 files changed, 10 insertions(+), 3 deletions(-)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 3f0cc89c0622..14f219921b4c 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1349,6 +1349,13 @@ u32 __bpf_dynptr_size(const struct bpf_dynptr_kern=
 *ptr);
>  const void *__bpf_dynptr_data(const struct bpf_dynptr_kern *ptr, u32 len=
);
>  void *__bpf_dynptr_data_rw(const struct bpf_dynptr_kern *ptr, u32 len);
>  bool __bpf_dynptr_is_rdonly(const struct bpf_dynptr_kern *ptr);
> +int __bpf_dynptr_write(const struct bpf_dynptr_kern *dst, u32 offset,
> +                      void *src, u32 len, u64 flags);
> +int bpf_dynptr_check_off_len(const struct bpf_dynptr_kern *ptr, u32 offs=
et, u32 len);
> +void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr *p, u32 offset,
> +                           void *buffer__opt, u32 buffer__szk);
> +int bpf_dynptr_check_off_len(const struct bpf_dynptr_kern *ptr,
> +                            u32 offset, u32 len);
>
>  #ifdef CONFIG_BPF_JIT
>  int bpf_trampoline_link_prog(struct bpf_tramp_link *link,
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index e3a2662f4e33..2aad7c57425b 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1713,7 +1713,7 @@ void bpf_dynptr_set_null(struct bpf_dynptr_kern *pt=
r)
>         memset(ptr, 0, sizeof(*ptr));
>  }
>
> -static int bpf_dynptr_check_off_len(const struct bpf_dynptr_kern *ptr, u=
32 offset, u32 len)
> +int bpf_dynptr_check_off_len(const struct bpf_dynptr_kern *ptr, u32 offs=
et, u32 len)
>  {
>         u32 size =3D __bpf_dynptr_size(ptr);
>
> @@ -1809,8 +1809,8 @@ static const struct bpf_func_proto bpf_dynptr_read_=
proto =3D {
>         .arg5_type      =3D ARG_ANYTHING,
>  };
>
> -static int __bpf_dynptr_write(const struct bpf_dynptr_kern *dst, u32 off=
set, void *src,
> -                             u32 len, u64 flags)
> +int __bpf_dynptr_write(const struct bpf_dynptr_kern *dst, u32 offset, vo=
id *src,
> +                      u32 len, u64 flags)
>  {
>         enum bpf_dynptr_type type;
>         int err;
> --
> 2.49.0
>

