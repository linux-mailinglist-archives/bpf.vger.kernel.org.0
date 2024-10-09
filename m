Return-Path: <bpf+bounces-41377-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7689965A9
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 11:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 847021F2263B
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 09:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FDC18B48B;
	Wed,  9 Oct 2024 09:40:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DC0817;
	Wed,  9 Oct 2024 09:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728466800; cv=none; b=jbbJDFHqrqxUsDWhxnPARf/iqPOxE2gi1YRFMmvvGnF4vw/jQ7nqYchUSFdN7mm1uKaZ0DyNo3sushpionuUakZ6IIH2hGDcoc0lLsPqMzsfXOU0EgapGvuJqxDjaPYlMo01H186yjdQjJ810YkaNwbD2lca12aM0B2Ra5tPWGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728466800; c=relaxed/simple;
	bh=f5m5XNYlzeu/Vrbj4WqB2ACnZwBMTiPZMWd1USbuw00=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jYiMaJEA1okTa1P/mdJFFxBxT0qpsNyoJZQCqQKlPxfSsNbht+ZYvMgCfiQhUKLdzAIhQlF0NnJUgTolbE/jTGLe9/ELBZosvFbefqRmMeYc7M8mzd103Inl7j5aFQ6E4HL9WkOPJKTN9dVt4QOnTVpPLtzK1En7aXxT3GR9Jm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [78.30.37.63] (port=50364 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1syTAe-00AfKI-CX; Wed, 09 Oct 2024 11:39:54 +0200
Date: Wed, 9 Oct 2024 11:39:51 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netfilter-devel@vger.kernel.org, netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: kmemleak in flowtable xdp
Message-ID: <ZwZPZ_xguhEchEv0@calendula>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Score: -1.8 (-)

Hi Lorenzo,

kmemleak is not happy here when running tests:

    [<00000000be65a589>] __kmalloc_cache_noprof+0x280/0x310
    [<00000000c6569ad4>] nf_flow_offload_xdp_setup+0x70/0x8d0 [nf_flow_table]
    [<000000001efe6e35>] nf_flow_table_offload_setup+0x324/0x610 [nf_flow_table]
    [<000000005d9c9ad6>] nft_register_flowtable_net_hooks+0x3f4/0x890 [nf_tables]
    [<00000000de9071ee>] nf_tables_newflowtable+0xf61/0x18c0 [nf_tables]
    [<00000000924f5d86>] nfnetlink_rcv_batch+0x12c1/0x1c50 [nfnetlink]
    [<000000003fa07104>] nfnetlink_rcv+0x2a3/0x320 [nfnetlink]
    [<000000009fd1c990>] netlink_unicast+0x588/0x7f0
    [<00000000ee126795>] netlink_sendmsg+0x702/0xba0
    [<000000000ddf29fb>] ____sys_sendmsg+0x7cd/0x9a0
    [<0000000027b80416>] ___sys_sendmsg+0xd6/0x140
    [<00000000edfe1eb5>] __sys_sendmsg+0xba/0x150
    [<000000009d5eb571>] do_syscall_64+0x47/0x110
    [<0000000077c3a21e>] entry_SYSCALL_64_after_hwframe+0x76/0x7e

nf_flow_offload_xdp_setup+0x70

56
57              ft_elem = kzalloc(sizeof(*ft_elem), GFP_KERNEL_ACCOUNT);
58              if (!ft_elem)
59                      return -ENOMEM;
60
61              ft_elem->ft = ft; <--- HERE
62
63              mutex_lock(&nf_xdp_hashtable_lock);
64
65              hash_for_each_possible(nf_xdp_hashtable,

Thanks.

