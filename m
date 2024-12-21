Return-Path: <bpf+bounces-47517-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7C09F9F05
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 08:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B295D16B97E
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2024 07:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C21E1E9B35;
	Sat, 21 Dec 2024 07:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="zgoga0QS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDB71AA7A9
	for <bpf@vger.kernel.org>; Sat, 21 Dec 2024 07:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734765745; cv=none; b=HafP6Vywc6hyry1hbEpe5DUCNGSbqx/dijnX1vi6RGfgK1TLBLjywnYo1q21TovCNdER8E666Pv60lABPPiJF7T08uLRjGUUsIWoRikJRSrJCDaYiMtWJkj8W9D34kUCQw4z3dNcwhcdgtMHxUc58RWezsYFZE/sfv5H+/YdWjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734765745; c=relaxed/simple;
	bh=37a/v6V/qVTYj75OLJ0gfzJnVO9B2xvI3YKnXrcIlW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nn+q/pB8yabuQ9TWAJIIOubKRaq6GR1jnl+4R+9ReCyxDuwWHiKVfq1UcikDQummg8Hmy5Rv1lorNJOsHGURC0NErvcc9mPUSL3FJw/AxWrvuWT0t++JzdYzKIIydqGD1L6r4yl88ifqmlxu4aEuzCyiDpy1M/GW0RU1Nmj1RyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=zgoga0QS; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43634b570c1so19177995e9.0
        for <bpf@vger.kernel.org>; Fri, 20 Dec 2024 23:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1734765743; x=1735370543; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rDuHJJaQb5fwBxcoZeTtCnujI4Vxi85W3MczCC/iP6k=;
        b=zgoga0QSs/FSgmWkPC34lIGH65A4rdwERvxYqaWx5t+WCKyHXuthfWAROfxECnxzxG
         Ywbb6u7QDCvn+KpLR+wdqRQG3gXBEN98WVApTkE0DTG5SCrKO/8bXhpJZdJM8DeyiYmr
         AT3o0ne+JxmsZLuWH8zaY91JgeKh3LQFWMIpC+7SJ66ZmiuImlhpXLQJ6ypoHitagjK5
         reTCagvVeO7/ozbLaS/kJJ000xt2WO6hZpN15oNYBYmFKuWNPq929cBKtvrX1cl/OOGB
         Cgzcr+1hXHAzA5S35LlHCOwDAaX65o2cA1T5piFp+O8ULfgvrPQdHjoOQiX/mkJllIFs
         oBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734765743; x=1735370543;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rDuHJJaQb5fwBxcoZeTtCnujI4Vxi85W3MczCC/iP6k=;
        b=X+fAUFuqEdOiMDpdbSfKJp4pZ4kTuWkIRKHunQbmBkldrafbHmbn+msv0S6fcoOBwW
         x566JQJQChbWDU+kOdbs00OGN5CfwK3DphHeN08BP2dFpTPFnQmaS2uVoVdD3yOCuFWM
         hdxhc9LEnBp8Bn7FpEQ+XI6HcN/7ginWwHg+FMdJJi8DlyC4qz4IFt2G30+rXzL70S31
         zenMGX+181KNnv5kPNOiAX+9C/CoHILqW7SgPGyRqBW4eLTiJpRUWQxYIyT120Rp3I8s
         OOypNtrWAsjutjKhZOs67BgIfwh9BgZZFuej8AoXS/GrGogCelSThpIdggfG9nn7JvfR
         bhPA==
X-Forwarded-Encrypted: i=1; AJvYcCUtSjmljrYoEIFy564QxC3v+gxcWirhhgOWNcJAyWYllk7A2LZnHUqu5+/Bwokrt+mzSXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1RBkb9aIv+wZlKFUzhh9IcA+O27oIMse26NY0hfQZsX5vY3R5
	nnQtS9VzSeKsZhn4/m64VFPuQDjbmtOsD6KlZaTZox00OsXQ142QBLDIWdgn+V0=
X-Gm-Gg: ASbGnctfPlAQWQD9QZzZroLfZVeJxhS1ydmhdBifxkHysfFcy6LE6VPIgrz21NAWaMW
	LGl0UqE/sY96B2vIEoCTFITnGZLZZBbPLCMsgRtbQLu1X/eIB5Y7Zm/8Xdvfn8WY2F/a/oZi9mt
	oTRRSEINOPqqJNY937vUvOZjCbdrzwxH9mqhhKskMBQdfFbCxiZ33ie2RuVx+gZWtWTO66pVtp7
	b0yhK0jkYrtmqrqM2Vja7ysYuHNlVahdi7Aa4Tzbz5W1CjKkJsAIEkiXw4Xmhbb2EqHszWSLjZS
	j3jLp8l1d4AZ
X-Google-Smtp-Source: AGHT+IHfdIN3rLQI8OJcOpR3tltD5UI8SyUBOxEPS8cqsdqsJyiKRr61UnJbs/KMz699DK7W2DbVXA==
X-Received: by 2002:a05:600c:4710:b0:434:9e1d:7626 with SMTP id 5b1f17b1804b1-43668b5dff4mr42643005e9.25.1734765742814;
        Fri, 20 Dec 2024 23:22:22 -0800 (PST)
Received: from [192.168.0.123] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656af6c4esm101601405e9.4.2024.12.20.23.22.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 23:22:22 -0800 (PST)
Message-ID: <5338e487-0e6a-4b90-affd-328d8c471d62@blackwall.org>
Date: Sat, 21 Dec 2024 09:22:21 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/3] netkit: Add add netkit {head,tail}room to
 rt_link.yaml
To: Daniel Borkmann <daniel@iogearbox.net>, martin.lau@linux.dev
Cc: pabeni@redhat.com, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20241219173928.464437-1-daniel@iogearbox.net>
 <20241219173928.464437-2-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241219173928.464437-2-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/19/24 19:39, Daniel Borkmann wrote:
> Add netkit {head,tail}room attribute support to the rt_link.yaml spec file.
> 
> Example:
> 
>   # ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/rt_link.yaml \
>    --do getlink --json '{"ifname": "nk0"}' --output-json | jq
>   [...]
>   "linkinfo": {
>     "kind": "netkit",
>     "data": {
>     }
>   },
>   [...]
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> ---
>  Documentation/netlink/specs/rt_link.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/netlink/specs/rt_link.yaml b/Documentation/netlink/specs/rt_link.yaml
> index 9ffa13b77dcf..dbeae6b1c548 100644
> --- a/Documentation/netlink/specs/rt_link.yaml
> +++ b/Documentation/netlink/specs/rt_link.yaml
> @@ -2166,6 +2166,12 @@ attribute-sets:
>          name: peer-scrub
>          type: u32
>          enum: netkit-scrub
> +      -
> +        name: headroom
> +        type: u16
> +      -
> +        name: tailroom
> +        type: u16
>  
>  sub-messages:
>    -

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


