Return-Path: <bpf+bounces-22187-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EECAE858840
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 22:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E0831F21D83
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 21:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87E61468F6;
	Fri, 16 Feb 2024 21:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vw3xZPLL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C121D69A
	for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 21:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708120363; cv=none; b=tOwyk4lu3UFW0BkD4dHVVZb9mbdWHoVUu6d+SkAyKWIj5lATyuGTMgu4Z77V4BoP6O3OD6et3UdWwZ6U2OFBB+RDca6koUR38v5oQ7KMwH6z0kNWGlUydxf/YqWHzuBu5vB1QYXgoKX2Y+Rde3FLNrjdM7CwkwbvXR1/yPy24Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708120363; c=relaxed/simple;
	bh=EbSPtbmwX/bze1qZpTtU1HI6bKvCONem6tEIpDUng5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kun0ELJQJMw671al5ZlmQE1aBCkzfkRCW3JefhpfYs+EiRSvQoGjzKO8rglcnVhLh+kmg05QXlxFae7BxcxYv57iMVE3hCPwt8fJb7ryaYGzWetTEpuLB55EtzSPrvS1mPbGgz0HklwkMdUvrrkP+XyTcduGkQx7d4sakp5EqyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vw3xZPLL; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-a2f79e79f0cso376432566b.2
        for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 13:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708120360; x=1708725160; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xgBZ9kbesLU6xAxhKrucivEtZzSSknCHMJdfRqXcZxg=;
        b=Vw3xZPLLryZf0Hu/UJJkHZVAnH4XevTgcX2UVohYPc8ODO0q16zh29PA4d8sC37sjT
         QVCe153vk1OT8bei/qoChVTogD9c7J+dX5oFySmmgwVW622bqryRjrQX+9E5Y/0H05+K
         YgSQX6aqO9vHWDTJ3G6uvHTRoBG4pykjBgyMnOZxji1CoSKlm7NKbTrjpp/YV3DBmf+3
         3XlB40RRGXdV94L6TS5lFR0nZvmfm84rqH6HfWnN3zk95oRu0t+WHtFJNOpUBApw96vM
         w3v42yz3PrXvMojxu9iiHsNVAHa2jENmFaLnv291OQaIrdVnORxAsGbOt2KP5mm3KaJ1
         teDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708120360; x=1708725160;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xgBZ9kbesLU6xAxhKrucivEtZzSSknCHMJdfRqXcZxg=;
        b=B2z4YKEKvvprSegGm9c7DsVME7FsCpH39U1JOwU/Km1F+Oe3lR02XI5JhBMUVjeCpW
         F1yr3YmidQcMd83O/a0zwWTEAlCnzWxm/Fd3oJW9o2bpXA1fydGsCw3Z6fsLfDPkZtDJ
         a2yFdq4TgjKWNRSD2N4hZFbQiew5YbQZunqea8Bcgg+pccAD+JDviFWdcTRKh+g9B5wV
         RMXr51KoD6a5PR9z69z2JY3e7x/ueu6RQG+KORQNfiZEYELaQOWuJtgeXOjh4MwbHZXG
         GkmUcycc93WgJUAw89ibjsUb7Dzv60V46XJZf84i+u5hN20pEbj8EfSsx13Xw4YMd6Fv
         tA5g==
X-Gm-Message-State: AOJu0YxpVo/mPAs6e/+B9tcxglYMek9ewBwFyTVjJMyzvSFxLKmbrMQq
	A8bzOzSNk+bL9KKvQxSqjOF2h8jts6CvbOoKGIEZ160TlMxZk3rEUe3ksMTsyj4+HVhmhXfe1uq
	xhSCIMJoCa/ATVSqZZ9cQ69vZaDQ=
X-Google-Smtp-Source: AGHT+IHnPoLNkxGhDoa6CRrXboYUIeKooGFahMPeW2x65P+LrCRpwTZLoohncW5B7g2/b00IlPkvTCTLJ7q8VuZQTBA=
X-Received: by 2002:a17:906:d78a:b0:a3d:4036:4543 with SMTP id
 pj10-20020a170906d78a00b00a3d40364543mr4626036ejb.51.1708120359765; Fri, 16
 Feb 2024 13:52:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201042109.1150490-1-memxor@gmail.com> <20240201042109.1150490-7-memxor@gmail.com>
 <8cb6e0ffa4810396ef618bfc92449dfd54d47043.camel@gmail.com>
In-Reply-To: <8cb6e0ffa4810396ef618bfc92449dfd54d47043.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 16 Feb 2024 22:52:03 +0100
Message-ID: <CAP01T77+q_72KjRBB31DX+QWG3qHPsOrj_z=ihXJcAV=O=M2rQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 06/14] bpf: Adjust frame descriptor pc on
 instruction patching
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, David Vernet <void@manifault.com>, Tejun Heo <tj@kernel.org>, 
	Raj Sahu <rjsu26@vt.edu>, Dan Williams <djwillia@vt.edu>, Rishabh Iyer <rishabh.iyer@epfl.ch>, 
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Feb 2024 at 17:31, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Thu, 2024-02-01 at 04:21 +0000, Kumar Kartikeya Dwivedi wrote:
>
> [...]
>
> > +static int adjust_subprog_frame_descs_after_remove(struct bpf_verifier_env *env, u32 off, u32 cnt)
> > +{
> > +     for (int i = 0; i < env->subprog_cnt; i++) {
> > +             struct bpf_exception_frame_desc_tab *fdtab = subprog_info(env, i)->fdtab;
> > +
> > +             if (!fdtab)
> > +                     continue;
> > +             for (int j = 0; j < fdtab->cnt; j++) {
> > +                     /* Part of a subprog_info whose instructions were removed partially, but the fdtab remained. */
> > +                     if (fdtab->desc[j]->pc >= off && fdtab->desc[j]->pc < off + cnt) {
> > +                             void *p = fdtab->desc[j];
> > +                             if (j < fdtab->cnt - 1)
> > +                                     memmove(fdtab->desc + j, fdtab->desc + j + 1, sizeof(fdtab->desc[0]) * (fdtab->cnt - j - 1));
> > +                             kfree(p);
>
> Is it necessary to release btf references for desc entries that are removed?
> Those that were grabbed by add_used_btf() in gen_exception_frame_desc_iter_entry().
>

I think these btf pointers are just a view, the real owner is in
the used_btfs array, in case of failure, it is dropped as part of
bpf_verifier_env cleanup, or in case of success, transferred to
bpf_prog struct and released on bpf_prog cleanup.
So I think it should be ok, but I will recheck again.

> [...]

