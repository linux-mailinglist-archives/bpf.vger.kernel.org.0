Return-Path: <bpf+bounces-56652-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B24A9BB9C
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 02:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA6261B686B1
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 00:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE8C10E9;
	Fri, 25 Apr 2025 00:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPaRtjkR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34B6A29;
	Fri, 25 Apr 2025 00:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745540040; cv=none; b=jCnEUQUpLLNkwPtlbZxVAWQGHnmz590/nCc5Zuv+d4HpSHBMD6sF06M4DvUyS1X3hia75JCwGF4wPfAWEnJStvhlEuneOHjHmhuWOnyAYZJ4cX5A5VMlQCqMi98UYWdSxOjQqYNxx4BlcXZ4OI9uZhA1A8OxECeCuQs1FGjENuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745540040; c=relaxed/simple;
	bh=WMN5iO/28N0oyoMFGSj4Ql3cCa9yN0Nvm0/VAlkWKYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gOQSIiJi7snRmfX81dr5ZuXsJHd6jaznGSgNJfWYiz7IVLTMc7KBBqrcyzTJl/Uhpggm9XUNzlSuBONod5BXgRs9etog9pJkn/J8+oJeqABCylNULrFJf90X9kMyXthETf08+mQZAMfM3hXcQUaNnULQIgrcj1t2AJvEO2duQUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPaRtjkR; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43d2d952eb1so11861275e9.1;
        Thu, 24 Apr 2025 17:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745540037; x=1746144837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E7032AcX+glA9yLPe6aUdt2STeaLN54buCtFcLi/YXw=;
        b=jPaRtjkRM9IWXRWjLnRk12O4fLiFOfLAQdBarA9gd9cfnp5A3YqCydQwL39DlvjvG3
         e5G9f3byzsY6DwL0/RSDhOhHFSGVGUqnMe8sF27HfXHtVJhaomj7zzq8VTHjDsZ1wbyY
         83sV+ZzY5R+kCd+0fGpw9vpgQunQmk+s6d8uHSlSMiw8QWLqmLV4v73pW+zoX3H7ELa1
         KqOIO0NpP4ykmE4j74EvmnBIMzTwSE4O/0icEzO45Lm5LNAUb1vychk4ap/1j2YUOaC4
         nzmXjOlzGJUFGGId3csJgDrXl+R/3kFFGz3jbpkxDHdeG0cV/5YLuJkBuq6s6gJMi345
         q5BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745540037; x=1746144837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E7032AcX+glA9yLPe6aUdt2STeaLN54buCtFcLi/YXw=;
        b=BDNqUX7AUw+2XY00bK6TjWn2j6YDo8ZTBtLFcN9Z9GwY5G08JdqKmMGGyKXcwU7M9b
         /07sIUK9yX3djuI3IbM6DWMIhq9FMW/vHD38XCXZPii5x/uhUoGvWUkJKPvupekh/RLS
         czmx5mwyTjf+k0AvtArTTH/CgbU9wO5zu8Lk+Jiv2RSxZfz95vYkEwrvuvst2XQ2o8L6
         2kWXGlkZnTOdFnwl7NXxju/e2jgtbNDK3WJVYurKUG47sELtV70aXaVeTM3o4XAaoq3j
         25Id4UuAEOfuasLlJwl5wSJ2AZuYQFXWhQuiMSn7iNzn65gJoOAFe/PmhJvMTWJ8vJvs
         wmdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVz9diDJwbIwXJR7NCwPVeTZ2dwl1slsu1iqIBjSbZ6QNFO/aDyPugRGhmLgzf93nmmBpoJCl8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2i0NKK1hNdXyfFRM0+iVxXuJUBGd2vbGr+7cI7b+co7sdlYae
	i6EIlJvEHM25ghd2OCsNch+jANLhbLVgQAUeDXwx2OVduHIz2KUkhL3ltVy+iiNxIAal+Mm5pMg
	DPUwWjm4Qcj+aQ1ibXa74wiflAb4=
X-Gm-Gg: ASbGncsQRjStPKXg+l6zDIpaOtL3ApfH/M82jrt9ZL9KuYT9gmG06dw81JUma9mRoX/
	3kj/NGQnbKXDc9u6lR7wTzloGcfkaQymiFKlDxub9rUN/ldXVYK37tuj5fZMzE8XwwBCwPvAQwn
	96Is0iUUdqvr+XlDutiUAP5mLYtJzxEKDR9Bnc+Q==
X-Google-Smtp-Source: AGHT+IF7qRIxt1z9jR2o0Mf6ZjtbKV8jF+cvY5gUf0pXP9aWH8NAVmmAVaPptDt3J3nGDOJiJSoG7qj6LcOMN4UOJwI=
X-Received: by 2002:a05:6000:240b:b0:38d:d701:419c with SMTP id
 ffacd0b85a97d-3a074f0dca7mr73258f8f.41.1745540036910; Thu, 24 Apr 2025
 17:13:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418224652.105998-1-martin.lau@linux.dev> <20250418224652.105998-13-martin.lau@linux.dev>
In-Reply-To: <20250418224652.105998-13-martin.lau@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 24 Apr 2025 17:13:45 -0700
X-Gm-Features: ATxdqUEiwTXbZWCWUF3dGLOf4HSIe4ZqklDyLrNbxVaAqio0P93mbjwQjRIWEg0
Message-ID: <CAADnVQJTfUyxkZTZHgL8yqwu7VU2Ssbao8B_sw6Q16wJ1hVK7A@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 12/12] selftests/bpf: A bpf fq implementation
 similar to the kernel sch_fq
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Network Development <netdev@vger.kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Amery Hung <ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 3:47=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> This patch adds a fuller fq qdisc implementation that is comparable
> to the kernel fq implementation. The code is mostly borrowed
> from the sch_fq.c before the WRR addition. The WRR should be
> doable as a followup.
>
> Some highlights:
> * The current struct_ops does not support the qdisc_priv() concept.
>   qdisc_priv() is the additional private data allocated by the
>   qdisc subsystem at the end of a struct_ops object.
>
>   The patch is using a map-in-map approach to do the qdisc_priv.
>   The outer map is an arraymap. When a qdisc instance starts,
>   it grabs an available index (idx) in the ".init" ops.
>   This idx will be the key to lookup the outer arraymap.
>
>   The inner map will then serve as the qdisc_priv which is
>   the 'struct fq_sched_data'
>
> * Each qdisc instance has a hash table of rbtrees. This patch
>   also uses map-in-map to do this. The outer arraymap's key is the
>   qdisc "idx". The inner map is the array of bpf_rb_root.
>
> * With bpf_rbtree_{root,left,right} and bpf_list_{front,back},
>   the fq_classify/enqueue/dequeue should be more recognizable when
>   comparing with the sch_fq.c. Like, searching the flow and doing gc.
>
> * Most of the code deviation from sch_fq.c is because of
>   the lock requirement and the refcount requirement.

This is a very impressive bpf prog.
Quite amazing what qdisc-bpf can do.

Few questions:

> bpf_probe_read_kernel(&sk_long

Will the following work ?
*bpf_core_cast(skb->sk, long)

or if verifier needs struct type (I don't recall)
struct long_wrap {
  long l;
};
bpf_core_cast(skb->sk, struct long_wrap)->l

> bpf_spin_lock(&root->lock);

have you considered "if (bpf_res_spin_lock(&root->lock))" ?
It can also protect rbtree and lists,
and allows arbitrary calls inside, so the algorithm
might be easier to implement?

