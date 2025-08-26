Return-Path: <bpf+bounces-66598-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C24B37466
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 23:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32514207C38
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 21:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2964B2FAC0B;
	Tue, 26 Aug 2025 21:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cAMkZsph"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EDB2F83B7
	for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 21:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756243493; cv=none; b=iNjvPlXl0VcoNG3ptcDpPOE5+mQC+8ElIZB0q8gqlCsx31T8F92mXKsQh10oCLN+YJpnsYQyQrlpQN4fyAT8RuecmtyOWBZTxfy3azAWPdcere3mU1RYwKLmq/u+eMO5z6jYspOQ1hHUse0lbep9Il3qFbOCW884v7sWEtlNgtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756243493; c=relaxed/simple;
	bh=VIiyrSqLG+vgF73thMJ1FZqyyfPAKoDCgtbBzE29VtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s/rNO9/yQV1qNlXJy+2H4LcD7yiDAxSFSrEiIz2DWR4Lrmsz5OcCtWBW+vnj6inA3t4wYbrStgQAe1oWeTuWHecytA6oZd2uQIT4/gQhPIk5QDJuAqE8wn9kT33j2tzDOlGOK8RLjVqf4wQkQ9N/XrwL+ZGC3fijod+VeVJBxNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cAMkZsph; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2487104b9c6so10692595ad.0
        for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 14:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756243491; x=1756848291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9B1276hphs7ULbe2JVDIArBKHCuzM07N66UKV8tf9VA=;
        b=cAMkZsphPBTJVAXWNFOed6eLXkliXPB+GrOvoRO6NsCsGM6bGGNv4H4aZDtoVC1gKJ
         +0zFejcTE1nuRdqV+8CtLKBsVdnrfNK9uT08bbK7V52OH/I6ZlwnKAqVpPAVS2w8FOYP
         xbdyzG/KtBYGrPDmwACVrrk7xT9c5O8dBN3LgP+KjO/0ZGv6J9AMvObmSxH7Z5jnK5Br
         ZGdFklt79nCOB3EPMOIbXnKOUMa/eTEt0/NY+WZDr3jTuECzNrEkwVaj2J5W8x+SXThe
         8ljXREKm2V0c1m1latDLSLMZjjE1Ixyzqlt4J8A/I+W6LvTA67+pwZTrKhDYhk8lgjuw
         e1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756243491; x=1756848291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9B1276hphs7ULbe2JVDIArBKHCuzM07N66UKV8tf9VA=;
        b=L/oH0YmncpF1SSm9p+tnEo5pKvjcp5QaSDM1UuwrtWwjT/LYOgy2PD3n42PxF0qD+h
         M077fEzbbMvZWqdEjvUe1a4uKinC9yXE4e0Q9/wTjZiCV5RbcFUhejuyApOl6s1pI/aV
         SiA32GrdCKeH5mTBoGl6qvlRfeXUhvlYz3san1p4oB8qbMQWh/QEHY2HjWoF2l5Nyvmp
         7hWUIn6RiAnuc8j8iofnWbVRVU5xu0/rZo+pBfdHaAaHpgep0l10tdYQ2Q8M8LH1YHFj
         kdF7PAFioGqcS34OeiwkEZL6ERPBj+wxdRzuX1T6uyS2SeDUOqId8SMEOSI/tcmp+BJr
         O7JA==
X-Forwarded-Encrypted: i=1; AJvYcCVxSXu04oxRJrQQzzXFT14Y7og7zA7RokVtBAR4/RCoovFK3wbagPODYP0+QXCbyhOUxfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP8R6JHtRxPLy6WaD8JYyxtXv8iAqQLP1S6Du7fSjPP/oDFHsF
	VC1WAW6G2NqPNofUS2wCofh8Cd38I3Y+OZSEp4AebcRxQ3g6UGpoVClKCZ1jwqNBS/XzCLaWi7W
	DqfSxHnVKsCVJjvR0xRiX4Q4FtbV7B+m+GAIBsYS/
X-Gm-Gg: ASbGncvW/lsRMxnQcSfLKeuQ9pFDpGQc/esiwisigtjuQtMqVx3AloNMPfn+RXQvjmh
	rtd1Yy4Y3Gfyy+rqgmmxqmM5N9yzRTLad0iGoe1nBQ8bVGj81RN2Tv5mO/CMCzZY7acKnMTQiOu
	vu+LdhsaRgEz5KLlb2FVV0NH9Hsk1ZNRyQ4Boh03ZnyUwFROSzh+CJkqpa8A+TqUEKhsURvOdVB
	QzOOHJvBk6+9DJ3WjquXwqChTh2/+hRR3b6Y841eruNdWIKCy3bWwrZCOKv9jhcEPyVgYVQ8xc=
X-Google-Smtp-Source: AGHT+IHLq1gemrW5FOQ8J+SVgDRvPZuS0+b2YwjoTLEqHXZr1nwf9zJN1MoCpZ8aamhKtFNsfhiLrSrW21/GXm2U0hI=
X-Received: by 2002:a17:902:f707:b0:246:115a:e5e6 with SMTP id
 d9443c01a7336-2462ef4962cmr239367055ad.42.1756243491292; Tue, 26 Aug 2025
 14:24:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826183940.3310118-1-kuniyu@google.com> <20250826183940.3310118-3-kuniyu@google.com>
 <aK4g640zGakSxlD9@mini-arch>
In-Reply-To: <aK4g640zGakSxlD9@mini-arch>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 26 Aug 2025 14:24:40 -0700
X-Gm-Features: Ac12FXxWrzjfG9SW-BvA8V57F_LVNX5ynmGN74H44sYRyRW6GLwLkog3Eu0eOUc
Message-ID: <CAAVpQUARxRTbmFiNE5GuO03qQAikddhT=BLcTWJVHvwK_Yq=Pg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next/net 2/5] bpf: Support bpf_setsockopt() for BPF_CGROUP_INET_SOCK_CREATE.
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 2:02=E2=80=AFPM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 08/26, Kuniyuki Iwashima wrote:
> > We will store a flag in sk->sk_memcg by bpf_setsockopt() during
> > socket() or before sk->sk_memcg is set in accept().
> >
> > BPF_CGROUP_INET_SOCK_CREATE is invoked by __cgroup_bpf_run_filter_sk()
> > that passes a pointer to struct sock to the bpf prog as void *ctx.
> >
> > But there are no bpf_func_proto for bpf_setsockopt() that receives
> > the ctx as a pointer to struct sock.
> >
> > Let's add a new bpf_setsockopt() variant for BPF_CGROUP_INET_SOCK_CREAT=
E.
>
> [..]
>
> > Note that inet_create() is not under lock_sock().
>
> Does anything prevent us from grabbing the lock before running
> SOCK_CREATE progs? This is not the fast path, so should be ok?
> Will make it easier to reason about socket options (where all paths
> are locked). We do similar things for sock_addr progs in
> BPF_CGROUP_RUN_SA_PROG_LOCK.

We can do that, but the reasoning here is exactly same with
how we allow unlocked setsockopt() for LSM hooks.  Also, SA_
prog actually needs lock_sock() to prevent sk->{addr fields} from
being changed concurrently.

---8<---
/* List of LSM hooks that trigger while the socket is _not_ locked,
 * but it's ok to call bpf_{g,s}etsockopt because the socket is still
 * in the early init phase.
 */
BTF_SET_START(bpf_lsm_unlocked_sockopt_hooks)
#ifdef CONFIG_SECURITY_NETWORK
BTF_ID(func, bpf_lsm_socket_post_create)
BTF_ID(func, bpf_lsm_socket_socketpair)
#endif
BTF_SET_END(bpf_lsm_unlocked_sockopt_hooks)
---8<---

