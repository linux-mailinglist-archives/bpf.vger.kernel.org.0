Return-Path: <bpf+bounces-68875-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46048B878AE
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 02:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 316287B4A3E
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 00:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AF71E9B1A;
	Fri, 19 Sep 2025 00:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKm4omKl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42955CDF1
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 00:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758243402; cv=none; b=MvYiBtuH1lSMdhtpyzZlOhllagRkBhXGnV16QY58t8flnW96SZx73v5nNAGWs9hqe9op/P6kuMHE28NCRmqtTz50mZFvhh0rc4jCcFJsn2iZGdIhJL3jclE+3LZq+ZU8FO0IdzfplVuBE89cw+wsb9wnqCTyefJd0MSyqh2fztA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758243402; c=relaxed/simple;
	bh=4B8cjQRAwSCdBrm+sJvKE57pT1at5yiaGYH8yNgsXfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qncb8BrF+gqt5d6Xd0Kj6kZEEXOO7B9uv1ZtGMWDVizEgTmOv7h0405D6aiILz4rx1PXqTApboDRWzGVpxM3K/DRclr7cyA0Kc7Riu525addTuQ57DAKBE0wRQ1xe8KBtUSAKG1L6n2kx/3/PHVW9UNQ5HzL2Oo9sRyE2tRQpt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKm4omKl; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3ee64bc6b85so322690f8f.3
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 17:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758243399; x=1758848199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6GlFEK40Km1Msy8fsLA6LJXdQUx60HOB1nzavbHIq30=;
        b=bKm4omKl21FohGhEzOEPco309QxFUH/k18b0yGtS3wKNeaLnlSvtAdnhWY+cKE+NMu
         GC4vWr+Wmj4EAyfswA+n9Z6LGEzmJupp1JEoJuHeZEgel1HZt0eLNT+ir3Mm00j7h0X0
         UD4nDV+yfSAXNHORSw3vpBqun6z7y2He3a/WJGAtmSqxhh9eF/M+iryxymc60xFb5xsl
         L/9JlCblVkAvI812h+KnjVa1yb74adA208i4Ak9espB77nfDmb0C3yDfLBGKLvz9OS1E
         ejsw8nGvDsKhNb7DloMkPZoOt5KGghi8wyG77Zxi8wvSDYhX57e5urI0P64S19j4lWkj
         q8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758243399; x=1758848199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6GlFEK40Km1Msy8fsLA6LJXdQUx60HOB1nzavbHIq30=;
        b=LuwVMo4cuF8EMGBUHz13aGYDKMgW87XrjSOlNRkM8Od6ful/TQbhZdJOimiFMIIjiZ
         S3A3dMeOZm8z+iYf1pHVgapBXDK0ZEFhrjAJOzavdFzT8rWMDqqxDLsEOkqTJxQ5FBA/
         D1JG2laUdFRXsnYPSel7b1IL7MwvHC92sBBhRUFkKQipnBSsH9Ck9gHwhP4oFd4P+BLg
         gK/GQ028e4bhg3Quz6atvbmq7rT3PKDqQAKlQCHrXxBoa8jtxXbAC5demqG9z8GpHAFo
         V62lJz7YtNIxcqdo3frkhiLR8Ilp4O24fMwIYcgkVcQKSQB9K5u7/OPygc1rGSmpZgBp
         k2pw==
X-Gm-Message-State: AOJu0YxhAUYxPHBwq94iNMPpOgOjFx2qtr6oWYaGlOdbFpgrbYsWa+w9
	qzwX0Ks8lebQ11zPK84zjQV5CxD+j1DhPL+xn58oJCYTC60YEM+G3kHAJxhAZb/d324RU2Zp9KM
	GX6k9HENe4g45s2M1YGVlpSZAasHVBYo=
X-Gm-Gg: ASbGncvT41jxhtddHw56ipQ4BwJU8+UB08B12WVUtKUdB+9iYCwjkoL01phFTAQDtKZ
	XxYth9q4XGktShM03JnTY7NM9z+M63CCdO6TehxVKUgF2Yt6mSKmBZ6OJIg2voMk/SJC08kaudN
	1xNwjOUudmTFY0yhNLo1hGkgT4GqJET8ScTh835QOOYTWQj2MkT/pZ/3TLoxsxyPvoufcEkfFkD
	ohF0XanV2elTGJF8vXSpa3TCdE5jMidf2k/WuAX2KljFFoxVbO3gM8=
X-Google-Smtp-Source: AGHT+IHSVgeSDZ9Rop1g3BSndi26b73bU+owJQUzoSj4bBUEN0HrBt+8Uthd5+j11VsEo/ufhVa+PW37jNJIP7o1c2M=
X-Received: by 2002:a05:6000:40e1:b0:3e7:620e:529e with SMTP id
 ffacd0b85a97d-3ee87ac994bmr762713f8f.43.1758243398907; Thu, 18 Sep 2025
 17:56:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918132615.193388-1-mykyta.yatsenko5@gmail.com> <20250918132615.193388-8-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250918132615.193388-8-mykyta.yatsenko5@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 18 Sep 2025 17:56:27 -0700
X-Gm-Features: AS18NWDo-UQgFu-xgL8S3jDeUL8oW0YkI91EIPE7tZzMM2c3VauXWrTzONQlYB8
Message-ID: <CAADnVQJfGqKpOhQpx_a-kKfv34XRE=hDZAN=u-=CVppUF5wfzA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 7/8] bpf: task work scheduling kfuncs
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 6:26=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> +static struct bpf_task_work_ctx *bpf_task_work_acquire_ctx(struct bpf_ta=
sk_work *tw,
> +                                                          struct bpf_map=
 *map)
> +{
> +       struct bpf_task_work_ctx *ctx;
> +
> +       /* early check to avoid any work, we'll double check at the end a=
gain */
> +       if (!atomic64_read(&map->usercnt))
> +               return ERR_PTR(-EBUSY);
> +
> +       ctx =3D bpf_task_work_fetch_ctx(tw, map);
> +       if (IS_ERR(ctx))
> +               return ctx;
> +
> +       /* try to get ref for task_work callback to hold */
> +       if (!bpf_task_work_ctx_tryget(ctx))
> +               return ERR_PTR(-EBUSY);
> +
> +       if (cmpxchg(&ctx->state, BPF_TW_STANDBY, BPF_TW_PENDING) !=3D BPF=
_TW_STANDBY) {
> +               /* lost acquiring race or map_release_uref() stole it fro=
m us, put ref and bail */
> +               bpf_task_work_ctx_put(ctx);
> +               return ERR_PTR(-EBUSY);
> +       }
> +
> +       /*
> +        * Double check that map->usercnt wasn't dropped while we were
> +        * preparing context, and if it was, we need to clean up as if
> +        * map_release_uref() was called; bpf_task_work_cancel_and_free()
> +        * is safe to be called twice on the same task work
> +        */
> +       if (!atomic64_read(&map->usercnt)) {
> +               /* drop ref we just got for task_work callback itself */
> +               bpf_task_work_ctx_put(ctx);
> +               /* transfer map's ref into cancel_and_free() */
> +               bpf_task_work_cancel_and_free(tw);
> +               return ERR_PTR(-EBUSY);
> +       }
> +
> +       return ctx;
> +}

If I understood the logic correctly the usercnt handling
is very much best effort: "let's try to detect usercnt=3D=3D0
and clean thing up, but if we don't detect it should be ok too".
I think it distracts from the main state transition logic.
I think it's better to remove both map->usercnt checks
and comment how the race with release_uref() is handled
through the state transitions.

Why above usercnt=3D=3D0 check is racy?
Because usercnt could have become zero right after this atomic64_read().
Then valid ctx (though maybe detached) would have been returned
to bpf_task_work_schedule(), and it would proceed with
irq_work_queue().
tw->ctx either already xchg-ed to NULL or will be soon.

The bpf_task_work_irq() callback would fire eventually it will do
 + if (cmpxchg(&ctx->state, BPF_TW_PENDING, BPF_TW_SCHEDULING) !=3D
BPF_TW_PENDING) {

if releas_uref() already did bpf_task_work_cancel_and_free()
then ctx->state =3D=3D BPF_TW_FREED and
  +   bpf_task_work_ctx_put(ctx);
  +   return;
  + }
will be called on this detached ctx.

but xchg(&ctx->state, BPF_TW_FREED) might not have been done.
so the code will proceed...
and further it looks correct when it comes to handling
races with cancel_and_free().

The point that usercnt=3D=3D0 or not doesn't change thing.
We don't check it in the steps after acquire_ctx().
It looks to me these two checks in bpf_task_work_acquire_ctx()
don't fix any race.
It seems to me they can be removed without affecting correctness,
and if so, let's remove them to avoid misleading
readers and ourselves in the future that they matter.

Note, similar usercnt checks in bpf_timer are not analogous,
since they're done under lock with async->cb manipulations.


Also I believe Eduard requested stess test to be part of patchset.
Please include it. I'd like to see what kind of stress testing
was done. Patch 8 is just basic sanity.

