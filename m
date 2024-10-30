Return-Path: <bpf+bounces-43465-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D12E9B5911
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 02:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F38F92846C5
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 01:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CD91494DB;
	Wed, 30 Oct 2024 01:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQRxC2Dz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3A4450FE;
	Wed, 30 Oct 2024 01:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730251439; cv=none; b=dazHashMdMyK3sLXf6GFmOHuwnhnKgWwWZoXr6W0irc7yQwyD3r+2hblopH5/SSe+G24KzfyjBWYUsU5AvniftrUeqpQRNsb1Db7DEWpPepwIoaDBiLfaL3kOVC8Fls+xpm5jxx9EYxsMIvwe8B/+PdrODDKACWTAArxHLISvms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730251439; c=relaxed/simple;
	bh=enLYmWeNZrKJvYr/sIMBVDFod5Dv9dd9O9OapZkj0JI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sQAYkA1uNpog/QtiwB1sPWvHYY3ITev0Ub+NOJEWXmUGXRJmLRjjRcTTOKFv7eMIANjE5ZL7kUqT1OazhlWkoSv8Hle5YTNiEJyoVKF2Evt5LU3lpROTBUUzJHyJ7bOUAorwxNoa2OK8U+dpJp1lnquOQUnexrd7nF94pZpi1Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQRxC2Dz; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a3a5cd2a3bso25271505ab.3;
        Tue, 29 Oct 2024 18:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730251437; x=1730856237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBPt5dUGPyCr944qr1Db7HUAEB1EjFLqAaybQAiUx0g=;
        b=NQRxC2DzCklDAx4aK99e5uG76XT2d4HWGo+9C0JKllO3V2UvhOKxdLCTjoxDZZp1So
         PNI6hi/j0DD3ZQir9hwDD6r9WTzhdDQVlQZRL11YjDBWANvpB3DXyNJdMUQa19YoRVUL
         hGWl9JiwLbARx01md0uGeAMhTjA2zmxEfPQJ6b75HYBU5l7daxfFtxDOJdKHcYEIjOzN
         FsUdFiLXRPDHtcHQyO9obVx167fLZDaUZhz9GBIrbNdd3IZ8FKQkkVAXtjIpagmBTvBJ
         SRK2fQQmCZKUSbxWJ+xE9HIeMG7wLEkkVzCwD5oZdZ9FFZgH8pC5mcpGtmsjaad/7hir
         l1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730251437; x=1730856237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DBPt5dUGPyCr944qr1Db7HUAEB1EjFLqAaybQAiUx0g=;
        b=pf0orPwKS5jKjodXqfhAQ5t1Rhyr6E9wrpuQR0lBZBhRVATRX6xz7YNe1d+gmCUPVg
         mjfhYlAol3UewF7/+nbPYi+HjoP+CI5rgC7n/bGa3p/guMuCWbUsvYJpy0+q8HESP7vA
         UnuFzGAqyeiCPFDGNiFUMu/cl1AUk7GN/a1JVCYhG/NaXv98qYxMBzy4+xbtq29bXKcc
         WuIIqqbAbgv9L0zBleKfZAavdnp5x6DN5zmeF5Edcg2ZlvTgEVf7b1ZjK/b7fQXIl48Q
         B3IogBCswjO45LrwTRDe1ctdcjjOrCt6S0ag2T62/cY1I4fg4hDp5mZNUqMYNlO52bBd
         nfQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDAttSqs5QGFbcI7cPSqKUJOLBfTvDzzy3L/KybLqnZC7Rru7NMMr5/6qIB8zQHNd+XFc=@vger.kernel.org, AJvYcCXENnrLD0DgUuJtJQjW1QC9qtHsxh/aMipCDBFFMvOTL6GEfrnL6wX36CdLyaAURouFLz7eqPQa@vger.kernel.org
X-Gm-Message-State: AOJu0YyX+BBYKD8BqTLenSt8MjIS66Ydlg3fc1rzJfanYdT10Bsmdtgh
	lUA51FS0FXgAn2DBUyL74Prd4DHpKPoGAn/712peSpMrdLjvHd5vRJhVZf5K2GxjOTO6C6yyLiO
	gPwPjAFzZ/lnUAjhSULDxVv/nEsw=
X-Google-Smtp-Source: AGHT+IHNvJ4nPuYGnoDl4ltZ2bH1DiwOcMujDmROQvMLEEliOOHPL/GwTJk8QUWn7NSHa+ZvlRyL2NMkHLyRAtNBLLY=
X-Received: by 2002:a05:6e02:2142:b0:3a4:e452:c42c with SMTP id
 e9e14a558f8ab-3a4ed27c5f0mr152102575ab.6.1730251436758; Tue, 29 Oct 2024
 18:23:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <20241028110535.82999-3-kerneljasonxing@gmail.com> <61e8c5cf-247f-484e-b3cc-27ab86e372de@linux.dev>
In-Reply-To: <61e8c5cf-247f-484e-b3cc-27ab86e372de@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 30 Oct 2024 09:23:20 +0800
Message-ID: <CAL+tcoDB8UvNMfTwmvTJb1JvCGDb3ESaJMszh4-Qa=ey0Yn3Vg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/14] net-timestamp: allow two features to
 work parallelly
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: willemb@google.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, 
	willemdebruijn.kernel@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, 
	ykolal@fb.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 7:00=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 10/28/24 4:05 AM, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > This patch has introduced a separate sk_tsflags_bpf for bpf
> > extension, which helps us let two feature work nearly at the
> > same time.
> >
> > Each feature will finally take effect on skb_shinfo(skb)->tx_flags,
> > say, tcp_tx_timestamp() for TCP or skb_setup_tx_timestamp() for
> > other types, so in __skb_tstamp_tx() we are unable to know which
> > feature is turned on, unless we check each feature's own socket
> > flag field.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >   include/net/sock.h |  1 +
> >   net/core/skbuff.c  | 39 +++++++++++++++++++++++++++++++++++++++
> >   2 files changed, 40 insertions(+)
> >
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index 7464e9f9f47c..5384f1e49f5c 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -445,6 +445,7 @@ struct sock {
> >       u32                     sk_reserved_mem;
> >       int                     sk_forward_alloc;
> >       u32                     sk_tsflags;
> > +     u32                     sk_tsflags_bpf;
> >       __cacheline_group_end(sock_write_rxtx);
> >
> >       __cacheline_group_begin(sock_write_tx);
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index 1cf8416f4123..39309f75e105 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -5539,6 +5539,32 @@ void skb_complete_tx_timestamp(struct sk_buff *s=
kb,
> >   }
> >   EXPORT_SYMBOL_GPL(skb_complete_tx_timestamp);
> >
> > +/* This function is used to test if application SO_TIMESTAMPING featur=
e
> > + * or bpf SO_TIMESTAMPING feature is loaded by checking its own socket=
 flags.
> > + */
> > +static bool sk_tstamp_tx_flags(struct sock *sk, u32 tsflags, int tstyp=
e)
> > +{
> > +     u32 testflag;
> > +
> > +     switch (tstype) {
> > +     case SCM_TSTAMP_SCHED:
> > +             testflag =3D SOF_TIMESTAMPING_TX_SCHED;
> > +             break;
> > +     case SCM_TSTAMP_SND:
> > +             testflag =3D SOF_TIMESTAMPING_TX_SOFTWARE;
> > +             break;
> > +     case SCM_TSTAMP_ACK:
> > +             testflag =3D SOF_TIMESTAMPING_TX_ACK;
> > +             break;
> > +     default:
> > +             return false;
> > +     }
> > +     if (tsflags & testflag)
> > +             return true;
> > +
> > +     return false;
> > +}
> > +
> >   static void skb_tstamp_tx_output(struct sk_buff *orig_skb,
> >                                const struct sk_buff *ack_skb,
> >                                struct skb_shared_hwtstamps *hwtstamps,
> > @@ -5549,6 +5575,9 @@ static void skb_tstamp_tx_output(struct sk_buff *=
orig_skb,
> >       u32 tsflags;
> >
> >       tsflags =3D READ_ONCE(sk->sk_tsflags);
> > +     if (!sk_tstamp_tx_flags(sk, tsflags, tstype))
>
> I still don't get this part since v2. How does it work with cmsg only
> SOF_TIMESTAMPING_TX_*?
>
> I tried with "./txtimestamp -6 -c 1 -C -N -L ::1" and it does not return =
any tx
> time stamp after this patch.
>
> I am likely missing something
> or v2 concluded that this behavior change is acceptable?

Sorry, I submitted this series accidentally removing one important
thing which is similar to what Vadim Fedorenko mentioned in the v1
[1]:
adding another member like sk_flags_bpf to handle the cmsg case.

Willem, would it be acceptable to add another field in struct sock to
help us recognise the case where BPF and cmsg works parallelly?

[1]: https://lore.kernel.org/all/662873cb-a897-464e-bdb3-edf01363c3b2@linux=
.dev/

Thanks,
Jason

