Return-Path: <bpf+bounces-50486-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0596A2827B
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 04:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BDAA161B80
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 03:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FF4213246;
	Wed,  5 Feb 2025 03:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJjfKl8q"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FE620C028;
	Wed,  5 Feb 2025 03:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738725275; cv=none; b=I7xiSGavVDdnW/FBxr3PxGL4s3BlxkYTN2RIo2z2hjH5N7aelCyEtt9LKL13qmj8GHYf+ZKWTJG5Q86JkDGmRWanmE3sVDO/0TUEx7dnBNn6P472RZIq7Te+LsRUNN5efBtZGPm+PGwb39/p8ecBc7SY4qDz+45bZEvshfd27Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738725275; c=relaxed/simple;
	bh=IFu/NvdoTuUeKbEz/IgQfYMFmAnUREC7EusYfwrBa3o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IF3tCh8dkz5FYG1iYlDNJ7gVv899q4r30p8hjx5JNH+IB+bFh8ajnG42F3x/GKsfVsOfqw5ZvzyZUWADTlPolFz4Suojk+vBVgA15xUP6C00Q5+epnwystARMsvj/rz5lSKfd9C4c9YkKri2JhlwDV3yGunilLx7v1udGaqfDFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJjfKl8q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC9EC4CEDF;
	Wed,  5 Feb 2025 03:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738725275;
	bh=IFu/NvdoTuUeKbEz/IgQfYMFmAnUREC7EusYfwrBa3o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PJjfKl8qaFD2u3eMQapgpW4oid2OEiXML8jyFb/q64WKsQuPDphmW7H8OfU3IMMTO
	 y0sBykutoFzm6xJ/qrEwSRsWLPK7pvrLLyLdN7/vFb6wE81cNO/RKpgEW/MAb8F85M
	 8vAAP8ORTmphAPnRz3RUXrTmMyzopp+WXZ8ewPBokB66Ib/nubiiw0cKHjr/nx0jZU
	 BgBkK6p3MupSIPkmJELER/jZSROsAMyBjZ242+AUjQ159W1mkMgfobg8HT+XIv45eU
	 2JpUVkz/jG6jmtjgcmsF8IeSUX/IhIxGRcNRJ7iYxftaWieM6spYKkh/PlXRdvUMCA
	 TJ+1XX+yLd87A==
Date: Tue, 4 Feb 2025 19:14:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 dsahern@kernel.org, willemdebruijn.kernel@gmail.com, willemb@google.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, horms@kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next v8 05/12] net-timestamp: prepare for isolating
 two modes of SO_TIMESTAMPING
Message-ID: <20250204191433.4cfa990a@kernel.org>
In-Reply-To: <CAL+tcoDcJd9zNNnsxaCocA1W-eTj+=Ca=B-DoL5Qm6ENfSZ_Fw@mail.gmail.com>
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
	<20250204183024.87508-6-kerneljasonxing@gmail.com>
	<20250204174750.677e3520@kernel.org>
	<CAL+tcoDcJd9zNNnsxaCocA1W-eTj+=Ca=B-DoL5Qm6ENfSZ_Fw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Feb 2025 10:40:42 +0800 Jason Xing wrote:
> I wonder if we need a separate cleanup after this series about moving
> this kind of functions into net/core/timestamping.c, say,
> __skb_tstamp_tx()?

IMHO no need to go too far, just move the one function as part of this
series. The only motivation is to avoid adding includes to
linux/skbuff.h since skbuff.h is included in something like 8k objects.

