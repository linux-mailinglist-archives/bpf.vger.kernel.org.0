Return-Path: <bpf+bounces-73526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F8CC33621
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 00:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C0CA4E70DF
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 23:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1620A2DFF0D;
	Tue,  4 Nov 2025 23:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHTwqMHX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CD22DF140
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 23:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762298882; cv=none; b=a67RQUEC7FbSwsWgMtNIBr+r/pYR6AdvSxPRW3PtGfr5hNY7SmDwUDlEMLkMLLT4LFyuqd+1Bm30gyqGmHlIlzbTwKgwTVdnq1vIVBxlTkoRulb/PK82VKvRoAp6VTX3q5dFtQgemlL7+qfDOuiA+voBNva89pLX/3qsOJVsJB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762298882; c=relaxed/simple;
	bh=atPyN88/ajTLGB32nE6pH8axtbT3UHg327vdI0JGABA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lYWIxDOtViKemAkOJ3FtaUbGfDLnBbueS1YfvxZljMTKfEze5p5hg7oCZ5oLqpXtSgfNH/orlwYztDM0CwHTzyCowuFPxeuWg4sr3Bm497bSnCDCE4e1U4353NgWonEJqvgmYF8MgLM+UAhzEPbtYjkZCCtDlkg/sqKIesEzRBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fHTwqMHX; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b67ae7e76abso4422647a12.3
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 15:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762298880; x=1762903680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3QqeHGWs/iUZhYOcRfX9mKywPLuJ4IlUyRhWDheThRs=;
        b=fHTwqMHX+eBcotYM31nSbhl/rWIcEbddLZ/+RsO5bCaj3pU9KB043S9uXm6iLbLzGJ
         9b86i6Wm0aEccZ77WNlUupRxuQDMQ1NQuTIAeWYcUXbue6PmlxCTYdE2FhEO3DEWklUk
         EAmQW8MVe+oyApRVMHIq5oPm4rA712AVMycl319rN0FBMT7lI1AQm8CYU6xcYtwZsNTx
         vlBYBP69sY+u96AlHOMfueknuheG+w/c5OpK4bSu8AkN0qiRPIZKPTwX6oRso3NFZZzP
         9ZG81wRrUfb7YNizn9d+2JEjjq7hmx+hLNVclb6oc+J7uug5UPThezb6Cug5GCyfSVPX
         YnAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762298880; x=1762903680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3QqeHGWs/iUZhYOcRfX9mKywPLuJ4IlUyRhWDheThRs=;
        b=WO7oIMYNppczFQBRyisD8rMVbkXgAbqmGJ5OpjVgEE+9G4NLj53e05nM9whgGL94Pm
         pUfTjXebKJSO0nCO6vhKApbzBVSJph2zohT2rZ0mH6jV6odYFZg24yO5W17LeYmQoiVU
         nWVrnTCRqhRUyCjubJvBpiMpOtsIPsJiNPexlUMYlaoy2j7sQGUWuLa5dkIIyN3Ly5MW
         UHR3atMlUMavAbhlAsVYDlFo0CqqtiqpYtG6o1R9eHKQcg7mNZKYgkzJJVrvCPbCpVKg
         Nh53otT+l7twv7kWS7dOivtDY+N+u+BVkzv/bLhJpm4J4BJb+1fhGbg6CUTnFa0k7k9L
         VHsA==
X-Forwarded-Encrypted: i=1; AJvYcCV4UeOJ2oOLwTKF42kRMSXikazsGIG+e2L02s8P1Fo9UDOxkh12qmRwGoRe8vE6CXVxg9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFAgMZjHu1RiXTgUMG1GTxdbfAGmGXdL1FTfj7ITuLziLgsaMD
	xHR5lpClNfvgKYkxMp5fnE/Xk2qEFhrSqzQSzsvX+IDsN6lALtnLfPsGWuEonQCkXw6Iw9ecRF9
	J07whE97p5Os5WQLq62DC9pZwQQ1gI14=
X-Gm-Gg: ASbGnctMxBzYSryepuoPY5wQvrG1ZxaDll3bQ4O3TRNX95Ut+ByVrKTUFLo8sedAjvP
	RjH1VuBZKcwE204YjkisH1n4yJYpGCz3ZkJEihTcEsKzQgVpthZrViEcckCs92ALyX4sgxRSMqv
	t1nidOhjonE0coB4mOG58yngGz7KEffcqTGyFjSDm19aB0H91oLSYKDZbrBtIX0v0zxcCU1exXK
	WRy+p9SkW0CrP4CtJ8k16HA0escD8Q5EXFZvr5aiX08uLscy+Ska7dmolrssDL7qHMoteLYbKvS
X-Google-Smtp-Source: AGHT+IGIinC5SPZ8Y05+eawvnOyy91jheBh28gyMVfLcElCVFVOyg5VqQRTKob5dilZqurjSBWNpDREsev6I88b5AhA=
X-Received: by 2002:a17:90a:d406:b0:340:b572:3b7f with SMTP id
 98e67ed59e1d1-341a6dcb832mr1431449a91.20.1762298880467; Tue, 04 Nov 2025
 15:28:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104172652.1746988-5-ameryhung@gmail.com> <b4c70f2af7001ee36b8d3702f280ca11e3ba281ba29cdcb63434ee28e0a8060a@mail.kernel.org>
In-Reply-To: <b4c70f2af7001ee36b8d3702f280ca11e3ba281ba29cdcb63434ee28e0a8060a@mail.kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 4 Nov 2025 15:27:46 -0800
X-Gm-Features: AWmQ_bkR1D_jg0XXWVAT_-ZRikcJygUG9HBMwXYeTV7IxYJq78TCWRkF5tvMZrs
Message-ID: <CAEf4Bza6gVd84ANwTyKZq8jnSBvALTppZUaZC802SKr5pO5QbQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 4/7] libbpf: Add support for associating BPF
 program with struct_ops
To: bot+bpf-ci@kernel.org
Cc: ameryhung@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, 
	tj@kernel.org, martin.lau@kernel.org, kernel-team@meta.com, ast@kernel.org, 
	eddyz87@gmail.com, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 9:54=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index fbe74686c..260e1feaa 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
>
> [ ... ]
>
> > @@ -13891,6 +13891,36 @@ int bpf_program__set_attach_target(struct bpf_=
program *prog,
> >       return 0;
> >  }
> >
> > +int bpf_program__assoc_struct_ops(struct bpf_program *prog, struct bpf=
_map *map,
> > +                               struct bpf_prog_assoc_struct_ops_opts *=
opts)
> > +{
> > +     int prog_fd;
> > +
> > +     prog_fd =3D bpf_program__fd(prog);
> > +     if (prog_fd < 0) {
> > +             pr_warn("prog '%s': can't associate BPF program without F=
D (was it loaded?)\n",
> > +                     prog->name);
>                      ^^^^^^^^^^
>
> Can prog be NULL here? If bpf_program__fd() returns -EINVAL because prog

libbpf APIs generally do not tolerate passing NULL for bpf_program or
bpf_map pointers. This is fine, this shouldn't happen with valid usage
of an API (and we don't guard against this).

> was NULL, this dereferences prog->name without a NULL check. Looking at
> bpf_program__set_attach_target() just above, it checks "if (!prog)"
> before any dereferences.
>
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS) {
>            ^^^^^^^^^^
>
> Same issue - prog->type is dereferenced without verifying prog is not
> NULL.
>
> > +             pr_warn("prog '%s': can't associate struct_ops program\n"=
, prog->name);
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (map->fd < 0) {
>            ^^^^^^
>
> Can map be NULL? There's no NULL check before dereferencing map->fd.
> Other map APIs like bpf_map__fd() and bpf_map__name() check for NULL
> before use.
>
> > +             pr_warn("map '%s': can't associate BPF map without FD (wa=
s it created?)\n", map->name);
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (!bpf_map__is_struct_ops(map)) {
> > +             pr_warn("map '%s': can't associate non-struct_ops map\n",=
 map->name);
> > +             return -EINVAL;
> > +     }
> > +
> > +     return bpf_prog_assoc_struct_ops(prog_fd, map->fd, opts);
> > +}
> > +
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/190776=
79684

