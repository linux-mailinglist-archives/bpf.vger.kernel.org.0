Return-Path: <bpf+bounces-62012-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A5BAF0548
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 22:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45BF31C052AE
	for <lists+bpf@lfdr.de>; Tue,  1 Jul 2025 20:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD59302055;
	Tue,  1 Jul 2025 20:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpWc6NBz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310C828312E;
	Tue,  1 Jul 2025 20:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751403572; cv=none; b=uKYskYcONn/uFP1GcipeF0g6mG88Zuyo/jsnizv5EzBdONXI3Q3CI1ibq/xV7v+w79aKgpPkTCZP0ctBZ18XRPX61UzSr4RVxOscKHASWOPeMuGY786sbYWw9JNjM7a6b3w8jdG0Yr6sXDtdGxvNGjKYhNzmBDVZIyQRrxLf3p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751403572; c=relaxed/simple;
	bh=0RrGj1IgvYkm+Aoaiq5WqOM3xqSqxtTBdlkU2yk7l6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iw0a67PdJgXumIkobvI69jmq6oBXSz4NrZRd9RNzqKJsHs81DhSiUuecIj3zbQUeu2ul33qLcmNQ16rKbl2sD8hD/xcd3oqxK8marFPgntJOjYcPkZnoSqQLmUVraJh6zysZmwOKVlCYSd30JKa7e2Je8f2hltXDGtqw5sN9bcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpWc6NBz; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-742c7a52e97so6159446b3a.3;
        Tue, 01 Jul 2025 13:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751403570; x=1752008370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0DGnlJCYt+vZvnGUsJPL3Moi5tkTMpLy1bBdBnoLUo=;
        b=BpWc6NBzHon/tcJQq0Wz7IlM5Dc7sjN7z+osgnhUOZYgi6c4FXAI/Dszoy9xm7b19g
         t18r4hKYkY9w3ElSZVOmnpr+s6mXp//7eu+7Wp02Coag6hnctWm6VpPdk6f0QbhdHgOD
         ImKK0A0OQnHLUapJ22lUPlA8oKgjtKhzGJEltKDyRS7dIRROWMUPSrpvFeEXwLiSVgis
         Woghdtxdnhu4gu8FFCQC5ii54Xg0zR34RiapfQJ5LtBr/hJ8L8tYi8Gtv5D/Y0YObNQD
         qlr6fXVOWL+uPfABFtzaBHCUy4WEk2dX7S3goEnudXCRmI+OFR7NQIWGM2pEY+nNfZ6e
         f6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751403570; x=1752008370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u0DGnlJCYt+vZvnGUsJPL3Moi5tkTMpLy1bBdBnoLUo=;
        b=od6hMKtxRlgb0ALfufnfnJUyLUQ1cWlmYoUBthB90WjtOollPPmjPKskaIeaIe7mde
         I0iKy0x14ZK4VYqcfbLuBcIBlQq1HMOx/Vy6PYZ39UtaOSbWF3Nm6+k54+BFkqBy1w0M
         0ILipvvR+UgBbSL4PxQftvptMwv2PZlqyMkzcW27Dp4H3D5LKcT17q5CRLhOgJWXkIDS
         OJqzn/K4POXdyr4KVaVRPNHHQmKabeL9zLNBzIneoU+CTodRJalkcxgAmB55S9PKfLmy
         KDAlEKC0I/+fk5aMjkI+D9mUc0K6nzKgk1K7NRmpr6AqVTMvG2/oJQaADim+JqRguYDf
         It5A==
X-Forwarded-Encrypted: i=1; AJvYcCVP5P3lg3KVXzL6DcpxLWgsRnX+PhkDqruSq8p89/fesB20rUqNda2w0nF9Pdd/rTWI3VqIO3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRDU9xAG1ucCJVDRgidebZ1EFMCNMLDOcoKaqGTImP578sy9xk
	VNeiwOOUAGNLXiN2uyn7xV8MW061qaRzk9K3gRZ9OPNlDCb0Z1JKELpUe1dvLFaivAjf6x3A8Y2
	78/sioJ5sxx9a/0W1NytUdTfEjXtwwA0=
X-Gm-Gg: ASbGnctJk/fDW/FLXJPwkXRZD6TB3MJN8NDxLbDL2puv1V5tY7Yeg/rppml0eOeEl0h
	MSfIRl/lVB6hZY2Ajw5klnrH1KpnhYsATBrMDOm0Q1VEBqtcTwBP3TNX2nSEMl1IKf9YzV2UkG9
	iT9IJoy84KjX3vhvMxw0dKDpzEVXLS8GmbDH1CrIHa241KY/N/YOBfKnagNO8=
X-Google-Smtp-Source: AGHT+IGT99loALCuF/C8ljfKueJ6EMPb+5af62S315v2rOSudNt/QyL1vwFK0ZoeOE6uvPxoGK5CaM0VEysnm2k5JEs=
X-Received: by 2002:a05:6a00:2d90:b0:748:e150:ac5c with SMTP id
 d2e1a72fcca58-74b5126b0eamr315876b3a.23.1751403570470; Tue, 01 Jul 2025
 13:59:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250630-skb-metadata-thru-dynptr-v1-0-f17da13625d8@cloudflare.com>
 <20250630-skb-metadata-thru-dynptr-v1-3-f17da13625d8@cloudflare.com>
In-Reply-To: <20250630-skb-metadata-thru-dynptr-v1-3-f17da13625d8@cloudflare.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 1 Jul 2025 13:59:15 -0700
X-Gm-Features: Ac12FXzgeNQq2M-iE5ovjrKk9qt4nR6HNIkiHAQEpfVsqE-tX4YPAWIQmY_N5sE
Message-ID: <CAEf4BzYjUc_ppemufs98YX+hvQ7vmSkBayuhsATkqCwOzh90aQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 03/13] bpf: Add new variant of skb dynptr for the
 metadata area
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Arthur Fabre <arthur@arthurfabre.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Jesse Brandeburg <jbrandeburg@cloudflare.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <thoiland@redhat.com>, 
	Yan Zhai <yan@cloudflare.com>, netdev@vger.kernel.org, kernel-team@cloudflare.com, 
	Stanislav Fomichev <sdf@fomichev.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 7:56=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.co=
m> wrote:
>
> Add a new flag for the bpf_dynptr_from_skb helper to let users to create
> dynptrs to skb metadata area. Access paths are stubbed out. Implemented b=
y
> the following changes.
>
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---
>  include/uapi/linux/bpf.h |  9 ++++++++
>  net/core/filter.c        | 60 +++++++++++++++++++++++++++++++++++++++++-=
------
>  2 files changed, 61 insertions(+), 8 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 719ba230032f..ab5730d2fb29 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7591,4 +7591,13 @@ enum bpf_kfunc_flags {
>         BPF_F_PAD_ZEROS =3D (1ULL << 0),
>  };
>
> +/**
> + * enum bpf_dynptr_from_skb_flags - Flags for bpf_dynptr_from_skb()
> + *
> + * @BPF_DYNPTR_F_SKB_METADATA: Create dynptr to the SKB metadata area
> + */
> +enum bpf_dynptr_from_skb_flags {
> +       BPF_DYNPTR_F_SKB_METADATA =3D (1ULL << 0),
> +};
> +
>  #endif /* _UAPI__LINUX_BPF_H__ */
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 1fee51b72220..3c2948517838 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -11967,12 +11967,27 @@ bpf_sk_base_func_proto(enum bpf_func_id func_id=
, const struct bpf_prog *prog)
>         return func;
>  }
>
> +enum skb_dynptr_offset {
> +       SKB_DYNPTR_METADATA     =3D -1,
> +       SKB_DYNPTR_PAYLOAD      =3D 0,
> +};

I'm missing why you need to do it in this hacky way instead of just
having both bpf_dynptr_from_skb() and bpf_dynptr_from_skb_metadata()
(or whatever we bikeshed it into), which will create
BPF_DYNPTR_TYPE_SKB or new BPF_DYNPTR_TYPE_SKB_META dynptr kind,
respectively. Why so complicated?

[...]

