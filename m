Return-Path: <bpf+bounces-46606-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABA29EC8CF
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 10:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F6342821DD
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 09:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA98D2336B6;
	Wed, 11 Dec 2024 09:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hh845d2X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5872336A4;
	Wed, 11 Dec 2024 09:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733908773; cv=none; b=M/itW2MWtUlGkco3nLAQrKZE3aj1m3wJ1Lr2OJrLrVUegaeUhaNxqGKc/QKdmFP3T+U6cpti5EfnDDR5c8bQRGiq+vHurwRA7y8qwsSci9fv0z3Jh5rE3h+NldM7YbTqH7w4oMWBVtq5uakCnFNKBqvXzivSI0cbFI3nyso5B1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733908773; c=relaxed/simple;
	bh=I2imVR2zHB3cwUvWNAPPWQ77dUp14fBwDwpll13IlvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSwpcbf4Kp67p6Q/bSWcelr7fcH9ynjnSTwT8Trjss8/xwYMUE7r7Lq63oG71/IKPlXMy9MHTeYSsih1robotGFR4ag7CYcY9DTP9Mk6FNs0qLlzcPPqT/CvUQzt8LgoucHXDyh/C11Za3wN72kLNC2Kq4FRLySRO+eQGJLiyhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hh845d2X; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7ea8de14848so4127046a12.2;
        Wed, 11 Dec 2024 01:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733908771; x=1734513571; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WvFJObj6VzxwwOpWqlxQAPvCXG9emn46k7TQI26p620=;
        b=hh845d2XutVPK6mHIqbU6k8eHrdLICL/+VjuSExuWweb2zoBKUUZfjuzrJ7Pq2GbVa
         zB670tQlpqHZfftTMsJYm8IIhtdOb3o5tOLtqkngMxOaXlN5lQZaFFjYw40DZZ0go/9g
         /Vy+PplQT5aOeB4//BYYNbf6ZI4Q2TdSzOG8kdBYq9hG6KUYvLQk5EzKjNNKEb9jyrUb
         6qih8vtEcIKLt1BQFxcf/SG0MwS2zS7gELrKSWcWNIghEwFw4UmN31mbqaMztPg0wpTL
         y9gO3BuGH0ozN8LhhYbxnsFZ2EyN4+kqKENXDWAEVDvrZxVUJATI7TXh8mJlmV75j3g/
         vyvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733908771; x=1734513571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WvFJObj6VzxwwOpWqlxQAPvCXG9emn46k7TQI26p620=;
        b=LsoqX06dbBcCFKnrxRS1sOdzUhYp9LcmxhYqatk6DztRt2xBB+Aphotz3Joovcl8WS
         jDein1i2NATsUtYcmplBAx3mvxxOFxBJTfVG9ZFV4TMPL0/MFNG5L4BZE7c/aBns0K6d
         twjvqxZVxKhljmQio7MBjccTEpxXquifNQu2qTDeRusA3bYoaMEDYe0etJqMqDvIb1h8
         CyDU1EcSQwF/9+l2Sm/BXcMYJlloVqHOjsoCgsLG4Z9DeXRxAxJwCqOYkHCdFaUqadZu
         n2JiISi+XuPo7HFOX7f8+VbFmH8i7hq7NL9+yClMDXqGGOh/0eeBmfkeZ3NLqZ7jnkV2
         8riA==
X-Forwarded-Encrypted: i=1; AJvYcCUwi6REzsBO6CSnOPRmHt3vUhkRX5PKD4Y+oulBwceJevfDAdHsCxfaW/ZJKoTarLwbgPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAflRAXIq0+P++nzWK+95Qkosk90GIUR+JVfR0XQ2852/OgnM3
	7Q1Ty6hag1nLFlSnLJWfIN0H1zBTN2wHMFOPBbo5aT3UzFawJxZN
X-Gm-Gg: ASbGncugFE798zR20KVpjqPQTErG6u7kynSuwsJeevXw8q35xPCUc+Jt6mjtvdqqcD1
	e5+2QByUy5xc3RCJdHNfojwsAUiC+cOFJzeC6/4PJZ+87iG7G/ALSxyP+DHdtUNgiPDgvSaosay
	SQtShiKqeQxIz6U1d3WkCcgM7fCfAm4lq3WufAPFq+YRJah6Yc7r0U+ckN/EuPLXsqPzg9oo0gx
	MyP0XhoIa7HrRN1Yv7tRhPOk5gKXsySlO0AHaeWr8+vOlrrr6otQWWevw4=
X-Google-Smtp-Source: AGHT+IGD0DS57z0pB6zcYbM7P+73ymPs1qfMtYE9PeYUkgknMob/qhWLKJ7AyMz/jGy6LgtpuGO1gg==
X-Received: by 2002:a17:90b:3812:b0:2ee:8430:b831 with SMTP id 98e67ed59e1d1-2f127f5507amr3237674a91.2.1733908771153;
        Wed, 11 Dec 2024 01:19:31 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef7fbec303sm7808394a91.3.2024.12.11.01.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 01:19:30 -0800 (PST)
Date: Wed, 11 Dec 2024 09:19:25 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, mkubecek@suse.cz,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@idosch.org>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net 5/5] team: Fix feature propagation of
 NETIF_F_GSO_ENCAP_ALL
Message-ID: <Z1lZHcP9KhoHkRS2@fedora>
References: <20241210141245.327886-1-daniel@iogearbox.net>
 <20241210141245.327886-5-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210141245.327886-5-daniel@iogearbox.net>

On Tue, Dec 10, 2024 at 03:12:45PM +0100, Daniel Borkmann wrote:
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
> -- 
> 2.43.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

