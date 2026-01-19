Return-Path: <bpf+bounces-79394-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A9DD39C1C
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 02:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B455C3009569
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 01:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121541DF723;
	Mon, 19 Jan 2026 01:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLCbNQa2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F29288D2
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 01:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768787156; cv=none; b=HR6f9hSx5VQHvSPFnwAOSRIuqfGByr20wXW1NInBJRFATS36i2hyXKeWz9KJM2dmKj1CkEr/MfGurFTCGga/IsVIz/K0EJGrpD+cRgaKYYTaE1rTR1C8v+Jkp/5NMlXQLKY2n4ZcDPWEffDNXHgA5p40KYXcKpKAEEi6BjP7fWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768787156; c=relaxed/simple;
	bh=2CDrjTpiQ/0AdQLT27kfYhsG2ykJSy38qiDj/IiUwVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6PX6Ye3+q5bqx3jcxQTSn6J25hsj7OW9anN1KtEsWKpm6xU2qUAwH6dHJ1LeB0hwqwflFK7gJwsEZsSEpBrxF35peq7vyUzC1MyT07r/3ajZjAk+Oey0lTGxsBvAohMSijNWHRnFeSctz7MgddftYhtUSrDFIFvDGK4msnxu+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLCbNQa2; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1233b953bebso2650422c88.1
        for <bpf@vger.kernel.org>; Sun, 18 Jan 2026 17:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768787154; x=1769391954; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wrj+EAeNVP8pFSjWojFc9is/CH6nYVXk5rMSOFLJMpU=;
        b=WLCbNQa23GcF/v5JX42iieX3OMoTi5q4TS3tuoBia588VCxeCpLYciLkLROQgQE6Ov
         LM+fuEHKqujPHPFPd9O3WrX4YItMi0s+JNGB+eySauBzdSaEjm4toEY5rzQswe2g3haJ
         WbMPYSJp+z/gD9cXXAQ8zHcM1AoyhI5J1DnChjiIGW0LeimNez1JQ1PeDwhvUWJdyW2v
         v4Cycsb639AxtymxBrfCkzJ52Guq/7RqXDrBoHw5nLBj0N7Blj5EOvSZZHZyDZtFJjaX
         Seend0wXX3JHoVe0ZNiFsdqNQUmTch5kRpFYP/U0lQ+E1xjjODMgga+eyOFXqlPuPikG
         WE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768787154; x=1769391954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wrj+EAeNVP8pFSjWojFc9is/CH6nYVXk5rMSOFLJMpU=;
        b=WrHHhj2rJQ4rWtNDJxZoZAvzkgd+wP2/aOHyguhay9PduT/R/wGOLZNMPpRFUvM2zE
         QenVBBx104AIaSfNwJVSAY4/ig1ORkWIizBRPRZpUTnX+V1jCv6KsjI5EOgCRGBgr/M6
         RnfAmhreOKqBKYYQxdFWBnBYP97fSCzh15GJFeLnZ9PcL3OAPBn3nc1aOf+gOw3UP+4f
         TjpuZKZq62q01NFmkVB81+BfX2VDOPYWY1Q2Rttq0stExpExsH//OVeHUtNvJmfsA3X8
         Lp4BChb4ash3gkLOtRt0ZfUSewukPXaGXAfoQopo+dC8AYc55+AZ2ZU98MbO9kC9Xkxr
         d3sQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYcpcCzz1iQQzd3FQMdE0ZoOb5s9Uo8igzdLjVBZir6kSxwnZZX9mSwjonb9kG04Y6kXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqgO3ZQkuxFnoe1iuGGXMvsyKpw6B+7jwsU3KVSc1XLUDEdAOf
	Uh0HM2KUOsRzbCcZ3i6tTimHz8GmLcXow8ENQXAdY7IyPsigo03pVfE=
X-Gm-Gg: AY/fxX5+7lB+ZbJiLzHGKUfFw+tzIy/lC5msPb60vENfF4YaFOpg7ANPsj8cRoasoxq
	v44NeYEWCn+IE1uK4y+1GNIOQ489YJ9u6zI+xUV98EMYDqjFy5SCrRqUiaIC4JjjO2f6kwdeqDw
	4OG1jS6m+O/RXZkH96WA3uKnVEVjo1+Cl95grAIbdoA5phn6Cc+tFFjdosT1yIv4YGOSRNddInr
	HX7keT1ivsze0Z+eYG9hm9BnxyCoFyxQ8otDH7aaIMxcRLB0LpR0hm0UE7+PIVA/8jmc511GlNx
	aCPuHaZTrxtcPOONjYDYnDTiKP1E8Btw+D17igm5aLPJjdnZpBb4arCVqy5e2wSe+oinAEIGP9n
	LsP72gM8qX63YNcCSplSkuBlCBn2cQI7Nkjchy5jUP8g51fBNHd4+xK9QqW5a8S6linAKkyXC72
	pTaopujI6P9Zldfolw8ccXs0ghEyAi0Y5zkSN4on9xcBXOl7btzgQ8hr27jWfbRc2a8M5YzqPiK
	09yVg==
X-Received: by 2002:a05:7022:f8b:b0:11c:b3ad:1fe1 with SMTP id a92af1059eb24-1244a6e9b6cmr8741045c88.11.1768787154303;
        Sun, 18 Jan 2026 17:45:54 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244aefa7c5sm14340962c88.10.2026.01.18.17.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 17:45:53 -0800 (PST)
Date: Sun, 18 Jan 2026 17:45:53 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
	willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
	martin.lau@kernel.org, jordan@jrife.io,
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
	dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v7 13/16] selftests/net: Add bpf skb forwarding
 program
Message-ID: <aW2M0cR3lEBEENim@mini-arch>
References: <20260115082603.219152-1-daniel@iogearbox.net>
 <20260115082603.219152-14-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260115082603.219152-14-daniel@iogearbox.net>

On 01/15, Daniel Borkmann wrote:
> From: David Wei <dw@davidwei.uk>
> 
> Add nk_forward.bpf.c, a BPF program that forwards skbs matching some IPv6
> prefix received on eth0 ifindex to a specified netkit ifindex. This will
> be needed by netkit container tests.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

