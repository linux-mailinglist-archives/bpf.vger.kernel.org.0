Return-Path: <bpf+bounces-46596-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECEC9EC5D1
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 08:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD3A6284A0C
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 07:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEDC1C5F2B;
	Wed, 11 Dec 2024 07:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="Eh2uPC2J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD091C5F12
	for <bpf@vger.kernel.org>; Wed, 11 Dec 2024 07:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733903089; cv=none; b=E2QfQS/xWd4jOurYGVOiCgnYo6FY03WoKrFZVwl+1Oj77F7EbJ4LHS/B3NntFaNCefvAGP9rhkYzzJjGGvn/JeacM48a4cSPojSBA13mxQ3UoDzyeKpfT+DCYKn01DoM8/EgoE56ss50otWw6ve2OtCpbi9QC75Fv6YFzZe8eQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733903089; c=relaxed/simple;
	bh=sxIVMt2/hjD756uf6JvOJ1KnrBG+5g6ANXFrmIgtwkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mk9pBn4f4EqimO/59bD/js61R8JVvT4K0gYrRDuDV2oeoooQneBAG8lTPPM2BnkLJiFlmg7WrCup+FVyEXRbJ2oGywYFQ3x5LzVo6CL8vBQFZEBP3TmloAldS1uU/Y5d095yTfprVC+jdPApvy0pRnH9FN+h0xFLOdYgoIYzXis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=Eh2uPC2J; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa68d0b9e7bso527409566b.3
        for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 23:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1733903086; x=1734507886; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D97EgHWZotyjd7s/d3GBn8KBQp5+lUYmXrY11fzr0yo=;
        b=Eh2uPC2JnIxcl1XZXws60JnnYP74xWciU98zGloUD3FFIDAgKyJuPOOpS/Qn6Pb7G9
         6983NlQ1hyTG/BMCbRYXKGU5HifKa9qyh2VSRtmTIQ/Z9I20uiQeUEzDGUx88zzZ01Hz
         DYosQyGPc/M72N9m5V8Linx4RuiSnM88ZZhFH20gJ3jZt6C0hDASB0VdGLxbJpNjaqNx
         uFkkBuv243YfhEJ2VOfc+q5VN0uK/MznAGiogl/3h1wIC7LIjnHWB7Hc25VwWzHDMTSh
         WAsd1eu74x3dp7QldLx6i38O8+hIsldtFNTdXT1clYDcvG+yCEOY65801n263ZsmcHmK
         ImEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733903086; x=1734507886;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D97EgHWZotyjd7s/d3GBn8KBQp5+lUYmXrY11fzr0yo=;
        b=pwRPT1louL09RnawC+M5EvU3ATgN2wwBKbZqyOm7KRwB5GVm5GWiyy5YuxeLohfBX/
         BZkHqiSn+OefKQDr8wOgcHDjJpdi/nhPZAo0GHKVYLr6j+Ynnk+N11/3/t+eCKSs4KQb
         I325R7MPYiQpPx6kbjivgZ3dWdfmFq9b2zOliLDdDlen4azCre4KYxgNnXRWpf9xDyRD
         Zd+YG/Ksgo3UdFXOC8qjZ35H70QcJgecKHcuwWw6udqeaqMRtJHZwZ3OmQbIXEll0SJg
         FG8CbvReXqBQhNDsP5S1U+4idUzrRdSGIm/d4BlOVUk/UQKfO05nY3L/lrekRQ11jdBD
         uO8g==
X-Gm-Message-State: AOJu0YyWuPo64T70O+oXT/sYh6HdeilYLr1435zWJSfbV4BGDCh/lXIz
	1/eVYxQoeMBrzwliabC/qwJRYQb2D6YgwFIQLGFY1lT8k86oy5eHRtUf9MhneAc=
X-Gm-Gg: ASbGncv+ZAjHN2zKOadc/r7V76L0SSrzINWuiHvOwK5MqCLbZPSJw/hduxlQnUs+ZXr
	NwkQV3K3TFRwIFs4TmdwouioAUdt5sJWWVDWoXl6PoZqk248UuzQkWbwMuKYZpytrKI7dXKX2lq
	ZQCyuCx7VaD0nnoo2vdYHxWPoluB2zWBmhPc65mIg+aI5E53316g1K4DHLmlZX9opvGO+sokfKk
	YV1M5xqIx8ojDRM60cCus8/uLg0STfiq1+za7EQcEimfGZ4AgFMhQtp
X-Google-Smtp-Source: AGHT+IH5dw3FTzIpV1e0MSOD0zhH7/Ngnd7ahJWo+lQxTTpdSZqNLLX26PwbmrntQk9dug+yImGlmA==
X-Received: by 2002:a17:906:3ca9:b0:aa6:96ad:f903 with SMTP id a640c23a62f3a-aa6b11b6dc2mr153987966b.31.1733903086202;
        Tue, 10 Dec 2024 23:44:46 -0800 (PST)
Received: from [192.168.0.123] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa683de38fesm450821966b.108.2024.12.10.23.44.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 23:44:45 -0800 (PST)
Message-ID: <63fe7c7e-f45f-454a-ac07-db758661d15b@blackwall.org>
Date: Wed, 11 Dec 2024 09:44:45 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/5] bonding: Fix initial {vlan,mpls}_feature set in
 bond_compute_features
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, mkubecek@suse.cz, Ido Schimmel <idosch@idosch.org>,
 Jiri Pirko <jiri@nvidia.com>
References: <20241210141245.327886-1-daniel@iogearbox.net>
 <20241210141245.327886-2-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241210141245.327886-2-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/10/24 16:12, Daniel Borkmann wrote:
> If a bonding device has slave devices, then the current logic to derive
> the feature set for the master bond device is limited in that flags which
> are fully supported by the underlying slave devices cannot be propagated
> up to vlan devices which sit on top of bond devices. Instead, these get
> blindly masked out via current NETIF_F_ALL_FOR_ALL logic.
> 
> vlan_features and mpls_features should reuse netdev_base_features() in
> order derive the set in the same way as ndo_fix_features before iterating
> through the slave devices to refine the feature set.
> 
> Fixes: a9b3ace44c7d ("bonding: fix vlan_features computing")
> Fixes: 2e770b507ccd ("net: bonding: Inherit MPLS features from slave devices")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Ido Schimmel <idosch@idosch.org>
> Cc: Jiri Pirko <jiri@nvidia.com>
> ---
>  drivers/net/bonding/bond_main.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 42c835c60cd8..320dd71392ef 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -1563,8 +1563,9 @@ static void bond_compute_features(struct bonding *bond)
>  
>  	if (!bond_has_slaves(bond))
>  		goto done;
> -	vlan_features &= NETIF_F_ALL_FOR_ALL;
> -	mpls_features &= NETIF_F_ALL_FOR_ALL;
> +
> +	vlan_features = netdev_base_features(vlan_features);
> +	mpls_features = netdev_base_features(mpls_features);
>  
>  	bond_for_each_slave(bond, slave, iter) {
>  		vlan_features = netdev_increment_features(vlan_features,

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


