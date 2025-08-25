Return-Path: <bpf+bounces-66416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 007E7B3491A
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 19:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB1B216B5AF
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 17:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA31305E3B;
	Mon, 25 Aug 2025 17:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQiexjnO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28436301014;
	Mon, 25 Aug 2025 17:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756143880; cv=none; b=UUON8j6lxBjX7f78oYNKIHxTaDm4LfX9/Ae5o7QiJk5oNImmjO9k9vwmQgChwyk4bW2ddg4VqQQ/BgL1DDRzf1R73Qk1qZKxwIAKbzPF0/J0JITPSYJEGXGADquueyq+AKRxvtPpKGJodaZZ3dZwH+ewZQgPo82IKOWuUhr7vxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756143880; c=relaxed/simple;
	bh=ZqlL7EdFcfshtpo93RHE9+IShCCevelJeVbbExIKcDA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TontlpBUQGXMicjbP/JV9p9U8i1oWONVS4TZUn8cftUwLKahHc06V2eDpq4A6kPGNeZm1QRfTXatgzdn59M4eBQK0joOIs3+TDKllh5pyaJ4kxYTEaOmpmugRsDbClwBNl9TsmqCkuQ3PzMrooSFLQkgntt4cRx//6uJ1yUiNtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQiexjnO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F1FC4CEF1;
	Mon, 25 Aug 2025 17:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756143879;
	bh=ZqlL7EdFcfshtpo93RHE9+IShCCevelJeVbbExIKcDA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NQiexjnOmQH+yk/u70s+I+sgV7M1yDteB+7hsAKtEqenIJbcLRPmKOSd1IvVlZuxq
	 iCOq0i6xFUCQ9Gz0iRBQG2ujSAEczDFAuUuSXtXN6DFQ9LSXeJWyahzONKjWcZmEFr
	 hk67jrJwwepHk9l6r6Mn5FYybQDtZ/mCoO/2MloWgjHZgCEBmixoRtU2Iy1nZE5s/Q
	 UzlV9E6sChsy5CsOP4PvEE450dP4PTAXyle8cMWJck6sSehf/xh+d1WNE6/BUW0/OV
	 TSfN7LvI/Y6Xabifx33QMd1rcn0KapRAPOBg2/TvRpmqZgD3m7O3acXivnJ5Iv7FQo
	 tSJtkm/mMBCbQ==
Date: Mon, 25 Aug 2025 10:44:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 horms@kernel.org, andrew+netdev@lunn.ch, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v2 0/9] xsk: improvement performance in copy
 mode
Message-ID: <20250825104437.5349512c@kernel.org>
In-Reply-To: <20250825135342.53110-1-kerneljasonxing@gmail.com>
References: <20250825135342.53110-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Aug 2025 21:53:33 +0800 Jason Xing wrote:
> copy mode:   1,109,754 pps
> batch mode:  2,393,498 pps (+115.6%)
> xmit.more:   3,024,110 pps (+172.5%)
> zc mode:    14,879,414 pps

I've asked you multiple times to add comparison with the performance 
of AF_PACKET. What's the disconnect?

