Return-Path: <bpf+bounces-66467-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8635B34F00
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 00:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11EF95E7604
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 22:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1341C4A33;
	Mon, 25 Aug 2025 22:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RY/bgmXN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F371429BDAC;
	Mon, 25 Aug 2025 22:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756160620; cv=none; b=NYTaMRsWuH8Jzi4TETpEg4U619aA3CwsO9dtAQNyZu0HzODJC1sWkqZNyX+5DtcM11zPjf+iWnwH++q/6E6LA2RbxeCvprX0G8NmtmPzxnJfSqbpmmSdNpDQRjNV3EYfFq/BIPXpQBAJbhItWRfX048ZOSFFLDqmi6bxC8m5eKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756160620; c=relaxed/simple;
	bh=CZLyMKvpwQEwWjB0C6C66lDB3Bdb+Ie5JjmeQ2dq2mo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DGjzdZzhj9CCHcC2uq+QuLRxDzr9b2Ozt0B+NqfwOrWrtYBpQ7EIkxU2SVlBmKKucgZqrNRzCidXDRLqwRmUJw0Rao2FWk1E+06pJ38/sVGpgobWlCPgaKHenC/hiS74d0I57JMeOJw+Cb/4/03K3Gre/ycwl210Faij37+jzy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RY/bgmXN; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e931cddb0e2so3802402276.3;
        Mon, 25 Aug 2025 15:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756160615; x=1756765415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nzNHqjRwyPzEngYrpdgoS7G0NCqlSAjz11yrt9wxnWw=;
        b=RY/bgmXNRVwimbnOdHfyRen6xOtE3w1fOYfbwqQqGbZ5y2K/pSQU41ULR/0OHky0uJ
         ilqQ0FzqbPRNNM0DSfpCaxtLnEokn4EMu0Wr+2ryOZJ9FQwhh9MEeJeGqdf4wcPnPkX5
         pqhz5+V6ROQPR1fj1VETQpIyRidmKIlRYV2ySg0w4uh4i3Vu6TEqoZz9wGCGf4/2LQh+
         TPa0KreM5bzI1fBbFxQz1tTKvRnSp/PRhnHn/A7nLHyNH3xuTzM44PJsuYrsR/d2G3JY
         PwuYgZjL+gMr01Ancn1uEsnHrs6qjdtdLyQ+5uVi+8QwGvvrw1gzLRkjt/iyT7EO6i24
         jAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756160615; x=1756765415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nzNHqjRwyPzEngYrpdgoS7G0NCqlSAjz11yrt9wxnWw=;
        b=k/HGGxWbeWKTvJoJMOzEk6g/uwxtGxKC2OEz8wxMPI4WCMsxX78iQuNTacl9FB3dNh
         zBAQigV4KH/XgvnqY9ad2+NubWQcFiRFMwJRSaYeLYQtJ5nYskui6pFL0kYH4ETJP1QU
         jyUDC/2lyhsS0SsGtp4AiKRV/Ympp9vmkNUzuvmu8LVPU4g61fzld15lN/+m0+ukSWd8
         zwwuuepXTYHnOAqIIbmdUj5SDolHCUA6EpNisdzjW/NBoeGym9emgmXU06noUFVjJaXC
         nvuds745mxMh7YeI3J+jDzXalNgbh3X/DxJWmB9RMP3jm/8QqFuy4Q4tngS7L209RUr6
         /7GQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsa4wsHN506v3sJDMiC+tp8wGOWcEICQeCr1yFCvl5GF/ldId80DdyL6qBxU/oH/V5AuXm5b8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqKaxtjARhA7p/ly8biqiNFZgQSXJxgUAjiVnuSvw/XKwVtUbx
	Yt1hXC0cd9HD+4I9DUoye3mePzuQcwgZDepT27AjyBA7hNQtSzE8zQ/K7G2VBxGZmvVkQvk+o7Q
	uUPVkPy9j+TnLOi8Me0rremJOAdV9BUo=
X-Gm-Gg: ASbGncu8jFm1Bq1LJ79GSdhcww8CF364oPtFVRxolp4UGjDSUSeRuAiVXj5LJp8GgJu
	d0lxaD+hIYMzv5EwYN2GR3DLy+NtLVyQVyXFxReGhy8tlRMJsfEsewitKxmBKD4wqCWBezbd+Bo
	TLUCiGwUMZmZGpRNbuDMUpOmtX11hiRqbyJYvC3H0NNR/rr8dOSl2LUQNYnmjKOWQMtIoXEM+fO
	+WSvIw=
X-Google-Smtp-Source: AGHT+IHj2/686nS+CpzQj5xfbvOkv3SSG9xoeXqtK9eGTjyFlcEkRxNyNrVAEGKpRjMCVttB8eLADGhwRDck9UTAXF0=
X-Received: by 2002:a05:690c:6382:b0:721:26e3:84f3 with SMTP id
 00721157ae682-72126e38861mr14942767b3.42.1756160614550; Mon, 25 Aug 2025
 15:23:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825193918.3445531-1-ameryhung@gmail.com> <20250825193918.3445531-4-ameryhung@gmail.com>
 <aKzVsZ0D53rhOhQe@mini-arch>
In-Reply-To: <aKzVsZ0D53rhOhQe@mini-arch>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 25 Aug 2025 15:23:23 -0700
X-Gm-Features: Ac12FXyQwSxg9BJxd7w0VRx9wOJzO0TslPkBYHwT5iHJwd3EoZXCW1wUHxsbhM4
Message-ID: <CAMB2axOkPx=5vseNXbwQtHQTFhdur6OSZ-HbNPUciwBmubQa1w@mail.gmail.com>
Subject: Re: [RFC bpf-next v1 3/7] bpf: Support pulling non-linear xdp data
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, kuba@kernel.org, 
	martin.lau@kernel.org, mohsin.bashr@gmail.com, saeedm@nvidia.com, 
	tariqt@nvidia.com, mbloch@nvidia.com, maciej.fijalkowski@intel.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 2:29=E2=80=AFPM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 08/25, Amery Hung wrote:
> > Add kfunc, bpf_xdp_pull_data(), to support pulling data from xdp
> > fragments. Similar to bpf_skb_pull_data(), bpf_xdp_pull_data() makes
> > the first len bytes of data directly readable and writable in bpf
> > programs. If the "len" argument is larger than the linear data size,
> > data in fragments will be copied to the linear region when there
> > is enough room between xdp->data_end and xdp_data_hard_end(xdp),
> > which is subject to driver implementation.
> >
> > A use case of the kfunc is to decapsulate headers residing in xdp
> > fragments. It is possible for a NIC driver to place headers in xdp
> > fragments. To keep using direct packet access for parsing and
> > decapsulating headers, users can pull headers into the linear data
> > area by calling bpf_xdp_pull_data() and then pop the header with
> > bpf_xdp_adjust_head().
> >
> > An unused argument, flags is reserved for future extension (e.g.,
> > tossing the data instead of copying it to the linear data area).
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >  net/core/filter.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 52 insertions(+)
> >
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index f0ee5aec7977..82d953e077ac 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -12211,6 +12211,57 @@ __bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(=
struct bpf_sock_ops_kern *skops,
> >       return 0;
> >  }
> >
> > +__bpf_kfunc int bpf_xdp_pull_data(struct xdp_md *x, u32 len, u64 flags=
)
> > +{
> > +     struct xdp_buff *xdp =3D (struct xdp_buff *)x;
> > +     struct skb_shared_info *sinfo =3D xdp_get_shared_info_from_buff(x=
dp);
> > +     void *data_end, *data_hard_end =3D xdp_data_hard_end(xdp);
> > +     int i, delta, buff_len, n_frags_free =3D 0, len_free =3D 0;
> > +
> > +     buff_len =3D xdp_get_buff_len(xdp);
> > +
> > +     if (unlikely(len > buff_len))
> > +             return -EINVAL;
> > +
> > +     if (!len)
> > +             len =3D xdp_get_buff_len(xdp);
>
> Why not return -EINVAL here for len=3D0?
>

I try to mirror the behavior of bpf_skb_pull_data() to reduce confusion her=
e.

> > +
> > +     data_end =3D xdp->data + len;
> > +     delta =3D data_end - xdp->data_end;
> > +
> > +     if (delta <=3D 0)
> > +             return 0;
> > +
> > +     if (unlikely(data_end > data_hard_end))
> > +             return -EINVAL;
> > +
> > +     for (i =3D 0; i < sinfo->nr_frags && delta; i++) {
> > +             skb_frag_t *frag =3D &sinfo->frags[i];
> > +             u32 shrink =3D min_t(u32, delta, skb_frag_size(frag));
> > +
> > +             memcpy(xdp->data_end + len_free, skb_frag_address(frag), =
shrink);
>
> skb_frag_address can return NULL for unreadable frags.

Is it safe to assume that drivers will ensure frags to be readable? It
seems at least mlx5 does.

I did a quick check and found other xdp kfuncs using
skb_frag_address() without checking the return.

Thanks for reviewing!

