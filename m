Return-Path: <bpf+bounces-42193-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F119A0B52
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 15:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 861D91C2273E
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 13:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA260208D7D;
	Wed, 16 Oct 2024 13:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CoNe25I8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3C7D520;
	Wed, 16 Oct 2024 13:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729084978; cv=none; b=jRR4tCh9uFc7wsoCeKJKHixua11Hd0j++UG6POwW7ikfoSca91/xnA2/qlFEwhZTWEOjmai0aouqcjq7UDVGLaaC1ymxgKigvj3D3R8aNe/gSAAZqZew8Cz2uGZY4Jhz2vZuwugHkMdCCYzD9hbpuc9amrt6CmJrBQv+bC119os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729084978; c=relaxed/simple;
	bh=2iqHdfaHvyYK2UCyOoTZlkZailHnu8dge6OHyKrWgbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RHXaX8uqBnAGsx4SUC9UCJa5Ghqxe1RrTrS1Qc3447PACCOwjJM1n7RUG5OYLps8g4BzRCdXdJmFYrR6rFBeDF0h+28CflxvzH0PyLKEgiLtH5C4JD9hLJYu6NFYuWz23JBV1AQngx1ageWddqaqHJdNlvjHUz83JQmWFltJxGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CoNe25I8; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a3bb6a020dso16841405ab.2;
        Wed, 16 Oct 2024 06:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729084976; x=1729689776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2iqHdfaHvyYK2UCyOoTZlkZailHnu8dge6OHyKrWgbg=;
        b=CoNe25I8YGszZ2C+j7rBl86pfheZ9RHvCYWQjRnGLev+cbmXBUrOMEzxInfLJHxGMi
         +7BojG+EsaV/nKSrCRIe+y5c9J0mM68ZAgbFUwCuCJ9U8tSL16pErmpZPPfyhKCGjkFA
         ddqoF+cqVIZWZgZuQO6P5naOUtFDKCSDcPxera035bZJGwmngi0IvRoOcYx8V1vPeXiv
         VU27Cr4ADQXqWpS9ff6T4OKw+giQzWvIsEqFWtnEd+q+++7mADDC+FHqU8Mt8HU1XIFe
         CpdnbbX1286vNIznDUCgfpXtKq/YxWFgXQtT1CQWvy6j/Gmq1Pbhmmd4t2OHBbAMybSG
         jMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729084976; x=1729689776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2iqHdfaHvyYK2UCyOoTZlkZailHnu8dge6OHyKrWgbg=;
        b=kvQpFjcAfAOQqpellreeKjsqTLDGwtkWX78oXpsSbeHFIAVqqFPehfKiItTnkJJkMl
         jf/B0XlElCmBQofgcO4npI/8BBDHo3xel06/xHtdxkDhH5V2bb6MMi56wFFcY74tp0B2
         MJUorlcndrSkm8i3nap9oaRCVN2xkI6iHnA54UmxVePauy4WvWLnc2zrGS7f4J1Lkozf
         MHTA9MVZ4AFjAjysBuMKdRvWBvGJV0RjfF7KLzltJ8jU4tvngZaGp7EnaSjjpUVRTqzN
         z0nzbMXlCDYAi2p/1uB/zUNRDhE1wg6yRWKruBGUM5+0+UzJzXPJv1Hnw9Z5Nye3A6nJ
         ebjA==
X-Forwarded-Encrypted: i=1; AJvYcCV2HZrbljFxMVnFew4ORQ6cmtsyXojPDEfyXyYSPERC6irxM9CYnEDfqWRWX0HHodLsPZk=@vger.kernel.org, AJvYcCWfNKMpfh/5jTK3M/tWmfOlFBLzobfj5yx6DOdbFTYmAr0zsyPCWw69/UZmTFWq4VxO75pmNRpC@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa7kn7Dn5FIdb8tU1VBD6UQ+uQNkVRQK94oHnxiuJ/GfQZALOO
	5+cTJvYOt9K/sI5NFj7yJxtH2tLrx1GcXCn3P5pZHmsd7y3qkE6HZbuQDSMdfpFKC4HqUyFEIox
	pVhf29rrF9LrZcax18Hus9Ix5BoY=
X-Google-Smtp-Source: AGHT+IEsW6Nna6+hyQkQ11Xma45K2Kk3Y/k6U61C3GQnmIbn9HToJFmx76Dq2RG2BMGeqnfOqr7FAM7IZTbhlYtuf4g=
X-Received: by 2002:a05:6e02:1a0b:b0:3a3:b4dd:4db with SMTP id
 e9e14a558f8ab-3a3b5c73b7fmr199044565ab.0.1729084975866; Wed, 16 Oct 2024
 06:22:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
 <20241012040651.95616-5-kerneljasonxing@gmail.com> <dbddb085-183e-47bf-8bc7-ec6eac4d877f@linux.dev>
 <CAL+tcoBieZ3_ZX3PRY8k7-C6Rv2g=Mr1U1NAQkQpbHYYvtWpTQ@mail.gmail.com>
 <49a87125-d5bd-4b8d-964e-0d745e9e669b@linux.dev> <CAL+tcoC5QLfpAuJrZxUPbaaK68pGKD31vuohi=NcXghe+uRpZA@mail.gmail.com>
 <670fbbf57b606_3422be294a9@willemb.c.googlers.com.notmuch>
In-Reply-To: <670fbbf57b606_3422be294a9@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 16 Oct 2024 21:22:19 +0800
Message-ID: <CAL+tcoAvOjwpvZKPPaMEWPj8YxU9G_dp_=KeJPnb6xRyq_H63w@mail.gmail.com>
Subject: Re: [PATCH net-next v2 04/12] net-timestamp: add static key to
 control the whole bpf extension
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 9:13=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > On Wed, Oct 16, 2024 at 2:31=E2=80=AFPM Martin KaFai Lau <martin.lau@li=
nux.dev> wrote:
> > >
> > > On 10/15/24 6:04 PM, Jason Xing wrote:
> > > > To be honest, I considered how to disable the static key. Like you
> > > > said, I failed to find a good chance that I can accurately disable =
it.
> > >
> > > It at least needs to be disabled whenever that bpf prog got detached.
> > >
> > > >
> > > >> The bpf prog may be detached also. (IF) it ends up staying with th=
e
> > > >> cgroup/sockops interface, it should depend on the existing static =
key in
> > > >> cgroup_bpf_enabled(CGROUP_SOCK_OPS) instead of adding another one.
> > >
> > > > Are you suggesting that we need to remove the current static key? I=
n
> > > > the previous thread, the reason why Willem came up with this idea i=
s,
> > > > I think, to avoid affect the non-bpf timestamping feature.
> > >
> > > Take a look at cgroup_bpf_enabled(CGROUP_SOCK_OPS). There is a static=
 key. I am
> > > saying to use that existing key. afaict, the newly added bpf_tstamp_c=
ontrol key
> > > is mainly an optimization. Yes, cgroup_bpf_enabled(CGROUP_SOCK_OPS) i=
s less
> > > granular but it has the needed accounting to disable whenever the bpf=
 prog got
> > > detached, so better just reuse the cgroup_bpf_enabled(CGROUP_SOCK_OPS=
).
> >
> > Good suggestion. Good thing is that I don't need to figure out a
> > proper place to disable it any more. I can directly use
> > cgroup_bpf_enabled(CGROUP_SOCK_OPS) to test if the timestamp should be
> > printed with BPF program loaded.
> >
> > BTW, I found that we don't implement how to disable the ip4_min_ttl
> > static key. Sometimes, I'm confused whether we have to disable it at a
> > certain time.
>
> In this case it would be fine to not disable it at all.
>
> The crux is that it is disabled on the vast majority of machines not
> using the feature. If a socket uses the feature, adding the small cost
> of the branches on the rest of the system is fine.
>
> Disabling requires refcounting usage. Sometimes the complexity and
> cost of that outweights the benefit.

Thanks for the explanation. I will take Martin's advice and use the
CGROUP_SOCK_OPS static key. So I don't have to take efforts to
implement the inc/dec/enable/disable the static key

Thanks,
Jason

