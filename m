Return-Path: <bpf+bounces-17897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D02E9813E3E
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 00:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74ECE2837F3
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 23:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316046C6EA;
	Thu, 14 Dec 2023 23:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCLh/YYL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EEC6C6DC
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 23:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-548ce39b101so72676a12.2
        for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 15:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702596521; x=1703201321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RWKAXIOm3JXittLsDKvD2E4nsAnKvy7ZC9+/oD5r0Zc=;
        b=NCLh/YYL2fyOxVbBPhgm9H8TdxTlmyT2K/WH3eGjmbsCJztZtWoev5cDu3LsBY7eXh
         HpT3HTtMiF+VA4yhhMsLvHifaJzMmDFIeTx6utCwhd9EmavRmhkkZtlp+fBVBcYVl9Iu
         SmRvDzEnqMZ0V0LzTwbRDgmiriKi/K6Lig8hMgUFhnPjYtYF/j7KQ8aC3TfQhRw7a8kd
         zC22ckqqkaHTs0XGVTDMbmVyJXuGOuQDgPR23H71OlXpis4mH8yRuWRGeFdd17VpCLap
         G9lb6Bt9IbZ+AHaQ6p80yV7+q4DpXJoP7/NtJY8TO/x2qaviZEfUuNBuJOqRa0fUPG7c
         p30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702596521; x=1703201321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RWKAXIOm3JXittLsDKvD2E4nsAnKvy7ZC9+/oD5r0Zc=;
        b=LUq9FeltOQ7OXK1o5zMFJCIqN540d5K78fUK3buHR8KoMS+zURy3mJYo/wwGYW4yHX
         e23o24Xm95kRnwis1UZLRHh2v6im/QzIPRCK9f9ZAYn9Cc1gmlaKXamk8MSJlLk2rf48
         eIjdrQkGPHxog+Hqwz1zQQIwcm8otH0F7YEqCia/zi6bZRc/LvYgkkc+6aA06KRx8PUw
         FORFOLb+fSNTLqd5vYuRgVR1JHnNCrt8id1cVc+pVrlmPEcYxyd1TjD8UdC8M+HNzZNU
         7YqoD4YxdROt1OTjCk3WcVWrbqj+Oda9SUhokcQIAqftsMb65htipUkUQg6ABvWHRiB5
         PXug==
X-Gm-Message-State: AOJu0YyP7hkqt9XurHrEWtG+NFmIH5GyDnoRaHhiNwozsDMnx1QNJraw
	BM4BqU9EFkZzOtyaFfm4HUYalNpxfem3D5G4gFs=
X-Google-Smtp-Source: AGHT+IEp3vAy+lVqa8tSykG/o8wYsDTM4IBBGDYnD3eyZtizDRztWaIuEh2kt+XNfVtbTgs1VVMtx6Z4yLZGtTrXef8=
X-Received: by 2002:a50:99d2:0:b0:552:a7e3:6e6a with SMTP id
 n18-20020a5099d2000000b00552a7e36e6amr49488edb.107.1702596521343; Thu, 14 Dec
 2023 15:28:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213141234.1210389-1-jolsa@kernel.org> <CAEf4BzbfdR+-ZXVvfmbc+Scb9i6SDqDG4C-4RvQE6vq8Pzcqow@mail.gmail.com>
 <ZXrF25fC4V8RtHqU@krava>
In-Reply-To: <ZXrF25fC4V8RtHqU@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 14 Dec 2023 15:28:29 -0800
Message-ID: <CAEf4BzYVPuokasyzT9hzLMdR6OvFYVADnDG+krFaGrk9Nx=LHQ@mail.gmail.com>
Subject: Re: [RFC bpf-next 1/2] bpf: Fail uprobe multi link with negative offset
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 1:07=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Wed, Dec 13, 2023 at 03:43:04PM -0800, Andrii Nakryiko wrote:
> > On Wed, Dec 13, 2023 at 6:12=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wr=
ote:
> > >
> > > Currently the __uprobe_register will return 0 (success) when called w=
ith
> > > negative offset. The reason is that the call to register_for_each_vma=
 and
> > > then build_map_info won't return error for negative offset. They just=
 won't
> > > do anything - no matching vma is found so there's no registered break=
point
> > > for the uprobe.
> > >
> > > I don't think we can change the behaviour of __uprobe_register and fa=
il
> > > for negative uprobe offset, because apps might depend on that already=
.
> > >
> > > But I think we can still make the change and check for it on bpf mult=
i
> > > link syscall level.
> > >
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  kernel/trace/bpf_trace.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > >
> > > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > > index 774cf476a892..0dbf8d9b3ace 100644
> > > --- a/kernel/trace/bpf_trace.c
> > > +++ b/kernel/trace/bpf_trace.c
> > > @@ -3397,6 +3397,11 @@ int bpf_uprobe_multi_link_attach(const union b=
pf_attr *attr, struct bpf_prog *pr
> > >                         goto error_free;
> > >                 }
> > >
> > > +               if (uprobes[i].offset < 0) {
> >
> > offset in UAPI is defined as unsigned, so how can it be negative?
>
> right, but then it's passed to uprobe_register_refctr as loff_t which is =
'long long'

ah, so it's not rejected because uprobe_register expects signed offset
(for some reason...) and it only does

if (offset > i_size_read(inode))

got it, thanks.

>
> jirka
>
> >
> > > +                       err =3D -EINVAL;
> > > +                       goto error_free;
> > > +               }
> > > +
> > >                 uprobes[i].link =3D link;
> > >
> > >                 if (flags & BPF_F_UPROBE_MULTI_RETURN)
> > > --
> > > 2.43.0
> > >

