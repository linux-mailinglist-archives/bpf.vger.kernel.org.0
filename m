Return-Path: <bpf+bounces-70110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8A1BB110F
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 17:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54736174069
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 15:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A132765CA;
	Wed,  1 Oct 2025 15:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pu4enX6d"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6603646BF;
	Wed,  1 Oct 2025 15:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759332459; cv=none; b=Rzgm/kc0RY0Ec7qlAxVjjC+rSPHURUoOaSFAP+a7VFfnsqF+6C0mipq7zLDDF59EYwFWZIwDbEwiO84KsSQN4jyGI5yGNF79rCNVUapdugtSkE2s6aoO40y/NanQUNsuhNUiuPXxAWuZJWTqeYxRA/oriZLYK4urgEL+4ZELPhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759332459; c=relaxed/simple;
	bh=WSnH7IirEGJGNs84RjsFq16wwx+I0W29kMdUTi2XFJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N64D85e8HKab2Cz0TEP50vCwcQ8RwhaPordYQTCvoOadaTO7XWtcbRKZa3e3oLP3KhJzGKsuEjeWmqRIruuShnNiBbOBdyedtCNE3YztVySHb4EGrM96WdjECAXd7bghcJohTOGyMPVQWU3lEOCvl3DPyfI49xNVduK81jsGfrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pu4enX6d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE78C4CEF1;
	Wed,  1 Oct 2025 15:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759332458;
	bh=WSnH7IirEGJGNs84RjsFq16wwx+I0W29kMdUTi2XFJ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Pu4enX6dS1gvR/srZivHLGWxbO9VgiRozQUowZ++wJV6t2j0DAxyAkbpYgcuENuVa
	 wywAPOr+nVUTsZQmw9oG36xTQByDLOm6vAOIiQSK97B8KPDEYVOJZcLxGI9tZzPv06
	 gKRbYVs2BWs4RXBdcqYuaetsH+xw19x4K1jobEfR36xDlpd3ZiI0kEmL6KY/Hlq1gO
	 keLWJZdUk3SioAGljxyIPGRcZQ900Plr743doGNIvJic48R5YSku5wfGy3E6FxVvTg
	 QUZd/SuKjaf5nT+gbO8xgDCp+OvYRboftpwPfqqPefqUl05YhzYInweaXLtqy4uFZv
	 ze3SQ4geb6gSA==
Date: Wed, 1 Oct 2025 08:27:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Octavian Purdila <tavip@google.com>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
 <ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
 <john.fastabend@gmail.com>, <sdf@fomichev.me>, <kuniyu@google.com>,
 <aleksander.lobakin@intel.com>, <toke@redhat.com>, <lorenzo@kernel.org>,
 <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
 <syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com>
Subject: Re: [PATCH net v2] xdp: update mem type when page pool is used for
 generic XDP
Message-ID: <20251001082737.23f5037f@kernel.org>
In-Reply-To: <aN091c4VZRtZwZDZ@boxer>
References: <20251001074704.2817028-1-tavip@google.com>
	<aN091c4VZRtZwZDZ@boxer>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 1 Oct 2025 16:42:29 +0200 Maciej Fijalkowski wrote:
> Here we piggy back on sk_buff::pp_recycle setting as it implies underlying
> memory is backed by page pool.

skb->pp_recycle means that if the pages of the skb came from a pp then
the skb is holding a pp reference not a full page reference on those
pages. It does not mean that all pages of an skb came from pp.
In practice it may be equivalent, especially here. But I'm slightly
worried that checking pp_recycle will lead to confusion..

