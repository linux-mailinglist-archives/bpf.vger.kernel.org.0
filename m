Return-Path: <bpf+bounces-65454-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E71E0B23A34
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 22:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 338DB1AA7612
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 20:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53002D0639;
	Tue, 12 Aug 2025 20:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ry0arDUx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262C41E5B7A;
	Tue, 12 Aug 2025 20:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755031754; cv=none; b=p6iTk4sCQsK/cWjZkB4CrlgV8MUBH0DZLs5I8WASwm/utQYFHoxijcqJyX0Xx6+EwBaLkF8kSdl6IH0ZP1qXeipZwslsjNTCU10CjvDxqc8P66GzbbYv0jikWEK1dc86D9UruzA95kX2ZiLQ2K6aTinME7NoYGkN8moACdxrzro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755031754; c=relaxed/simple;
	bh=7CF1FVLpGJHb03LymcmzOUUnSoGfzaAyfdlsBPYu54E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=erYOrmhI+Nry7CMaWmFufgf0fS1h+ILWoZ20DDp6ONWkHrwkwOhXt6rPo3huKBnaMC1VtdGpuVkGCeLYrgLaiZghEmoztCn3Ny9yWM0vo8Mw3ehj6d8L2nJ2svetGjmtZzaFH3w2b5E7OCaC2eYoWU0HACRt8iWfuB+tRyDuTIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ry0arDUx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DFBEC4CEF0;
	Tue, 12 Aug 2025 20:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755031753;
	bh=7CF1FVLpGJHb03LymcmzOUUnSoGfzaAyfdlsBPYu54E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ry0arDUxmBTdQhp2BXXKIDsVRH3AI1VMVM8FqryNb8cST8NutZZ1mVNlVxdq393qW
	 FSn8LP0IylTi7ZO1qoE8FQJcrjla9p+BSKC3FdZLzIJXUWx2Q5oE6AsR2qbT+bGANN
	 pS+u3ZkzRrnCsppjxDSWyzn9L9gLNkZbdkwDPQboBkX2cB2AAq0FhWtsSkg051tegL
	 KwUJ4+9ZR+/tSx5+NDQadkWKVlWtdigFhCMqaok8KrjSnvX4QWrit2m2f5gdYmCCcy
	 KHU9lI+81jM+TyizkqAPbj27dZHJLFvHvMAemnCAqHf8/CBnmOHfaQA9mo8PxHSR9U
	 a3JwDx4HLXVjQ==
Date: Tue, 12 Aug 2025 13:49:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
 <sdf@fomichev.me>, intel-wired-lan@lists.osuosl.org (moderated list:INTEL
 ETHERNET DRIVERS), netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
 linux-kernel@vger.kernel.org (open list), bpf@vger.kernel.org (open
 list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_))
Subject: Re: [PATCH 1/5] ethtool: use vmalloc_array() to simplify code
Message-ID: <20250812134912.6c79845e@kernel.org>
In-Reply-To: <20250812133226.258318-2-rongqianfeng@vivo.com>
References: <20250812133226.258318-1-rongqianfeng@vivo.com>
	<20250812133226.258318-2-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Aug 2025 21:32:14 +0800 Qianfeng Rong wrote:
> Subject: [PATCH 1/5] ethtool: use vmalloc_array() to simplify code

ethtool:

would make sense for patches which touch net/ethtool.
Please use 

	eth: intel:

as the subject prefix.

