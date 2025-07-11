Return-Path: <bpf+bounces-63081-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A15B0240B
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 20:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F6C65C8090
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 18:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929352F3654;
	Fri, 11 Jul 2025 18:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fd+ZWmmJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988EB2EF67E
	for <bpf@vger.kernel.org>; Fri, 11 Jul 2025 18:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752259320; cv=none; b=imIpKVQEAgBAA6SSUCDwGxqQF4lKgk3nrfovY5pLd77E873yD9P5nfJwjU0qOMvV+fJfj7c4GLAd+aiQlwyez2L6nYIq+rUTkLvj+t8qy1UZB3Q168et5/E4zbBolp1ePjwI/tFmgqMbqFXakkaiknE2cjx2gkmQirkYEr1nItE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752259320; c=relaxed/simple;
	bh=6xtWW+ZCEaRT8XtBd7t0CA0yrmnEBHq8CRJa1twJsZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LfBNqLznku5lqxj3OdKaDVP70qN9qfKLDYWC2+EGC3krf9q077uQN8MGOi2k6fEhgoEqOaPmDwoBjERsp+kb3ngWUyjFgdLY0+F7utVqinkQ2pWyc2PCZh2FyzS+7yzW7tfQ++3VGWieDQNgjTSxrRoQkJ8OEZCq4o1j+qUbiiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fd+ZWmmJ; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b3226307787so2059504a12.1
        for <bpf@vger.kernel.org>; Fri, 11 Jul 2025 11:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752259318; x=1752864118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Y/yNvQt1KbLLrsl6IC7Xmwm5Dp+uY7kxB+z/5jnBuI=;
        b=fd+ZWmmJKPT1kqLm8iu6UZTkSYEuZUvzL1x9xPkn11e/ZKbue6rRQaLPNn116aR4ip
         Qz2uT817oaaqpJmd82S+2Prbts4K7GWNTo5jo7SYTOV40dv3ySZxrv2HuGz3Ecj8j1pO
         Q+m0KiWcsm55HI7XjURNBmtQGZcHmO3g44a54FjEiXXZK4Y/23nT4plnWX3j15ria1Zq
         ARO8ebkpMKO/SjV+YSltgOCFn4uHtklzrjaOLxaLuvlWp2MMxDuK8dbG1gWUSS9wrIAD
         1dp2n8YN6CrXNz2+uLBZKIB+/B7lE1OheMfDk4hqgS8Q7EVevfLX7bG2JL3DZPqv/5R8
         CFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752259318; x=1752864118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Y/yNvQt1KbLLrsl6IC7Xmwm5Dp+uY7kxB+z/5jnBuI=;
        b=ZGWoDJbrOb36Kdg6EodusjuS8XkLPaEigYO6wvNhftuKmfNEDbmFE8Mo9RSOu1Ysgh
         8ytH3iRpXgDM9LKaDh4TstCtMLnKZdeZXO/eGbYJwIsSD8xuVgo+0eiRxoSPJCi2IXn7
         /cfQWMcnB30jrscvIk5L0Tugcomrf482ZBjMhcaUuHIvQnzgkJ5SI5xWSS5CmATyPm/d
         nRHxmaV2B5UXNa1E8WsM/x/HATCS9OoLkPdxgBzGYqL6iE1j/4EvZraxILrHV8eFtdtF
         oujekm+e9o/dpvJOn2tVUL18D67Axfa4q6fDKHYcEt+8zEjAPohTxfRx0K6J+HVplCvy
         JWyw==
X-Forwarded-Encrypted: i=1; AJvYcCUgNUvL6hP6tDu4JB0e+ww9jm85M9zS8Sopdkf6I8aQUgRwGdY5mmFGwYpzEFQSdWTxN8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVr8jtPnRFAsTxurMO5q8nO2irQeVG0wM8ZUKPMbajjBpcI9Qj
	GI42R/erz9jysPivDJm7runcHBIejefNg6quwJCIUBaQg+wQ3RVmBCahZQ0MssI8LD+91ILRMCl
	y18CLwc0UaPL980ZoC3Jxle8Vf2YpNu8=
X-Gm-Gg: ASbGncvhijtYQ8P247BAUaUpXDMzO95UIXW4K7cJnv2bn8p/QwEV6Osyuksk/8et0Ik
	/DbhSRnpXbQE8wBy+LWIW1bQIjUqAEV8pEZ8Lg4xTpFVBqm4NiiZg+I3nplf9zQSV2zwp5bxk3k
	xEanaXT9QijE0nywVGF+TrMUYrJA9ARIsVlABx5zcCn9xpBCCbmFS9joZJuxxNvRqvP6S6DUahm
	ri79x+Rq6Z+vvSOm1HwKuo=
X-Google-Smtp-Source: AGHT+IHHZ27UuQAfAKBrb/F+H8aBhzvtlIyaPt7vC+lkZBH7cYJYHvR7zCb3wbhDKyKngUezrrZUtY3g+W7J2gFueqs=
X-Received: by 2002:a17:90b:4b84:b0:312:f0d0:bb0 with SMTP id
 98e67ed59e1d1-31c4f4b8228mr5428358a91.12.1752259317631; Fri, 11 Jul 2025
 11:41:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708230825.4159486-1-ameryhung@gmail.com> <20250708230825.4159486-3-ameryhung@gmail.com>
 <68f4b77c-3265-489e-9190-0333ed54b697@linux.dev> <CAMB2axO3Ma7jYa00fbSzB8ZFZyekS13BNJ87rsTfbfcSZhpc6w@mail.gmail.com>
 <2d1b45f3-3bde-415d-8568-eb4c2a7dd219@linux.dev> <CAMB2axMDUr+s+f9K-4sj-5vSkPQV4RXHo8y73VH9V2JQbKZOxQ@mail.gmail.com>
In-Reply-To: <CAMB2axMDUr+s+f9K-4sj-5vSkPQV4RXHo8y73VH9V2JQbKZOxQ@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 11 Jul 2025 11:41:41 -0700
X-Gm-Features: Ac12FXxWoVD4kz1z9k-EepTOHA70zAvQ3s9ba9AM1ksbZKLskqTzd_AE_0XePGs
Message-ID: <CAEf4BzaUK0i7QFkKi800TQhAKw2WL+FyoG3eFP6nq_r-TUPBKw@mail.gmail.com>
Subject: Re: [RFC bpf-next v1 2/4] bpf: Support cookie for linked-based
 struct_ops attachment
To: Amery Hung <ameryhung@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 2:00=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> On Thu, Jul 10, 2025 at 12:47=E2=80=AFPM Martin KaFai Lau <martin.lau@lin=
ux.dev> wrote:
> >
> > On 7/10/25 11:39 AM, Amery Hung wrote:
> > >> On 7/8/25 4:08 PM, Amery Hung wrote:
> > >>> @@ -906,6 +904,10 @@ static long bpf_struct_ops_map_update_elem(str=
uct bpf_map *map, void *key,
> > >>>                goto unlock;
> > >>>        }
> > >>>
> > >>> +     err =3D bpf_struct_ops_prepare_attach(st_map, 0);
> > >> A follow-up on the "using the map->id as the cookie" comment in the =
cover
> > >> letter. I meant to use the map->id here instead of 0. If the cookie =
is intended
> > >> to identify a particular struct_ops instance (i.e., the struct_ops m=
ap), then
> > >> map->id should be a good fit, and it is automatically generated by t=
he kernel
> > >> during the map creation. As a result, I suspect that most of the cha=
nges in
> > >> patch 1 and patch 2 will not be needed.
> > >>
> > > Do you mean keep using cookie as the mechanism to associate programs,
> > > but for struct_ops the cookie will be map->id (i.e.,
> > > bpf_get_attah_cookie() in struct_ops will return map->id)?
> >
> > I meant to use the map->id as the bpf_cookie stored in the bpf_tramp_ru=
n_ctx.
> > Then there is no need for user space to generate a unique cookie during
> > link_create. The kernel has already generated a unique ID in the map->i=
d. The
> > map->id is available during the bpf_struct_ops_map_update_elem(). Then =
there is
> > also no need to distinguish between SEC(".struct_ops") vs
> > SEC(".struct_ops.link"). Most of the patch 1 and patch 2 will not be ne=
eded.
> >
> > A minor detail: note that the same struct ops program can be used in di=
fferent
> > trampolines. Thus, to be specific, the bpf cookie is stored in the tram=
poline.
> >
> > If the question is about bpf global variable vs bpf cookie, yeah, I thi=
nk using
> > a bpf global variable should also work. The global variable can be init=
ialized
> > before libbpf's bpf_map__attach_struct_ops(). At that time, the map->id=
 should
> > be known already. I don't have a strong opinion on reusing the bpf cook=
ie in the
> > struct ops trampoline. No one is using it now, so it is available to be=
 used.
> > Exposing BPF_FUNC_get_attach_cookie for struct ops programs is pretty c=
heap
> > also. Using bpf cookie to allow the struct ops program to tell which st=
ruct_ops
> > map is calling it seems to fit well also after sleeping on it a bit. bp=
f global
> > variable will also break if a bpf_prog.o has more than one SEC(".struct=
_ops").
> >
>
> While both of them work, using cookie instead of global variable is
> one less thing for the user to take care of (i.e., slightly better
> usability).
>
> With the approach you suggested, to not mix the existing semantics of
> bpf cookie, I think a new struct_ops kfuncs is needed to retrieve the

yes, if absolutely necessary, sure, let's reuse the spot that is
reserved for cookie inside the trampoline, but let's not expose this
as real BPF cookie (i.e., let's not allow bpf_get_attach_cookie()
helper for struct_ops), because BPF cookie is meant to be fully user
controllable and used for whatever they deem necessary. Not
necessarily to just identify the struct_ops map. So it will be a huge
violation to just pre-define what BPF cookie value is for struct_ops.

> map->id stored in bpf_tramp_run_ctx::bpf_cookie. Maybe
> bpf_struct_ops_get_map_id()?
>
> Another approach is to complete the plumbing of this patchset by
> moving trampoline and ksyms from map to link. Right now it is broken
> when creating multiple links from the same map as can be seen in the
> CI. I think this is better as we don't create another unique thing for
> struct_ops.
>
> WDYT?

I think that is a logical thing to do, because BPF link represents
attachment, and trampoline should conceptually correspond to an
attachment, not to the thing that is being attached (and might be
attached to multiple places, potentially). We have this approach with
the fentry/fexit program's trampoline, so it would be nice to move
struct_ops to the same model.

>
> > For tracing program, the bpf cookie seems to be an existing mechanism t=
hat can
> > have any value (?). Thus, user space is free to store the map->id in it=
 also. It
> > can also choose to store the map->id in a bpf global variable if it has=
 other
> > uses for the bpf cookie. I think both should work similarly.
>

