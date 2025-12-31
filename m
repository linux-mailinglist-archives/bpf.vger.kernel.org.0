Return-Path: <bpf+bounces-77592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B365CEC391
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 17:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E2593007214
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 16:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4F0281358;
	Wed, 31 Dec 2025 16:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="NJq5/8sa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDEC2798F3
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 16:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767197980; cv=none; b=GVtVfDIyd9JXioEjVJHUyDq+9VtNa+Wxzz3rpqLLeDmTsda4qHqdBKXZEoGdymZmKNuH+XPl4xj3E2+KyxWMt/9cZheDtx8Ue0qK8K/I4rW8Qo68KCy9Rsj7kwt6kNWEsDcoSNS8XKDnIETxXJ8f6lAeuSzzj3lqjEOxhcjlNzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767197980; c=relaxed/simple;
	bh=PV9ObsaQUslm7ksahgGL6hbKXHBuW4VSBTs6JUgThHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lG2MHTBTzk27T5Cn6SvQzSklmzRaH5w1XdDCBMFgKMxY5ABUheWoMu3I8XiufpgVIyL2Wb0ujy4EfkZ5Ka+Ch4RwlQdzd7NA9ZnFyqGUrrFPKuKkDBQqJ6oZlJm45M25bMAM5La+sqcAIFGbyfqH5feJ/xs/xboAMMaADAO9m/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=NJq5/8sa; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a08c65fceeso21942165ad.2
        for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 08:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767197977; x=1767802777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBYry6OKDc4usUoNKMCcIdOf7nJmUX0YNZVCMO040LQ=;
        b=NJq5/8sa8zs3UBvKMDu9hpUnlFj3gjMBQijcfmrLdIiIzewmKfrLLGV03kwPaBBvzV
         llOKB8dMnRqsIsmTdw1v7y8rn9j6IXp4PtZ1Le050uADXapgflq1Tg2AH+HedfHt1uY6
         tfWsS4d5yUtFwkR3fKHr5y8PfCOqZ93AiXAgevt4GL2FUG6dcvjbwG+txlwUxSXMxXCB
         fFHuDlpAqR12qDEnjrcBOzYmmYWxpKJDtViW/waFlIMcXSzf5Wt6OgHu/yjjCJzCe8On
         vK1AEnqN+cJoY77BNye8PTesFgNQ4i8FDO+PP4fR7cN0uwmFhs7L0E/YWub7LHavEi1R
         JS2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767197977; x=1767802777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZBYry6OKDc4usUoNKMCcIdOf7nJmUX0YNZVCMO040LQ=;
        b=s1tMCkDPeS0aTv24Dk5KvVKZhR/RMkGZ46mRdZXDd1wF6vHdJsSn1ndKEhtHVi/Gje
         7aRwEW1qI5ByWECC/94DAhfsZzQV9gtNEBMQBJw+KqTdg7NyJxzPwOYTrv85d7Kg55sd
         GhSYP1abIxOOM3JNfaF60XOcZO9bSGy7xLy3aV03k64QsPjuF9TlzEXAvRvopahwhSdZ
         lvmFukBVJ49K/9wsTIKmOEUvuzmZsAgRW7RcTHNPLkGewkbBnNoz4VPjOs0EDHcFcZyB
         RBveu7cYS9bGaPjoi7V12u32NrnR0PEAXPZasriBWQD+3/yYFWG+9Es38XwByKJ5U5+I
         HllA==
X-Forwarded-Encrypted: i=1; AJvYcCVXRU65Sv0Q9cWbMCvJmypBbPvCfDsV7qLU7LR/ECO+C3ZOFKsBQZaNmSlGHzmcWEOSebM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9INCGOOyEopcw/ho/mQGHZbvIyrM3K/JzsmCJuPNVr3VOHji/
	cxv7+koyW0GWmV5oOcQWPb0+AKjGsovCFegsQB5Uh8KlP69wLGpG5evZgpbjAAh8uqDK3v6o2Vr
	oG08c8gMeN3xBBtwz/86zSEfx8syk51luVApGDRm2TQ==
X-Gm-Gg: AY/fxX4aF4Rt9aGmMjJ7Yn8tmuwgqlmOaofDcDb3WvxCS9KfnmQRyk+ywXHD/5tOmr+
	F2tqprC6hu6wxjA4BLh72HZI6xRHT7dFqyaxmDNkjvNlG74eYvVoz5mUNggKRFAcr0qzhvv1wKI
	vNYu85ii6Z8VzAv6Uc+OUePk83GsrrIqyo00RUoLYxJRmiezwYrG4dQ8RJeSCkjukRhDBmLxP8q
	jkNAWfwpmytIIjZGZKxK2ZHfk7sfCnAtJ70CeDehhHnmM2GsizTmC8uPhsKx77Bs2ChtGT1WnsJ
	c5PM/Ow=
X-Google-Smtp-Source: AGHT+IHzoNDr9r+qi9ocI9cVRAchOZIvTAjPMMn+KafiawGwKaZ+9XvlCd9qvScOO5sndGrhbpLtTkeJtqRSyHnOi6Y=
X-Received: by 2002:a05:7022:264a:b0:11b:862d:8031 with SMTP id
 a92af1059eb24-121721380fcmr14016919c88.0.1767197977253; Wed, 31 Dec 2025
 08:19:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104162123.1086035-1-ming.lei@redhat.com> <20251104162123.1086035-3-ming.lei@redhat.com>
 <CADUfDZonj-mn9oOF-cGgw2TS9Emmk0vP=3=+n0bJbhGw43ra3A@mail.gmail.com> <aVTxt_0DR1ZEE8SW@fedora>
In-Reply-To: <aVTxt_0DR1ZEE8SW@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 31 Dec 2025 11:19:26 -0500
X-Gm-Features: AQt7F2p4EOIPXBDxgprHZrrJrnKJFgWuhyUpAGGR4g2NtbTtcmUPKlwJ8nVscLg
Message-ID: <CADUfDZq7uVkQ_Xac9=DUogWvomD+oD3ahSawd82XFa2yoJ3JxQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] io_uring: bpf: add io_uring_ctx setup for BPF into
 one list
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	Akilesh Kailash <akailash@google.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 1:49=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Tue, Dec 30, 2025 at 08:13:51PM -0500, Caleb Sander Mateos wrote:
> > On Tue, Nov 4, 2025 at 8:22=E2=80=AFAM Ming Lei <ming.lei@redhat.com> w=
rote:
> > >
> > > Add io_uring_ctx setup for BPF into one list, and prepare for syncing
> > > bpf struct_ops register and un-register.
> > >
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >  include/linux/io_uring_types.h |  5 +++++
> > >  include/uapi/linux/io_uring.h  |  5 +++++
> > >  io_uring/bpf.c                 | 15 +++++++++++++++
> > >  io_uring/io_uring.c            |  7 +++++++
> > >  io_uring/io_uring.h            |  3 ++-
> > >  io_uring/uring_bpf.h           | 11 +++++++++++
> > >  6 files changed, 45 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_=
types.h
> > > index 92780764d5fa..d2e098c3fd2c 100644
> > > --- a/include/linux/io_uring_types.h
> > > +++ b/include/linux/io_uring_types.h
> > > @@ -465,6 +465,11 @@ struct io_ring_ctx {
> > >         struct io_mapped_region         ring_region;
> > >         /* used for optimised request parameter and wait argument pas=
sing  */
> > >         struct io_mapped_region         param_region;
> > > +
> > > +#ifdef CONFIG_IO_URING_BPF
> > > +       /* added to uring_bpf_ctx_list */
> > > +       struct list_head                bpf_node;
> > > +#endif
> > >  };
> > >
> > >  /*
> > > diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_ur=
ing.h
> > > index b167c1d4ce6e..b8c49813b4e5 100644
> > > --- a/include/uapi/linux/io_uring.h
> > > +++ b/include/uapi/linux/io_uring.h
> > > @@ -237,6 +237,11 @@ enum io_uring_sqe_flags_bit {
> > >   */
> > >  #define IORING_SETUP_SQE_MIXED         (1U << 19)
> > >
> > > +/*
> > > + * Allow to submit bpf IO
> > > + */
> > > +#define IORING_SETUP_BPF               (1U << 20)
> >
> > Is the setup flag really necessary? It doesn't look like there's much
> > overhead to allowing BPF programs to be used on any io_ring_ctx, so I
> > would be inclined to avoid needing to set an additional flag to use
> > it.
>
> It is used for dealing with unregistering & registering bpf prog vs. hand=
ling IO.

It looks like it's only necessary because the io_uring BPF program
lookup uses uring_lock for protection instead of srcu in contexts
where uring_lock is already held. So then registering and
unregistering an io_uring BPF program requires acquiring uring_lock
for all io_ring_ctxs that support BPF programs. I think this mechanism
could be avoided entirely if the BPF program were specified by bpf_fd
instead. Then it would be protected by the existing RCU + refcount of
a file descriptor lookup. The bpf_fd could also be registered as an
io_uring fixed file to avoid the reference count overhead, in which
case the lookup would be protected by uring_lock.

Best,
Caleb

