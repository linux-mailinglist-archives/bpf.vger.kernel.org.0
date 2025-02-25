Return-Path: <bpf+bounces-52489-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F85BA4354C
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 07:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B87151899B9B
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 06:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB71025E47E;
	Tue, 25 Feb 2025 06:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ATVTdfAo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFDD25D549
	for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 06:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740465008; cv=none; b=Ir/glbnaFRVNN4gUuuWRjTPM4akWR7Z+I+HN242cSVXneXymh7M6PBf1a9gUKvU4HVrER04MsoE8oB0BDwkdjlBXh7f05zwvkAJbjrm5sg1r3TVQZYTB0bcHjM1wOr73fHM3xaLF6a+3+5mjhDwRFCjGXVGRy8YBC7YEOZ4Rh/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740465008; c=relaxed/simple;
	bh=RYfyD32sRASx29xi497H3XJdDF3XXVn40eOIf2rnFm0=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=rVFE2qHqmclQge3wwHJKzD/D7eVylWoLs4Fy9atlNnhpbUKQKVgoHC2SFFCWIcsWJUzBMMFJVmuMQndWE8W+0u+2T6qoDDCJkAeJBTdFEXLi8JaQOcuNLqznTHFpMbCdZ4dYvMs5MX+9Q9T0mRzz9uSEvvwyFTi74VcQBeNm69g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ATVTdfAo; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3f417de5e25so2366361b6e.3
        for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 22:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1740465004; x=1741069804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4+mBAQq6Mkez/2/DMWHStf85qnBYyGFLVJqfvqnbkxk=;
        b=ATVTdfAoZ8/xxq1ZmnjF7OLKA0Xgvb7CoBQQ87W4nCqYvgoKGF1WfWw7itwOEF/kQ2
         qSEC712GTgta39biH0N9ptdUCZON99uEGDNtQAHraF5yqKkiQif0P3PLLx4dOpd02hU3
         w51m7o1mLP/kdvlplhEAUBZB0iorvyx/M6eRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740465004; x=1741069804;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4+mBAQq6Mkez/2/DMWHStf85qnBYyGFLVJqfvqnbkxk=;
        b=CoKWb9+HUeFnKbEGwR2RnMwfynwjSJyxnEJ5TVRHxLLr4MGajj5YKip6M72KhQpbTk
         DIsmvOgW1vk+DzCVV7kP0unoq9P+uOW+Nw5rVG14jckQ9opPL+GI/ynJBmxe5ef9NZcT
         G4UEHY1ubvsx7IeSrYTQ+sRFUN5JN8I7JxifqzOz37Ugf8/lTCfpeeAD3ONzCFc+a3rZ
         LMyCm5xWwmm8QpPLKaRp/nKBv5U8rlJuBTCezaToPxO8JHrp1l6k+TzIN/fX3QaquVuz
         hSFVctO+9W0uc0o1e42ThH4WTNKkJ8fiuKn3dJ3eNfBZiwB0C/i2EVccq50w3KntxCuD
         AK9w==
X-Forwarded-Encrypted: i=1; AJvYcCX1MuzKqUSlDH5PV3kA58zLoMfbM2nVhJqagQJrm4Adqt/wVZYcRUFHYNcmRaCjkOcDIBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkOK+kedq6dkQhUhMbUbHpX0iaqOZ/NMGCnKVjt/xRtg0U+CVb
	ZjW2BPT7rUXIyB9CRNazv6GbppnFDoOASVw4DJKyyVEE+kXU795dWcxGOh2lSQ==
X-Gm-Gg: ASbGncuslIq1do1+MFVnt71R31XtFKKdf1NEJ+M9IhfbaCC8irulBTRgASdQcBS3+I1
	KTuRttzdlCrgD8LKYKLEtUTeQ7QABB1LIb8AbMChrITFOr0oWefhRmIF3ICff3m2YwsZ8KsgTLX
	pfIhKRrT4Cgbs5ieMFa79cLNfkpzQpc2LeuEdYBiqRry5WMyRsJAI0xG53agzg5rjWDT951yejJ
	6u2kAcg/z8KgsCG7cfMy9i5p/Kmw3evX20hd7fFU0emOk0RflXwQb9HNIzmkpp5pht7fwLtCDSu
	mzWfLSTFjr2LJPsLFxPcRUIdt4UP5hc/mSSv0Hx5unhskI7wLyn5AHNCZEuSQMxK
X-Google-Smtp-Source: AGHT+IFdXMbhGx7fP9GFKGlpguOITWaZZGOBzMRAt9OnDAJpr0Tf6LoZNYE9WcUj4WMJOinaxdWK7Q==
X-Received: by 2002:a05:6808:3c8f:b0:3f3:e8e7:2001 with SMTP id 5614622812f47-3f424777eb0mr12305946b6e.26.1740465004283;
        Mon, 24 Feb 2025 22:30:04 -0800 (PST)
Received: from [192.168.178.74] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f541bd992bsm190300b6e.16.2025.02.24.22.29.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 22:30:03 -0800 (PST)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: "Kuan-Wei Chiu" <visitorckw@gmail.com>, <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>, <x86@kernel.org>, <jk@ozlabs.org>, <joel@jms.id.au>, <eajames@linux.ibm.com>, <andrzej.hajda@intel.com>, <neil.armstrong@linaro.org>, <rfoss@kernel.org>, <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>, <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>, <dmitry.torokhov@gmail.com>, <mchehab@kernel.org>, <awalls@md.metrocast.net>, <hverkuil@xs4all.nl>, <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>, <louis.peens@corigine.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>, <parthiban.veerasooran@microchip.com>, <johannes@sipsolutions.net>, <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>, <yury.norov@gmail.com>, <akpm@linux-foundation.org>
CC: <hpa@zytor.com>, <alistair@popple.id.au>, <linux@rasmusvillemoes.dk>, <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>, <jernej.skrabec@gmail.com>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>, <linux-fsi@lists.ozlabs.org>, <dri-devel@lists.freedesktop.org>, <linux-input@vger.kernel.org>, <linux-media@vger.kernel.org>, <linux-mtd@lists.infradead.org>, <oss-drivers@corigine.com>, <netdev@vger.kernel.org>, <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <linux-serial@vger.kernel.org>, <bpf@vger.kernel.org>, <jserv@ccns.ncku.edu.tw>, "Yu-Chun Lin" <eleanor15x@gmail.com>
Date: Tue, 25 Feb 2025 07:29:46 +0100
Message-ID: <1953bcc1790.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20250223164217.2139331-12-visitorckw@gmail.com>
References: <20250223164217.2139331-1-visitorckw@gmail.com>
 <20250223164217.2139331-12-visitorckw@gmail.com>
User-Agent: AquaMail/1.54.1 (build: 105401536)
Subject: Re: [PATCH 11/17] wifi: brcm80211: Replace open-coded parity calculation with parity32()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On February 23, 2025 5:44:54 PM Kuan-Wei Chiu <visitorckw@gmail.com> wrote:

> Refactor parity calculations to use the standard parity32() helper.
> This change eliminates redundant implementations and improves code
> efficiency.

While the dust settles on the exact implementation from driver perspective 
looks fine to me so...

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>
> Co-developed-by: Yu-Chun Lin <eleanor15x@gmail.com>
> Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
> .../wireless/broadcom/brcm80211/brcmsmac/dma.c   | 16 +---------------
> 1 file changed, 1 insertion(+), 15 deletions(-)




