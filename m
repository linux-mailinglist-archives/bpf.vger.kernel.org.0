Return-Path: <bpf+bounces-68410-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A41B58367
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 19:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00F257B3CC0
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 17:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEE02BDC2B;
	Mon, 15 Sep 2025 17:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTTIKSOU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD27284693
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 17:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757956839; cv=none; b=oLHerFeGZC5jnqufp5kzUCP1td8QrTVP0ngoNKXAYUINmdw2/OwVPGXSOe9j3iL5bpraKtmiTZziRB32rrXpdEbs29lLoWv0fMoVTuEngzdecQwyQliTAcVgXAnN0ot4vfuPguv2Bjd8lbmJZ7u+A7pr1qcXJWk9sQYfgBH1/LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757956839; c=relaxed/simple;
	bh=1qov6th7cCIsI/ExKMEr5Z2juqrZ2R3i/EdZtlEssPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nQMuuNgBc4ssfgNBOz9nOPOe17AAVkhpGN0DaP0BVW06rSNX6z+ae7WuKHBOXYGFoZpZYE1fm+FiLd8v9tEX++oqCt/qdp6uvgoSvtiOPFEEo/hfJgzpxa4QUNMZ0+n8UgRJ2IcQQSCamuG9YC2JtPZCtQ/Dx4VnRJGB94quVC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTTIKSOU; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ea7af25f8aso551477f8f.0
        for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 10:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757956836; x=1758561636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ed+aXjjmSvbPr2Wqg5nATrXFGqPhNsC0aXEJs2HqI10=;
        b=PTTIKSOUkkSdAQubgSHcQYt5eD0gqDLQuSUOJmQEuZg3klBnPfQuA4v2LqdGf/7Vwc
         YLmpZmDOaUndl8KakvQKVmmK8mgLwUr6vRFmMmwXBESxFhy2ZqWYdytMtLNe/m4MV95f
         ByV8qtwtdy7Zub8nq35ZM8roz1ykAgrmeNyFHywHR9N7pdyxqILalyMkAd1Xe6ducDIb
         wEXUEyYL2j2AEJgDjw/P38D3NjkraHxEfr2ImXw7ch7B2myii4Jz83elunuGQOHj3eLD
         pu3RXQ5iMEgRPgjl5lQTVXpmBwvn6qJOzWEJZy6WTAfn0Oplao0FEpOT6fd4rcud4+hH
         9Jnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757956836; x=1758561636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ed+aXjjmSvbPr2Wqg5nATrXFGqPhNsC0aXEJs2HqI10=;
        b=tBVep9bXBeOsY8OPbvOwkI2IDVvfN5Eb1ATuRQAZhkNTsozjYPqqYFxga0IBMg1GZ5
         G3yW3b8RA/cqRPn3crQzv/UFcagJTiSYC5mDnKgAh56GzCYLMtC7oD5IpkjpjyNTaHzJ
         5+zWiaquYPrEvKrk/f7Uulf9OAexd55dd7aHsXx4syaGdznClT4UO98hcvaFxn7eiUCQ
         pkvHwtM1/Mo4aBuX5MK6BBPqDporHeR41c23nRCt+0nfWfXwx8WjCbiUE8Bo48C0saSO
         oxNfRSbqAioYL3Y4ZoIlrwWstYR5seJn/Ni6jJz4KsHpYjPyCXW60za4vHbdTScD+9RU
         CgDA==
X-Gm-Message-State: AOJu0YyH/cDLi0HyrPvRTaIjeEJVVdNa/iv38HHSuGrCioNyZM5gGuOT
	C1/CYMY0ApYB6Tah/jb55S7eG6bVQmAtMJjTYOS+faoRyXO3Z3H725hOtUAYFek1JAhlP3MjHqs
	RwDbdqsGtg3NnV52zFqRGqWTv+wnrRI0=
X-Gm-Gg: ASbGnctz3RNLeSgLbqZGyQvGVfI0kjbd2eboOsce8cmm7+TP5rT895Cw/R2Tsku1Oqp
	Efm0R5OH8St66d/OqYMZH0DnPcRZWRhJNJLEyRtQxz5o+mElreug6iyNBeKva4xdnBprYdk7iPn
	4aD4hodMVCRyCsv7Or4Ddw0gLUg/yKv0FbT9pj9CAc/OUzbe1/Gj48rOWz4eAMNUi/yoPiZsE5D
	wF6mno+Yyc7yPfLpo9TsT0uaqfiEKrozg==
X-Google-Smtp-Source: AGHT+IEhzTAX8pEctBRcX/TjG5z5k3JDwdepR4QhqTXE2MmYE5qTziCmh+EbjgSeFMWs2gUVvOp2vgsfRjZETZdfKkg=
X-Received: by 2002:a05:6000:2408:b0:3b8:d360:336f with SMTP id
 ffacd0b85a97d-3e7658c1c6emr12384479f8f.28.1757956835971; Mon, 15 Sep 2025
 10:20:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915032618.1551762-1-memxor@gmail.com> <20250915032618.1551762-2-memxor@gmail.com>
In-Reply-To: <20250915032618.1551762-2-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 15 Sep 2025 10:20:22 -0700
X-Gm-Features: AS18NWDPKVDcnHUjr9wYnQmcG8Hucvs6imRFZt9mjGbw28lgiaeXfaV_I9wbHV8
Message-ID: <CAADnVQ+3NdReC_urqC9bv+2y-kq8m+e-eMGOm-ht8qEQUHShpQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Do not limit bpf_cgroup_from_id to
 current's namespace
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Dan Schatzberg <dschatzberg@meta.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, kkd@meta.com, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 14, 2025 at 8:26=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> The bpf_cgroup_from_id kfunc relies on cgroup_get_from_id to obtain the
> cgroup corresponding to a given cgroup ID. This helper can be called in
> a lot of contexts where the current thread can be random. A recent
> example was its use in sched_ext's ops.tick(), to obtain the root cgroup
> pointer. Since the current task can be whatever random user space task
> preempted by the timer tick, this makes the behavior of the helper
> unreliable.
>
> Refactor out __cgroup_get_from_id as the non-namespace aware version of
> cgroup_get_from_id, and change bpf_cgroup_from_id to make use of it.
>
> There is no compatibility breakage here, since changing the namespace
> against which the lookup is being done to the root cgroup namespace only
> permits a wider set of lookups to succeed now. The cgroup IDs across
> namespaces are globally unique, and thus don't need to be retranslated.
>
> Reported-by: Dan Schatzberg <dschatzberg@meta.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/cgroup.h |  1 +
>  kernel/bpf/helpers.c   |  2 +-
>  kernel/cgroup/cgroup.c | 24 ++++++++++++++++++++----
>  3 files changed, 22 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> index b18fb5fcb38e..b08c8e62881c 100644
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
> @@ -650,6 +650,7 @@ static inline void cgroup_kthread_ready(void)
>  }
>
>  void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen);
> +struct cgroup *__cgroup_get_from_id(u64 id);
>  struct cgroup *cgroup_get_from_id(u64 id);
>  #else /* !CONFIG_CGROUPS */
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index c0c0764a2025..51229aba5318 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2546,7 +2546,7 @@ __bpf_kfunc struct cgroup *bpf_cgroup_from_id(u64 c=
gid)
>  {
>         struct cgroup *cgrp;
>
> -       cgrp =3D cgroup_get_from_id(cgid);
> +       cgrp =3D __cgroup_get_from_id(cgid);

All makes sense to me.

Should bpf cgroup iterator
in kernel/bpf/cgroup_iter.c bpf_iter_attach_cgroup()
also use __cgroup_get_from_id() version
to allow iterating any cgroup ?

That can be a follow up, of course.

