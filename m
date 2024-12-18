Return-Path: <bpf+bounces-47184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 536E59F5D9D
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 04:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C23E41890D23
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 03:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1EA14AD38;
	Wed, 18 Dec 2024 03:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CnSDd7wE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D94142903
	for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 03:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734493878; cv=none; b=YQFAtdrqx3ef9TmCwq6jDiM3qAIXaQpp2ku26aAVWMSouRMNignVOTOm8xAAw1+60tKvdbzV1z26GFlkUCYLwwsi1dEmi45L2BZcP3Uoo9+czksco9GrsGgHMrFxvwPpFR68Z16I8d7NL6foPV5CaqRp0Kzc4JlJoUbK5QuDrfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734493878; c=relaxed/simple;
	bh=vewWQW7umR7UdMMuwwVTH81WLZQ7UdR872dko4OWrgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=skqzsKNERkytxd2dKm2Y5CStgUnR8xGtA0FjCZ6+T0OWEV5QtyLYLZ08JFpg6Nn83v+3CBjk6Tpxo6X+Kh2kC603f0FU5n9LNV8K+plQcHOfoAY/+pu06KDHt7nMNM/MD7OCqgmHHk1HisT3hssM6ihHX6Y9Liims5BfC2KZr6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CnSDd7wE; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-6f27bbe8fc3so35319537b3.2
        for <bpf@vger.kernel.org>; Tue, 17 Dec 2024 19:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734493874; x=1735098674; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfNlVeuYBdN5H+RIZhW1yZASAmeUw/u2SM0DIGO8/lw=;
        b=CnSDd7wEDvM8goXwHX+jxRfEk6UVT7xCVigwxATvmTEU3EMLcQuirEp+SPj9TyTf6+
         hZDz30xtfRCFdw5MS1nvdHiiD2yStlRSDPMcbnAoy2z/AFMsQyq5kfFTdoOBLmiazuSV
         ZdTeb2LzDeZgf1PnfNgzcFsPhotp63cL+IlnIvpw321BpC5c04BSeUKJ0LvuF0/S7hVd
         ryjtwZKvpJ1lQUBvl8XWPq1bBmBhNWLidVQBMZijV3LFvNc8y2wrW15brU91MSU0guSi
         ibPLGPtebKUGin7bts/Tpvo6mK3QHu94WwwZXbo+WjwrnADEflMrok/HyntRyv/r8Hkw
         k98w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734493874; x=1735098674;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tfNlVeuYBdN5H+RIZhW1yZASAmeUw/u2SM0DIGO8/lw=;
        b=sWHKg6p4oZflHgaUcCvirfk0Ie5D11b4uE96vaJtv+J6loDKkt4FGH/S5LdX+OuV17
         gypsQT8MwIMAzKykm43OfdQ2RgnUmC1+joeWLhZvfDcMofXpnVhGQH6jOQQzQ/Bjipik
         O6saLxBXDFuBUuA71p9cB+v4gnD3Py0POSsiNF111RK7WLEjZCwKTm4HT9Pyr0cAMwZw
         DJRc+xog1VxuaFaWM2zlY0+BblVZorwBC35+EAnd6Q7PoYgOeeYE38ttDR11n77cwUvX
         aDsesyaaIYZLEhlzhGz+B8WjRDNQJcOWGgTxjr19/EYTCympCVmqmge7brXiQUmd09e9
         r68g==
X-Forwarded-Encrypted: i=1; AJvYcCUPuu1cKbjlbS8nO9S/cXpU7JDxpsimfIc4BomBzSbE853QI1np+93c8Eo9zshPGgEzoGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJqeNy6MgBwFqn/dQCQWWGA/23KnxJ0tTEmhb9jzX2XImSnFz8
	GAU0y5w5YJ4AcPIli8XrEf3x04nfznV+SVV1ECgFr8hX17+sCGjCiqy02Cyfx4IWu7TjQvsLBlA
	Z/6MjHC/lJbJfR8elVZ/SasMwOjg=
X-Gm-Gg: ASbGncuK82NG+dtkO/bfiOctUmxEQPugmgio9NU1Al9TVLOxZDzE7SpIrDwZFjg0M9l
	EkfeHAAVoK07twl9DFSx3mtY1PWBiQ901ZM3xDg==
X-Google-Smtp-Source: AGHT+IGdJ/vHd1r0xSoa93Roj0jIOGqG+mbEsCtSywzLx9qmIdLBbXykuK/R8IP9mq0UYUvrw/dsnWsacow5lxorQ8Q=
X-Received: by 2002:a05:690c:74c3:b0:6f0:23da:49a3 with SMTP id
 00721157ae682-6f3ccc28993mr10304467b3.8.1734493873977; Tue, 17 Dec 2024
 19:51:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADxym3Yop==sWx2q8448kYkDWcK=P7+fqeZLzyzk8D0GwZEV-A@mail.gmail.com>
 <CAADnVQ+1mSHwUK4rZ_mJP7W72iSXgsVfazurYPRGi=3p5aBVdQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+1mSHwUK4rZ_mJP7W72iSXgsVfazurYPRGi=3p5aBVdQ@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 18 Dec 2024 11:52:03 +0800
Message-ID: <CADxym3ZfHv_VdgopE5TBQxhO7RrPTVm83VW07c8bAywp404QPw@mail.gmail.com>
Subject: Re: Idea for "function meta"
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 2:46=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Dec 12, 2024 at 6:17=E2=80=AFAM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > Hello, Alexei.
> >
> > After the series of "bpf: make tracing program support multi-link", I'm
> > keeping think about the method to make tracing support multi-link.
> > The previous discuss is here:
> >
> > https://lore.kernel.org/netdev/20240311093526.1010158-1-dongmenglong.8@=
bytedance.com/
> >
> > Now, I have a idea. How about we introduce a "function meta", which
> > will reserve some space (such as 16-bytes) before function, just like
> > what fentry do, except that the space we reserve for fentry is after th=
e
> > function. For example, we have a function "do_test", the layout is just
> > like this:
> >
> > -------------> 16-bytes
> > -------------> do_test
> > -------------> __fentry__(nop)
> >
> > (Of curse, this need the suuport of the compiler, which is not availabl=
e
> > for now.)
> >
> > Then, we create a global trampoline for BPF. When we need to attach
> > a BPF program to the function do_test(), we can allocate a
> > "progs" of type struct tracing_progs, which is defined like this:
> >
> > struct tracing_progs {
> >     struct bpf_prog *fentry_progs;
> >     int fentry_count;
> >     struct bpf_prog *fexit_progs;
> >     int fexit_count;
> >     struct bpf_prog *fret_progs;
> >     int fret_count;
> > };
> >
> > Then, we store the address of the bpf program to "progs", and
> > store the "progs" to "do_test - 8". And we make the __fentry__
> > of do_test() a call to the global bpf trampoline.
> >
> > In the global bpf trampoline, we can get the "progs" by "ip - 8",
> > and call the bpf progs in it.
> >
> > The function meta can be used in more general way. For example,
> > ftrace can alse use it. Then, we don't need to lookup the filter hash
> > table.
> >
> > (Hope I'm disturbing you)
>
> Not at all. Sorry for the delay.
> It's best to email the mailing list all the time.
> Plenty of eyes there that can help evaluate and refine the idea.
>
> Overall, I think, it makes sense and there is a compiler
> support already.
> See -fpatchable-function-entry.

Awesome! This makes it possible for me to implement
such idea in the kernel right now~

>
> But it's probably a hard sell to unconditionally add 8 or 16 bytes
> to all functions in the kernel for x86,
> though arm64 is already using -fpatchable-function-entry=3D4,2
> to support jumping to full 64-bit offsets (if I recall correctly).
>
> If it's only 8 extra bytes for x86 in front of the function
> then please measure vmlinux text before/after.
> Then we can decide.

Okay, I'm testing on this pointer, and I'll send the result
out to the list after I finish it.

> Let's discuss this on the list.

Thanks for the replying :/
Menglong Dong

