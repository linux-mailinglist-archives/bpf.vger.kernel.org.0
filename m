Return-Path: <bpf+bounces-66016-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C2FB2C726
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 16:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE37D5E1FA0
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 14:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CD42765C8;
	Tue, 19 Aug 2025 14:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TaO+KUqT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0271F9F70;
	Tue, 19 Aug 2025 14:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755614161; cv=none; b=YkJSCZd1T091M0uxsnI2IQtEwoptPly/6DLHBmjpS67Uje8oO2sTawN7TDOLt2cKfwcQQ5/xzIiE+v8/ZQDXqssQEfWkZa8qRrX3F1uzPfyt/Amau5hqsgNJ+eVEsE9RHFrmcuun7o5Ly6k0g7Y60ImUb0Fgn4zfz0m49OJnC3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755614161; c=relaxed/simple;
	bh=BiHe/FguZmNKLQFvQErwkmhZShCmEsuov9mR9CCAK10=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l16Q36AN1KQQrT47OoydlgncS0V1QhWuia+ki0jCPs11YpO2wq88qnLJJO1jh3m/VIGpb2R/XtI63hV1XV2lDDeI5qtfxXwjFJ308LzVZo8Um7loTsxD2wk0MKo2PWo9lMaP2gr3Af1QDckEqoaEyQHGJfDhDQjgzTYc2ZQxETY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TaO+KUqT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBAAFC4CEF1;
	Tue, 19 Aug 2025 14:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755614161;
	bh=BiHe/FguZmNKLQFvQErwkmhZShCmEsuov9mR9CCAK10=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TaO+KUqTMSIodh39ZJ/nPQgGEHgwsyFzbEZITzVRRHFdJkJK4wIirxXwoU5f/8FQv
	 d8Y3m/ELPmUqtK4bLDl+zd56vViPX8vjh1VTrX5aJz4/G8pIZ3tVEU7eMS1PHiTBJG
	 exWybiL3Eh9a1r3RSw6SLJoOlFWlnT4AwvgYWibYapB0qPiaS3L1kJQb6/6NHjT2e0
	 nz5kWH0P8sLmQrwe8zFJASoFkeNpVKcr9BduukCOTNWYgKL49J1xuwIKHSd/OiNVGe
	 ntHEdK6OnQ4AvIbZF8fGt6SWosAGX4WIkxpQ64bc+7gRCD7ZplQ82Nd85ofT02gzPP
	 dRF1C0SzgUveA==
Date: Tue, 19 Aug 2025 07:35:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Meghana Malladi <m-malladi@ti.com>
Cc: <namcao@linutronix.de>, <jacob.e.keller@intel.com>,
 <christian.koenig@amd.com>, <sumit.semwal@linaro.org>, <sdf@fomichev.me>,
 <john.fastabend@gmail.com>, <hawk@kernel.org>, <daniel@iogearbox.net>,
 <ast@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
 <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
 <linaro-mm-sig@lists.linaro.org>, <dri-devel@lists.freedesktop.org>,
 <linux-media@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: Re: [PATCH net-next 5/6] net: ti: icssg-prueth: Add AF_XDP zero
 copy for RX
Message-ID: <20250819073558.2c996b6d@kernel.org>
In-Reply-To: <20250818112424.3068643-6-m-malladi@ti.com>
References: <20250818112424.3068643-1-m-malladi@ti.com>
	<20250818112424.3068643-6-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Aug 2025 16:54:23 +0530 Meghana Malladi wrote:
> @@ -1332,6 +1350,13 @@ static int prueth_xsk_wakeup(struct net_device *ndev, u32 qid, u32 flags)
>  		}
>  	}
>  
> +	if (flags & XDP_WAKEUP_RX) {
> +		if (!napi_if_scheduled_mark_missed(&emac->napi_rx)) {
> +			if (likely(napi_schedule_prep(&emac->napi_rx)))
> +				__napi_schedule(&emac->napi_rx);
> +		}
> +	}
> +
>  	return 0;

I suspect this series is generated against old source or there's
another conflicting series in flight, because git ends up applying
this chunk to prueth_xsk_pool_disable() :S

Before you proceed with AF_XDP could you make this driver build under
COMPILE_TEST on x86? This is very easy to miss, luckily we got an off
list report but its pure luck. And obviously much more effort for the
maintainers to investigate than if it was caught by the CI.
-- 
pw-bot: cr

