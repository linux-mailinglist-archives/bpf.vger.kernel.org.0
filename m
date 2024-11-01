Return-Path: <bpf+bounces-43745-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3931D9B959B
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 17:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B25E61F230B7
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 16:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076211C9B97;
	Fri,  1 Nov 2024 16:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRnkiUMC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6ED137747;
	Fri,  1 Nov 2024 16:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730479176; cv=none; b=IH5ZB1UHJFUfq9uC7us1osVminJ8Kokyrw/RT71W/Ogk5syMeRvyKF1ZpvJpNaicOkyIoSP29HprKCcCHkPRaT+oZugkPUQsDBgdHni3GSkZjskuHKhPzvUhbjdl+o4QSKcRfjk/qIOOVJBgjOMAse4kyyi9RLLPgVb3e0MEBVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730479176; c=relaxed/simple;
	bh=eYcrOG9mHh6yyHrcNyGtvglh2QWfqXs/k1+/Wyn9ENs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=cd/utpx5/b+481V9l/iMtIXvloLygkb1jPQZuNC4uSIzX+KQyFGU1iq9oxTdNiwKocJ+9Ravon2aRAjWCIcgZOaqMLSM2ytKNUmPy6la+NuQ75VoPZ8XPnbChx81xVNdQ5xGM1wU7TEPQNfZdbH2OgKqlgfpA0lXO5kWgMidfNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRnkiUMC; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b1474b1377so156234385a.2;
        Fri, 01 Nov 2024 09:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730479173; x=1731083973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHm8aPw/Qd4coTpdXsYu8y9FaG/uUMCrjQn/n+HNt4I=;
        b=CRnkiUMCXPZjIkZOlD9xTdx+kWBCm2TSQTvfG2xnUIRGL+5RzOWC7oL9tHFARpVLcS
         xvDd033DLRomyK4/AG6tMIT//9w1CgNFFI+W2FnAjLj/ufKSxkkmqQI7ETKNwGi/W7j2
         DC8AeDd9fu1jLJq4BfpGguNLakEhw0vEyolhn6WPVfPgNvnbVW1WELXT0lnY9o5eSej5
         jtKw353QcJCLlmZTMR9brAVO4wtSyfqFISExj0xmWH/n3Tp52tGlumRF6Y9p20ocRX+Z
         dr9p7m4Jf5yD047tFvHh/GVyOJ/+pH0uMYsQeiz6UVPr9CB7+Bqmij/RzHY5sI5NKq9H
         Cb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730479173; x=1731083973;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JHm8aPw/Qd4coTpdXsYu8y9FaG/uUMCrjQn/n+HNt4I=;
        b=ePf0DYRkK/BrkDLDo8UoaHNrRqVp/S+bUZPzz/DpN1JLofoyGoaSgzE4sJDeE7nmes
         YoRGe+Q5uIqRIZ5v3kZkTVQi9fk4pDuFjFW7FZk+s5p2zig5OnWYA57ZqLCM35PT3JOW
         7rZqlPFY+o3QkLqhNSkWUbtliLffG3OIdsN5AbkSIBYx6Od/tmhLWGQfI9O3NJNWo34s
         QbdnIb0o+oquWY+gdlTrd6eIYfw3M+DDZx400Y2VrJ6jOUzwK3IF1wA4pLuBOA+x5KSU
         DTmOXAnYM5zcgEnGSc2d+H2ST9+pNl029gKaaFNTI6Fw7iJR4bwlEER61fIIOT4Sbc9S
         1FeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcCBrkyY9eVjXBqt06Acq8+qTQNJxEnE5pzLOv7HYTkF8ndUgAguIAfcAdPwCQYh5AVPKiNOz9@vger.kernel.org, AJvYcCXykX+Z9lSwEZ5+nIWU2lWaic/ECvVycl5+4wmo7+9beLfytj9+714shSEtj4zVQg5DenI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMqKi/GlkkulmA3WW6ncF/2UYymOkZTNMCue+iww0wEjlxI0K4
	wOkln5KDJMT0hdHf2We3bTw/ZyYhGNQ4zcY5dEad2pjgXPfafU/G
X-Google-Smtp-Source: AGHT+IGHtA0Toc/v5pgrYY+zsCHCYwv1iuiz4qJujChQ72j7yIN5GAC3yZ4auLrd9x5pBdVJSS01Lw==
X-Received: by 2002:a05:620a:2444:b0:7b1:440a:fdf2 with SMTP id af79cd13be357-7b2f24dd30bmr1058347185a.20.1730479173300;
        Fri, 01 Nov 2024 09:39:33 -0700 (PDT)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f3a9b28fsm182981185a.130.2024.11.01.09.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 09:39:32 -0700 (PDT)
Date: Fri, 01 Nov 2024 12:39:32 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, 
 willemb@google.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 shuah@kernel.org, 
 ykolal@fb.com, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <672504444fc8a_1c9cd029466@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoDyvAcwxdsOWfWoJ-ZJ=kMXdw-XM2BDC+_tJO+Eudg3jg@mail.gmail.com>
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <61e8c5cf-247f-484e-b3cc-27ab86e372de@linux.dev>
 <CAL+tcoDB8UvNMfTwmvTJb1JvCGDb3ESaJMszh4-Qa=ey0Yn3Vg@mail.gmail.com>
 <67218fb61dbb5_31d4d029455@willemb.c.googlers.com.notmuch>
 <CAL+tcoBhfZ4XB5QgCKKbNyq+dfm26fPsvXfbWbV=jAEKYeLDEg@mail.gmail.com>
 <67219e5562f8c_37251929465@willemb.c.googlers.com.notmuch>
 <CAL+tcoDonudsr800HmhDir7f0B6cx0RPwmnrsRmQF=yDUJUszg@mail.gmail.com>
 <3c7c5f25-593f-4b48-9274-a18a9ea61e8f@linux.dev>
 <CAL+tcoAy2ryOpLi2am=T68GaFG1ACCtYmcJzDoEOan-0u3aaWw@mail.gmail.com>
 <672269c08bcd5_3c834029423@willemb.c.googlers.com.notmuch>
 <CAL+tcoA7Uddjx3OJzTB3+kqmKRt6KQN4G1VDCbE+xwEhATQpQQ@mail.gmail.com>
 <CAL+tcoDL0by6epqExL0VVMqfveA_awZ3PE9mfwYi3OmovZf3JQ@mail.gmail.com>
 <d138a81d-f9f5-4d51-bedd-3916d377699d@linux.dev>
 <CAL+tcoBfuFL7-EOBY4RLMdDZJcUSyq20pJW13OqzNazUP7=gaw@mail.gmail.com>
 <67237877cd08d_b246b2942b@willemb.c.googlers.com.notmuch>
 <CAL+tcoBpdxtz5GHkTp6e52VDCtyZWvU7+1hTuEo1CnUemj=-eQ@mail.gmail.com>
 <65968a5c-2c67-4b66-8fe0-0cebd2bf9c29@linux.dev>
 <6724d85d8072_1a157829475@willemb.c.googlers.com.notmuch>
 <CAL+tcoDyvAcwxdsOWfWoJ-ZJ=kMXdw-XM2BDC+_tJO+Eudg3jg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/14] net-timestamp: allow two features to
 work parallelly
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

> > > >>
> > > >> For datagrams (UDP as well as RAW and many non IP protocols), an
> > > >> alternative still needs to be found.
> > >
> > > In udp/raw/..., I don't know how likely is the user space having "cork->tx_flags
> > > & SKBTX_ANY_TSTAMP" set but has neither "READ_ONCE(sk->sk_tsflags) &
> > > SOF_TIMESTAMPING_OPT_ID" nor "cork->flags & IPCORK_TS_OPT_ID" set.
> >
> > This is not something to rely on. OPT_ID was added relatively recently.
> > Older applications, or any that just use the most straightforward API,
> > will not set this.
> >
> > > If it is
> > > unlikely, may be we can just disallow bpf prog from directly setting
> > > skb_shinfo(skb)->tskey for this particular skb.
> > >
> > > For all other cases, in __ip[6]_append_data, directly call a bpf prog and also
> > > pass the kernel decided tskey to the bpf prog.
> > >
> > > The kernel passed tskey could be 0 (meaning the user space has not used it). The
> > > bpf prog can give one for the kernel to use. The bpf prog can store the
> > > sk_tskey_bpf in the bpf_sk_storage now. Meaning no need to add one to the struct
> > > sock. The bpf prog does not have to start from 0 (e.g. start from U32_MAX
> > > instead) if it helps.
> > >
> > > If the kernel passed tskey is not 0, the bpf prog can just use that one
> > > (assuming the user space is doing something sane, like the value in
> > > SCM_TS_OPT_ID won't be jumping back and front between 0 to U32_MAX). I hope this
> > > is very unlikely also (?) but the bpf prog can probably detect this and choose
> > > to ignore this sk.
> >
> > If an applications uses OPT_ID, it is unlikely that they will toggle
> > the feature on and off on a per-packet basis. So in the common case
> > the program could use the user-set counter or use its own if userspace
> > does not enable the feature. In the rare case that an application does
> > intermittently set an OPT_ID, the numbering would be erratic. This
> > does mean that an actively malicious application could mess with admin
> > measurements.
> >
> 
> Sorry, I got lost in this part. What would you recommend I should do
> about OPT_ID in the next move? Should I keep those three OPT_ID
> patches?

I did not offer a suggestion. Just pointed out a constraint.

