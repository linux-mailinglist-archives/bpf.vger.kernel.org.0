Return-Path: <bpf+bounces-57534-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2064AAAC8CA
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 16:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D077C4C824A
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 14:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8081283684;
	Tue,  6 May 2025 14:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AU+8C+x/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AAE28315A;
	Tue,  6 May 2025 14:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746543280; cv=none; b=Dbz54uBJc+kY0b3inttMgcF6vQ8kPY74tFE6cWDfNPX5f85DgPbXx+pEeY0GmMVNk97QrcYWDvhKvrwVcanK29/tPCBY0nOTPWmEYprWsQ7uCVsrWSuE7GqfD2VoiryNqLWUrR16tfsfMe5vWZPbFGmThgVtN4KK84CtUVhAFKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746543280; c=relaxed/simple;
	bh=K9ogP1tmJjZSOXVBIvvRG3xIb2/GeSv/sKRRz8UlgZI=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=IiaQmh5Ezdo+Cf04C+PqTXd9NSS/Z3ydnETck+2X9Zoddo7z4Ojp9K7btMzGp6AUuttW7YPLu+q5aEEfWnGbmE3U/1ZytQRwY2xwNGG15gvdA7kVkZra4XUQIRmaG3TLlILJzhfuYA3OFQsuccMdye+AHo4FMjLID9P4QF7USZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AU+8C+x/; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c5e2fe5f17so638154385a.3;
        Tue, 06 May 2025 07:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746543278; x=1747148078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jXdU4F4hQFYW1syDEWo1uY3Vr2xLb+00dl00kT5tMQc=;
        b=AU+8C+x/OMI8t+j7wz4Ugk+i2QVnNNorJHbgVL7IlmmaXd+qG9YDAzcnTrjU19WX/i
         vo3LdoFceMZ/RiGfTYVfFVU733lBqNlnAQERh0o3k2IdtL4EPuI1aoGSziYDS8awYWMY
         7ylplU7pl1+BxMahAO19yn/E5TMykj7SIsSxxKWm9+wj1v92VXtu8f7UW8KzYjw8KaIO
         +UwnYa6X8ZNhoeOQiWky42+nBz5HnSrdbaCBHCTMbpnr7BjmU0aqPgAiMQrLtm60Cioe
         g5XZxV/IdArXqgU9+rOzA4QuVDel0ZxhvcO8UH3xdraHVLKzIxaS94s4GwOwC6EB4dlO
         mHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746543278; x=1747148078;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jXdU4F4hQFYW1syDEWo1uY3Vr2xLb+00dl00kT5tMQc=;
        b=jPlRKW4EZIflutCjQG2Q4lWyovLdra8odlJC29S9vaavAvrhZCVuicTJv8taHGANTq
         KYX+OTvwoPuxgA2VflVAIUXVhU2ZN/fuauxi140PM28x9D1YE/7MHUNOvcDXPV6Xcm+1
         wL66/lPRNuoXawPbCGWhc9czrdw5OKZ1+roJtgz2vQEW2ZL7qq45yGINJ6GwmAeEBWQ5
         b6stC6cO1G++8lStUd6hipQg3+MkVUkkv92o68TwPjc+Hv2eMKBraiM3r/EdJ6EHVyM4
         /KqAhSSDh+R3qXQSnfwkWx9VkiqRI5kFr4Ar/10jKNuqx0FuzAvAgdSn6PKYovyVgvHf
         ggqw==
X-Forwarded-Encrypted: i=1; AJvYcCVzfrl3LrQqCY8uDj8HOeKzzZ3t7CAWrRdld/7wW6po59NakbsTomoG9XhDjrVtJQkJyrY=@vger.kernel.org, AJvYcCWloSbvYd3i0uo9HcZCiz7nWO4lxK49/PSg5VwCG5kSOnDFJx5QjJ4HfHws/86Gjm0IHAjZhdB4@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/5niK10A24+WtLN3BwXe95ZL21xBhIy68yy6PW4o6p3qeNalv
	AVKl6wa48YACSJLA5uEJxpQc6fWx007QcdchiIbl0eiJwDzZHAn9
X-Gm-Gg: ASbGnctnEKVy+fja+4vjXJz73502yJ6kgzz85ihjhj8SbIOvyJS/mqYTFfG08OHji8I
	J5w+Ajh0DOFIXN35mEhTeLAsJv75p+AiaXa0SvEvDEbUJ07wy0dn5GFlGl+GI8nV99um3WBm2Jr
	psUB/eSjTsE73nyHzqzKHf2e1ZE/hE4a+oDvVp+uIZdkwnYTCzcOLSPzIspKocGunKPRI+SWpZl
	4zWc7gu/d/WV/ad/9ZPiOtFJCyXPK2muN3XV7BxEc69wHAODePUYct9jWXqqviiM6Wow5BbBv6M
	8ZoqAr2mikfcBLGHbTdRcFBPqci1FP21PpzLulef3D+6lFx/27gcaglDER4jCywH6qYZqyjZwI/
	PysXowlLgn6FiXv5DtcaL
X-Google-Smtp-Source: AGHT+IFsgzLQ70WIuR2BZG4l8TtuRZ6R4lbanDP1rOl2rp3pL5f4+VL3jZRyUkMmquyu4BtqTzuX5w==
X-Received: by 2002:a05:620a:4690:b0:7ca:efd9:7d49 with SMTP id af79cd13be357-7caf1117cd2mr444331685a.13.1746543277675;
        Tue, 06 May 2025 07:54:37 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7cad242a486sm720632985a.67.2025.05.06.07.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 07:54:36 -0700 (PDT)
Date: Tue, 06 May 2025 10:54:36 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jon Kohler <jon@nutanix.com>, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 hawk@kernel.org, 
 john.fastabend@gmail.com, 
 netdev@vger.kernel.org, 
 bpf@vger.kernel.org, 
 jon@nutanix.com, 
 aleksander.lobakin@intel.com
Message-ID: <681a22ac9964d_15abb629445@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250506145530.2877229-1-jon@nutanix.com>
References: <20250506145530.2877229-1-jon@nutanix.com>
Subject: Re: [PATCH net-next 0/4] tun: optimize SKB allocation with NAPI cache
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jon Kohler wrote:
> Use the per-CPU NAPI cache for SKB allocation, leveraging bulk
> allocation since the batch size is known at submission time. This
> improves efficiency by reducing allocation overhead, particularly when
> using IFF_NAPI and GRO, which can replenish the cache in a tight loop.

Do you have experimental data?
 
> Additionally, utilize napi_build_skb and napi_consume_skb to further
> benefit from the NAPI cache.
> 
> Note: This series does not address the large payload path in
> tun_alloc_skb, which spans sock.c and skbuff.c. A separate series will
> handle privatizing the allocation code in tun and integrating the NAPI
> cache for that path.
> 
> Thanks all,
> Jon
> 
> Jon Kohler (4):
>   tun: rcu_deference xdp_prog only once per batch
>   tun: optimize skb allocation in tun_xdp_one
>   tun: use napi_build_skb in __tun_build_skb
>   tun: use napi_consume_skb in tun_do_read
> 
>  drivers/net/tun.c | 60 +++++++++++++++++++++++++++++++++--------------
>  1 file changed, 42 insertions(+), 18 deletions(-)
> 
> -- 
> 2.43.0
> 



