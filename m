Return-Path: <bpf+bounces-46281-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1073E9E7520
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 17:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFBA6289737
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 16:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C6B20CCD7;
	Fri,  6 Dec 2024 16:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmgLAWr0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340EEBA20
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 16:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501289; cv=none; b=dbmkaCZAYI8/mqA6BqtUs9hYaJDJKDM6yIOzUmF8VlRCjMl9cS52mNDf9H2Rj/dGFySNm2zhs/dIf8vG9orqP7Bt3o2FPwzRfLfbw2Yc7dJgoRrJN8lGxTsn7m6SVmahsE9W12EpoYIyxQsGrN0vljVv/QgSochE851KOxEHspE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501289; c=relaxed/simple;
	bh=7ZE+5pa21zu3nzjXqijaT+RQkZdMEqvIhiKNMJ2ZqDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ee1i7+ovfC/poPjUaLnBiLcZX4DDXJVPBNKAYDi8E+j7eU3vI5uBUUBWjW3rg+kgsSZ0INgYd7CzH+q9bGW5LNiUAHABw1JmRTFZGQlbt/1RDzOwC5trb4lDbE66AAFIjXq0xKj9pApbYGtDLFWkzQ7iuE6t3wA0bc3baiYlA98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AmgLAWr0; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43497839b80so14978775e9.2
        for <bpf@vger.kernel.org>; Fri, 06 Dec 2024 08:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733501287; x=1734106087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZE+5pa21zu3nzjXqijaT+RQkZdMEqvIhiKNMJ2ZqDk=;
        b=AmgLAWr0gNNfmBFjzLpS1fECGe03HofjZVrGXi1mpawyYSJCL1a4Myj8tHIE5Dzcqt
         lWVEtDIqmfkHicCiNBJ3DxJew7/bb674Oy5vzYgjfkmTaoh/AnU4J73t1atkCr51mp4k
         84k20HLtgq237SoapGZ187KOVK3w2FbJQUaU6UT/lT5+m37BWD0AZaHrGXMmxk1NnAmg
         IlAz396JtGnP4teMid4w9QbFJc192IiNO8lptWTSQsgGRkEVsm5GXUtrI9EGzu+0kyhN
         W5zGB7me7KLuBl9UaSDkH36dXEOQD+LzIiHTwqWRGvqqha5rzKeeVIisiAqr90zbxF0Z
         ke0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733501287; x=1734106087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ZE+5pa21zu3nzjXqijaT+RQkZdMEqvIhiKNMJ2ZqDk=;
        b=rHj5e5LHeJf7j4LJAlrn3okErRTB9NKh4Vq8pZkQoLvGy6cl6BVBgTDBHeTVI/NtxX
         kRS7ZqTERz9OeWjXz34zjc1juzMQEO9vDq4SiQ829R/9vL8hYm9DqzKaaMwPKScM7o4N
         f1U3kZE4tawCX6EbPIuWK1kueW3onvXeWqPwT6jdSqD4dc7U4EYtymoIBDBaqne+aErg
         wUVUGb+ls2cyftzus6bkoVsrCVtm+Sb+8XHOVWB3ovjMEQFDmZF1iqb3POYbuFBNmKxF
         kjkVPMPRAYWsyaZopXU5FV3wSK7IJW2Aze2hLmMwh9nY1p59v833Ojpa+yot1C28DRSx
         N2mw==
X-Forwarded-Encrypted: i=1; AJvYcCWpTTeuK2a4sVt1vUNMo2HD2nQtEZ8oZ+/OZ9HFqzJBJFIHSD99u5LjDDASj95XruN4JLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOHurl+70uXCbnfpcRiCngc3Ynt8X4q8INo7rsi8MufIMDPV5F
	5YAh51LcFzWlmjUeAyDlnxpv030P48hWPGGHwpoHvea3QECxG6sN01+5kS2SweXPN+f0YrAR9Gc
	EWdy5g34Xnjtbn9G8okrQgBaKRIS5NRkL
X-Gm-Gg: ASbGncs2q7k8SNxH9Zoglw2nyh62s89y/nY3LsKlDLmpSPzA3ARaT4IAmwqwQh+3amr
	ebeW4fAqU78s/eqIDvSIKOzu56/AfvAiR4v/SXSot88egVns=
X-Google-Smtp-Source: AGHT+IFxCJi5ZBsTcY3zd+ITvo0djivXIBpoAMQXs36KveThux2LF4jaEePGkU+gEjmThNtmyWXe1bhaJMRRwzLa66c=
X-Received: by 2002:a05:600c:1c82:b0:434:a968:89b5 with SMTP id
 5b1f17b1804b1-434ddeb5285mr33463735e9.9.1733501286242; Fri, 06 Dec 2024
 08:08:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0498CA22-5779-4767-9C0C-A9515CEA711F@gmail.com>
 <1b8e139bd6983045c747f1b6d703aa6eabab2c82.camel@gmail.com>
 <47f2a827d4946208e984110541e4324e653338e0.camel@gmail.com>
 <CAEf4BzZBPp40E-_itj1jFT2_+VSL9QcqjK4OQvt6sy5=iJx8Yw@mail.gmail.com>
 <4bbdf595be6afbe52f44c362be6d7e4f22b8b00f.camel@gmail.com>
 <CAADnVQKscY7UC-5nAYxaEM4FQZGiFdLUv-27O+-qvQqQX0To5A@mail.gmail.com>
 <1f77772b8c8775b922ae577a6c3877f6ada4a0a1.camel@gmail.com> <CAEf4BzZybLU0bmYJqH2XJYG_g8Pvm+STRdHBtE1c5zbhHvtrcg@mail.gmail.com>
In-Reply-To: <CAEf4BzZybLU0bmYJqH2XJYG_g8Pvm+STRdHBtE1c5zbhHvtrcg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 6 Dec 2024 08:07:55 -0800
Message-ID: <CAADnVQJ7WuFge8YZ-g07VK6XhmMCf1RHa0B64O0_S4TLzu0yUg@mail.gmail.com>
Subject: Re: Packet pointer invalidation and subprograms
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, andrii <andrii@kernel.org>, 
	Nick Zavaritsky <mejedi@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 10:23=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Dec 5, 2024 at 8:07=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >
> > On Thu, 2024-12-05 at 17:44 -0800, Alexei Starovoitov wrote:
> > > On Thu, Dec 5, 2024 at 4:29=E2=80=AFPM Eduard Zingerman <eddyz87@gmai=
l.com> wrote:
> > > >
> > > > so I went ahead and the fix does look simple:
> > > > https://github.com/eddyz87/bpf/tree/skb-pull-data-global-func-bug
> > >
> > > Looks simple enough to me.
> > > Ship it for bpf tree.
> > > If we can come up with something better we can do it later in bpf-nex=
t.
> > >
> > > I very much prefer to avoid complexity as much as possible.
> >
> > Sent the patch-set for "simple".
> > It is better then "dumb" by any metric anyways.
> > Will try what Andrii suggests, as allowing calling global sub-programs
> > from non-sleepable context sounds interesting.
> >
>
> I haven't looked at your patches yet, but keep in mind another gotcha
> with subprograms: they can be freplace'd by another BPF program
> (clearly freplace programs were a successful reduction of
> complexity... ;)
>
> What this means in practice is whatever deductions you get out of
> analyzing any specific original subprogram might be violated by
> freplace program if we don't enforce them during freplace attachment.
>
>
> Anyways, I came here to say that I think I have a much simpler
> solution that won't require big changes to the BPF verifier: tags. We
> can shift the burden to the user having to declare the intent upfront
> through subprog tags. And then, during verification of that global
> subprog, the verifier can enforce that only explicitly declared side
> effects can be enacted by the subprogram's code (taking into account
> lazy dead code detection logic).
>
> We already take advantage of declarative tags for global subprog args
> (__arg_trusted, etc), we can do the same for the function itself. We
> can have __subprog_invalidates_all_pkt_pointers tag (and yes, I do
> insist on this laconic name, of course), and during verification of
> subprogram we just make sure that subprog was annotated as such, if
> one of those fancy helpers is called directly in subprog itself or
> transitively through any of *actually* called subprogs.

tags for args was an aid to the verifier. Nothing is broken without them.
Here it's about correctness.
So we cannot use tags to solve this case.

