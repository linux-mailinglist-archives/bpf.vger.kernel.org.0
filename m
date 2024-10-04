Return-Path: <bpf+bounces-41033-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E130991309
	for <lists+bpf@lfdr.de>; Sat,  5 Oct 2024 01:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9200D1C22DEC
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 23:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0984C14EC71;
	Fri,  4 Oct 2024 23:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grd3VFgo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E0A231C9A
	for <bpf@vger.kernel.org>; Fri,  4 Oct 2024 23:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728084655; cv=none; b=OpJUS4A6WIgeyeK0EuyaJYsL1yDnXqvJOTV1ZUFzIQ+WKwi6e/AvhaZNkoTzRlviO98MvWJFI70XxN3xaTcUxdBWIHBVpO8slqe53xQXzpgK4t+slWVUiNqfuAt5k9FwvEQ3I7geLroCjz9cFfnHZzz6YjE//mg6P1PrvcmnsOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728084655; c=relaxed/simple;
	bh=SOb/zc2dA1llSeMKNmyFLP1mTx0GSJkP8C83iKwRnCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DBU7uWZbfBSYpIRp7P0YpPuAjy8u+ZTN4u21d/e0dNjBmSF5vzwkZpA3cusqLILuHCGVrqSJYaTtuRKtLOezVwZSuCNiq+v/zSRj3f+qcW0RotSWcgvZrA8cXMcyUUcRMUUB/0RNd5oL5LtGU0eKXnfJquTsS1W+COLIqpRL4Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=grd3VFgo; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cba6cdf32so26606455e9.1
        for <bpf@vger.kernel.org>; Fri, 04 Oct 2024 16:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728084652; x=1728689452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cnLD4cm8CNlsW5Sb/038+vu9ogBwyfFo/+2E/K9LaOE=;
        b=grd3VFgoFas2E/wY1+ztAWRNH8STwiRcWqgEvnonrB6V/YeKPpxBrNr6ec581xpSNx
         Xf0leQB6GFE1WVB/Q8GKT5tR4Oy7Y0qdGH6Mmqa++zn03YjqxOxixpRZyJdtGVzoppnT
         pvoYikObo8DsdpwTLrugRZbavfcErrLdtBUr6ecRpSSZIQ3OgNVcvFpfhkERsw5trYJO
         HnDahZ2Z0VzX5ZAdDtyVsvErpGdsX5KoN8pPC7vlqH2WtXRLy5jiqaY1xi+87Tv9vUZ1
         LV02ssrPrVobgV+UUfppuxvVqzhfvDmJIDWR2MZJAmRisj5jXvOxoJj9hHsR8HNrdQrX
         g1XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728084652; x=1728689452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cnLD4cm8CNlsW5Sb/038+vu9ogBwyfFo/+2E/K9LaOE=;
        b=XGPkqtzGgGSN/O0yiH4t5iNmR9nZRDiMOHE0dMoq3g0H+PhIuu9zX2X4Nvh7sOgWQ+
         GOlJTFQLyOn1BiaumMMOpR1fwZQs5JHeoYHvUXN7654e+K/2sXyZtN9ObFyra+/tbKG0
         iI+XrcDi8vI/vy8e66SWkdajppHlElrODSwo87T8DjrpqagBEqgjbpcXGzI+vxBnECb5
         V71FrVXYY1k1UfZnmA06crEGYzdo2N+hFbOHLREhwZYfytKqwdy9o1zs67u0zPObsEKC
         vpf8MXxFhdOkTgxEv2FF1YuqNUg5CEPauKJ1wWGJ7WeR7KG1MGp28/t51y2T4aFyw7wK
         QAMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWIIDo8VqD6j3mjfN8UXhci4CB0zLKGZPQcAbcTzWrHiM9GJsoFcCtlahtUJKfQjsjTYE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5kTKL6sF+eA43x0syLGOhP5jyllZMUajJl9GNCohQMTV74Vrh
	qMBk6j7ajvLJJsYOVXlxw3OalCBkzodbPm1VghEU1kR5tlqmGx4eByYu0ZHhAa6ft/iqzBZNZzU
	KO5bqtr4XzjI53VHqc1IjjZm4H9tnztx5
X-Google-Smtp-Source: AGHT+IFaPQIvqCOkjyZRU692susvHBgUPatYvlOoracHR5gk0xT/EG8euwxe36InG8gfXTXCcGq6MJ6U7TvvONYeGvE=
X-Received: by 2002:a05:600c:1ca4:b0:42c:b995:20d3 with SMTP id
 5b1f17b1804b1-42f85ae9d41mr37451105e9.26.1728084652040; Fri, 04 Oct 2024
 16:30:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240929132757.79826-1-leon.hwang@linux.dev> <20240929132757.79826-3-leon.hwang@linux.dev>
 <378aa2d5-6359-4e89-a228-7ea47ba563c3@gmail.com> <CAADnVQL_VUJCFH6TuHMLesafY8iQ-4xBkiTdfEMqr02C_G6T=w@mail.gmail.com>
 <3d2ba1d054d73c53b205559ad5d89cef78d89303.camel@gmail.com>
In-Reply-To: <3d2ba1d054d73c53b205559ad5d89cef78d89303.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 4 Oct 2024 16:30:40 -0700
Message-ID: <CAADnVQKaUZofEkUBU=mDEWmPYOYLBmWUiKOqBnfd0Qq2x7wpCA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/4] bpf: Prevent extending tail callee prog
 with freplace prog
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Leon Hwang <hffilwlqm@gmail.com>, Leon Hwang <leon.hwang@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 1:52=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Fri, 2024-10-04 at 12:33 -0700, Alexei Starovoitov wrote:
>
> [...]
>
> > btw the whole thing can be done with a single atomic64_t:
> > - set it to 1 at the start then
> >
> > - prog_fd_array_get_ptr() will do
> > atomic64_inc_not_zero
> >
> > - prog_fd_array_put_ptr() will do
> > atomic64_add_unless(,-1, 1)
> >
> > - freplace attach will do
> > cmpxchg(,1,0)
> >
> > so 1 - initial state
> > 2,3,.. - prog in prog_array
> > 0 - prog was extended.
> >
> > If =3D=3D 0 -> cannot add to prog_array
> > if > 1 -> cannot freplace.
>
> I think this should work, because we no longer need to jungle two values.
> I kinda like it.

It's a bit too clever.

With mutex it's much easier to reason about:

struct bpf_prog_aux {
   mutex ext_mutex;
   bool is_extended;
   u64 prog_array_member_cnt;
};

freplace link on tgt_prog:
guard(mutex)(&aux->ext_mutex);
if (aux->prog_array_member_cnt) {
  // reject freplace
} else {
  aux->is_extended =3D true;
}

freplace unlink:
guard(mutex)(&aux->ext_mutex);
aux->is_extended =3D false;

and similar in prog_fd_array_get_ptr():
guard(mutex)(&aux->ext_mutex);
if (aux->is_extended) {
   // reject adding to prog_array
} else {
  aux->prog_array_member_cnt++;
}

in prog_fd_array_put_ptr():
guard(mutex)(&aux->ext_mutex);
aux->prog_array_member_cnt--;

