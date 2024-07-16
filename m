Return-Path: <bpf+bounces-34932-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B43E293332E
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 22:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0E001C2203B
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 20:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F264F57CAC;
	Tue, 16 Jul 2024 20:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="yUoCXrnz"
X-Original-To: bpf@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F99E208BA;
	Tue, 16 Jul 2024 20:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721163498; cv=none; b=iYDbYZkJe8SxN6bWZ46f08FMZmC6bcZbXSkuFY2EbtES+V/wjBnqTJZgdGcT0Wvh10EaUZQ962lkXL4bawXaqZXStoXjg+EzCX3NpjCoxX/DSqqPredZv4rJM7XVCCMVxv87yl14Tx9dm2qSMZk3zPwXKmqwzcHL6X3WtWqJrA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721163498; c=relaxed/simple;
	bh=l6UbUcx3iMGM9PCj02/Umm7pb3tV6srslXvDG8JNVzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nuO5+ICbhwgq6w/4x/lh2jojBYs3Q62qy6S7kf/dfYhre/QUZhKdpI0WTROIFcWWJu0tmfc5c9js3WT/zaIDgIisUXRiz5X2PAOauCSDrzV+p1NYmTjwlqs4dbgbe+IiMTxIqy2l77FXHlOB7sR7JDDp4I29kXoEdRoKlAIszaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=yUoCXrnz; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1sTpFW-003lKS-Hz; Tue, 16 Jul 2024 22:58:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=1omvi2M8OSQnXOnTEvYz7/YhotvJgsglWPtup6b0jNs=; b=yUoCXrnzzDqBU42PDlAQzmdjZF
	QStY/I3TzXpBem43XPLbbnWgUd4ZHWz4hnl/qPap/u8D2rFQ2j791fbSr7OLiEyA6sxSWdmV1d0LX
	zW2lZqaFuMvo5DLX80w1gKE/uSJqb78CJJvgcbfpow072xdSxXcRq9HunwB+z26j0L9z3RrPQVxAu
	eV9Pr5CoH7b65ev5pg+qHH3RsXIAP3/fHzN3PkUKt588MOVsMgTPYsbrJl/PYTAM1SsGMQx/clrKD
	UBZXtUR2QY4G8M7K7Nzemn4qVYngZ0cNDxO0NOu3Oor9gN9s5u8LfB9agU/tl1iagLp95Na/wDPdG
	f3N/ozFA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1sTpFV-0001zf-5J; Tue, 16 Jul 2024 22:58:13 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1sTpFM-005V69-2d; Tue, 16 Jul 2024 22:58:04 +0200
Message-ID: <d31d7493-7b79-489f-9d90-51ad0e3a1757@rbox.co>
Date: Tue, 16 Jul 2024 22:58:02 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3 2/4] selftest/bpf: Support SOCK_STREAM in
 unix_inet_redir_to_connected()
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 john.fastabend@gmail.com, kuniyu@amazon.com, Rao.Shoaib@oracle.com,
 cong.wang@bytedance.com
References: <20240707222842.4119416-1-mhal@rbox.co>
 <20240707222842.4119416-3-mhal@rbox.co> <87zfqqnbex.fsf@cloudflare.com>
 <fb95824c-6068-47f2-b9eb-894ea9182ede@rbox.co>
 <87ikx962wm.fsf@cloudflare.com>
 <a4edd3d6-4cad-4312-bd20-2fb8d3738ad6@rbox.co>
 <8734o98zr9.fsf@cloudflare.com>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <8734o98zr9.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/16/24 11:14, Jakub Sitnicki wrote:
> On Sat, Jul 13, 2024 at 10:16 PM +02, Michal Luczaj wrote:
>> On 7/13/24 11:45, Jakub Sitnicki wrote:
>>> On Thu, Jul 11, 2024 at 10:33 PM +02, Michal Luczaj wrote:
>>>> And looking at that commit[1], inet_unix_redir_to_connected() has its
>>>> @type ignored, too.  Same treatment?
>>>
>>> That one will not be a trivial fix like this case. inet_socketpair()
>>> won't work for TCP as is. It will fail trying to connect() a listening
>>> socket (p0). I recall now that we are in this state due to some
>>> abandoned work that began in 75e0e27db6cf ("selftest/bpf: Change udp to
>>> inet in some function names").
>>
>> I've assumed @type applies to AF_UNIX. So I've meant to keep
>> inet_socketpair() with SOCK_DGRAM hardcoded (like it is in
>> unix_inet_redir_to_connected()), but let the socketpair(AF_UNIX, ...)
>> accept @type (like this patch does).
> 
> Ah, that is what you had in mind.
> Sure, a partial fix gets us closer to a fully working test.

Well, I'm all for a fully working test. And I'd be happy to help out.

