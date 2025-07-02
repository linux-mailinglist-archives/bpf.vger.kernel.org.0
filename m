Return-Path: <bpf+bounces-62081-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C116FAF0DCD
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 10:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D57A81C250D1
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 08:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE607236454;
	Wed,  2 Jul 2025 08:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="IdS4WZv3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48184C7F
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 08:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751444548; cv=none; b=uPSZsdveitdW+DMTGJmDOm91oKoLFF8T0I5fDsoW/arqUSiKws5nq7DxSmvfxfmx0mtq52/rkvrKRC0aCGVSXMlUwg6Crie4+4liZdH+StIGgmXPS9oVet6savSJRSoBMbbd8QagqU575ZuxQY4I9wUhsLCEyK2mW/Bl21eYED4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751444548; c=relaxed/simple;
	bh=lEB0197n+DeT8LUiIDrX2d8wdS5PwXWjdYpoGmqNvhI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NoeuQKa4gazPXDijFQL/5Wx0zADla00DpZKOpow0OFyzQR5BVOkbxzsQtaanTEP7Djc/YBjxtVduj+scHLPAIVsPGVY/mlK8t0lKfVCv6AzveVOBNNX/4UqQ9W7YlxX20MRouVusYC+h/Ew+1Tc9g8lnhNenjci21vBD02yJxAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=IdS4WZv3; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ae0b2ead33cso1144906566b.0
        for <bpf@vger.kernel.org>; Wed, 02 Jul 2025 01:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1751444545; x=1752049345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tDZq2jAmbOtNNTelYfJqHekR92CRgjmJZJTVyE8kQdE=;
        b=IdS4WZv3gbIRHkuZln2KTC6xZkXIbH0UNfp6P6mPmllpet+6o/qvnLPZOSfg948hxr
         AkjvAQPsuHkKqjFFXH/mOGpm76K6bqioj7EEr+FrybsZ+cViafo/FX5yQFXMJK3jbNy9
         fBOBYHo41nI3BNd/jXyuO7OT5NYKc5NPth/qc/t7FMkEX5jyg+qqHMXztt4DYBTOQoma
         fXe1jTkhymyCVQpNQtBnSQhafELLSGyIgxL1p2kR8Fgl+99j56KNQShKrhZBOrFpgGfy
         knfM+F+y/Fl7Yu1LJhdKnHQGGSnkozqTWdMXsdo4YOfEn9ho5Uz4JU9wHPNIIqvRKixQ
         XSCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751444545; x=1752049345;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tDZq2jAmbOtNNTelYfJqHekR92CRgjmJZJTVyE8kQdE=;
        b=BN1xvikK+n2+BhDeflLF8AxS1G3ctB0F4qYttgh5pZBRbjnlljL2q3srtnz32TIFNi
         2ndzY12EZ10E2WulnNYk5r1LGBecacD/foU7kLXjBavTDHi3caDDHSio6sGtfXffqoa9
         tPxRGUsfa1fvFTub7uF2f5gDKgLDRAnAm+q3F+VOdyDOBTlQf3uNAGBOpLM8+oMPSKMI
         H2x+9C5U1Gaj5pCqw2AWPwvlDjkLyddwjupOYBs6i6/zKGVIbkv7ZlfQaKk3uwbTUGIq
         FcTYVV9AnEM+d4f4U629v9BX+7D7r1LULETXlfRmZqVf8BNmE57RvaQezV3mTDCfd4Zz
         QwXQ==
X-Gm-Message-State: AOJu0YxpH+gkG+GOkOwRgfQ+jnVO60kLilgH7Gnv+y2qTMwsDkD3ZD/a
	J4e5N+F018rHiXAHwsQC8blCOp2Ir8bRlhB/udCEICpNNXGLGGm2l+tXMK43xkSSAJw=
X-Gm-Gg: ASbGnctJKFYJgEZlLwoy1CsC65cr+XpANXpsJ2utOIxYLTOyb7L6yAyLPtFm3bMP/JX
	9kVcO1KiPOyx3iJlB1MCI2raZklZq63/1f95K4Gp7LddplQCItDVk7UnlSsQsVgyddalXWgNe1H
	38ScMoIiEOYGdEZLJ895+LyrodkAipuMnj3Sh7tQTFHZ4fiIdZH5dzDGpuukk9QG6NxKWKX7D+r
	tYsrdUcv452ThP93Wu9NgFAGF/NLTmt4rI0iIfkTyxXn8nbmSFVbOVtaMNbB48WVyVrsjPDlj5w
	GOQO271nmDlUPZ/apXR4mhHWBX/Gfe3EgZ+HOgd867lf3j+7fDxW5o9GsW1O368iCQ==
X-Google-Smtp-Source: AGHT+IFdwG6iWebc01cvZjnOgUq5Rid2gTzPpRepPaKrph60ofYGzrziYaHpyTa81CVGkghqtjGvLA==
X-Received: by 2002:a17:907:1c26:b0:ae0:d4ef:e35e with SMTP id a640c23a62f3a-ae3c39a32b0mr150593266b.20.1751444544956;
        Wed, 02 Jul 2025 01:22:24 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:e7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c65ac7sm1031255466b.119.2025.07.02.01.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 01:22:24 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,  Arthur Fabre
 <arthur@arthurfabre.com>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Jesper Dangaard Brouer <hawk@kernel.org>,
  Jesse Brandeburg <jbrandeburg@cloudflare.com>,  Joanne Koong
 <joannelkoong@gmail.com>,  Lorenzo Bianconi <lorenzo@kernel.org>,  Toke
 =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <thoiland@redhat.com>,  Yan Zhai
 <yan@cloudflare.com>,
  netdev@vger.kernel.org,  kernel-team@cloudflare.com,  Stanislav Fomichev
 <sdf@fomichev.me>
Subject: Re: [PATCH bpf-next 03/13] bpf: Add new variant of skb dynptr for
 the metadata area
In-Reply-To: <CAEf4BzYjUc_ppemufs98YX+hvQ7vmSkBayuhsATkqCwOzh90aQ@mail.gmail.com>
	(Andrii Nakryiko's message of "Tue, 1 Jul 2025 13:59:15 -0700")
References: <20250630-skb-metadata-thru-dynptr-v1-0-f17da13625d8@cloudflare.com>
	<20250630-skb-metadata-thru-dynptr-v1-3-f17da13625d8@cloudflare.com>
	<CAEf4BzYjUc_ppemufs98YX+hvQ7vmSkBayuhsATkqCwOzh90aQ@mail.gmail.com>
Date: Wed, 02 Jul 2025 10:22:23 +0200
Message-ID: <877c0rngsg.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 01, 2025 at 01:59 PM -07, Andrii Nakryiko wrote:
> On Mon, Jun 30, 2025 at 7:56=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.=
com> wrote:
>>
>> Add a new flag for the bpf_dynptr_from_skb helper to let users to create
>> dynptrs to skb metadata area. Access paths are stubbed out. Implemented =
by
>> the following changes.
>>
>> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
>> ---
>>  include/uapi/linux/bpf.h |  9 ++++++++
>>  net/core/filter.c        | 60 +++++++++++++++++++++++++++++++++++++++++=
-------
>>  2 files changed, 61 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 719ba230032f..ab5730d2fb29 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -7591,4 +7591,13 @@ enum bpf_kfunc_flags {
>>         BPF_F_PAD_ZEROS =3D (1ULL << 0),
>>  };
>>
>> +/**
>> + * enum bpf_dynptr_from_skb_flags - Flags for bpf_dynptr_from_skb()
>> + *
>> + * @BPF_DYNPTR_F_SKB_METADATA: Create dynptr to the SKB metadata area
>> + */
>> +enum bpf_dynptr_from_skb_flags {
>> +       BPF_DYNPTR_F_SKB_METADATA =3D (1ULL << 0),
>> +};
>> +
>>  #endif /* _UAPI__LINUX_BPF_H__ */
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index 1fee51b72220..3c2948517838 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -11967,12 +11967,27 @@ bpf_sk_base_func_proto(enum bpf_func_id func_i=
d, const struct bpf_prog *prog)
>>         return func;
>>  }
>>
>> +enum skb_dynptr_offset {
>> +       SKB_DYNPTR_METADATA     =3D -1,
>> +       SKB_DYNPTR_PAYLOAD      =3D 0,
>> +};
>
> I'm missing why you need to do it in this hacky way instead of just
> having both bpf_dynptr_from_skb() and bpf_dynptr_from_skb_metadata()
> (or whatever we bikeshed it into), which will create
> BPF_DYNPTR_TYPE_SKB or new BPF_DYNPTR_TYPE_SKB_META dynptr kind,
> respectively. Why so complicated?
>
> [...]

Agree. Let's keep things simple.

This piggybacking on the skb dynptr was a bad idea.

