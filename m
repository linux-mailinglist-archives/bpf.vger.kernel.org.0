Return-Path: <bpf+bounces-58123-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F66AB57C4
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 16:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CC118602FF
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 14:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722081C8632;
	Tue, 13 May 2025 14:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KawTisIz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FC213CA97
	for <bpf@vger.kernel.org>; Tue, 13 May 2025 14:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747148321; cv=none; b=clVL4cxicidwUSLRiPS0AKvYKwx2JwZssRh5sRY0j5RhcHMVnPZH088KFnkM3n+7kiZzQnggvocQxsHiLRh3m+AkCuRdk2IaE8Xv+kkikF/6wE+ZJsPHW6Gjpoe+nS/ciDyDtZAjKnC8h4q9iSc4myRKQDyM8kTYyq91v7We6pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747148321; c=relaxed/simple;
	bh=3ZSCHIdRTkfSmA/uGcDcHNNBNC/SrFRrFW9tRksq1PM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SxtFfQz7fqZiKYDMNjUJp6ZlLcCEXzh8z+pX4VWIqfuVKKmZVM5LtbRo1AWt1OJRR33S8NR77DwxYnwpJ2WfAMZjVF5Wc0hGjlHueJTAPD/mtop2UX0C5H+3feqjV0XBECpsFeCPfMieYq05sf8a8eEqfo4hlLwosxqkPfASavs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KawTisIz; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a1f9791a4dso2453823f8f.0
        for <bpf@vger.kernel.org>; Tue, 13 May 2025 07:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747148318; x=1747753118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3z0RoafmXhnBe1HCRXo0YItnKxgva5rLQCfX+hjji/4=;
        b=KawTisIzsmzvDapi3JwzqgN/Qphk+8U5weJXhsXTluhqkCISEj41Lrh93lBqXRfQhz
         FZq7zrmWrDS87bdwko9avLf69aWZi1I3Ndm4Q109HUqn771S0T4hUay5XNn/F1YJntNr
         vPbUsASTs0L3ROm9uLJeHgixpir+VFoRnnWS3+XnHv9sNEyncV9Rc4YeVkoE+QafM+Ts
         TPUtRpoogRp/E6/QxiDwkh+3PLMvxFIXRnsVIvZ5r1P5umJkV+2dxsCoO1/ZveDYLLrt
         OWDOg9CQZc0I/nZiXZNcExqYGJLr0+G0dlcfPqOCz/2QEd68BPc9X9idhqc+3hgGNIHK
         kMdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747148318; x=1747753118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3z0RoafmXhnBe1HCRXo0YItnKxgva5rLQCfX+hjji/4=;
        b=JzEEJWhvAMkwp5AzFEU58Az2/YJ24uK5UPJsVqxG+ZwhCi7Ws6qKD1qVBA4IKLZ2c4
         +8Wo6Z9MUb4ac22fwRx29703FhGD/T4KnUZNTUFY4MfjKFt/xjo8U4e7Y2dHRbExpxcO
         +h+uzqF+XqUbvKUqhJavDRLCTRg/AGL2MvXCxhUQJwiFiXF0iDgkE0//MQMhMYLNLIJ4
         gW6im9Z+PnJU4CagT3xm2ogcVlfuM80+5cm8dLyyqLkJUBmik0O0HgoA1zQdcQ45DxzN
         kTXibZSSqLMgriOV01tgaDqELPTDNN8hWnV4dzQpTZOeRj74clyUVtcBJyfyFzPSDCmf
         kn+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXWOoUk5ABcXEHnrtIpzlKSfgmuBaKUSxJ6d0H9gKgfG2gs+IEZaAZwhyJyzphb3ami/68=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMOERiq6AS+qT9v5rEjg3EGa2/nyFSekUrnHMFx02yL985+T8l
	OfaxX3Dy1YDdrUx7cA3tvB0n0oC92caYLFFtHutGqJGTz2lHZnEzFS7vBoU/ljCF5+JbL7uUoMj
	Q77cDjRifxmbu/WsJSPjOK9u1EFk=
X-Gm-Gg: ASbGncuBqp6m2h/cosbqCyeQajnSwtrWm21o9qdpXr0dapN8rr/k10vndjiFgvLpaIJ
	QarVC7Iftn0q7HfO9JjuDY15nSCPbBify6cIIqawFTSM5MVsAYslIpZEshie/iOdLluMSUA5rfJ
	pMrFU+LmCjjAs5SmP/lfq2SHSALrT9bdewt+PmtrUzSdSxsKl95HAsGD1yDx4=
X-Google-Smtp-Source: AGHT+IFuEmYyii+aG+mGy3pmLK3dIwWxRkEEmLOvpXmg5eGwcL6H2tROQJUkrZDyz59gI8Mo/U72gzlda6jy/7v1zz8=
X-Received: by 2002:a05:6000:1449:b0:3a0:8442:2c48 with SMTP id
 ffacd0b85a97d-3a1f64a48ecmr11571972f8f.44.1747148317750; Tue, 13 May 2025
 07:58:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1746598898.git.vmalik@redhat.com> <1497b70f2a948fe29559c6bfb03551a7cc8638f1.1746598898.git.vmalik@redhat.com>
 <aBx0qmVvL84Jb3rf@google.com> <CAADnVQJD3dQfuT2ExXL5iGeVj0TJ9L5KWGovmsSz5giKft4ryQ@mail.gmail.com>
 <aCLrK_QBMVWCy4bo@google.com> <e6b8ebc8-7b55-4bbf-a5ac-04445b46325d@redhat.com>
In-Reply-To: <e6b8ebc8-7b55-4bbf-a5ac-04445b46325d@redhat.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 13 May 2025 07:58:26 -0700
X-Gm-Features: AX0GCFtJWaZ_jQYTCGIRLNJo81-f1eeqPmkbxr3QD7kEPb4pAUvYcjSLxoVNGHA
Message-ID: <CAADnVQLg4BJ_mBJVKSM1sTNHiySeVOgk3o7R6VADzidzGWJr8A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/4] bpf: Teach vefier to handle const ptrs as
 args to kfuncs
To: Viktor Malik <vmalik@redhat.com>
Cc: Matt Bobrowski <mattbobrowski@google.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 12:54=E2=80=AFAM Viktor Malik <vmalik@redhat.com> w=
rote:
>
> On 5/13/25 08:48, Matt Bobrowski wrote:
> > On Fri, May 09, 2025 at 09:20:53AM -0700, Alexei Starovoitov wrote:
> >> On Thu, May 8, 2025 at 2:09=E2=80=AFAM Matt Bobrowski <mattbobrowski@g=
oogle.com> wrote:
> >>>
> >>>>
> >>>>  static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_r=
eg_state *reg,
> >>>> -                      u32 regno, u32 mem_size)
> >>>> +                      u32 regno, u32 mem_size, bool read_only)
> >>>
> >>> Maybe s/read_only/write_mem_access?
> >>
> >> 'bool' arguments are not readable at the callsite.
> >> Let's use enum bpf_access_type BPF_READ|WRITE here
> >> or introduce another enum ?
> >
> > Yes, I agree, and using enum bpf_access_type is also something that
> > had crossed my mind. I think that's what should be used here in favour
> > of the boolean.
>
> Reusing bpf_access_type feels like the right thing here, however, it is
> missing an option for read/write access. Should we introduce a new
> BPF_READ_WRITE enum value? Or assume that BPF_WRITE should also perform
> the BPF_READ check? Or make this argument an int and pass
> `BPF_READ | BPF_WRITE`?

I think most, if not all, other places in the verifier
assume that BPF_WRITE also means that read has to work.
So I don't see a need for new enum values.

