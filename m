Return-Path: <bpf+bounces-64937-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 691DFB1893A
	for <lists+bpf@lfdr.de>; Sat,  2 Aug 2025 00:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 231FF627A7C
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 22:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9A022B5A5;
	Fri,  1 Aug 2025 22:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrMIMpTF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392C115A8;
	Fri,  1 Aug 2025 22:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754087625; cv=none; b=md71cK4Grx2Aj48tPnfBr2KmJr4CHGo3MGLYFk2eQhtcG1kaxau/4YvuTsIAI1UvF/0QbWfwvOq5NyilIUim3oseD3vUZThalfkWEtsuwV7p332JnBk7Oge1YiWGGKtSOZbpIpY0WnzEnouytvczNLdH0+Dkq4IfAbpviPhoA/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754087625; c=relaxed/simple;
	bh=rHvT7XzTyZKGUqrO5uQ6yfryUOqdTr9MuHLG9FWPxR0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k92p33Vgc+RTNIhfNUaEk6jgfNpNgGoVZGqBVckSc3unfGfpZS3tnYe5iUXybA93rzcbmjps/YH+zK3PYLqkgm61Bh2rEyZTe0lvn7XBlhFueVu7ZU7SOE1oWgGQo+AVlMSZ2bm1VZ/o52W8yC596rgJ+8OE+Mt1O2owtxOIawE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrMIMpTF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3249FC4CEE7;
	Fri,  1 Aug 2025 22:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754087624;
	bh=rHvT7XzTyZKGUqrO5uQ6yfryUOqdTr9MuHLG9FWPxR0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DrMIMpTF7juPOgfakhioYc3zyLfUzAVsbQo2H4ycDqIN5WYj1t/s+UiYa66L9Y5LZ
	 fYuKKBFrsZNJdfw4UyR1ZaZF+HlFiWGc/ex3N3VThZOPcdILaL9qKEgws7dQQUhuMK
	 fn/2hCTLlQl65fStSZv2lr4uYzZWqkd1pUo0RuQ3xRUF72EHubgFbrSjmP2vO5exqR
	 AcCWr53Atg0J2H5OXohHWUaq0i9FxCJ7fbpYPY+W4M3G8qeDYIWT5mfaepB76fPEb4
	 AP7SjAWTHFvHeVzrOMvFgJptg2RFy3thhVnZ/2pYY1YhtZUfdkip75NPeAN2E+lmup
	 fIJ93hX7SvGOg==
Date: Fri, 1 Aug 2025 15:33:43 -0700
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
Subject: Re: [PATCH iwl-next v3 16/18] idpf: add support for XDP on Rx
Message-ID: <20250801153343.74e0884b@kernel.org>
In-Reply-To: <20250730160717.28976-17-aleksander.lobakin@intel.com>
References: <20250730160717.28976-1-aleksander.lobakin@intel.com>
	<20250730160717.28976-17-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Jul 2025 18:07:15 +0200 Alexander Lobakin wrote:
> Use __LIBETH_WORD_ACCESS to parse descriptors more efficiently when
> applicable. It really gives some good boosts and code size reduction
> on x86_64.

Could you perhaps quantify the goodness of the boost with a number? :)

