Return-Path: <bpf+bounces-22888-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 769D686B51F
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 17:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77BDE1C21CBB
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 16:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88F81E86C;
	Wed, 28 Feb 2024 16:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="LdkB87zd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A486D6EF1D
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 16:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709138285; cv=none; b=uu7GUd4j+8PdVbsSvZxPlm5Ub4jfsIhCWcayHiodOUu/mY6oRnWjUp4ZMfSTzoU5fvKjsICUa2oUQTszfJUTe5l4c0hgLV/WyS0cSiecRShHHd/XLZ5T0NelKG0FAVv42VlXZG8XYSpjU/yS+BKMxExjb0G+30UFwqaIvlReBEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709138285; c=relaxed/simple;
	bh=9PTeAYYKh6BghzUQ5SY1FEoCFtAzge8LlEvtJa+/mwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o+cYPMuC1yg6yBg/phcdbGOTR/2zXzwfdfmSa/NZiJzh0rTBLBVi+g64MjJ8nR7x+GtDNxxvxadiyAyUz0uxkTqbWPawwDrQnSTju3ngWMMzT18LO7mSzikxEN849XCI2UPS3NRKvyiI4LSKrMsdqU2vlVJq8g+tym7HCZxPKcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=LdkB87zd; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55a5e7fa471so7878741a12.1
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 08:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1709138282; x=1709743082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWAQpAUpfQCDhx0rGjR9Oel5LgwsLKY+ggnWMU654+8=;
        b=LdkB87zd/3Ey/TszPdJTjeBQW0CD8ooalvGxGuuwIAZDzqDmWaj0B/AU3vvPUzguME
         efMh/O1i1e4AdYTsJ3LCDduY7WErH+GOcYL3Ekt+sK6CmLuLTCFWegQfToCkq+bDYAjC
         ExlXDdy4kn7Lo124FUzyhxciy7Avg9lImGOpWtlvlk2DK1rWKQR+3x8FfYJHE1mWw477
         IjVO27AnTPrNXoYNbzQ0lKRhYwuSxcxok561LJwnPBBkVcNrAYGKF7vy11qiqQ56HaBN
         WD60dlG3pOb5Q0iKZKsxGKSXPkiwcJeiOVS1+KjFR/wXicr3DWprGwOJwMT5FsaH4iBW
         wFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709138282; x=1709743082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWAQpAUpfQCDhx0rGjR9Oel5LgwsLKY+ggnWMU654+8=;
        b=pcbD/Zo+RpubHhcm/Ap3tU07RWEnugECNbrwxDeMCunJIqQLmreMEaFPY6TiU1R4N7
         6ZRMMwW3ImigN5wXMNVmowRAuSXjACcQALEinZe3C4KpdDR2QVAF6nv1HKAuGlNQ/h5a
         pJ3Dai8Os7qSdvvgWF9iHTt/5aF/sRmOYFK2aup7lGBO0Gn/HH4+Gh5LqhoboTxC7UP0
         11qwhAbVfy/J/5JJPYNioRvfX1TWd6zW+ops0zvq3jylzO1j51dmQuL6XhkDbd2Sl4v+
         KIKhSuprsnWN68kumBmk33NEO9+5lO6MSY+NdWCldNUiUjfA8sMWng9Mxgj85fObvNbP
         l7mg==
X-Forwarded-Encrypted: i=1; AJvYcCXhpo40DfVvo5A08txf4UT0EqZ24JczIYqj8Pd9DdwTiOtN4bTxAwgBq+rvxUcpQZ81aLGvmsiroGS7p1R6kY+83XHI
X-Gm-Message-State: AOJu0YwjGWl0Ml+StSHmVaElm48B+KkzbRgR8Vwm0EsoNxDvdbNUzFG6
	UkLURbf5p2VP1zCczSvcadymIHTtLkeIv1tkjzJSpjXBJvOMkskxO2mzPdv/THsxllvTtEuHNWh
	dz3lNuqdwqHf77PAYrHLrNtPbtLhmAA2RpEmAJQ==
X-Google-Smtp-Source: AGHT+IH6HQq8hzqji91OJqqxN2VkP0/oD9hn7fSXzbwfcVbmFDthP3qt0d5uMMo2K+yS0zBkR2z5gsNJJobM1iVOpOM=
X-Received: by 2002:a17:906:e8f:b0:a43:49ca:2473 with SMTP id
 p15-20020a1709060e8f00b00a4349ca2473mr193121ejf.0.1709138282075; Wed, 28 Feb
 2024 08:38:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zd4DXTyCf17lcTfq@debian.debian> <CANn89iJQX14C1Qb_qbTVG4yoG26Cq7Ct+2qK_8T-Ok2JDdTGEA@mail.gmail.com>
 <d633c5b9-53a5-4cd6-9dbb-6623bb74c00b@paulmck-laptop> <f1d1e0fb-2870-4b8f-8936-881ac29a24f1@joelfernandes.org>
In-Reply-To: <f1d1e0fb-2870-4b8f-8936-881ac29a24f1@joelfernandes.org>
From: Yan Zhai <yan@cloudflare.com>
Date: Wed, 28 Feb 2024 10:37:51 -0600
Message-ID: <CAO3-Pboo32iQBBUHUELUkvvpSa=jZwUqefrwC-NBjDYx4yxYJQ@mail.gmail.com>
Subject: Re: [PATCH] net: raise RCU qs after each threaded NAPI poll
To: Joel Fernandes <joel@joelfernandes.org>
Cc: paulmck@kernel.org, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>, 
	Alexander Duyck <alexanderduyck@fb.com>, Hannes Frederic Sowa <hannes@stressinduktion.org>, 
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org, bpf@vger.kernel.org, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 9:37=E2=80=AFAM Joel Fernandes <joel@joelfernandes.=
org> wrote:
> Also optionally, I wonder if calling rcu_tasks_qs() directly is better
> (for documentation if anything) since the issue is Tasks RCU specific. Al=
so
> code comment above the rcu_softirq_qs() call about cond_resched() not tak=
ing
> care of Tasks RCU would be great!
>
Yes it's quite surprising to me that cond_resched does not help here,
I will include that comment. Raising just the task RCU QS seems
sufficient to the problem we encountered. But according to commit
d28139c4e967 ("rcu: Apply RCU-bh QSes to RCU-sched and RCU-preempt
when safe"), there might be additional threat factor in __do_softirq
that also applies to threaded poll.

Yan


> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>
> thanks,
>
>  - Joel
> [1]
> @@ -381,8 +553,10 @@ asmlinkage __visible void __softirq_entry __do_softi=
rq(void)
>                 pending >>=3D softirq_bit;
>         }
>
> -       if (__this_cpu_read(ksoftirqd) =3D=3D current)
> +       if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
> +           __this_cpu_read(ksoftirqd) =3D=3D current)
>                 rcu_softirq_qs();
> +
>         local_irq_disable();

