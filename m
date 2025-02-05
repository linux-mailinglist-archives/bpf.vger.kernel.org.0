Return-Path: <bpf+bounces-50517-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B48A2950C
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 16:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7B8F7A520E
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 15:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D860189F57;
	Wed,  5 Feb 2025 15:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Klma6ssi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D2837160;
	Wed,  5 Feb 2025 15:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738769720; cv=none; b=eguiNXCYk0567nR75H0cM5KEma9WiQzBGHkC8Lk/CzOffgWiP+8OrvrEosGhJ5yPOii9kE/MxEsqO1v5BZ4FJOu+uVtH/YjqVi3ahMDs4CDLVBVtVuLDFSMutqdeVg5tjEvF8/PhpvSargZ9gcM6ZzNkzj5KkXiqXcJqSYbCoBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738769720; c=relaxed/simple;
	bh=6px1nqAqpVnjNche0Y04H//ZhXi3kORDAHJT176InZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iAQWCtK8mc85nUEhCklf3/PpghBrYtfadqz+uBCVcUEJJjQDnHlxx2LNrwj21O0hL0FzbynMouREMjo0tcWtimOyilIuQPlOpDGBqzFVfIlIOlQAUhratqjIBMGIetWQxTZ+yWPZOVPZLxWAi9zSJs5mME5TvPnUEv3wjMXxPWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Klma6ssi; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-844ee166150so166249539f.2;
        Wed, 05 Feb 2025 07:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738769718; x=1739374518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bFnpsDzxhc6oVItPvKejTzWIesCheiEL1qK16774S1Y=;
        b=Klma6ssiN7B1Yf61Wzm6qniKzu8vSs0DV6EPTVjfjtK0lwyOX6DUkxKVjzXfZ27UKe
         l8XPkOVVJ77pO5VNFixq4VIYPgyUpxzwTDR+O4QjHu7v51mE/tgLv7NZLOmpl5A/leLc
         N2b5MexTrnrsRAQ02fYda2/XapfiL+aCCR7JwtTLxR3Vv4afdtJFTkmmY8mMOGHU5Lyy
         vEoR8bDnfUzbJY5nc3b8nA6ZcU458ykOBzXSIfrS2IW/wzXWk49vOFMHjnjfkP/MuHph
         F85gUb9tS86ZPHe8EMLJ4pdKZfxxtPpwFh1HdQtq1Pqg8NNhIxMKErIJZIrgi23wMuk5
         qSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738769718; x=1739374518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bFnpsDzxhc6oVItPvKejTzWIesCheiEL1qK16774S1Y=;
        b=K8dUrtvKfyXJCY9VU5OuP4wFH9Lcr2V3JzY03IXaZ63e6qFBWQ27vXmBKFqQqwHR5q
         96kh2YClBR/efjF3KP1vEt5IJzlfUh0LWBD+Q3EVb1MAtmIjnnl1GJugUg61IlKMRipB
         63FRMVNz7Nac/m089QeGsGhFuTKiTxS9eillihxDgQ2NfARt4l6NKClZYXPGZY0UHveF
         kRGzmKcDT4AK+beGBP6ghzNlLFBcnMgDLnoYYe95m/6BPCxFdc96XdkJyfN/j+RmDn0T
         UibJ4NggvIw/JF6kMPC6jvURZH35Cc7VgMcRogBn5ckc7hxBe6TB9ds1xphGfukp6yv0
         mZYA==
X-Forwarded-Encrypted: i=1; AJvYcCUM0aRa4Yd2b1ewt7oAvE5e9qGPcH89XbLKqBtwQkx5i3W9Pi0E4HJLv11XS10Wb/k1NHTOMs11@vger.kernel.org, AJvYcCV4skYyZY0WoTCkZLSGGmGBGt2K8oH8qmaCKTXjco4j2WyG+g81pRwrxK4pE23Pd8qjYuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrgSc7DOkALAu4KaYczukPZzAleT+hjTX8jy/wvR9d8SUy7+8p
	ZpzRhOYD0t5V+jg09LQaJOrWGebuiKqo7Ip1eAEzlXRZ+21k9Bftnj+qrB0tAbKHfyxMIeTi0Zj
	E9HhGuURSOwimPut1XMHMtvZyXAc=
X-Gm-Gg: ASbGncvi4xq8rE8w6nxul2rCEmeiJDMEhrd9E+eNXitxCSIKu2iXIkTCBX9KQIDA5sa
	fl2CanoLqG6y/WeDt/iC7QaeAlMNWjBQg+PNHd7oFjyXqcGiPWgrRlWPo2yCqZ/Q6aBbsNgc=
X-Google-Smtp-Source: AGHT+IH5gPre7BFItkirOlemqEgb1p3kUk7cby/NJORjQO6dzsJaA7u/B9+jiv9rbLs+32Qc76qPDhDLVIS28ayzVuw=
X-Received: by 2002:a05:6e02:194c:b0:3cf:ae67:4115 with SMTP id
 e9e14a558f8ab-3d04f432d8bmr31260805ab.8.1738769718064; Wed, 05 Feb 2025
 07:35:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
 <20250204183024.87508-2-kerneljasonxing@gmail.com> <67a3821d3ae5b_14e0832944c@willemb.c.googlers.com.notmuch>
In-Reply-To: <67a3821d3ae5b_14e0832944c@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 5 Feb 2025 23:34:41 +0800
X-Gm-Features: AWEUYZnDFlClAon9sgC2GYeEuIKiB8nks5tImLKOeMOkJLGmbTO-rB7R6Or84sI
Message-ID: <CAL+tcoA26mQQf-_0Ebi2qqd=qVn1soUoma-3o8NdUFGZL_-L2g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 01/12] bpf: add support for bpf_setsockopt()
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

On Wed, Feb 5, 2025 at 11:22=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > Users can write the following code to enable the bpf extension:
> > int flags =3D SK_BPF_CB_TX_TIMESTAMPING;
> > int opts =3D SK_BPF_CB_FLAGS;
> > bpf_setsockopt(skops, SOL_SOCKET, opts, &flags, sizeof(flags));
> >
> > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > ---
> >  include/net/sock.h             |  3 +++
> >  include/uapi/linux/bpf.h       |  8 ++++++++
> >  net/core/filter.c              | 23 +++++++++++++++++++++++
> >  tools/include/uapi/linux/bpf.h |  1 +
> >  4 files changed, 35 insertions(+)
> >
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index 8036b3b79cd8..7916982343c6 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -303,6 +303,7 @@ struct sk_filter;
> >    *  @sk_stamp: time stamp of last packet received
> >    *  @sk_stamp_seq: lock for accessing sk_stamp on 32 bit architecture=
s only
> >    *  @sk_tsflags: SO_TIMESTAMPING flags
> > +  *  @sk_bpf_cb_flags: used in bpf_setsockopt()
> >    *  @sk_use_task_frag: allow sk_page_frag() to use current->task_frag=
.
> >    *                     Sockets that can be used under memory reclaim =
should
> >    *                     set this to false.
> > @@ -445,6 +446,8 @@ struct sock {
> >       u32                     sk_reserved_mem;
> >       int                     sk_forward_alloc;
> >       u32                     sk_tsflags;
> > +#define SK_BPF_CB_FLAG_TEST(SK, FLAG) ((SK)->sk_bpf_cb_flags & (FLAG))
> > +     u32                     sk_bpf_cb_flags;
> >       __cacheline_group_end(sock_write_rxtx);
> >
> >       __cacheline_group_begin(sock_write_tx);
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 2acf9b336371..6116eb3d1515 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -6913,6 +6913,13 @@ enum {
> >       BPF_SOCK_OPS_ALL_CB_FLAGS       =3D 0x7F,
> >  };
> >
> > +/* Definitions for bpf_sk_cb_flags */
> > +enum {
> > +     SK_BPF_CB_TX_TIMESTAMPING       =3D 1<<0,
> > +     SK_BPF_CB_MASK                  =3D (SK_BPF_CB_TX_TIMESTAMPING - =
1) |
> > +                                        SK_BPF_CB_TX_TIMESTAMPING
> > +};
> > +
> >  /* List of known BPF sock_ops operators.
> >   * New entries can only be added at the end
> >   */
> > @@ -7091,6 +7098,7 @@ enum {
> >       TCP_BPF_SYN_IP          =3D 1006, /* Copy the IP[46] and TCP head=
er */
> >       TCP_BPF_SYN_MAC         =3D 1007, /* Copy the MAC, IP[46], and TC=
P header */
> >       TCP_BPF_SOCK_OPS_CB_FLAGS =3D 1008, /* Get or Set TCP sock ops fl=
ags */
> > +     SK_BPF_CB_FLAGS         =3D 1009, /* Used to set socket bpf flags=
 */
> >  };
> >
> >  enum {
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 2ec162dd83c4..1c6c07507a78 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -5222,6 +5222,25 @@ static const struct bpf_func_proto bpf_get_socke=
t_uid_proto =3D {
> >       .arg1_type      =3D ARG_PTR_TO_CTX,
> >  };
> >
> > +static int sk_bpf_set_get_cb_flags(struct sock *sk, char *optval, bool=
 getopt)
> > +{
> > +     u32 sk_bpf_cb_flags;
> > +
> > +     if (getopt) {
> > +             *(u32 *)optval =3D sk->sk_bpf_cb_flags;
> > +             return 0;
> > +     }
> > +
> > +     sk_bpf_cb_flags =3D *(u32 *)optval;
> > +
> > +     if (sk_bpf_cb_flags & ~SK_BPF_CB_MASK)
> > +             return -EINVAL;
> > +
> > +     sk->sk_bpf_cb_flags =3D sk_bpf_cb_flags;
>
> I don't know BPF internals that well:
>
> Is there mutual exclusion between these sol_socket_sockopt calls?
> Or do these sk field accesses need WRITE_ONCE/READ_ONCE.

According to the existing callbacks (like
BPF_SOCK_OPS_ACTIVE_ESTABLISHED_CB which I used in the selftests) in
include/uapi/linux/bpf.h, they are under the socket lock protection.
And the correct use of this feature is to set during the 3-way
handshake that also is protected by lock. But after you remind me of
this potential data race issue, just in case bpf program doesn't use
it as we expect, I think I will add the this annotation in v9.

Thanks,
Jason

