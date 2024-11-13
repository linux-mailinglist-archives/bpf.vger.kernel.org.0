Return-Path: <bpf+bounces-44810-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4418E9C7D11
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 21:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08332281DDD
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 20:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4106820696F;
	Wed, 13 Nov 2024 20:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIwFAmJ2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76201206506;
	Wed, 13 Nov 2024 20:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731530531; cv=none; b=el7rPJ+m6cWQ2iFl8Or06mGl4++Xe2bD77qFk11L23lKzPVxNi+CKlDHr6vea5lI6QLj7ZBgPdlCLe9Rn4vyUgzlgOWzdat2W00sZDXYcKGBmqUQoyQc2JyK7KgObufKyCt9y9bz4CXv6QCEPyvBucdPV/cYbUEzcOEFM/WHKaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731530531; c=relaxed/simple;
	bh=dsslkL/cHDha94ojCCxtKg9sxCwFPRnQtzza6/zFv0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bM6Fs/vo2uoRXzil/cTeUjKdDhmbhghAOPwYgNv99jAxv0+QVGZyel7LY8I8mmYuOsYn0DaGrfeE1II4TwrKumKeM8oo0UeA/matY5U8XG8cO7qilZO05jTALwpb4XAMwqZMLKjvnNKnoO9/F+PUjHZnPi2OPtjR45rp8p52K60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIwFAmJ2; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21145812538so68432055ad.0;
        Wed, 13 Nov 2024 12:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731530530; x=1732135330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x5k/vcy+YkRtsXHCvxx1YoArBudZGxMfgRmDXEnYjP0=;
        b=fIwFAmJ22VtgoBKVZY/eNIfxE68YjPBEiubt2wcmnx/HpbTf6Z3SHSJjee/2IHok7/
         93k/de55IAHlBir/Q4VmvpthjVvJrseoh5TQ2jmui7eq1AGmG+GstRbLAsR84uvsfIAa
         IIIRMb6/ehKP/EumSi5xdTzF1QYrGuA/i91iIMf+jL0k5DS3bD3EHplUtVxFJ9WKfbaY
         mDvIeSxwI2K44aDhdaYy6Qleyex9UO0DX19kxM5wJlb5GCpM2/hvqA2WLIEKsBrKxLsw
         SwLkesvSKcL3wQ3gEEuD/nGYoaDaaJWxgSwPh0rdhjmBmBs+ANIW4uua1TCxQcZeIR/H
         7PMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731530530; x=1732135330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x5k/vcy+YkRtsXHCvxx1YoArBudZGxMfgRmDXEnYjP0=;
        b=qMyuNI8Od2MMWUyXDN4P2qvnZEHDyraFg03bhChf+J1/re1b64IaFBkC4AXXYHe/2Y
         i/xSU4AKCpX4JIqWFQaxZM/Ookg2adhMi1NlJUfBURHzMkojZcTdgI662aI6S2OJEcu0
         3eWWn3ajMMZspahpOSyYJI0l73cgMaiAZPi4e1patZ4MBBVVczdCJjkFflj9xr2hWo72
         6Grn/HjzUY/DJQLVa9HVCqdMBC0W58/hTyrxFp60zY51m3VpeRmpZlA2GNJvgezqmM0b
         bfO4iVAz3SKkCU9pq8nf1PFroyux7X4YyAZHfrW7FsJHKNTk7N4V2bkzNqiXKn5HAU1u
         VU2w==
X-Forwarded-Encrypted: i=1; AJvYcCVPQhAujdTtcYWWmSPrN0skY8LRRvNqBcQuwgdt5rIRD0FuAGiSnyWA5pY3P6YLDXn8a0Q=@vger.kernel.org, AJvYcCW64YDPV6UrAJ8MCS0ijlwOloWc2I/WWHmLjBeGYRPj+7RQRdmKGOnMUygeZVxgG9BdgwPFcLnbGJlRYU8H@vger.kernel.org
X-Gm-Message-State: AOJu0YzKrmMWTe3A1MrCT9IQt8R/iBV6q4rUrbCffSGnnmm24QQt3YeQ
	nlvopR6ymgc77Cv9BQYtFEq/8kMJV0MXMf6Yj9ARJpHblzIkDWOXDKHur6swe5n1O/SmBCK+rmJ
	FR0IvvR6wTvYpZwVUGuN/9QBV4DI=
X-Google-Smtp-Source: AGHT+IE35WNA1Cu6Rlck+f1V6KsF/J9hzAqRslj1Yazulz2bNH8vLzJsxqQANOVB0AN7CuwWYjHiIFZEy4+lP7L7isU=
X-Received: by 2002:a17:902:e549:b0:20f:c225:f28c with SMTP id
 d9443c01a7336-21183da3eeemr309510295ad.52.1731530529787; Wed, 13 Nov 2024
 12:42:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111062312.3541-1-zhujun2@cmss.chinamobile.com>
In-Reply-To: <20241111062312.3541-1-zhujun2@cmss.chinamobile.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 13 Nov 2024 12:41:57 -0800
Message-ID: <CAEf4Bzam6bRX+e5ZcQD-px59Fij_O6dZvk6VsKHZhDMURt7W_g@mail.gmail.com>
Subject: Re: [PATCH] samples/bpf: Remove unused variables
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, sdf@fomichev.me, haoluo@google.com, 
	jolsa@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 10, 2024 at 10:23=E2=80=AFPM Zhu Jun <zhujun2@cmss.chinamobile.=
com> wrote:
>
> These variables are never referenced in the code, just remove them
>
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
>  samples/bpf/tc_l2_redirect_kern.c | 4 ----
>  1 file changed, 4 deletions(-)
>

applied to bpf-next (but added file name to subject, so not sure if
bot will pick this up)

> diff --git a/samples/bpf/tc_l2_redirect_kern.c b/samples/bpf/tc_l2_redire=
ct_kern.c
> index fd2fa0004330..729657d77802 100644
> --- a/samples/bpf/tc_l2_redirect_kern.c
> +++ b/samples/bpf/tc_l2_redirect_kern.c
> @@ -64,8 +64,6 @@ int _l2_to_iptun_ingress_forward(struct __sk_buff *skb)
>         void *data_end =3D (void *)(long)skb->data_end;
>         int key =3D 0, *ifindex;
>
> -       int ret;
> -
>         if (data + sizeof(*eth) > data_end)
>                 return TC_ACT_OK;
>
> @@ -115,8 +113,6 @@ int _l2_to_iptun_ingress_redirect(struct __sk_buff *s=
kb)
>         void *data_end =3D (void *)(long)skb->data_end;
>         int key =3D 0, *ifindex;
>
> -       int ret;
> -
>         if (data + sizeof(*eth) > data_end)
>                 return TC_ACT_OK;
>
> --
> 2.17.1
>
>
>
>

