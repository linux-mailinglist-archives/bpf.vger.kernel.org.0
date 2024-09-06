Return-Path: <bpf+bounces-39119-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0A996F339
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 13:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CDE1B24164
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 11:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B311CB33E;
	Fri,  6 Sep 2024 11:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JNvEDg2O"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2D61CB31E
	for <bpf@vger.kernel.org>; Fri,  6 Sep 2024 11:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725622724; cv=none; b=jR2cvebyr74zbds/I4wPAcyUXZDbjs6gFX2OQT7JaIjIH4ToYhizr1yzGy3jK6jT8k6GTUysoG+1TxooQvD+oHEAcoeQQJHEVGsUQ3qqRC8VMnOcCaFXez3boQAXH5UJT9lTd/j3GGnCCwy+OVCL7I3uZrZymoWe2pVsQy9udIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725622724; c=relaxed/simple;
	bh=3OSEMPeLSNHVCNVbKv7RAO1iD4GGzvlj38LVpMDyE9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C66ou09/g9vPEjb6rYVkX6VEJ1A8AuuaB/RMUlPbrnCNgfwFHdu/B/wTu0i1iS7IG1bclTMBBiHynYAvgKhs01TjERK85dmuusKK+VPnb4fw1M+YyMLOiHnQe0iPWtJP7KFXjTkc3mNVHqcAltzi03Rp4FXl9IPX5Ewipf5g85k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JNvEDg2O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725622721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3OSEMPeLSNHVCNVbKv7RAO1iD4GGzvlj38LVpMDyE9k=;
	b=JNvEDg2OAKAtaRGouESzx3GBBJS5P/Fx2scwr76pPS7hFqMqBGg5t6K/uspFdmv60XTEVA
	Gyk+zIsi24NCZtkcNTZMLQ1HE70nABXUBGMy7adcTDwUn8CoY5SGD7hO0hIUPGzyZN4Rb1
	pzgRc2ZCF9+yEpGwB2ooAdi/w4JqFFw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-vFBlFpdIPJGndhbMXU1yRA-1; Fri, 06 Sep 2024 07:38:40 -0400
X-MC-Unique: vFBlFpdIPJGndhbMXU1yRA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42bb68e1706so15394145e9.3
        for <bpf@vger.kernel.org>; Fri, 06 Sep 2024 04:38:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725622719; x=1726227519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OSEMPeLSNHVCNVbKv7RAO1iD4GGzvlj38LVpMDyE9k=;
        b=lsAZcBxZyT9el3VlgKlfieU89Mf9Jc5dg+S27U3hWKj6haH0jjpBx+FaX2Xwb6m+dj
         8BMZKicdu1c1aYivqKIvcvxqCD5XufPTbdukBXh1R/nJTUJRUaZTSst46GSmHCXMwhH7
         VNfzkqUX0e7IGA2SmNw1CIcZ8DRjJzJihxOoLPVTkXpwS1b0QdSTSHt5T/aqToiLyYbd
         2Me57uE6rsfkt/BQsMDekmO/1RhYM7iwGQjcUwB6M2/kLKn5Uab6GSEhcfsdwyzOCf0A
         yxYV1F2zjTjLcVNIq2+lP6RhDpGrUcIO9t2FqtEl8oPJAGaeUrv6ox5GuWWNZ3KZypHg
         zjcA==
X-Forwarded-Encrypted: i=1; AJvYcCUxKLXjgfmIa/kCIq8D/4PyGbkck+6eF+ZhTfv4RVB2D/AM3MyObZOSbDSA7Yoo3nTDSRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyoM7W20eHO5bW2JpKjJt24TlzR6R3jIuLxcddWsc72dGkdopL
	mb1cQwN6U2uIotMLhwZSui4YvpMgL8rzsD+Pu7x5Xji2pFaPjWXNa2BeRr2ijYdvz6qSrrDA0oh
	aLRqSRP1lQB3ZTqJsyoPrsYtM+Etg4czQ0viwnUt1sOqvI15/Jg==
X-Received: by 2002:a05:600c:1c1b:b0:426:641f:25e2 with SMTP id 5b1f17b1804b1-42c9f9d7035mr18302885e9.25.1725622719306;
        Fri, 06 Sep 2024 04:38:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuAsg7pwxpDVtdYJ/6+D+Ph/FNa76MdgLyOilEwQ/89LMv1D0nMU3M5+amZnhf14vF76nDJg==
X-Received: by 2002:a05:600c:1c1b:b0:426:641f:25e2 with SMTP id 5b1f17b1804b1-42c9f9d7035mr18302555e9.25.1725622718460;
        Fri, 06 Sep 2024 04:38:38 -0700 (PDT)
Received: from debian (2a01cb058d23d6009996916de7ed7c62.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:9996:916d:e7ed:7c62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca05cc3dbsm17708455e9.20.2024.09.06.04.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 04:38:38 -0700 (PDT)
Date: Fri, 6 Sep 2024 13:38:36 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	razor@blackwall.org, pablo@netfilter.org, kadlec@netfilter.org,
	marcelo.leitner@gmail.com, lucien.xin@gmail.com,
	bridge@lists.linux.dev, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-sctp@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 08/12] ipv4: netfilter: Unmask upper DSCP bits
 in ip_route_me_harder()
Message-ID: <ZtrpvGliOjZzPkyv@debian>
References: <20240905165140.3105140-1-idosch@nvidia.com>
 <20240905165140.3105140-9-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905165140.3105140-9-idosch@nvidia.com>

On Thu, Sep 05, 2024 at 07:51:36PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when calling ip_route_output_key() so that in
> the future it could perform the FIB lookup according to the full DSCP
> value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


