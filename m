Return-Path: <bpf+bounces-16492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FEF801A44
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 04:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 056381F21180
	for <lists+bpf@lfdr.de>; Sat,  2 Dec 2023 03:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC538BF6;
	Sat,  2 Dec 2023 03:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKUAKlQj"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C94D399;
	Sat,  2 Dec 2023 03:48:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C1CC433C9;
	Sat,  2 Dec 2023 03:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701488911;
	bh=pdmq7TzQd2+K99eFA+C3lM33OvZy8TFGcKdYgScxkm8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MKUAKlQjy/sT/G5D8elG/Jo8f2tp0otXg/w8vg1z8us6Ne6M9z+TQ7SIV4vx46ULb
	 PlDtmc+mc/tjTJdjsxt98Unoh50xK4cMqLHBX8pszBNfMxYxm3Cs36fISMr8CKc9ga
	 tszVXPsh7PZfVxqJosoQ1QYOUsYW+1bPoiPx7GIbkrCP1EdFhmQe9Ne1K4GtUoNt3O
	 cxCJsHKUMjs8SHvA+9n8+MpyBtEYQA5WOzHbkCX1hxt4y4f+jUrVyZAYs6uKa726zj
	 fpahMwIqcdSmAXSnXX6iGbj/83PY93m/RB37hCxRR7ZdgNeBPv+dQ/fyMK5dnGyWKj
	 MSSdYj8vHw5rw==
Date: Fri, 1 Dec 2023 19:48:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>, aleksander.lobakin@intel.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, lorenzo.bianconi@redhat.com, bpf@vger.kernel.org,
 hawk@kernel.org, toke@redhat.com, willemdebruijn.kernel@gmail.com,
 jasowang@redhat.com, sdf@google.com
Subject: Re: [PATCH v3 net-next 2/2] xdp: add multi-buff support for xdp
 running in generic mode
Message-ID: <20231201194829.428a96da@kernel.org>
In-Reply-To: <c9ee1db92c8baa7806f8949186b43ffc13fa01ca.1701437962.git.lorenzo@kernel.org>
References: <cover.1701437961.git.lorenzo@kernel.org>
	<c9ee1db92c8baa7806f8949186b43ffc13fa01ca.1701437962.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  1 Dec 2023 14:48:26 +0100 Lorenzo Bianconi wrote:
> Similar to native xdp, do not always linearize the skb in
> netif_receive_generic_xdp routine but create a non-linear xdp_buff to be
> processed by the eBPF program. This allow to add  multi-buffer support
> for xdp running in generic mode.

Hm. How close is the xdp generic code to veth?
I wonder if it'd make sense to create a page pool instance for each
core, we could then pass it into a common "reallocate skb into a
page-pool backed, fragged form" helper. Common between this code
and veth? Perhaps we could even get rid of the veth page pools
and use the per cpu pools there?

