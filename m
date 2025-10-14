Return-Path: <bpf+bounces-70917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC07EBDAC76
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 19:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 204691926084
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 17:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE8E30BF7F;
	Tue, 14 Oct 2025 17:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="h5HZ0LTz"
X-Original-To: bpf@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B50F307AC8;
	Tue, 14 Oct 2025 17:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760462993; cv=none; b=CIq4QbZBiYk4/kJtpqrQ7ZWqDxNxKRohviqQBthTL0sC5+q9YPT/fVlQQRF7GfHhOQlILclzo3DJEJxuRVrZpVqOFHelkJ7YpKwWZpDQkb1yAZaZc8DCPZwNBjbuRrzfiH8GRag3TQNMODwRHABJznoRDBgtl8w5WNK+UJ8NOKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760462993; c=relaxed/simple;
	bh=rYh9uNFhpbkALLzDDpNk48XhoTr0ObqQoknbFwkH+T0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u2C3Zgp3oruvq1P1tP6A7M2aN4/qn6VrnvtsQol/fP6cInzQeeY6teB1+jnuRvGcdVK8992bIpzB5wkYg9DbYDBk21hBexBweuafz9Op2cGmTnt+7ek69ORx8fobmD0ExjcI/hiyWPtE8/Q/UzBM87kNr8rEq5uLDQSN+fn2sfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=h5HZ0LTz; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1760462979;
	bh=rYh9uNFhpbkALLzDDpNk48XhoTr0ObqQoknbFwkH+T0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h5HZ0LTzFdFDdVVhX6f3+D53NzTFsW75zEqrj7V++EewILtyZYrBj4U4207ScOJNR
	 9qTnwPd3SuDd/VisXQVtGf3FNwPAS5gE/zLOTAY62VnQP/4OX5uzqJG0C4Z53uKDbT
	 vsA1KhOolrU1ZHOJOiKqVYlilOFJRL9oOtVH9/4cRnrEXLTsgXcydnjbdt6mJvR402
	 ZoIOKI9lXnudxQFOtfbabM8PmkFg5NAlTbV2jzj9ntxKpdtA5u6kfP2EFROooKx3Hm
	 Na956xRQ4NwoY9XhLBBQX2X2D3VGTKB0YFteH7iDwLogfTIrtEYa88ukb2HN2znyFi
	 hi31jFUStamnw==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 80327600BF;
	Tue, 14 Oct 2025 17:29:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 10DDB202092;
	Tue, 14 Oct 2025 17:04:15 +0000 (UTC)
Message-ID: <5c944395-141c-415b-b29a-8f70cafaa24d@fiberby.net>
Date: Tue, 14 Oct 2025 17:04:14 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/6] tools: ynl-gen: refactor render-max enum
 generation
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Daniel Zahka
 <daniel.zahka@gmail.com>, Donald Hunter <donald.hunter@gmail.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Joe Damato <jdamato@fastly.com>, John Fastabend <john.fastabend@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Simon Horman <horms@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Willem de Bruijn <willemb@google.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251013165005.83659-1-ast@fiberby.net>
 <20251013165005.83659-3-ast@fiberby.net> <20251013175826.6dbf6c78@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <20251013175826.6dbf6c78@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/14/25 12:58 AM, Jakub Kicinski wrote:
> On Mon, 13 Oct 2025 16:49:59 +0000 Asbjørn Sloth Tønnesen wrote:
>> +        suffix = yaml['type'] == 'flags' and 'mask' or 'max'
> 
> This construct looks highly non-pythonic to me

I don't mind changing it to it's multi-line form, but this line might go
away (see below).

>> +        self.enum_max_name = f'{self.value_pfx}{suffix}'
> 
> sometimes its max sometimes is mask, so we shouldn't call it max always

I'm fine with splitting them to render-max, enum-max-name, render-mask and
enum-mask-name. I was just following along the current lines in the code,
as started in commit 96a611b6b60c.

