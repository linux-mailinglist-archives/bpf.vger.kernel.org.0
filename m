Return-Path: <bpf+bounces-74615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE99C5FD9C
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 03:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B6A1E35A332
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 02:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE6C1B78F3;
	Sat, 15 Nov 2025 02:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/8INstA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFFE14B950
	for <bpf@vger.kernel.org>; Sat, 15 Nov 2025 02:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763172103; cv=none; b=Hu9ETOqAsKSfnmdvUkQp3TRcgBbVtIYaBIuYy+ymWMkO9ZqlO4jpY08V+i0hAUzi+r8Ec2PZrjaeRMrmKCJbepbFl+woeaiD92kkgjiOI5MYKyrdQCyhJ6FAVjr+Sw1bc0zcAYcPHzmtEOHwqp9HRzWtXCsuFBRU5xrG/tqLBAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763172103; c=relaxed/simple;
	bh=/43KkXepOYmTg+RLFX6sLPbu5i/jn78Mlcc9IHgLJf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TOppdMGWAnrl9sCBOorDq/emt9U4xRUvmWqGErWkZUbWhIJnq8N1JVIKZdTji4y4uaEDy4F8cyUgX0r9OHGi1ICiHw/NUh4OqXuyQNXMB1Vie27z7nBIwpBpczscCAFWvm2MnUp22nzAEQKi441aoo0nfl8mJiXCZStDLE9ZB8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/8INstA; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42b427cda88so1850074f8f.0
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 18:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763172100; x=1763776900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snvBoq+ef5JsLu+gjGmrgTsLGO/j9TpebBmcGlqRx1M=;
        b=T/8INstA3vrr7Mqcm4k0nqu7RyMIGoz1qGblCC3nr7gtr9aXvaTwTzfyufDU3Q43iN
         Utdw3fyPxcK9Z0Sew+IA7Qz6DcNTL5CrbZJE+/wl8dJMFt6ADLOBaBP67m3Azc8RwRPL
         2weOjAVCn4neETSnbR1gi0n46EAVFkj0wMtCZPP7nT66VPWLkn3psyNCd/MlWymYokJG
         GqQW3AS/vtJPtrtTyslGvzzYV69wpxIb13iMowJTfeRus0qVFaNcyoAipROenRwbIiCL
         v6mAy1/AWTSTbCKk2u8044jJBx5/RL7v6cG6wIXpLl4M/ZIKBQuWq9v+ZXFwyCAhqs1n
         0kHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763172100; x=1763776900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=snvBoq+ef5JsLu+gjGmrgTsLGO/j9TpebBmcGlqRx1M=;
        b=OITor+CndbM8+n2vi/dgWQzAW2wvLhSFbgd2hgVmAWxvSd99nyNsyZy02dJBOobWjT
         sMA4matMmlA6uTHLG7e55XoM9ok+ZkHOq0oA9l24L8dcCpxvzK90yBOU8f99kCBbvyNi
         YedQ0FAHvlx+goLk0Jezo5dR3tEEPSwOZQRya7XuozUZ+KELqXZWDZfaXAN9MtLoS4qn
         3xsnkj1buO1Qfg6d9j6vqNbui5TeeEidKivoL9RlE0pMaGjYFxH936Of4maaN2KqQadX
         V+IDX0oO1nkqYRJRQFGEL4oPEMgd4jIRzla7b9yVvxbsiueAn2xT1NTp04JF6JpRL+J3
         qNPQ==
X-Gm-Message-State: AOJu0YzEeFQ6NbWgmNnrlBoyZTxS9Uhkl4KlBwft8gSNfGJ+/PfboeBM
	rVX/Yo73kN/tEYJYGl6EoJ9ZNw8vyo2koVdpGUovmYykd+njEoVmZDfvHvuLndGmfc+WWIQAUZw
	sW1xhLBowqG7rVaqyOzJUgsOL/FOtuQ8=
X-Gm-Gg: ASbGncsYn34jjXEherP90ki4pt0pCfURoYKE8ld+zyvm4fwjcoLOSxf8pgnPK6xoMTH
	0I4ok4w8Miuy28v3WcBmi8y52+QQePHo4rZNctyJIkB5TG4EwJC/5xDLyzPQjP9Lp1c+0INA+uY
	cFx7s+K+n03qa8DlETNAHv75YpB3u65UwwRIyIxVbJiTVwbCAYVHGoQ0RGC23KuNbdKGNdFOghI
	rkM5iKyCv7VGVlqUoyIIvsRJTGr+tDByzN0Itu7ZYCIDU6aqeJe1Smysv+nZpspuBxtB798P6iA
	q3twV5r3CmbgQxIDjXnl7fmio9ON5NNVNkGGa08=
X-Google-Smtp-Source: AGHT+IFcIbmy0+KdmUTm8TULB/r+E+XQFU7N48InvlfGYO4yRCsNOw+aAzQYgliXTXvofhb9tnNDN8rxRdQuNV1vJuk=
X-Received: by 2002:a05:6000:2913:b0:42b:3806:2ba0 with SMTP id
 ffacd0b85a97d-42b593234camr4860658f8f.2.1763172100006; Fri, 14 Nov 2025
 18:01:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114201329.3275875-1-ameryhung@gmail.com> <20251114201329.3275875-5-ameryhung@gmail.com>
In-Reply-To: <20251114201329.3275875-5-ameryhung@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 14 Nov 2025 18:01:29 -0800
X-Gm-Features: AWmQ_bl0zPxy_ssWz8jZphhCNVf_RE23q-z7MI3UW-rrA4RSIF6BfYq7BiradNM
Message-ID: <CAADnVQJD0xLa=bWUerdYsRg8R4S54yqnPnuwkHWL1R663U3Xcg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/4] bpf: Replace bpf memory allocator with
 kmalloc_nolock() in local storage
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 12:13=E2=80=AFPM Amery Hung <ameryhung@gmail.com> w=
rote:
>
>
> -       if (smap->bpf_ma) {
> +       if (smap->use_kmalloc_nolock) {
>                 rcu_barrier_tasks_trace();
> -               if (!rcu_trace_implies_rcu_gp())
> -                       rcu_barrier();
> -               bpf_mem_alloc_destroy(&smap->selem_ma);
> -               bpf_mem_alloc_destroy(&smap->storage_ma);
> +               rcu_barrier();

Why unconditional rcu_barrier() ?
It's implied in rcu_barrier_tasks_trace().
What am I missing?

The rest looks good.
If that's the only issue, I can fix it up while applying.

