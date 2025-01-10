Return-Path: <bpf+bounces-48510-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 578B2A084F8
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 02:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7FBE188C289
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 01:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4039480BEC;
	Fri, 10 Jan 2025 01:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eejBoRJw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5712C9D;
	Fri, 10 Jan 2025 01:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736473408; cv=none; b=KpzFZwl9uVI9qxPRifjFHkk7kxhcMQ8L/WnkmKfFM7LvnW9W3WfqW/MLjw6U4A00D3lDgr6g1oKm/f+ntgT6ixVxpMOL2qoKodAMVf6K58V8CGuykhFt1dtsGNVs4wVn3f9r7P+p5Ts5rc8EN0wKVl4niLkaLxOyODyL+fQqYE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736473408; c=relaxed/simple;
	bh=o2XPZP+0IFA4x7leBl7ilw+adK677OtVOOFJWO/2sEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i4fxOfTqn2op6yyzTu1iH79wIysrhPQBBIHCD0/jN9VW0i/aJQbo1oBMtX5lThTFpKvcfMIrQP7mAeIZoPCDvc5rJVIwOlsprMJMlpJJpP/mxqgjH46D8myOb9IPXI6IZXL+Hi/2qvbEfVZxO4VFTH/ms0Fd8fePmC27sC/nlz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eejBoRJw; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-385f06d0c8eso840152f8f.0;
        Thu, 09 Jan 2025 17:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736473405; x=1737078205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9bpPWe6qYLJI51huF1n3iHHe/0W9cmw4C/J6ySpxfqM=;
        b=eejBoRJwTxNidihr60ozUMnd9VFiHb/PBIOdr6071nP6HStUloO1Ud5zF4bouMAaGH
         b963pjkLaqop7zgRivhFeXOciWr06RV7I1RnZ239E1Yc0TgVphqxdauTyp8bR1HPitZg
         ct0T3nG3xVdyJaMaLdmUSNTI6wRAgE9OAkXUtXOhrWOCKjNjVH1Bf1shrW2r5RQw8qxU
         TePpj+eXijN+MXRLXIcgvcwBoN0jWTxhwLL1+cbgnhuOM7EtWTN88myLAw5/rXkYFtuz
         KaF2zbfBbUizHLWxjkDfvK4I5uZrcAA24fhDij4EkR1cfNAKD4dNwGKvvofZmtkXBukn
         /Jfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736473405; x=1737078205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9bpPWe6qYLJI51huF1n3iHHe/0W9cmw4C/J6ySpxfqM=;
        b=Pltcft9ctn1KbnEBLFYRx2BvEYkm1ReFLZ6xMrRbqQBl5GI603v9tDI7UL8AoaFH/P
         qZGJaMPcliDcV5jN3bx7/4uH87OYiw0I4jmA6lyMq0CY3lng1CpVU3qR5E6hlidUwlCG
         cDd9aqaqBL4vnz7oEg3T4T8IYhXoAPO1gvsTQuqYoDORjqoXLXeyW5frbOJUUWRx+Ku4
         LvKZUxFzVh4gnfuvIoHx2XjdIr1h7c5x0LIFRl9DqHLUd56ZLZg11mde3JU92L28Y4uB
         H2CMA1HGhX0oQPEhZxS2mIHBUGliGut63Nq36rE58/zSxDE2tGBZEYQ+We3NHrEfSDwR
         ZJTg==
X-Forwarded-Encrypted: i=1; AJvYcCWb02dhEZUDAZvW0qnie9CT9gap1WeC2qjgeaJ/gzgIN6M3MHyp6g59L0dqMDDfNYXEiycmDUXPJNwAHmc=@vger.kernel.org, AJvYcCWkjOOAwFk6ovaoQt/D2JFqwt7VR/DVhHNX/Jmq2RC1gagf40Fzs7vMHxHcYuRHxzOIqEI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7kApT3lAYF9lzKBmle+3iDBBBU/lhSvV0d98213VPwwABAWZ3
	n/X8oVVmUtKIOt/LG6yoZl5eE4N9pSqr/y2DLpkIyaPF+HVJVv7xmZ0B2vuc7rjT+3MwS8bK6VK
	ZzL7f7wVKJuCfWRCn8xOXOK6Skhg=
X-Gm-Gg: ASbGncsEPZNlzMrBdAiUplon/o+WJe1FXGGxA11IPmfL2r9YWi/YCzXkVMFWFmNwQ6l
	MuerBnVZeHWqLIV0IOblxzVxM5P1by2Ob00mnK0Vw8oizDF5LnKL0FA==
X-Google-Smtp-Source: AGHT+IEvr0oS1MEGaOG5kOFAEWtTb0IkThLcUiRcjrb8YJZfEgmbjnUllCZIkZomjpep1vNPTry+F19gn6Or+Sj0vJo=
X-Received: by 2002:a05:6000:2c5:b0:386:930:fad4 with SMTP id
 ffacd0b85a97d-38a872dec5fmr6612129f8f.19.1736473405113; Thu, 09 Jan 2025
 17:43:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107120417.1237392-1-tom.leiming@gmail.com> <20250107120417.1237392-9-tom.leiming@gmail.com>
In-Reply-To: <20250107120417.1237392-9-tom.leiming@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 9 Jan 2025 17:43:12 -0800
X-Gm-Features: AbW1kvaffMmj9m1lwyhEIOIZAQfcj7ry02wtHwCdPhkUtoCz3G1IJaotii68oNk
Message-ID: <CAADnVQLGw07CNpi7=XHJRgBL2ku7Q23nfah07pBc45G+xeTKxw@mail.gmail.com>
Subject: Re: [RFC PATCH 08/22] ublk: bpf: add bpf struct_ops
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 4:08=E2=80=AFAM Ming Lei <tom.leiming@gmail.com> wro=
te:
> +
> +/* Return true if io cmd is queued, otherwise forward it to userspace */
> +bool ublk_run_bpf_handler(struct ublk_queue *ubq, struct request *req,
> +                         queue_io_cmd_t cb)
> +{
> +       ublk_bpf_return_t ret;
> +       struct ublk_rq_data *data =3D blk_mq_rq_to_pdu(req);
> +       struct ublksrv_io_desc *iod =3D ublk_get_iod(ubq, req->tag);
> +       struct ublk_bpf_io *bpf_io =3D &data->bpf_data;
> +       const unsigned long total =3D iod->nr_sectors << 9;
> +       unsigned int done =3D 0;
> +       bool res =3D true;
> +       int err;
> +
> +       if (!test_bit(UBLK_BPF_IO_PREP, &bpf_io->flags))
> +               ublk_bpf_prep_io(bpf_io, iod);
> +
> +       do {
> +               enum ublk_bpf_disposition rc;
> +               unsigned int bytes;
> +
> +               ret =3D cb(bpf_io, done);

High level observation...
I suspect forcing all sturct_ops callbacks to have only these
two arguments and packing args into ublk_bpf_io
will be limiting in the long term.

And this part of api would need to be redesigned,
but since it's not an uapi... not a big deal.

> +               rc =3D ublk_bpf_get_disposition(ret);
> +
> +               if (rc =3D=3D UBLK_BPF_IO_QUEUED)
> +                       goto exit;
> +
> +               if (rc =3D=3D UBLK_BPF_IO_REDIRECT)
> +                       break;

Same point about return value processing...
Each struct_ops callback could have had its own meaning
of retvals.
I suspect it would have been more flexible and more powerful
this way.

Other than that bpf plumbing looks good.

There is an issue with leaking allocated memory in bpf_aio_alloc kfunc
(it probably should be KF_ACQUIRE)
and a few other things, but before doing any in depth review
from bpf pov I'd like to hear what block folks think.

Motivation looks useful,
but the claim of performance gains without performance numbers
is a leap of faith.

> +
> +               if (unlikely(rc !=3D UBLK_BPF_IO_CONTINUE)) {
> +                       printk_ratelimited(KERN_ERR "%s: unknown rc code =
%d\n",
> +                                       __func__, rc);
> +                       err =3D -EINVAL;
> +                       goto fail;
> +               }
> +
> +               bytes =3D ublk_bpf_get_return_bytes(ret);
> +               if (unlikely((bytes & 511) || !bytes)) {
> +                       err =3D -EREMOTEIO;
> +                       goto fail;
> +               } else if (unlikely(bytes > total - done)) {
> +                       err =3D -ENOSPC;
> +                       goto fail;
> +               } else {
> +                       done +=3D bytes;
> +               }
> +       } while (done < total);

