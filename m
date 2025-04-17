Return-Path: <bpf+bounces-56158-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EBAA92BF5
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 21:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DF003B44F2
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 19:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F179620408A;
	Thu, 17 Apr 2025 19:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AevgiW3r"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CF31FFC49
	for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 19:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744919572; cv=none; b=PIVVhD2Ki8s48POrwN42fds/RN3rdfHTRleNWlE/m5uftgP5xUl+IolrMYwmca2GC1M9KWDmtaSpiOCiHKx58eusZmbfi16wg/egFjtxNnllGCivTUrAjjseG4/pwi6Mog2ee9nfEbuIzK5yLGQ92QfnGQMq4KiHRjC7AmkNVOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744919572; c=relaxed/simple;
	bh=dM3d4D46buKU22HT0tc/QcHQJ737fw2FBD5xyj9APcc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jUJjq1bvmpRSV7fe3DoWo5y2OjE0C75waBso2B8pI7cJJwwrEJBzX4bWk5vvpA8GBLs6KHmNsZD1/PcJ25CABT31F6fjzVqSuzrG09eIHPQi11jxeUPY5dwTBP/w8YBqlr0yUusmJy8mk+gC0+KNSbA/SgNhOHh5939CcrYUHJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AevgiW3r; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-ac339f53df9so216993966b.1
        for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 12:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744919569; x=1745524369; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uK3PwfAY2wk2or4DPAQVjFLOr5767gtoTw6TDx/Wvgg=;
        b=AevgiW3rxNGm1lJReB2foJoWMLimv90dIfgYk317Bex7BDIdfg8wqVC44818M8Qi95
         kGOhJ5oW3BIqn7v8xofR1x3dusICemjqu4FdVuquuMaQQsq3uFCPhU9l27yDhX3kHIYu
         etfP6J3MyoXNXgQlNn1hw0qHegAMN3d8P7vpWV1tjRfUcS8YVGtKptoH3HceVrSIXj0h
         amc1O0p3q2KUUisevmFOD4wV2qh2j2NrTa+kia4eoFtOClh2Owe3yYEbwx8qMdTEeyeM
         BTp4IsbpYQ9Jmh2umzJSASbA34ljosgqSRTKErS7ZAYow2bPxDSCZsKz1r+7mluhpOCj
         rVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744919569; x=1745524369;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uK3PwfAY2wk2or4DPAQVjFLOr5767gtoTw6TDx/Wvgg=;
        b=Koftq9CaAKzBkBEiwLJI+96MnTE3QBBwDa+kW/Pbjmb1cg5rKDVltepH0H0bg3qui9
         IZOQyQu4o+4JssaX2/YyXvrBvSxxJpDGJxMtSvIp4T5k7rEB8KzcivGxiOgHwTDUV6FF
         aNhQVfS5iLEHMwlqBrpUtXgXNT84Jd0PLos6GBEHjd6oD0pc44MhD1DYcTcpVI6QkyDK
         DU/K47RuENo3kTOhmzBU7fwJ8dHpiB1opBtidrp/N+rRulbxcgzGR4JyIaK3M1uj64QY
         Xl+OMBx6qCXIdkk7fFyaokoS7bXsZiJRHFEfYqNZ6C0b6D28ps76HJUbmjXq3Nbr+BXJ
         GGqg==
X-Gm-Message-State: AOJu0Yxf7jUM7odpSsP84NXgR/shMlajZgr5Jsuv7t9t8aDsP8iz4CMJ
	bRnyCQRdgdcioVOlMxhhGvrUFyIHTRLeVKkyBzNLqSr9DMBe0v+NyKNgeGz4mgb2d2Lbmx7+CT4
	PFsbaZKkSluBD50twEKToYVzVYwo=
X-Gm-Gg: ASbGncsrho5Q5U8EGUGfX9sO0x4Xnv6wspQV7EH8jgoKKGxNlQP9aE9ULr8XSyWweqi
	Z3pRpznfIAGvRRhXaq3aY2/CQ588OrHhNojm6vfpgwbkuwna8EZZVnqnAIkurILT9WL3eRa/Iwf
	d9iyeUWgBws84ZttcU3W6pxV0dR9cuOQY/aj3aqyRDcY3oUwDJrXewMA==
X-Google-Smtp-Source: AGHT+IFpF1zp8m0beQBWnGtHVMPUyIPNhKv5mEk5lvzIGMjocFwLohEABHtdbYj21ZsygSGR+w6EM+MUmsbzifmVHqE=
X-Received: by 2002:a17:907:d8a:b0:ac6:b729:9285 with SMTP id
 a640c23a62f3a-acb74e2f9b1mr6590666b.55.1744919568855; Thu, 17 Apr 2025
 12:52:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414161443.1146103-1-memxor@gmail.com> <20250414161443.1146103-2-memxor@gmail.com>
 <m234e8wt3a.fsf@gmail.com>
In-Reply-To: <m234e8wt3a.fsf@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 17 Apr 2025 21:52:12 +0200
X-Gm-Features: ATxdqUGxjUDoojTluehskX956feO6q_6GLEDQi79Kb6vPp5EVn2MRU-Q_3JdzGE
Message-ID: <CAP01T77Lh2Vv3+qjuQfU+YBf0sGLpYS8ygaL=yrcRea28vR52Q@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next/net v1 01/13] bpf: Tie dynptrs to referenced
 source objects
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Amery Hung <ameryhung@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 Apr 2025 at 07:53, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
>
> [...]
>
> > @@ -818,22 +819,19 @@ static void invalidate_dynptr(struct bpf_verifier_env *env, struct bpf_func_stat
> >       state->stack[spi - 1].spilled_ptr.live |= REG_LIVE_WRITTEN;
> >  }
> >
> > -static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
> > +static int __unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_func_state *state,
> > +                                    int spi, bool slice)
> >  {
> > -     struct bpf_func_state *state = func(env, reg);
> > -     int spi, ref_obj_id, i;
> > +     u32 ref_obj_id;
> > +     int i;
> >
> > -     spi = dynptr_get_spi(env, reg);
> > -     if (spi < 0)
> > -             return spi;
> > +     ref_obj_id = state->stack[spi].spilled_ptr.ref_obj_id;
> >
> > -     if (!dynptr_type_refcounted(state->stack[spi].spilled_ptr.dynptr.type)) {
> > +     if (!dynptr_type_refcounted(state->stack[spi].spilled_ptr.dynptr.type) && !ref_obj_id) {
>
> If dynptr_type_refcounted is true, does this mean that ref_obj_id is set?
> If it does, the check could be simplified to just `if (!ref_obj_id)`.

Yes, I will change in non-RFC v1.

>
> >               invalidate_dynptr(env, state, spi);
> >               return 0;
> >       }
> >
> > -     ref_obj_id = state->stack[spi].spilled_ptr.ref_obj_id;
> > -
> >       /* If the dynptr has a ref_obj_id, then we need to invalidate
> >        * two things:
> >        *
>
> [...]

