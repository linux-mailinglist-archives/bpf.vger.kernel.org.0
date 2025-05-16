Return-Path: <bpf+bounces-58401-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA27BAB9ED7
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 16:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC8B116D76B
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 14:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB461A23A9;
	Fri, 16 May 2025 14:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIohOczF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9959317B425;
	Fri, 16 May 2025 14:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747406642; cv=none; b=FG3R9oQH6BQ85c3sNthms6zDpotsEpIkWwxN9r23Ab5Hv6rTzZ9GFhkH1jnuX5KV/c+fslTM/Ev4D2cI2Y1RuiNWuHxVxceLYannGwOOXcGDFEQo323PTe9xysKRZM7pBb1beEnsoJxv3+M2VWSdB0pUhureaGUFHJgoTz8bIA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747406642; c=relaxed/simple;
	bh=iCxsZZd0sUHuM8uPNwEJRgf0yHo14GFLJbNsIXTJHCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UX3Q2+LY5oSZPLbHmuGryPN4+/aOOqNIMIL1F1rReAhZ9QCTFhBwieyd0cMFMo4olzJc4QHQ9+nxszimq/fVfDcQO0whr/yXfY2c59vvfw3f/VRSbPjL03tUTTZL1IMZYrHzbs99vVFcbUw99SG2cTQNCZxPm1JV3a3VcHeAwaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIohOczF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 005DBC4CEE4;
	Fri, 16 May 2025 14:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747406642;
	bh=iCxsZZd0sUHuM8uPNwEJRgf0yHo14GFLJbNsIXTJHCk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hIohOczFCMGxH0/70imo1ujChKe5GEWHRCHsR66xM45yd6eQtEFuv2nDD1IygFjFR
	 uGHdFIRwC4p1q3x0tGbJZkTVnd5KOH7Evciy4JaKq6GXI+92GymaIwtHc4bPBXiS2Q
	 BFA2xrbmPqlqWC0H/YCzJmSRasnCs98j9k/gJmoVHxgXP8bCfMkZtqfmvFFktqmmqs
	 b9oUxiuzhoAYHuAZOavyaM/CgIc2OGVM9sdE7ANtLks37HVbPmLggZiHIJawMCAFXK
	 JbXQux7MUwMnoNWDMwQ/mVscAy0yKEFlUJ8fjPlAOHXDF1xNqXKCS9VSH7r+OEH6HG
	 K5Iy+wwNY8jJw==
Message-ID: <09377c1a-dac5-487d-9fc1-d973b20b04dd@kernel.org>
Date: Fri, 16 May 2025 16:43:54 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/mlx5e: Reuse per-RQ XDP buffer to avoid
 stack zeroing overhead
To: Tariq Toukan <ttoukan.linux@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Network Development <netdev@vger.kernel.org>, linux-rdma@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 Moshe Shemesh <moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
 Sebastiano Miano <mianosebastiano@gmail.com>,
 Samuel Dobron <sdobron@redhat.com>
References: <1747253032-663457-1-git-send-email-tariqt@nvidia.com>
 <CAADnVQLSMvk3uuzTCjqQKXs6hbZH9-_XeYo2Uvu2uHAiYrnkog@mail.gmail.com>
 <dcb3053f-6588-4c87-be42-a172dacb1828@gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <dcb3053f-6588-4c87-be42-a172dacb1828@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16/05/2025 15.47, Tariq Toukan wrote:
> 
> 
> On 15/05/2025 3:26, Alexei Starovoitov wrote:
>> On Wed, May 14, 2025 at 1:04 PM Tariq Toukan <tariqt@nvidia.com> wrote:
>>>
>>> From: Carolina Jubran <cjubran@nvidia.com>
>>>
>>> CONFIG_INIT_STACK_ALL_ZERO introduces a performance cost by
>>> zero-initializing all stack variables on function entry. The mlx5 XDP
>>> RX path previously allocated a struct mlx5e_xdp_buff on the stack per
>>> received CQE, resulting in measurable performance degradation under
>>> this config.
>>>
>>> This patch reuses a mlx5e_xdp_buff stored in the mlx5e_rq struct,
>>> avoiding per-CQE stack allocations and repeated zeroing.
>>>
>>> With this change, XDP_DROP and XDP_TX performance matches that of
>>> kernels built without CONFIG_INIT_STACK_ALL_ZERO.
>>>
>>> Performance was measured on a ConnectX-6Dx using a single RX channel
>>> (1 CPU at 100% usage) at ~50 Mpps. The baseline results were taken from
>>> net-next-6.15.
>>>
>>> Stack zeroing disabled:
>>> - XDP_DROP:
>>>      * baseline:                     31.47 Mpps
>>>      * baseline + per-RQ allocation: 32.31 Mpps (+2.68%)
>>>

31.47 Mpps = 31.77 nanosec per packet
32.31 Mpps = 30.95 nanosec per packet
Improvement:  0.82 nanosec faster

>>> - XDP_TX:
>>>      * baseline:                     12.41 Mpps
>>>      * baseline + per-RQ allocation: 12.95 Mpps (+4.30%)
>>

The XDP_TX number are actually lower than I expected.
Hmm... I wonder if we regressed here(?)

12.41 Mpps = 80.58 nanosec per packet
12.95 Mpps = 77.22 nanosec per packet
Improvement:  3.36 nanosec faster

>> Looks good, but where are these gains coming from ?
>> The patch just moves mxbuf from stack to rq.
>> The number of operations should really be the same.
>>
> 
> I guess it's cache related. Hot/cold areas, alignments, movement of 
> other fields in the mlx5e_rq structure...

The improvements for XDP_DROP (see calc above) in nanosec is so small
that it is hard to measure accurately/stable on any system.

The improvement for XDP_TX is above 2 nanosec, which looks like an 
actual improvement...


>>> Stack zeroing enabled:
>>> - XDP_DROP:
>>>      * baseline:                     24.32 Mpps
>>>      * baseline + per-RQ allocation: 32.27 Mpps (+32.7%)
>>
>> This part makes sense.
> 

Yes, this makes sense as it is a measurable improvement.

24.32 Mpps = 41.12 nanosec per packet
32.27 Mpps = 30.99 nanosec per packet
Improvement: 10.13 nanosec faster

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>

--Jesper

