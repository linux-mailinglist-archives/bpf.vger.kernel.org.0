Return-Path: <bpf+bounces-51668-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AC0A36F6C
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 17:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2E1B1891ABE
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 16:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE061E5B82;
	Sat, 15 Feb 2025 16:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAxUNaQL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FD41624E8;
	Sat, 15 Feb 2025 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739636467; cv=none; b=jYBmbyvD/oV4QloTjlmHplnrjPd/J7QP7QkBCFdTguSiG7HGKKIH58Sh/EKn2K7K5B7kS17fN1zA7KUV9CW69F/VzqlMQ2l1xNqq2aii3fNHbsJgmj21C/WzpnEXH92P1OnFdoM8Qwz6RYSxe8cGjtr6x75ev+WkUDznVHTZok8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739636467; c=relaxed/simple;
	bh=oMr9kLTfKManm/UUrjsm3ZodbEL/TxRtX0uLcVKFAno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FQjXnUPbi13XZV5jmUw8vNeNqLTqePsnvSw12HcTTl5YEhuNqDsx6p8wgD4JrP+TvIHjrMdD47IzMCzsLLpSt56NTcRCLDhy+26C5Q5+4HrzWfMYDtEuUYo0XZKOOOKlSIG3o1kpt3MfB46cqhTWuL6AmFUqysB/Mf2GBipCuJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAxUNaQL; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3d19d214f0aso14045635ab.1;
        Sat, 15 Feb 2025 08:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739636465; x=1740241265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oMr9kLTfKManm/UUrjsm3ZodbEL/TxRtX0uLcVKFAno=;
        b=QAxUNaQL4RCc1kQnYaQDr+YgB82wpytu0gcVomDDQN/SGfVsDjaYhD7tU1d3af5Er2
         lQVyokFic3KDJ5A2gVdGWpv9bUMYz63Jat2yjccSTsGLMDWcvhixogHOWni9KACvS0fs
         eJc/71Ya1VwBcP4gnq1lDGn9VEdxR1F050oWz9JeSQBGcOENXk3kL3usEAgEcxaGkHHu
         besvmAL+yZWxyjGRXev0Yt7+lNpfb5j8kRzaJOiHVqR9aLPvZ55pYaTrIXFB17AGLpXw
         P1a8cqk/FB+64P0KwZD6rStNEdMw/HiTuP6NqU3M34XiWQyqALGjqhj8H+RUqGAl2g3d
         PUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739636465; x=1740241265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oMr9kLTfKManm/UUrjsm3ZodbEL/TxRtX0uLcVKFAno=;
        b=vVhx4nxFsTJZB+PYZDcz7YJS3RCFcpqeGGeclEJmprSrX+7ZKsMjETJ+fBFi2Z2f47
         sLJfdshRlL3xc6hO0yCFGBYzkQKtE/Sjs4CHWdgEKAX0KrK6o9Mc8ZcBOKvBCUjnp4Xv
         pJ2b4HMDnnfUKN+ry95gl7T+NDRyaXmeEjE3vQJ9Tzg9LihZi15hWirayo7OzQrT5eHw
         eqGDsHmnlqlSGK9nhcIt8425eNPbWWGdGD883gvHTU28yQdaLFDNIbg7Eof5aF+b+K5h
         4d8Blp8NSHvgXaRZLet01nRalDKHQn1RPSNsBs7NPCKodSICduSFv3J6PgJ+9hHhnYFO
         qAQQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6iyyBbFmolpgwUUVh+oaNPHcF0KJmBDMGjnXbTq9drkxvoTa9tcwC6G3o+oIdgGch3aM/tH92@vger.kernel.org, AJvYcCVXDpdGGrYlqawtBpX7CYhpJ/+ppu024fY6Bm1ye/x7mpv/bmv53bS3vQIXPUY6Zo05hkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIi+4F+IRDM/kLI92nrswyn/gPIzI8W96qN7fPsWY1JyT84c0u
	g+0epvaytnr6j0mZNA9yXcgVT+2IJS40e5fubJK1PDUfsqiEnyLD0tcfo1rlOfJnD/9g+JYgirW
	G0OzgtY3vf/d29eSP0INrRvwujaQ=
X-Gm-Gg: ASbGncufk2QbRA5GEQu6QK33SDrVj4+CTx9jaJsJb1EsfiKqdMOInyiCBue0iG54QGv
	7isVpdxCnTQ2LwrXnzdxrP++VQPwiULw4jPRzU8as+X8lv6wJv4OHYksWzgn0nSbTUjzKlD8=
X-Google-Smtp-Source: AGHT+IEwxonViDBiv+JKCboR3HbTQrNJhUhbqCDu+zTz3kVlvjWyn66IxEBTvkdyBc0w8yNdJncMfbdN/FBhEh1Ai8c=
X-Received: by 2002:a05:6e02:20cd:b0:3d1:980a:6a7c with SMTP id
 e9e14a558f8ab-3d2807bc6f0mr27639655ab.8.1739636465303; Sat, 15 Feb 2025
 08:21:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214010038.54131-1-kerneljasonxing@gmail.com>
 <20250214010038.54131-9-kerneljasonxing@gmail.com> <67b0ad8819948_36e344294a7@willemb.c.googlers.com.notmuch>
In-Reply-To: <67b0ad8819948_36e344294a7@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 16 Feb 2025 00:20:29 +0800
X-Gm-Features: AWEUYZkdJ3ieNrvQt5iWntR9Wf2OZXPKTe-qJr__MQQy5tegpJ61qdsaB1qVW_4
Message-ID: <CAL+tcoAJHSfBrfdn-Cmk=9ZkMNSdkGYKJbZ0mynn_=qU9Mp1Ag@mail.gmail.com>
Subject: Re: [PATCH bpf-next v11 08/12] bpf: add BPF_SOCK_OPS_TS_HW_OPT_CB callback
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 15, 2025 at 11:06=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > Support hw SCM_TSTAMP_SND case for bpf timestamping.
> >
> > Add a new sock_ops callback, BPF_SOCK_OPS_TS_HW_OPT_CB. This
> > callback will occur at the same timestamping point as the user
> > space's hardware SCM_TSTAMP_SND. The BPF program can use it to
> > get the same SCM_TSTAMP_SND timestamp without modifying the
> > user-space application.
> >
> > To avoid increasing the code complexity, replace SKBTX_HW_TSTAMP
> > with SKBTX_HW_TSTAMP_NOBPF instead of changing numerous callers
> > from driver side using SKBTX_HW_TSTAMP. The new definition of
> > SKBTX_HW_TSTAMP means the combination tests of socket timestamping
> > and bpf timestamping. After this patch, drivers can work under the
> > bpf timestamping.
> >
> > Considering some drivers doesn't assign the skb with hardware
> > timestamp,
>
> This is not for a real technical limitation, like the skb perhaps
> being cloned or shared?

Agreed on this point. I'm kind of familiar with I40E, so I dare to say
the reason why it doesn't assign the hwtstamp is because the skb will
soon be destroyed, that is to say, it's pointless to assign the
timestamp.

>
> > this patch do the assignment and then BPF program
> > can acquire the hwstamp from skb directly.
>
> If the above is not the case and it is safe to write to the skb_shinfo,
> and only if respinning anyway, grammar:

From what I've known about various drivers (although very limited),
it's safe to do the assignment.

>
> s/doesn't/don't/
> s/do/does/

Thanks for catching these things. If the re-spin is necessary, I will
fix them all for sure.

Thanks,
Jason

