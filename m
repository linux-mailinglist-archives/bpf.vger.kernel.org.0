Return-Path: <bpf+bounces-77594-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DC4CEC478
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 17:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0AB16300100A
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 16:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23845205E02;
	Wed, 31 Dec 2025 16:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGo9SgVy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DCB262BD
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 16:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767199523; cv=none; b=ZF6AV0KWiu0WDS8dCvESF5p8IoGwY+sYdr+98eeJz2piP5t1gNz70UdKar0BuY3nrzubPtwI1anAwZxEZjZQXzYtXPQo5PzDj4LjwBdlEG01KwBEJl1Ai5MrCUmTwXXAtpXxOkzqjZjePmDHhT+zRcM/YymH7qj/v0HLa8ri54Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767199523; c=relaxed/simple;
	bh=+PGDx+GGZSviU2xKOkRGPMjp5EHzK+2aothMaA/N+Wc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eVAfgx5QlU2MbZ7NDaA2VGYOeNZEiFXR3SYyvCzdiGbwFiuMCt9EJKv546qDi83jJerLM2O5KXnUaw9j8yMpOAWTjDGyVFKdqWg7hddOrE0Oy04emvptjf9UONDURbN136mWhNdJJRPFxUjeS+Son77WgXHrwM6KgUDgYQK6pyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGo9SgVy; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43260a5a096so5651177f8f.0
        for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 08:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767199520; x=1767804320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+PGDx+GGZSviU2xKOkRGPMjp5EHzK+2aothMaA/N+Wc=;
        b=BGo9SgVyvTvZ2+nAk/ylpBl7kaolqiJ8o16vb/Qa103VWhchjwxeUALRa+JawIdsCT
         1KDa6WDfnHzHGO9YpLto4Bb9Gjy/hK82W6DuHiQzczcELNtuDeAtPCOrAS590DOe3+rS
         Yfsr7gfeRNDBtIscaet59JbkPEm9KL7AvddCam8lD2+XZWuUEq96W2ACDrFVPj8gb5Te
         2jH7oK0wDCNGUHbplhOeitmFecqt5tNeK8c2jcNNGTqUByA5Qu6b2rlNCf2UGoq+E1aM
         U1wNyhfrl1gFzox8itBE8dxmvdp37bYjZBPQX8mwaW/YC33m2Fq9fUxzafnNk0hYkRbm
         qNhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767199520; x=1767804320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+PGDx+GGZSviU2xKOkRGPMjp5EHzK+2aothMaA/N+Wc=;
        b=Ff3N+EeJ2VUIuYomYN8uyR979EZqUG1FGFmxrKvsodtOxBV83CDuIXa4UklJzL39/H
         O1EGkCIjArtm4BtOP1j8zniXn78H19z2iqo2tN8mttHfVjsXZFtqn9GO64A0+LhRH66g
         KJdyZDvkGihfVP5/G7650O1E/F93JZHCIhUmibUy6c11zwS4vOC3i/b7EtqmqA7QZm+T
         EWAdNUtR0JDjEfFGp7JZd1Ycw7SwMOwCWv4GbeeI5X5wTDpur6aJ8xrcJObKGcWi1A3B
         fdNETzrsjdaMgYEm4PJ1nLC3icLcNHcVL17cS3liyPhQZbU57HiXHz9z/FP9v6cOYquo
         hduw==
X-Forwarded-Encrypted: i=1; AJvYcCWjjP31M8qUZEY4kSkKAR/rNxP8EWnQ9Gt7rhs5E+MnRBQ73g25irirfGL2ONlf46n35Uw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWbapNtqajFBxGYoTduq9i5OkBxKESmc8zwHGIH4Hm/anf+h4w
	aCD3wrrQEQzPMb30J6+TRVsvF7zTjQElOrM9DOxFLP+f3/38e638+YM71lvIgIkSbfcUR+nEilo
	/zQPAUvtNV9Jd8BAqkzWqXFWjARBan6M=
X-Gm-Gg: AY/fxX4MthE3hZis8oyQWlf9RUo+6JmnDqFoEb0guAuSruRjUGqBWggbk4NLP2xOaes
	kGo4pCl99ryIRYG51EsLd0mNpdgdooXhwt9rnD+3tXIzgdshyndowr9Em35fBMKX47dG4sQnfCN
	tb1WFFdSuLHIxnOjWIQMu1Knm6YoaQsI3tRTD7zNq8sNXTFHfsX6WYRKN9DXJkO/P4kljnT117U
	dYORXFmlQNouOtQDja+c4nyhQizY8aV8dhwhZsPsSplo+R9cMopchcyOWk3wdHVDqb6Jb5mYcbH
	5BPC23xLc8Cs2EE9Cv7vvN3iWApB
X-Google-Smtp-Source: AGHT+IGFYQ6LF7DDPDbxsHlHG0aiikjDNXD/xZMeE1WZapoH4CDNdRwaPSGkH7pVxZlgI1m+Iv3cl2k+T5rOPpa+PYc=
X-Received: by 2002:adf:f047:0:b0:432:5b81:484 with SMTP id
 ffacd0b85a97d-4325b81098emr29087064f8f.52.1767199520254; Wed, 31 Dec 2025
 08:45:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251224192448.3176531-1-puranjay@kernel.org> <20251224192448.3176531-2-puranjay@kernel.org>
 <4cb72b4808c333156552374c5f3912260097af43.camel@gmail.com>
 <CANk7y0g6s5C-mLTPUpGyvJC=ZA=v9WawYzbeVgocbsf4dcXJHw@mail.gmail.com>
 <6d032492af465929e1e02c53a479f71ef8964d76.camel@gmail.com> <CANk7y0jdE-1cVE3UsyQaC2HwZ0TyjPZr=q=c4meYjH27PdUwJg@mail.gmail.com>
In-Reply-To: <CANk7y0jdE-1cVE3UsyQaC2HwZ0TyjPZr=q=c4meYjH27PdUwJg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 31 Dec 2025 08:45:09 -0800
X-Gm-Features: AQt7F2oUVYdTUHBJnJNPownlQHtXUAiVOXivlE7VOt2fXKUZRQ4Y_kT7E6BON2A
Message-ID: <CAADnVQKaqiQP_wYwM8wrhKg4VuMAkQekpY8w0YaRhj+H4af4nw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/7] bpf: Make KF_TRUSTED_ARGS the default for
 all kfuncs
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 4:35=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> On Wed, Dec 31, 2025 at 12:29=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.=
com> wrote:
> >
> > On Wed, 2025-12-31 at 00:08 +0000, Puranjay Mohan wrote:
> >
> > [...]
> >
> > > I wish to do a full review of all kfuncs and make
> > > sure either they are tagged with correct __nullable, __opt annotation
> > > or fixed to make sure they are doing the right thing. But currently I
> > > just made sure all selftests pass, some of the kfuncs might not have
> > > self tests and would need manual analysis and I will have to do that.
> >
> > Ack, sounds like a plan.
> >
> > > Some kfuncs will have breaking changes, I am not sure how to work
> > > around that case, for example css_rstat_updated() could be
> > > successfully called from fentry programs like the selftest fixed in
> > > Patch 7, it worked because css_rstat_updated() doesn't mark the
> > > parameters with KF_TRUSTED_ARGS, but now KF_TRUSTED_ARGS is the
> > > default so this kfunc can't be called from fentry programs as fentry'=
s
> > > parameters are not marked as trusted.
> > >
> > >
> > > Looking at the code of css_rstat_updated() it seems that it assumes
> > > the parameters to be trusted and therefore not allowing it to be
> > > called from fentry would be the right thing to do,
> > > but it could break perfectly working BPF programs.
> >
> > Indeed, it expects 'css' to be not NULL as it dereferences the
> > pointer immediately.
>
> So what do you think is the right way to move forward? it will break
> some programs but for their good. I think correctness and security
> outweigh backwards compatibility.

Fix HID kfuncs, and sched-ext (if needed) and respin.
We're definitely removing KF_TRUSTED_ARGS. That was the plan all along.

