Return-Path: <bpf+bounces-22966-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF8086BC5E
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 00:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CF341C22676
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 23:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0749172931;
	Wed, 28 Feb 2024 23:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUPiTmj9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B0A13D306
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 23:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709164520; cv=none; b=NNcUX0wIqeEFXuSaYTwIvSlmlmTb/UY0qXJ4Kot0CkAFNDcQL4PlDCx89iBRZf+Z8yqKpxQBWB2AY876bkvHM0eyyxMIMb7I1dmnN9w8ChwlDtPOkqJzzM67AquOvHtCpQFDx1sEAHMrESc9ZwiY5Fiv3eggefdkwdhScLfdET0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709164520; c=relaxed/simple;
	bh=Y4cySuEqeMGtHLN0Mqivrpy7K3iJazNWfRSILB1C1L8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tGXSMDT9prx3k3+RYvqW4GthWe+VpIAt+2kpZd455pVvqAF/id8apXEFES9etS+dpOVDJlVV3OY6g2FDYIrfDa4UfJxipRwMcLdElvt04LoiiHOXlcPfYYNl/1n3DnovsclRVbqcut+WZxMWDzusBBxkOf6VdhjD6m1UpXe6zVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUPiTmj9; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d944e8f367so2877495ad.0
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 15:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709164518; x=1709769318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BbIoQw1WozDnoDOR+YaVUuZap3T7yLMHZD+UWAdUh/g=;
        b=TUPiTmj9u8kL0JI0UgwT48XuLx5EiXuUYFD4ZfFubHWTZ6ESavi8gLOrdIBiFpKSlI
         A0wm/sdojuOXvk/BOTJvn+0i3WTezGtaLMdjKIL3xmwY7HGGbAydu34yl6sIDKK7BNOq
         qn0saPWTWhHvDPljbtJLwZzuH6iq02uyRtRnOCFzFKvXl7E/dbtDdU8SaG/OUmHRq5Zk
         +ae6AlXTD+4Ph8TbVsUoD+glHVCqtCLZOUXeNbZWvzPjrrFqralF7pITdUjq7Ubx7C2Z
         7J9BGAwIVNxv/XCmxF4Ud/pf/M27FtcfIDsgjcQXlDs3lmROkQR8C7mJos4HqKTEzh6u
         7gvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709164518; x=1709769318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BbIoQw1WozDnoDOR+YaVUuZap3T7yLMHZD+UWAdUh/g=;
        b=Owtd9yeJ1sBWWWQPW0GmnwxayPy3OAru/9TSEmnsOLibr+2UkDRPuBSX9xWrC4lSKO
         r7Mt9hnDEbqrw88r1gG6oq3fBp1S2ZY49p5EWz0Arujn+AKj+q80CIYQMbq2wFheFUzA
         Liqv3lQfyNsILG6SpYIqceWigM4Uf3DgmBmtCUJZcBrmyKhNxy+rtIK6KMGTE0z9sN1X
         BA55U95A3rjkeqxY/QlybnZkGd8XmDUrhOEybrL6p/0lk0BiLy9Fs+XDjmSymh7wt1qv
         t54FQch0mwc5es2S2Cz2mB9IJhisL6vcfv4Ts/FzWEDSXe77mfk89m2bd2ho9pNM+xw+
         bTTg==
X-Forwarded-Encrypted: i=1; AJvYcCV7TwUabUB/xhxBNmhOaJ76weMYSeWtVahaKBN4zhYT1VnmIxQfRw3j8/ycaNWVZM8+xoi+nV1wLyeidiPFlywxa6Y8
X-Gm-Message-State: AOJu0YxcAmZJ3iNU/VO9RiZwKGz1Q+XS3/zRmKWXILmWPplYlgxxhor+
	lbwRjcwsnn27XjKSMfaozsQ6JS+og06Q+cl/DBM+Lt6B8tWClrD+aZLOd+xdxfl4rfSyB1ywkuG
	Kp7bKanS1+SwiWE1MNZeF4mW7WO8=
X-Google-Smtp-Source: AGHT+IGnrvZsESR2LWZZogkuoDI1c27+YBSM7DPTuSKvtSFnf5V9U4w7I5mZs+dz4Z5EuwjeYXWGLK5UxjJeMZr6ndM=
X-Received: by 2002:a17:90b:23d1:b0:299:32f0:8124 with SMTP id
 md17-20020a17090b23d100b0029932f08124mr711951pjb.42.1709164518412; Wed, 28
 Feb 2024 15:55:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227204556.17524-1-eddyz87@gmail.com> <20240227204556.17524-8-eddyz87@gmail.com>
 <1e95162a-a8d7-44e6-bc63-999df8cae987@linux.dev>
In-Reply-To: <1e95162a-a8d7-44e6-bc63-999df8cae987@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 28 Feb 2024 15:55:06 -0800
Message-ID: <CAEf4BzbQryFpZFd0ruu0w9BC6VV-5BMHCzEJJNJz_OXk5j0DEw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 7/8] libbpf: sync progs autoload with maps
 autocreate for struct_ops maps
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>, andrii@kernel.org, daniel@iogearbox.net, 
	kernel-team@fb.com, yonghong.song@linux.dev, void@manifault.com, 
	bpf@vger.kernel.org, ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 6:11=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 2/27/24 12:45 PM, Eduard Zingerman wrote:
> > Make bpf_map__set_autocreate() for struct_ops maps toggle autoload
> > state for referenced programs.
> >
> > E.g. for the BPF code below:
> >
> >      SEC("struct_ops/test_1") int BPF_PROG(foo) { ... }
> >      SEC("struct_ops/test_2") int BPF_PROG(bar) { ... }
> >
> >      SEC(".struct_ops.link")
> >      struct test_ops___v1 A =3D {
> >          .foo =3D (void *)foo
> >      };
> >
> >      SEC(".struct_ops.link")
> >      struct test_ops___v2 B =3D {
> >          .foo =3D (void *)foo,
> >          .bar =3D (void *)bar,
> >      };
> >
> > And the following libbpf API calls:
> >
> >      bpf_map__set_autocreate(skel->maps.A, true);
> >      bpf_map__set_autocreate(skel->maps.B, false);
> >
> > The autoload would be enabled for program 'foo' and disabled for
> > program 'bar'.
> >
> > Do not apply such toggling if program autoload state is set by a call
> > to bpf_program__set_autoload().
> >
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> >   tools/lib/bpf/libbpf.c | 35 ++++++++++++++++++++++++++++++++++-
> >   1 file changed, 34 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index b39d3f2898a1..1ea3046724f8 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -446,13 +446,18 @@ struct bpf_program {
> >       struct bpf_object *obj;
> >
> >       int fd;
> > -     bool autoload;
> > +     bool autoload:1;
> > +     bool autoload_user_set:1;
> >       bool autoattach;
> >       bool sym_global;
> >       bool mark_btf_static;
> >       enum bpf_prog_type type;
> >       enum bpf_attach_type expected_attach_type;
> >       int exception_cb_idx;
> > +     /* total number of struct_ops maps with autocreate =3D=3D true
> > +      * that reference this program
> > +      */
> > +     __u32 struct_ops_refs;
>
> Instead of adding struct_ops_refs and autoload_user_set,
>
> for BPF_PROG_TYPE_STRUCT_OPS, how about deciding to load it or not by che=
cking
> prog->attach_btf_id (non zero) alone. The prog->attach_btf_id is now deci=
ded at
> load time and is only set if it is used by at least one autocreate map, i=
f I
> read patch 2 & 3 correctly.
>
> Meaning ignore prog->autoload*. Load the struct_ops prog as long as it is=
 used
> by one struct_ops map with autocreate =3D=3D true.
>
> If the struct_ops prog is not used in any struct_ops map, the bpf prog ca=
nnot be
> loaded even the autoload is set. If bpf prog is used in a struct_ops map =
and its
> autoload is set to false, the struct_ops map will be in broken state. Thu=
s,

We can easily detect this condition and report meaningful error.

> prog->autoload does not fit very well with struct_ops prog and may as wel=
l
> depend on whether the struct_ops prog is used by a struct_ops map alone?

I think it's probably fine from a usability standpoint to disable
loading the BPF program if its struct_ops map was explicitly set to
not auto-create. It's a bit of deviation from other program types, but
in practice this logic will make it easier for users.

One question I have, though, is whether we should report as an error a
stand-alone struct_ops BPF program that is not used from any
struct_ops map? Or should we load it nevertheless? Or should we
silently not load it?

I feel like silently not loading is the worst behavior here. So either
loading it anyway or reporting an error would be my preference,
probably.

