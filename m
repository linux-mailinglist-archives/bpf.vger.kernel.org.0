Return-Path: <bpf+bounces-64936-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2070EB18931
	for <lists+bpf@lfdr.de>; Sat,  2 Aug 2025 00:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A65EFAA5F41
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 22:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B728E22F76E;
	Fri,  1 Aug 2025 22:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNonI/Ee"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347CB15A8;
	Fri,  1 Aug 2025 22:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754087425; cv=none; b=J7jZZqXlRrlfuqijcDOQ0QEA1DrP6r/U4EVKOtm5CV30NufQhW+iWeb875Me6mNwbpjglO1RZFczYVMEpEoVmBJtc+JZMHjQGWEIUc9yGeL/CaSwoqdozMsF0eilDP/iZLmRn/bJaGNxPRzXwZ19os0sXr9ZguXlWcKUF4qfrsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754087425; c=relaxed/simple;
	bh=tWrjYCv4Av71BXfLwIY5KSkGF90mEgoc4+EF2H4mUFU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tasnBaGUkaC8B4g4IJUh9t9Al5zL01sdKoJR7FwU6zjl+7fLMrmjoAxZqtot1TM3YMrUkzF8AGXXmB1y9PtsDwsX3wdCxURlhm1XHAxVraTswI99roF20F1XuOijikcMb8MkyvP9mcOM3TOf8kNBhVYyC4+rcnGGK+dFJ55Iqic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNonI/Ee; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB70C4CEE7;
	Fri,  1 Aug 2025 22:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754087424;
	bh=tWrjYCv4Av71BXfLwIY5KSkGF90mEgoc4+EF2H4mUFU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZNonI/EeCWpvWxBn4aEBp9vm/e5E7w1X4sFcMjRT6iOT0CMa2E9AK1m4T1KfF96w1
	 7Gyo2jG2brmupaBZ3bKruwfuxi3A5RXlxwrHtcSb/7ji2hAd2nir0rJmBy9rU33wsJ
	 z5ndtRukYjTBclcw/f0+TARFk+i6cyWGOrwZTvpG7VU6tSAeNRCaSTZpywJ8plYwgS
	 jWpeGJHaBNsMDPMc6Dg3Qiexx0Cl9VcEM6RMKxn+T/5hKX74yDj/LShtUuIsJVFbIN
	 YcM0Qvm7AChZKDxdwAxApPx18uq1Qu7BcgS5zyOGi8cpMNtim44A3Qad6cKxJf29ZQ
	 ktJtxE0u+sByQ==
Date: Fri, 1 Aug 2025 15:30:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, Michal Kubiak
 <michal.kubiak@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Simon
 Horman <horms@kernel.org>, nxne.cnse.osdt.itp.upstreaming@intel.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-next v3 13/18] idpf: prepare structures to support
 XDP
Message-ID: <20250801153023.087c940c@kernel.org>
In-Reply-To: <20250730160717.28976-14-aleksander.lobakin@intel.com>
References: <20250730160717.28976-1-aleksander.lobakin@intel.com>
	<20250730160717.28976-14-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Jul 2025 18:07:12 +0200 Alexander Lobakin wrote:
> Note that "other count" in Ethtool will now also include XDP Tx queues.

Erm, what? You mean other channels? Channels are interrupts, 
not queues.

