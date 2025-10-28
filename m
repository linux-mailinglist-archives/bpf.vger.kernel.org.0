Return-Path: <bpf+bounces-72648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E232C1743A
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 00:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C5A0188EC6C
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 23:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB56C355810;
	Tue, 28 Oct 2025 23:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIdDZmyJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFF9226D00;
	Tue, 28 Oct 2025 23:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761692468; cv=none; b=mgGXsTLYq/N1Wbpot7uUpoGnaSFljeFcVORKv56/BuUnw0B0KoREcijW7KPypxtUO2+9jr6tb6fnJXmRQz55pRQ20VHxZ5KcBHCCsFcNeDqPy7gj+j1ul+lJTpBQCIbR51IleumhaCl7UQUo3BNfW1nwiGkn3yzaNzSoTiNas7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761692468; c=relaxed/simple;
	bh=FaaO/U8ks8JbiSUKHoN4+iFu4ESdUEig964Hq+IAu1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A9uwEH0Qn7iTVZn8khmkqk/FJ/rhS6NxonXzvNQDn1a8jxeQ2/N9Y6uMJZRTFYFlsHUtTeMg5YKnDC4OD/YpX4qbVOvNqSD+B+f9RWRh/AVp33gSwUMK91HGBjiwgSiK0wYUyyiLu4cb5IKGvEu5ko0g730bic40tLtvWC9Hk+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIdDZmyJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8835C4CEE7;
	Tue, 28 Oct 2025 23:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761692468;
	bh=FaaO/U8ks8JbiSUKHoN4+iFu4ESdUEig964Hq+IAu1Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UIdDZmyJqmQ0fWHU4KLp2zdtgehE7cpjYc5E3zBWrPmENoDphd+b+9pdJ45rDpPxJ
	 /Z7WtxTTG9IOzdCFf89OewhazEMjPswOqhHoNZjy8taN/JPTXa9MMkVypymRDuesI2
	 evRDYmAAWOGK+FWHd00J3JgRJk4NJznonpP5y+f+kS6yTED7cH2ak54/RTajJY8r3/
	 21ShqQ0GDnET5xB985gp5aJwZ2dV9XWbwyBP22EHL/3scB3OwAsuPKOMe0T9exRvqe
	 x3wA6LDFRYsovx40KCFU3S92CdMbjCJCwCFV2rB27LEnscnnd1hpo5NvUfKPDuOVvV
	 I+5QcwQneTP8A==
Date: Tue, 28 Oct 2025 16:01:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, sdf@fomichev.me, kerneljasonxing@gmail.com,
 fw@strlen.de
Subject: Re: [PATCH 2/2 bpf v2] xsk: avoid data corruption on cq descriptor
 number
Message-ID: <20251028160107.5c161a4f@kernel.org>
In-Reply-To: <20251028183032.5350-2-fmancera@suse.de>
References: <20251028183032.5350-1-fmancera@suse.de>
	<20251028183032.5350-2-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Oct 2025 19:30:32 +0100 Fernando Fernandez Mancera wrote:
> Since commit 30f241fcf52a ("xsk: Fix immature cq descriptor
> production"), the descriptor number is stored in skb control block and
> xsk_cq_submit_addr_locked() relies on it to put the umem addrs onto
> pool's completion queue.

Looking at the past discussion it sounds like you want to optimize 
the single descriptor case? Can you not use a magic pointer for that?

	#define XSK_DESTRUCT_SINGLE_BUF	(void *)1
	destructor_arg = XSK_DESTRUCT_SINGLE_BUF

Let's target this fix at net, please, I think the complexity here is
all in skbs paths.

