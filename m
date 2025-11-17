Return-Path: <bpf+bounces-74822-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D280C669C3
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 00:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D27F94E0F61
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 23:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0244A327215;
	Mon, 17 Nov 2025 23:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ah2RpTmH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52621320CA8;
	Mon, 17 Nov 2025 23:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763423963; cv=none; b=aXSRz5Aq0dkZRQJegQV+1SSGqZ4zopQwW1SJoRKhq1xEQb5WmQXym0GjrN5mHNNz34IbHFNYkT2Wn24sbGcNxBOu/WAFjH+3PZk6sEo8kNl2Wylc97H9AAgODRUeCaeuQrCJvKLdHA9ypg4p6yK34F3F6GDW5jIimQ5Sqq7RjTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763423963; c=relaxed/simple;
	bh=QWtab+7YYyxQQgR/WSlIl4PzngTNSiu1rVqIdi5XG84=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KWivoCwsFlmMUKpO6Eo4ox9roDqIcELEv5AARzjLF0eWkeNTEJyCKwvvNvhfEIDvEESKnruilCj/6zSiyods6bmvcjrlPNB7GjXU1oiW8lgOzf0qj0YINq3qZxo3UYp8iiwt2pbk/ot/y2WMO50WYIltcTL7Yj4XUPVkKD+j4c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ah2RpTmH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA96C4CEF1;
	Mon, 17 Nov 2025 23:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763423962;
	bh=QWtab+7YYyxQQgR/WSlIl4PzngTNSiu1rVqIdi5XG84=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ah2RpTmH/aA3k+W26MyHVatVbU0g5cG1h8hphSEFW5I4XjXe1ubOQJXahUIfXCuDC
	 MzU+gONXZZEczTnJefWURQR15N/lKN0a6/a++bBSuZ5plB7Z5c2YlAURGEA60CCJcX
	 gXi6hbdYBiM4K3gs2J9iHM8gscauSOkYU0oY1V0uah5kFITfsMDpSXwKh2V71SeuOi
	 LDd4MUgP7eYoA9Vs65MN/w/5Q7F7aB9EpzkJ/+3swmLea9m9LKlYzy9iFdO3sYNRga
	 M7/w6cCP5FpSYWxl2pQ+F2p2t/D7qI0oLK2nXmIe1Gank5PAatToSdnsBGt+4R0FOr
	 h3bpw0cgT2SLg==
Date: Mon, 17 Nov 2025 15:59:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 netdev@vger.kernel.org, csmate@nop.hu, kerneljasonxing@gmail.com,
 bjorn@kernel.org, sdf@fomichev.me, jonathan.lemon@gmail.com,
 bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH net v3] xsk: avoid data corruption on cq descriptor
 number
Message-ID: <20251117155919.1834be7b@kernel.org>
In-Reply-To: <4cf22f51-c3d4-4c02-b5b6-0cb38985d0f8@suse.de>
References: <20251030140355.4059-1-fmancera@suse.de>
	<aRtIiIvfVwJCmcn1@boxer>
	<4cf22f51-c3d4-4c02-b5b6-0cb38985d0f8@suse.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Nov 2025 17:11:48 +0100 Fernando Fernandez Mancera wrote:
> >> Instead use the skb destructor_arg pointer along with pointer tagging.
> >> As pointers are always aligned to 8B, use the bottom bit to indicate
> >> whether this a single address or an allocated struct containing several
> >> addresses.
> >>
> >> Fixes: 30f241fcf52a ("xsk: Fix immature cq descriptor production")
> >> Closes: https://lore.kernel.org/netdev/0435b904-f44f-48f8-afb0-68868474bf1c@nop.hu/
> >> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> >> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>  
> > 
> > Tested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > 
> > Fernando thanks for stepping in and providing this fix!
> > And thanks Jakub for ptr tagging trick.
> > 
> > @BPF maintainers, please apply this patch.

This is just an skb patch, let's stick to net as previously requested 
if that's okay with everyone.

> Thank you, please note that if rebasing is needed I can send a rebased 
> version. Just let me know.

I think repost would be good. Get a fresh run thru CIs and re-raise it
to reviewers who may have started ignoring the thread.

