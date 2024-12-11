Return-Path: <bpf+bounces-46599-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0949EC5E9
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 08:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13A691881BE8
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 07:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803831C6F70;
	Wed, 11 Dec 2024 07:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="DH2Qoqug"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B79C2770B
	for <bpf@vger.kernel.org>; Wed, 11 Dec 2024 07:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733903276; cv=none; b=ITQraSs8vQSy3EMwPr4zVgLpHsR8RrC8cv9PTKGswVFAM7ZZE6dSs88yd9GUZlNAKNcCO4JJbghSPFGjgMbz+meP8jGltWv/VxLaY1YoDEQNADfrSflsWqHOuKB4Sg8VOWOMVnyphbHTcWULgxV7etCZKco05q50M4k7+PSzsYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733903276; c=relaxed/simple;
	bh=TUVGTdzfcQP43eRAMRjYFmi1MnK/rZDxy5/4b8C8Hdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MdScSrrUDihTWLJ+pZSBUmhEMTV+RoWeZppBRM3fGTLiblSO24pkC1KaDqzC4D4XDtTAUAbJ3KQEJTyAzFeoNGV53M0XNImShLE/VkfWQAqwrhXjfmq5xuV7sAnxyKYCmpEi3vtFQXHr+dTxcQuBNr7CEiLxWdfebCoqBUPRYHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=DH2Qoqug; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9f1d76dab1so877663666b.0
        for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 23:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1733903273; x=1734508073; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C9avSO34dj2cbK4oT3GkDrDvFb5SBzVZgXvDYfCmnG0=;
        b=DH2QoqugnssSYahAnVgFMVATuo6hRXTAVBYxqS4srDTKcel6+dOoFU4bkAq6ky5fMd
         i70oTXJaAH73UB1j+gXa+1FrMwvNCNBZjsFRA7Uw35WrUV+Yere/5rxV7TAKlQitu7Mn
         cESFSEP/IuaxFI+owBHEvDQnQcHRK1ioftYNxL369bw51+AoYSYvt/hKALZpzSsq+JzC
         9Wc13OT6825GkNZqTvMK3bYiVWzOY0vCjLLr55579fBJ4A0PtHJF8Uhxs8BnWIJ7oYY7
         99ZFiChJGbtcGbd8vb29sL9R+gLP8/EZjDERpeNtuU/Oq4Yk93i8ksX4gr53gp0fwtnM
         qmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733903273; x=1734508073;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C9avSO34dj2cbK4oT3GkDrDvFb5SBzVZgXvDYfCmnG0=;
        b=wJIOsHsIJZs27lZOeLdDOieVxoa7Q32gpPjPOlN65XxtNhtjJht+49C9qEWDmnEaqe
         0V8rG+bpqNBAVRhwV0uD3Ic+6lDcr6gJrwxiaehYpTlZXM8LxfrRGjWMtjKvzheR2sYU
         MvWViTA9q0bh9rh0kSZ1ont5Kjooxos8HGPMRuW6+wNEVYxW3+9WP50n1Po8nl7juLgZ
         OSY3mhvs4yyWl+kM1HJssswPLGQ4vZOpykc6MafQ4ivn1WeBgPF8nZ/bl3DYioSjEn8V
         /7MnX0MXxL5j6JlOueWIgk9esomXBh/Isr07BpZCgzUsfDrr3dwasoLXKnsTJbbXp2Oo
         sUqw==
X-Gm-Message-State: AOJu0Yyfk5kYmGzEtnbKbstW9EYoFNo3dliUU3VnA6WrMG6Y71OdF2E8
	J/84VVhX5D6BSAoyalTOt3hnzd0TI6BH2DKDfokAH3lymrDGa3sS2ud/FXfnJ7M=
X-Gm-Gg: ASbGncv5MUcpyaoWSlvPGG1v7b5DDgjnc6Vetphf/TV3xW/V+DsCctlhG5UF67+yRnI
	ku/UaDkmbM4uMiJJWWdmS6W22yLrWMYolsU+1/a7v1DBMXk3m2ePUKK0/D8uXuzjFqZjXiyTC+L
	GWKtXSBTTsm/Qr2LWgjMnfvkAlm66bje/V9CvMA7/4mPMSBoeY+P/HQSK6eSmELxBILkLAvBJsA
	DGRhXTVCmbIr/lSV/QGRJ1Q287OwQPwAEmtyuz7NqHesG4dHl5XF6l/
X-Google-Smtp-Source: AGHT+IHaFCpxYn1qWnjVigLj6jX1jU0ewLVQF5KgPoDKZ0fPJqOBncskDQmBZX1lbuSMbjqhPVLTyg==
X-Received: by 2002:a17:906:2192:b0:aa6:6a52:962 with SMTP id a640c23a62f3a-aa6b11a05b6mr141367666b.18.1733903272842;
        Tue, 10 Dec 2024 23:47:52 -0800 (PST)
Received: from [192.168.0.123] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa673474d96sm540475266b.96.2024.12.10.23.47.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 23:47:52 -0800 (PST)
Message-ID: <9c4f8153-7eb9-47a4-89a8-dd0f875b8b1a@blackwall.org>
Date: Wed, 11 Dec 2024 09:47:51 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 5/5] team: Fix feature propagation of
 NETIF_F_GSO_ENCAP_ALL
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, mkubecek@suse.cz, Ido Schimmel <idosch@idosch.org>,
 Jiri Pirko <jiri@nvidia.com>
References: <20241210141245.327886-1-daniel@iogearbox.net>
 <20241210141245.327886-5-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241210141245.327886-5-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/10/24 16:12, Daniel Borkmann wrote:
> Similar to bonding driver, add NETIF_F_GSO_ENCAP_ALL to TEAM_VLAN_FEATURES
> in order to support slave devices which propagate NETIF_F_GSO_UDP_TUNNEL &
> NETIF_F_GSO_UDP_TUNNEL_CSUM as vlan_features.
> 
> Fixes: 3625920b62c3 ("teaming: fix vlan_features computing")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Ido Schimmel <idosch@idosch.org>
> Cc: Jiri Pirko <jiri@nvidia.com>
> ---
>  drivers/net/team/team_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
> index 306416fc1db0..69ea2c3c76bf 100644
> --- a/drivers/net/team/team_core.c
> +++ b/drivers/net/team/team_core.c
> @@ -983,7 +983,8 @@ static void team_port_disable(struct team *team,
>  
>  #define TEAM_VLAN_FEATURES (NETIF_F_HW_CSUM | NETIF_F_SG | \
>  			    NETIF_F_FRAGLIST | NETIF_F_GSO_SOFTWARE | \
> -			    NETIF_F_HIGHDMA | NETIF_F_LRO)
> +			    NETIF_F_HIGHDMA | NETIF_F_LRO | \
> +			    NETIF_F_GSO_ENCAP_ALL)
>  
>  #define TEAM_ENC_FEATURES	(NETIF_F_HW_CSUM | NETIF_F_SG | \
>  				 NETIF_F_RXCSUM | NETIF_F_GSO_SOFTWARE)

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


