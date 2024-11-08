Return-Path: <bpf+bounces-44362-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6FF9C220E
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 17:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB75B1C21303
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2024 16:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAC4192D7C;
	Fri,  8 Nov 2024 16:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2hndtek"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4E4208C4;
	Fri,  8 Nov 2024 16:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731083263; cv=none; b=Vdmhj7wsBHWnoKp2O4EdmAxJPHC0zBOA5aPhNaBSG/YsftjwFxYtDKGPp/8+A226KvgPIMD7lm+wNxl4NPSEsyTBhk4QUV+h/fbF2bLxCagcWCfF4zQauAPxVYsH4Byk1im+sltDH489aub+SbXRtQW7gBZqs1jxBVL69DyTO5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731083263; c=relaxed/simple;
	bh=uWvqX+QHXO1h/vBvY5VkQEqGJ05LmF4d5/0xZHY92KM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KUghq8jacWgFf/GKKCUfhMY8w4FrnjqJuN0GC+F5iCqT11mT4Phksp2gL9TuprFqG9KA3f8K/CuTPMncPeXomiEPdfcepbq5S6jzzSLVuynbUVRbefikq2x1ukdee9rYZm911SinK+iIQHp1tTI/vUITeoRg5c0vCgj6FDYcUhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2hndtek; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D25CC4CECD;
	Fri,  8 Nov 2024 16:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731083262;
	bh=uWvqX+QHXO1h/vBvY5VkQEqGJ05LmF4d5/0xZHY92KM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e2hndtek9jvQJfjIfOuOchIl4ZEU038mmF/jBJRgaTGwybblIY1wwqiR1XXB2MS7J
	 kMlS80G5phOtWWjQvJQ4vB/NVjc6YzFHRIRfy8hj6pfzVclNVjpTkgNufMPC1bCPgq
	 qRf37Sz6NLVw4mCVSOujA9y/VhRc3XkPOu7l9h+Fa8Hvad5J3fu0raz+b6WFohs6HJ
	 opbrKnxcSj6iLYlmygBTziyhkf97xztSoMK6NQ6oodDdp2j5QYJMmofhewicIY8F9C
	 68apl84lqYvD0Jp6DGnK9I2P1fvXJ4ysWdEpY8jA8IgNNZ9DrNQUkX4nJKjliPsiU8
	 lYj33llRhG3Ww==
Date: Fri, 8 Nov 2024 08:27:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Toke
 =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John
 Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Magnus Karlsson <magnus.karlsson@intel.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 00/19] xdp: a fistful of generic changes
 (+libeth_xdp)
Message-ID: <20241108082741.43bf10e7@kernel.org>
In-Reply-To: <20241107161026.2903044-1-aleksander.lobakin@intel.com>
References: <20241107161026.2903044-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 Nov 2024 17:10:07 +0100 Alexander Lobakin wrote:
> XDP for idpf is currently 5 chapters:
> * convert Rx to libeth;
> * convert Tx and stats to libeth;
> * generic XDP and XSk code changes (this);
> * actual XDP for idpf via libeth_xdp;
> * XSk for idpf (^).

include/net/libeth/xsk.h:93:2-3: Unneeded semicolon
include/net/libeth/xdp.h:660:2-3: Unneeded semicolon
include/net/libeth/xdp.h:957:2-3: Unneeded semicolon

:(

