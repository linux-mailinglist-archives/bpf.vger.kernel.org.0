Return-Path: <bpf+bounces-52840-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B53A48ED1
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 03:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49F803B7347
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 02:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8F813DDB9;
	Fri, 28 Feb 2025 02:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcQXvaYo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C981618C31
	for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 02:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740710653; cv=none; b=qVqrrISFhEeMEKAOB/NboxjcfWFkNnQd57htf/dgTJGf2CB6v/yTZ3uVtJ/ajzpB8gCInRe1Xpyca7qPvGG2MfAO4kSESg2zyZKjOoevG4+dgCjusQlcV6Lj/7hdUEge/7mwEuGbffYnV02tKQ4daTFatAVIJr2HPhDUnh3lvEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740710653; c=relaxed/simple;
	bh=ssRB05EeIH+WKCPBXwX7ouCRCqWAX9tj/TLrvVqZF7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z7ddfk/MsWCR90ru8EOcElCxp7v3aFoDZ3a/xu8kI7ThTjySAAyvLFVlmL2tdsYQ1iF2EhHo4uFANjPySw8xuFt9WMazX9k3aJ7rDuRGGFRAj6NhZdYo528j/+IqzXW6Q++874vfe2bdl8AGeShzhA349Pdvl4Y/9z+v8sAMeTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcQXvaYo; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso10938215e9.0
        for <bpf@vger.kernel.org>; Thu, 27 Feb 2025 18:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740710650; x=1741315450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c4g5bD1iwtCcAcdxwzgr3cvfpwNY6CIPmCrs8gYxoZc=;
        b=LcQXvaYoei+Q3Rj83pDFHC9AxAtkgSqwBKOXabBClNeCfqGqo6XzrK78n8pUBVQJIC
         4T5jjKdAfmXnJH8qo33U7j1Ut28q+aaG8x+77T73RHB4+iE4SYZ9zx7Nsb3aEwX76ibi
         mKEUvs2I3mhqP7x96pmd+Nry0P7Qf6qMlnFmhXNBH9ud2njKpJEb93Vkv+vpJmHdzY6P
         h1DUZt61H97ePVwNa8R6Y7/GwpvW0v4f0lHpPnx11ZnG58SNs8i/16Ip8L0+9pK2D+AB
         Ppe2dm66LhrRQugyC/nCWANjFVTppIYZiJAwEEj7EqG18+ozlcvAWP8yDwqKyNfOoW/Y
         SWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740710650; x=1741315450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c4g5bD1iwtCcAcdxwzgr3cvfpwNY6CIPmCrs8gYxoZc=;
        b=aRTXArJiUtOxnQSW96WvcZKuJMwmKHugOkdJKWFiWMML2kQAPficGwhwc+17tTNa3k
         AghrHJKNu1edBbcGOhETmKUicC9oSWOWETPMLyntVWSnHaxGyJumQrTeHkiIFOl9g7N/
         +myjF6x5M4mX9Lrg4zuddy/Q1ExJfGKSRX5fZ+Ez97I/Ig8BvIWgF+eNvsP/eq/4JrWY
         u0mHPOHQdV3VVa71lFZqGzuVUW6mIiPOA9oqvjKmJCPRfKWYFyNfaDP3iK4vgqqufuXN
         yKGqqgJnigsIYTC6CleLz33mSPiZgjJx6pzLcwJcdtvVJ7MObQx84GHGXq1mW7H+UVj/
         AI1Q==
X-Gm-Message-State: AOJu0YxJiRU/ZZS2iq1Xj92YRvhWqUS0lnnVbzUUYcNkqg5n+qOjIOyB
	NLaELwxa129ZUs0JIUlOf72PIykckgiav9+IdJTXJJeMyNyKGpOzi8AMfs05vbEoJDNPB8WufGF
	z7023SjiNDclO+Pzcc4pDrENK27Y=
X-Gm-Gg: ASbGncsi2IVB7CgIvsyPfa35ipG7bgEscaJpgu31bkUbSCmW5SN9/q6cC1wweoQc4AZ
	zia43Nz8jNJSmcRssXQSOCyO8JOO5X9kocI0PZ8GPgmCZnAxWmCPw53uLd57rQW0p24bnqrYXWR
	vvYm9ErlAaJns+vFPeULN1E0+tXHUBe4Wc8cvU8xw=
X-Google-Smtp-Source: AGHT+IFD8bfhdX/iiqYqUwIsSAOuZQhGQwXzlkxKaCo5nPkatQnyh0KU1hbPtoi1jPy61Sqrtb3lIoux4WiwNhfUXrw=
X-Received: by 2002:a05:6000:188c:b0:38f:3224:65ff with SMTP id
 ffacd0b85a97d-390ec7c6a8emr938993f8f.5.1740710650079; Thu, 27 Feb 2025
 18:44:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250125111109.732718-1-houtao@huaweicloud.com>
 <20250125111109.732718-7-houtao@huaweicloud.com> <CAADnVQL+866m69rv+PC_V1y1-PjL4=w3obTwqLPgW3=kA_BjEg@mail.gmail.com>
 <6223b1f5-b491-fcec-b50c-222f1075f952@huaweicloud.com> <CAADnVQ+G9YQyj8-Q7UFT9y26tD1Rud_AgRu-D-s1LruYE03NZQ@mail.gmail.com>
 <01e5b3ca-86d3-46a9-742a-3b69f378d141@huaweicloud.com> <012917a0-e707-0527-f1f2-bb3f38464c7e@huaweicloud.com>
 <CAADnVQ+ng5wPns+tbFAumWLoZzNnho8pRVaorKGBA=6h9NsYhw@mail.gmail.com>
 <CAADnVQ+o=2XQ2Wo-Roe35ahq=zgHjC19ptsbRJa1DVir5umqxw@mail.gmail.com> <dac0c127-1876-b936-5d59-bfd29e11c687@huaweicloud.com>
In-Reply-To: <dac0c127-1876-b936-5d59-bfd29e11c687@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 27 Feb 2025 18:43:59 -0800
X-Gm-Features: AQ5f1JrAEAi9Psq7phjsof3yuIKGV5K9id5iO2M08pAlUFBoduJJCqSjRuW6EM4
Message-ID: <CAADnVQJB=jCwYcaXXAPOibNgKdSqtGDtVNPQQ_rwWB5W2064Dg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 06/20] bpf: Set BPF_INT_F_DYNPTR_IN_KEY conditionally
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Hou Tao <houtao1@huawei.com>, Xu Kuohai <xukuohai@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 5:16=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> Hi,
>
> On 2/28/2025 5:10 AM, Alexei Starovoitov wrote:
> > On Fri, Feb 14, 2025 at 9:30=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> >> On Thu, Feb 13, 2025 at 11:25=E2=80=AFPM Hou Tao <houtao@huaweicloud.c=
om> wrote:
> >>> Hi,
> >>>
>
> SNIP
> >>>
> >>> 3) ->map_check_btf()
> >>>
> >>> In ->map_check_btf() callback, check whether the created map is
> >>> mismatched with the dynptr key. If it is, let map_create() destroys t=
he map.
> >> map_check_btf() itself can have the code to filter out unsupported map=
s
> >> like it does already:
> >>                         case BPF_WORKQUEUE:
> >>                                 if (map->map_type !=3D BPF_MAP_TYPE_HA=
SH &&
> >>                                     map->map_type !=3D BPF_MAP_TYPE_LR=
U_HASH &&
> >>                                     map->map_type !=3D BPF_MAP_TYPE_AR=
RAY) {
> >>                                         ret =3D -EOPNOTSUPP;
> >>
> >> I don't mind moving map_check_btf() before ->map_alloc_check()
> >> since it doesn't really need 'map' pointer.
> >> I objected to partial move where btf_get_by_fd() is done early
> >> while the rest after map allocation.
> >> Either all map types do map_check_btf() before alloc or
> >> all map types do it after.
> >>
> >> If we move map_check_btf() before alloc
> >> then the final map->ops->map_check_btf() should probably
> >> stay after alloc.
> >> Otherwise this is too much churn.
> >>
> >> So I think it's better to try to keep the whole map_check_btf() after
> >> as it is right now.
> >> I don't see yet why dynptr-in-key has to have it before.
> >> So far map_extra limitation was the only special condition,
> >> but even if we have to keep (which I doubt) it can be done in
> >> map->ops->map_check_btf().
> > Any update on this ?
> > Two weeks have passed.
> > iirc above was the only thing left to resolve.
> Er, I started adding bpffs seq-file and batched operation support
> recently.  I need to ask whether it is OK to complete these todo items
> shown below in the following patch-set. As noted in the cover letter,
> the following things have not been supported yet:
>
> 1) batched map operation through bpf syscall
> 2) the memory accounting for dynptr (aka .htab_map_mem_usage)
> 3) btf print for the dynptr in map key
> 4) bpftool support
> 5) the iteration of elements through bpf program

All these things would be nice to add, but the patch set
needs to stay review-able.
It's 20 patches already which is too high.
v1 was done many months ago and not only complexity of the feature
makes it slow to land, but the size of the set too.
Keep it small. Incremental work is preferred.
Better to land the core feature first and then gradually
add 5,2,3,4.
Batched ops aka 1 can be delayed for some time.

