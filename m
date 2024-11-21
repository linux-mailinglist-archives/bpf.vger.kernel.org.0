Return-Path: <bpf+bounces-45406-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BED9D533F
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 20:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F1AEB245BE
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 19:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D421DD0FE;
	Thu, 21 Nov 2024 18:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CnO9ZZCA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A96D1C8773
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 18:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732215257; cv=none; b=nqr3buirszldob5OL7pDTVSNoLTVU+xF/uxqaL6dLE1Vvk90hiANpTdsw5r2MbAxDflfWJA/xtLUW1Jn0Qcio0rXI+F13VZd0aAxBSedBFpZNPGLoMqGJxFque1udeN//je7of3y1VnukDBW9DUFgcAwKJjRLKUeMYYtnbgKNA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732215257; c=relaxed/simple;
	bh=C+BVUY32c7S8TwoCD8us5P/vxKs5amwS7WglwD6dDnk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IElxWPLg24razikNwTKWjZibKTNuXart2Yl3Ww6VXW0E9NuQRcHQktbqOGkW9sxnSD8xrc5S1n+6f58av6XwFnhQuandviYgK7ZRIJSHUKd6BWbb21l7nyNhXRad3kkdTElWPTUz6RHXsg+19I9ONf9xtRrur3aNNxD1Smvx2u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CnO9ZZCA; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-718119fc061so609954a34.2
        for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 10:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732215255; x=1732820055; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ifwDY8VMD9HfjbQuBYjngClWa+DKO938XzOAHz3NBME=;
        b=CnO9ZZCA2OG7EevE7VlaR8jYncS9qQ4up0wRxgp8Aqi1UJhkvpYV51sWvnN2D9JRU0
         VBnmfSyZpWuuAD6c0ihX/ECUQhUW9DR7GsiAZns/YadmGcnzTGYp6EN65fyEW7BuRkvx
         EtWi0jUmsx2tcA10UinZBk0hd/Ib3FgPI00XlYpkbZZWB+oDFE0HIr5lxgV9eFIv0RDX
         uDcyc6EX/xRzEllA+JIg72dto0DJrYdqsj1edbSWYr1KwD2ePm0Oqw2RWpOPDRka9hNx
         2qDeXVYx1lzXFvckHZ6kwwqJXY11VON4932Sx/U7QV8uSiWiIeDalubVeYRNYu3ml26e
         6umQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732215255; x=1732820055;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ifwDY8VMD9HfjbQuBYjngClWa+DKO938XzOAHz3NBME=;
        b=l6KoNF50mcxz0r+i0DOCCh6aXcIOuPgcu6uP9FQfTa6eXmookZecLDR0Zsp8QKWjiT
         awo+vRVRGM+KMk/y1YHBNk92OUC5k1A0z2xpUEeasi4VxKIqem7I8imbrn2nnpDH1UNo
         Jcv4oIeN0Efn+Fl/Ugcolr92cKxEVvBVQ3bJXuH6tv3YdMHYytdJ7umXEOI/+HykSjTD
         ChuI4UG+T2WQL0wJ/A6FoRJv/iTHksR6CXFT00bfhJ4NgUAPW1zx6TYKW7RsPKl9jrMd
         WqejvAVYhSLlLj7bqQ0XN0H9TnkfAiqBp7CXpgpioLZj3PHD1a2F0DxsQTX0UawWWchd
         kwLg==
X-Gm-Message-State: AOJu0YwwNTLKY7Mcg1ahRr8UAoAByeAKMLCbJWR9FF6+ZlJlf5klyCtx
	fG8RpOghgRMdwadkZ4CHmnhPBHAwxsLKBD2qOeiHv7dF0QfCdXat
X-Gm-Gg: ASbGncvEtMge1sjtW+s+/xMirmyD3NTMea8UKrT2GVAGvy/wHVwGwUWbzBwYKAIfM5S
	mhjw6WgpAG+D521M+PoFphbWBdImY31eKlJoeAIl5oDyEXYDG63UBk51gNgONwbkML3c0nR/AxV
	xsnGUYfz33vfXxtQLUqjEagUysfeKdi2uBlHbrcAsA6r466OL7YMUBWnIxelfUcgW+33DafdaA6
	6Awn1YvvndcySFaxLsGG0J+csRlWMNPA5SxbbiSUyXOlQQ=
X-Google-Smtp-Source: AGHT+IHgufBMJnf5H8u9dNUYdJwYGFmpS5KSmw4CT7SIfe1KvbFiX8l3ePTYLh/5OjDx4hr56ohDNg==
X-Received: by 2002:a9d:620d:0:b0:71a:21c9:cd5c with SMTP id 46e09a7af769-71ab319a881mr6308798a34.22.1732215255205;
        Thu, 21 Nov 2024 10:54:15 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcc3de0ecsm101308a12.57.2024.11.21.10.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 10:54:14 -0800 (PST)
Message-ID: <763a88cb28f66ac5c62ddbeef763b77fc6833418.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 3/7] bpf: Consolidate RCU and preempt locks
 in bpf_func_state
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>,
 kernel-team@fb.com
Date: Thu, 21 Nov 2024 10:54:10 -0800
In-Reply-To: <CAP01T75sz0YB7dj3fchyw-E2kjftaewcXhWJP_=hf_OBnWBDQA@mail.gmail.com>
References: <20241121005329.408873-1-memxor@gmail.com>
	 <20241121005329.408873-4-memxor@gmail.com>
	 <dfe594d893ce83a3be0ddaa3559043908465eaec.camel@gmail.com>
	 <CAP01T75sz0YB7dj3fchyw-E2kjftaewcXhWJP_=hf_OBnWBDQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-11-21 at 19:12 +0100, Kumar Kartikeya Dwivedi wrote:
> On Thu, 21 Nov 2024 at 19:09, Eduard Zingerman <eddyz87@gmail.com> wrote:
> >=20
> > On Wed, 2024-11-20 at 16:53 -0800, Kumar Kartikeya Dwivedi wrote:
> > > To ensure consistency in resource handling, move RCU and preemption
> > > state counters to bpf_func_state, and convert all users to access the=
m
> > > through cur_func(env).
> > >=20
> > > For the sake of consistency, also compare active_locks in ressafe as =
a
> > > quick way to eliminate iteration and entry matching if the number of
> > > locks are not the same.
> > >=20
> > > OTOH, the comparison of active_preempt_locks and active_rcu_lock is
> > > needed for correctness, as state exploration cannot be avoided if the=
se
> > > counters do not match, and not comparing them will lead to problems
> > > since they lack an actual entry in the acquired_res array.
> > >=20
> > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > ---
> >=20
> > This change is a bit confusing to me.
> > The following is done currently:
> > - in setup_func_entry() called from check_func_call():
> >   copy_resource_state(callee, caller);
> > - in prepare_func_exit():
> >   copy_resource_state(caller, callee);
> >=20
> > So it seems that it is logical to track resources in the
> > bpf_verifier_state and avoid copying.
> > There is probably something I don't understand.
> >=20
>=20
> This is what we were doing all along, and you're right, it is sort of
> a global entity.

Right, but since this patch-set does a refactoring,
might be a good time to change.

> But we've moved active_locks to bpf_func_state, where references reside, =
while
> RCU and preempt lock state stays in verifier state. Either everything
> should be in
> cur_func, or in bpf_verifier_state. I am fine with either of them,
> because it would
> materially does not matter too much.
>=20
> Alexei's preference has been stashing this in bpf_func_state instead in [=
0].
> Let me know what you think.
>=20
>   [0] https://lore.kernel.org/bpf/CAADnVQKxgE7=3DWhjNckvMDTZ5GZujPuT3Dqd+=
sY=3DpW8CWoaF9FA@mail.gmail.com

As far as I understand check_func_call(), function calls to static
functions are allowed while holding each kind of resources currently
tracked. So it seems odd to track it as a part of function state.
The way I understand Alexei in the thread [0] the idea is more
to track all counters in one place.

Let's wait what Alexei has to say.


