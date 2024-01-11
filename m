Return-Path: <bpf+bounces-19354-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D39C82A607
	for <lists+bpf@lfdr.de>; Thu, 11 Jan 2024 03:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02BAF28A5E5
	for <lists+bpf@lfdr.de>; Thu, 11 Jan 2024 02:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59320EA3;
	Thu, 11 Jan 2024 02:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAgkwl9d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA5AA4A
	for <bpf@vger.kernel.org>; Thu, 11 Jan 2024 02:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-67f9fac086bso33007346d6.3
        for <bpf@vger.kernel.org>; Wed, 10 Jan 2024 18:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704940310; x=1705545110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TnYM+HovGc2Ti7WYRyxAIWcBIWoOGK6dAcO1dWdb8PM=;
        b=jAgkwl9dimA9ntO8NaRE7kJTKaWQTzPKX6JsjUxEGq9FF2gIjShSJEKn/wB6o0LqMZ
         qxnZnfXmutWYd76U1Kw3xHbn+cYymu70WEF/BClgPDZPhJOim5DUJhCG6ljzWbAGYXA+
         AJz4TuesAipG4JlMsOwnjsWHd/q1KnAsB5qRxjKKD4KTLYqHas+w2EmDzF7NoFwLNaP6
         +L9LB6IbWIms96rtUcWprQu4yZ35hgp4d+JEwfxy4ZZR5JtP0CZrVlZeEMgyp3eGTeWu
         jaditaJi5iyokhsrrd7L8UYUN+VLYYj3cZCXrs1qk8AhOy7TshdS6djGoDFv+yRidz1T
         WypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704940310; x=1705545110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TnYM+HovGc2Ti7WYRyxAIWcBIWoOGK6dAcO1dWdb8PM=;
        b=HxBBa+ZUyjEKe+ReFG+I+05x7ikbRS5kIUNyWJFDVIh7Pz6ufV2jM5ft/yd2m7BJZx
         +UbAIAhfVSQOwABqlQku+SWKsrY587GyPqYRYvudlvze0HM/Sfrinu0WgSv36j9sfp9E
         4zLDKfy4IVzE4uE7Sz6P+9yZVyJTVHJwzP0v6vPeMhiCxudel8LNHJ+vIcsRqsVkE7Z3
         2LOuETOKhDUZy2eNw+Hb1W3Lf1HmEFf4ldFlOCj/xmcHYZLOXCazrTkaBHof20ynV0ku
         6nVeJ5dwSMl8iykH+w/OZ3iC7pyiqq1v63kjjXPb6D2QlPZ42huuXPj0Ihzk5ROgOhJO
         fmyg==
X-Gm-Message-State: AOJu0YwtyO7vJsTNQ5l39irPPkxw66A7oq4+EkSMa/wBYAcpMaSA5hvv
	Zpt85ilYauftfZwyDFM842xtdhtSvoYWevCnM/VSYtWYNgk4JQ==
X-Google-Smtp-Source: AGHT+IGPIQRkEBVCQwkbehLCnUgb/IVcaUzs7jjyBNcU7k/mXZGbWnAmPuIkYfB0o0k5Rj5wBkxQ5V0nYPfDFi125IA=
X-Received: by 2002:a05:6214:3383:b0:680:fa03:73eb with SMTP id
 mv3-20020a056214338300b00680fa0373ebmr577086qvb.9.1704940310476; Wed, 10 Jan
 2024 18:31:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110060037.4202-1-laoar.shao@gmail.com> <20240110060037.4202-2-laoar.shao@gmail.com>
 <CAADnVQ+Upjb6TCVSeAh2VYXwY+wZfF8OFCwNMQk3uKL06nynTQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+Upjb6TCVSeAh2VYXwY+wZfF8OFCwNMQk3uKL06nynTQ@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 11 Jan 2024 10:31:14 +0800
Message-ID: <CALOAHbBvh0dQrmosQRe+jsm3boPXVhMMiRVVsQwNqsye5pyoYA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Add bpf_iter_cpumask kfuncs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Tejun Heo <tj@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 1:50=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Jan 9, 2024 at 10:00=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > +__bpf_kfunc int bpf_iter_cpumask_new(struct bpf_iter_cpumask *it, stru=
ct cpumask *mask)
> > +{
> > +       struct bpf_iter_cpumask_kern *kit =3D (void *)it;
> > +
> > +       BUILD_BUG_ON(sizeof(struct bpf_iter_cpumask_kern) > sizeof(stru=
ct bpf_iter_cpumask));
> > +       BUILD_BUG_ON(__alignof__(struct bpf_iter_cpumask_kern) !=3D
> > +                    __alignof__(struct bpf_iter_cpumask));
> > +
> > +       kit->mask =3D mask;
> > +       kit->cpu =3D -1;
> > +       return 0;
> > +}
> > +
>
> ...
>
> > +BTF_ID_FLAGS(func, bpf_iter_cpumask_new, KF_ITER_NEW | KF_RCU)
>
> this is not safe.
> KF_RCU means that 'mask' pointer is valid in RCU CS,
> but you're storing the pointer in the iterator that may leak
> past RCU CS.
>
> You need KF_RCU_PROTECTED at least.
> KF_TRUSTED_ARGS might be necessary too. This needs to be thought through.

Thanks for your detailed explanation. I will analyze it carefully.

--=20
Regards
Yafang

