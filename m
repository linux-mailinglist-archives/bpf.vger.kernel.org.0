Return-Path: <bpf+bounces-34968-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A829193448D
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 00:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 533881F21AD0
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 22:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2F83D552;
	Wed, 17 Jul 2024 22:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DryeXZdu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0E54D8AF;
	Wed, 17 Jul 2024 22:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721253888; cv=none; b=i9MdThDJwn33FfmSB5daXe+hslmU13oFDKFFQUPdjmWtmIXT5dKeLwl02Wfy+wPp/heFnDFxeevvRY60qLC/MI7ZXn353f11/p0i3xlfEgIi46fSkLC7YNb0e/eeMgg63GToKGo6bXDE0BUZBguhqERdZ+x/ibuKOMhsPr2re98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721253888; c=relaxed/simple;
	bh=j+4hWmewnH7hGdnNXnkTDCzUqai2SHYQ5ldqvkbVLc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TOAJpXFI1HbcKvXvETBXNdEdpHNBnMa0iT/ZCera/CrJaCD0PkG0yPhi5WCpN7SVGykhhZqJ5ff6qgXQqUVOagFO3KsLhhkhS1HbaMLnEn0YKIHzurcEAxHSIbzCYgwyP9wvpS8ZMdAq3JYC+gt9rDM938lcD8PbypNjX7qcOQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DryeXZdu; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e05d48cf642so180026276.2;
        Wed, 17 Jul 2024 15:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721253886; x=1721858686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j+4hWmewnH7hGdnNXnkTDCzUqai2SHYQ5ldqvkbVLc4=;
        b=DryeXZduIKZi/u0/wl7PfZHNwxdz1W5NfeT7ZswLSEhSgLBLAOwG0SgOR2+170oS+f
         80BSgE2BcTsryBWuE7hCGD3O/FHrZ8hW64ZvQV7pkr/Cv4fWijcllT2CkX61OkyywVoE
         29Y/9Nld7wA9eiXf5oqA+/YM0X9B6r0Leo/lT2B0Qto75GmA0rm0gg8iEJiyLLf12kAw
         xWWW3XmQGU2TqXKnvihPLvMdUBq0emLD7h/ADoXpcohWU+qFAniH8T3krhONsrtCaEQg
         D0Xadg91/y7QSn2EeHvyRS1/dHRZSdfGQlGgh+AzLOZOZzTq/RiX1ShQzKnQ/G+BTFLh
         9OJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721253886; x=1721858686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j+4hWmewnH7hGdnNXnkTDCzUqai2SHYQ5ldqvkbVLc4=;
        b=d0gQL5+gYONCEb7uaU+Ox9tmGxJ0mZNELIbZtefnjWTyF2rQ7kSRi2QtTt9s1odsBP
         Y4p+dnlgrr9x7ve+SBUK3HeIR0gyK9vNwlSimMEbsWF3aAJjSwvEaW1sxhF/MU0rqRtB
         VMa0JK4Vqh8A8xScrCbAL9CKyM6Krwxfu5PVM8TnJ0oOm8HgIRHEXl+wQEjQbblUD7mT
         GLB8U8bRaSmWasmZCwjGOQNe0bamuHznwE9OiotPHrEtWB84bdScuvNN20jHLxqfEaRp
         UNOR9GTc/fO7A8MHPrDteq6USwi2S8CyWxxNiVVOhRhZ3eaPG5bkDxwK339OH8NLpfB5
         YlDg==
X-Forwarded-Encrypted: i=1; AJvYcCV40QBC6o+VKwxdhfmgCCVLnapG2A6lPcZlVBWwmonIVR6IKb18BxyyMRYxj9XG9i7ZcOxftEv6qFFF3zZ4qj2oBgwP
X-Gm-Message-State: AOJu0Yx+vyi09Gz+Aq0grmFWEUg6RO3O2NRtTGH6PAoC4n7oQ6bHixb9
	RTiWADqvTZfcHymU2TVj8JeA/fXsDOv0en0pbcjd0V4QS/seWYxnZxL3Z4daEzRel5981X9II0W
	tE5NHTvV0XOPrbnU9BNeh15hZGFE=
X-Google-Smtp-Source: AGHT+IGQRwmNx5NqP+1e+umgCisxCGZr/EFMSS0JwkN7tjvl68jCCLyZW1k67gBT6wO7SIA45BNRMhs2aC1cM3tuJT8=
X-Received: by 2002:a05:6902:f8a:b0:dff:3055:3c26 with SMTP id
 3f1490d57ef6-e05ed7e7d62mr3137048276.40.1721253886523; Wed, 17 Jul 2024
 15:04:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240714175130.4051012-1-amery.hung@bytedance.com> <m2bk2wz5pi.fsf@gmail.com>
In-Reply-To: <m2bk2wz5pi.fsf@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 17 Jul 2024 15:04:35 -0700
Message-ID: <CAMB2axOguJd=2b3wjnvahE=OxZcU-6Th3kkmuJb=_coT=GjiBg@mail.gmail.com>
Subject: Re: [RFC PATCH v9 00/11] bpf qdisc
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, yangpeihao@sjtu.edu.cn, 
	daniel@iogearbox.net, andrii@kernel.org, alexei.starovoitov@gmail.com, 
	martin.lau@kernel.org, sinquersw@gmail.com, toke@redhat.com, jhs@mojatatu.com, 
	jiri@resnulli.us, sdf@google.com, xiyou.wangcong@gmail.com, 
	yepeilin.cs@gmail.com, Dave Marchevsky <davemarchevsky@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 3:13=E2=80=AFAM Donald Hunter <donald.hunter@gmail.=
com> wrote:
>
> Amery Hung <ameryhung@gmail.com> writes:
>
> > Hi all,
> >
> > This patchset aims to support implementing qdisc using bpf struct_ops.
> > This version takes a step back and only implements the minimum support
> > for bpf qdisc. 1) support of adding skb to bpf_list and bpf_rbtree
> > directly and 2) classful qdisc are deferred to future patchsets.
>
> How do you build with this patchset?
>
> I had to build with the following to get the selftests to build:
>
> CONFIG_NET_SCH_NETEM=3Dy
> CONFIG_NET_FOU=3Dy
>

There are config issues in my code. bpf qdisc depends on
CONFIG_NET_SCHED. Therefore, I will create a config entry,
CONFIG_NET_SCH_BPF, for bpf qdisc and make it under CONFIG_NET_SCHED
in Kconfig. The selftests will then require CONFIG_NET_SCH_BPF to
build.

I will send the fixed patches in reply to the problematic patches.
Sorry for the inconvenience.

> > * Miscellaneous notes *
> >
> > The bpf qdiscs in selftest requires support of exchanging kptr into
> > allocated objects (local kptr), which Dave Marchevsky developed and
> > kindly sent me as off-list patchset.
>
> It's impossible to try out this patchset without the kptr patches. Can
> you include those patches here?

Will do.

