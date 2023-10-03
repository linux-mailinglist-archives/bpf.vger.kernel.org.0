Return-Path: <bpf+bounces-11325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A817B743F
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 00:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 7E9322815A6
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 22:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671773E49A;
	Tue,  3 Oct 2023 22:49:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A643E47B;
	Tue,  3 Oct 2023 22:49:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E17B3C433C8;
	Tue,  3 Oct 2023 22:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696373361;
	bh=sNFNOsCAUTdTCrCK/6t3DnsdjrJJ3nc6KvG8sLL1Yl8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a+hBKprQstjNXjWdk7v4Z4U7Gi9y5UGDciA1+azE8+yL2BKigIB6Ph2YHWjyqaXKs
	 Dff+TgjX3AD2R/HKHPdwXJuH08d3bs9hMjoXW0nS5YKhM2IYl5psS6vcdYpkghKKN1
	 0zHJfZ1Z/fHhYE6IBAi3mgOydP3rXj67jqbnHIq/gjFsQ1C743ncosU9mUSDK4vUCf
	 EvWyJTPPUVNz8gCjJJ60wPsrna/a/OcKvHychg+Zz5mXfIDzY5zeHEudM2QCdNGUl2
	 JYotAMM5oG27SnQdVopUK4Uh79oy6ZmrbDYQuFaa2UGMbeFiz44e2Kxx4cpXIKQjY/
	 zglCWJaSUgt6g==
Date: Tue, 3 Oct 2023 15:49:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, Kamil Maziarz <kamil.maziarz@intel.com>,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 bpf@vger.kernel.org, Chandan Kumar Rout <chandanx.rout@intel.com>
Subject: Re: [PATCH net] ice: don't stop netdev tx queues when setting up
 XSK socket
Message-ID: <20231003154920.6ae3801f@kernel.org>
In-Reply-To: <20230925171957.3448944-1-anthony.l.nguyen@intel.com>
References: <20230925171957.3448944-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Sep 2023 10:19:57 -0700 Tony Nguyen wrote:
> Avoid stopping netdev tx queues during XSK setup by removing
> netif_tx_stop_queue() and netif_tx_start_queue().
> These changes prevent unnecessary stopping and starting of netdev
> transmit queues during the setup of XDP socket. Without this change,
> after stopping the XDP traffic flow tracker and then stopping
> the XDP prog - NETDEV WATCHDOG transmit queue timed out appears.

I think we need more info about what happens here.

Maybe ice_qp_ena() fails before it gets to the start?
If we don't understand what happens, exactly, we may be papering
over other bugs.
-- 
pw-bot: cr

