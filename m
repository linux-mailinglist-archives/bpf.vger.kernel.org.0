Return-Path: <bpf+bounces-70914-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC05BDAC62
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 19:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EAE663551BE
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 17:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF87307AD4;
	Tue, 14 Oct 2025 17:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="mdWttZ76"
X-Original-To: bpf@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD3A3019B5;
	Tue, 14 Oct 2025 17:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760462991; cv=none; b=mUgCG9UtTe8xBCGGJzv48Zc/d1dZtHvI4jlt3/Sv5xwtCMlPNqPDjsFF3VA/CXKCyKTNFXVDCLmS/tuPI4P4yvNt6mhwCL1/40LSzXy07dnlAO7ZqhRAso3x1XaFlMZPac7IzLMDABWnY9wqXxD2ZhqZcb2Wc8pe/nXLrt7e258=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760462991; c=relaxed/simple;
	bh=umIOKuw4Cl92BTjFZLvn+l5GvBsnKpPNG5VctslFvvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sIs36a+MA+0rL6Fij8+ZBMmAEA2osu2BRAl8Ew9/EIY9NObKQZr/F4EyoLA3ojbUEaW4PjAxghZMsnovog3Sd89zFFmYJ1MvcdnuB+DvSdo1kaQgi3rwUrZp/0/+jtyfYKzsT68lF/L+qNVgnSRcHGKb+VKnniDsSYM4SHdGSE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=mdWttZ76; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1760462979;
	bh=umIOKuw4Cl92BTjFZLvn+l5GvBsnKpPNG5VctslFvvo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mdWttZ76qpu6mbUf6Kj3WIQKjBlvUyV2NoAAPBwGNNWh1SGf4B2P1AGl5pYHdZmb3
	 Xsm705nYkO/mvz6yIyjWf/sJkxgthTOlzjjA+L03s/r35dr82hi8lCTrMdzZt45Rw9
	 WMd3Q2aM4FFs+rviSn8r74z2UFroU/wVDkOWkFrG8FrvJmNVVxz3SqT1Sg09J3yZet
	 GUSzkC7YFoGTrEqeEeE06miGOXMm2rkiU8eNXEIfcyYr/ISkY6LymhP+Moo0AWv9kd
	 V1aIiAOgdQCjqDefFIiNElIXvc6UtUxQFl88wUS4g74DgGkDPQQDitpqq+gUjJQKhA
	 XT8sWfdCBqQYg==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 7E45F60075;
	Tue, 14 Oct 2025 17:29:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id CCB47201BEC;
	Tue, 14 Oct 2025 16:27:57 +0000 (UTC)
Message-ID: <168fe516-b097-4bc3-8b72-acee310216a6@fiberby.net>
Date: Tue, 14 Oct 2025 16:27:53 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/6] tools: ynl-gen: bitshift the flag values in
 the generated code
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Daniel Zahka
 <daniel.zahka@gmail.com>, Donald Hunter <donald.hunter@gmail.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Joe Damato <jdamato@fastly.com>, John Fastabend <john.fastabend@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>, Simon Horman <horms@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Willem de Bruijn <willemb@google.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>
References: <20251013165005.83659-1-ast@fiberby.net>
 <20251013165005.83659-2-ast@fiberby.net>
 <a3835375-6eea-467f-8488-fff62ce4262b@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <a3835375-6eea-467f-8488-fff62ce4262b@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/13/25 11:07 PM, Jacob Keller wrote:
> On 10/13/2025 9:49 AM, Asbjørn Sloth Tønnesen wrote:
>> Instead of pre-computing the flag values within the code generator,
>> then move the bitshift operation into the generated code.
>>
>> This IMHO makes the generated code read more like handwritten code.
>>
>> No functional changes.
>>
> 
> Could we use BIT() here? or is that not available within uAPI headers?

Correct, BIT() is not exported to uAPI[1].

Thank you for the reviews!

[1] [PATCH v2] checkpatch: don't complain about BIT macro in uapi
https://lore.kernel.org/all/1468707033-16173-1-git-send-email-tomas.winkler@intel.com/


