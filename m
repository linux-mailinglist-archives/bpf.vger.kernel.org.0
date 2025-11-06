Return-Path: <bpf+bounces-73902-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22121C3D40A
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 20:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CB41E4E6421
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 19:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7362DA75A;
	Thu,  6 Nov 2025 19:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWULrYDe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243142D877B
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 19:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762457569; cv=none; b=RGs2UISTS96CCoKp+ypOlQgPi8Srj61MTp43ITdhqDHzLyKf/KLLHLJOnWNJmGobXh13Xd0kH6v7VH9AjAMROPT2m3Doh3QgzVVU9aiYXrCEIcQOyzu5DJi9YCnWeA8kz7KfsPPGY2ZG/19r+8yMtqoxNQJ/7qMVDZ+EgDrNAO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762457569; c=relaxed/simple;
	bh=J1HwanVJqmGyUZmqtXsePVvkUL4ixOEFWwb1YQBvcWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A6Uxt92jt0T2us4hLDfOjq6npUhF192/hyk42kkvWKawdvRbbILBRyNw+fkuk1rCCm2w9vk7+PtKAb+MbBlZ0NvZfGABUBhoLVru/HlHlyseHAX5rBr0Ll9sRFVjlV4tm2no/BHK9sIXgVqCOuo+TSzia5T0kjIvzLPUglCmBX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWULrYDe; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47109187c32so6471905e9.2
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 11:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762457566; x=1763062366; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LdX2P425dqJBqqy/BCKowoMdQ+f6XYtt+4UwUATXkU=;
        b=VWULrYDetgSnQnQNbvVV/Yj0m9YHRbVLZ3URZfLst16nIcGGryCnuGjn9Y97lV5E6X
         1DG6r9SI34e/DU/inOLbSwl5v5jMPkdnOUNus78RuiJylxWi/OsAdeYFI9dQTqUORCaJ
         Re+p7Cpq7ZCnfcDAnFurAzwpFrXRmo8QIjB+GcZzdQM5UU9BbtgrOSDoFq9ZvQ2sFsa4
         FFOxkTT1oZ8uBWze+KiQLIHD2eCUvSlRYAuP5/ULZMNlg14XZZCTVRuQTCSxb5ZQ25Eg
         +XOoLiB0PdKjKbHVyixDk7rzLtAp7vnzKE1Q3VRmXJt94JDstGPTF5wpEecrY54p2Q5Z
         oEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762457566; x=1763062366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3LdX2P425dqJBqqy/BCKowoMdQ+f6XYtt+4UwUATXkU=;
        b=h3luMnaEGx+kzJmeJRaVjyPpJENG60cSaiA9aG1nFkXwRcBXstlRrosPZ4BpD6WesL
         gCuN/xMjeVaof2CQcun0CKNbT0/jMz1hz7vts0cjc8rc8rOuMgB0iAq18B13/vCqphDk
         0PaNNIzLp4ypi7gGk74zHGvko6cVGyfzyJUZYFLtrHsFG3ET7YIf+mnwRDIBYBKeNDLc
         g71n/IejYrvewdGDopTvnvo8potYiM3gf8bZQosmLWep0mlwVbvnLp32SssXDLohvISZ
         I5Ku7B3PgS09CXTq27TzxwuvxgiCygSI9hzRkRMh6KUKbR67dhuh5bG07r5YhuuLOGkI
         tBZg==
X-Forwarded-Encrypted: i=1; AJvYcCUviVFMQAyao9wJrZ+mUdKJZ+RfAPwNAF0nGkoK3Zen90gnBnMlJUnRxFc22n+6Fba5c+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKGhXyzFSyt+QQZXOV0D0hRBg8oCYTqE6tuf+fu3hDwzm7dpOj
	a3RjR33raAPApN+yhdtyofCx57m/eUPXylF6haf3R2Rp1w4c0StyzupwAi0OGtEEw1VzPktuSW4
	HwT8Vk3goGhDs/nJ4wkzcOUu3eFKQUWA=
X-Gm-Gg: ASbGncvB6IFR1ULqw97n/f5a+COUefUsTv8GfqgmaR6ftcat9mhz/+o0/Ae7NOIm7l+
	Z/tG0Z+TmFJmHqL9tsYlQRoHHssP2/wNT9600Eho7b+8Jker1raqtR9RRCH399l8Xt5h2ZXLr9k
	1GsFFG1I06h9Ia8CHWEzVJsrIIYxztu/nexvAvV8CGoBnUHBHYrt+OQ4UDSPFHPIO2P4TajFVlG
	0EcL+vQ6sPBklmdmIFtZO/ezrlgr+CZL+O2Qdl894dGZjnx1u7A5odK8+x0oZlxowherI55hrsN
	t1IqCv1EVz4=
X-Google-Smtp-Source: AGHT+IFZ1x5WJx94ejOJ+UHJxQBQIghvIJa+xm2So91Mrkuidp9kOFibRBImuLNpC51GTBEr6bz6CLwxvkvruR0SRmw=
X-Received: by 2002:a05:6000:240e:b0:429:d391:642d with SMTP id
 ffacd0b85a97d-42adc68a30fmr406960f8f.5.1762457566294; Thu, 06 Nov 2025
 11:32:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106170608.4800-1-puranjay@kernel.org> <07d47ff900decea1efa670a5973e6499b0722d7a33609a21e204a616252eef58@mail.kernel.org>
In-Reply-To: <07d47ff900decea1efa670a5973e6499b0722d7a33609a21e204a616252eef58@mail.kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 6 Nov 2025 11:32:32 -0800
X-Gm-Features: AWmQ_bncB7ywYtzXnFGhaUB_GIu0BPFF3SetxOH7dzmbmiJ6GPQnrZojOZrJ-WI
Message-ID: <CAADnVQLDeKVdBvinbV_AO5rLtJzDeYka74M54kWVtqTdPzpm+w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Use kmalloc_nolock() in range tree
To: bot+bpf-ci@kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@meta.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 9:30=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/kernel/bpf/range_tree.c b/kernel/bpf/range_tree.c
> > index 37b80a23a..99c63d982 100644
> > --- a/kernel/bpf/range_tree.c
> > +++ b/kernel/bpf/range_tree.c
>
> [ ... ]
>
> > @@ -150,9 +149,7 @@ int range_tree_clear(struct range_tree *rt, u32 sta=
rt, u32 len)
> >               range_it_insert(rn, rt);
> >
> >               /* Add a range */
> > -             migrate_disable();
> > -             new_rn =3D bpf_mem_alloc(&bpf_global_ma, sizeof(struct ra=
nge_node));
> > -             migrate_enable();
> > +             new_rn =3D kmalloc_nolock(sizeof(struct range_node), 0, N=
UMA_NO_NODE);
> >               if (!new_rn)
> >                       return -ENOMEM;
>
> Was the change in memcg accounting behavior intentional here?
>
> The old code used bpf_mem_alloc(&bpf_global_ma, ...) which charges
> allocations to the root memcg (bpf_global_ma is initialized at
> late_initcall with get_obj_cgroup_from_current()).
>
> The new code uses kmalloc_nolock() with gfp_flags=3D0, which does not
> include __GFP_ACCOUNT, so these allocations are not charged to any
> memcg.

Glad that AI caught this. We're going to revisit this when
non-sleepable arena allocations land.
At that time we can set_active_memcg() early on in arena_alloc/free
paths and all subsequent page_alloc_nolock() and kmalloc_nolock()
will charge correct memcg, and __GFP_ACCOUNT will return to all of them.

