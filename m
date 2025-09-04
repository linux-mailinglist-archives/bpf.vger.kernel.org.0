Return-Path: <bpf+bounces-67392-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64234B43275
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 08:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA7EA7A9812
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 06:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2281E276051;
	Thu,  4 Sep 2025 06:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="ekejYrX4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B2F2750FA
	for <bpf@vger.kernel.org>; Thu,  4 Sep 2025 06:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756967702; cv=none; b=ddRvisBByutyMLvCJlqNlRj/YW78yPL/RsGA3K4JIL3xFQaMpW1EZ+RZ9oTqjOYNcH9B6s8ZEwTr/jSdWQCLHxlZ6Xvfsb0GUYIm02yrwM6clA/zQ+d/WJwXq0WgLOiTmEINLzr08XmXeLBZ4m4aDC0omMd8zCsFQYs2YnCpOC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756967702; c=relaxed/simple;
	bh=EF1d9d6TM/5WixDRVpoLI/2mZi8oaT+MyfzNnMPvcno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZkMC/FFlI2BkUyq3soCTWDMzYo8q3dxqagSPDxsxjefMyG9M79ZXy0pZ/MNQAwYIWoFv4TZR7didWic2BbXS2vOjouVHToyCyNuKUYeT+3uln9wqIZZWW8xLhHW03dmr7soO4TYY+m5C+W0t3pqfz1VgVilnsGaVJ+ItIHIG5dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=ekejYrX4; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45b7da4101fso1909905e9.3
        for <bpf@vger.kernel.org>; Wed, 03 Sep 2025 23:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1756967698; x=1757572498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AQ3Gc/O+sD8twCNzZA1nv6UYXB4RvutwP3PJpU6jpms=;
        b=ekejYrX4pecdMrGRxwxkSMrAgrFko81B47NfH763XKEyUxgNCyaKiKSbTRnUgh1nLM
         UWYcJpZ2dUtpCHjCpTcLymFktsueQ+neHGPSWjw6NXvFYnhIXAvqF56mf9dMk/pl41Dx
         XVu1PqOOj5AWC8OLf0Inf/dtWHfazPdXgHyo79rMsCPLcj7NLHwSnPvbAlto8aVRFIiJ
         /wlfHiOfKhAEQCwRfz6We92lloPUa7Sm0D8KB+WTu9PEAoBe7wkAargQI1SfKPjz+TsC
         1xWO4ni1cNagtEeuOzP2Lezs39RDhH98TOGO1ZORoHME5jEeHdXSL6seyduYgWqyuKxd
         QScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756967698; x=1757572498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQ3Gc/O+sD8twCNzZA1nv6UYXB4RvutwP3PJpU6jpms=;
        b=OqCEQnNjaDrlksQVsDXUXCqQgPrl7vqS/nz7iJBwZn/dKecQx7/YaGSZyzypl2BUBN
         rXEwrZBZLWVDXwMAifhJ9MOrDAbDwmGtrrGBDBJYpFFkIRy2VHkygkc3S2RAQwi8F7MS
         OvtOvrNec/McP758TEjPZYhsVg6Zsc0e/0DTG3pwbLC7nr/pRQAJAdRMUzzTbybpQgOQ
         yADAI7u7EyfwGcgxU4klZIxFHDd41Rv6HWSw+dnzP4KPYlX8wYDNFYgMgy2EYm33Epm+
         zRpdrx86vNBt4dQIlcSc90APBwrTezw6+kbkZizNh/SUpxu/GHWC8s6LZ6Fh5N2GLjuR
         7wig==
X-Forwarded-Encrypted: i=1; AJvYcCUmNZoRs6ZV0d4OEDLIpgUlKAm84lwxpc6ngs6mIEkCI0/uH/uQ7CLTUaUdDsUM7G8vRks=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ8d4IvmRHSUpBELeEi8UDC2tMS0sVSoEO3hVx8uuOlQ0actXI
	DGGFB88fRDXhpnwSxGyK6fYKatCQOc8AfBroH0ZvCyeZBqrN/3hgeGWVIrCkNUmPv58=
X-Gm-Gg: ASbGncvT8MGmNTOMTeXZ6DsZyIsMjLcvEc2zhYSs355i7Qj/vtT9rUNMuI9VAmmeoVD
	pFg/ERW3jTYFNOi6/SXDpIalTiXX98fSE9CvdfWFb5peb3pBijyW0eIAuQ7RInolLQvNWfpewhq
	IT6muDsMQtIhoZSy1tP/ni+E6hmwbQY5hkormvSrCXIlHJzm12cFsegfdU+KW3Db8iCAQfGRWVk
	iMMblGQg4fR8P9bIcM6oVtdzAXpU0KdUFAC+CDei/B6fydKfb3QmpUdf/Tz0Ddnx2/N9O4Rwqyf
	jhnUpHlkB09AFucq6uLTfMCE61RjIeb6kYaA/3UIffLjsoG79Zw/LBEn3/7eaZWBLY/ghH3Fhzc
	vXnMfIqVHdiucss1+Jz2FopT6JxWfdoGUtiFdcrnYc1j9dRp5Srb55g==
X-Google-Smtp-Source: AGHT+IHrCWv5mgqi9YiX+c+MNqNC7162B9DkMT4OdgROL1wmk5ec8Z4tHuuSyn2qqCkckUPvPlsj4Q==
X-Received: by 2002:a05:600c:4452:b0:455:f187:6203 with SMTP id 5b1f17b1804b1-45b855983cfmr129194505e9.27.1756967698452;
        Wed, 03 Sep 2025 23:34:58 -0700 (PDT)
Received: from localhost (93-46-179-206.ip108.fastwebnet.it. [93.46.179.206])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45dcfa3ec60sm23305275e9.15.2025.09.03.23.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 23:34:57 -0700 (PDT)
Date: Thu, 4 Sep 2025 07:34:56 +0100
From: Johannes Weiner <hannes@cmpxchg.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Neal Cardwell <ncardwell@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Mina Almasry <almasrymina@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v5 bpf-next/net 4/5] net-memcg: Allow decoupling memcg
 from global protocol memory accounting.
Message-ID: <20250904063456.GB2144@cmpxchg.org>
References: <20250903190238.2511885-1-kuniyu@google.com>
 <20250903190238.2511885-5-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903190238.2511885-5-kuniyu@google.com>

On Wed, Sep 03, 2025 at 07:02:03PM +0000, Kuniyuki Iwashima wrote:
> If all workloads were guaranteed to be controlled under memcg, the issue
> could be worked around by setting tcp_mem[0~2] to UINT_MAX.
> 
> In reality, this assumption does not always hold, and processes not
> controlled by memcg lose the seatbelt and can consume memory up to
> the global limit, becoming noisy neighbour.

It's been repeatedly pointed out to you that this container
configuration is not, and cannot be, supported. Processes not
controlled by memcg have many avenues to become noisy neighbors in a
multi-tenant system.

So my NAK still applies. Please carry this forward in all future patch
submissions even if your implementation changes.

