Return-Path: <bpf+bounces-21636-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA0784F9C3
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 17:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D077A1C2206A
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 16:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3827B3D9;
	Fri,  9 Feb 2024 16:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CO53OVx7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D911D687;
	Fri,  9 Feb 2024 16:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707496715; cv=none; b=U5muCgm44gqWDPh6fO2BXB4lWQ4w2eZsPbtNoUxFTAcXil3cBQ1l3aGdgbwe70hMSkUPYU2Wa9FGAjbrd2LlUpZZGSokGJI79/xN3UiHWGoz2d1yHWiCyue/19/kUsHKeYIL6rYf6djxfPdPzJA3FTdivF2koLgf4dVuMJfniao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707496715; c=relaxed/simple;
	bh=PqBRjemLiZPnWG41A/wTQvfcHw62YvkHQDDZ2tLlhU8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bcKy6HTGKIIfIqzX9pV3cruTPpk8x+ONmTjMdSf2GOf8Y8AJG/BvoEgFMND1pBNCL+btxYhVg6Hdxt1PQyzdTVp6WlIoMDkBMz1i8FKz8Vpi0hbk07UTVSAn1IduxJWD0ZpTtW4kbOAyCwX/7okduAs2TDh3QY3yY0xftOaBLXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CO53OVx7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CFB9C433C7;
	Fri,  9 Feb 2024 16:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707496715;
	bh=PqBRjemLiZPnWG41A/wTQvfcHw62YvkHQDDZ2tLlhU8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CO53OVx7uRPr0aIU+2GRPuMWFysVmV+RMQzzl/2NMr7mKRgXjJdcDkT4EASfkDdtG
	 hcIzca6enRI+IzUAJOwJ/IzagJvli1pxGPD1OGpcVdkT1NwzkQGi6Q4p2iBzdRGCat
	 39MXWWQe2DQGIwLuBrBYbaxocl5UEy0Ry5SDOBGm80EtmlcwG+nMJeFCatjneJJoT+
	 IJF839tQlWxFNH5K6CUW36mSeL2DKJVmwbya67toEwfUv8FzrM/EKwEem6THqSp6Ay
	 yvuHNkZlZOecUAw11MMUIzjF5CqNk/SqG6Lqj/yblO/d9Dk8TAx2kp9iF3jAtlIYYR
	 KiNjyqWhhqltw==
Date: Fri, 9 Feb 2024 08:38:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, lorenzo.bianconi@redhat.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 bpf@vger.kernel.org, toke@redhat.com, willemdebruijn.kernel@gmail.com,
 jasowang@redhat.com, sdf@google.com, hawk@kernel.org,
 ilias.apalodimas@linaro.org, linyunsheng@huawei.com
Subject: Re: [PATCH v8 net-next 0/4] add multi-buff support for xdp running
 in generic mode
Message-ID: <20240209083834.78a9e941@kernel.org>
In-Reply-To: <cover.1707132752.git.lorenzo@kernel.org>
References: <cover.1707132752.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 Feb 2024 12:35:11 +0100 Lorenzo Bianconi wrote:
> Introduce multi-buffer support for xdp running in generic mode not always
> linearizing the skb in netif_receive_generic_xdp routine.
> Introduce generic percpu page_pools allocator.

breaks the veth test, apparently:

https://netdev-3.bots.linux.dev/vmksft-net/results/458181/60-veth-sh/stdout

could be that the test needs fixing not the code.
But either way we need a respin :(
-- 
pw-bot: cr

