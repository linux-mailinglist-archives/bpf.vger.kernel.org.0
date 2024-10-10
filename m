Return-Path: <bpf+bounces-41549-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9966099816C
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 11:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C96961C260B2
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 09:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B09C1C7B98;
	Thu, 10 Oct 2024 09:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gw1Hu8To"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A7E1C6F7D
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 08:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728550799; cv=none; b=rF3zubRmwyZDGtb/FIRMOAHKVy/Iwg5IzI5ae5rhBGBVLZTbLKSJoOP1zCB89djMK1Dag7WQB6k0qyPSA81zSBhJTVP3JMz+OXref7M+qzkHLnif+MuC+dEfe47T1g61hU9YwtC2Ju+afpWJeQYDkyw8yYflhpArCu/xPpHbOhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728550799; c=relaxed/simple;
	bh=+G/YrbCxPH0eM1bgt8wmdfNzeFFqY49wGey7ifv6a+I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EWYrjXhH/MkpPd+ezzREHW76dpoIJsXIYZS+10LXGgG9m82mxYHLc6n+Ujt1bS3r+p3Wj6bkKrHM0pz9CkO/PFwpF6/fjiEjN1kRPiGHICPCdOFvRHUps7hMuojdReo7whQd/TBomEFRxksDfWPCT4blNIdyvYjMesurQ2X8YIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gw1Hu8To; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728550797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+G/YrbCxPH0eM1bgt8wmdfNzeFFqY49wGey7ifv6a+I=;
	b=Gw1Hu8To6aPhd6ny+G6InnBjsGajWGw2O6j5uzHiMg5rNe0SuEtf1fXU6NPIp6Z9YNCM0F
	OatI0nwqO1YdMITPWDZuJkSS4t4CmBTkAt7NDMDPVqldhxfayspyGIEte/tiXlH2pkWOrK
	k+p503Y3PeAvTwt/agNnp4Bg0xGxW5M=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-zrrxHj1pPfOWbP-UzSQjcQ-1; Thu, 10 Oct 2024 04:59:52 -0400
X-MC-Unique: zrrxHj1pPfOWbP-UzSQjcQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a93d0b27d37so65968666b.0
        for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 01:59:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728550791; x=1729155591;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+G/YrbCxPH0eM1bgt8wmdfNzeFFqY49wGey7ifv6a+I=;
        b=SHHhSBAI0AnDP0x7wmKSiu8K/igvtEyt97x4yNb6Phy9UhwEWOl342iOgdwj/lxtSF
         6m3msXcm6TniNNRGlV50kZc3wyT9vvYCMe/YMvmyBWA/dJeRSAQqivVpewlZRIu9sN3a
         nr46zXeYvsVGyE+vwLDi+WxottTg5jcGMSYgpQBrLh1aXRHn5eWxrMntZcWfEHYWdzEo
         F2Z4vsTLtpTJIO4A06PKWq2Efbi0qDaYam54x5KYFPOIp496eGuS99gh+XwHH3l21XQU
         G+1QBneh8qZ9uQzn7r5VWfIPQnVpBYXtw+cVdAG74snBBRToLSfd40NvYUJdCL2f+ysW
         TzVw==
X-Forwarded-Encrypted: i=1; AJvYcCWmdSWjuzcYQ1fzJbeIsRXlu13a+MQePG51g8ppCMMR7feDhSvQ+63d3lxrduTdPxHwxLI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycz9dTb9qb/jM+04+RA7qRIka68Yn/hVQb6SEgRqnMFeEZDAFv
	6UOC/VfyMC7ahL3bE3v0JIZpFDi2jryr8tTqsdy4tl8RWs8kt9cw6i0LIbetgVneL4qkqLpm6zU
	NFSNCOhVVsZ5kfXZrNKa1wL69//SL5v3x6cs6OXIJxpLaLPYDyA==
X-Received: by 2002:a17:906:4786:b0:a99:4acc:3a0c with SMTP id a640c23a62f3a-a999e8ec058mr336833266b.53.1728550790865;
        Thu, 10 Oct 2024 01:59:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4LYy5Qqcg/C5y0i+TfiG+LCRjg4ILwCeslTPo/EVGqR3wOXn7Rp6NqCvSPpl+dhHSgg50mA==
X-Received: by 2002:a17:906:4786:b0:a99:4acc:3a0c with SMTP id a640c23a62f3a-a999e8ec058mr336829566b.53.1728550790497;
        Thu, 10 Oct 2024 01:59:50 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7ec585csm58270666b.3.2024.10.10.01.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 01:59:49 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 05B1A15F3E2D; Thu, 10 Oct 2024 10:59:49 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Simon
 Sundberg <simon.sundberg@kau.se>, bpf <bpf@vger.kernel.org>, Network
 Development <netdev@vger.kernel.org>
Subject: Re: [PATCH bpf 2/4] selftests/bpf: Consolidate kernel modules into
 common directory
In-Reply-To: <CAADnVQKuw=HqtzRok5NyxMDLoe=AHQfwtBxpe9hs3G1HDRJmfA@mail.gmail.com>
References: <20241008-fix-kfunc-btf-caching-for-modules-v1-0-dfefd9aa4318@redhat.com>
 <20241008-fix-kfunc-btf-caching-for-modules-v1-2-dfefd9aa4318@redhat.com>
 <CAADnVQKM0Mw=VXp6mX2aZrHoUz1+EpVO5RDMq3FPm9scPkVZXw@mail.gmail.com>
 <87bjztsp2b.fsf@toke.dk>
 <CAADnVQKuw=HqtzRok5NyxMDLoe=AHQfwtBxpe9hs3G1HDRJmfA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 10 Oct 2024 10:59:48 +0200
Message-ID: <875xq0s58b.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Wed, Oct 9, 2024 at 12:39=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen =
<toke@redhat.com> wrote:
>>
>> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>>
>> > On Tue, Oct 8, 2024 at 3:35=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgense=
n <toke@redhat.com> wrote:
>> >>
>> >> The selftests build two kernel modules (bpf_testmod.ko and
>> >> bpf_test_no_cfi.ko) which use copy-pasted Makefile targets. This is a
>> >> bit messy, and doesn't scale so well when we add more modules, so let=
's
>> >> consolidate these rules into a single rule generated for each module
>> >> name, and move the module sources into a single directory.
>> >>
>> >> To avoid parallel builds of the different modules stepping on each
>> >> other's toes during the 'modpost' phase of the Kbuild 'make modules',=
 we
>> >> create a single target for all the defined modules, which contains the
>> >> recursive 'make' call into the modules directory. The Makefile in the
>> >> subdirectory building the modules is modified to also touch a
>> >> 'modules.built' file, which we can add as a dependency on the top-lev=
el
>> >> selftests Makefile, thus ensuring that the modules are always rebuilt=
 if
>> >> any of the dependencies in the selftests change.
>> >
>> > Nice cleanup, but looks unrelated to the fix and hence
>> > not a bpf material.
>> > Why combine them?
>>
>> Because the selftest adds two more kernel modules to the selftest build,
>> so we'd have to add two more directories with a single module in each
>> and copy-pasted Makefile rules. It seemed simpler to just refactor the
>> build of the two existing modules first, after which adding the two new
>> modules means just dropping two more source files into the modules
>> directory.
>>
>> I guess we could technically do the single-directory-per-module, and
>> then send this patch as a follow-up once bpf gets merged back into
>> bpf-next, but it seems a bit of a hassle, TBH. WDYT?
>
> The way it is right it's certainly not going into bpf tree.
> So if you don't want to split then the whole thing is bpf-next then.

ACK. Will see how cumbersome it is to split, and otherwise resubmit the
whole thing against bpf-next.

-Toke


