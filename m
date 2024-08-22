Return-Path: <bpf+bounces-37872-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F17595BA98
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 17:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B805B2A31B
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 15:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510C51CCB35;
	Thu, 22 Aug 2024 15:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMtAECi2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE24E1CB147;
	Thu, 22 Aug 2024 15:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724340851; cv=none; b=MMJ/mFbPBwgvTiFfbrDQNDgH89vQe+rUZVFhIrdMPk08toEL2wsEW/rNua0NRjyYmqbensDwCR9TtSAIkNBXmkyO0NT+ZhEwULdIkLy1gLjfCoVDaVS6GAK137+vxvGOunC6lLqzzWmWBMVT1kuQUtejmpKStz+YOSPeL6HPsCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724340851; c=relaxed/simple;
	bh=OP8lF7oeT/CTs5WaHYhcMzt+Wz9kFx2xDQKUUihobcA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DdUNedM9bAWtmfyp6pzA36KYLRZU+XJ8i6hSDfjZ5fOtcFoU8kOpFmSqHPutclD2MMUVYYqBdKbBm1yJcP59InSYmXPG3SrEPa5BkK9BPC+0jUo0l4yqA2CtSJkI8+/XULDwTD9PLJ1HdZsiF1AmWuJpInIInI8iuA7yGgmudgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMtAECi2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2CF6C32782;
	Thu, 22 Aug 2024 15:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724340851;
	bh=OP8lF7oeT/CTs5WaHYhcMzt+Wz9kFx2xDQKUUihobcA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LMtAECi2JU62ydFv5EeS8D9T99864EUvv1hg+DiHXO8AFDzNpnjsHq4uCGbUEDEb0
	 hQpAMFZj6cblWtC3TSQjTL7IYGg38vGWXUolduHXg4L7M2//ySs3iiZHhfnJr9MxgO
	 Eqrjq36fsR0vbTZpU4lKGGUCNXTjHJ9bS2O5o9lhPo82ykpkhwKP43i8VTsERjWEBL
	 PiTk25z2M4g2Wy+mGFs12V9WFhXP6e4B1/YbUCxZvTIC+D6LZEibd5oVq/z0b/QUQI
	 xLeHRDIQXPkrXqqiGA3PXJxnq2IRMEJHYmCNwGlGGTzreO6uxGk2s64ktB1wzl+cEv
	 tZykJJFYSpwUA==
Date: Thu, 22 Aug 2024 08:34:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, bpf@vger.kernel.org, Jay Vosburgh
 <jv@jvosburgh.net>, Andy Gospodarek <andy@greyhouse.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH net-next v2] net: refactor ->ndo_bpf calls into
 dev_xdp_propagate
Message-ID: <20240822083410.2edf979f@kernel.org>
In-Reply-To: <20240822055154.4176338-1-almasrymina@google.com>
References: <20240822055154.4176338-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Aug 2024 05:51:54 +0000 Mina Almasry wrote:
> When net devices propagate xdp configurations to slave devices,
> we will need to perform a memory provider check to ensure we're
> not binding xdp to a device using unreadable netmem.
> 
> Currently the ->ndo_bpf calls in a few places. Adding checks to all
> these places would not be ideal.
> 
> Refactor all the ->ndo_bpf calls into one place where we can add this
> check in the future.

LGTM! (if anyone is planning to review this please TAL, I'm thinking of
applying it a few hours before the full 24h period to let Mina post his
larger series today)

