Return-Path: <bpf+bounces-52618-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B29C0A4552E
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 06:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2BC53A9DD2
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 05:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270FE2686A5;
	Wed, 26 Feb 2025 05:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PfAREa7N"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19402676CE
	for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 05:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740549570; cv=none; b=C7cy92pk54LcP3cEbf7AoKV/wRa1FhZ+2f3lZsoy292yCizwFzq0f6cn2UNfFMXsu8VL8B1MRrM5zfFtxBKWfXgBZYlA8ZGIE512DIgNvLJODZRVmF+XdtFZzBqgKWiDM1oKJ7o0HixxmnOwqdXMKw6ZI6miEJ/QIWuJYzBo8J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740549570; c=relaxed/simple;
	bh=m7gnNaSnVIQnhwXaGmMm7ApeqEyKQEEPJJKfMSkYWew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HdACYZInswL8y4gAaoJgrOF0hQih1JNVJIZvfVgK4ByAt85kES2Hto3zOzeBWPsiz/yD1d/9E1DaoOmwi23iRN95ANcpakI6easjLdJP87uVAjseAm+muzmb0bqq+Sqxig9X2zLL5RebCIzesESQid268HE5RGsp/4kP6+TMq1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PfAREa7N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740549566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m7gnNaSnVIQnhwXaGmMm7ApeqEyKQEEPJJKfMSkYWew=;
	b=PfAREa7NjUAVOjJaRDNGG9uKIUR9M2DzXN5lsVlMkn9lOsJXJmfzrVJGDxQSeO0DTnxDvM
	3rcdE0k7jhAunAEupe23L1YvdBq5L8+2kF6n3HqQDD2BuZh6MezaoA2zIMcXeHu6SgUQFP
	qXwN6eqA8feelBQktZYdcEo72GuYBmg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-_YYty3xZO9ueCzdCArETUQ-1; Wed, 26 Feb 2025 00:59:25 -0500
X-MC-Unique: _YYty3xZO9ueCzdCArETUQ-1
X-Mimecast-MFC-AGG-ID: _YYty3xZO9ueCzdCArETUQ_1740549564
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fc1cb0c2cbso21025561a91.1
        for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 21:59:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740549564; x=1741154364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m7gnNaSnVIQnhwXaGmMm7ApeqEyKQEEPJJKfMSkYWew=;
        b=WaapxBuKcbunjnIw76KylRfmDUI5o0iYboEJvBxvOskp8am6V4owatBkz9q5VuKIGU
         j//PPIBp80suENZSsfTnqXKO0+TwJahVv+CGbh/Xdlxws+b8Oq5SMUo13NeGFSeMDowG
         2dHwzJZdtdolcfS+FoDQRLS+WXJ2Qh5KkK5VTXaLST+rHlNhf22aGsUIUE6Q9VWAGpsv
         fQ5j9WmyGavWifoVTxRBiakMvwRBMrvM+rOqt6KWSw1UGRKAfGC6FCIsKStR998lZLzB
         xslNkdpTftgCq/ob5Z3EooI7KvUDFUQp6Zltm55jODO6nKkoZRAWxyrBCZUwXiaeLOZw
         /qlw==
X-Forwarded-Encrypted: i=1; AJvYcCUpE7Y0DmUAGyjYfb3j8D25xCsVfIaVUskkqX8wh9as6mSFgbFTBzM5ozF5gMSmYFWlOgo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc/GdIGweS2Q9iuvi9H3vpnibsL5YgtpIv+e+uNAdR4C7Q577l
	kWIKj2psntuT8q+Pqd1mDsP4vYJke0RJHosb+lpp9tS0E02o/FtxmkcTZPsUxSecbMpPsGCR/iA
	GaxHdeBQ0D5zKllFJEiQa+EhfUXQgs7N454FfN6EG1gnudYDp8ySWPOXsAVK7fiim36IIAmGRAB
	YZakscIHCy7mi9QtRZRCb0blSV
X-Gm-Gg: ASbGncu84ygYGf4Cyq+S/q1qNn2saJcVnAsk7UnzTMSLgwIIIRC5+DS9WWT20tBJZHv
	CcIJJmt+4ljg9bXkX29zaunFIrYnwdX76mwKH3X5WJqj1m37clmjQFJWY+RyWjfRYbtlA2tONWg
	==
X-Received: by 2002:a17:90b:2803:b0:2f4:4003:f3ea with SMTP id 98e67ed59e1d1-2fe692c8403mr10781869a91.33.1740549563985;
        Tue, 25 Feb 2025 21:59:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjfukw25/3dRjwBrKqTgNYjNEca8F88lv26UtFCag9qeKPB/TQL+bJT6mEpFZEyRdR+HxO/f/07hSLXK/EZbY=
X-Received: by 2002:a17:90b:2803:b0:2f4:4003:f3ea with SMTP id
 98e67ed59e1d1-2fe692c8403mr10781849a91.33.1740549563668; Tue, 25 Feb 2025
 21:59:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224152909.3911544-1-marcus.wichelmann@hetzner-cloud.de> <20250224152909.3911544-3-marcus.wichelmann@hetzner-cloud.de>
In-Reply-To: <20250224152909.3911544-3-marcus.wichelmann@hetzner-cloud.de>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 26 Feb 2025 13:59:10 +0800
X-Gm-Features: AWEUYZn3sINGV0LaU89f2SQBC-EkP65HckbvJbjb0aMWfaIJ_G6VZpbaC4mxxbg
Message-ID: <CACGkMEt72ZwDQUUDPUrxiEJQLTWBQ25pP0wCO-FrZ2tZDj7itA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/6] net: tun: enable transfer of XDP metadata
 to skb
To: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, willemdebruijn.kernel@gmail.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, andrii@kernel.org, eddyz87@gmail.com, 
	mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	shuah@kernel.org, hawk@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 11:29=E2=80=AFPM Marcus Wichelmann
<marcus.wichelmann@hetzner-cloud.de> wrote:
>
> When the XDP metadata area was used, it is expected that the same
> metadata can also be accessed from TC, as can be read in the description
> of the bpf_xdp_adjust_meta helper function. In the tun driver, this was
> not yet implemented.
>
> To make this work, the skb that is being built on XDP_PASS should know
> of the current size of the metadata area. This is ensured by adding
> calls to skb_metadata_set. For the tun_xdp_one code path, an additional
> check is necessary to handle the case where the externally initialized
> xdp_buff has no metadata support (xdp->data_meta =3D=3D xdp->data + 1).
>
> More information about this feature can be found in the commit message
> of commit de8f3a83b0a0 ("bpf: add meta pointer for direct access").
>
> Signed-off-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


