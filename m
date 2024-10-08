Return-Path: <bpf+bounces-41312-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F775995BA5
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 01:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D73241F25F5D
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 23:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EBA218582;
	Tue,  8 Oct 2024 23:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbS+n4nR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DB52178FE;
	Tue,  8 Oct 2024 23:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728430097; cv=none; b=H3KNXC66XFkk8UO+2g6IUoTfi34R6ELU1eM5qA1N6y8tv1FbEndjEEyIi5ufYwNHdwZ/w/T2WWeV08FJdseXPhaNjNmlRUT6M0KtD7NFC4l+KXmQDiDbiZPrPwZtYbUM7uxWmECt4QKFJO7i/NPmt1SVwFjXPheIVpd4vkn9DUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728430097; c=relaxed/simple;
	bh=nLL/p/2e52NVIaX0e8HX/qHox/VKxcmsARraMumXAKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q0Z3oqF4uzsZyiC4wQWnxATEgMSdxVxy+2UbYMTFoMyTuKTHYsy1+G/3lhtlcufPSh0vqz9v3ScatPc822Iczm/NZuwa9yMeuc/68ftMh/Jom8OM59SxmpCP5Qych6equ7cv1w0zMucUqmHOqNnLjApK5q5bYrkedcl/PY+M+B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EbS+n4nR; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-37636c3872bso20291145ab.3;
        Tue, 08 Oct 2024 16:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728430095; x=1729034895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hx7zye3cnljlInNHTYIeTXJ6WNf7NduswCnrK2MuPTI=;
        b=EbS+n4nRO0rzaqrRj4p23JLJ55bsxYb8BuyQf03Sh0on0s6hlLTJldpkDkxJdVtwO6
         NRca6uFLRtPVBqe8cRODwK0z+eR/cyWttpxMGGnxjdql73HcIlhkcNKB8jWE4ReH7Pnf
         fDcwHHwO31Eg7+KPc1B/xoKhbV3pxqG/KtCcNHFNl+CgqiDedUv43OowhYfaTendwwP9
         NPna0UQhaYEG6BbyFoS67KEw51qGfhnk0tzwD/gATr2as5PFQ1RIibBb8jWP/2YBg01W
         USzfd0iWUQVaTzugFyIEyUNH30Zkm/e/NHNQ5Bft6NqXeametD8F9OTfHjV4Jq9nKYah
         G99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728430095; x=1729034895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hx7zye3cnljlInNHTYIeTXJ6WNf7NduswCnrK2MuPTI=;
        b=PGyDnZXuSKlxful0J04zIA3nUybY0BBpbBhVsXgCNgjNTN8TYlgzHUfdsr3cvZpmqx
         vIr1feYOOxM3BLz3EEHuEoJU6zUxYiNIDmRySFwLSMF0E+OV3fCSS6fJ4xsmeqKiMLpL
         m6VVk7HthewviK9kHuXx1RRAVcwsLd89T3toLOxkPwPc8um9EkkJqsdIIBtFqZrJOFpN
         JiFrHtn7Lu5jIUek0+giTmI27smPJ5oMFxCSr++i1VxTcMlLU97nPSDAeXBVuUI03zKC
         jx8MDD94oGZ120x81jdQkGRJ4gV1J6UutvDpmUETjCT1Lib/ZOmDwpyM/mGpoNkwBE6i
         RpmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrquffXnHGBaxz2H7oAN9rmpHeQMZ4gkuNmErlipxqvaGTDuXsRx9uxpf8vaforBd2kvIz6Ujd@vger.kernel.org, AJvYcCUssUQ2icGpR1itl6PUri2Jp6vlUeRXQaw/RxX30jg4Oh3kqcc9QdmWUFA/+ZTv1SwJ5YU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyusRWifD8JY/fRjmKXPSOxdidxunAjoCdwt24sMDK6Im6SQqd
	h1gO4A7MTHsqMzctwrInLstEYH6CbpQriU+BtlueyaeucLwdBhSNd/uisO1rvh56ysYFg8TO3WU
	ffTP/g3p9YVdYlKedwexdGnc6Tlg=
X-Google-Smtp-Source: AGHT+IFyQ78KSyq1si+/WqCze5UiUsG630xaDeTIdmVAp7z/O4LhldI0d32dIF5XU6iFZN+QfwKl/js+3b6YGdYe7Go=
X-Received: by 2002:a05:6e02:1ca1:b0:3a0:4a91:224f with SMTP id
 e9e14a558f8ab-3a397ce85b3mr5026325ab.1.1728430095097; Tue, 08 Oct 2024
 16:28:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008095109.99918-1-kerneljasonxing@gmail.com>
 <20241008095109.99918-2-kerneljasonxing@gmail.com> <67057db07a8c6_1a4199294b6@willemb.c.googlers.com.notmuch>
In-Reply-To: <67057db07a8c6_1a4199294b6@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 9 Oct 2024 07:27:38 +0800
Message-ID: <CAL+tcoALeCguB0+HpTq+MHitHZft3drF5OunPh1Qme8XGifiNw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/9] net-timestamp: add bpf infrastructure to
 allow exposing more information later
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 2:45=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Implement basic codes so that we later can easily add each tx points.
> > Introducing BPF_SOCK_OPS_ALL_CB_FLAGS used as a test statement can help=
 use
> > control whether to output or not.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  include/uapi/linux/bpf.h       |  5 ++++-
> >  net/core/skbuff.c              | 18 ++++++++++++++++++
> >  tools/include/uapi/linux/bpf.h |  5 ++++-
> >  3 files changed, 26 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index c6cd7c7aeeee..157e139ed6fc 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -6900,8 +6900,11 @@ enum {
> >        * options first before the BPF program does.
> >        */
> >       BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG =3D (1<<6),
> > +     /* Call bpf when the kernel is generating tx timestamps.
> > +      */
> > +     BPF_SOCK_OPS_TX_TIMESTAMPING_OPT_CB_FLAG =3D (1<<7),
> >  /* Mask of all currently supported cb flags */
> > -     BPF_SOCK_OPS_ALL_CB_FLAGS       =3D 0x7F,
> > +     BPF_SOCK_OPS_ALL_CB_FLAGS       =3D 0xFF,
> >  };
> >
> >  /* List of known BPF sock_ops operators.
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index 74149dc4ee31..5ff1a91c1204 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -5539,6 +5539,21 @@ void skb_complete_tx_timestamp(struct sk_buff *s=
kb,
> >  }
> >  EXPORT_SYMBOL_GPL(skb_complete_tx_timestamp);
> >
> > +static bool bpf_skb_tstamp_tx(struct sock *sk, u32 scm_flag,
> > +                           struct skb_shared_hwtstamps *hwtstamps)
> > +{
> > +     struct tcp_sock *tp;
> > +
> > +     if (!sk_is_tcp(sk))
> > +             return false;
> > +
> > +     tp =3D tcp_sk(sk);
> > +     if (BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_TX_TIMESTAMPING_OPT_C=
B_FLAG))
> > +             return true;
> > +
> > +     return false;
> > +}
> > +
> >  void __skb_tstamp_tx(struct sk_buff *orig_skb,
> >                    const struct sk_buff *ack_skb,
> >                    struct skb_shared_hwtstamps *hwtstamps,
> > @@ -5551,6 +5566,9 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
> >       if (!sk)
> >               return;
> >
> > +     if (bpf_skb_tstamp_tx(sk, tstype, hwtstamps))
> > +             return;
> > +
>
> Eventually, this whole feature could probably be behind a
> static_branch.

You want to implement another toggle to control it? But for tx path
"BPF_SOCK_OPS_TEST_FLAG(tp, BPF_SOCK_OPS_TX_TIMESTAMPING_OPT_CB_FLAG)"
works as a per-netns toggle. I would like to know what you exactly
want to do in the next move?

Thanks,
Jason

