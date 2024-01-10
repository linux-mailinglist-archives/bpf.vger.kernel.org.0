Return-Path: <bpf+bounces-19328-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C51A4829FB3
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 18:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21D39B25948
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 17:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DFF4D109;
	Wed, 10 Jan 2024 17:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDAB/sug"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5014CE17
	for <bpf@vger.kernel.org>; Wed, 10 Jan 2024 17:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33694bf8835so3741852f8f.3
        for <bpf@vger.kernel.org>; Wed, 10 Jan 2024 09:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704909018; x=1705513818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3JCVA0MAbyhY2Xtej73DUOwjD+Mhw2xqSxOeOgV8vB0=;
        b=RDAB/sug7tdQCBEESt15MYJDg0/74czccFLqnx8DUxNQ+YUC0lDtgaFJu3e8uLfrMq
         8bpkRbCvCmE3eSWscxcoDG0arJnGvsXROQPDoBSWkUTSFupSFi3HCpt41nq+1zfJ+wVj
         VZv+PO3BYlNpXMIBO9HRTp9iyhDi8y3Izru3qAIf4Ou8RTtNiztnQ0ENNeXKT8Ui0OEy
         3G43QlGLnFiNCUDj/OUrRXLPx1Ak7XrewKk4+rNz0CiavgWszg/QTCH2peaiFpmu+KcW
         ThSyZw5WMIpFsFkU5R6sKqaLDSmM7+72DiFQWwLvNe4gALDfnhkCE7ocK9BiPLbY0HOg
         Tkmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704909018; x=1705513818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3JCVA0MAbyhY2Xtej73DUOwjD+Mhw2xqSxOeOgV8vB0=;
        b=YcTWQDOAaceegwm6Q/Ow83CFlDSZnH0mJGuvzBGCqqDmi0vTga5yjx/Ca0wInvEw2n
         tMuL/JyvbW8rLuSGtrN4MlOVkt/oWtUNvke+uU3QwCwU3KITj+twAO+vpSUSJ4IoyKU6
         vEIObNALIdamQ2m9VBeQgCcGCWzN6Jtr4WS3b+e/ZOziNa3S2MAiEF+UcqaH8mgIjxvq
         71j5WokRkzZGglpvOxVJZ3vLLepLj1Og8sAH1/sPpmk7ygMAKHu1ZEkvX8CBDEuQMREW
         BrbmDj0uknrp54RJrfzQFnFFPPxvn4RrfmlMTrEyIVDt/P33mUqmK3ao/GsyEZ1c6IWO
         6dXw==
X-Gm-Message-State: AOJu0YwWH+REPJ1W3PgUrsISfvIEZVuQrgQr7gS1Xin+2EyZr/Mw/N6q
	pQ/d1B/YWCRQyfT2TyDd6jx0SQZtmakHBuprq8A=
X-Google-Smtp-Source: AGHT+IERfbRgg4uM150NFiiEKtiwlyVEt9GyiFnu0KOkpjz678Xdxb4GwABvoc/T8iVX8cj58Nck7kolW9EUs63XKw8=
X-Received: by 2002:a05:6000:245:b0:336:67fa:971a with SMTP id
 m5-20020a056000024500b0033667fa971amr707485wrz.101.1704909017707; Wed, 10 Jan
 2024 09:50:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110060037.4202-1-laoar.shao@gmail.com> <20240110060037.4202-2-laoar.shao@gmail.com>
In-Reply-To: <20240110060037.4202-2-laoar.shao@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 10 Jan 2024 09:50:06 -0800
Message-ID: <CAADnVQ+Upjb6TCVSeAh2VYXwY+wZfF8OFCwNMQk3uKL06nynTQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Add bpf_iter_cpumask kfuncs
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Tejun Heo <tj@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 10:00=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> +__bpf_kfunc int bpf_iter_cpumask_new(struct bpf_iter_cpumask *it, struct=
 cpumask *mask)
> +{
> +       struct bpf_iter_cpumask_kern *kit =3D (void *)it;
> +
> +       BUILD_BUG_ON(sizeof(struct bpf_iter_cpumask_kern) > sizeof(struct=
 bpf_iter_cpumask));
> +       BUILD_BUG_ON(__alignof__(struct bpf_iter_cpumask_kern) !=3D
> +                    __alignof__(struct bpf_iter_cpumask));
> +
> +       kit->mask =3D mask;
> +       kit->cpu =3D -1;
> +       return 0;
> +}
> +

...

> +BTF_ID_FLAGS(func, bpf_iter_cpumask_new, KF_ITER_NEW | KF_RCU)

this is not safe.
KF_RCU means that 'mask' pointer is valid in RCU CS,
but you're storing the pointer in the iterator that may leak
past RCU CS.

You need KF_RCU_PROTECTED at least.
KF_TRUSTED_ARGS might be necessary too. This needs to be thought through.

