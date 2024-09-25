Return-Path: <bpf+bounces-40322-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 110F998677F
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 22:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6C711F22243
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 20:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499F7146A79;
	Wed, 25 Sep 2024 20:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="WfioIAnw"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CCE28E8
	for <bpf@vger.kernel.org>; Wed, 25 Sep 2024 20:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727295492; cv=none; b=a+LGYjMzfBmnxX6bckocw7hiy3EKa7tf1F9skpb1p/oWb1bizG6TChnZ/ehcfQvvhsi46LVHkfI0H7JWU942eaKE2WuLMwWcEEp+L6qeK9yvCBP9kuCPqekb2AmTiVIk5YifwtC7ZgNUSvWoXdVG1y29RaYljxb3/mMgl4sU5IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727295492; c=relaxed/simple;
	bh=eqaS9S/tXg1WsM3OjCRppz24xoDWlDbe2a/3V4EcRSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X+38gxZMfWREcFvphJzQBvDU7jJSS+cnuUA4C0g00IE3Hx3qnfcY/acbbtoX+oIh4pwwDf17uydZmct0qQ2JQy0VQmIM1KIf7HQ4b6EyLgb7yOLckMOmwIluH2B5wboIZPtUEWuGKc5xxjZB+u7qMH+6ZEN9gy4RQNjQS7pMdfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=WfioIAnw; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Zuhvvdt7NVbEROzPMSPAx4HRRvXqRSQ6ics1W80pRrE=; b=WfioIAnwhDniLXZBOGAVdDe9uA
	DdvZ4p1zLOHmzmRfu7JOm8/3v5EIOoq5z/MHvzIdD3IekD8+D0Hd5gvUnKYkMq77Hqt2Elb2tlj8J
	1A0WJWjyuCZ3f1p79hz8M4y6UaHfickmuTP2mD/xRV6sgwCUAz6lILOLs4fvRCIrLQj9N77LsLrZ4
	4k4D87nZBfLRSc8wS9P7OU5Yz0LW37ea7IPYq6qOTaI/DEvvj2UKnwyF1nzd8T2vCF3plTQqjhf7s
	4l7v3tmlDG2Np0jVqeVms4PDN4krjxQdahjl11HP6yl1iH5XUELKLdj2dONhodCVLtlWJ6YC5DAiu
	OrAVlBzQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1stYST-00057V-93; Wed, 25 Sep 2024 22:17:57 +0200
Received: from [178.197.249.20] (helo=[192.168.1.114])
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1stYSS-0005k0-1u;
	Wed, 25 Sep 2024 22:17:56 +0200
Message-ID: <b6d82e51-d993-4c1c-bcbc-1c6b9d022462@iogearbox.net>
Date: Wed, 25 Sep 2024 22:17:55 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v1 1/2] bpf: sync_linked_regs() must preserve
 subreg_def
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev, Lonial Con <kongln9170@gmail.com>
References: <20240924210844.1758441-1-eddyz87@gmail.com>
 <88488499-771a-4179-b959-37a3d8f0cf51@iogearbox.net>
 <ffb55362a04fcc6e20db4705902e721c639b4245.camel@gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
In-Reply-To: <ffb55362a04fcc6e20db4705902e721c639b4245.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27409/Wed Sep 25 11:17:07 2024)

On 9/25/24 9:48 PM, Eduard Zingerman wrote:
> On Wed, 2024-09-25 at 11:44 +0200, Daniel Borkmann wrote:
>
> [...]
>
>> Do we have a Fixes tag for stable?
> I think this bug persisted from the beginning:
> 75748837b7e5 ("bpf: Propagate scalar ranges through register assignments.")
>
> E.g. here is original find_equal_scalars():
> static void find_equal_scalars(struct bpf_verifier_state *vstate,
> 			       struct bpf_reg_state *known_reg)
> {
> 	...
> 	struct bpf_reg_state *reg;
> 	...
> 				*reg = *known_reg;
> 	...
> }
>
> And bpf_reg_state for 75748837b7e5 has subreg_def as a member.
>
> I can post v2 with this "Fixes" tag if you'd like.
No need, thanks, this can easily be added while applying.

