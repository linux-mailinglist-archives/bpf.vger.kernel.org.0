Return-Path: <bpf+bounces-70387-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7E5BB9012
	for <lists+bpf@lfdr.de>; Sat, 04 Oct 2025 18:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B0D354E4EBF
	for <lists+bpf@lfdr.de>; Sat,  4 Oct 2025 16:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DF627FD45;
	Sat,  4 Oct 2025 16:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwL1cu4L"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECE11EBFE0;
	Sat,  4 Oct 2025 16:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759596297; cv=none; b=dgv+k2QfPgQ4Uis8SmZhK7d4aSDk5ekAtrOdQqtBDInRaiREodTOg6vBFZrcX6PzvFlFTlLCZdvJTXYVNWJtroaHlO/Z8mQxLtdG+tSWndG/eg4xoFO+5Sgz1HBA9qEJhGSdrb7dBXDGHsfH5RnXMnQo8mReaKvmdWZ24mPMO4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759596297; c=relaxed/simple;
	bh=kRbTPHOH1LvxIY+6r8QOR8CqimN5VY7N0WB57fVySnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCopfJpBhX+atVnqYe9RMgNfOxIqn+am4ml4ssUi8JfRtvcl1IFcBpicDQYzQ4ghJxLWrOi683nYtwJmGJIh6wkYeUFH1O4V6HpSwlZt9+4jBBTqbJ33vMiUMQB+k09lS9U9lKDvqV01jAycLuHuN8aHAq6TbGkSyWEbnpvw8s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pwL1cu4L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89480C4CEF1;
	Sat,  4 Oct 2025 16:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759596296;
	bh=kRbTPHOH1LvxIY+6r8QOR8CqimN5VY7N0WB57fVySnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pwL1cu4LJymzIrlVhJvirhZWK7TcocXM8Hs/G+S4yF+bVDrSZnpDHSKzhqYg8R36w
	 0N80gBhO1IXHPleEezqn//1E31qy5+L9/Zwq1IZ0Q+vbqgWD7RxL5VSNs9uJIPQGGJ
	 YpLLQwwBbQRAZ7z1TE0rNjTD4QEJ2bWYC6E2HfkPRrXdJxs6haypI98XBkzlPtSw+E
	 XrI0nLCwU/jKNlmYJp4GF7h3P2Ph4GL8AXibgLlopf8axQsF+v1oPxIVp/wMiFXYot
	 zxs4GqYJ4wnBDkOGY235Jkcdh+sEeoyUG9fv0jHHjUlZgZ/pme/dd5efLG3oG/UmvU
	 eAdj8prsHS0xw==
Date: Sat, 4 Oct 2025 17:44:51 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, bpf@vger.kernel.org,
	alexanderduyck@fb.com, jacob.e.keller@intel.com,
	mohsin.bashr@gmail.com
Subject: Re: [PATCH net 1/9] eth: fbnic: fix missing programming of the
 default descriptor
Message-ID: <20251004164451.GF3060232@horms.kernel.org>
References: <20251003233025.1157158-1-kuba@kernel.org>
 <20251003233025.1157158-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003233025.1157158-2-kuba@kernel.org>

On Fri, Oct 03, 2025 at 04:30:17PM -0700, Jakub Kicinski wrote:
> XDP_TX typically uses no offloads. To optimize XDP we added a "default
> descriptor" feature to the chip, which allows us to send XDP frames with
> just the buffer descriptors (DMA address + length). All the metadata
> descriptors are derived from the queue config.
> 
> Commit under Fixes missed adding setting the defaults up when transplanting
> the code from the prototype driver. Importantly after reset the "request
> completion" bit is not set. Packets still get sent but there's no
> completion, so ring is not cleaned up. We can send one ring's worth
> of packets and then will start dropping all frames that got the XDP_TX
> action from the XDP prog.
> 
> Fixes: 168deb7b31b2 ("eth: fbnic: Add support for XDP_TX action")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>

