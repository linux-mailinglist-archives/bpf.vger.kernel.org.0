Return-Path: <bpf+bounces-38223-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F166961ABC
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 01:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CD1728504D
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 23:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23091D47AC;
	Tue, 27 Aug 2024 23:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VW+hSwj3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D155319EEBB
	for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 23:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724802156; cv=none; b=DPnX9gC54J5syevIsgTku+QTJBb/6DFjHdZaf0RwUF6XjxsCKuf5fm6NzMTeYuO7sGLzVrkruX3rKCvLr+nY+IQLpJVP6RVNqbiyLq9netBuIUzTXmmDuaaTTHrzVl9jzUM4e4jLUn138f6Dfih8hpifhB7LaFxTbQJSUhuASXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724802156; c=relaxed/simple;
	bh=j1/x1OhCZM9g8EEPUqixxK508HgFx0r3EUCsq6yc7qM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g4esuaGe8PGFBOtZ7MqEG+vMpeGssoV0mfmKEvWfQz+wRaVlBgJqfqKPaYr/entqGQnOkwYsRfppcYljH9WiTggCzykg9LsL1iMLwPMcjxfKZRmRgrhcpnGskFDVlbbR+Og+skuM3lPg8LUHJ7BDYJh/PYsa6Zi1FmiYiDwORPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VW+hSwj3; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-428ec6c190eso53031935e9.1
        for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 16:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724802153; x=1725406953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOClQZe9sTVqgjHLMrVTuXCZt5Z5aV9+hWXflT8UCIg=;
        b=VW+hSwj3WcMkn97MTVrPbClUEnnls7CJhrRYdMEH/uaXDTn23D+ggUB4sJjDhode1J
         aP7Ms3tIfrzf1LAaMiAhQ2Lni/xTcVcnduCDywb2ZEZ1MN+AykjeohFcXZ4G7E7lxunB
         2Xk2j59z6R+b53Mwo7rMvA9itCVyYxd6PDexDe143b5DxqjhXhvTuYat6kiyjiBxUAD4
         kUV8gJtjM0FLf+EASYEe+oTY/t6eiStDhuR4F21PWQ46EkA01qkxCMV/nb2dNS4UW8y9
         2i3VpAN2yTfvyKfIawv0uA3lZiNv3eRK65Bjz9WO3ahFynoM97bSp6E7Yx/P0xMf5RBz
         dcJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724802153; x=1725406953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vOClQZe9sTVqgjHLMrVTuXCZt5Z5aV9+hWXflT8UCIg=;
        b=r//hLNdQR40Iw6eG+2iiY/BsKdvRdT16pcROfb2KeGviSsEtHFXWkloo0QPFpW2R8Z
         ult0o5GLsjeBLJjFkFqFapBNzexyf2DQ4o+Na+xB2s+SPLULRpgLerxTEmsGCT8Up8D2
         0R+xDqrkyWqQ2lKLLGyICwQ+nksTJXWComzdgwG8cK0ROKdcyZ+LA8eU1/D+3sWTJIKJ
         D6yzq8Ee+Qw6RDd0aG0p9BS1ubxVyZqxXYF8fA2kiKArK6XTXDWOUajcsSw+s8xD/h7L
         c30N4CYflnXZn2l0wddo8vo5p0L/MABOxtIuNlWi9v/UTOGNOnOhnnagKp9uP6LwElFz
         Yqhg==
X-Gm-Message-State: AOJu0YyNvqQelpZVGxbiTp0VN6XpYY/W2uKalIVoOYFyUj4+jbmO+eL/
	0CBFsgWL6YDbGq6gyxKFVqYSyhuB693I/PIXQFEBiOaDSgbqJkCbv+7XXU6vLNJqiTWJaV+Xx5s
	O406VQ+8ag3j5HFTuLNhQrKaqPrI=
X-Google-Smtp-Source: AGHT+IGqowqRAl5PdTF1rnScGmbNcSfG7ZDGD4Ktrq2tS1JgMdU74I3wv6UemPWZL98f3JPsYBrEpwoTHxUietczihU=
X-Received: by 2002:a5d:54c7:0:b0:371:9154:597 with SMTP id
 ffacd0b85a97d-373117be4b7mr9547558f8f.0.1724802152713; Tue, 27 Aug 2024
 16:42:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823222033.31006-1-daniel@iogearbox.net> <20240823222033.31006-2-daniel@iogearbox.net>
In-Reply-To: <20240823222033.31006-2-daniel@iogearbox.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 27 Aug 2024 16:42:21 -0700
Message-ID: <CAADnVQLLLD-arUV0uG9Kxyra_Tdu07yP6HNDwPZC1JzARhE4jA@mail.gmail.com>
Subject: Re: [PATCH bpf 2/4] bpf: Zero ARG_PTR_TO_{LONG,INT} | MEM_UNINIT args
 in case of error
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf <bpf@vger.kernel.org>, kongln9170@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 3:20=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 2ff210cb068c..a25c32da3d6c 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -6264,6 +6264,8 @@ BPF_CALL_5(bpf_skb_check_mtu, struct sk_buff *, skb=
,
>         int skb_len, dev_len;
>         int mtu;
>
> +       *mtu_len =3D 0;
> +
>         if (unlikely(flags & ~(BPF_MTU_CHK_SEGS)))
>                 return -EINVAL;
>
> @@ -6313,6 +6315,8 @@ BPF_CALL_5(bpf_xdp_check_mtu, struct xdp_buff *, xd=
p,
>         int ret =3D BPF_MTU_CHK_RET_SUCCESS;
>         int mtu, dev_len;
>
> +       *mtu_len =3D 0;
> +
>         /* XDP variant doesn't support multi-buffer segment check (yet) *=
/
>         if (unlikely(flags))
>                 return -EINVAL;

This looks wrong.
If selftests are not failing because of that they should.

