Return-Path: <bpf+bounces-62831-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2A4AFF322
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 22:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFD031BC6A0B
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 20:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6375624678A;
	Wed,  9 Jul 2025 20:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="darP9BSv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCC92459F8;
	Wed,  9 Jul 2025 20:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752093467; cv=none; b=AiUmRTr08JzSvM5o8PRF0j11MB3iqUV3gtSXNuENSG2ipBEJqHIz0csL9VliUx3y2NndPizjAZt2Oi+hjcoVcjx+OeS69xQrJZpPpiwjCxAtyk2qoJZqdXPhjXxpgHRRNLrY5F1J5CiRMW3SPLT2NBSKnk5jtNwgMD0jVpujxcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752093467; c=relaxed/simple;
	bh=FhBAQJsQxZeGPyRJGtl96KIDtVR+LyUU4HpDhMUyEM0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CyUu+5JfjhoxuACwWxPt+XOw4/p3vmFNKoD1QavJSKT9oJwfVYSKEXB3+e7WOIj0tuqnosCPqlZsLjk5nkQd5A1Zke3siJ6y90U+JqZgbHjGZ4RzWXVHCx84web1MRCnIr2CFSCOVPFQQhmtATJ8+bZyFe1Sdr+bHF9v3Qlh0Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=darP9BSv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3099C4CEEF;
	Wed,  9 Jul 2025 20:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752093466;
	bh=FhBAQJsQxZeGPyRJGtl96KIDtVR+LyUU4HpDhMUyEM0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=darP9BSvYoLyMOQeMBEYEvdbj5aZ1oSb+Rlhkc1Dan2c5QJXGYXvalbTzzRvqphD9
	 Ufe+c2CyIIBLr8GA6TZeUYGEu82WsRhtEgys1eoIXvY8JpJSd+0v0C8e+NF3fDx4EM
	 mxk/ybl/QWvj/l3ZfgQlGBbAZOU+rBXFthsbnEDep8d2WhgKiZN8r3z3StXSyg3K7g
	 +UG3w+4D57tnb2g4DWAnRTtYTvkfu1MN2phFv/7iAFu9Ww1AtlEg9CWVCGXmv39vqu
	 PlP9iEEiqPxpAgGYbft9eT6pIuYEuQiJxKceMyyaosxmyMcRKUwoAfiPjVyFaE9x+h
	 FWoYYZyDvt+vw==
Date: Wed, 9 Jul 2025 13:37:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, shuah@kernel.org, horms@kernel.org,
 cratiu@nvidia.com, noren@nvidia.com, cjubran@nvidia.com, mbloch@nvidia.com,
 jdamato@fastly.com, gal@nvidia.com, sdf@fomichev.me, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 2/5] selftests: drv-net: Test XDP_PASS/DROP
 support
Message-ID: <20250709133745.2a8ddfb8@kernel.org>
In-Reply-To: <20250709173707.3177206-3-mohsin.bashr@gmail.com>
References: <20250709173707.3177206-1-mohsin.bashr@gmail.com>
	<20250709173707.3177206-3-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Jul 2025 10:37:04 -0700 Mohsin Bashir wrote:
> +#include <xdp/xdp_helpers.h>
> +#include <xdp/prog_dispatcher.h>

Hm, you don't appear to use these headers and they require installing
libxdp-devel (which is not universally packaged, sadly). Could you
remove? Also these headers are reportedly unused:

#include <linux/tcp.h>
#include <linux/bpf_common.h>
-- 
pw-bot: cr

