Return-Path: <bpf+bounces-42865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF849ABC70
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 05:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 795682830FE
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 03:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B9213665A;
	Wed, 23 Oct 2024 03:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLN9lFCH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD9F17741;
	Wed, 23 Oct 2024 03:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729655388; cv=none; b=VXWG0f1p1j+c8vxuiAhb98zMPXm94mQLLtqEy3pTvxACKAvXr+dTrZtt2pvmY7agoyZJ1Oe2ksZVyXk/0bVs5YY8wUfyrdJRvIQb06DNSHfH9annxD6+fW/bm+bTVYDkOy4hOnHku6mrb6gEVQQHoSwS3M3PjvjwoX0P1HhK/lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729655388; c=relaxed/simple;
	bh=HAdf8JsIB3HzftQdJtOEv1fyrDd2Kusf5Vj0mWEiC3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OedTtJ628DoGaYI7kAbWZWCls+pzN0qBzK2riOte9xWdWhVbLzPNeR5FK+UuSieHwkZEzlkl/QK0ffViSHCHtndCd2HptWatf6p2A3Ck4YKSkoMeDR549TsgMQGoZ+PL103SRb4uMIUY9/s79iFZepqLmmqQltL3rwymJGVa+EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLN9lFCH; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a3b98d8a7eso21725905ab.3;
        Tue, 22 Oct 2024 20:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729655386; x=1730260186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPsFlQSf+mV+7xr9JBn+I09DodkH5Zj2WR+9BAcZWOA=;
        b=fLN9lFCHa7L7oErfOI9leVAAqhZrRL6IqkZ9kQyEEqX5f6GiGCJYXC0PRfFcVX2JX6
         zqnu6tWWX9CI35u+zUXC9fw5QvulliWmj/3xo/YQMwcCfaszkxX3I2N+JyoX7zob+Plf
         67SGVzoUStviSBSETxPWKpGwF7DHAGCZE5bmypjQVMsmEP5lWLSsiyOIAXJVEHpYq0Nu
         svDy3/gvoW4+JnSfntRxUfsypH5HHZOhA3hZg+ME1AajL8ufI4Ggy78mhpjAyzfQTlWW
         wEuQYOwu4QRhTAAxe5+XgG5PJuHw29uLOVKfzkSiA0fMKi92z0+xUN8/JFjpvXaIXqm5
         Ps7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729655386; x=1730260186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yPsFlQSf+mV+7xr9JBn+I09DodkH5Zj2WR+9BAcZWOA=;
        b=a5TI4jORiUwfFkqCurDdqMmoY90PEh7OuHbcsqKouEexpi9nYDq+TRnsVDqe10dmPY
         PiQeA5WZq5jlM/dT6xZlevd7D2/EfBFu8oqBT3Gwq34S0RW0A6BSrOmpsULZcDNMUmnU
         3lJdYj1KH/yL9E4xU+Jw5G9A3Tr/rcSiO/XvuqoDk1pchvHNLUplTcHs3vptiQUM9i1d
         sC1yqEogFXmQExsUJSWlpFXkIi13xPaMgJl7W6Ljr8lsf7r1/nEtU29vR6r1BBjLSHiz
         UCCW2I3bdWSziO47WD5brH1ZwgN+XPekKLnCaCKQFEMXSaN3YAcWunNrXSoYjN4CRqNz
         03qA==
X-Forwarded-Encrypted: i=1; AJvYcCW/OW0F6B2HnUUXjEvQnjyNdhIa011o/xxM2d91gk0saBDHhfRFF4xJ4eFjwW+15l85f71sE2oT@vger.kernel.org, AJvYcCX4nS20/S7Ds7YSLqnfruNluM3SyL13JIt05a13LSGc1vK3udsu1vrxYY5cgzH+utJ1ATc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY6HxOh8rVmasz8vcRfzsusyvU64IDbu6Cnb6g23GbY4qUh7E4
	9T7IdP0U0452BMSInHWFRLMU1epfrcdZIEYJmRZDQEu+mic8rqT3Y625ZWyixP3cq7/oZDzMag8
	A8KtPghrmVvkg9ThDBhdSqzVTdfc=
X-Google-Smtp-Source: AGHT+IFFRseNoEHQLY9aqikuAqdqc/FnKXZgA0CkYAKSgWJY6aYQ/qJTFqjOw50oOCacmiOnHWTOPzc9dmHf1kMgh0s=
X-Received: by 2002:a05:6e02:20e6:b0:3a3:a78a:b6cc with SMTP id
 e9e14a558f8ab-3a4d59cf27bmr12653975ab.20.1729655386038; Tue, 22 Oct 2024
 20:49:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
 <20241012040651.95616-3-kerneljasonxing@gmail.com> <cb96b56a-0c00-4f57-b4b5-8a7e00065cdc@linux.dev>
 <670ee4efea023_322ac329445@willemb.c.googlers.com.notmuch>
 <CAL+tcoCBONnrP_YyE_0n_o4zQUNJfE8DY61f6XRQeeBdGNZMgQ@mail.gmail.com> <67183df34e8e3_1420e5294a2@willemb.c.googlers.com.notmuch>
In-Reply-To: <67183df34e8e3_1420e5294a2@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 23 Oct 2024 11:49:09 +0800
Message-ID: <CAL+tcoASCO5_N+cY0bJYBn8+6C7FzhQ2QtB=8q5zEnrYFNBa3w@mail.gmail.com>
Subject: Re: [PATCH net-next v2 02/12] net-timestamp: open gate for bpf_setsockopt
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 8:06=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > On Wed, Oct 16, 2024 at 5:56=E2=80=AFAM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Martin KaFai Lau wrote:
> > > > On 10/11/24 9:06 PM, Jason Xing wrote:
> > > > >   static int sol_socket_sockopt(struct sock *sk, int optname,
> > > > >                           char *optval, int *optlen,
> > > > >                           bool getopt)
> > > > >   {
> > > > > +   struct so_timestamping ts;
> > > > > +   int ret =3D 0;
> > > > > +
> > > > >     switch (optname) {
> > > > >     case SO_REUSEADDR:
> > > > >     case SO_SNDBUF:
> > > > > @@ -5225,6 +5245,13 @@ static int sol_socket_sockopt(struct sock =
*sk, int optname,
> > > > >             break;
> > > > >     case SO_BINDTODEVICE:
> > > > >             break;
> > > > > +   case SO_TIMESTAMPING_NEW:
> > > > > +   case SO_TIMESTAMPING_OLD:
> > > >
> > > > How about remove the "_OLD" support ?
> > >
> > > +1 I forgot to mention that yesterday.
> >
> > Hello Willem, Martin,
> >
> > I did a test on this and found that if we only use
> > SO_TIMESTAMPING_NEW, we will never enter the real set sk_tsflags_bpf
> > logic, unless there is "case SO_TIMESTAMPING_OLD".
> >
> > And I checked SO_TIMESTAMPING in include/uapi/asm-generic/socket.h:
> > #if __BITS_PER_LONG =3D=3D 64 || (defined(__x86_64__) && defined(__ILP3=
2__))
> > /* on 64-bit and x32, avoid the ?: operator */
> > ...
> > #define SO_TIMESTAMPING         SO_TIMESTAMPING_OLD
> > ...
> > #else
> > ...
> > #define SO_TIMESTAMPING (sizeof(time_t) =3D=3D sizeof(__kernel_long_t) =
?
> > SO_TIMESTAMPING_OLD : SO_TIMESTAMPING_NEW)
> > ...
> > #endif
> >
> > The SO_TIMESTAMPING is defined as SO_TIMESTAMPING_OLD. I wonder if I
> > missed something? Thanks in advance.
>
> The _NEW vs _OLD aim to deal with y2038 issues on 32-bit platforms.
>
> For new APIs, like BPF timestamping, we should always use the safe
> structs, such as timespec64.

Thanks, I learned a lot.

>
> Then we can just use SO_TIMESTAMPING without the NEW or OLD suffix.

Weird thing is that the SO_TIMESTAMPING would be converted to
SO_TIMESTAMPING_OLD in kernel if I use this :
bpf_setsockopt(skops, SOL_SOCKET, SO_TIMESTAMPING, &flags, sizeof(flags));

As I mentioned before, SO_TIMESTAMPING exists in
include/uapi/asm-generic/socket.h:
#if __BITS_PER_LONG =3D=3D 64 || (defined(__x86_64__) && defined(__ILP32__)=
)
/* on 64-bit and x32, avoid the ?: operator */
...
#define SO_TIMESTAMPING         SO_TIMESTAMPING_OLD
...
#else
...
#define SO_TIMESTAMPING (sizeof(time_t) =3D=3D sizeof(__kernel_long_t) ?
SO_TIMESTAMPING_OLD : SO_TIMESTAMPING_NEW)
...
#endif

So I wonder if there is something unexpected?

BTW, I conducted the test on a VM with x86_64 cpu.

Thanks,
Jason

