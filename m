Return-Path: <bpf+bounces-57149-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B64B3AA64D2
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 22:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD5B49A67FB
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 20:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3F3251782;
	Thu,  1 May 2025 20:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L39/Degz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC25B674;
	Thu,  1 May 2025 20:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746131857; cv=none; b=msu/HsDxk1OpIcgDrV86hdcqarG1EW8tAWyksdNzUE7qulr7fJh+w6GhfEqsspEQUbxZa4cLvEzFqIJw4W7GWvB03BYiLssbANCgP88KLZq/2Uof5o1MBQXsxOyCZGuoim+vi0lFG/QutDPMJYxeYI4gLIMd44HnWi/D9sDIU1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746131857; c=relaxed/simple;
	bh=L/LIpFW3antBpbfi731c4Gfo1KH87MWLWTIGTfKQfhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eauovlAi6bOJwjQKDgmYbR6dflficaUmaAxgcjoznihOKirLBtI973cuMWxshwA39wVipgHsB0I7vWW3DaQShKAizBp/Yf9vrpOmYoYGpWI5k2AwrOxZFMdpfFXwAkkqI8CmmqO16dbaFexZG3WmPPABMxNbD+OQf4zJf/V0fKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L39/Degz; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-227c7e57da2so13020515ad.0;
        Thu, 01 May 2025 13:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746131855; x=1746736655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E8skB8WeVm57NEFs/qjIcRf3ilTMUq5Oyzva7gTT2r0=;
        b=L39/DegzKpdojDreICO9ZMpwzmfUOlpxgB6XO4ZJUfbCr/jNItUPUN3tMvUXwwTFLe
         un1d30ENNSckGVGtxgsGC1+2G0+/r1LyLJlqxejHG9hhHCYtlKEQr/vWwjlFXCXLaBQG
         eZBUnXm4OOY005M2RK9B/8Y8DSEsF+U6+pH56Lr1m3uGnZ+jYdu+WHMxZyevdj7IY8m2
         gvmCf8+CW2cJ//juBv41hkmRHfHu8SOMafTIEctxTGd+uf+Y61sgTNlrkuguGGcaD4L8
         llcDMP2EoWX+qgZCswvBiarDHgMdPtZ4YUxBB3N9fhO14hsr5Sm+emGD02KW9x9rJRXS
         fw5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746131855; x=1746736655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E8skB8WeVm57NEFs/qjIcRf3ilTMUq5Oyzva7gTT2r0=;
        b=uGHTXh8i9qVleAEGX4LxcRvxYE57EscGkg2jwfSZ/oZLmFw5kFqnzzsLx/JG2gkvgl
         zbGHDpu6wVHD11Vunn9rUWpnhza8aMgXKubRfAcKExXLU4oMD04vSm9Rok6LigxBCgSU
         o9fKYS4QfFqDktqb7lbG1yD3xl41JxrAoyU9liwknWYp7kWlljAD1kXLXwGsyIW5jWm2
         kfAsONEDd7FfJD1B/VrMN5EIMAdqNgbp8NlNcKVZTVuroMolKJvtsIVI0TEjtT/HGLra
         wiFRUyCMCg0E9wdyAS5FOMHIDBepDFFV8pfhNMtcdtXCtQ2gPeoHqgRcMLUA4QKthelF
         MEhw==
X-Forwarded-Encrypted: i=1; AJvYcCVDiL7sJHOJ7YwnpdIlyr0HkbGJmYeBruFvpqwPqaVUa2WAzFzt2pOYB0ogH5bZ+yd21v/B7/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJfwJALg4ZY7ZlNFL6Ys1rmV/aisjVl7YhTB5FxSWPn249XCLc
	kU/m6v7da3bFuKV2TRbkC3O6cKXP1DgXDlSPEe3IkF1oQ2nCGBqKu5uYlxy7NL2irO+YVoN33o8
	egR67M9X/m5jicd15zKhp3uAzJwA=
X-Gm-Gg: ASbGncvdT/zBNUNDyatGv5qRFl3woHxCV2fBspkmMTQK3BGp0sjk2lPMQR9zEgmTCgj
	GmeDHoaEMy0hTn9E7yiTPD4NTTGOyka2CQRm90oTr/iUl2p7j2VsKACrX/A3FmLpPzYE0DhPnlu
	ycikiKxucd3gaND/Y5RlC+dUDN7wvIYik3n8rPUlMIJEAq6hJe
X-Google-Smtp-Source: AGHT+IHb0CF+t0M6tMcTFU0dUcYjEwLejij2Knj4KQESfUO3PTEpdKTVVSJjHuZvoLH1HUA4DA3JoTkFwOY/C2zCa7k=
X-Received: by 2002:a17:90b:5844:b0:2ff:5714:6a with SMTP id
 98e67ed59e1d1-30a4e5c19bcmr691783a91.19.1746131855201; Thu, 01 May 2025
 13:37:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425214039.2919818-1-ameryhung@gmail.com>
In-Reply-To: <20250425214039.2919818-1-ameryhung@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 1 May 2025 13:37:23 -0700
X-Gm-Features: ATxdqUGdeJ8GnvgcC1CbUNR_FSSJuTbm-kRym7kgMQVKRhRelJirFUVPNTMODew
Message-ID: <CAEf4BzYUNckc9pXcE7BawxWFVfY--p12c3ax8ySP1P+BEww91w@mail.gmail.com>
Subject: Re: [PATCH RFC v3 0/2] Task local data API
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 2:40=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> Hi,
>
> This a respin of uptr KV store. It is renamed to task local data (TLD)
> as the problem statement and the solution have changed, and it now draws
> more similarities to pthread thread-specific data.
>
> * Overview *
>
> This patchset is a continuation of the original UPTR work[0], which aims
> to provide a fast way for user space programs to pass per-task hints to
> sched_ext schedulers. UPTR built the foundation by supporting sharing
> user pages with bpf programs through task local storage maps.
>
> Additionally, sched_ext would like to allow multiple developers to share
> a storage without the need to explicitly agreeing on the layout of it.
> This simplify code base management and makes experimenting easier.
> While a centralized storage layout definition would have worked, the
> friction of synchronizing it across different repos is not desirable.
>
> This patchset contains the user space plumbing so that user space and bpf
> program developers can exchange per-task hints easily through simple
> interfaces.
>
> * Design *
>
> BPF task local data is a simple API for sharing task-specific data
> between user space and bpf programs, where data are refered to using
> string keys. As shown in the following figure, user space programs can
> define a task local data using bpf_tld_type_var(). The data is
> effectively a variable declared with __thread, which every thread owns an
> independent copy and can be directly accessed. On the bpf side, a task
> local data first needs to be initialized for every new task once (e.g.,
> in sched_ext_ops::init_task) using bpf_tld_init_var(). Then, other bpf
> programs can get a pointer to the data using bpf_tld_lookup(). The task
> local data APIs refer to data using string keys so developers
> does not need to deal with addresses of data in a shared storage.
>
>  =E2=94=8C=E2=94=80 Application =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
>  =E2=94=82                          =E2=94=8C=E2=94=80 library A =E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90 =E2=94=82
>  =E2=94=82 bpf_tld_type_var(int, X) =E2=94=82 bpf_tld_type_var(int, Y) =
=E2=94=82 =E2=94=82
>  =E2=94=82                          =E2=94=94=E2=94=AC=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98 =E2=94=
=82
>  =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=82=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
>          =E2=94=82 X =3D 123;          =E2=94=82 Y =3D true;

bpf_tld_type_var() is *defining* variable (i.e., it allocates storage
for it), right? I think for completeness we need also *declare* macro
to access that variable from other compilation units


>          V                   V
>  + =E2=94=80 Task local data =E2=94=80 =E2=94=80 =E2=94=80 =E2=94=80 =E2=
=94=80 =E2=94=80 +
>  | =E2=94=8C=E2=94=80 task_kvs_map =E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=90 |  =E2=94=8C=E2=94=80 sched_ext_ops::init_task =E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
>  | =E2=94=82 BPF Task local storage    =E2=94=82 |  =E2=94=82 bpf_tld_ini=
t_var(&kvs, X);      =E2=94=82
>  | =E2=94=82  =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90    =E2=94=82 |<=
=E2=94=80=E2=94=A4 bpf_tld_init_var(&kvs, Y);      =E2=94=82
>  | =E2=94=82  =E2=94=82 __uptr *udata     =E2=94=82    =E2=94=82 |  =E2=
=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=98
>  | =E2=94=82  =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98    =E2=94=82 |
>  | =E2=94=82  =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90    =E2=94=82 |  =
=E2=94=8C=E2=94=80 Other sched_ext_ops op =E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90
>  | =E2=94=82  =E2=94=82 __uptr *umetadata =E2=94=82    =E2=94=82 |  =E2=
=94=82 int *y;                         =E2=94=9C=E2=94=90
>  | =E2=94=82  =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98    =E2=94=82 |<=
=E2=94=80=E2=94=A4 y =3D bpf_tld_lookup(&kvs, Y, 1); =E2=94=82=E2=94=82
>  | =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98 |  =E2=94=82 if (y)             =
             =E2=94=82=E2=94=82
>  | =E2=94=8C=E2=94=80 task_kvs_off_map =E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90 |  =E2=94=82     /* do som=
ething */          =E2=94=82=E2=94=82
>  | =E2=94=82 BPF Task local storage    =E2=94=82 |  =E2=94=94=E2=94=AC=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98=E2=94=
=82
>  | =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98 |   =E2=94=94=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
>  + =E2=94=80 =E2=94=80 =E2=94=80 =E2=94=80 =E2=94=80 =E2=94=80 =E2=94=80 =
=E2=94=80 =E2=94=80 =E2=94=80 =E2=94=80 =E2=94=80 =E2=94=80 =E2=94=80 =E2=
=94=80 +
>
> * Implementation *
>
> Task local data API hides the memory management from the developers.
> Internally, it shares user data with bpf programs through udata UPTRs.
> Task local data from different compilation units are placed into a
> custom "udata" section by the declaration API, bpf_tld_type_var(), so
> that they are placed together in the memory. User space will need to
> call bpf_tld_thread_init() for every new thread to pin udata pages to
> kernel.
>
> The metadata used to address udata is stored in umetadata UPTR. It is
> generated by constructors inserted by bpf_tld_type_var() and
> bpf_tld_thread_init(). umetadata is an array of 64 metadata corresponding
> to each data, which contains the key and the offset of data in udata.
> During initialization, bpf_tld_init_var() will search umetadata for
> a matching key and cache its offset in task_kvs_off_map. Later,
> bpf_tld_lookup() will use the cached offset to retreive a pointer to
> udata.
>
> * Limitation *
>
> Currently, it is assumed all key-value pairs are known as a program
> starts. All compilation units using task local data should be statically
> linked together so that values are all placed together in a udata section
> and therefore can be shared with bpf through two UPTRs. The next

Lack of support for shared libraries is a big limitation, IMO, so I
think we should design for that support from the very beginning.

FWIW, I think this compile-time static __thread variable definitions
are unnecessarily limiting and add a non-trivial amount of complexity.
I think it's more reasonable to go with a more dynamic approach, and
I'll try to outline what an API (and some implementation details)
might look like.

Note, all this is related to the user-space side of things. BPF-side
is unchanged, effectively, except you get a guarantee that all the
data will definitely be page-aligned, so you won't need to do these
two uptr pages handling.

First, data structures. You'll have one per-process metadata structure
describing known keys and their assigned "offsets":

struct tld_metadata {
    int cnt;
    char keys[MAX_KEY_CNT];
    __u16 offs[MAX_KEY_CNT];
    __u16 szs[MAX_KEY_CNT];
};

Now, each thread will basically have just a blob of data, so,
technically, per-thread we will just have:

struct tld_data {
    __u8 data[PAGE_SIZE];
};

By pre-allocating the entire page we avoid lots of complications, so I
think it's worth doing.

Now, we really need just two APIs on user-space (and I'll use the
"opaque offset" type as I suggested on another patch):

typedef struct { int off; } tld_off_t;

tld_off_t tld_add_key_def(const char *key_name, size_t key_size);

This API can be called just once per each key that process cares
about. And this can be done at any point, really, very dynamically.
The implementation will:
  - (just once per process) open pinned BPF map, remember its FD;
  - (just once) allocate struct tld_metadata, unless we define it as
pre-allocated global variable;
  - (locklessly) check if key_name is already in tld_metadata, if yes
- return already assigned offset;
  - (locklessly) if not, add this key and assign it offset that is
offs[cnt - 1] + szs[cnt - 1] (i.e., we just tightly pack all the
values (though we should take care of alignment requirements, of
course);
  - return newly assigned offset;

Now, the second essential API is called for each participating thread
for each different key. And again, this is all very dynamic. It's
possible that some threads won't use any of this TLD stuff, in which
case there will be no overhead (memory or CPU), and not even an entry
in task local storage map for that thread. So, API:

void *tld_resolve_key(tld_off_t key_off);

This API will:
   - (just once per thread, which is done trivially by using
__thread-local global variable to keep track of this) allocate struct
tld_data dynamically (with page alignment, alloc_aligned(PAGE_SIZE,
PAGE_SIZE))
   - (just once per thread as well) bpf_map_update_elem() for current
thread, updating two uptrs: one pointing to global tld_metadata,
another pointing to thread-local tld_data;
   - return tld_data->data + key_off.off;

That is, this API returns an absolute memory address of a value
resolved in the context of the current thread.


And let's look at how one can make use of this on the user-space side
to optimally use this API.


/* global variables */
tld_off_t my_key1_off; /* struct my_val */
tld_off_t my_key2_off; /* int */

__thread struct my_val *my_val1;
__thread int *my_val2;

... somewhere in constructor ...

my_key1_off =3D tld_add_key_def("my_key1", sizeof(struct my_val));
my_key2_off =3D tld_add_key_def("my_key2", sizeof(int));

... and then somewhere in the code that makes use of TLD stuff ...

if (!my_val1) /* this can be initialized once per thread to avoid this
check (or hidden in a helper accessor function) */
    my_val1 =3D tld_resolve(my_key1_off);

my_val1->blah_field =3D 123;

if (!my_val2)
   my_val2 =3D tld_resolve(my_key2_off);
*my_val2 =3D 567;


That's pretty much it, I think.

In C++ code base, it should be possible to make this even more
convenient by using a templated wrapper with thread-local inner
variable with its own constructor. Adding operator overloading (e.g.,
operator=3D and operator->) you get a very naturally looking definition
and access patterns:

/* global data */

tld_variable<struct my_val> my_val1("my_key1");
tld_variable<int> my_val2("my_key2");

... now in the actual TLD-using code, we just do:

my_val1->blah_field =3D 123;
my_val2 =3D 567; /* I think C++ would allow this with operator overloading =
*/

I hope the example explains why it's still fast despite everything
being dynamic. There is a pointer indirection and that page-sized
allocation (so that we can cache thread-specific resolved pointers),
but it seems absolutely fine from performance perspective.

> iteration will explore how bpf task local data can work in dynamic
> libraries. Maybe more udata UPTRs will be added to pin page of TLS
> of dynamically loaded modules. Or maybe it will allocate memory for data
> instead of relying on __thread, and change how user space interact with
> task local data slightly. The later approach can also save some troubles
> dealing with the restriction of UPTR.
>
> Some other limitations:
>  - Total task local data cannot exceed a page
>  - Only support 64 task local data
>  - Some memory waste for data whose size is not power of two
>    due to UPTR limitation
>
> [0] https://lore.kernel.org/bpf/20241023234759.860539-1-martin.lau@linux.=
dev/
>
>
> Amery Hung (2):
>   selftests/bpf: Introduce task local data
>   selftests/bpf: Test basic workflow of task local data
>
>  .../bpf/prog_tests/task_local_data.c          | 159 +++++++++++++++
>  .../bpf/prog_tests/task_local_data.h          |  58 ++++++
>  .../bpf/prog_tests/test_task_local_data.c     | 156 +++++++++++++++
>  .../selftests/bpf/progs/task_local_data.h     | 181 ++++++++++++++++++
>  .../bpf/progs/test_task_local_data_basic.c    |  78 ++++++++
>  .../selftests/bpf/task_local_data_common.h    |  49 +++++
>  6 files changed, 681 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/task_local_dat=
a.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/task_local_dat=
a.h
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_task_loca=
l_data.c
>  create mode 100644 tools/testing/selftests/bpf/progs/task_local_data.h
>  create mode 100644 tools/testing/selftests/bpf/progs/test_task_local_dat=
a_basic.c
>  create mode 100644 tools/testing/selftests/bpf/task_local_data_common.h
>
> --
> 2.47.1
>

