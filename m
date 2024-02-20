Return-Path: <bpf+bounces-22295-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A89F85B71C
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 10:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE2F5B265AE
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 09:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564675FB83;
	Tue, 20 Feb 2024 09:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MINPxiDQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFA260DDF;
	Tue, 20 Feb 2024 09:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708420677; cv=none; b=c0wVq3YcmgDMqcbW6xcUhNyTXUKDSc65KUzuuXf+i2aSraPUKOdwVOIigNCD7vBM7tkSlCJWFdXc2ysreG9KIgBVARXPGTCeYU+8sb/0CcA+QxQgwc4hqvNL1cujguAmkkkS/RMy+3vyu6CdcK90sBGYNbNjfAKo6ACVZeAmwPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708420677; c=relaxed/simple;
	bh=9LsdSu2OdnC/3DuAFj0k0VOgM/ft+uowjXfSoCMDeyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sz8/FsABhufOlFc//MGUtetJMnIA1tPVzkvqw2rS/LXgxRAlHVPexQi4omS/nCmLi316KgbSid36IOog/+dPgU4++KMTXckibiTvOn20txm6QOqHuFYBQnsvabScOB0v6p2/867KAeb77AwGKf1o/nwLwNCfw2DAIwD9ddJDEe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MINPxiDQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B8DDC43390;
	Tue, 20 Feb 2024 09:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708420677;
	bh=9LsdSu2OdnC/3DuAFj0k0VOgM/ft+uowjXfSoCMDeyQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MINPxiDQYOYFuRySK3zZze7Q8hIG1Lzme3urvPukljmaG9Lpx7m2LNA/rgFPInNqT
	 erVdx5zZThUNE7qXKgQjx4RVTj9D/moILrahgPOY8uriQyaIYrST4XGPacvdPR9+1/
	 YZDmqF3yu6OTRXKDPkOkbXKDYZVCKoTSOovMbJF05PpuFd7KkesD6mwVoofakPN1zn
	 sD4VANrlUvoC/4sBtXovBbeTTpYyatuDqCUamGmH/zbFsNk2KGEJhthnmAum9HG2e9
	 uxRQAeugK2P+9HojUTPMpNruQG8sfj9/UTzoRywLQPuKj7vvQWwt3uHcW+v+9DvhNv
	 QRJQQqmeho/Dw==
Message-ID: <04d72b93-a423-4574-a98e-f8915a949415@kernel.org>
Date: Tue, 20 Feb 2024 10:17:53 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 1/2] net: Reference bpf_redirect_info via
 task_struct on PREEMPT_RT.
Content-Language: en-US
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20240213145923.2552753-1-bigeasy@linutronix.de>
 <20240213145923.2552753-2-bigeasy@linutronix.de>
 <66d9ee60-fbe3-4444-b98d-887845d4c187@kernel.org>
 <20240214121921.VJJ2bCBE@linutronix.de> <87y1bndvsx.fsf@toke.dk>
 <20240214142827.3vV2WhIA@linutronix.de> <87le7ndo4z.fsf@toke.dk>
 <20240214163607.RjjT5bO_@linutronix.de> <87jzn5cw90.fsf@toke.dk>
 <20240216165737.oIFG5g-U@linutronix.de> <87ttm4b7mh.fsf@toke.dk>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <87ttm4b7mh.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 19/02/2024 20.01, Toke Høiland-Jørgensen wrote:
> may be simpler to use pktgen, and at 10G rates that shouldn't become a
> bottleneck either. The pktgen_sample03_burst_single_flow.sh script in
> samples/pktgen in the kernel source tree is fine for this usage.

Example of running script:
  ./pktgen_sample03_burst_single_flow.sh -vi mlx5p1 -d 198.18.1.1 -m 
ec:0d:9a:db:11:c4 -t 12

Notice the last parameter, which is number threads to start.
If you have a ixgbe NIC driver, then I recommend -t 2 even if you have 
more CPUs.

--Jesper

