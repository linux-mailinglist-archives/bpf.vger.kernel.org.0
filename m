Return-Path: <bpf+bounces-54291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B98A670E7
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 11:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1B643AFAF9
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 10:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3905206F37;
	Tue, 18 Mar 2025 10:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AQpgYCmf"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E845E20764B
	for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 10:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742292813; cv=none; b=seyNI7Ip6HziVZOsEFWtt2sI8137KORx//G7E73DAqm5X0Nb9yJ2VytiaDIYAzs1T4eXkmKqAMuofMOfjylWsADlTcz17BTHrqbLBKomzzTJRjKBPduj4yz63KQlpZoFUBwY86XIcoo6xAUIdT3yvolcmhg87kkRP8X2cDnv3c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742292813; c=relaxed/simple;
	bh=bTXyPUX/nTogcTrzO4w+0DnzKj6GcEsE6zMX5lpp/T8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KCo2oajZwfZkcah3bFcjMiVz6+jrBln+GSjyKRItbB0lFzIWR9/djbxN6mt0kyEi9x6UJCiMWSda+yve3+GQOaX9gKRHn6EvPBq9L+wBAumTWyyzkrC5vpdhJvnSYeIdlwJbCUTIFZTP7U9X0yZe4+jE1Md95WGGEQ3yJGCjOFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AQpgYCmf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742292807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bTXyPUX/nTogcTrzO4w+0DnzKj6GcEsE6zMX5lpp/T8=;
	b=AQpgYCmfpA2TBL9C2S2jkX34ddR0CnZKOoYKQbKX/3evvYkWW+bPjcFOit+tFC/2noS2Sc
	pyp1YrNhQ7zrpCScspKNxPf0WUP2hGBvrIKKkpyQYCY+Iy25TtxlD4uXMvxSsRhl3DfwEw
	zoXJeNtVbPahL/3ghvYnAf2svs3QQh8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-f8yu4JTiNTOgZBooN58E1w-1; Tue, 18 Mar 2025 06:13:25 -0400
X-MC-Unique: f8yu4JTiNTOgZBooN58E1w-1
X-Mimecast-MFC-AGG-ID: f8yu4JTiNTOgZBooN58E1w_1742292805
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43d209dc2d3so19101335e9.3
        for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 03:13:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742292804; x=1742897604;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bTXyPUX/nTogcTrzO4w+0DnzKj6GcEsE6zMX5lpp/T8=;
        b=gJuWMx2Z/Xm5YXachCFzLtDe8Zb7Pl7yrkB9ifIeFI7CksiaTQwBJhK+mLy8UZqbPl
         wEkcn2Hv9/98HwgbiTCxO4RCIOcj43z5v67j3Xz+/+hG+ERRu0qWFViBPcjMd4CaRkAS
         p7ludagtD+/CHKmdz5xq2u8JV+sulOdbGNKim7xYS3Y2b8NfFKQJRH7MJKkPoJ7RFSyb
         gwExKBzgq05iOsmlODmjRzzdHC/EZ3jw+4pTYlcPMmbdQ0ti/iK1zxt3SQQ70X7aak2P
         wQNN+it2OXR+P3He9TshMgOcYsrf59fE6BGPIydPW56v0smDC06zVUVq5IMjrs/jPVfd
         8xXg==
X-Forwarded-Encrypted: i=1; AJvYcCWVnyu7oBPVb79czns5e7T62z2FVl0CEgjqR82SAJAVOEv3itzDltEx4B6bt+MR1NzloWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpegOuKMzysFdbQb5ZkjfUe22AEQK7x9Trjg4sGaf2HLE8xyRG
	s12i40d7yUAMHcmhhOYk4GIinqWcZAPpv3F6pW9WRUs15LhnJt9wG5uXTmNIq69FuL9S98emtiy
	v1YNXeS+LWcnjVcF6duU+8N/j/XNm06uhMNr5nrWSo51xjYwH8w==
X-Gm-Gg: ASbGnctdRtIA1kCfb6nf4I1yAZP1XZsbPh1yhi3XPUgOLZ7vJA9vszWC3BKYw1D4nw/
	Mv+YYxf3S3T+Z7X9WGPS872m8zsis99UA2p0Qnq5PmKH04oM98pidFC2OvmtOiLdQ9tymj6cYW8
	bfp0zGah1VR21GRndaBK4zuJhtvz67kcmBA4GVh98VYqe6GifhZU/kn0GlIpP4ByVt4QGqDf43P
	LKIS4l5qDI+EElbUgG87AHX4oz2ysUWMPgv8GCV7ZHMIsJJViu+GYKHsOYo0SwecO7Vo+5oNIOv
	nl9pfoyemyUumllHzhi2Szn7Wk7HD/9IRDt1rCy3FomvSw==
X-Received: by 2002:a05:600c:5112:b0:43c:e70d:4504 with SMTP id 5b1f17b1804b1-43d3b9cd704mr14645175e9.19.1742292804478;
        Tue, 18 Mar 2025 03:13:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEa2x79C78ENEoyzPPniqeGCkHBce2M9I0jdc1yv0/RSaEENBZYufXun9PO4beIARs4YqnHHQ==
X-Received: by 2002:a05:600c:5112:b0:43c:e70d:4504 with SMTP id 5b1f17b1804b1-43d3b9cd704mr14644695e9.19.1742292804010;
        Tue, 18 Mar 2025 03:13:24 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fe609dasm129105475e9.28.2025.03.18.03.13.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 03:13:23 -0700 (PDT)
Message-ID: <6259af5f-f518-4f88-ada9-31c3425ce6ed@redhat.com>
Date: Tue, 18 Mar 2025 11:13:20 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/7] net: xdp: Add missing metadata support for
 some xdp drvs
To: Lorenzo Bianconi <lorenzo@kernel.org>,
 Marcin Wojtas <marcin.s.wojtas@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sunil Goutham <sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>,
 Subbaraya Sundeep <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>,
 Bharat Bhushan <bbhushan2@marvell.com>, Felix Fietkau <nbd@nbd.name>,
 Sean Wang <sean.wang@mediatek.com>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-hyperv@vger.kernel.org, linux-omap@vger.kernel.org
References: <20250311-mvneta-xdp-meta-v1-0-36cf1c99790e@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250311-mvneta-xdp-meta-v1-0-36cf1c99790e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/11/25 1:18 PM, Lorenzo Bianconi wrote:
> Introduce missing metadata support for some xdp drivers setting metadata
> size building the skb from xdp_buff.
> Please note most of the drivers are just compile tested.

I'm sorry, but you should at very least report explicitly on per patch
basis which ones have been compile tested.

Even better, please additionally document in each patch why/how the
current headroom is large enough.

Thanks,

Paolo


