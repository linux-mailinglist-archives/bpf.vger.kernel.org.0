Return-Path: <bpf+bounces-46582-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 276309EC193
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 02:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F84C1889220
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 01:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03131D6DA3;
	Wed, 11 Dec 2024 01:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/u8TzYi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE5B183CBB;
	Wed, 11 Dec 2024 01:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733880824; cv=none; b=MekKWoSk4Fj0k1UawoT1j4GSHZ2iLHllQk2qGkFQhHYfSfj2fJ/D2reWxhb9i1Cj7BIqi+r/JRNjyCMwiqZyXWzInGIzmrdj17+gq68BtcrY+yQJ3MSfRbzhRKFKeTG1M2wLSsrkCurBQ8NXJN1IcwU9bUHTP8bvMS9IIgrYOiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733880824; c=relaxed/simple;
	bh=HkuoD3MdsgdUq11eUQxnSzzxxX00LLLtF+6pEB3G8Ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i4UuoSkkKDlqil7wKHxuOEXrlM9OX5MZN1GGDDHQ++8pOQR2Uc1Mn7/LmKUUubKsXBjdkOBLoZwltTPZiFZW2cZr57Mm3GXXodJdUQUSDTXQbcZuCAwfwfr4AbmvDx53iUXz7uAhOSe/X0QzVVRMJoiCJc8fTgZQwZg1M4qrZCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/u8TzYi; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21631789fcdso1316645ad.1;
        Tue, 10 Dec 2024 17:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733880822; x=1734485622; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oIg5z9DwAnNjKDqi4AszpXeBD7CvekP0cOJlGdb9IuU=;
        b=C/u8TzYibAA0uwOXTt7SW7tqDk8zMAqec3tvYUMFpIRlri95YZ0afrgSwR+Ropo2B5
         Przdwhm5FycBi+W4jlO5Oex39p0WW/VsnxH7b1itxZENKLuhav1hmBfC2/QdNVhhUL4y
         cdA42ELOIhDGHU22vs//ZoOchkjm1C0RFw13UDtRol1j0LNVoCApHzL6F6EUU9BC0Gc0
         zEnHUUqa7a33ZeQ74RdsPTk7pj4zIJmMViTVns185kQ/+/EFBHX94ITVbIJFkHTjdbUg
         QcqS3dO7Psc/q10ye1EMc2yWjqPgCcpXlfRyynxKrJFVDB+KkwOvYHlIZOV+rZo1AL5b
         6onw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733880822; x=1734485622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oIg5z9DwAnNjKDqi4AszpXeBD7CvekP0cOJlGdb9IuU=;
        b=NEZ8PNxVTD8+ioGGpSuMfuT81t+K5S8Mh+EIwCJkMBGSb1jGyrNuqxEGNMwG89+rTn
         XAuJfyEBEPbbyDc9NZjHRvlcaurkD7Z/t8CC8Zwveur3r26T0wvY8bDcx2lz7UZWMGH2
         mUMesMmfkK6od+fOWVJMKNxN3mvPUrHymm0F1wtq5l2eq5M4115j86LGojVMLQKeGSjN
         uTIF+PdynDAsjj19ZaHUMwOEq+qtx4lFAP2cg7Pt3MDG3yGInz4usMKqYq12s+tWJuMB
         hRhyXw2tg6Jm4Seb6O/GYZalapHwwJYXxCEiaVi+x6FJk5PEdo9cB6HvDycsXSZJ61vs
         TcOw==
X-Forwarded-Encrypted: i=1; AJvYcCULsXzolxWdZfnoMfnrRO9FJ5QWf7y5Y8f0x8ArRsFJ7JkoAotejGNXp06bzuwTLwWNwTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWk7y9ouMKSWET16oojri3f8rXKAxWJYBRJYSvDNmBusch/Rgz
	jPgYVjmeomxqwUGGsek0/ac+WIyXoCcNDAm2+bFn+aplSqo7qaBI
X-Gm-Gg: ASbGncvN3Vq/CdschGiUykIHb5s+DLbPl5qIVMSKTrRAq2Awz3KA4TEGdWy114hWVkz
	/JNSgcDf7iJBJCN9kz+dZGoR5jrdYG/Nzu4Uj6e8g4Ehlz6NH6resTqFG9UPnXyQ+zmW21g82JF
	iP+f4u4KAkokBw1Ezr8Ov3Ww35TsgPbkqigEcaG0Zb7oWuEAlKsgm9LLXvjonBSO1njYWCUpyJj
	zYYv0d/uSmK4ZaDPXiqY9BQ8pkFoPbjFE6BE/AkmnKCoTXNWCYYuHCTYPQ=
X-Google-Smtp-Source: AGHT+IHXNlBbd6gYVlOBw5+pXxlFEfCMzHMMIv2J+5HfB1KBbUeBaMXka5h2c/MvMScNgCf7AetpHw==
X-Received: by 2002:a17:902:eccc:b0:215:a56f:1e50 with SMTP id d9443c01a7336-21779e4474emr12393385ad.8.1733880820409;
        Tue, 10 Dec 2024 17:33:40 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-216150886e7sm77995765ad.282.2024.12.10.17.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 17:33:39 -0800 (PST)
Date: Wed, 11 Dec 2024 01:33:33 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, mkubecek@suse.cz,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@idosch.org>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net 1/5] net, team, bonding: Add netdev_base_features
 helper
Message-ID: <Z1jr7Vl4O7iEu0A0@fedora>
References: <20241210141245.327886-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210141245.327886-1-daniel@iogearbox.net>

On Tue, Dec 10, 2024 at 03:12:41PM +0100, Daniel Borkmann wrote:
> Both bonding and team driver have logic to derive the base feature
> flags before iterating over their slave devices to refine the set
> via netdev_increment_features().
> 
> Add a small helper netdev_base_features() so this can be reused
> instead of having it open-coded multiple times.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Ido Schimmel <idosch@idosch.org>
> Cc: Jiri Pirko <jiri@nvidia.com>
> ---
>  drivers/net/bonding/bond_main.c | 4 +---
>  drivers/net/team/team_core.c    | 3 +--
>  include/linux/netdev_features.h | 7 +++++++
>  3 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 49dd4fe195e5..42c835c60cd8 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -1520,9 +1520,7 @@ static netdev_features_t bond_fix_features(struct net_device *dev,
>  	struct slave *slave;
>  
>  	mask = features;
> -
> -	features &= ~NETIF_F_ONE_FOR_ALL;
> -	features |= NETIF_F_ALL_FOR_ALL;
> +	features = netdev_base_features(features);
>  
>  	bond_for_each_slave(bond, slave, iter) {
>  		features = netdev_increment_features(features,
> diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
> index a1b27b69f010..1df062c67640 100644
> --- a/drivers/net/team/team_core.c
> +++ b/drivers/net/team/team_core.c
> @@ -2011,8 +2011,7 @@ static netdev_features_t team_fix_features(struct net_device *dev,
>  	netdev_features_t mask;
>  
>  	mask = features;
> -	features &= ~NETIF_F_ONE_FOR_ALL;
> -	features |= NETIF_F_ALL_FOR_ALL;
> +	features = netdev_base_features(features);
>  
>  	rcu_read_lock();
>  	list_for_each_entry_rcu(port, &team->port_list, list) {
> diff --git a/include/linux/netdev_features.h b/include/linux/netdev_features.h
> index 66e7d26b70a4..11be70a7929f 100644
> --- a/include/linux/netdev_features.h
> +++ b/include/linux/netdev_features.h
> @@ -253,4 +253,11 @@ static inline int find_next_netdev_feature(u64 feature, unsigned long start)
>  				 NETIF_F_GSO_UDP_TUNNEL |		\
>  				 NETIF_F_GSO_UDP_TUNNEL_CSUM)
>  
> +static inline netdev_features_t netdev_base_features(netdev_features_t features)
> +{
> +	features &= ~NETIF_F_ONE_FOR_ALL;
> +	features |= NETIF_F_ALL_FOR_ALL;
> +	return features;
> +}
> +
>  #endif	/* _LINUX_NETDEV_FEATURES_H */
> -- 
> 2.43.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

