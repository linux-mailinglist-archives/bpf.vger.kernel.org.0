Return-Path: <bpf+bounces-34352-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA4492C942
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 05:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E560E1C20AB4
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 03:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF9A381B0;
	Wed, 10 Jul 2024 03:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+KnwWTk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4A522075
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 03:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720582519; cv=none; b=DOZdmnVdiqgFWowHF1xVvLqYktoxl8z5weFkYa3w0fDwKMXZRa1PupY0RUu55kF9RJ3iBZc7QVKmELHa0bBW+vo4n2Stue7v7QeswxIU7t1nGLHzBbySGTLdwaQRresviP9RFxoWCTqz2gP7ff7sWRMWcRyuNAvxj8KlLUdPhxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720582519; c=relaxed/simple;
	bh=5p0jlViHSzs+fkLh63/GmCJ24Ef4GJdSQgHrT9G2sn4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uv0SNtjYvAgppiKeXTRG3b2YmgYjdPqpr3FgEg1OwLkNCx+oF6sKHqQ2Japgc0mxL670OgVL5/aQrm+36GZ1YNr6IEj2BkC3OT1ecT/wIuSnNaQ/nvGghMcRFVw3yAG0O5JMhkrLW7jbLcF5MTxvjV7DMvayJHOk9pJX+bGoie0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+KnwWTk; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fa9ecfb321so35761205ad.0
        for <bpf@vger.kernel.org>; Tue, 09 Jul 2024 20:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720582518; x=1721187318; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kZxzutTfUpZJbjao9r0qwLi6mts0kHpGpuPUO7PTm00=;
        b=N+KnwWTkpKmrpnjQdfqo7XSuRQCxd/ltoi0hNc6TwX+eal5ZvMyQKVZ+ZSh0t+PZRg
         HrrXLD+PcyqV/yJhIHtElYddygFfZYZkWrNmPiIw1hh3a4cMsdABoepVtL8zU1QpSMoM
         s22sDriexM2SRB3OBt+/4Zv1NA7kA76CmbYGOQWtoHdzQWf6QYC9v8x8JfrOD8k40A1V
         7mTg7iYdnhJb8jQl9ikne/c9uaeESkTbJhBVDdevVft9ZZYDM9swP/yVkUubwLafd/YO
         rjyhkgmut0IxyOoby/30K4EpizQ6Ta9vbDRW5XMzMi2v+gonbBPmzAHWGx+jtMe9rYQ2
         O1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720582518; x=1721187318;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kZxzutTfUpZJbjao9r0qwLi6mts0kHpGpuPUO7PTm00=;
        b=R25SKdhxmagRXJvjsl0eO+L5jiJAJfjClsDA+izZ7i48dSJkKZVZx17JAiejYCfUkT
         4r2z2vfaOw+JWjKBPbWkUmzBFBQ+AbHlx3HF3i/W8X6LyatifeCaozFadtGN3jF3OZQb
         IT+ryO9XZ+Q22pc/2Hoa6OE9qh6p8fvHembZGpEnegepjMRm4ztHBqjOgCNXwvaN2xTm
         ojRWaxGS2XQErgedEE1VjwOnaj4HHQNEFhLc7m03x+wuovIMq6BpWF6l4AV+iq1DL6+y
         b1HyT5uN/cRTgMCG2HokVzlNNBEJ6p4JVIqdqd5OJDX+y/r7fheGMPXSXZo7LIUuXRjo
         ZaBg==
X-Gm-Message-State: AOJu0YwAf+2hAxHPbKPJ+8i7BUe9Dsl/RKZwRSREZXB2VBKH9HzDKyeH
	wXOZ84Rky/p4E+zWStPsXivjD3AjJk/deSgP5fx/EkEthdZD0h48gXTCBQ==
X-Google-Smtp-Source: AGHT+IHhvYIvUVKmYRj7taBNqbJX5zgU6TYVq+YJg37iTSDcDQqSfr9DZ4LK44WeRWWYsMjXyA1rLA==
X-Received: by 2002:a17:903:41cd:b0:1fb:888d:91a0 with SMTP id d9443c01a7336-1fbb6ec3f52mr37193525ad.50.1720582517707;
        Tue, 09 Jul 2024 20:35:17 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ab8026sm23308535ad.179.2024.07.09.20.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 20:35:17 -0700 (PDT)
Message-ID: <c9639d8de4c000cf4d685416d81da81a653fcfb4.camel@gmail.com>
Subject: Re: [RFC bpf-next v2 0/9] no_caller_saved_registers attribute for
 helper calls
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song <yonghong.song@linux.dev>, Puranjay Mohan
 <puranjay@kernel.org>, "Jose E. Marchesi" <jose.marchesi@oracle.com>
Date: Tue, 09 Jul 2024 20:35:12 -0700
In-Reply-To: <CAADnVQLBd9V3NxxbEJM_RyZHm-jcwqqUkc1n-1Djry5RqF5eEQ@mail.gmail.com>
References: <20240704102402.1644916-1-eddyz87@gmail.com>
	 <CAADnVQLBd9V3NxxbEJM_RyZHm-jcwqqUkc1n-1Djry5RqF5eEQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-07-09 at 18:18 -0700, Alexei Starovoitov wrote:
> On Thu, Jul 4, 2024 at 3:24=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >=20
> > - stack offsets used for spills/fills are allocated as minimal
> >   stack offsets in whole function and are not used for any other
> >   purposes;
>=20
> "minimal stack offset" reads odd to me.
> I noticed the same naming convention is used in llvm diff.
> imo it's odd there as well.
> Maybe say:
> llvm grows the stack that in bpf architecture always grows down and
> picks the lowest stack offset not used by local variables
> and spill/fill.

Will replace "minimal" with lowest here and in LLVM diff.

> > Here is how the program looks after verifier processing:
> >=20
> >   # bpftool prog load ./nocsr.bpf.o /sys/fs/bpf/nocsr-test
> >   # bpftool prog dump xlated pinned /sys/fs/bpf/nocsr-test
> >   int test(void * ctx):
> >   ; int test(void *ctx)
> >      0: (bf) r3 =3D r1               <--------- 3rd printk parameter
> >   ; __u32 task =3D bpf_get_smp_processor_id();
> >      1: (b4) w0 =3D 197132           <--------- inlined helper call,
> >      2: (bf) r0 =3D r0               <--------- spill/fill pair removed
>=20
> Are you using old bpftool or something?
> That should have been:
> r0 =3D &(void __percpu *)(r0)
> ?

Yes, I was using distro-provided bpftool.
Re-running with kernel version of the tool shows the __percpu thing.

>=20
> >      3: (61) r0 =3D *(u32 *)(r0 +0)  <---------

[...]


