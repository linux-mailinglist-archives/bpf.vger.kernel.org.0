Return-Path: <bpf+bounces-53664-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7C2A582DF
	for <lists+bpf@lfdr.de>; Sun,  9 Mar 2025 11:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 999F93ACDBB
	for <lists+bpf@lfdr.de>; Sun,  9 Mar 2025 10:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6347192B71;
	Sun,  9 Mar 2025 10:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7Qyvwrf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1241137E;
	Sun,  9 Mar 2025 10:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741514429; cv=none; b=pEyQFp9ssQz9A7XLO86fYEr8rTErBxYtvaqvfNtFTiUGE6hacmx74KE//eGxClg++KH9t9QCWPf4PIlTzeRrPnfOqwFY3/Nq9b+KnTwSoFOcGlC9PU1C5+Ac80gDB53s+f3LiKxKgfVN7EL4ipFCl4QQG6uTQ858QawbYfqFPi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741514429; c=relaxed/simple;
	bh=2Llx3WTFhJi8bgiJrQRCPqh8mOoxRD8TfAWh4LsxneA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I0rufbphXx+lJzk6e1nFkULZkkh2G7BeM26klx0lF0zu1UfWTEnvW5dJIM9MQG6Y38sif8VLKvIYrSCKDzigCJZuJop6xLr1m/B/oSVAjxJz78z+mzwWhfztO4IXga8qSVOxa++gETemDd7fPaF5L5c6mpsg09dJuJEXNJ9myWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7Qyvwrf; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cf0d787eeso3443285e9.3;
        Sun, 09 Mar 2025 03:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741514426; x=1742119226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSysHQVWdQunSfphu9SyzaqKsyGnlT5vXpLfTP06qGY=;
        b=V7Qyvwrf28fu8sKOc7FAYVnjcg1YZZYnOkuD3oWarE4BtcDJpJgA1prJdwZL/4P8tO
         8yVlGJ6OXRX2D9Zc4n2tgZ6A2aESlsNMJLn+AzkKUZQYAjklg0T9ppAYkCcqaK5TmGV9
         y/oeH678a08ar9f1PYjQt0bDktXzwXE6WCJtOBCa8JLSBB+WfwI8rusUzaBSQL16HclF
         YuuHgyg5HOCs7kVgBmLRtuhmQkhFPmRxFeQiwFmGJpgGD4KTF+Jh3EIHZzjK1s/l4+qs
         hB1UiOq1v7lbEA/pIuNTK9XVCc7JCe2KVoR+L5UP579NCCD3osfZDowL+/elddYUkb9D
         76HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741514426; x=1742119226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RSysHQVWdQunSfphu9SyzaqKsyGnlT5vXpLfTP06qGY=;
        b=BiYPKOG8/8ARfFWWOVRzNZVVda65MeBzgreUPZ0R84nsajUq815YmA4vluYgH0T6a6
         T9SSFdfDZOUz3x9pHaCxEq9M7guKAAu7PORd3/vvgDqb+wBsNAzilGDvV8+NPpRvdtYa
         6k/MKmTE6vZGzsepAnSJ3ScGKFV8uOR1xQLJ9dWJoN299dhWEoLNvA0B2AEYS3DzbGlU
         Zy/jDvAzbBZDyDY4/xZXHYHWY+9J3M8H9hYZGfoVA4ZBUbfSUc2lho7peYzE/U3OarKA
         +oApgU2kpyOawudJIxfaqal1LlfUCBzdxsgWwMFEYfNlowNKej1zwHi4xVSOy5RXNrLl
         vrfg==
X-Forwarded-Encrypted: i=1; AJvYcCUt7HDS70+wnxosCBvyjE6T1bywAzFVbZwMxYKm2tIf/S9kegw1EWRUSpFEvjlkyKWEmSs=@vger.kernel.org, AJvYcCXG2hm269OkCi/nJG/UQdD7XKv/H+IJyOKciE/bsvU10D77x8TJiFIeXefe0BM2yzv4lOaSZ6J2y3xHJx65@vger.kernel.org
X-Gm-Message-State: AOJu0YzIdO8Om/CkoFjKbVzZzQpa8pKpY35R6V+fQoh9jhmjXcX3mE5e
	H5Tzg1eljry+xiFhcbmc49PXDJZOjpZ3BiB+bC1NRC/C70CVHqH9hOSQ7zaQylVOvB7SLLigmez
	Tdfd4bsmWzCeIQtPUfZjBaOm/sSg=
X-Gm-Gg: ASbGncuTdHqeBU/Dvd6Jc9XZu6XyYfyOCLS4qtB5C5ZIBDdfAvaJTqA8VG4MsU8O8pV
	xZ3IwOAucb2+aygsju7tlB0hWgYcJUJX14EfusAVR/IGH9LwC7ITJMWib2SrG3raZblALghYpT4
	UOG9cP2A1BOdm8b579UkNFn9TdYw==
X-Google-Smtp-Source: AGHT+IHAdrXeYHESp4cpupnGPtGa+Cn6/Oy5mReHKOjpU9NtfG31n3GfdKpz06eaEDf7bKQVV1EhrOUKM6T+7d+M5ZY=
X-Received: by 2002:a05:6000:144d:b0:391:139f:61af with SMTP id
 ffacd0b85a97d-39132d8c768mr5319852f8f.32.1741514426111; Sun, 09 Mar 2025
 03:00:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250308215605.4774-1-qasdev00@gmail.com>
In-Reply-To: <20250308215605.4774-1-qasdev00@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 9 Mar 2025 11:00:15 +0100
X-Gm-Features: AQ5f1JpivXMGOjJcgY-jGBHiQAyPCA6FBN6aolP1cifdfphoYjEc6sBlxWWWmpg
Message-ID: <CAADnVQJXH7M0uhsswbWq1RjNv-h5e2M_6AtWd-1TazBo+QTgUg@mail.gmail.com>
Subject: Re: [PATCH] bpf: add missing NULL check for __dev_get_by_index
To: Qasim Ijaz <qasdev00@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 8, 2025 at 10:56=E2=80=AFPM Qasim Ijaz <qasdev00@gmail.com> wro=
te:
>
> The __dev_get_by_index function can return NULL if it fails to
> find a device with the provided ifindex.
>
> We should handle this case by adding a NULL check
> and cleaning up if it does happened.
>
> Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
> Fixes: a38845729ea3 ("bpf: offload: add map offload infrastructure")
> ---
>  kernel/bpf/offload.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
> index a10153c3be2d..28a30fa4457a 100644
> --- a/kernel/bpf/offload.c
> +++ b/kernel/bpf/offload.c
> @@ -530,6 +530,12 @@ struct bpf_map *bpf_map_offload_map_alloc(union bpf_=
attr *attr)
>         bpf_map_init_from_attr(&offmap->map, attr);
>         rtnl_lock();
>         offmap->netdev =3D __dev_get_by_index(net, attr->map_ifindex);
> +       if (!offmap->netdev) {
> +               rtnl_unlock();
> +               bpf_map_area_free(offmap);
> +               return ERR_PTR(-ENODEV);
> +       }

1. you're using some old git tree.
there is no such code in bpf_map_offload_map_alloc().

2. The actual code has bpf_dev_offload_check(offmap->netdev)
that does the NULL check already.

pw-bot: cr

> +
>         netdev_lock_ops(offmap->netdev);
>         down_write(&bpf_devs_lock);
>         err =3D bpf_dev_offload_check(offmap->netdev);
> --
> 2.39.5
>

