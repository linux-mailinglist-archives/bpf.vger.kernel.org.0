Return-Path: <bpf+bounces-42191-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1B79A0B1B
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 15:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F20AA1C2287A
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 13:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1187220968C;
	Wed, 16 Oct 2024 13:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJz/rz7p"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0C812E75;
	Wed, 16 Oct 2024 13:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729084409; cv=none; b=aRz+9hqWTgO0xt2DbyBSGmQCBy8Oz4kR9ZWfR4hvQ8imWc7kUFaPKuOYZQS1+ARE5nd0teKNL9ESTXQj0kiLBsQLcTDRQW0Fr+rkuddWBw2ugvaSseWNS4u9975g/4/wDyHq/IXI9zFVoNmP/PO4sez3wSN8R7gBrELmIS5Tc4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729084409; c=relaxed/simple;
	bh=VnDt1UOnhj8zNfRK9i/Oehu6fV0+ILXu0M8qbbDrq5Y=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Te5jdEVBUaOKWPH2mrS6+Q75xGXTVP2RZ4//npM//agHISuntkfuHbVa7YiqYC+jSpm7U3gOT89zF388eVhnyyb8EpkaSKMW6LxrsM/b8ssHZppcB+anWvNbU6EIhfYp8mOkMgC0aRG5UywngJZ+mzgwLU8s4/h2CBf9sbAl2n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJz/rz7p; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4607d5932aaso7277221cf.1;
        Wed, 16 Oct 2024 06:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729084407; x=1729689207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VnDt1UOnhj8zNfRK9i/Oehu6fV0+ILXu0M8qbbDrq5Y=;
        b=eJz/rz7pkMInjCCqROS2TIFn6IEMTdxMABKiWiKFuvwY9SaVKAzfOcYLqTZWgoGoU1
         AXAYdcrGeeslexA7yrbS7hSJ3n9sau3nmWg0UtA71XLhxRIk7a6iIBgWU+5XP3hpjQ5f
         2Vsruv5+e07zFwohemhZFNfIfMZjRvB+oS8D43Lc1MWJ2JCCvJNk32WD0Xb3hJ7zGcol
         ed1Z57JMleQviwEB/bzQXCRndlWOTht1GClOTEYDr7wsY6jTE/qME2JOFArh/gnl37/A
         R+pyozsIaaRZgLuYQgSGFq483FWtjfhbUTOf2c7ArqZH+dYmkFwUJvRxQG9w9qqmu/Ly
         YgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729084407; x=1729689207;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VnDt1UOnhj8zNfRK9i/Oehu6fV0+ILXu0M8qbbDrq5Y=;
        b=v8jd5CJSvm9YGffVQ2SAK7w2BteJnl77Mzivil3lCYuaLv/FspuxM2XElyrJcQDl4F
         0WjlpGjJa1z9vhkiyPQwpLdBwc5bIoV6XjEpa3OfkVMic8KaP9bCwHDn33zjDz2LsmVi
         QSr+cdaaTORuPAvmkmlF9mQalNulkwALR704mzgsj/04dBC3jnWyMeeFn0OHDvHQ4eMx
         zOIPsb2AzEJzIJQKprLitLi3Scvz3HB7FriR169HiMztRhv4zDa1EqxB3jnYPwtMtTwY
         vSutaqjd4+3Nor6w3Oqd9vHGGagTt+1CdikEzdZ3FtQhgC8R0vT2PJGYHaH2BybwB2fq
         seXg==
X-Forwarded-Encrypted: i=1; AJvYcCUCTw3AiRmXPuLXFHkqG2Wt/sqbo/j0kqeCorFb2Vc1uDTzadvoZIXKj9oLnFPHKSLIP+E=@vger.kernel.org, AJvYcCX3GTa4TpMLhvtiKt8bK8xlLPXHq95/6O+CoIvL6aJO3G3sNShb6Bombvi0YcxZxYQIywKFKAu+@vger.kernel.org
X-Gm-Message-State: AOJu0YyKP2FLHzmNlK+E0dpSjmjHEn1Zueb2+JVzMYOqlMrzlloDl2+c
	hQHkI7IR3xycWRGz8ziJpA+3PB9CR1ChnDsVHT7TahSkJOkGFy9J
X-Google-Smtp-Source: AGHT+IGaaxwDRU1FGDsd8SG40DOmhY4b0wTE+rvTGrN27iCrHN/IlTzgNhENAFKAocTTafi0Zy5GlA==
X-Received: by 2002:a05:622a:4d92:b0:45d:7eba:af80 with SMTP id d75a77b69052e-4604b32099fmr298188201cf.25.1729084406841;
        Wed, 16 Oct 2024 06:13:26 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460850c82acsm14375281cf.61.2024.10.16.06.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 06:13:25 -0700 (PDT)
Date: Wed, 16 Oct 2024 09:13:25 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 willemb@google.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <670fbbf57b606_3422be294a9@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoC5QLfpAuJrZxUPbaaK68pGKD31vuohi=NcXghe+uRpZA@mail.gmail.com>
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
 <20241012040651.95616-5-kerneljasonxing@gmail.com>
 <dbddb085-183e-47bf-8bc7-ec6eac4d877f@linux.dev>
 <CAL+tcoBieZ3_ZX3PRY8k7-C6Rv2g=Mr1U1NAQkQpbHYYvtWpTQ@mail.gmail.com>
 <49a87125-d5bd-4b8d-964e-0d745e9e669b@linux.dev>
 <CAL+tcoC5QLfpAuJrZxUPbaaK68pGKD31vuohi=NcXghe+uRpZA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 04/12] net-timestamp: add static key to
 control the whole bpf extension
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Xing wrote:
> On Wed, Oct 16, 2024 at 2:31=E2=80=AFPM Martin KaFai Lau <martin.lau@li=
nux.dev> wrote:
> >
> > On 10/15/24 6:04 PM, Jason Xing wrote:
> > > To be honest, I considered how to disable the static key. Like you
> > > said, I failed to find a good chance that I can accurately disable =
it.
> >
> > It at least needs to be disabled whenever that bpf prog got detached.=

> >
> > >
> > >> The bpf prog may be detached also. (IF) it ends up staying with th=
e
> > >> cgroup/sockops interface, it should depend on the existing static =
key in
> > >> cgroup_bpf_enabled(CGROUP_SOCK_OPS) instead of adding another one.=

> >
> > > Are you suggesting that we need to remove the current static key? I=
n
> > > the previous thread, the reason why Willem came up with this idea i=
s,
> > > I think, to avoid affect the non-bpf timestamping feature.
> >
> > Take a look at cgroup_bpf_enabled(CGROUP_SOCK_OPS). There is a static=
 key. I am
> > saying to use that existing key. afaict, the newly added bpf_tstamp_c=
ontrol key
> > is mainly an optimization. Yes, cgroup_bpf_enabled(CGROUP_SOCK_OPS) i=
s less
> > granular but it has the needed accounting to disable whenever the bpf=
 prog got
> > detached, so better just reuse the cgroup_bpf_enabled(CGROUP_SOCK_OPS=
).
> =

> Good suggestion. Good thing is that I don't need to figure out a
> proper place to disable it any more. I can directly use
> cgroup_bpf_enabled(CGROUP_SOCK_OPS) to test if the timestamp should be
> printed with BPF program loaded.
> =

> BTW, I found that we don't implement how to disable the ip4_min_ttl
> static key. Sometimes, I'm confused whether we have to disable it at a
> certain time.

In this case it would be fine to not disable it at all.

The crux is that it is disabled on the vast majority of machines not
using the feature. If a socket uses the feature, adding the small cost
of the branches on the rest of the system is fine.

Disabling requires refcounting usage. Sometimes the complexity and
cost of that outweights the benefit.

