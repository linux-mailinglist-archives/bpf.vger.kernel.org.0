Return-Path: <bpf+bounces-46603-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C989EC87F
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 10:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A86B81648B6
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 09:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B056E2210D2;
	Wed, 11 Dec 2024 09:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llCT5XEs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC45C2210C0;
	Wed, 11 Dec 2024 09:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733908209; cv=none; b=BBkjlaXbvW+1E+S98CJ7hhOSHpsz+se66y5XGCWXpEXrgIGEu5RwFA495e8UNip45epfiXyRJLjwJn/xF/0YyKbSas0mCN8NCTa2jF0Oa/AUvMr4Z0E+n4vzbk8VbVEt1o8EHlnWsZn8kQ/3beM5GZ/h63lDe8QcjV/917a6YxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733908209; c=relaxed/simple;
	bh=lnLjvSQoyITD4fyiygfWRicJaqtlbsesWonfZxvC0/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rfx6Vn22jtOTrQc/LtA7l9zedbqok/BEtxhoqo+keKxiI9JUfrwcfhgJFULPDC4vzHbS4i/BrKbMiez2epwIG4MuHvjOdEfd1oqAiWLOIcmJZsUgZP8fl/rv8ZzN2nHR5sNTBR8Zz0rQb8g+ddv8qa0JRg8uhBoupLIBe+0wUNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llCT5XEs; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-728eedfca37so415887b3a.2;
        Wed, 11 Dec 2024 01:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733908207; x=1734513007; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=95VNZTlSV0GmtcT1rkj1rSMJXseSIfnM0Z5wuTWOkUo=;
        b=llCT5XEsgGfpqjIw3mKSgJyBWMuEQJuCuEmWaHI52t51ur0AZqxvIuxRflM9WdRkOj
         bMaGClz+ol1IeVzNsy7APzsdxHGPLVXEkvVx4UJgkEsglxD3ja++VkHhrmXMCl6MZJO5
         EvlT1mdAflijZaU0XJYIQtKGt9c9le03wE+N7jbHsGHHy4dEk29vHJ2IE2T6TV2CnTVh
         9uG8aYsR6Grewp3Jlvh5pyJGUj8KYB5GUXUI58fgbs6FpRELs7oT4wr/thrpvtaanpzM
         cC5mATxV6pbZsqFJ+OrK8vr8jIc+vb6mf2GtS2g+ItybfWimm4aZo4d59ny+mPzRvGuP
         Mg+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733908207; x=1734513007;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=95VNZTlSV0GmtcT1rkj1rSMJXseSIfnM0Z5wuTWOkUo=;
        b=wJBb/eeSwhCEZs5IYmt3BKaeDPqpFNVEGO6oaOBeiEqFTUyEwMKcf+Mlz6ERdfCC0U
         9e7dzhZp0C0vwSbfjhmmuWuqP1+eo7g72MzznYhEeJwGdFi9PxqlojANFUomBIe4HwXo
         KuAsKOPhyOZEzviMOWssPGMwTyu/Fc8yA7TH2vuLqNWWdp4id/rF5gmFscaX9pjuLNA5
         Y/q6BmKsiDoG8IKhuOKaRASO8+ImnsHWXHslyTMCOg5l0VrdjUocRRsoRh1+0lNODkYg
         YCes6pFUu5axolz7LhewuSZ0ozNGMiKj3l4D36SQnulxDhSHdE6MO/qkKbtzW7ILlYdK
         bxaA==
X-Forwarded-Encrypted: i=1; AJvYcCU1Hxvo4G5AFYRW31pDfN90X6wbLMvo1mSuAxE/ve4RIpmb24SZ7p9Pr7T+I/gUJovi/1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOhlgudl4/F64ZA/GjxXvYuV5Pp0Q89AAdWEMNvbv4qQNCa1Xu
	wJ++G8kCHFl4MDocdvQAVvLvqnzbGxYjDnXSXg3Rh6plRXVnxjKbnYl4YJR1
X-Gm-Gg: ASbGncupb4srjPCU27fMdUF91DRl6cXd+S6FSQ9qoruxYL59ZvUXNerMUhi853KvmPK
	jM2iGJ17t/cWGv/+MGEcyg8UetLr2Uhyz8G9h1oEY9zlxIB9DMJPns/lV4NOma6lu7hRFh0OcKv
	fLYwdaEp6vrEdZ/UwJCWgiIXxsIkJNpI1mwWmSj7JeYl9LaVzq+QO7SRgC6jp3LPHiwxWvl9l51
	SAo8CvaYD17/qhr7Q/eAf8EDA+jclEziUmG1GA2LOK1CG2WCD7n2dnrYDc=
X-Google-Smtp-Source: AGHT+IFW6Naz+OTWa/PYPIVfYv/UxUumZZr6ce4hkxERUdlxOtW0YvjX8sA1l02cG6NHn2APItX04g==
X-Received: by 2002:a05:6a20:7fa2:b0:1e1:bee3:50ea with SMTP id adf61e73a8af0-1e1c12834d8mr4241911637.11.1733908207197;
        Wed, 11 Dec 2024 01:10:07 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd430cec7bsm5868062a12.67.2024.12.11.01.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 01:10:06 -0800 (PST)
Date: Wed, 11 Dec 2024 09:10:01 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, mkubecek@suse.cz,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@idosch.org>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net 4/5] team: Fix initial vlan_feature set in
 __team_compute_features
Message-ID: <Z1lW6R0yhxxvYdrz@fedora>
References: <20241210141245.327886-1-daniel@iogearbox.net>
 <20241210141245.327886-4-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210141245.327886-4-daniel@iogearbox.net>

On Tue, Dec 10, 2024 at 03:12:44PM +0100, Daniel Borkmann wrote:
> Similarly as with bonding, fix the calculation of vlan_features to reuse
> netdev_base_features() in order derive the set in the same way as
> ndo_fix_features before iterating through the slave devices to refine the
> feature set.
> 
> Fixes: 3625920b62c3 ("teaming: fix vlan_features computing")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Ido Schimmel <idosch@idosch.org>
> Cc: Jiri Pirko <jiri@nvidia.com>
> ---
>  drivers/net/team/team_core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
> index 1df062c67640..306416fc1db0 100644
> --- a/drivers/net/team/team_core.c
> +++ b/drivers/net/team/team_core.c
> @@ -991,13 +991,14 @@ static void team_port_disable(struct team *team,
>  static void __team_compute_features(struct team *team)
>  {
>  	struct team_port *port;
> -	netdev_features_t vlan_features = TEAM_VLAN_FEATURES &
> -					  NETIF_F_ALL_FOR_ALL;
> +	netdev_features_t vlan_features = TEAM_VLAN_FEATURES;
>  	netdev_features_t enc_features  = TEAM_ENC_FEATURES;
>  	unsigned short max_hard_header_len = ETH_HLEN;
>  	unsigned int dst_release_flag = IFF_XMIT_DST_RELEASE |
>  					IFF_XMIT_DST_RELEASE_PERM;
>  
> +	vlan_features = netdev_base_features(vlan_features);
> +
>  	rcu_read_lock();
>  	list_for_each_entry_rcu(port, &team->port_list, list) {
>  		vlan_features = netdev_increment_features(vlan_features,
> -- 
> 2.43.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

