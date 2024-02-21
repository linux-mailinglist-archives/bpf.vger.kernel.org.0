Return-Path: <bpf+bounces-22412-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CBA85E2A1
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 17:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44536B20BF4
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 16:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BDD8121F;
	Wed, 21 Feb 2024 16:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cUJWKrp5"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411E93A1B1
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 16:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708531632; cv=none; b=K6GW2ZWlFomvPjXu5n/bme/ShIhuCn5rZLoCdh7FhDRhyF9bs4OmpRGCYjT/ttU0GFz19nqG+VOggp2RE+wUqcGh4rGXx80u6kjdMzAyRXAYe5bnM4B+0z2neqeqI9PNxWUDFG3updmTvWS2tJGiYmCNh5o1SQchQpEQ5wT0h7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708531632; c=relaxed/simple;
	bh=dGmgF8qGHnx/mJYlpADnCFU8iTkJrq/0O6aXwei1tvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I4jJD147UXp7JILxzaMKvAyUKNhRQV0ojI9XeDqm2O024MneWI66sLhkAaaIuSJKZNzYHCzuLHRuqhT7PFcTNwT1sMS0VTEEXFY5b/ThsS+F943mrtx8F0gAeSTpZh9dmP5zNfiZCrHMkTIerUGRu2xewQ4UTjgXO4VFhyf19GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cUJWKrp5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708531629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y30RSH8hthw/OYPhhhlk6+N/9nuxkhj3RC/Z3jCPafw=;
	b=cUJWKrp5FaJGVarLt8LVWwUAHBffFjeEPq1b8C+w11cdW8RzAIidgPO9mClgOx5f0K1y8p
	acup2CODzt56h2bokQfdLeZkGAGMO8xuacVB8CVuytbFWb+TrBJQAB+JqSpR9IGjXYPViv
	OdjQ4/pbDf0k5iJpSVxvKue5F2f/GBs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-bE2wKuotO76yLHpxfZe9Bg-1; Wed, 21 Feb 2024 11:07:07 -0500
X-MC-Unique: bE2wKuotO76yLHpxfZe9Bg-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-558aafe9bf2so4903305a12.1
        for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 08:07:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708531626; x=1709136426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y30RSH8hthw/OYPhhhlk6+N/9nuxkhj3RC/Z3jCPafw=;
        b=O2Ru1J9ESMn+2+owVYAYDaN/WElMSZVSZnxByo13R2vWkyXEMB3ALhvsU1vjEDQFk2
         vNTEcfIo88RbA/0tQlEVfYG76xOdeDxke38WiUJcuqVlVZeW4OLXCiwQeF26YmC+Syn6
         mbTkt1KXTz21xvDw3UWA1mS7v/9TIklPJTkR3JsMqeZJMZewNITBA/UvPKNue8AW3Rii
         MSPAanNQ9ab6JUruR4Ak/bSUYlosh1UCw5Wd0CNzkwzRH7mMVoYpN3iIRYhbKQMNTS2u
         uwOq7TiiicjT3rdbuUg57LHMiGsEc9WZpkIk7w4OuUaO0lMrYuyPX7+RUDmJCOscaZJ+
         V/yg==
X-Forwarded-Encrypted: i=1; AJvYcCU24I68AkWylZ9R+HP1jsY3YeHgKr88GLTYPxF4r51ba0RnFk+ZG0lMeex2Stf4t4qy9qIaJRHsDKGCejhfTf8LlmsB
X-Gm-Message-State: AOJu0Yyttz02eOtyipwcMITUg+GTBiFbx/acYEGF120YJGB4SKE7qjDn
	Tg/BRcN60hM0UnuV7HWPnIxyMHfefhT3Yfor5CO8wCZoZlcfqnhumXKpbPIVVpzuwqvHmmvYLBE
	t/VatzEhQMvit1fpIrEUZ2sJqqZ5hMfTpS9dwjLoM+CxuEhTBQDVHLFuPARh8jYAt4FGFYT3DFI
	d+0k26SOz6ZedVTMucH3/8bjgc
X-Received: by 2002:a17:906:7f0e:b0:a3f:4a33:8112 with SMTP id d14-20020a1709067f0e00b00a3f4a338112mr1044399ejr.53.1708531626776;
        Wed, 21 Feb 2024 08:07:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEU4eTPlizClIf0KjJt8QJlDiVbr8zCov6ZxhFgOKzHfX9uYPosMdqWZ4sbQtPG6AkyJmD/Xm3IdY1QDhuEqg4=
X-Received: by 2002:a17:906:7f0e:b0:a3f:4a33:8112 with SMTP id
 d14-20020a1709067f0e00b00a3f4a338112mr1044385ejr.53.1708531626473; Wed, 21
 Feb 2024 08:07:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214-hid-bpf-sleepable-v2-0-5756b054724d@kernel.org>
 <20240214-hid-bpf-sleepable-v2-2-5756b054724d@kernel.org> <mth43jfjhwtatwfo3unefrze62opht3yklleblslyz2adc6p5p@wm3miaqhhtkt>
 <rhdu4st5tfabsdqs27ewhvdlwblhj2re4o56iz3fq3bsuokxxe@gtuqdjffj2hn> <i2womwfk2bvxh3h7ubmj2p4aqywci36hcfufuqflcusg73ilsq@chpndguq7bgu>
In-Reply-To: <i2womwfk2bvxh3h7ubmj2p4aqywci36hcfufuqflcusg73ilsq@chpndguq7bgu>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Wed, 21 Feb 2024 17:06:54 +0100
Message-ID: <CAO-hwJKz+eRA+BFLANTrEqz2jQAOANTE3c7eqNJ6wDqJR7jMiQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v2 02/10] bpf/helpers: introduce sleepable timers
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Jiri Kosina <jikos@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[replying to both of your messages here]

On Wed, Feb 21, 2024 at 3:59=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Feb 16, 2024 at 10:50:10AM +0100, Benjamin Tissoires wrote:
> >  static bool is_rbtree_lock_required_kfunc(u32 btf_id)
> >  {
> >       return is_bpf_rbtree_api_kfunc(btf_id);
> > @@ -12140,6 +12143,16 @@ static int check_kfunc_call(struct bpf_verifie=
r_env *env, struct bpf_insn *insn,
> >               }
> >       }
> >
> > +     if (is_bpf_timer_set_sleepable_cb_kfunc(meta.func_id)) {
> > +             err =3D push_callback_call(env, insn, insn_idx, meta.subp=
rogno,
> > +                                      set_timer_callback_state);
> > +             if (err) {
> > +                     verbose(env, "kfunc %s#%d failed callback verific=
ation\n",
> > +                             func_name, meta.func_id);
> > +                     return err;
> > +             }
> > +     }
>
> All makes sense so far.
> Please squash all the fix and repost.
> It's hard to do a proper review in this shape of the patch.

Yeah, I was expecting a very quick "I know why you are crashing", not
a full review here.

> As far as rcu_read_lock/unlock that is done in callback...
> it feels buggy and unnecessary.

This rcu approach is indeed wrong, but there still needs to be some
locking if bpf_timer_set_callback() or bpf_timer_set_sleepable_cb() is
called while the work just started. I went with a semaphore in v3 as
it seemed lightweight enough there. Please shout if you disagree :)

Anyway, I've also dropped the flags in bpf_timer_init() in v3 to only
add BPF_F_TIMER_SLEEPABLE in bpf_timer_start().

V3 (not RFC) is coming.

Cheers,
Benjamin

> bpf prog and timer won't disappear while work is queued.
> array and hash map will call bpf_obj_free_timer() before going away.
>
> And things like:
> +       rcu_read_lock();
> +       callback_fn =3D rcu_dereference(t->sleepable_cb_fn);
> +       rcu_read_unlock();
> +       if (!callback_fn)
> +               return;
>
> is 99% broken. if (!callback_fn) line is UAF.
>


