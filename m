Return-Path: <bpf+bounces-33818-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F75926AD2
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 23:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 460E1B27AFD
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 21:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E297E181BB2;
	Wed,  3 Jul 2024 21:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h48UPAcd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2371849CD;
	Wed,  3 Jul 2024 21:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720043322; cv=none; b=BzKkIl3RtKF+HVoXNsm5jORLsSt0gCteLtxLeH8gOZKS/7B9Qyck91afSPcSbeH8inJk9kay4pJ6CCzamTh158VjzVsA4Et/mDxvtXhbQGxaDKADzTvWoNer0qF9swTT/tNa3MBIIasLiIOJJQ2zmRFD+dxpNQE4JyW7BMeui2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720043322; c=relaxed/simple;
	bh=k5FnhMvXRUBiIzUc1ItfZMOzj5vINlUgdH4QsQibVpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tnJ+aaqT+myjaiJwVMBOEKkPo40aS9G117xFSFiAExURv4S9eePUHYntEDGK2k5193IsKRaNF8OhrN3hhF/orRDkCFRJsPDhK+pbR6cQPOEperlX6Vz7p9mVB6tgn3P2xDuEH6SigWJe6AMb4TDjJ20N+Y4A8Mrp2ZwQd0PYOmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h48UPAcd; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70ad2488fb1so27496b3a.1;
        Wed, 03 Jul 2024 14:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720043320; x=1720648120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRW4svlzqqatFjF02kT9r7dWaAJh/+PGyFL+ikp0Stg=;
        b=h48UPAcdxcbZJRaPQkWxKK6bcimCdROYbNLjlDdbLu3tZmxoaI/iWieXyslzA18wxv
         7F1k2up1CTuPaUKHGZLWFsxkQlScjABlTG1bUHPCI2fJwypeHh3ZiwRKx7sMs9dNzl78
         Cz1GSj11v7eUzqgvVtiBBexE8akVxJ8nSEpdCeixlQW0O2wgzkL39jmIyLHIBsSN4wrU
         fUL9lpTRpY96daFr64r6rIGTjsfpmGWHjzmylUoZquRo9ITulistWr6Vllo8MQIwMhPM
         v9O5XQTtcpP0cU5H7Ik4pBTNU1eiop1t7cxy7zTUBh3sR/vB5kci6ghqrD+AikT/a2t1
         ElCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720043320; x=1720648120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FRW4svlzqqatFjF02kT9r7dWaAJh/+PGyFL+ikp0Stg=;
        b=sRLpimtDZwtV2vtCO0sw6lhXlfJQ/Whs3IemzNVgzwbd/SXqBE+cXjaohdWw1tJLIb
         k8Y3DvaBEDuUelpgx2LBY/9S6gXOsOMeJy4ckVtKc6MpDuGPSZBvYLgOPhwM2qhsaLpD
         g+DLSqKQzrIEKgC9nHftjFpHVuTRIo7cGJ73s8iwOzAoIUh4Uq+eOgu1Edd9kYF6qM2+
         tn3RYmOeiqcFi4u7Pi4cpu/WgDJ7JWTyDoJGugsjtdm7sJLONYLbF/qs682Lw2q+pJkX
         7bP9DpP0CzPShq35XcE0fpqvjh5w93EADqcaMZD4sFMZSZDHIgPzD2rzjWzVHw2J8C84
         lCeg==
X-Forwarded-Encrypted: i=1; AJvYcCX3pMiYtFI6wcRx+5lsEnFHjYZ6/JNpz+711w5y7Jw/dIH3Tgbd8FOcsZqgpXSfz7XhZpH94rJ0CI+kvYVk6zlQbEsnzkswqw4Gr/nqjgPvJiV246Bw1j9o8GUgTq+vCEecLZV+EyMW2rbBj4XvWBWJEf4i++0JmfrtnlUnmwl3PGNaI7P2
X-Gm-Message-State: AOJu0YynAXUA+yxlLzmoqc1JiSdEKPVzlKzPZ0qVchg+4r6dwUfgiIMN
	eCt/K2n8IUL6VLtgD/HTd5gxyYuM26iWiSP2jgTTlO4OopUAB9Nn4wYqOVMM3WBEHnDpEhFxcyR
	LnP/1ZLMAcR6ywKzbBvT2NiKlaXA=
X-Google-Smtp-Source: AGHT+IFzGQmwFpF7QWLCNnkRdZd/fTKchFReHddYzEfVjxXQN3azEtZDe9RP0qC0HdFeFK41fD+HSm/ku4N027AKsW8=
X-Received: by 2002:a05:6a20:258c:b0:1be:c4f9:ddd3 with SMTP id
 adf61e73a8af0-1bef611dcecmr16494254637.24.1720043320279; Wed, 03 Jul 2024
 14:48:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701164115.723677-1-jolsa@kernel.org> <20240701164115.723677-2-jolsa@kernel.org>
 <CAEf4BzZaTNTDauJYaES-q40UpvcjNyDSfSnuU+DkSuAPSuZ8Qw@mail.gmail.com> <ZoWGrGYdyaimB_zF@krava>
In-Reply-To: <ZoWGrGYdyaimB_zF@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Jul 2024 14:48:28 -0700
Message-ID: <CAEf4BzbfKE1cWWXfWnWN510pai8Aq_W6J-WSLSAyGO_=rZWX_Q@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 1/9] uprobe: Add support for session consumer
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 10:13=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Tue, Jul 02, 2024 at 01:51:28PM -0700, Andrii Nakryiko wrote:
>
> SNIP
>
> > >  #ifdef CONFIG_UPROBES
> > > @@ -80,6 +83,12 @@ struct uprobe_task {
> > >         unsigned int                    depth;
> > >  };
> > >
> > > +struct session_consumer {
> > > +       __u64           cookie;
> > > +       unsigned int    id;
> > > +       int             rc;
> >
> > you'll be using u64 for ID, right? so this struct will be 24 bytes.
>
> yes
>
> > Maybe we can just use topmost bit of ID to store whether uretprobe
> > should run or not? It's trivial to mask out during ID comparisons
>
> actually.. I think we could store just consumers that need to be
> executed in return probe so there will be no need for 'rc' value

ah, nice idea. NULL would mean we have session uprobe, but for this
particular run we "disabled" uretprobe part of it. Great. And for
non-session uprobes we just won't have session_consumer at all, right?

[...]

> > > +static struct session_consumer *
> > > +session_consumer_next(struct return_instance *ri, struct session_con=
sumer *sc,
> > > +                     int session_id)
> > > +{
> > > +       struct session_consumer *next;
> > > +
> > > +       next =3D sc ? sc + 1 : &ri->sessions[0];
> > > +       next->id =3D session_id;
> >
> > it's kind of unexpected that "session_consumer_next" would actually
> > set an ID... Maybe drop int session_id as input argument and fill it
> > out outside of this function, this function being just a simple
> > iterator?
>
> yea, I was going back and forth on what to have in that function
> or not, to keep the change minimal, but makes sense, will move
>

great, thanks

> >
> > > +       return next;
> > > +}
> > > +

[...]

> >
> > > +               } else if (uc->ret_handler) {
> > >                         need_prep =3D true;
> > > +               }
> > >
> > >                 remove &=3D rc;
> > >         }
> > >
> > > +       /* no removal if there's at least one session consumer */
> > > +       remove &=3D !uprobe->sessions_cnt;
> >
> > this is counter (not error, not pointer), let's stick to ` =3D=3D 0`, p=
lease
> >
> > is this
> >
> > if (uprobe->sessions_cnt !=3D 0)
> >    remove =3D 0;
>
> yes ;-) will change
>

Thanks, I feel bad for being the only one to call this out, but I find
all these '!<some_integer_variable>` constructs extremely unintuitive
and hard to reason about quickly. It's only pointers and error cases
that are more or less intuitive. Everything else, including
!strcmp(...) is just mind bending and exhausting... Perhaps I'm just
not a kernel engineer enough :)

> jirka
>
> >
> > ? I can't tell (honestly), without spending ridiculous amounts of
> > mental resources (for the underlying simplicity of the condition).
>
> SNIP

