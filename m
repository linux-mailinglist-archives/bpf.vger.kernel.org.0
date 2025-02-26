Return-Path: <bpf+bounces-52627-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C901DA45A92
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 10:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C8267A7F81
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 09:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCCF238159;
	Wed, 26 Feb 2025 09:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="yo4EE5bm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1F6226CFB
	for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 09:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740563339; cv=none; b=DDynPcERvzHtS11ZKznSZ19uW4JjKzYNfEepHIaA6TG1a5AvsUpGYQw9TIGPENRGnnBR3I7oz1IU0URz3d9s5W0FaWCpCwBzvf/1ggZExG52t6+HgE1XnrnSk32VJyVLz+xa8SirX1fcu8YnDH+v5re4mbzWkN4z3/H69BF+DVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740563339; c=relaxed/simple;
	bh=1HPPBHHSUY3PRvmuiiP90sap6MSAtYnXYhmsU0XUNLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qQyv1spYG+L1pcKgFVNWiNzQUBcDrNrGupZYF5YXUlgBJvFv82C4zUZXUKtwSyMGxnasaRG73B208jITN/q/zP2z0KeOLh8HA4YMN1Bcg7EZOmli8oXilqBlGcFK1Dr1bsozqFVLY9AS2KG5rhgEtSsiqaC3CeoJQhGuBzcXGS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=yo4EE5bm; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaec111762bso506805466b.2
        for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 01:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1740563335; x=1741168135; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CEZzW4mm0bZ6YAjD2BUJKfvoKsnMPQlH9S2idWWcyCw=;
        b=yo4EE5bmdsx9h5+yfNJ1TwPfQNIxLnpPJ0fmjacDfFr5LL0F6yALSJp0oi8SaR0Hkd
         BAj4xU6SDyTfq9Ec7p+xlGjS/YM/iPScLYvR9aqLj8YAQu67pzTuPCjY4rlLosNlkxMK
         h/CHrRZ68kPK3dA/lstN/GA4VCUFrwbU4qD23vyAB8e7EHe2kRmv/wxuJvLyl2BZbikV
         v2LYth3VoURH1d6MCFeu1DJUI+xoQm80BzX3B56Ku9RdKs9rzsNJUMcc9giT1YLpW+VH
         8I0Nd1zf54Em81lpmnVtPtsGiC3NwszHBahrr6k/8ccdfqjUPJdVAD6QA2oj/g4tO2s5
         Z8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740563335; x=1741168135;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CEZzW4mm0bZ6YAjD2BUJKfvoKsnMPQlH9S2idWWcyCw=;
        b=m8TLmAW4Gvj3tCeq3qPyDXlME3xtY7dN7p3/D3ou4X4X1IHb6axdM9mswbGKzeDUDB
         sIJh0D+Sr9ggS/Fn+3cYNDRKcjJqKBouCDP2HMJwdqoESlcr9wDCIf+UdtknvuZt4tQ/
         oqY+hRmNgAfU/sxiAfoVyKtGdQWfJ269mF8EW9+f+mpIQj518C9GqiQlQG2UymlCqhKj
         S0cn1B9znC4DuLPfNYZ7m0EKS7iyhhXhFO5P055EnUn8G7vR6Lr4jOlKOq040sz4Rk2+
         8AC/81TZe4f/g/GwO7mntSDoAUFl3z8ha4RlHNFyPBlBCa5qHxGGEnPLfFGY0TiF/iww
         6vvw==
X-Forwarded-Encrypted: i=1; AJvYcCWKcYbhiDjbelDKg3bR2cx5MgZSjiY0zK8+nyXFuGOa24u5vZRn55FjlnItwQuEg84iDPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTKTp4xYypbFV/1XZM0nZoc6myf08PslGqsQp4DOGSyto1wa+G
	Bje5+dtF0PJoYxcNMcA1oj+cm0/EXha3Ws5CryQCtwYdeQsn6+VRMWYZnuSFFDHICk5Cg9fVWQf
	R
X-Gm-Gg: ASbGncuvejxX35Tt5p/+BEtF8/ZPuD5dO1v5oAPpL4YtLdHayeD6uuLjF6SqWnPr6+Q
	8XoMClN296QJwWQw0C1SCQDxIhJif9MF2OkGLfbSsXw6lOIlZw1ojwW3dKsJVEEJkfKDJtRVpFk
	kJou6NscS882Qcy4geIvt8qoGEtUyUrEUacbe1oNKAMnK0iGVIFxOM7wX+j79PE3QdUNCC0oe65
	6J9bdK4+JpwRmwYvEBkGHyE35dGhsbcvBFNuaxWwt39h0KSINeOC1cu+Bla4MdBDSpsGL6F4Fao
	lh+My57rjHaiSw1hMApIPOXtyxP4AQb2kqhHqdsX5Qe6rIR9wTDyCNrf/Q==
X-Google-Smtp-Source: AGHT+IEl5djX8JiFRmc0bLyTiN+Op/kyQSTScGVDsJHx7aTXaZ3/WEl7mETyPPGA+Rk2eAsmYwBy9w==
X-Received: by 2002:a17:906:18b1:b0:ab6:ed8a:601f with SMTP id a640c23a62f3a-abeeed1123amr258466766b.12.1740563334449;
        Wed, 26 Feb 2025 01:48:54 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1d54a0dsm299856266b.50.2025.02.26.01.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 01:48:53 -0800 (PST)
Message-ID: <df2b1a91-89a4-40e8-b0d6-b666b17efb5a@blackwall.org>
Date: Wed, 26 Feb 2025 11:48:52 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] netkit: Remove double invocation to clear ipvs
 property flag
To: Daniel Borkmann <daniel@iogearbox.net>, kuba@kernel.org
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 Philo Lu <lulie@linux.alibaba.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20250225212927.69271-1-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250225212927.69271-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/25/25 23:29, Daniel Borkmann wrote:
> With ipvs_reset() now done unconditionally in skb_scrub_packet()
> we would then call the former twice netkit_prep_forward(). Thus
> remove the now unnecessary explicit call.
> 
> Fixes: de2c211868b9 ("ipvs: Always clear ipvs_property flag in skb_scrub_packet()")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Philo Lu <lulie@linux.alibaba.com>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Martin KaFai Lau <martin.lau@kernel.org>
> ---
>  [ Sending to net since de2c211868b9 is in net ]
> 
>  drivers/net/netkit.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
> index 1e1b00756be7..20088f781376 100644
> --- a/drivers/net/netkit.c
> +++ b/drivers/net/netkit.c
> @@ -65,7 +65,6 @@ static void netkit_prep_forward(struct sk_buff *skb,
>  	skb_reset_mac_header(skb);
>  	if (!xnet)
>  		return;
> -	ipvs_reset(skb);
>  	skb_clear_tstamp(skb);
>  	if (xnet_scrub)
>  		netkit_xnet(skb);

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


