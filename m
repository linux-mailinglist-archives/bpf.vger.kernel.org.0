Return-Path: <bpf+bounces-55220-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9FDA7A23B
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 13:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7420188F09F
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 11:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D998324BBE3;
	Thu,  3 Apr 2025 11:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UcuTvaiI"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A64224B0C
	for <bpf@vger.kernel.org>; Thu,  3 Apr 2025 11:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743681381; cv=none; b=VlPnjJsCoqge1+ZwnF8fNpVuev+GlhJDfzTHzNJ+ICCp1GrOPz6L2M5hipN8NyRzNqn/vf/9gIvVVofdb1QWk2BoE6vfJnPZYvcuOXC1NApqz7IAM0L8tz2cp0l3Orh9AMvkHTgSwArhyB2AnPghUdpkgkzYi09nkNRTkHpG73g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743681381; c=relaxed/simple;
	bh=CQW3LvrpYLZr2hfNBWwV9hoIx59/BSsLvUr5/tUTLg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pf/fcIzAhpsFDDuGkx/ZUJbQXqfxbOjIui1mV870hF0dUqkBRkWNJtp8qFnFHv9I7J/vZ7lHs6kjrBgq1MsrF2pUTRd+H9zwubBZ/DBBwV4z1x8eSseTiKkuvwNsepeEuNWS/I5N58cMlMmnE99XXA5HhsWF0kVSWTnigqlMRQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UcuTvaiI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743681377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0H5/xBFkSHvSdkgm2kc89t+j93IWUj4d38uiubvlMZM=;
	b=UcuTvaiIa4JvYlViu4Tbr8SIfXohQ2glX6O3m40MIBQPJXWOk+CAyRsWee6GizyO0csyin
	RG1uW4VJKnXNTUPoOP9+pQV181BviRjfdTBf+NFf7uhA7hzHn3XfUhP8FislCetyM6xAbF
	K+4A4/davgqzVjdJEJ7zYW429eXqFkg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-YfryqcJZPfuMlqEGuus8Ag-1; Thu, 03 Apr 2025 07:56:16 -0400
X-MC-Unique: YfryqcJZPfuMlqEGuus8Ag-1
X-Mimecast-MFC-AGG-ID: YfryqcJZPfuMlqEGuus8Ag_1743681375
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3913f546dfdso484878f8f.1
        for <bpf@vger.kernel.org>; Thu, 03 Apr 2025 04:56:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743681375; x=1744286175;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0H5/xBFkSHvSdkgm2kc89t+j93IWUj4d38uiubvlMZM=;
        b=wd9wTf4PFb04pi3mMbbxMJ97q0k7B7FLhyNTGRFsPmr6oh6VwW9XxSz5pLyOq0q2j4
         gaGLqREbYkTAOBJrhYCmKKJZCj6Vy0B+s9ODgp6JnUulY4uW6Vv+j8TLiMOaLxIwaYfL
         NsTiprnjMCv9BM4oMg9ZtLfSurxm6mQ2Pm+sOZP4buuGj04B4bdq+4I2X4rAPZDLcLCX
         1N4R4E/YXQ8cMGz+bYJEzaQZHG0+VjRG2ZayBn+cFW8hYY2QAG6FU+HCjv5PwUaoFrNM
         BGLdSKmbfIm+2/NNGj8gf4JY5ZqZF5udAqW7LHIWBtSVtZsOwShboLS/nzo6iOZH+H1l
         0Aig==
X-Forwarded-Encrypted: i=1; AJvYcCXF0iRJ1bLmvHXkgvh7H/Ef9jd8ZZkUBhWujiN6+v4oE8g8YESqU34KMRF3lY1JuCWXYYk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/JgPdeaYw2EeSkqcAvxlCzsCIqtwPd6wlfU4ytb7vAaNnkOVz
	XxTe41JuffLUz2qdjVlELaI8jI0P+OQ37ECKwD+42CBtiSNE446BNof2J41E9OIt2SX8KYiiMeJ
	4tc4/gIqR03qFEHO3yblMcTtgGuQBqBXjHv819YKDPoP9LH9ZKA==
X-Gm-Gg: ASbGncs+ebDAy2Lr4Vjix5/Jz5oxXLLLd22ufhoL+cC61yut+jfHPTGK3SmmXRv8J6/
	9no9OuD0MzyN9F7RKeheezfOUnvDl2UNvDdo/aWvzcDSHc2FB5HmMaA0pTeLNjecWa0bTT8+sxU
	smZxJoDbtd4YyglEZEIdm/aDOYxrMKg+ZBzNKbkcmoOe/UEmgkdCC7fs1A6SULyTrsMcDzpzoBc
	hOIAPkCSwJIGsY9LQV8pjVnfyfOHBcVjLv0jAFCuKGeo6+8BS9CaQphJjJhfyl4mxKlKT5d9uJv
	UIRov371YFBakje5rcLup0rprcKMjg9sLb+yVMlG3Lplgw==
X-Received: by 2002:a05:6000:22c6:b0:39c:1efc:1c1c with SMTP id ffacd0b85a97d-39c2976984emr5568299f8f.34.1743681374884;
        Thu, 03 Apr 2025 04:56:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGe9epn8RH+1tWTOrW9iJCz/QsoiUwz7lwD5Ai/FLreIW9iTiIUclOnBL+eTfQUeG5/OFX1zA==
X-Received: by 2002:a05:6000:22c6:b0:39c:1efc:1c1c with SMTP id ffacd0b85a97d-39c2976984emr5568275f8f.34.1743681374535;
        Thu, 03 Apr 2025 04:56:14 -0700 (PDT)
Received: from [192.168.88.253] (146-241-68-231.dyn.eolo.it. [146.241.68.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c30226acfsm1558796f8f.88.2025.04.03.04.56.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 04:56:14 -0700 (PDT)
Message-ID: <4ea9e4da-636a-4573-a0b0-78ae3972bdb0@redhat.com>
Date: Thu, 3 Apr 2025 13:56:12 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: octeontx2: Handle XDP_ABORTED and XDP invalid as
 XDP_DROP
To: Lorenzo Bianconi <lorenzo@kernel.org>,
 Sunil Goutham <sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>,
 Subbaraya Sundeep <sbhatta@marvell.com>, hariprasad <hkelam@marvell.com>,
 Bharat Bhushan <bbhushan2@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>
Cc: Sunil Goutham <sgoutham@cavium.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org
References: <20250401-octeontx2-xdp-abort-fix-v1-1-f0587c35a0b9@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250401-octeontx2-xdp-abort-fix-v1-1-f0587c35a0b9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/1/25 11:02 AM, Lorenzo Bianconi wrote:
> In the current implementation octeontx2 manages XDP_ABORTED and XDP
> invalid as XDP_PASS forwarding the skb to the networking stack.
> Align the behaviour to other XDP drivers handling XDP_ABORTED and XDP
> invalid as XDP_DROP.
> Please note this patch has just compile tested.
> 
> Fixes: 06059a1a9a4a5 ("octeontx2-pf: Add XDP support to netdev PF")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

The patch LGTM, but I would appreciate some feedback from someone that
could actually run the code on real H/W before sending it all the way to
stable.

Thanks!

Paolo


