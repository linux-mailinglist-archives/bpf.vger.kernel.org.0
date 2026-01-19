Return-Path: <bpf+bounces-79387-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DEBD39C06
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 02:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C73DD3009A8F
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 01:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10111205E26;
	Mon, 19 Jan 2026 01:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRDBGIjg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2531DF736
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 01:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768787056; cv=none; b=aELzBWdbkcWS+foJ6bnhzY/Ff2uG7UA5m8xyPMBJuG+y2+mIX3AYiUJDP+YBXZuSjIBgBQSG5MlXabyRFsS3dbiJq4znpBto3/JLdLTUfkIOnqEdzIfldgAqS3eK0kRhhJuaRdBtd7WVgMRlidyU3vrbH4WU8oOPOgjai6mqxQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768787056; c=relaxed/simple;
	bh=7q+R2/RHzVQW5cjTjhhJh8W9Bo5v5oSb7JGW/NI6s5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eyBaYv26c7kD6rSGWNewd+37edHDfuc75OHncOuwBFrddSr3KgDrwOt5uUExAyIX1xXBF3LIpfvVqGPdHfd+KSrxiRqBHENJWgQEvsYXEjs2BRhfU4AH/i4YTH3Xb1LIP2ZctXFNHHP9XPowtygH0HBZkL5/g/pBBUXCXlQ2h80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRDBGIjg; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1233bc1117fso2408931c88.0
        for <bpf@vger.kernel.org>; Sun, 18 Jan 2026 17:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768787054; x=1769391854; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xNXKzv0XBaJNo8dt2IzChTr0sf06VY1ICo1CXdPMe5M=;
        b=nRDBGIjghN28alxm0XHzyA758qyhFhrd/ByzhPn7e7/EPuhNCi5UopjWOsZI8WtqtU
         23dmXIAMJSlZ6q97JLkvY04sc9jVNQoNq8ytJ66L4fAJDBEoFPWdF2KAvXqbDR1CyEfi
         mmINX7UjGW97BHHSaG1k9NaCdPnpFWu9VCKNTC8ObOlcxVBqiYIJGyWOhGv1HY4XH0LV
         EP+bhCMKznL8oRWMYa4BAdbAXyYqowWDk8RYBOrsVT1tNs94b2cTTTr3aI18Nq/WeLWc
         9u1sSZ99IHEravffjWcn6+cd5IOR/Doww4LL5NbnqUZajNijawtfJXtN6EmJvq2S0O4e
         F0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768787054; x=1769391854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xNXKzv0XBaJNo8dt2IzChTr0sf06VY1ICo1CXdPMe5M=;
        b=Kt4JyHw8Lk1W1z1CUA//FzEaRsoKb+jNzlqLB+5OEsPodl3cTlGvUM/WZTCQM3fBSQ
         8x4m6HdACEc3BVeGvbedG6994WdMsfhj9nlACnuKIN4FHHa8kb7Wyhm6UeG5RnicZVee
         E7J318GEu5hC4xXhqgTIqhjmOtyHL/UBk3DvL2Kpss9+vk55dCA2/u2AtqsZ+BtcscyM
         BzZiQ0ONTcj4hDtvBMI3NnpkKzIWgxxHVPjWZ3lG2DGbZvC0EcMVEkkNLSANOQR2rdnl
         dmkKOMwexC5PXYnRoSXGSurz5ReaxhpCc/eD468NVRwouyMpjX1x03mqTCPNu+NG+zsE
         26dw==
X-Forwarded-Encrypted: i=1; AJvYcCXc5JoFWaiHKoMNqdM0ddLGdtdYmFWflE9Nfx00muvCKVkFxUHnq5LlrKBkge2JIqet/zU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOprNIbG/bmq7RMRDlTQn9/JZa1i7FzjKZVM4pf62gEjsShNuy
	kN6KJxh8vnYa4UcyY5u0a0LN3vKoDXnIfZmGhsfCMhLJ6NM/Ge8vmFQ=
X-Gm-Gg: AY/fxX5p8qKQ1/ETB4xSuV/FGT3RPkmS9wucd0uLynVypTSGt8QFk6ncu/XmKr5rL1c
	JhHMASvLsK25yolcUtKY4+D5A+Q3XG44WRbsonKJCKqHKs6z9tM2T7b66MeWl0/7wL0B/GiYzfo
	1IPkuht9LhUFxF2ZpIhZNMqJ1QxfzcYVcVyik+NxUDpGHXyF9YqmrWWlqT2c4DIHTqvqM1MDymA
	ueQPeVvaMDIBLHyYIY9NVL9jwuuQ729aBcAR/L8W9/mg4cRr4deFRAsgu2EyD/mYsMKdEZcAxV5
	bYXtv1PV6TVcuPigBnqdcT1+lkOh0+wK+fh4Vp7vwoSj8T4FbMOyp7+qctuiiTCgIyG+Onqh3dj
	/4n7xZqhgzMiYy/Q+2TDrgfE2tPMPNQnNRI29fpQIf24ESZ0BL2qQW7vAc7R3S9S7ZEM3XgdWvT
	5A5eTXLxXJXM3CV8uJf5ieaF5oCdT1ZTi+5mpbJDvveK7aOqr1RMSY+SM0XGFt5JhHGN7DV1A2+
	cAP8A==
X-Received: by 2002:a05:7022:3b89:b0:11b:9b9f:427c with SMTP id a92af1059eb24-1233d0add9fmr10454242c88.13.1768787054432;
        Sun, 18 Jan 2026 17:44:14 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244ac585a9sm12174458c88.2.2026.01.18.17.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 17:44:14 -0800 (PST)
Date: Sun, 18 Jan 2026 17:44:13 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
	willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
	martin.lau@kernel.org, jordan@jrife.io,
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
	dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v7 02/16] net: Implement
 netdev_nl_queue_create_doit
Message-ID: <aW2MbURmxRBKVvEC@mini-arch>
References: <20260115082603.219152-1-daniel@iogearbox.net>
 <20260115082603.219152-3-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260115082603.219152-3-daniel@iogearbox.net>

On 01/15, Daniel Borkmann wrote:
> Implement netdev_nl_queue_create_doit which creates a new rx queue in a
> virtual netdev and then leases it to a rx queue in a physical netdev.
> 
> Example with ynl client:
> 
>   # ./pyynl/cli.py \
>       --spec ~/netlink/specs/netdev.yaml \
>       --do queue-create \
>       --json '{"ifindex": 8, "type": "rx", "lease": {"ifindex": 4, "queue": {"type": "rx", "id": 15}}}'
>   {'id': 1}
> 
> Note that the netdevice locking order is always from the virtual to
> the physical device.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Co-developed-by: David Wei <dw@davidwei.uk>
> Signed-off-by: David Wei <dw@davidwei.uk>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

