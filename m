Return-Path: <bpf+bounces-65097-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A982BB1BE26
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 03:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7259F3B5384
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 01:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC351586C8;
	Wed,  6 Aug 2025 01:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QuPb+213"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E47F2E36EC;
	Wed,  6 Aug 2025 01:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754442454; cv=none; b=fPSgwL88lZd99ER57auD4sOMlQyu18311RsbP7ZWL3+iH4qmvlB4rJ051YGNSgV6Tkaobg3qzclM5ivQjY1U3CWKbNwCDuv71rrBunAQJrhNGuUMt/jtkodSyjTGH92w2weVbmiDX5KiqEHlYnDRdw14YFzGMQ5WHe0mIp3/RKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754442454; c=relaxed/simple;
	bh=793dCkPLvCc/LQ1zS3ZrNrBwKQpA1X+iahg+16KvZgE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mNy9fMsPA4pNeAp3wY590V5P7mQ+ytUoEhqSVB2OMsZOgxdaVE+9Xw4cyNYW4N799IiONYVBDOQ+2U4xJ1ylRfWRhHTYsxhc8npEra6wgiSGb5AIehIfqS8dVBParqYxuOrRqZnPCXsbqjdPY0aEAguSf0kOAhx+JQTN+lsAByg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QuPb+213; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6213CC4CEF0;
	Wed,  6 Aug 2025 01:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754442454;
	bh=793dCkPLvCc/LQ1zS3ZrNrBwKQpA1X+iahg+16KvZgE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QuPb+2134pQ8T88W22ROE/t31GTl88ZEiSIzyRTKJVxvYvVEOIL2QkS4JiiqO3DXQ
	 5SOcTRsOEDwbKIaU3HoyiLK12Y5DzTCd65RTVhfsSF/LMhWF9Edznyv+tIaJ6mmT3I
	 d6WhrgoFEZJ4kzwGq+EwXos2M7N//bRnZMXMpU3E324FvxV9HK/zZNPOPrGCQ9aC+1
	 /lwmSpFwLkgyyU5hRV78mh5Rkz+LPOnAdnWDUPt3KYLXQTGaFT+j5FIRQxa7aTqnT6
	 dCdXUTBOboHJrKIU+nLKo0khXhvkO5ZQRDZQGaGHeE97u0k7LegOWj5v/B+v5ZlU2s
	 yF3hEgfrY8fGw==
Date: Tue, 5 Aug 2025 18:07:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Meghana Malladi <m-malladi@ti.com>
Cc: <namcao@linutronix.de>, <r-gunasekaran@ti.com>,
 <jacob.e.keller@intel.com>, <sdf@fomichev.me>, <john.fastabend@gmail.com>,
 <hawk@kernel.org>, <daniel@iogearbox.net>, <ast@kernel.org>,
 <pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>,
 <andrew+netdev@lunn.ch>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: Re: [PATCH net v2] net: ti: icssg-prueth: Fix skb handling for
 XDP_PASS
Message-ID: <20250805180732.4e756498@kernel.org>
In-Reply-To: <20250803180216.3569139-1-m-malladi@ti.com>
References: <20250803180216.3569139-1-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 3 Aug 2025 23:32:16 +0530 Meghana Malladi wrote:
> emac_rx_packet() is a common function for handling traffic
> for both xdp and non-xdp use cases. Use common logic for
> handling skb with or without xdp to prevent any incorrect
> packet processing. This patch fixes ping working with
> XDP_PASS for icssg driver.

Out of curiosity were you able to use the in-tree XDP test?

