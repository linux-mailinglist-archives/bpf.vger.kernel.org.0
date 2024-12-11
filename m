Return-Path: <bpf+bounces-46602-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 379A59EC879
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 10:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BF73163E2A
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 09:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2DD2210ED;
	Wed, 11 Dec 2024 09:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZo3c9wo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62AA2210C6;
	Wed, 11 Dec 2024 09:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733908172; cv=none; b=n+1lDzZ1SUQygIgXRXuh8Y9bcmOAEvEP4KcYSpCeMLJx9bK1bEsTsiONlWMgqBgHOM07R5Rw8Z+2LLH7vlSmEUvf4PybNzWE3xfnU12hD7tRjmEHgqc0dVMlq8al74gSGFiV2hXfGrnIgOLDSbqB0pNgxf6FwyLKUkhPnNm+zfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733908172; c=relaxed/simple;
	bh=xIaQXFskKCgp5A/NEx71Hx314rVTXuATxS4qKYmDeLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UIZUsmEvRoutquXUJ1rbPY5ps1eKHvrH5CEqjww90r87yhIcZxqDVSdIY/A3ycA2WHBJttFBG2tTvq1IHPLNfJjtonui2BI5mcTnfZT5BZ/FmIiBS5BmO+8hv2Y80YtX083H8OokRJf6TUQPARebqMiyncDqd4/yLhFuopV9vB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZo3c9wo; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-725e71a11f7so365134b3a.1;
        Wed, 11 Dec 2024 01:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733908170; x=1734512970; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1RMe/+7kIy4SbIRyalwwTZ03nL2wZipPR7y509ZPy4c=;
        b=JZo3c9wonO2bgSwY4c6GlK7Uq9T/5g0MisNZsqMbp93b244QwHIXnt6HYmfwh2qQMJ
         dkmOesRgp5DaCQK79vWDOqZVpBGCsH/5WiATiGafwJQiGvlThM3qM/ZSH6NQmrEgiPAY
         1yEV1R1WkNUeTCG7gurDbBIz/SCNvT+Lde9cv5IhYMoS+WL+ELbpOlsPQat80fvM4Cmd
         fccQlGPoYX8jmGdut7OkSGGsKTHq/cvra6611+wxzS0wD0kFbxbDO879P37hdMl/aR75
         PhP3Ua4Y41bRN/adfKMK+/beTITuKDqG5UE42Y775T/BOoL4glx6rFSTKguzfccLaB/j
         2Row==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733908170; x=1734512970;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1RMe/+7kIy4SbIRyalwwTZ03nL2wZipPR7y509ZPy4c=;
        b=haFvFTX4V8Rjjy/vrD2tnVIy0pXRqJyPGIEUNxG36jJj8sj4g+u0N0D4d6NwCcdsA1
         LjNC8zEbWa+/vBbzL795lXvgsEVCL5ke6ijeUaI+omCLxQVJTDe6praajcH/aOYy5DEK
         Kvr8SSAaRnhFOcZgMywAYpa37zIjzuJkisJK4o2umdEudX4apUL2DX8+eu9GCXqPwWvB
         i0EqQW/tNAhOPX7o+HfaTaotXeRvCUqIx8ULzs380t4h+J3V0h2BW+3A3JatNM4vRoyG
         bpeEm2/UGPq7rkXco6pAhfJ7+2ugiLD/QMwtGhr3Yg0V+Ec/GA6X5XlUMNskhjwLkVma
         VlEg==
X-Forwarded-Encrypted: i=1; AJvYcCVPzR6A3OTb2886XpDc0aBqghuXz4A5ltx9Cko4/izidA2tlCTErsYrBmmFxWGG5/76aCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YySTMl17Cc7BDiYpctNQyy0SWMu2JuaEKSwA4ty7zyE7FcsysuO
	3mX5gfhZ6fjHqeUuk+6HYwtua5svLXg4kTNSHEM1xPRbGLUzguTV
X-Gm-Gg: ASbGncsiaL1FaAcLO5im/MgCkNeHUoW7ai2CiiaRwfJ/jLgVlnf6zZlh2D/ublklqXv
	5+8lSDb6Xo0VnotUt/4isHA6y+aV+fkl6LDpOUP0Rsc3yxxOKhiXh+yldzbbkRZl8niDB1fPYCG
	xGlj65Prmfi7tr49Lgzs1LnThJIcZUiQzQIukBODwTMZTkzYH1OPFqgGJBZ4rO4NaNtpDLoPQy5
	wgKmehKV6nzj0RAUjkNvko8AqbZE/B7mQ9oD9/q/QTBT2h5zgJmRsLNsRw=
X-Google-Smtp-Source: AGHT+IHbBIG2jkSmgeOa0zNVx6HrbC60xE8IDHv2oBq3+JdwoA6FDnuCXUx8LX4D4UbLraJUB7ulLQ==
X-Received: by 2002:a05:6a00:1817:b0:725:e386:3c5b with SMTP id d2e1a72fcca58-728edb790bfmr3134095b3a.5.1733908170117;
        Wed, 11 Dec 2024 01:09:30 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-727ba09a13bsm3185774b3a.46.2024.12.11.01.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 01:09:29 -0800 (PST)
Date: Wed, 11 Dec 2024 09:09:23 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, mkubecek@suse.cz,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@idosch.org>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net 2/5] bonding: Fix initial {vlan,mpls}_feature set in
 bond_compute_features
Message-ID: <Z1lWw5qM-AGPCjuZ@fedora>
References: <20241210141245.327886-1-daniel@iogearbox.net>
 <20241210141245.327886-2-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210141245.327886-2-daniel@iogearbox.net>

On Tue, Dec 10, 2024 at 03:12:42PM +0100, Daniel Borkmann wrote:
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
> -- 
> 2.43.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

