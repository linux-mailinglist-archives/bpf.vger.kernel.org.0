Return-Path: <bpf+bounces-40693-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E2D98C424
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 19:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B35BF1F26349
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 17:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84031CBE82;
	Tue,  1 Oct 2024 17:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpnntMl9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB48F1CBE85
	for <bpf@vger.kernel.org>; Tue,  1 Oct 2024 17:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727802246; cv=none; b=d7Fg3UiOhni5RYlLBMjcUzdt0gnyCWrS2lJN3+e1I7vbq/iuG1Myro0enfuSO7yzdzEa04Y7SGMY6qRaZV87rLe50W3I7D7ffzQDVunAx3aZMOywzcuuCFuDc1Tte851R8SdHFdiGnIVu0XAQ1i20LhO53ZsiK93iSBQZbpAOmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727802246; c=relaxed/simple;
	bh=RE+/Fvf79w1VmHbBulCfR2k5YrkfXcoixDmjPtDoYME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lu6KDpZDVClPcsyvuy1rgl5lNgC4GHmPDgc89wS1XhCFlgAMVv/HSbRCfxqP45dWqMReu2T6DluxrVWlgcuoaTzqI4fO075MeEnUoW0zmHdAYqXYQTHiThM79tQW46W4ymdtsARC7vQCZLivRfjDFbBL2wPD4SdYIM6/R74ykjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpnntMl9; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e082f2a427so4383607a91.3
        for <bpf@vger.kernel.org>; Tue, 01 Oct 2024 10:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727802244; x=1728407044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/YlQXS99qulS0t1jgjspsdH1Uu+reL/wi2XRxPf+qw=;
        b=JpnntMl9TPMlwTileYOdmCIvcOHJZapq90ekVuoQWjudffVMupA1dZFCee8aacZ18y
         selP0MlpaRN74FUj/Fd1iTW2J6lpawcXvgZx+80UvrvXOYL7uDii4OAs1P+jBtbKTiXq
         yX4Jvmi10wXgcUWYHQ4fjjuAWcsNeYWzOYxRBs27n6JKgrjepQZQzsJ6967H4qEb95OM
         tHQW/YmVglk3XPBt4o577htwReENrZGS9QKX2BhYQ9bboj4knsl0LnNMOxODhKDETu0p
         btqG+uSBhi2002P5o7yYLMfazx2WYxXLA4pok8KdDY/4Wlm13WNAjQ1x/LgCnqa5yoNt
         Je2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727802244; x=1728407044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C/YlQXS99qulS0t1jgjspsdH1Uu+reL/wi2XRxPf+qw=;
        b=Uk//wmmfKBY+HUmdJN6VJP+D3BC5Zq/zH87yX7s1fGHJ05oHTdfV6+4qvUFVtxMqZi
         DPffHzlLADKwM9Hx3W6hlh8dHnS4g4jSVH1oPu2qQh+xOgbPzchG+J4NM5A4kBqQYpR3
         yvcscYx6eRIxMHmj8nt/rX2gI8k9Wv4JOBDRZ2Gvpwkq23q/WNgLQWzMAULMIPeuPc9x
         8tNZkxZoHn10uZTutPPrs3XCEYKgCMIgZKW70GBXe8Ll7J/ZfzrEaCx9j31ZaGENPb8z
         mqHAlDrqep5hlJh1bXJSlK+fV3pU2rJqsRzWBOarlOwk+Y58dy1tsbukyPOS5FSX/QOe
         3DOg==
X-Forwarded-Encrypted: i=1; AJvYcCXsRJBRcXvRvav7C5avHclH4HxNHMnEW6kT5cVQ7FO6DsLo3dAuk0BwpB/qE/MAW8skcgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjrV+T6TyKr0yUY85VvGQ8z0LGmDxPzZ25D1rhB3TMwjIHsbNH
	19l+bzJsZrSf7p26aPwoZOAlFt1UjUL76Zym6MmXX6LLT8E49LJ1h94WgW5kn7icMyuwbPzhZXK
	0L2yDeOmXt5ZpAzcDffywwlYG5Mk=
X-Google-Smtp-Source: AGHT+IGjO3O1c81ZRlM6KoQvAePTu/03cuK0puMd0ysKq4b6CInV5TZKhuxpR001i9KIaVN+h4e8ZZxdT6cxuB1RLcA=
X-Received: by 2002:a17:90a:ac16:b0:2e0:9147:7db5 with SMTP id
 98e67ed59e1d1-2e18496cc2fmr385197a91.38.1727802243715; Tue, 01 Oct 2024
 10:04:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1727329823.git.vmalik@redhat.com> <bc06e1f4bef09ba3d431d7a7236303746a7adb57.1727329823.git.vmalik@redhat.com>
 <CAEf4Bzas4ZxiyJp7h7N5OGmPSMRfZDgPUgEAdTmir3n-4cx-xg@mail.gmail.com>
 <adaa47618f2b71c2803195749cedd4a5b468cffa.camel@gmail.com> <CAADnVQLCk+VNpN8WfCbSbT-FBcHBuMXpk-hBOLB7HX3BrURp8w@mail.gmail.com>
In-Reply-To: <CAADnVQLCk+VNpN8WfCbSbT-FBcHBuMXpk-hBOLB7HX3BrURp8w@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 1 Oct 2024 10:03:51 -0700
Message-ID: <CAEf4BzZSFuXyUbwN8_VvbR6Uk_qHAKWNLkCZfdo-58WC_RYYag@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add kfuncs for read-only string operations
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Viktor Malik <vmalik@redhat.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 7:48=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Oct 1, 2024 at 4:26=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >
> > On Mon, 2024-09-30 at 15:00 -0700, Andrii Nakryiko wrote:
> >
> > [...]
> >
> > > Right now, the only way to pass dynamically sized anything is through
> > > dynptr, AFAIU.
> >
> > But we do have 'is_kfunc_arg_mem_size()' that checks for __sz suffix,
> > e.g. used for bpf_copy_from_user_str():
> >
> > /**
> >  * bpf_copy_from_user_str() - Copy a string from an unsafe user address
> >  * @dst:             Destination address, in kernel space.  This buffer=
 must be
> >  *                   at least @dst__sz bytes long.
> >  * @dst__sz:         Maximum number of bytes to copy, includes the trai=
ling NUL.
> >  * ...
> >  */
> > __bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__sz, const vo=
id __user *unsafe_ptr__ign, u64 flags)
> >
> > However, this suffix won't work for strnstr because of the arguments or=
der.
>
> Stating the obvious... we don't need to keep the order exactly the same.
>
> Regarding all of these kfuncs... as Andrii pointed out 'const char *s'
> means that the verifier will check that 's' points to a valid byte.
> I think we can do a hybrid static + dynamic safety scheme here.
> All of the kfunc signatures can stay the same, but we'd have to
> open code all string helpers with __get_kernel_nofault() instead of
> direct memory access.
> Since the first byte is guaranteed to be valid by the verifier
> we only need to make sure that the s+N bytes won't cause page faults

You mean to just check that s[N-1] can be read? Given a large enough
N, couldn't it be that some page between s[0] and s[N-1] still can be
unmapped, defeating this check?

> and __get_kernel_nofault is an efficient mechanism to do that.
> It's just an annotated load. No extra overhead.
>
> So readonly kfuncs can look like:
> bpf_str...(const char *src)
>
> while kfuncs that need a destination buffer will look like:
> bpf_str...(void *dst, u32 dst__sz, ...)
>
> bpf_strcpy(), strncpy, strlcpy shouldn't be introduced though.
>
> but bpf_strscpy_pad(void *dst, u32 dst__sz, const char *src)
> would be good to have.
> And it will be just as fast as strscpy_pad().

