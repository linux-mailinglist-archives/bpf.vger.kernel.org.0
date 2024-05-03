Return-Path: <bpf+bounces-28520-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8138BB0BC
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 18:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CDA21C20C2E
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 16:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CFA155333;
	Fri,  3 May 2024 16:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jy/+yIMj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA9121360
	for <bpf@vger.kernel.org>; Fri,  3 May 2024 16:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714753173; cv=none; b=Y9DhgY3+aE6oUtHOl6NHOpY+Uagf58aKIz4sCNof1WuxG+NKl6LJecaUJepCO0yzxvYceKageXKqOtmrpNk25xn2NF3G5FjSEc7fXfBhTD26Zhn2pFtIcVk7hMzpII4hkh1JFuxy5WyXkmMF3aN0cnyvJjtgkm1SvczValUedPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714753173; c=relaxed/simple;
	bh=4Ut0Bo09Ic1uNRtQ8uxr8CJrrKn3HnJ3ByVZTXP4VJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VfSHmL4+PT4M/QIrVcHn1PoLLLfC5TT2TJArdQXSJgMDyEBEYPeRoi2GZdoyT8oqvflFqO++Bl19PQgoJahcHFSDO68A1OK2+OLgodbJGIrYcstPRXMmC2owEk8xKRsN1Fz55InNt/r3AXfrO56iYkIcI0MLx9E1IzBBEHwrP9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jy/+yIMj; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41b5e74fa83so63409965e9.0
        for <bpf@vger.kernel.org>; Fri, 03 May 2024 09:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714753169; x=1715357969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QKN35Mxl6BODEPYfOYqJOo3hFjMeWJfkT/Of6XTz5Xw=;
        b=Jy/+yIMjwBIWycguxdojlHz8TWjJf/5tsm3hMo/OHa5eD1g82DKYaZXFUFIRCvBzg5
         qwPso1ZHCzdbUeq00B4xsm7s7QkNHNQUTIPlnmCTWOQtFCKvcAk+4x6khZLyg/8tKB1Y
         L3Iupp1hzvv1lw1X1QOG+0eEAsboCSXOG+QS0I7dc4aVCcpfm3XzLIk41kCn+ohkuBg2
         I6a82WgQomz7uTiDb9hEjC5THfoqgbQv1uMd6iRDfsr4JrOZ/tmS/O6Lnk9lIENXfCxL
         ddTMejA0Db6FzexlnL7ESBfuRSROiKnzC0jZmLGf4IJrpzi4pF5M96hctz/PHJcrQN/v
         mT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714753169; x=1715357969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QKN35Mxl6BODEPYfOYqJOo3hFjMeWJfkT/Of6XTz5Xw=;
        b=RpJaHVwQhSQFfRvagxOAmwDDJZzd5/j2umllTkggmXqXUaKPHE4c4IoG6K876XGgYk
         uwGK7Lh7hJhurDDOfDbwVaiIC32u3wYmpxEGOdbLBDx8GF2QMdSJ2OEeFOtryaiK5iRd
         x2YDsPNUrt0T3rkfN/RuFcwDOwi3CbpwAww5D6u7kXebEvi7xUol4muIQEwIucd63/KQ
         1uv2REGfaGbU3ABL7uiWBkoSCe1zi3/QPvx/Ht8wu5MB1CmkwNYDp6jbS36wbFXXTVQj
         cdnEtdoC1hSvqHN4wW18yWBBPidhjOjiLzFF8sYOCXg2IWx4JUCTYpN8umoQ7y497dxW
         2aGg==
X-Forwarded-Encrypted: i=1; AJvYcCUFDozNxARqdmTUvYX6Y01fv/c6rxcvcbd5xY+RNZQI9ch9HoMwLeg3I/nXI+i0zfgwsT2nKR5SJr25ebj9IZ6+gxHa
X-Gm-Message-State: AOJu0YzlRbpMwIKqlxpnNvC+EdkD8CRdYECUH2xrIDQvBDv5y1kMyks9
	9dCizzq6hT2zx7AQHuODORp9wVKYZGYInaSLAj1HnziSlPO4NGvUKEHxSdIihadCULJ6hf61zul
	+D0n7byv9V8WLgnT0O5l/zS3pX6E=
X-Google-Smtp-Source: AGHT+IEvw2I1EBt65Ohu04MiNo2ZpVRkhWhllJ4c2KxdjJ9k4mhQw0crVO+i/XZQ5K9H+QW+FqPwLdAHYvPUAtZREaw=
X-Received: by 2002:a05:6000:87:b0:34c:5f6e:1720 with SMTP id
 m7-20020a056000008700b0034c5f6e1720mr2402435wrx.60.1714753169562; Fri, 03 May
 2024 09:19:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429213609.487820-1-thinker.li@gmail.com> <20240429213609.487820-4-thinker.li@gmail.com>
 <f287c62f-628f-4201-ba34-03a7193212d8@linux.dev> <5c07376c-40b3-4dd3-ab2c-7659900914b3@linux.dev>
 <fb06e9a7-244a-421d-ae9e-8d6da9a25684@gmail.com>
In-Reply-To: <fb06e9a7-244a-421d-ae9e-8d6da9a25684@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 3 May 2024 09:19:18 -0700
Message-ID: <CAADnVQK6NqyFrjW29m-02GuS0jFyxyWWNySp+82N2+oaVZNg8A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/6] bpf: provide a function to unregister
 struct_ops objects from consumers.
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Kui-Feng Lee <thinker.li@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Song Liu <song@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Kui-Feng Lee <kuifeng@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 5:41=E2=80=AFPM Kui-Feng Lee <sinquersw@gmail.com> w=
rote:
>
>
> >>> +    prev_state =3D cmpxchg(&st_map->kvalue.common.state,
> >>> +                 BPF_STRUCT_OPS_STATE_INUSE,
> >>> +                 BPF_STRUCT_OPS_STATE_TOBEFREE);

All the uses of cmpxchg mean that there are races.
I know there is already a case for it in the existing code
and maybe it's justified.
But I would very much prefer the whole code converted to
clean locks without cmpxchg tricks.


> >>> +    if (prev_state =3D=3D BPF_STRUCT_OPS_STATE_INUSE) {
> >>> +        st_map->st_ops_desc->st_ops->unreg(data);
> >>> +        /* Pair with bpf_map_inc() for reg() */
> >>> +        bpf_map_put(&st_map->map);
> >>> +        /* Pair with bpf_map_inc_not_zero() above */
> >>> +        bpf_map_put(&st_map->map);
> >>> +        return true;

I haven't tried to follow the logic, but double bpf_map_put
on the same map screams that this is broken.
Do proper locks everywhere.
inc_not_zero and cmpxchg shouldn't be needed.
keep it simple.

