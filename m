Return-Path: <bpf+bounces-35537-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA04093B57B
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 19:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E58D281960
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 17:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6666015F40D;
	Wed, 24 Jul 2024 17:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5/lwebi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7795415F3FE;
	Wed, 24 Jul 2024 17:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721840444; cv=none; b=Ggwjv+c+vkXqAY9dbyfvAaSRjGdd8SvLcTPw2/hoko5cN41LiSp1kQbaxqUikaqnxmOypT9OOMQfdkDDyrqfcqpcIOd/vXpFDdhOt9vOVIUk99FP2dE+tw2bq7OIvVzfkJ35bcDLtebIxnBLKnsbWkIMYSY1wCndKv1ThLEdHCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721840444; c=relaxed/simple;
	bh=L9FBaIo9sLKEktVMvBhb0N/RQUJeBgeJKo5uJsvx9Qc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qyi672lm8heA+QUgByR+cs5fZtBk9f5C4/evuP7WJJfAYL1q02TQNKFDACedoJeyFJstggGwjzNj3J+j+gcPHsklvVt3zEJ2SkeUbYNhegU9wLfgfWr1PNmcDoOy3E7YGkxhXpMUwnAxNbPSei11BZKlLR17VbgXITdKzenzvuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5/lwebi; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e05eccfcdb3so6541338276.1;
        Wed, 24 Jul 2024 10:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721840441; x=1722445241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JjWUCwC2vBkyT5arSqYAONMAqVJ7Hmul4z98hr9nc80=;
        b=E5/lwebiIbSfmry5Td7uWM6y2xgkgqRcqvT6smlS21T00mx0/Cq8aRIcxpJnh/knwr
         fpB601CDeA2oiX/vFlt/DHYYAPgpTp4CbJALifkwTWJlGDXPXtbrNla95ZitA4bAwONx
         J2q+VGkBVoelNyIDlD0kGYnBk8x2Uk2vbFjH26ronYbyJpVwta/wN1mTOQqaUwwGhJPn
         TDnVx9Kum0m9kfc4GrQMfi27+vQVmLLG8/gZaAl3EO4trYRHAK6xgORL8s6uHn30zHoi
         4cT25F30m6ibExZQTbO9O98an4Wbct1BnQ7NZDH7/0euZE1/UHV6r//iQg9wLU1Nk0oS
         tP4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721840441; x=1722445241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JjWUCwC2vBkyT5arSqYAONMAqVJ7Hmul4z98hr9nc80=;
        b=v3+gaEkKIV6YTNv1I4o3E1OSg2KKb0HW56AI23yvQLkMuZ65n4J8cRdZZKAuIn/xAM
         YzVxc2XyWsTmtJB97a4NsDBPC9GIxfXYWUAQOSsmKOo8cUuK21efQcTJ2/XfGtnT7CrE
         HaD/FyRGABKrY/BmgBzri5/EVh83HD+rUedpqthZrLOYUKj4/a2BkUIP4Kf4DyuCjJeC
         NYdh9H9+MbK5dNIQJY6tlCApyqLDwr3LglXBs1EtSzrLhMSf0V4PjN+A7QdQWx84gRvz
         vidb6gyuYtaqrrRdML9stps4dwDpofUMWbcdhqACNdYP/LwRzRlc9uVFdpyMaoPA3SVk
         MXsg==
X-Forwarded-Encrypted: i=1; AJvYcCW+RzMRkKzEudv3fpUVqg11v2gNFJyvMX3fyRaW7qNzTlIslB/6b7fnjajWpQYNAawjMs9HZIWB9atz5FQbpWr/MXEPpXzf
X-Gm-Message-State: AOJu0YwP4JxsopyMD4R4r8ON+eJa6uP+jqLJ9gZvkzFZ1Qj8lneP/D6+
	SvQhikkzab/qzFvK3vEGm9SNe1WkxXMm2V6oW0Y0eJ8SlS+gmzoS8xJzRrKSfk8BMPKFuTtVY80
	MgTUsI4idoXs63wOIFXdJ0JSHbkM=
X-Google-Smtp-Source: AGHT+IH7ntmzlI2bt5BYDM95Cjq2pryxaHW7IYCoJvrYqc/u9frLEKpEl/5nLHP3sd/Q+w1yareRKewqel+gVUgZW8Y=
X-Received: by 2002:a05:6902:2b11:b0:e08:54db:46b8 with SMTP id
 3f1490d57ef6-e0b232f9be8mr109925276.43.1721840441251; Wed, 24 Jul 2024
 10:00:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240714175130.4051012-1-amery.hung@bytedance.com>
 <20240714175130.4051012-2-amery.hung@bytedance.com> <907f24f2-0f33-415e-85c6-0400ab67f896@linux.dev>
In-Reply-To: <907f24f2-0f33-415e-85c6-0400ab67f896@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 24 Jul 2024 10:00:30 -0700
Message-ID: <CAMB2axNDVCdH7stBj8-duOcV1P=qjyjUAR+YXywVMx8HgRPokg@mail.gmail.com>
Subject: Re: [RFC PATCH v9 01/11] bpf: Support getting referenced kptr from
 struct_ops argument
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, yangpeihao@sjtu.edu.cn, 
	daniel@iogearbox.net, andrii@kernel.org, alexei.starovoitov@gmail.com, 
	martin.lau@kernel.org, sinquersw@gmail.com, toke@redhat.com, jhs@mojatatu.com, 
	jiri@resnulli.us, sdf@google.com, xiyou.wangcong@gmail.com, 
	yepeilin.cs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2024 at 5:32=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 7/14/24 10:51 AM, Amery Hung wrote:
> > @@ -21004,6 +21025,13 @@ static int do_check_common(struct bpf_verifier=
_env *env, int subprog)
> >               mark_reg_known_zero(env, regs, BPF_REG_1);
> >       }
> >
> > +     if (env->prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS) {
> > +             ctx_arg_info =3D (struct bpf_ctx_arg_aux *)env->prog->aux=
->ctx_arg_info;
> > +             for (i =3D 0; i < env->prog->aux->ctx_arg_info_size; i++)
> > +                     if (ctx_arg_info[i].refcounted)
> > +                             ctx_arg_info[i].ref_obj_id =3D acquire_re=
ference_state(env, 0);
> > +     }
> > +
>
> I think this will miss a case when passing the struct_ops prog ctx (i.e. =
"__u64
> *ctx") to a global subprog. Something like this:
>
> __noinline int subprog_release(__u64 *ctx __arg_ctx)
> {
>         struct task_struct *task =3D (struct task_struct *)ctx[1];
>         int dummy =3D (int)ctx[0];
>
>         bpf_task_release(task);
>
>         return dummy + 1;
> }
>
> SEC("struct_ops/subprog_ref")
> __failure
> int test_subprog_ref(__u64 *ctx)
> {
>         struct task_struct *task =3D (struct task_struct *)ctx[1];
>
>         bpf_task_release(task);
>
>         return subprog_release(ctx);;
> }
>
> SEC(".struct_ops.link")
> struct bpf_testmod_ops subprog_ref =3D {
>         .test_refcounted =3D (void *)test_subprog_ref,
> };
>

Thanks for pointing this out. The test did failed.

> A quick thought is, I think tracking the ctx's ref id in the env->cur_sta=
te may
> not be the correct place.

I think it is a bit tricky because subprogs are checked independently
and their state is folded (i.e., there can be multiple edges from the
main program to a subprog).

Maybe the verifier can rewrite the program: set the refcounted ctx to
NULL when releasing reference. Then, in do_check_common(), if it is a
global subprog, we mark refcounted ctx as PTR_MAYBE_NULL to force a
runtime check. How does it sound?

>
> [ Just want to bring up what I have noticed so far. I will stop at here f=
or
> today and will continue. ]

