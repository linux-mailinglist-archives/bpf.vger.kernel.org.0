Return-Path: <bpf+bounces-20843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93ECE844570
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 18:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FBE81F226AA
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 17:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7870412BF22;
	Wed, 31 Jan 2024 17:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCaVjh8w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919C318E03;
	Wed, 31 Jan 2024 17:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706720408; cv=none; b=V/u06uHc6Ywk38hSunC9N1Qo9pYxJ0dblhe75fs3br669wrkba7jfUXcT6E5kmxVWuwNZx6Qi0knIofylt5hyNdpGBsqrHNFzVSnlExZj7kp/DtgeHjjRGgUjpwZhPGbEMJv6BlUVd9QqgqOOHWn7bdVf/8YCbOkxR8mqhVY8W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706720408; c=relaxed/simple;
	bh=OdyunxAvfGlnpZJYwdm+ah4C6aEDd20TBY6ybstEe2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mA8HPC7/kTaJ/9gP/1frrgfw+iJgWWyOVx9r4BbMmZVXEfta3z3ZcYJa8hHQjYE2xRmkYaoYWFHViO0QXFvoPwem4JgHV3bM7YWWJIBG5ZAGT+1xDJDvxQSnke82spVRWC7Xo3GuECcG1cX5t8vwdOXTP2nePLRv8JiraeiFahE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nCaVjh8w; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5ff7ec8772dso55708047b3.0;
        Wed, 31 Jan 2024 09:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706720405; x=1707325205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5G7qt+YIxTvuZuAFv+trc1OXkufXCm3OexoqbSM/FgU=;
        b=nCaVjh8wAZG8ruxvY0XgB2kX8vOPKisdzxvyPRQ0Lbv9UnLaAdKrlBdTvTgCpI2lxs
         87R2DaDaaY6f4/CLviF4O+QfP+ILfQ+JMFrrRNtc60b2xWPlnkLwu0AAb1Q+ARcBALEu
         edqtDWMWQ0eEsbGx8dtI1OPPIApTlv829Fjt4hfqaa9qmpRNH6EXiqBDXDnZGeMwvFnb
         zlPVDOTFj7gdhy8hAX3t9SNVNez6fE0OPwDwQRASLx1rkxSvX10o/JMPBzTFfz13Tv2J
         FhKS4BO01dFpT/eBJZz1MWF9ZjiQep7V3U+BU/wq6n8WEsaFIPXH+hwlhGX9ZZyhE//k
         aEug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706720405; x=1707325205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5G7qt+YIxTvuZuAFv+trc1OXkufXCm3OexoqbSM/FgU=;
        b=pIVxfHF/TthA7SNDhvfo3mUQR7GxMDMyhnGRjF7Kjr2CPPLRvjpQzZQ+D71L5ZksMy
         cGemi0+jt6iG5eVp+dM5DpCL4Hjh1NIp1xyJ20DEfqPO5+VDQUor7Q55Zx5H8l0OZCK4
         A2gR3EWuTMgZ+QRiiFCWERXbCW4coUxJyLyJ0WXjt1Da4JQMaZBMFmMnHXMm9lJhE9US
         B2XkQR3QmO1JSy58rJpykN5uHnQsQOnNJK+tzKNm5kvSm0P/OTB7DuO3bGLHq9rj71Vs
         UoZjMp8o7bUCc0lgMktSPgb9nnpQpeS9A/lZ4gapQDSmUxomGJDXRSEmR9e9Nrj6/X/8
         f7uA==
X-Gm-Message-State: AOJu0YzZZu2dBWh3u7p/u/c6HTNBYndSWu88ADyYGGsG5ieXeruVigbU
	+ce4b8Pd13fPwvgIYfSN2+80QeWSWdWTSiTBhRk/Bg4phFLBOP5DKDjCs+daYpr7r2dJ2pR8Ppo
	eEv8I70QJIJtq2y+Vtr7S6U4IqLY=
X-Google-Smtp-Source: AGHT+IETgFDcZ9jBf+EcGYiCDE0MToCDyOqonG2V8ksygu27GXffWOfEmI4TV1ttN2XvLLso7fLGzkd6mamG+Ct5crQ=
X-Received: by 2002:a0d:cb41:0:b0:5f9:d912:400e with SMTP id
 n62-20020a0dcb41000000b005f9d912400emr2023908ywd.13.1706720405403; Wed, 31
 Jan 2024 09:00:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1705432850.git.amery.hung@bytedance.com>
 <232881645a5c4c05a35df4ff1f08a19ef9a02662.1705432850.git.amery.hung@bytedance.com>
 <0484f7f7-715f-4084-b42d-6d43ebb5180f@linux.dev> <CAMB2axM1TVw05jZsFe7TsKKRN8jw=YOwu-+rA9bOAkOiCPyFqQ@mail.gmail.com>
 <01fdb720-c0dc-495d-a42d-756aa2bf4455@linux.dev> <CAMB2axOZqwgksukO5d4OiXeEgo2jFrgnzO5PQwABi_WxYFycGg@mail.gmail.com>
 <8c00bd63-2d00-401e-af6d-1b6aebac4701@linux.dev> <845df264-adb3-4e00-bb8e-2a0ac1d331ae@gmail.com>
 <b36c40fb-d274-41ea-abbe-231bebfabdc9@linux.dev> <33e72531-b525-4c9f-a9cc-73175b7cd721@gmail.com>
In-Reply-To: <33e72531-b525-4c9f-a9cc-73175b7cd721@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 31 Jan 2024 08:59:54 -0800
Message-ID: <CAMB2axODTPK9PzHWokXfg0FgSEcXLTq9kKapD7GQVd8WUKRzVA@mail.gmail.com>
Subject: Re: [RFC PATCH v7 1/8] net_sched: Introduce eBPF based Qdisc
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org, yangpeihao@sjtu.edu.cn, 
	toke@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, sdf@google.com, 
	xiyou.wangcong@gmail.com, yepeilin.cs@gmail.com, netdev@vger.kernel.org, 
	Kui-Feng Lee <thinker.li@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 8:49=E2=80=AFAM Kui-Feng Lee <sinquersw@gmail.com> =
wrote:
>
>
>
> On 1/30/24 17:01, Martin KaFai Lau wrote:
> > On 1/30/24 9:49 AM, Kui-Feng Lee wrote:
> >>>> 2. Returning a kptr from a program and treating it as releasing the
> >>>> reference.
> >>>
> >>> e.g. for dequeue:
> >>>
> >>> struct Qdisc_ops {
> >>>      /* ... */
> >>>      struct sk_buff *        (*dequeue)(struct Qdisc *);
> >>> };
> >>>
> >>>
> >>> Right now the verifier should complain on check_reference_leak() if
> >>> the struct_ops bpf prog is returning a referenced kptr.
> >>>
> >>> Unlike an argument, the return type of a function does not have a
> >>> name to tag. It is the first case that a struct_ops bpf_prog returnin=
g a
> >>
> >> We may tag the stub functions instead, right?
> >
> > What is the suggestion on how to tag the return type?
> >
> > I was suggesting it doesn't need to tag and it should by default requir=
e
> > a trusted ptr for the pointer returned by struct_ops. The pointer
> > argument and the return pointer of a struct_ops should be a trusted ptr=
.
>
>
> That make sense to me. Should we also allow operators to return a null
> pointer?
>

.dequeue in Qdisc_ops can return a null pointer when there is no skb
to be dequeued so I think that should be allowed.

> >
> >> Is the purpose here to return a referenced pointer from a struct_ops
> >> operator without verifier complaining?
> >
> > Yes, basically need to teach the verifier the kernel will do the
> > reference release.
> >
> >>
> >>> pointer. One idea is to assume it must be a trusted pointer
> >>> (PTR_TRUSTED) and the verifier should check it is indeed with
> >>> PTR_TRUSTED flag.
> >>>
> >>> May be release_reference_state() can be called to assume the kernel
> >>> will release it as long as the return pointer type is PTR_TRUSTED and
> >>> the type matches the return type of the ops. Take a look at
> >>> check_return_code().
> >

