Return-Path: <bpf+bounces-16283-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF10D7FF456
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 17:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC78B1C20C5E
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 16:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D935466A;
	Thu, 30 Nov 2023 16:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mDIdWTHr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F0C10D5
	for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 08:05:05 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-54b0c368d98so12591a12.1
        for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 08:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701360304; x=1701965104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=py/UYRyeys28a8i4kga7u2wKQX1+4E1lmesjjnOgCD8=;
        b=mDIdWTHrw9DVk7xHxd9mDRRWvuD7LLCYUjrdGPT38BJpuiNmarg0NRRigpmgK4wz6W
         qgHv3RSgWdKIqrPxY0InFmI4Y/4E2xprCySyJgywcQgyj3avSVyvJoUeBB4e6kpwLjcV
         +hCgaVz9n1rSoGkkDYXalCtK+vClpZBbV7vQQ8flIdCxrf/0OrnF9WNOrS5ct8Jn/obf
         Fh5fMMA1KHTKkasOkEbiek5Vx4oJ7AxciMxjqxluRFy0/6HxcG+M1615a8gKpNMrNcCi
         nnEoPArJYg7sMHiAzRp8DJOTL/P5XDYZrEu/etqU1nBWsSWz7HvQja/90R42zpdRGPWo
         kfRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701360304; x=1701965104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=py/UYRyeys28a8i4kga7u2wKQX1+4E1lmesjjnOgCD8=;
        b=GoSQuJVoBRr04na+KigMGsP010bi+lX7doj+bxu3+SNQU2t42BcJmL+PDP/MLac1Mh
         qaFA9En8Zmsjqk7Ofuymjp0EwiNsayLYL8cPQxOebJZeSmauqqEppwuX0403XyJGRZHX
         u1ZFIe0PU7G79iBJrF12iK+Tufa15YGdo1i4/R7ixHvckdIS3pFB9F/V8v7oyTAOepHK
         bmESu9YFJPsaC8T5Aco1/Mvz84c4ELMrDNeKzDMZ1k5oMFQg33tun1k2usGQQ0VLqmin
         n4oGdpdYobMz8/3+TLtBHR0nOZ/KIaJb3x2M2wR8Dluhr++uDR2fNHRdtxbU790sgMTP
         90fw==
X-Gm-Message-State: AOJu0Yy3f0YPqFd982+rqeQxYNY5QoB0EFuL8An+RWNrcdnpDPd5kCbE
	SkN7NlyxvrHH106ey5PYv/8Z1adh5aFQe7RexooREw==
X-Google-Smtp-Source: AGHT+IHiX/yaU3mC6vkAZLouB0rZDjFCvjF0MByDKZWp9pOIJXPlUJogCYBhUQSR8ZGDMh5Fzb3+d+gtEkO0LjexB+A=
X-Received: by 2002:a05:6402:1cae:b0:54b:81ba:93b2 with SMTP id
 cz14-20020a0564021cae00b0054b81ba93b2mr190505edb.2.1701360304140; Thu, 30 Nov
 2023 08:05:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129234916.16128-1-daniel@iogearbox.net> <CANn89i+0UuXTYzBD1=zaWmvBKNtyriWQifOhQKF3Y7z4BWZhig@mail.gmail.com>
 <edef4d8b-8682-c23f-31c4-57546be97299@iogearbox.net> <6568b03cbceb7_1b8920827@john.notmuch>
In-Reply-To: <6568b03cbceb7_1b8920827@john.notmuch>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 30 Nov 2023 17:04:50 +0100
Message-ID: <CANn89iK9VrbRJsF2KoLfArv5Eu5d7Hyq-pSO4hmWuS_PNsM8dQ@mail.gmail.com>
Subject: Re: pull-request: bpf 2023-11-30
To: John Fastabend <john.fastabend@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, jakub@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 4:54=E2=80=AFPM John Fastabend <john.fastabend@gmai=
l.com> wrote:
>
> Daniel Borkmann wrote:
> > On 11/30/23 3:53 PM, Eric Dumazet wrote:
> > > On Thu, Nov 30, 2023 at 12:49=E2=80=AFAM Daniel Borkmann <daniel@ioge=
arbox.net> wrote:
> > >>
> > >> Hi David, hi Jakub, hi Paolo, hi Eric,
> > >>
> > >> The following pull-request contains BPF updates for your *net* tree.
> > >>
> > >> We've added 5 non-merge commits during the last 7 day(s) which conta=
in
> > >> a total of 10 files changed, 66 insertions(+), 15 deletions(-).
> > >>
> > >> The main changes are:
> > >>
> > >> 1) Fix AF_UNIX splat from use after free in BPF sockmap, from John F=
astabend.
> > >
> > > syzbot is not happy with this patch.
> > >
> > > Would the following fix make sense?
> > >
> > > diff --git a/net/unix/unix_bpf.c b/net/unix/unix_bpf.c
> > > index 7ea7c3a0d0d06224f49ad5f073bf772b9528a30a..58e89361059fbf9d5942c=
6dd268dd80ac4b57098
> > > 100644
> > > --- a/net/unix/unix_bpf.c
> > > +++ b/net/unix/unix_bpf.c
> > > @@ -168,7 +168,8 @@ int unix_stream_bpf_update_proto(struct sock *sk,
> > > struct sk_psock *psock, bool r
> > >          }
> > >
> > >          sk_pair =3D unix_peer(sk);
> > > -       sock_hold(sk_pair);
> > > +       if (sk_pair)
> > > +               sock_hold(sk_pair);
> > >          psock->sk_pair =3D sk_pair;
> > >          unix_stream_bpf_check_needs_rebuild(psock->sk_proto);
> > >          sock_replace_proto(sk, &unix_stream_bpf_prot);
> > >
> >
> > Oh well :/ Above looks reasonable to me, thanks, but I'll defer to John=
 & Jakub (both Cc'ed)
> > for a final look.
> >
> > Thanks,
> > Daniel
>
> Is that sk in LISTEN state by any chance? I can't think why we even allow=
 such a
> thing for af_unix sockets.  Another possible fix would be to block adding=
 these
> to sockmap at all.
>
> But, above should be fine as well so I would just go with that. Eric or D=
aniel
> would you like to submit a patch or I can if needed.

Here is the repro:

# See https://goo.gl/kgGztJ for information about syzkaller reproducers.
#{"procs":1,"slowdown":1,"sandbox":"","sandbox_arg":0,"close_fds":false}
r0 =3D socket(0x1, 0x1, 0x0)
r1 =3D bpf$MAP_CREATE(0x0, &(0x7f0000000200)=3D@base=3D{0xf, 0x4, 0x4, 0x12=
}, 0x48)
bpf$MAP_UPDATE_ELEM(0x2, &(0x7f0000000140)=3D{r1, &(0x7f0000000000),
&(0x7f0000000100)=3D@tcp6=3Dr0}, 0x20)

I will release the syzbot report, and send the patch, thanks.

