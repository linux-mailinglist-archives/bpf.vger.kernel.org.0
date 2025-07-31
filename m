Return-Path: <bpf+bounces-64783-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2293B16E43
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 11:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BBD45832BE
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 09:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FB5299928;
	Thu, 31 Jul 2025 09:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxEqLmhS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC8C1D618A;
	Thu, 31 Jul 2025 09:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753953260; cv=none; b=lZSFniUyrOAibAo8BbVO987A3UI1viF/wA5WtW1/3C3Qa0dF5Y0HGmHxLwzbpHf67Yrnabo5BFDgZV7MJwWxVnGmidluKrhmXEawKrzhoy9SjDmKhzgCHqmEJfwLvHPfUVKUBWDGBJ0Jp9Og2i5syLhtM4l0geoXkyRHgkil+mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753953260; c=relaxed/simple;
	bh=o1GnT/mv5uDo9vZxctWYqJZ/ZVlGC9o4m7b8LxI/dKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UV1T4xUsa/QzeUoTyrQuXiNG1Z3HQjazUyvIut7XBZ3nckraVbBzZ3aRRJliUnaVFCNt27A0bWOUeK+bMibMiSl+9t8MXVp5E8bxxTs1ODCj7jtH74QJMvkcxI0LA5SgnDl5REZvokhNlAHUEo1QLJiA7xpNzagRD2suc4DcmPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxEqLmhS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B322C4CEEF;
	Thu, 31 Jul 2025 09:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753953260;
	bh=o1GnT/mv5uDo9vZxctWYqJZ/ZVlGC9o4m7b8LxI/dKs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZxEqLmhSyJL5s1N7GWltmF+Q9EcbntivFSJS0yqhCHVIu1W76AONTUf2xfJJnmtpT
	 wzbi7WPDgIdp+YX/M8luyen2O6LTkvIt9plT3bPpk73dKKIvzhtmO4XXcsU68eKeKM
	 tyHfMQ+k2IhQT12huuVhfvAhC7kthQZK5aHNCMLchCL5Q3Vk6RvVrU5EBOnrEeWtkx
	 hYlDAA8uJorci4yykWwiWFluwohVErV/NcQL6YklY2Yzw2LWvMJ1dg8VuZl9wmK1Yp
	 ZOaYflUoPkOp3BvTbUzzJ5aeg/+S+GDn5r31pBIIaTqxyyy0ZsnOs7hbuKghrHLZdz
	 3OG/PTC2iCByg==
Message-ID: <a13646af-78f7-4ba7-9767-41d598222b1d@kernel.org>
Date: Thu, 31 Jul 2025 11:14:14 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sfc: handle NULL returned by xdp_convert_buff_to_frame()
To: Edward Cree <ecree@amd.com>, Paolo Abeni <pabeni@redhat.com>,
 Chenyuan Yang <chenyuan0y@gmail.com>, ecree.xilinx@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, sdf@fomichev.me, lorenzo@kernel.org
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com, bpf@vger.kernel.org,
 zzjas98@gmail.com
References: <20250723003203.1238480-1-chenyuan0y@gmail.com>
 <045d1ff5-bb20-481d-a067-0a42345ab83d@redhat.com>
 <de14f60e-b1f0-432c-80b4-a2f0453e0fe2@amd.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <de14f60e-b1f0-432c-80b4-a2f0453e0fe2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 25/07/2025 12.11, Edward Cree wrote:
> On 7/24/25 10:57, Paolo Abeni wrote:
>> On 7/23/25 2:32 AM, Chenyuan Yang wrote:
>>> The xdp_convert_buff_to_frame() function can return NULL when there is
>>> insufficient headroom in the buffer to store the xdp_frame structure
>>> or when the driver didn't reserve enough tailroom for skb_shared_info.
>>
>> AFAIC the sfc driver reserves both enough headroom and tailroom, but
>> this is after ebpf run, which in turn could consume enough headroom to
>> cause a failure, so I think this makes sense.
> 
> Your reasoning seems plausible to me.

Hmm... have you actually tested that XDP/BPF can adjust headroom so much
that xdp_convert_buff_to_frame() function fails?

I really doubt this possible for BPF-progs to violate this.

The XDP BPF-prog can only adjust the headroom via the helpers
bpf_xdp_adjust_head() and bpf_xdp_adjust_meta().  These helpers reserve
room for sizeof(struct xdp_frame).

The tailroom can be adjusted via helper bpf_xdp_adjust_tail() and it
also reserve room for sizeof(struct skb_shared_info) such that BPF-progs
cannot get access to this area. See define for xdp_data_hard_end.

--Jesper

