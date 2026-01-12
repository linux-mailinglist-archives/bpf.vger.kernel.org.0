Return-Path: <bpf+bounces-78630-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 751EAD159A7
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 23:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC972301F037
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 22:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BA4303CAB;
	Mon, 12 Jan 2026 22:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gi+Y7Zko"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4C72BEFFE
	for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 22:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768257810; cv=none; b=NU9P7yyo+q56TDblvkOEwnz4x8hTeNPnw57GUcDbyXgPQd7/EIgH2/l6ATJfMlLcouqPubPHD1muggFE0aLXCgfxQO/vAJ2aZuqgkQy/sKQZYYAY/63SzvF5cLriprCHkmHCRoqx4k/5dHbFbyXecx9FKbRaBNa40DGPdH8oxNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768257810; c=relaxed/simple;
	bh=0Ga4046PoD1QjORJ8x9YGyeaqSw2W7pHCfFHrwB+sqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OgvTs3FVDPrDNEu6DPNsDkxEW+ZWkNSOelpd+Vq4r/FuDO7ufqvHPt386NChTkOaPIqdDlc4zmoeG/0VmklmS7ciXNt5zn+F40sHnabZu5ycu5bcW8EI0atqiX3lSZPFZaZPMqHVshDvAkIxV+YrM0yedZOyXbz92BeZ6Z7nr9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gi+Y7Zko; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c46d68f2b4eso4200345a12.2
        for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 14:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768257808; x=1768862608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGobhM5gknftRAivxeGEAO6mhAVtTPpcYFMxFViT17s=;
        b=Gi+Y7ZkoLMFZwlIuQkxMyQRF04ybogZFv7FwHPlBYisGUUvTfUpM+m83raSAvGjcww
         52w3cCIELafvovm6XM12wNy5NQe/S413+xcFXVTSRzdFfTUCXJVeqEPxMhKPyZcTYNJm
         qRzWNrY9EmNnCmViJMFlrSwvrLgqWLWi0Fha1w2e9LeJWX424i/cIHF+53moyyVfGaj+
         X186nZGzECvblvm1terPEq8e2ROp57YYFH4PY1okaSVpl7VRORT7ATeJ56x5n6w9WD1B
         OSIq+xD5BOXF5GS+mWjx9eEkTF3FMQzFlurtMOQhrlscXPvDZjyzmAEDTMkDOxkiT+jA
         +zRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768257808; x=1768862608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PGobhM5gknftRAivxeGEAO6mhAVtTPpcYFMxFViT17s=;
        b=YqqJ/ScM3eY1Uh6EOKQnDsFfFmKjTkWT7VX7Hq4+P0mLJF5Puxpu53Nf9xCRMWxyZ0
         WxVgFALgrr/RT8LKcphm05YOthxPoJN50bkurB6r7nPIPTje3PAQ1pJ8wjYQDYMUu1sU
         1S95T7NcNQwvunystRJZbKLiiw3iqqbhx7IzcYZUhJvSVoEL/BS4nJCc7+8MbaX+WJ5c
         R2LwT54aRh7Z9Sjib+1FZhZDWWn7hO7ktTmRa5EEJfXoOHwQWzpT7iKs0XO7Zv7Or93v
         WmTNPWQ+6bXNHcKCvpnHAyz+VvKK0R1+2ePzMvhwq9p36C5wACvPgwTSZwopiFOvZ8vT
         JnHg==
X-Forwarded-Encrypted: i=1; AJvYcCXGexJHdrsdO7BTsV6GrEvyhs4I87AEZFYrtEqX5jNbGw1RhDWGTIJr/YncnwMReGKc6es=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJLuR7QXm2idvvl85a+R32Mif9wh9A1C7oZSyONQofAJE1iEuQ
	QWlEjZBaQMuHHtBRwsxOj46JG3uvjRHXO+h33NYZJ8q4ceKQ+qv968lVXxrCUYolIUseoFj1fDw
	8669fJ73eXSVQXYYNbFVPsMb/wixnExM=
X-Gm-Gg: AY/fxX5EDCIr1Y/4geLJutwgKZhEA01bKGzDihc5gRK4DDE+hsfSHPbkxpj4pWV05Xg
	7NwpsdMvXQDhT44aKNb6abaA6GxYStGWzRwfyN5/4jBxdIEdcn8W3lPlzYK/RXYX/a1jRoJGaXy
	V6GppLl9ZjMQvykkgEZn9mlb5mPUCKv5o8T7bN+e6/Z0ajbuE2TPDe6fQqu8XdZkKYi7qTDvg/Z
	KM7vtdKskq9SD1qYTfadPkmmHbYXa3z5pIoVkSq8OX7kBINnsHIptzmyppkcrdFgQm0QOnZcQH9
	9oxxTzmyMcE=
X-Google-Smtp-Source: AGHT+IHUazrPlEet43khWdyf1XxNCYUu5w5+tqtqvaSnOm9KMVvJkpgW6G3rA/Hm6dlK5sFlWJd5odNJwJX0gdLy7xE=
X-Received: by 2002:a17:90b:38cd:b0:340:ad5e:cb with SMTP id
 98e67ed59e1d1-34f68b8325amr16854677a91.8.1768257808289; Mon, 12 Jan 2026
 14:43:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109184852.1089786-1-ihor.solodrai@linux.dev>
 <20260109184852.1089786-9-ihor.solodrai@linux.dev> <CAADnVQJDv80_T+1jz=7_8y+8hRTjMqqkm38in2er8iRU-p9W+g@mail.gmail.com>
 <b099a95e-5e69-4eeb-a2c9-9a52b8042a85@linux.dev> <CAADnVQ+_AmiwuupkVJTGyKY3KOp68GLuivs2LMEr0M_yaHPUUg@mail.gmail.com>
 <0c4d84ab-1725-45bc-9c1c-8bdc1f5fc032@linux.dev> <CAADnVQ+k-nbq-2PGRSPJDRZ3G9sp9zu3Owqsj7zqO_G+3OQEww@mail.gmail.com>
 <f0e63b55-65c3-4367-b3da-275df18147a1@linux.dev> <3a697699-ffcb-4e2f-a7a4-9e3f571aa402@linux.dev>
In-Reply-To: <3a697699-ffcb-4e2f-a7a4-9e3f571aa402@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 12 Jan 2026 14:43:15 -0800
X-Gm-Features: AZwV_QjU-ODZg1GeGIyYt8QDqUW_SFHA2LTq3XVJjopePVE88KAjYA43jKP0aL4
Message-ID: <CAEf4BzbgPfRm9BX=TsZm-TsHFAHcwhPY4vTt=9OT-uhWqf8tqw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 08/10] bpf: Add bpf_task_work_schedule_*
 kfuncs with KF_IMPLICIT_ARGS
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, Benjamin Tissoires <bentiss@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>, sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 10:54=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linux=
.dev> wrote:
>
> On 1/9/26 1:56 PM, Ihor Solodrai wrote:
> > On 1/9/26 1:49 PM, Alexei Starovoitov wrote:
> >> On Fri, Jan 9, 2026 at 1:39=E2=80=AFPM Ihor Solodrai <ihor.solodrai@li=
nux.dev> wrote:
> >>>
> >>> [...]
> >>>
> >>>> I feel bpf_task_work_schedule_resume() is ok to break, since it's so=
 new.
> >>>> We can remove bpf_task_work_schedule_[resume|singal]_impl()
> >>>> to avoid carrying forward forever.
> >>>>
> >>>> bpf_stream_vprintk_impl() is not that clear. I would remove it too.
> >>>
> >>> That leaves only bpf_wq_set_callback_impl(). Can we break that too?
> >>
> >> Sounds like Benjamin is ok removing it.
> >> So I think we can indeed remove them all.
> >>
> >>> Then there won't be legacy cases at all. It was introduced in v6.16
> >>> along the with __prog suffix [1][2].
> >>>
> >>> If we go this route, we could clean up __prog support/docs too.
> >>>
> >>> I think it's worth it to make an "all or nothing" decision here:
> >>> either break all 4 existing kfuncs, or backwards-support all of them.
> >>
> >> I don't see why "all or nothing" is a good thing.
> >> It won't be "all" anyway.
> >> We have bpf_rbtree_add_impl(), bpf_list_push_front_impl(), etc.
> >> And those we cannot remove. sched-ext is using them.
> >> Another few categories are bpf_obj_new_impl(), bpf_obj_drop_impl().
> >> There are not __prog type, but conceptually the same thing and
> >> KF_IMPLICIT_ARGS should support them too eventually.
> >
> > I was thinking we could remove/simplify code relevant to backwards
> > compat of existing _impl kfuncs. But you're right, if we start using
> > implicit args for other types/kfuncs, the "legacy" case still has to
> > work.
> >
> > Ok, in the next revision I'll remove all the __prog users, but leave
> > the "legacy" case support in place for future use.
>
> I just had an off-list chat with Andrii, and we agreed that leaving
> the existing _impl kfuncs supported may be a good idea.
>
> It doesn't cost us much: we keep the mechanism for legacy functions
> anyways, so supporting bpf_wq_set_callback_impl() and co only requires
> keeping definitions in the kernel.
>
> The only benefit of *removing* these _impl functions is that we could
> clean up __prog support.
>
> But having backwards compat seems like a better deal.
> What do you think?
>

I think that bit of __prog clean up might be worth doing after all.
The biggest difference for users if we remove _impl stuff from new
kernels would be an extra explicit xxx_impl kfunc declaration (it
won't come from vmlinux.h anymore) and then the following call pattern
(which probably will be hidden in the macro anyways):

if (xxx_impl)
    xxx_impl(..., NULL);
else
    xxx(...);


This will work on old and new kernels alike, so ok, let's just drop
all the _impl stuff. Can't do that for bpf_obj_new_impl() because
that's already used more widely, but for task_work, wq, stream -- they
are all fresh and not yet properly used in production.


>
> >
> >>
> >>
> >>> git tag --contains bc049387b41f | grep -v rc
> >>> v6.16
> >>> v6.17
> >>> v6.18
> >>>
> >>> [1] https://lore.kernel.org/all/20250513142812.1021591-1-memxor@gmail=
.com/
> >>> [2] https://lore.kernel.org/all/20240420-bpf_wq-v2-13-6c986a5a741f@ke=
rnel.org/
> >>>
> >>>
> >
>

