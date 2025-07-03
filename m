Return-Path: <bpf+bounces-62246-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07780AF6E8E
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 11:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DDCF3B1F71
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 09:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566072D6622;
	Thu,  3 Jul 2025 09:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aIPgo60Y"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561BE2D63F1
	for <bpf@vger.kernel.org>; Thu,  3 Jul 2025 09:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751534754; cv=none; b=pTsVIAVFMpYRo09ksdq0qpMITXJcKSv4EMYdtoouPJdjgC7yOm4/j7sw7T/fZAt2N4VBNsBgM3uWRkFFpKNO5+g4PX7CC5Jur8Qv4fjXDbHvJxv27QPv5nalbQ7gu16TBksrnJCWbnI9KZ18KYE2iNTNZi2p/eM5bq0AydyJ2RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751534754; c=relaxed/simple;
	bh=STzWJep7C0ueCylwebeqomoBi53CDoyHXyyg3q6vros=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KNcaVXR83qbY2I8ozjH9rKvNAqFcNCIu9Tz8dwxgngZckeuE4kMG7U9SYR/xhBkykY2vKya1u8CN/4NMOnW8V/UKKkKe1qcKmWenhhhnu94fBgO3VnQ/Ba0+FGMInxMFC2PkF6IL/l7yEVwnK/DflWQfRcW6wViQ0NtGAfR/Gk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aIPgo60Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751534752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NmUFP/5otJp7Yva7rirEL2lRiqI/PxhyfiBWQUHadCI=;
	b=aIPgo60Yx1rUEP7wrBc57yg3ki75N3xHe+5dmEIYGa71+TANiHnUPsLEHt7NZaHd0mFs2I
	86pJTwveZex9LQ06bSikcYQk1Ntz9QhNwccIW+nhnrGxqG2+p7NVbUbSRnvl1EtGQ+YZBk
	FgpR9P1A78Er4D60dLYXf6sgOKgl6JU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-ismqGMN_MgeFiJAnD0A4Xg-1; Thu, 03 Jul 2025 05:25:50 -0400
X-MC-Unique: ismqGMN_MgeFiJAnD0A4Xg-1
X-Mimecast-MFC-AGG-ID: ismqGMN_MgeFiJAnD0A4Xg_1751534749
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-453691d0a1dso30700855e9.0
        for <bpf@vger.kernel.org>; Thu, 03 Jul 2025 02:25:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751534749; x=1752139549;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NmUFP/5otJp7Yva7rirEL2lRiqI/PxhyfiBWQUHadCI=;
        b=WKm7Gp9g/ViZh37fn37RJLYwem98bQwX1WaCeWlxb90ibmy/BvO2sUGqrtT1AADV7J
         9eCTrqNYuRJlakKyMW5VQtJUdrC4GRifcbjwUUVj47kCoSK/pdJ/yyddqOYXNg/KTKm6
         Tg0GA5POjit7Yk/5v4BmN1OxK0GTSGlrSnA7ik7zFDzEWwxsq2M6/rt1yDb19yxsXvsO
         ipdZ+mUNYQhM3IkhTZw0XYLN2GUwdnLXcEVrQL2Toqgtu44PEOGL8x12fQXCwqC0Enrm
         IxvBFpdkfXp36Bu4x+wcQ3p1GdlsgMIJydNyypam37h19gnYuptMnNd2cCSmyIF44MGK
         efIA==
X-Forwarded-Encrypted: i=1; AJvYcCV139izDB5DILDPulZizK2mM5V2gTo9nIJWfYjdjcYJsh73jXuTvLXSlMeY5nzPf67zL3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMJdaOHKnjMjE26XXFExbayQ/15TvX1n4/2YKi/YGDis3NU0HP
	gBgxekWPSce2GkJMyI7wO2MiMjqZRSId7vxVbzc7vH4C2xDf85ZKNShNtCNOshcWOF+bfOFnZYW
	1E7eIbNA5s+QBhjVCMHZ/60SOWEw4b1u/QSxwLOS59RDXYWYgix+J3g==
X-Gm-Gg: ASbGnctc3acFk9XgQD5lVz8D94ym04TTbc1VZ8yt/dU9D8U7ve/L9xt4KBYCLzeN8/j
	SAOwegOfKrOHqlHerh3dvKn3QolkXKgIjb5mFNiHVzDWMNyCPdwKQFPJrhnbAxkQ0wLIaBRPoQK
	Oodi5LxbEATFPh5pJUAQCpP3rHl2rvCjjR9fmD01A77oy1xqo83mUoOJ9imUzcqymWM6RdyTQj4
	ZMEh+aB0RG/9WXwr+G7RUY6nx+nILyoXkKs4RgRF9aZJbuX4jwGQXg9GXoBjqZJWgFY6Os+8rVn
	x02ACxaEE8eChMEgLjoLgQBlluChvSW9+JjRi94rReS+gancC04TfaiQGRLkftji6Ug=
X-Received: by 2002:a05:600c:608a:b0:453:8f6:6383 with SMTP id 5b1f17b1804b1-454a36e996cmr71174395e9.15.1751534749318;
        Thu, 03 Jul 2025 02:25:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEihb3DB580vG3swYDdikiInjReCzKhZiPBvQTN0giVHizEK3OOIkuH4ihxHrIuTcVlib7I/A==
X-Received: by 2002:a05:600c:608a:b0:453:8f6:6383 with SMTP id 5b1f17b1804b1-454a36e996cmr71173955e9.15.1751534748907;
        Thu, 03 Jul 2025 02:25:48 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:270a:b10:5fbf:faa5:ef2b:6314? ([2a0d:3344:270a:b10:5fbf:faa5:ef2b:6314])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a9969058sm21577325e9.3.2025.07.03.02.25.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 02:25:48 -0700 (PDT)
Message-ID: <869be9b5-846a-478a-b90f-5e9068387601@redhat.com>
Date: Thu, 3 Jul 2025 11:25:46 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 2/2] virtio-net: xsk: rx: move the xdp->data
 adjustment to buf_to_xdp()
To: Jason Wang <jasowang@redhat.com>,
 Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250630151315.86722-1-minhquangbui99@gmail.com>
 <20250630151315.86722-3-minhquangbui99@gmail.com>
 <CACGkMEtv+v3JozrNLvOYapE6uyYuaxpDn88PeMH1X4LcuSQfjw@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CACGkMEtv+v3JozrNLvOYapE6uyYuaxpDn88PeMH1X4LcuSQfjw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/1/25 4:23 AM, Jason Wang wrote:
> On Mon, Jun 30, 2025 at 11:13 PM Bui Quang Minh
> <minhquangbui99@gmail.com> wrote:
>>
>> This commit does not do any functional changes. It moves xdp->data
>> adjustment for buffer other than first buffer to buf_to_xdp() helper so
>> that the xdp_buff adjustment does not scatter over different functions.
> 
> So I think this should go for net-next not net.

Please, re-submit this patch only for net-next after that the first one
will land there.

Thanks,

Paolo


