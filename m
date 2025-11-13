Return-Path: <bpf+bounces-74432-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E21AEC59762
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 19:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7EC5C4EDAA5
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 17:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67B8359708;
	Thu, 13 Nov 2025 17:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqqB+O3a"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8051F2EF67F
	for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 17:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763056643; cv=none; b=Fhjjv66I4n/nAhD+xySHGg3/zFPKPW3kowyua3Pv08/SvoH3WrbIAo9y0RddnOUootFUUgzQYZyrmMl091XMxR4YCIG4jowlapyfZ2WGfUt/DUrHV1sj8Kbi+QzbtmylBbgfEOT6U0JfLMILjpPIzdqoGDt7GSORXZ21JbZeMRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763056643; c=relaxed/simple;
	bh=kvDK0kyHBLsRLqo/xqfgjRnH1mILL5tzYr3RBtYpY5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WPG9zZWnfD7ksFAqVg9GJ9Y61Cb6xtRKU8VxWGKucXpl7Jvt9xdj+ktLC6HkODCjce4Jd4dLJwY4kJa7dfwAHaa+N0amEWMkBLII6Ok+6qX9SQAJTLJcovncXonVfMOYZH7BpoHJVveqxi0asMkJmUqnkermrlkGTbrH8BaqAgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqqB+O3a; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47728f914a4so7512025e9.1
        for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 09:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763056640; x=1763661440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YI6SwLVxaeWge12jpv+g65IL6HLVUJJ6dHq74rzDBFI=;
        b=gqqB+O3as26Es4StwpMjNr7sXODvZxhjRDPhnWWK6BV8QBa600NpcoqYwpw+UtCN5W
         e8jNkZZPVeTriwboCCSG8z1qN4nc4qJWzUeSGoFp2AOtLJq825w0moZoqc0dSXogewr7
         k19CDwiDZ3BJP+mNW58NMVJ1iUBqJdq/GOspUIx+LHR37YCkZgK8H9Mwg2M7szLfIccd
         TiUqa8tYahcq0xl+8UCgE/UViZN9SA9nff5IaAJiQ+ie5KWU/wqVVfFCafn08Vj5B0Pe
         1arYXm9FWx/4FTS3V+Bg6/EJZ6p5aAQrr48Vdx+XztJf2Uopyb2/23laN6kkRgCHygyx
         cWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763056640; x=1763661440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YI6SwLVxaeWge12jpv+g65IL6HLVUJJ6dHq74rzDBFI=;
        b=sloxIog7IlvMHD3GPCnHKEQJ1s4edd9BM/hmgxMuF6dDilg1XvOyXeo/6OFi8hHNHO
         u1BZqpUhv8avSEYep21+5CJsM/elywm5n2KL1saWc0zlnatq1YaKmp8ZZDmFD21db5FA
         94TgWpx8xS9iFqzsjBN1BedSrIS+/VdHo51yMJhhGrklbeHRvi2QZnVeIoWCDEkzcVyb
         bTRDZyNBbAuyHW9xiKENRN6Gja8ZgAAubBVwA39/HxahdkXxUsia2IB0S8ptT/LwZF59
         0wUsVqVwXjdFtmwx1YOBrmru9PRkAmQeLMoFh/4SZStngV3dDrUkyy9KnqxT//aYbY4x
         79Pw==
X-Forwarded-Encrypted: i=1; AJvYcCX1zANhXPFzouHEBPKAGhjdmbRxDJCnFpfHDzUOffV3pkgU2qxQF57CvSoYCb0kLCTsXBE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5lOFMIlqt+jBEyJ+YxWCDU+MxCHFW0Vp9s7+bit+FTvQvTonb
	s57VbUmgEi7wS/BWtD1klp1N9Hsm/WZpb2RfiTFWAX6NqecrcP/86UeqwCN7QfyceoT8gN1S6lo
	hJdTRMLLWSS81cISgzFOz0HbIL7ybXiFblA==
X-Gm-Gg: ASbGncu3JHZkjEA00ot2Zsh8EyC36Af5KKR486Lbj+0fS/dz6NWY27KCXr24FI+uNrd
	J/YX2JVyoXRxp3rr/0eBC6VWtbqvE968Cx2oPjFGW4vNbC4ln8TC8fUE/FQFxDInSOEBSuF03nJ
	D1yg2SV/3j+nJvrejSdISA6SyKEp0d7OFVTY/pKq2Hp3FAts9YeQb5bE2OuTEZtpAjafhF8on5t
	42DJ5IttJ52Xu0VABaf3raGD60eXTLDKgQiEZFRfzzfp3ISc/1MSDyfh18Rn7Yvd+6+xv88+eKQ
	HiySAb7NkbE=
X-Google-Smtp-Source: AGHT+IHbO+ZGBFXO5ge0ijkSwdvqQcv57wZTtQs6YNPPselRxjdniZ7ynd75vfty+uOIzSWSgkGQqLyBXVlxsfcb078=
X-Received: by 2002:a05:600c:3b84:b0:476:a25f:6a4d with SMTP id
 5b1f17b1804b1-4778fe4f3d1mr4281155e9.1.1763056639666; Thu, 13 Nov 2025
 09:57:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113123750.2507435-6-jolsa@kernel.org> <c3260fe9e3d8ad79c75a6e8281f9fae5580beb3fcdd08e2015f417e11ec0a1b2@mail.kernel.org>
 <aRYAhDqGsOHZzTL-@krava>
In-Reply-To: <aRYAhDqGsOHZzTL-@krava>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 13 Nov 2025 09:57:05 -0800
X-Gm-Features: AWmQ_bljz9ERUrLpgXYFmwgFdNYuQjEZ9EECbJhv0IrVw392banlmrLNtGinfI0
Message-ID: <CAADnVQKnnZkODUUDDJQNJ7tVnoGreggw5NuvaP81=rpUYXwd7g@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 5/8] ftrace: Add update_ftrace_direct_mod function
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bot+bpf-ci@kernel.org, rostedt@kernel.org, 
	Florent Revest <revest@google.com>, Mark Rutland <mark.rutland@arm.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Menglong Dong <menglong8.dong@gmail.com>, Song Liu <song@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 8:00=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Thu, Nov 13, 2025 at 01:02:17PM +0000, bot+bpf-ci@kernel.org wrote:
> > > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > > index 433c36c3a..bacb6d9ab 100644
> > > --- a/include/linux/ftrace.h
> > > +++ b/include/linux/ftrace.h
> > > @@ -544,6 +544,7 @@ int modify_ftrace_direct_nolock(struct ftrace_ops=
 *ops, unsigned long addr);
> > >
> > >  int update_ftrace_direct_add(struct ftrace_ops *ops, struct ftrace_h=
ash *hash);
> > >  int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_h=
ash *hash);
> > > +int update_ftrace_direct_mod(struct ftrace_ops *ops, struct ftrace_h=
ash *hash, bool do_direct_lock);
> > >
> > >  void ftrace_stub_direct_tramp(void);
> > >
> > > @@ -581,6 +582,11 @@ int update_ftrace_direct_del(struct ftrace_ops *=
ops, struct ftrace_hash *hash)
> > >     return -ENODEV;
> > >  }
> > >
> > > +int modify_ftrace_direct_hash(struct ftrace_ops *ops, struct ftrace_=
hash *hash, bool do_direct_lock)
> >                 ^^^^^^^^^^^^^^^^^^^^^^^^^^
> > The stub function name doesn't match the declaration. Should this be
> > update_ftrace_direct_mod() instead of modify_ftrace_direct_hash()?
>
> it should, my bad
>
> >
> > > +{
> > > +   return -ENODEV;
> > > +}
> > > +
> >
> > [ ... ]
> >
> > > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > > index 345f3fdd2..627d05b57 100644
> > > --- a/kernel/trace/ftrace.c
> > > +++ b/kernel/trace/ftrace.c
> > > @@ -6445,6 +6445,74 @@ int update_ftrace_direct_del(struct ftrace_ops=
 *ops, struct ftrace_hash *hash)
> > >     return err;
> > >  }
> > >
> > > +int update_ftrace_direct_mod(struct ftrace_ops *ops, struct ftrace_h=
ash *hash, bool do_direct_lock)
> > > +{
> > > +   struct ftrace_hash *orig_hash =3D ops->func_hash->filter_hash;
> > > +   struct ftrace_func_entry *entry, *tmp;
> > > +   static struct ftrace_ops tmp_ops =3D {
> > > +           .func           =3D ftrace_stub,
> > > +           .flags          =3D FTRACE_OPS_FL_STUB,
> > > +   };
> > > +   unsigned long size, i;
> > > +   int err;
> > > +
> > > +   if (!hash_count(hash))
> > > +           return 0;
> > > +   if (check_direct_multi(ops))
> > > +           return -EINVAL;
> > > +   if (!(ops->flags & FTRACE_OPS_FL_ENABLED))
> > > +           return -EINVAL;
> > > +   if (direct_functions =3D=3D EMPTY_HASH)
> > > +           return -EINVAL;
> > > +
> > > +   if (do_direct_lock)
> > > +           mutex_lock(&direct_mutex);
> > > +
> > > +   /* Enable the tmp_ops to have the same functions as the direct op=
s */
> > > +   ftrace_ops_init(&tmp_ops);
> > > +   tmp_ops.func_hash =3D ops->func_hash;
> > > +
> > > +   err =3D register_ftrace_function_nolock(&tmp_ops);
> > > +   if (err)
> > > +           goto unlock;
> > > +
> > > +   /*
> > > +    * Call __ftrace_hash_update_ipmodify() here, so that we can call
> > > +    * ops->ops_func for the ops. This is needed because the above
> > > +    * register_ftrace_function_nolock() worked on tmp_ops.
> > > +    */
> > > +   err =3D __ftrace_hash_update_ipmodify(ops, orig_hash, orig_hash, =
true);
> >                                                                        =
 ^^^^
> > Does __ftrace_hash_update_ipmodify() accept a fourth argument? The
> > function signature shows it only takes three parameters (ops, old_hash,
> > new_hash). This looks like a compilation error.
>
> the whole patchset is based on bpf-next/master plus Song's livepatch
> fixes which change modify_ftrace_direct_hash function, it's mentioned
> in the cover letter

Ohh. Will send bpf PR to Linus today and merge into bpf-next afterwards.

