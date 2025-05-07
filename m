Return-Path: <bpf+bounces-57710-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D515AAED61
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 22:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D6263ACA33
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 20:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E4328FAB3;
	Wed,  7 May 2025 20:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QgZ819Tm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C694B1DE3DB;
	Wed,  7 May 2025 20:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746651008; cv=none; b=TD3idrpX2tODC3jWQ/zQq/gNYubUjO2Xg/xIyfmCNvVdt9RWDCThK+X2bkapBSveHQb5iwfHXoO4weG45GoZBKExS76FaYsk4JL53S5clkYWLgeKKtoGum0p8YxINjGFdY8BIt+9tc2u6OUB2KpOURWX9kb0yr23ryIT2kr2hwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746651008; c=relaxed/simple;
	bh=RTzFgdYqMKIy1fECYhZ21RC3nL2J+DPf1mQUp9ZRSmw=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=K/u8YC3+xRACDULuXsI2JA+m5eovbjVdDUUCiA5lrhSLVzQ4cz1OsLH1Sls/qJPeAAZkRSmLUy/vLyPLUiLOYRKjvFmqIBs0lQI+6ItZUCU+eGJQI6XGRCDJDF4Aw1wolqFInLVCZyOBrraa2ge54mc+DWe/qttzSo5Ffs1+G04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QgZ819Tm; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c5ba363f1aso37838485a.0;
        Wed, 07 May 2025 13:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746651005; x=1747255805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJdYFz5H9Ac9Y1h/c2dEG8ah82bylcztNEpbEYWuC0U=;
        b=QgZ819TmDXY5Iddg477p5LpRQQ5+DBRsyHtJ/yz6QnLEnYUZIEGJvydCycoQPAAV/o
         PTqvmf2dkfmut7/s9jytJgyhXAjmMW7E96J1x84wnXEfPqdQdeuayMtehqI352nFJ9Nu
         /DXv7exjkp7/erhPQH1q8i6dQ669Yqa5si2JO/bWPJFB9qCnh0ymZAfPyVSZlK98A7On
         IJ8IeNMbt4ywzPMJeoknfyE+bvm/SC7s7TBBn9w0ElPLTfm8M/sPft5iIpe5Q3/+Fa6F
         NvkrLQETrs/Li3touvSP8ElGMHGXJ9tFikV00BujkoUgRB3jK6VzzeFaPo+09IfckWgb
         LulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746651005; x=1747255805;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJdYFz5H9Ac9Y1h/c2dEG8ah82bylcztNEpbEYWuC0U=;
        b=hGvaFAXk4n08T/JajN7BsHRf+PnmYV5ve262lSCYRCNSgx+6/lYpwJYyASwQFyQKGZ
         2ocRS0P5MPZPCP1hKx2le8vEheNgJHKvGTD9I+rhgkWyEPfVXMIcax/bh2nniC3CXGW7
         qjB0rpxgVmeshRAg7kWBWSZvE5GXNLxyhqY0upEvu8OBNkHxQqq+QRvLMBt6xWnsQzaS
         3jPrCg/TWy9BRfGaxignBnU8In1g6+rtYH+x1THybIibjGtOaHuHYkqJaNyBF17cLqMd
         HqQL2W+O+Xcb/m06CwkEE6Kou/oI46DYxHqpTMUD2WEv/dPtLwcu0/fM4WfIGyiuE5Ul
         AFAg==
X-Forwarded-Encrypted: i=1; AJvYcCUAosOkIgUCvDyO0p98Wg1YtXKm8acgsKnJNIHOiKHgmxH7drp29AyzbRCq4oO2MJFBUv0=@vger.kernel.org, AJvYcCUZTo5xT4OYwlYUlUZ86qtjrXfCcl0VlmLMVKQiSZ83MbetcDirJgOws3cvxH30I/XZjRap/wTX@vger.kernel.org, AJvYcCXNiP/rJ9aZP8fgDB7oqlTpjiiyxvRbtGfg04IZQldZBfWDahPveIJGZh0//RYMw8/KGHTLuEaakhRKl0Yd@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv8hiTiTjTwXQDK2kn0ZeON4D5qnvGPUtlyywujuZ36RvlqpHY
	VVryOLDJEk/hwNnmX2furcB/XQGqmarvCqmMBpzBfMtVgB0z8lEk
X-Gm-Gg: ASbGncv2Ak/U9RDLJFb6TLryAN/nVNHGERjtX3GDrWxMdKdJLElMdGpVXHnKKh3eAOv
	mSrpDYT8rRrMd4EB3Taw1YeZS9bnmc2xGTFM/NSLZBDMwZMxaJM014n6LO2MU3Z8vSo+yatLhBw
	XL3p6yGlMd4qAEsio9YA30e6b8WUWjfOi31TOrCV97KHXOa0qjmZEoTJptPZzr8W5XwWXMc2B4e
	qrxzjx9mI3cfSbY6QzEJRONEpwnOWqG6dTvv7V734KkPWIKFUaZnXwf4GG+Dv8V7nvMmNHz2ClO
	PMPQpLRvUxsvC2pO8fgMJAdXFpMOUa97Uo/BiX/X6MdL82K7IFqAugVRJfk7rbPJz0S4szdFkuC
	lD/k87Im2dC9IMH0VwBjQ
X-Google-Smtp-Source: AGHT+IHIENSOL5xWk2n0ZpKa2eUQ3plVdHmLfICCayO8Sn6MjIw8GtVlpnhxXvAblQvcnnj7pPvLwA==
X-Received: by 2002:a05:620a:4491:b0:7ca:f039:7365 with SMTP id af79cd13be357-7caf736f357mr690398885a.8.1746651005517;
        Wed, 07 May 2025 13:50:05 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7caf7529790sm211729985a.25.2025.05.07.13.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 13:50:04 -0700 (PDT)
Date: Wed, 07 May 2025 16:50:04 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jon Kohler <jon@nutanix.com>, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 hawk@kernel.org, 
 john.fastabend@gmail.com, 
 netdev@vger.kernel.org, 
 bpf@vger.kernel.org, 
 jon@nutanix.com, 
 aleksander.lobakin@intel.com, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 linux-kernel@vger.kernel.org (open list), 
 hawk@kernel.org
Message-ID: <681bc77c96437_20dc642942a@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250506145530.2877229-4-jon@nutanix.com>
References: <20250506145530.2877229-1-jon@nutanix.com>
 <20250506145530.2877229-4-jon@nutanix.com>
Subject: Re: [PATCH net-next 3/4] tun: use napi_build_skb in __tun_build_skb
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jon Kohler wrote:
> Use napi_build_skb for small payload SKBs that end up using the
> tun_build_skb path.
> 
> Signed-off-by: Jon Kohler <jon@nutanix.com>
> ---
>  drivers/net/tun.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index f7f7490e78dc..7b13d4bf5374 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1538,7 +1538,11 @@ static struct sk_buff *__tun_build_skb(struct tun_file *tfile,
>  				       int buflen, int len, int pad,
>  				       int metasize)
>  {
> -	struct sk_buff *skb = build_skb(buf, buflen);
> +	struct sk_buff *skb;
> +
> +	local_bh_disable();
> +	skb = napi_build_skb(buf, buflen);
> +	local_bh_enable();

The goal of this whole series seems to be to use the percpu skb cache
for bulk alloc.

As all these helpers' prefix indicates, they are meant to be used with
NAPI. Not sure using them on a tun write() datapath is deemed
acceptable. Or even correct. Perhaps the infrastructure authors have
an opinion.

From commit 795bb1c00dd3 ("net: bulk free infrastructure for NAPI
context, use napi_consume_skb") it does appear that technically all
that is needed is to be called in softirq context.

