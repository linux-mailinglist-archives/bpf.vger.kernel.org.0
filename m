Return-Path: <bpf+bounces-73483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D77C329A1
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 19:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E15E3BB189
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 18:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076D834A772;
	Tue,  4 Nov 2025 18:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Og6FUUUG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B765A33E377
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 18:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279846; cv=none; b=D+nrvyIkmjkgWHoK4J8nYwD5yBz9S02buNNUQF3kO4BQXkU2bL8NwUwcINIFhIN3Y7jhzMQKHK8hlbeaXRUa/+zN5WazpNEowwujGGYiDj4MS+VcRW9g5WwKyBhbuC05iLN3XkeQaWvZgfNVfubz1xOM+6pLhVUhmEP9navPNbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279846; c=relaxed/simple;
	bh=gn+1cyCQ/07KM855F/NeAln3hHIcHTws74h6tFo6Okc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dM8ddCpacAYvDSsm/U2Vc7iq/efopECrA/rv2gAl5xMPBDyVj0jCohSMITrsNajQhmNplExKUyhgYxlbpKGhjhOwiYwD/GO3TLxWv4HcMl9m+yB5/qMyr/imY8ToAqKLygFgm5BNMiyS8blWgLX0m9AecbVHuHzPnbdysygOl3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Og6FUUUG; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-63e2cc1ac4aso5556002d50.2
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 10:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762279844; x=1762884644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23KFcuOuxCVXm913D7qKqfrC6/WNaTrfBBTB+yzkDBg=;
        b=Og6FUUUGMkVX2fgpRpZ3MLvoY+fyppTtg5agAeVmHO/+VNY4DtVSa5DrKITyHw6ncW
         wmrDOXBh+ydsthbwf4n6DE314ORsE8b2cdEOneThC44c+aB+rzGNfDPfbV1kAejOAMU6
         ODvyzd77PJJ17NIRzTK2WQYl7MB3ggSTowtksAkNeClzTjBwTzJrTNN9u3iSa2kEa63L
         +7G1jXmehA/3p2V8uSpuzsd8a0MzN8kTIAceFrUol9zITe8rateS1WWO9kj0LqvseegT
         yNNgOmTmGQ6dKfTZkz+NzWVXcxPvThN6IFpbTqIQWqyEbY1a1YRP+mEzX0YLl95NnJS6
         egiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762279844; x=1762884644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=23KFcuOuxCVXm913D7qKqfrC6/WNaTrfBBTB+yzkDBg=;
        b=PNHuLbwatCxnH+2erOiihwYFCFX2qbEPEROd6t6EUaez9uIGx5W1HbjbA45LQ+tQSE
         jZl3FXQLmNbnzYfvBrvnZP57MD6iS3Qw9WvMtUCvl07kfybcrL+fWCoQpQ1iTHptlWe1
         TgZS1pvr/Sgo4cashpvxEF3RmO8YjJkhHrsOEXNpAAuaeu76Pap87mV9uJQ5NBoBVN0s
         UZAtfvAc2IaxkeeglXVs9puR/JkuJvgOeMVlm/axRY+/EJnVXjVy5BOVtzApV+Bc98TU
         4Dqrfgf8UNJQrIWptpm4Kv7gc+/enpVDsG0lAdILa+JFb7MTmGfP5YHonpsLstDrq7fo
         ZGpg==
X-Gm-Message-State: AOJu0YzuLfLEsJRJ7Uk1cXXaGJzVAxTPGuCApek/1tC4T1WDG6R+cjW3
	ZwDO8/0idTRtT+mt/gASSX4zD9OOG3j9lXOvs3KZTzHlD4MPWiH9cVQIARdSvwPaKlVL/S9IMpx
	UUb/mGEQ1FirtzpV+uJdoTTytJXtaOHQ=
X-Gm-Gg: ASbGncvDIYDuPijHHkWhMbma6lDjgEf4ePuHygtE5sFbqJUgOFjAaN/RSLYZhpKfn7b
	s0HznVdhszjkGCnFJGfvqpZbFebvRC6c7yPaNaKb5B+dErIqq4sDbzLuM3Z7Wzs5TK2gclbtD8v
	DQo2Pj4ibp22OR9kix2xlH5dt23SwSdQuldB6LtsF7BjJJWo2//w8MlC3rMUoz7P+HuIJ/wweQr
	GeRg34Yoxs9M/lGElxE6gHtb4aIxdM4E5McZXO9+RTEs+I1GaYxW8bCvmIMTzupYevWJhjf0jxN
X-Google-Smtp-Source: AGHT+IHTNpRh2KHG6Pbc5u7di/OTCMr9jG612AsDubzWqLWd8MsoVItAKkt/jwmEPvVdEYPbEPahuJtYHKvWl/RrWm4=
X-Received: by 2002:a05:690e:1559:20b0:63f:c10e:6422 with SMTP id
 956f58d0204a3-63fd34bb6c0mr380771d50.8.1762279843545; Tue, 04 Nov 2025
 10:10:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104172652.1746988-4-ameryhung@gmail.com> <6fbae8b38c532ccd1accfa75df7614f56b6a49d6b4a851b525a59b7a07f33d25@mail.kernel.org>
In-Reply-To: <6fbae8b38c532ccd1accfa75df7614f56b6a49d6b4a851b525a59b7a07f33d25@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 4 Nov 2025 10:10:31 -0800
X-Gm-Features: AWmQ_bmSxUWeL0HOMYWBJwMhgEG7HyVRMl5w44JIdR-0dpIc-mlNp10AJxj4nFk
Message-ID: <CAMB2axN+hsZ0VQHYvw-Z31EK-7wF7SVr2nOv9=e5h=wLW_cq+w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 3/7] bpf: Pin associated struct_ops when
 registering async callback
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com, ast@kernel.org, eddyz87@gmail.com, 
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 10:03=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 865b0dae3..557570479 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
>
> [ ... ]
>
> > +static int bpf_async_res_get(struct bpf_async_res *res, struct bpf_pro=
g *prog)
> > +{
> > +     struct bpf_map *st_ops_assoc =3D NULL;
> > +     int err;
> > +
> > +     prog =3D bpf_prog_inc_not_zero(prog);
> > +     if (IS_ERR(prog))
> > +             return PTR_ERR(prog);
> > +
> > +     st_ops_assoc =3D READ_ONCE(prog->aux->st_ops_assoc);
> > +     if (prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS &&
> > +         st_ops_assoc && st_ops_assoc !=3D BPF_PTR_POISON) {
> > +             st_ops_assoc =3D bpf_map_inc_not_zero(st_ops_assoc);
> > +             if (IS_ERR(st_ops_assoc)) {
> > +                     err =3D PTR_ERR(st_ops_assoc);
> > +                     goto put_prog;
> > +             }
> > +     }
>
> Can this race with bpf_prog_disassoc_struct_ops()? Between reading
> st_ops_assoc and incrementing it, another thread could dissociate the
> map:

This is fine. struct_ops map will wait for struct_ops BPF programs to
finish running (an RCU gp) before freeing itself. Therefore, when
another thread is freeing the map and this thread is calling
bpf_async_res_get(), if this thread still sees
prog->aux->st_ops_assoc, bpf_map_inc_not_zero() will fail and stop the
async callback from being registered.

>
>   bpf_async_res_get():
>     READ_ONCE(prog->aux->st_ops_assoc)  // reads valid map pointer
>
>   bpf_prog_disassoc_struct_ops():
>     guard(mutex)(&prog->aux->st_ops_assoc_mutex)
>     WRITE_ONCE(prog->aux->st_ops_assoc, NULL)
>     bpf_map_put(st_ops_assoc)  // potentially frees map
>
>   bpf_async_res_get():
>     bpf_map_inc_not_zero(st_ops_assoc)  // use-after-free
>
> The map could be freed via RCU and memory reused before
> bpf_map_inc_not_zero() executes. Other functions that access
> st_ops_assoc (bpf_prog_assoc_struct_ops and bpf_prog_disassoc_struct_ops)
> hold prog->aux->st_ops_assoc_mutex. Additionally, bpf_map_inc_not_zero's
> documentation states "map_idr_lock should have been held or the map
> should have been protected by rcu read lock."
>
> Should bpf_async_res_get() hold the st_ops_assoc_mutex or an RCU read
> lock around the st_ops_assoc access?
>
> > +
> > +     res->prog =3D prog;
> > +     res->st_ops_assoc =3D st_ops_assoc;
> > +     return 0;
> > +put_prog:
> > +     bpf_prog_put(prog);
> > +     return err;
> > +}
>
> [ ... ]
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

