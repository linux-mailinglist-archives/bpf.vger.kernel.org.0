Return-Path: <bpf+bounces-78911-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A1BD1F366
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 14:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1293930F9554
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 13:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CAA2BDC0F;
	Wed, 14 Jan 2026 13:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCtYn47l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4882BE056
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 13:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768398439; cv=none; b=jvHxQpb1DpXPAQx92S1guAT/6uoNEZQhaeo+giet66It5Pscc9dGC4jAdRemoH0pAuBicmjm9xBh4cUsE2gvlYmY4hy7vX2OlvdzQHiZrBBKrsJCucusNqtumiVZCusIXa7CP1izNwrNTdSB9JsUKeTQf2ZALyBmeFkuNUCIhag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768398439; c=relaxed/simple;
	bh=L3dR8NudphjzOLY06rRJEZjL9fEEuauxwFNrQodgmbk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j2A6RvjUM50IXVvLR5lNv9Eqx6ChWkUui5v79fdlqSzqpDxAHKGrt2d6PzeWfymAQxKo/KYq+B20e4bqaq0qVfYFBIJ6H2MqqLL1+zqm3Lp9fYiCDYsGtVw5fgdTyvqx32PUHP/8dmJf71Ywz9rXJTlmo/P7DP1RjcpMncW42u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCtYn47l; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47ed9b04365so13051005e9.0
        for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 05:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768398436; x=1769003236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9jT5+6PNxAsiSLc4phs+HsvpCwG6ks9aQbUheKgFsmM=;
        b=RCtYn47luvoQ8q4+NaUZlfWWBG/l/k5+End8lqN0K9CXWV+mUFe0dIM/4PZ+VqxFHL
         Yn3pQGr6wWd4aISC/GalrilNj5bjK8CVpn0SRul/jW5bECMWBcUq4ZzT8PJwzN2WpoQ2
         lMheyYHC7o8lKLhvrMO08ebk4F8xR19U1VBGoK2QI7yH8BPIkRc+sIiPLbdQhrU92NeG
         fZs+IdcEKjMy1lUAmeGQDU5S/0qZMCJSOvsgDNXKkS49C/WOXPQg+kRZLODNGXLlO3uV
         tNIUfhMGz5BEf2P99bFttYU0pDxCqUw0HoAra7Ey+saD2eFw9p7IGzjAY+xIk0Ibgo0i
         Im9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768398436; x=1769003236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9jT5+6PNxAsiSLc4phs+HsvpCwG6ks9aQbUheKgFsmM=;
        b=Xal6i6gFiTwokow1mrRL7tu/TF/82L1gpBbxD1pYqQRYCZWpbPcYwCj7BO5r2AIO6S
         ImtSsBUcpqkEcCmAxzR8MeNrW3WTzN9Xz6Dge3OALa9xT78rEN/tlfiObppI5nKcmUvP
         qeIdJ32ma7TD7tXzfum2RP4rSQIO12BL6UHrJvXNjOVPx0mTksV/s0ylPBiB6PtnjsyN
         DVXGFvAVP4YEseh0p1xjbiz0urMkBigyGV8ZH0COc4I0g4oQrXYA8Lir9DgSK7Q95Vtc
         3upw2A/qBIf7lhtzm2H6pDHfVK5L8/FwY43mEQRlou0BWFXKmP6yBEEQVJDPEuk/TBgy
         FXhw==
X-Forwarded-Encrypted: i=1; AJvYcCWytuTpUVKy7455eBy7gVq0sXJNnGtOMDCRxJjpKSd20yL2R0YVGFn4yUSNORMa7o2npyc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz13o4wjadEDQBKyPPQnvz2/Pd+vSXbmpow+A0fDzY6IdQC3QvO
	C8rselep7fod+7LsUlk28D/XmjVtBGrnTGHsIH2ZipjqMV+Ic32WbCBF
X-Gm-Gg: AY/fxX6MCIw5STXYCZ2ia2sKMJwNNMmVeOncv9l+3i7msL4L+ue1bFEWFeQkT03RlEM
	xVQbtklF1IQfd5gdaNdn73ZRNLf2F/JKXcZDOqadhIQCReCDfIk3OVVAtv8MTJPe5K4L/WSTcq9
	JWfFmgU53wStJjL95cdkTWO04K7xYFnLG49+1bcsivscMSMqcRKQJMGbEE3hGstgBOPl1KDUDej
	3UewsYZDnMCL8kI5oKQ2NutozY4+OYy9lHyheVjEGhFTZFrTbW1brexxoVqepewg6JKhHTFGX0d
	FIyyHg44CzPbNFuVbE0SzYdspUzNNR1WHvjGZQN+jRyvsLO63MmkgMMVpslGRQHpdAiM2JzsV7K
	0cRQ7eKt04WRrxNazKS6/YhJLsaoy9KsV2M2XjuMSeMfmyIF0yzWcFkkYASLng/HsSS8SlRGTFp
	9CIHfHMtOcVfDl455Pd8hK/1r6ir9lIYy5Exo5Y4tumTj1AplpyEGS
X-Received: by 2002:a05:600c:83c3:b0:477:8a2a:1244 with SMTP id 5b1f17b1804b1-47ee32fcf0amr27966825e9.11.1768398435487;
        Wed, 14 Jan 2026 05:47:15 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee85e8807sm5184825e9.16.2026.01.14.05.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 05:47:15 -0800 (PST)
Date: Wed, 14 Jan 2026 13:47:13 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: shenwei.wang@nxp.com, xiaoning.wang@nxp.com, frank.li@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 bpf@vger.kernel.org
Subject: Re: [PATCH net-next 07/11] net: fec: use switch statement to check
 the type of tx_buf
Message-ID: <20260114134713.565f2b3c@pumpkin>
In-Reply-To: <20260113032939.3705137-8-wei.fang@nxp.com>
References: <20260113032939.3705137-1-wei.fang@nxp.com>
	<20260113032939.3705137-8-wei.fang@nxp.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Jan 2026 11:29:35 +0800
Wei Fang <wei.fang@nxp.com> wrote:

> The tx_buf has three types: FEC_TXBUF_T_SKB, FEC_TXBUF_T_XDP_NDO and
> FEC_TXBUF_T_XDP_TX. Currently, the driver uses 'if...else...' statements
> to check the type and perform the corresponding processing. This is very
> detrimental to future expansion. For example, if new types are added to
> support XDP zero copy in the future, continuing to use 'if...else...'
> would be a very bad coding style. So the 'if...else...' statements in
> the current driver are replaced with switch statements to support XDP
> zero copy in the future.

The if...else... sequence has the advantage that the common 'cases'
can be put first.
The compiler will use a branch tree for a switch statement (jumps tables
are pretty much not allowed because of speculative execution issues) and
limit the maximum number of branches.
That is likely to be pessimal in many cases - especially if it generates
mispredicted branches for the common cases.

So not clear cut at all.

	David

