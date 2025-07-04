Return-Path: <bpf+bounces-62433-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFD5AF9AEA
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 20:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC1603ABD26
	for <lists+bpf@lfdr.de>; Fri,  4 Jul 2025 18:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC061DE4DC;
	Fri,  4 Jul 2025 18:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLoAtK/x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24182E36EB
	for <bpf@vger.kernel.org>; Fri,  4 Jul 2025 18:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751655094; cv=none; b=ndu9OcmqBo6v4rcAqrZKVl4tI/v8CCkBKU2zCYrjejDN4bAkTXDN++exFTzw+Ay/SUqcliksJ4cXrquI5ReWXE6KLMzfDA2ocOaqt5ugENtTDJXYjUpq2UXlTp8uAdierc7Y9p/632m6QKbnsPzFUSwTMtCg0i1NQH1ksuKouYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751655094; c=relaxed/simple;
	bh=zLQu8Prscr7G4/CtcRY6/lolFG92GGZcNkS7gxgHl4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AL29oSl2Okxayb4obxopmbjVO6Y28o1M7gFvcTOvwiXk1BMDbzDhmgNIhEh/yxxHgWbViTt7vUMtNPkqTTndiLReqn28znjagBNlU5AM2tGeAXV+AKKWF+F7bRYC8t6MthncjteXUNzHBEwbLahjp4G70yNG+lnvrpwXqn4EJ04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLoAtK/x; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-ade5b8aab41so241742466b.0
        for <bpf@vger.kernel.org>; Fri, 04 Jul 2025 11:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751655090; x=1752259890; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/8e7VJX4tlXOJseCzZHPXBNtcAJmKE/D4m/ZHXHma1g=;
        b=ZLoAtK/xzcWvzkKTrcYPl+R3sQu0oKaVc5Lg5EK/YUXCgGxBn5LhzsmksFPysQZDd0
         7kryzCaFrbywc24C9GBDx5Ynrts4xEhayKzlRhwFKRqJB48Fz6EVhXNIeBnFJJRWv8d1
         pD0FPLTPH6GnOtK/WW3tMoQgUVQOj15Z0HEBXbk0ijgMgUO5oG4rfjHbBGBnBUdJHAZD
         ARc0RvfhnSfoFoLX8i9zCWwkQrY6/fc9FSb0Q0wBlqHr91aWXJXPODOywo4ZK4SHsCkI
         C+ZJmRo5nqBwfp31NfIeNSejoaJEJl2d4qIDqUvAbabkYhXMq6SC0Dr1j/4qDX/9JJRW
         /qqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751655090; x=1752259890;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/8e7VJX4tlXOJseCzZHPXBNtcAJmKE/D4m/ZHXHma1g=;
        b=uprwdjLSoBLlxnRuACD/0wHTk5auXgIaYEozZ0z8kJ6Jud5WxbMrX3v8zxhZmSZLFA
         sRVqKuMOsRCGHjgLqLZOsN5My71ajPQDBmYNPNtXIgrr+57LLIhrimlE/6QnAcdiIInc
         54xsjBll59UCNmjEktUH2+mhA4OlqZ58XHcjTYSzsfLA9DEQqsrMfr+Tm6LL3LiImZC3
         YYctUXViXF08djTp9XbSLD3wqApgCN2vDi2uNfFV5RH4UxJlRZj6wL7KChQEhhR/E2H0
         QLXE58zW2jzkAowPUFVXYmtPQEQxX33ZhyIAGSUi4E8OWdRCW8/PG2tTu/bweyKxlRCt
         zLuQ==
X-Gm-Message-State: AOJu0Yzh1hrkADg6GvfbYVoP/seEkBUy73bVSrijNSVM5Y1HnM84W6Uz
	E7vOV2v32WzcNUPNnMMOx3/g9tdZN3l+xDF5NueWM8tbw6UmMeKeVfQWTriUFIDxTtOuR3L6lFo
	Upn59pdH8V9ecQlAcTZg9oe66L/IvZQg=
X-Gm-Gg: ASbGnctyHnypf4zQG69nOb/+3keYvp9UZNdaXw/q9EmPwbSl9adYvDdHKDlQ/clOK48
	9Ww3KlvHS+GdK10tO+4vvpcbgD91AuFF3sWUN7rhpWlrSVIHVRFgSDqgJUhhN/y1NHivynuz8iV
	sdEP3ECBL6qeo7z4QVQf1VPHAfITJorSze5WCSg1EUjAiIWlId9HTmZZ38mEGGgNgME8QVW71dZ
	wg=
X-Google-Smtp-Source: AGHT+IEoQl9zzO79cWGlLC25LgiwTgtmXitmFBjcoM/BJ2W3zURreLTsCo+PFGuvf17nMzVTFo9htyqnGnk22LsBpUI=
X-Received: by 2002:a17:906:4789:b0:ae3:4f57:2110 with SMTP id
 a640c23a62f3a-ae3fe78f9b8mr339731566b.54.1751655090097; Fri, 04 Jul 2025
 11:51:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702224209.3300396-1-eddyz87@gmail.com> <20250702224209.3300396-5-eddyz87@gmail.com>
 <CAP01T74AYNX5ARJ5YXryUyKvn5o0Dv0JBoq3CCKcD8rh==uKQA@mail.gmail.com>
 <fb5b8613584dbce72359e44ef3974e4cb7c8298e.camel@gmail.com> <de7f3a2c5bc521c1111b0ed1870291c0889e4757.camel@gmail.com>
In-Reply-To: <de7f3a2c5bc521c1111b0ed1870291c0889e4757.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 4 Jul 2025 20:50:53 +0200
X-Gm-Features: Ac12FXxvs6diSbGhzKIowljN0TBK7kLNEiKzaMaVbuVORJet-U8Pu0CMWL1BL2M
Message-ID: <CAP01T75+cXUv4Je+bYQNb-Us_MF1s1Zc9fL0wmowLExKUQ8KNg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 4/8] bpf: attribute __arg_untrusted for global
 function parameters
To: Eduard Zingerman <eddyz87@gmail.com>, Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, Alexei Starovoitov <alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 4 Jul 2025 at 20:33, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Fri, 2025-07-04 at 11:28 -0700, Eduard Zingerman wrote:
> > On Fri, 2025-07-04 at 20:03 +0200, Kumar Kartikeya Dwivedi wrote:
> >
> > [...]
> >
> > > > @@ -7818,6 +7821,22 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
> > > >                         sub->args[i].btf_id = kern_type_id;
> > > >                         continue;
> > > >                 }
> > > > +               if (tags & ARG_TAG_UNTRUSTED) {
> > > > +                       int kern_type_id;
> > > > +
> > > > +                       if (tags & ~ARG_TAG_UNTRUSTED) {
> > > > +                               bpf_log(log, "arg#%d untrusted cannot be combined with any other tags\n", i);
> > > > +                               return -EINVAL;
> > > > +                       }
> > > > +
> > > > +                       kern_type_id = btf_get_ptr_to_btf_id(log, i, btf, t);
> > >
> > > So while this makes sense for trusted, I think for untrusted, we
> > > should allow types in program BTF as well.
> > > This is one of the things I think lacks in bpf_rdonly_cast as well, to
> > > be able to cast to types in program BTF.
> > > Say you want to reinterpret some kernel memory into your own type and
> > > access it using a struct in the program which is a different type.
> > > I think it makes sense to make this work.
> >
> > Hi Kumar,
> >
> > Thank you for the review.
> > Allowing local program BTF makes sense to me.
> > I assume we should first search in kernel BTF and fallback to program
> > BTF if nothing found. This way verifier might catch a program
> > accessing kernel data structure but having wrong assumptions about
> > field offsets (not using CO-RE). On the other hand, this might get
> > confusing if there is an accidental conflict between kernel data
> > structure name and program local data structure name.
>
> Maybe just add __arg_untrusted_local and avoid ambiguity?

That might be less ambiguous, sure. But I don't see why the fallback
would be confusing.
It might be nice if we can support it without asking users to learn
about the difference between the two tags, but if it's too ugly we can
go with explicit local tag.
A user can have a struct without preserve_access_index now and having
the same name as the kernel struct, and the program will load things
at potentially wrong offsets.
If the same type exists, the program would fail compilation in C due
to duplicate types.
Are there any other cases where it might be a footgun that you anticipate?

>
> > Supporting bpf_core_cast for both prog BTF and kernel BTF types is not
> > trivial because we cannot disambiguate local vs kernel types.
> > IIRC module BTF types probably don't work either but that's a different story.

> I can add bpf_rdonly_cast_local() as a followup, do you remember
> context in which you needed this?

Adding Matt.

Not long ago we were discussing iterating over the bpf linked list
since support doesn't exist in the kernel and it was safe in the
specific context to iterate over the list.
Ofcourse, we could add iteration support in the kernel, but another
approach would be the ability to subtract offset from node to arrive
at an untrusted pointer to type in prog BTF (that was allocated using
bpf_obj_new).
But bpf_core_cast didn't work there, so we ended up discarding that approach.
Not to get hung up on this specific example, but I think it would be
useful in general.

