Return-Path: <bpf+bounces-33390-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3D891C9B1
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 01:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B96F284FA9
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 23:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56902839E3;
	Fri, 28 Jun 2024 23:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lT0qBc/Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814FE17BDC;
	Fri, 28 Jun 2024 23:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719619029; cv=none; b=aZMGHPHAqzNQ3F7qAc3ebdAJaJr1W5jdSgy4tdK+Y3wIBSVPNRek6PNWpGlUqq7EmdtuR4RscCaDKVfNjN5/6xEDrQAAlIvftFJzWXq0OKKo8naj7ham1H0U7w8/Une1rsg04QnkWqxgQ/+zAwJdynIW0kdgeyQU8awFcWfiBb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719619029; c=relaxed/simple;
	bh=s2UII4ggSpYu8K1rwyFgZkco//+d7d5M5JqxT1hxTMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bPr/FXoBUPZXeDRZMwmoT4iskPs2Opcn9tZfKNF52ZDMkh8TeUsxUefE7GCPV1vUi3XjZBRRhfJRuzXDsOhxtV7edX4iCtc9Vms5Lp0o2vq1w/EdLAlIXQpIjE7mq/rryEsQ/gj8q90dTpWWcjGjm2jqV0pl08EL67neJD8oR+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lT0qBc/Y; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-701f227c256so569387a34.3;
        Fri, 28 Jun 2024 16:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719619027; x=1720223827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2UII4ggSpYu8K1rwyFgZkco//+d7d5M5JqxT1hxTMI=;
        b=lT0qBc/YwLyRTMlASxdetJYnFj/J6pcfChFJl9Xcs+N51wu2ypOIRq2K5DW++udWTg
         EGWPI7Vn0LLBKfRTUmXBJPbEpYJf1uQdWS2iLtZV5NYl+WzL4h8wMJllDxwYGHWg9UVT
         54/Xwxp2jwPXJVQDU7y0HMqdhHwq8TsjQKkBBDO9bSUBtDvVFggVvcbS4PGwM6CpTOn4
         lyH91R3z9K41R1tf3Byrk8GpLWY6bOA+nm+MResbVIpz+P/JgOAQEht/RA5+QOZeo+J2
         BhEfSvsslVQDzlHe2RbqzA+GWvuxiRp2A+56fCrpOpwN4FqOdUnBqxEmFlpV9U8mrag+
         3/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719619027; x=1720223827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s2UII4ggSpYu8K1rwyFgZkco//+d7d5M5JqxT1hxTMI=;
        b=Bz18UCgB976/NvfZnpjuKWwAgqjPV2v7aLIOZLShuxeasecowFteyIB6hrFb/1P5Ta
         J+t11EsdUNc+8VA/vrV41Wacz41eXVSiH74uFEStT4pbw7FdLyJlt+huZSVhUMg8a5Ye
         F3s9vDtTT271YDaGQWWk0qfWuOMyyDFBE5WfQyM5RcLaW3NnDG4OgocLdFfEPw1I1Fhp
         /exHkO2SLTXryG45gwJYDLJpIiNC8Jpv+E/3lhs3FRh64uw97G8xTFYA7FeOgwFjHYDn
         PhOssXNePmRn9hvM+4FJSRI0TPxB3r5ilYqoNNM4Z72OkLUov9v67rM2ae0pjDUDgwcp
         EmAw==
X-Forwarded-Encrypted: i=1; AJvYcCWpYTXLwn+PRwJ8RnWfHTo3WM/LhbMtHf2rB3q3fpqitm9eboTib3zeao71/SU05koApflFxsnWhaS9A1E30Qa06AApoEFhh98bZoebSilWlwUTUA9LntcgEBpmnvo3JPaB
X-Gm-Message-State: AOJu0Yx3N9J5LvaPl2kRtgAlAcGABBljMtLGiTYiAFgy6eJqX18R00gW
	cXU6oNZeJyHcPkPp5bWOafeUyUtE+eloqRxRzdobVjuoOZfYsPWqyIIWXpjua8HME6LlA1Lv5V/
	dW/VaOjf8eaf78uCfvVxqQCs8lS7/3g==
X-Google-Smtp-Source: AGHT+IEhQcbluO1CXSh5xOdYE4gVK3nJCbamaiXjrZH7jXnBiR8u95ET0HqVL2++YRNjxPoSgHI+GDSwrVXfwwA6+jI=
X-Received: by 2002:a05:6359:6e07:b0:1a2:5caa:1482 with SMTP id
 e5c5f4694b2df-1a25caa1c60mr865462855d.32.1719619027545; Fri, 28 Jun 2024
 16:57:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zn4BupVa65CVayqQ@slm.duckdns.org> <Zn4Cw4FDTmvXnhaf@slm.duckdns.org>
 <CAADnVQJym9sDF1xo1hw3NCn9XVPJzC1RfqtS4m2yY+YMOZEJYA@mail.gmail.com>
 <Zn8xzgG4f8vByVL3@slm.duckdns.org> <CAEf4BzbVorxvJdGA0eLviRhboaisxe4Ng=VErZVh3MG9YrRaKw@mail.gmail.com>
 <Zn9BZB8tE-CySXnn@slm.duckdns.org> <Zn9De_70fy-DVA-_@slm.duckdns.org>
In-Reply-To: <Zn9De_70fy-DVA-_@slm.duckdns.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 28 Jun 2024 16:56:55 -0700
Message-ID: <CAEf4BzY9-CW+SamvwkrHBH1RgB3bxybRmnrK_E0p_Np=V5MsMg@mail.gmail.com>
Subject: Re: [PATCH sched_ext/for-6.11 2/2] sched_ext: Implement scx_bpf_consume_task()
To: Tejun Heo <tj@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 4:13=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello, again.
>
> On Fri, Jun 28, 2024 at 01:04:04PM -1000, Tejun Heo wrote:
> ...
> > Not a stupid question at all. It's just that all the existing interface=
 is
> > based on IDs. This is partly because there's not much the BPF code can =
do
> > with the DSQ data structure and partly because DSQs are usually not acc=
essed
> > multiple times in sequence (ie. if the BPF code isn't going to look it =
up
> > and hold it persistently, it's going to have to look it up each time
> > anyway).
> >
> > The multiple lookups aren't the end of the world. They're all on a resi=
zing
> > hashtable, so lookups should be pretty low cost. It's just a little bit=
 sad
> > to look at.
>
> Just a bit of addition and a question. scx_bpf_consume_task() is maybe na=
med
> too generically and I have a hard time imagining it being useful outside
> iteration loop. So, it does work out kinda neatly if we can tie the whole
> thing (DSQ lookup, barrier seq) to the iterator.
>
> The reason why this becomes nasty is because I can't pass the pointer to =
the
> iterator to a kfunc, so maybe allowing that can be a solution here too?
>

Sure, if that's the best way to go about this.


> Thanks.
>
> --
> tejun

