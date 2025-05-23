Return-Path: <bpf+bounces-58860-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09899AC2A79
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 21:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B324316CAD6
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 19:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD9F29DB99;
	Fri, 23 May 2025 19:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knD6GqEz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B1D299952;
	Fri, 23 May 2025 19:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748028912; cv=none; b=dQgmj8sv6rN7Z/pD4zlTTSd8cbeTmk49At/sqhENx0iiRZWl+0OIksYZfSMjSyKhDtrotvsWT0fj8HBTNlxhjfzXuchKsupmWh4uGLV2gUo2+LnO6TLhJci1BUwrVokyMd0ktf3bZWsTq20Ic8BASAeIzyQy8fkIqkhnyBJaBpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748028912; c=relaxed/simple;
	bh=3AdZVXv0zxpClnAAHm6qS0J668YTkFj2/6hPaehODiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqw5B+uFL/fzalIDnyyLKbVU2CFEVtcrZqYKVHMahyX9zt7fdFyrhNEOjguJmxAU88Vwa9zbLuo5YQ1ceAKUFZUCtH57LIM7K172gJHhUI7IO7jf9daJqDshF+UkD3GnnxIN4WOAS3MGV1rbR/nVdmIotjEegJK2X1dIc2Hv40Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knD6GqEz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA82C4CEE9;
	Fri, 23 May 2025 19:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748028911;
	bh=3AdZVXv0zxpClnAAHm6qS0J668YTkFj2/6hPaehODiM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=knD6GqEztMNAhOFnQmhgVudOaO3qaKgyNjnHzIw2wbxZatITUu6MWirTzr9UCiD5e
	 su1BdCqaLDaPhivViE5bHPDJikBDpXIJirPc4WPYYM3yW4D0GJiN3nReKLZbCkTz01
	 nng/hnVo+rXJKhkWyqftMh9gn0qVO6K6MREnBKDmS+ok8ggVlhWfe/3sxq10ZAkuY+
	 Inlc8qq+8sDNVIrkV9RkYwftaswW5wuGmPl3hrc5nxiFtq1VkRo2FcdBK/QUBzOhQM
	 nssNm3dNb9t3V8Hq9tzpaZZffFhSUMeJgJIgkEZNli3B3gCSNMnSOTi7CsviTQYb4H
	 CE2MjET+5HiRg==
Date: Fri, 23 May 2025 12:35:10 -0700
From: "saeed@kernel.org" <saeed@kernel.org>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: "kuba@kernel.org" <kuba@kernel.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"hawk@kernel.org" <hawk@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"leon@kernel.org" <leon@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"ast@kernel.org" <ast@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Gal Pressman <gal@nvidia.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	Moshe Shemesh <moshe@nvidia.com>
Subject: Re: [PATCH net-next V2 11/11] net/mlx5e: Support ethtool
 tcp-data-split settings
Message-ID: <aDDN7qfX-hG3FVub@x130>
References: <1747950086-1246773-1-git-send-email-tariqt@nvidia.com>
 <1747950086-1246773-12-git-send-email-tariqt@nvidia.com>
 <20250522155518.47ab81d3@kernel.org>
 <aC-xAK0Unw2XE-2T@x130>
 <4f1e6469dc0f3f9dda4741bb3213e0dc86f3805a.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <4f1e6469dc0f3f9dda4741bb3213e0dc86f3805a.camel@nvidia.com>

On 23 May 16:17, Cosmin Ratiu wrote:
>On Thu, 2025-05-22 at 16:19 -0700, Saeed Mahameed wrote:
>> >
>> > The kernel_param->tcp_data_split here is the user config, right?
>> > It would be cleaner to not support setting SPLIT_DISABLED.
>> > Nothing requires that, you can support just setting AUTO and
>> > ENABLED.
>> >
>>
>> I think I agree, AUTO might require some extra work on the driver
>> side to
>> figure out current internal mode, but it actually makes more sense
>> than
>> just doing "UNKNOWN", UKNOWN here means that HW GRO needs to be
>> enabled
>> when disabling TCP HDR split, and we still don't know if that will
>> work..
>>
>> Cosmin will you look into this ?
>
>Yes, I will address all comments from this round by the next
>submission.
>

I thought about it, maybe we should simplify mlx5:
when hw_gro is not enabled mlx5 should fail tcp_data_split ethtool
settings, and when hw_gro is enabled setting tcp_data_split on mlx5 should
be a no-op.

I think verbosity is important here as mlx5 doesn't support plain
tcp_data_split, it must come with gro_hw .. 

reporting tcp_data_split in mlx5 can remain the same as before the series.

We might need to update some tests and script to try hw_gro if enabling
just tcp_data_split didn't work.

for the AUTO state I really have no clue what it means and I think we
should avoid it.


>Cosmin.

