Return-Path: <bpf+bounces-59297-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C04AC805E
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 17:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCC034A30D0
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 15:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B90722CBEF;
	Thu, 29 May 2025 15:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQ/dg/dd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3793F21C195
	for <bpf@vger.kernel.org>; Thu, 29 May 2025 15:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748533003; cv=none; b=KA1mfRhAuFqbuu8q6NmaxOC6gJ7yIWA0alyP62oOOPurmHzeeWKesUGRL/5RfEqW9FLAz3sq3lEBxx36MAz29WV0RVg7Qc8jWHvPsY/Lj/RjeRtrqbO5XSlGciX2OJZu3ExKMpZi6BIg8KtxXRwkHnKEqqDw/Q2ShT51BaZJ5mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748533003; c=relaxed/simple;
	bh=lkSvuZdcXkUdRnjdzuQAODrrHNrf+seMVguh3EWipmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K+xGRYtT2P3ZoaGAC8it97R4bWZ0vY+KqcFdAkquzm9feYjFqn7jneWUB8v/t8SiWbZKuOAMk4Ntimn8uz56jsmsv049A4ZazhPM+nme1haKDr8t6z7MqfoHqx/HA0lrU4ZAua5IhV6Rnq4fA/9PhvTiFxBxrM6C9wCEAJjYxm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQ/dg/dd; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-ad88eb71eb5so123983066b.0
        for <bpf@vger.kernel.org>; Thu, 29 May 2025 08:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748533000; x=1749137800; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1PHELbSYOMgWNuRXijAcIYRM3CTVLrBcmlsKLfj99/A=;
        b=hQ/dg/dd7BX3hvyZ0Dp/wxyeU41R1ROfxa1Wlj3hv1qWVVPZ2Xe406+76OUJb+DerS
         E6oTk1tKteEc+sxmtRp7ZD5CJuiNGko6Qspt2uRhzJSokguINptD7C7Ur36O8ARaiiDr
         fNByVbqIrZUeXxr00/iNDt9TJW15fssrOWkz6JyzMq4/kxgxjjw+1aaMsNI+nN3QYGgG
         I89qJHADSkwSEjvngz7+AybzlOkMLgsr5gQbMv/5e6tRGRAkvFsL4CZNyn7yUuoHa+/u
         BmOrkO6XjSj6xSl3sv6A+xqHlfhpVimDSptPmK6MD0eLRSvxZkqBlaLy4LN1pgUJ+qym
         qv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748533000; x=1749137800;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1PHELbSYOMgWNuRXijAcIYRM3CTVLrBcmlsKLfj99/A=;
        b=ercnM5gvFee9Uawpk394jSiCbtDev+7zpnQ29RXCzsglX/UzCvZbcSeC9H+jUN1qUE
         ntYHtWH2TkKHwwmXDHdj7QnQarE6BKSBYeFv2OOr1+hEdSn0ClWmRkFRyGidi89m14/p
         tMzcUmJDHqjSzSZIZmGpvyr+7hXHS9XAUQLSsw+RWf4yucccR97QaU/orpFULBibpJsN
         WNBtzpmZ2fOFevIxC27uDl4jBOB0RjOlQCXmMKMFACYM4I+9Jn9UDm0BKxe5LoOUiNqk
         +f7aGU1JlNcEmkdhJPJ2k0zGgHMLRF/c9+zCTbdAzQagFiSUtx50xMypbU9S84roRmWk
         btkA==
X-Gm-Message-State: AOJu0YxqGkHZAxAn/2dMYEhidVs2sGEw+Ohhqxt4DKBGex5KsS1uohQf
	TS0JHvVD9Hpnm9HocG0Vr4e4hmSMEkw4dwUJ4fJCqBkHs1BDMZge9qm8wCkNBYNMuW7D3MpV8UR
	pjwkiK5ZSJ2Z1/Dv1rubIBnmR9G0nP+M=
X-Gm-Gg: ASbGnctnWc8WJl9vXFRnLBHido9z/2tRkirDExVseqTXwiZ/N5TJO+yyqC5RO0QYqA+
	F0eJ7sopsc/1i71KT/tyl2IKPiIhQ8+Glg6fBmtdhMdu+F3q5XL+8VEYEMoIUPasKkBrLbP4suO
	Z6v7PTtHW2vk0sSg5XfC7voJ5YvIdfhoA0
X-Google-Smtp-Source: AGHT+IHQd4aMPZy7czCI9+5zeBPNe+XTbu6grFodIJQwbwtcrsOJ8RUJi7o54XFIL0P2FZYWZOWma6kCeSshZpX+Gk8=
X-Received: by 2002:a17:907:3f29:b0:ad5:59ef:7f56 with SMTP id
 a640c23a62f3a-adadeeaa5abmr281639966b.48.1748533000248; Thu, 29 May 2025
 08:36:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250524011849.681425-1-memxor@gmail.com> <20250524011849.681425-10-memxor@gmail.com>
 <m2o6vc1uml.fsf@gmail.com>
In-Reply-To: <m2o6vc1uml.fsf@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 29 May 2025 17:36:01 +0200
X-Gm-Features: AX0GCFsLwI5hGcyUFf8EnqnABARfUULfU738r-28tdUMd48kUuC16OI6tQCkr80
Message-ID: <CAP01T77cY9ti0u++_o_MhvszdKxu_uYH=ESrQ_N8xDbnS9PHhA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 09/11] libbpf: Introduce bpf_prog_stream_read()
 API
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Barret Rhoden <brho@google.com>, Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 May 2025 at 20:02, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
>
> > Introduce a libbpf API so that users can read data from a given BPF
> > stream for a BPF prog fd. For now, only the low-level syscall wrapper
> > is provided, we can add a bpf_program__* accessor as a follow up if
> > needed.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> [...]
>
> > +int bpf_prog_stream_read(int prog_fd, __u32 stream_id, void *stream_buf, __u32 stream_buf_len)
>
> Note: many of such utility functions have _opts parameter for future
>       extensibility. Imo in this case it would hinder usability a bit.
>       If need be bpf_prog_stream_read_opts can be added later.
>

We may have more arguments in the future (like count of errors, as
Alan requested), so it may be a good idea to add the opts variant
directly now.

> [...]

