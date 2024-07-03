Return-Path: <bpf+bounces-33814-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA10926A87
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 23:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE36BB23419
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 21:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117BA194159;
	Wed,  3 Jul 2024 21:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GylwNTGt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBDE1940AA;
	Wed,  3 Jul 2024 21:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720042895; cv=none; b=JBqkO8kdv6cmKADQvnoN0bo8S3GtgM5cqs3VRyKpDya65gylTzWPLpEC7m4LSELFhCZxfEwXD/wZ5yuCDj4IRU2jbKmkka9oc4XeHFVSN7gSwH1VV8WpF70dWetxmRfo+u7gVI/YoVsuVgFKrpdwW7MpqJgvNIeQ+MFT2Ekxqjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720042895; c=relaxed/simple;
	bh=UYId9ib4W1XVwakUKpK8UdCaHjuCl6qTKvCSJgVA8Gs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OveyvraVA5cEqpCRuvpV03wcnWz8HBGe0As5PCcTG/kKtvESwXEjez2VrCLjPkbthIlZobsf8nGBu+K60JMKw1dgcg20mkz3JdbxvqcmdY+go71u5jukJNo5rieytA6PZ23mYrKb8FQoQfgzdV4g/nPFRF0nLsWd0adkwVdeOYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GylwNTGt; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70af5fbf0d5so15283b3a.1;
        Wed, 03 Jul 2024 14:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720042893; x=1720647693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=esvZ6VuiStx2UmyM3dQcBLcwAYAmnaiZ2GvpF1eDANY=;
        b=GylwNTGtN5Szfzw1T1p6xcrZy1mRjPTHKt2nlfVkfoZmEc2zeJ4D3kgUSs3Vrz2Ke+
         xtNbln6JhJtKd3Dysi9mtUvXxbA5FI0a1Pz7nmFyjmfChZ0c3LVFhPTZvUamSHLich+a
         QOnxXK0e9KhDtol8lVBEDOutsDylyDxdwBAlEWaQpVBN2ytajl4A2pgy03dMiZ41C08M
         zOSjT3VGoF3h6kk1ZRTdgqMfBRal2XjsGaIg3vA4+fX05m8hd+SBrn+0qMPi6/osK8Ar
         LWBqJULdR+CwjirhwDafmfjs9xnhoq5XRyYTLHWTivMAfHBcJIfZvNUcxFX4VxGIX9IN
         7tVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720042893; x=1720647693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=esvZ6VuiStx2UmyM3dQcBLcwAYAmnaiZ2GvpF1eDANY=;
        b=W6CFwTwCJkepPsef0LTW5AACb4bPSoCcnAj5qgmfT5cc3Qs9OccJ5uVUihv0IEW85y
         pRxTqZWZE0dBIaSDMjYfoy3hOuhnS+6JwQeSnCRahLGxJKdyHcnxLZHbtAhrEZT3/RSV
         5Sxy1aG6utm4ZA54DLAZfydWSLpjdowT69KrwaP0OzwpvqKfkO/kIxTtYPfguYkA4Rh/
         tZEOhpRVmwcdpoXvuZqjFNhdVRzh6dIvjGQeyPymNzZrazJ77WnkZtFTqhkOPSndkvAo
         I5wWWMkHSgf1U2T9oQ7KiMS0oMyDt/BdZgB02A5dQBprPpRKWviansEr0JuCd69LRXe2
         YiQQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/9WjnoF6LHdF9TBj4PG7+LudtB1FnZUL5HqsAuw0E13KW3lzRa/rYNAeicr/h+WCqFr3+rpvO7sOIW6JR3JCvQPT9cl4xw3UH5wuDlIuXNOV9j3KBuVr6lCK2IuhdW1y+74L3fqk6rm3HEVlYQ9KlecXZlqIpwesiLextfuzt4th+U0p5
X-Gm-Message-State: AOJu0YxWNl8NKkhSGLXcTD2GdcbEujM7+vzaDpirDOBKQLyz45RiEPhX
	MJex2d20aZKKL+KKiu4vaGA9PlOUuW/M58qZTxEKpFI6hHV3eoe7Ito/XWOQbpSdFI6SmBRZ6ra
	ORgg2zpqPAr9ie2Gv/8HqC+8xXIk=
X-Google-Smtp-Source: AGHT+IFcRbJCxRI3b/A2c9aiTrHs5VWyD1gQ4oRlspFH5zC6lceXw8F7cGP3QA9TMEsLz3XpNabDIr0Oa9BJn9T5oYo=
X-Received: by 2002:a05:6a00:2d83:b0:706:79fa:37d1 with SMTP id
 d2e1a72fcca58-70aeb5e2976mr4210283b3a.17.1720042893439; Wed, 03 Jul 2024
 14:41:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701164115.723677-1-jolsa@kernel.org> <20240701164115.723677-2-jolsa@kernel.org>
 <20240702130408.GH11386@noisy.programming.kicks-ass.net> <ZoQmkiKwsy41JNt4@krava>
 <CAEf4BzYz-4eeNb1621LugDtm7NFshGJUgPzrVL7p4Wg+mq4Aqg@mail.gmail.com> <ZoVu1MKUZKtPJ7Am@krava>
In-Reply-To: <ZoVu1MKUZKtPJ7Am@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Jul 2024 14:41:19 -0700
Message-ID: <CAEf4Bzb9r5PF-w3PM6CbO4d0L-sHF_zmB=P4ZjJLHyfEDNNdtQ@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 1/9] uprobe: Add support for session consumer
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 8:31=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Tue, Jul 02, 2024 at 01:52:38PM -0700, Andrii Nakryiko wrote:
> > On Tue, Jul 2, 2024 at 9:11=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> w=
rote:
> > >
> > > On Tue, Jul 02, 2024 at 03:04:08PM +0200, Peter Zijlstra wrote:
> > > > On Mon, Jul 01, 2024 at 06:41:07PM +0200, Jiri Olsa wrote:
> > > >
> > > > > +static void
> > > > > +uprobe_consumer_account(struct uprobe *uprobe, struct uprobe_con=
sumer *uc)
> > > > > +{
> > > > > +   static unsigned int session_id;
> > > > > +
> > > > > +   if (uc->session) {
> > > > > +           uprobe->sessions_cnt++;
> > > > > +           uc->session_id =3D ++session_id ?: ++session_id;
> > > > > +   }
> > > > > +}
> > > >
> > > > The way I understand this code, you create a consumer every time yo=
u do
> > > > uprobe_register() and unregister makes it go away.
> > > >
> > > > Now, register one, then 4g-1 times register+unregister, then regist=
er
> > > > again.
> > > >
> > > > The above seems to then result in two consumers with the same
> > > > session_id, which leads to trouble.
> > > >
> > > > Hmm?
> > >
> > > ugh true.. will make it u64 :)
> > >
> > > I think we could store uprobe_consumer pointer+ref in session_consume=
r,
> > > and that would make the unregister path more interesting.. will check
> >
> > More interesting how? It's actually a great idea, uprobe_consumer
>
> nah, got confused ;-)
>
> > pointer itself is a unique ID and 64-bit. We can still use lowest bit
> > for RC (see my other reply).
>
> I used pointers in the previous version, but then I thought what if the
> consumer gets free-ed and new one created (with same address.. maybe not
> likely but possible, right?) before the return probe is hit

I think no matter what we do, uprobe_unregister() API has to guarantee
that when it returns consumer won't be hit (i.e., we removed consumer
from uprobe->consumers list, waited for RCU grace period(s), etc). So
I don't think this should be a problem. And that's one of the reasons
for the need for batched unregister, because we'll have to do sync_rcu
call there for this.

>
> jirka

