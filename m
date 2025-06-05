Return-Path: <bpf+bounces-59758-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAAEACF212
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 16:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5067316C15D
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 14:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2364419AD5C;
	Thu,  5 Jun 2025 14:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsVM8EhG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF2619C542;
	Thu,  5 Jun 2025 14:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749134014; cv=none; b=TiYAhbbO62Onln4MncNmVhZ6yURvHVR1wviBI3hyB9c8Aa/QtMYPThlFFwOe/w7h5/h/Ynwq/k0wluypgTyKfgfVgpT3H9qpvCApTu7FgivEONzhYt+4XroPw5CfEUKEfpxXnt+LVM0BcFKXWSGMVaGLMM2cUYQzQmtY0rgCSKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749134014; c=relaxed/simple;
	bh=tr58EZgbVcJISngjP+ObYSCUQbAQYsfVcd2Vwdp3hD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UhGOjePFXhDAEYoypZqklx24DRYVwjP+PGYDs2rvbrOX7uwmzc9u0LcnB9C+Xh0Gtimo45kKB5fG2ETlNTFQakZRcojOKogTXtOsjn0KPdOsn85eyZJ1C4IFFxWuQnaBV9vCt5aRMln6MHj5JKf9BfT6MF8JMz0IvDKzNhVMeT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GsVM8EhG; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2320d06b728so9716915ad.1;
        Thu, 05 Jun 2025 07:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749134012; x=1749738812; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l9avWjVFt6aWkiQYT2o6nDnnWjkbc+AGyVyiibpfVvU=;
        b=GsVM8EhGv7fTMgIBH0lnq3zDiuuT1H5O/fBIN9Lu1VLCOyPOjtH/DkknEHRu/WXJxa
         lAjBoSLe7hy+XQ5/btvefKyqrgFwNSEXHFKHYtjmoYYZoV8c0Vdod6lSkm+aVYc/qdPd
         PNZ0Oy0MWrP6VyWYsvcTP6quvYCRT7E5qvj70f3fZE5z5JfIGUsiKWnRuG0DNTSWC0J3
         rW1P9eg1SIFFMWyEtP74GV/j4A2IEuZ53tnEXWbJj36Xtngesc5d+9FJyKwWYrL+tHK6
         4mnNljzrBWX1ed+aEKdyxVMKsY5LYz7GV9HmXxBWXqKove/mkSZRfvRlQ0jAEWMLy/iB
         aqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749134012; x=1749738812;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l9avWjVFt6aWkiQYT2o6nDnnWjkbc+AGyVyiibpfVvU=;
        b=lZWk13Ab4iY2tGsAv/joZxaq+1L6o/BKdhCrBrfXU6fCkpB0KsJyg4yMB2kKfUv8J4
         Wd7r3VF9QBWkEdJU1CIDyRAm22SyyBS8df7FPOH9MMTKUsrVXa0LcNi3SIgDv6CQt3io
         3alXS2DloAbuIVZWcfAX32rPqDowXz/EJUhNbummzQxU3A+LGmv+D2juNMxRcHj9DhXl
         jlk9ujilYT1MkPg5EBu8tDrVSnE7kxHtw4D23X6QA1N49ppTxqDJK8VI2L8Mf5ba+s1b
         UZJ29O/gTuM7HKRucMykfwlIXSCOctonP7HJBzIR1uvYMPZaorVHEqZMYL1/LW2LEvln
         IhNg==
X-Forwarded-Encrypted: i=1; AJvYcCV6CPqf5uO3cl1XtWNCyVpgHykMCHi8FnmcsAhYXW5o8xogm5cf9bBdzw6XduOKrT6TTov7xBC0@vger.kernel.org, AJvYcCVBCYKsMMlJUTwrKQ4W75r+g6NJ4nNB9cE/qLFBKZUqr/CqQdXoDXMBnAbBfeTqj7NBxwctqQT2@vger.kernel.org, AJvYcCXT+Blp8V8pm/UeXbyRbgwSmjFtXdRC/Lwv5LT7Ge2oybj3R/49PVSEDBaV+JiyCXx74aE=@vger.kernel.org, AJvYcCXg2lG6cHAMSIEFXMOuJkX/Z23CbwGz8gq8AfTtRCdTbHmWCahlwYaTRN1bJxc75yZtMvBNPijtdMyNjiGB@vger.kernel.org
X-Gm-Message-State: AOJu0YzXVNdzFm69CgZd/5rnOWBR1sEFfSWI4LWR3nZIpPsa9vMYpHUV
	r8Aw0jjXK+2BOjFvZASKOAaJ6UWTF85WkUPZDU2tGbKhppmf2WTmyGXD5gXCGw==
X-Gm-Gg: ASbGncsfsBBXxA+K2Qt49viKfnlv77wZmNRMKAV9NINlDeLUDo6reE8jxKf9mnhF9HN
	vMq6ZrtV3DXnrq75VeUog7X/ooq8FITWcOwQsF2MDE/3lAXiqZAQ2axdej43DHORhhAvy5fCeUI
	TQdWK/dH3+rxxhnWhh16mLPE4E8h4Ip9kf5ExqaJw1JJ3iFIqAx/vb4CyrAhbkHTZ8hOFVu3MXt
	yvDa/Q3bzIFsXPPFq0JGvEtYsNGBIvA+0lwXPofKFgScs4H+R1sZRjWXzY+jjNzW1Tkqsoy0dIB
	gVa+cOgOWXRucw3+qfqv1Gv7ZqTlTkHmrkNqQyWEVAlX9Q9Gk9X+nnWtfGAlHYMthtza7L2R6Ph
	5wGbA5on99Uq5eBW7OfbVG5g3Vck=
X-Google-Smtp-Source: AGHT+IHoYsehzq4W4hQnnnjTlH/Y7tcjh0kuCIpQiDNFzibOyjGm7QM3TfN7RjAAdMWkvPfyNTl5uw==
X-Received: by 2002:a17:902:d550:b0:224:1af1:87f4 with SMTP id d9443c01a7336-235e14bc5d2mr113225345ad.22.1749134012316;
        Thu, 05 Jun 2025 07:33:32 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:fe1:cf75:ee2d:d934? ([2001:ee0:4f0e:fb30:fe1:cf75:ee2d:d934])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cd8cf0sm120472525ad.155.2025.06.05.07.33.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 07:33:31 -0700 (PDT)
Message-ID: <f6d7610b-abfe-415d-adf8-08ce791e4e72@gmail.com>
Date: Thu, 5 Jun 2025 21:33:26 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] virtio-net: drop the multi-buffer XDP packet in
 zerocopy
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
References: <20250603150613.83802-1-minhquangbui99@gmail.com>
 <dd087fdf-5d6c-4015-bed3-29760002f859@redhat.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <dd087fdf-5d6c-4015-bed3-29760002f859@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/5/25 18:03, Paolo Abeni wrote:
> On 6/3/25 5:06 PM, Bui Quang Minh wrote:
>> In virtio-net, we have not yet supported multi-buffer XDP packet in
>> zerocopy mode when there is a binding XDP program. However, in that
>> case, when receiving multi-buffer XDP packet, we skip the XDP program
>> and return XDP_PASS. As a result, the packet is passed to normal network
>> stack which is an incorrect behavior.
> Why? AFAICS the multi-buffer mode depends on features negotiation, which
> is not controlled by the VM user.
>
> Let's suppose the user wants to attach an XDP program to do some per
> packet stats accounting. That suddenly would cause drop packets
> depending on conditions not controlled by the (guest) user. It looks
> wrong to me.

But currently, if a multi-buffer packet arrives, it will not go through 
XDP program so it doesn't increase the stats but still goes to network 
stack. So I think it's not a correct behavior.

>
> XDP_ABORTED looks like a better choice.
>
> /P
>

Thanks,
Quang Minh.

