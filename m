Return-Path: <bpf+bounces-78658-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 645D3D1692F
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 04:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1530930115CE
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 03:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955623246EE;
	Tue, 13 Jan 2026 03:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PV7qEz8a"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A922E0925;
	Tue, 13 Jan 2026 03:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768276716; cv=none; b=FM+U/imVp/6Bw5zcrUsGBMad1lXhVdoHPkaB6U6DW5SxBv2ji9D2kEUHHG8JX0Rd2wbpfxH9WbXR+T2DTfLbu0D2ZLN1BFmXjcVt+XhXIoc9VfHiZ9aMD3gsyiDRhYGzyX1uTJbxRQQ1yi6svi5QVDnJvkNOctIw5AvjbiwZhIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768276716; c=relaxed/simple;
	bh=R5Hz8hw4pVoYwFbjbl5t7mGZtvyjZTX8ukY0HlbA2Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fhQdk9NHQzK1Hw6NE2J7VOviCLm1awppVu929pGO5H3/iMLoHqvUlXMgEEZFE2rEpLYx0CcDc1v9pyeRaJJx6C5fv1sBVXyzBT6leAgEMLvYt61ZYd/RQgXd3FNJ5zbjCEXg7jTxVFS4SAcKdloJQWGmyx7q0U4CBxdSZveSBo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PV7qEz8a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6B7C116C6;
	Tue, 13 Jan 2026 03:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768276715;
	bh=R5Hz8hw4pVoYwFbjbl5t7mGZtvyjZTX8ukY0HlbA2Uw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PV7qEz8awjf/NP6z+rOXNyYQXafp+Aa2j8YvkoP5wB7jSxrmbFldz3K5Y2ACh7BlP
	 fOJko4FwgEdf6g8mO6BWBmMrmzLkzje7QSIQKase+ag+m8npbDmfnPTpkpAWndN2na
	 lj9UJEJp2RJgHCe3y0FzFftcznat4NgUDUMMhxiG9rfT4krryLHKaa4nxntzpsjMnW
	 8HfpW215tFZp4z8D3VlG8DxX6K9PQ54pWYEkKrkVEYlKrXLq9b+B66KzrBa3KXExck
	 bN3oY68KMauZM7mhJYaHnAdHg5x0hwmTkSNirZwv3XvgeOANA3ktkj+nw3BEty7FWx
	 MmHnlARQUPR6A==
Date: Mon, 12 Jan 2026 19:58:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com,
 sdf@fomichev.me, john.fastabend@gmail.com, martin.lau@kernel.org,
 jordan@jrife.io, maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v5 14/16] selftests/net: Add env for container
 based tests
Message-ID: <20260112195834.733c0ffe@kernel.org>
In-Reply-To: <20260109212632.146920-15-daniel@iogearbox.net>
References: <20260109212632.146920-1-daniel@iogearbox.net>
	<20260109212632.146920-15-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  9 Jan 2026 22:26:30 +0100 Daniel Borkmann wrote:
> +            cmd(f"tc filter del dev {self.ifname} ingress pref {self._bpf_prog_pref}").stdout

tools/testing/selftests/drivers/net/lib/py/env.py:380:12: W0106: Expression "cmd(f'tc filter del dev {self.ifname} ingress pref {self._bpf_prog_pref}').stdout" is assigned to nothing (expression-not-assigned)

