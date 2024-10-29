Return-Path: <bpf+bounces-43410-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8828E9B52EB
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 20:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A03E1F23D16
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 19:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B4E20606D;
	Tue, 29 Oct 2024 19:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHPopEG3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A1D19A2A2;
	Tue, 29 Oct 2024 19:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730231143; cv=none; b=tLBV4Ej9bmuPEX3MvwRolSobz5Cy1fA3kE+HPM3AIcxOYm0WayersxI3tDJZOWPt/J0Fjq8mk0VDtAbE3bxQIQ/oMWfDUQbhErnEMdyFkpGXOKMUCl/rGNyPVfZs3yjXM8lhCZ0PHXCcox4FvXB0I2ZkZ/s/MI5Ue3Fs1tAS9cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730231143; c=relaxed/simple;
	bh=4hwtZFDfg+dx9ftK8Ab16rSuGce3VQPmw54/oonESl4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=KiyquWifnF9BXdTx4nu8Y9TWoOcjZQ/GIh/IFKASVP7NTupZk+HqcEuJwPqM1D85QCC/BvCgHDw7xlbQqfFcNHfc51jIerCgqjsKxuOdOL6YW7B/p7YsKUME0S4vIf5rRJsX3q6y9Gmp5DrRo1k9PTpeJEFAQnWYUuXXQBu6ZN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XHPopEG3; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6e38ebcc0abso69358257b3.2;
        Tue, 29 Oct 2024 12:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730231140; x=1730835940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oz++kog8R11S3FQCFfJ3vXqUAJV3rP07MP62qfhNccM=;
        b=XHPopEG3pvI3dgjjURAVjd2bDK3bWm1fBM5U7RFQZy2hd+yI9U4g8MOzOFmQws8bn4
         bCF4E5puGkbiO1n2MlocJtoIsQDLR+cVMEV/wq7YJGj/rvCPvNPPX2uGuheIU8tM3gxi
         gIRyC9P2sm9BHEsaaDkGKRj9cKJ/bar3YggLWSrWPF2r80umQ/tNfr/nPc3V7c2W9HjH
         W611Sui3f0nKMHpk20X4cnWQl+dvrjTABmSefZOzjag3uScOsDB71nwwoumflJmRYxa6
         7ZA58+TcWmeotgsB76u0Rr+7XAt8120avmYaj3Svh+88h/FdJwJDkkKikVNgXa7xmyNv
         gd1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730231140; x=1730835940;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oz++kog8R11S3FQCFfJ3vXqUAJV3rP07MP62qfhNccM=;
        b=vCbZBh8MfMP4WXwa6DgbKCm8qUO+ZlqDT7uBaigunUiomPn/vDyaYRjFv4oA+RNt42
         FAJnd7LnClgLs9CbU2PKcvO9nqLoYBX2Tq+kZlChmootZDxwmk+61yg4vlwvRVL/g8/I
         lQ8/fMQTgILnOZZcC0o8jiZNeORX8In8z5Y3c7jKuwkhs4AotmyYuz9hqmlR4RNMv0Fu
         y9c7c0W8fnwqwNjehMs0hUA2GAJkcFFNUhiLHOt7YJrJaCJEiS4zDlAlXz1cwi6l/lbD
         3S3v69EqS1Ok53Y1ASCjE7xfi6isRK5nVS9gqaGgp3UJJ8sIkf/vyXY8yojZ127KRj8x
         eVAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtpOAhXiV08YqACcKvE7kTVqZ0OCPL1sQoHbXKOM5lb27oWBV52VU24K44ahYUNHV6QnUMPB3L@vger.kernel.org, AJvYcCX6jdvhpQpsY1lPDVBH4UwgzGsQs9xhwVis7HM6CrrqSvtemi5zR5F52mT3E8DDmtv2d0o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb+0c4bdgDSAuGLqCBh/vNsaCAL3DTVpsZHWvB3IpZGnUkCIn+
	6JCqzcngWJegrC07UJMFdkIS7MafwWKOiQOk3176un5qAQHFQnDF
X-Google-Smtp-Source: AGHT+IGefUc29igJ+8c98f9qeJDl8r1WcdXQSM3Jul9t145O9JP4e+N+g/lecyY1/o+l6jcIXRFPbQ==
X-Received: by 2002:a05:690c:10c:b0:6e7:de90:315f with SMTP id 00721157ae682-6e9d8aa57d6mr103857007b3.28.1730231139998;
        Tue, 29 Oct 2024 12:45:39 -0700 (PDT)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d179a2b073sm45095946d6.110.2024.10.29.12.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 12:45:39 -0700 (PDT)
Date: Tue, 29 Oct 2024 15:45:39 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemb@google.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
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
Message-ID: <67213b62f4100_2f188c294b7@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoCDN+YSwXDocv9DcvPGW-sLhEfPHHbzcO2+1PBZFRkB0Q@mail.gmail.com>
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <20241028110535.82999-11-kerneljasonxing@gmail.com>
 <6720394714070_24dce62944a@willemb.c.googlers.com.notmuch>
 <CAL+tcoBgbA1Q_7UaC0vp-mGHqDHxQ+eMybep0kw=E-T0oJAHfw@mail.gmail.com>
 <6720f9359d2ef_2bcd7f29458@willemb.c.googlers.com.notmuch>
 <CAL+tcoCDN+YSwXDocv9DcvPGW-sLhEfPHHbzcO2+1PBZFRkB0Q@mail.gmail.com>
Subject: Re: [PATCH net-next v3 10/14] net-timestamp: add basic support with
 tskey offset
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

> > > > > +static long int sock_calculate_tskey_offset(struct sock *sk, int val, int bpf_type)
> > > > > +{
> > > > > +     u32 tskey;
> > > > > +
> > > > > +     if (sk_is_tcp(sk)) {
> > > > > +             if ((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN))
> > > > > +                     return -EINVAL;
> > > > > +
> > > > > +             if (val & SOF_TIMESTAMPING_OPT_ID_TCP)
> > > > > +                     tskey = tcp_sk(sk)->write_seq;
> > > > > +             else
> > > > > +                     tskey = tcp_sk(sk)->snd_una;
> > > > > +     } else {
> > > > > +             tskey = 0;
> > > > > +     }
> > > > > +
> > > > > +     if (bpf_type && (sk->sk_tsflags & SOF_TIMESTAMPING_OPT_ID)) {
> > > > > +             sk->sk_tskey_bpf_offset = tskey - atomic_read(&sk->sk_tskey);
> > > > > +             return 0;
> > > > > +     } else if (!bpf_type && (sk->sk_tsflags_bpf & SOF_TIMESTAMPING_OPT_ID)) {
> > > > > +             sk->sk_tskey_bpf_offset = atomic_read(&sk->sk_tskey) - tskey;
> > > > > +     } else {
> > > > > +             sk->sk_tskey_bpf_offset = 0;
> > > > > +     }
> > > > > +
> > > > > +     return tskey;
> > > > > +}
> > > > > +
> > > > >  int sock_set_tskey(struct sock *sk, int val, int bpf_type)
> > > > >  {
> > > > >       u32 tsflags = bpf_type ? sk->sk_tsflags_bpf : sk->sk_tsflags;
> > > > > @@ -901,17 +944,13 @@ int sock_set_tskey(struct sock *sk, int val, int bpf_type)
> > > > >
> > > > >       if (val & SOF_TIMESTAMPING_OPT_ID &&
> > > > >           !(tsflags & SOF_TIMESTAMPING_OPT_ID)) {
> > > > > -             if (sk_is_tcp(sk)) {
> > > > > -                     if ((1 << sk->sk_state) &
> > > > > -                         (TCPF_CLOSE | TCPF_LISTEN))
> > > > > -                             return -EINVAL;
> > > > > -                     if (val & SOF_TIMESTAMPING_OPT_ID_TCP)
> > > > > -                             atomic_set(&sk->sk_tskey, tcp_sk(sk)->write_seq);
> > > > > -                     else
> > > > > -                             atomic_set(&sk->sk_tskey, tcp_sk(sk)->snd_una);
> > > > > -             } else {
> > > > > -                     atomic_set(&sk->sk_tskey, 0);
> > > > > -             }
> > > > > +             long int ret;
> > > > > +
> > > > > +             ret = sock_calculate_tskey_offset(sk, val, bpf_type);
> > > > > +             if (ret <= 0)
> > > > > +                     return ret;
> > > > > +
> > > > > +             atomic_set(&sk->sk_tskey, ret);
> > > > >       }
> > > > >
> > > > >       return 0;
> > > > > @@ -956,10 +995,15 @@ static int sock_set_timestamping_bpf(struct sock *sk,
> > > > >                                    struct so_timestamping timestamping)
> > > > >  {
> > > > >       u32 flags = timestamping.flags;
> > > > > +     int ret;
> > > > >
> > > > >       if (flags & ~SOF_TIMESTAMPING_BPF_SUPPPORTED_MASK)
> > > > >               return -EINVAL;
> > > > >
> > > > > +     ret = sock_set_tskey(sk, flags, 1);
> > > > > +     if (ret)
> > > > > +             return ret;
> > > > > +
> > > > >       WRITE_ONCE(sk->sk_tsflags_bpf, flags);
> > > > >
> > > > >       return 0;
> > > >
> > > > I'm a bit hazy on when this can be called. We can assume that this new
> > > > BPF operation cannot race with the existing setsockopt nor with the
> > > > datapath that might touch the atomic fields, right?
> > >
> > > It surely can race with the existing setsockopt.
> > >
> > > 1)
> > > if (only existing setsockopt works) {
> > >         then sk->sk_tskey is set through setsockopt, sk_tskey_bpf_offset is 0.
> > > }
> > >
> > > 2)
> > > if (only bpf setsockopt works) {
> > >         then sk->sk_tskey is set through bpf_setsockopt,
> > > sk_tskey_bpf_offset is 0.
> > > }
> > >
> > > 3)
> > > if (existing setsockopt already started, here we enable the bpf feature) {
> > >         then sk->sk_tskey will not change, but the sk_tskey_bpf_offset
> > > will be calculated.
> > > }
> > >
> > > 4)
> > > if (bpf setsockopt already started, here we enable the application feature) {
> > >         then sk->sk_tskey will re-initialized/overridden by
> > > setsockopt, and the sk_tskey_bpf_offset will be calculated.
> > > }
> 
> I will copy the above to the commit message next time in order to
> provide a clear design to future readers.
> 
> > >
> > > Then the skb tskey will use the sk->sk_tskey like before.
> >
> > I mean race as in the setsockopt and bpf setsockopt and datapath
> > running concurrently.
> >
> > As long as both variants of setsockopt hold the socket lock, that
> > won't happen.
> >
> > The datapath is lockless for UDP, so atomic_inc sk_tskey can race
> > with calculating the difference. But this is a known issue. A process
> > that cares should not run setsockopt and send concurrently. So this is
> > fine too.
> 
> Oh, now I see. Thanks for the detailed explanation! So Do you feel if
> we need to take care of this in the future, I mean, after this series
> gets merged...?

If there is a race condition, then that cannot be fixed up later.

But from my admittedly brief analysis, it seems that there is nothing
here that needs to be fixed: control plane operations (setsockopt)
hold the socket lock. A setsockopt that conflicts with a lockless
datapath update will have a slightly ambiguous offset. It is under
controlof and up to the user to avoid that if they care.

