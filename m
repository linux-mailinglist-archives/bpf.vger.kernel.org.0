Return-Path: <bpf+bounces-56101-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B007A914AB
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 09:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32DF55A1B11
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 07:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC0321C162;
	Thu, 17 Apr 2025 07:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="PdLuvDQ3"
X-Original-To: bpf@vger.kernel.org
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54BE19F13B
	for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 07:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744873256; cv=none; b=aO3oGyj19QjEWceiV/rYUI4gcYSrwAinyRhhZJjFM5HndiVG8ixNYQ5TB+dB3J9lqb7b4AgQmPZvvswp8IQFjqS9RB4X/ZeFN55ige8+Ubl1ZnFwL9ZhvRYKBoGp0ayXzbs9ptfht0dIStpRsyLhctn0ovSl8DhpO62muJk+uP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744873256; c=relaxed/simple;
	bh=w5PRKU5sdEGDHRp4fP0Y606LJOfqnZ6orvNNl1CuqY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kj2NV2NAK2WSypVGEpHXx+++h2iRavbtXNjgZc07V5ymwSuEtzuFs3WuvPgYtafo6yI9NbaCZfXkoCBVd5LeBQGJZ4S4dT4Xgo/V9zfHS81SYVyUCG8zxVwXwgrBNCPxKs2CLPSbeQmP2l5T0L3A+kQSBvg/KCmj8MXnpQpdPZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=PdLuvDQ3; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id C31841C0E76
	for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 10:00:38 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:to:subject:subject
	:user-agent:mime-version:date:date:message-id; s=dkim; t=
	1744873238; x=1745737239; bh=w5PRKU5sdEGDHRp4fP0Y606LJOfqnZ6orvN
	Nl1CuqY8=; b=PdLuvDQ31t8mLtMkmrs/NTfYcHICtXlo8nyDwX06bM0Sp8AK/DK
	N6rrVwdgdzdPmKmAKhGXFKdAXD0Mb3mIWHQw7/AION0eNrN0ONMfjfvjKDpjmLt7
	kafQyqRLeZG5bu1+aG3+NCyW9IdowXePwZu+inkN0yy7/yoBO6nOhIpA=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id z_L5BJLdVgPT for <bpf@vger.kernel.org>;
	Thu, 17 Apr 2025 10:00:38 +0300 (MSK)
Received: from [172.16.0.185] (unknown [176.59.174.214])
	by mail.nppct.ru (Postfix) with ESMTPSA id 8B6BC1C08D8;
	Thu, 17 Apr 2025 10:00:23 +0300 (MSK)
Message-ID: <fa91aad9-f8f3-4b27-81b3-4c963e2e64aa@nppct.ru>
Date: Thu, 17 Apr 2025 10:00:22 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen-netfront: handle NULL returned by
 xdp_convert_buff_to_frame()
To: Jakub Kicinski <kuba@kernel.org>
Cc: Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, xen-devel@lists.xenproject.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 lvc-project@linuxtesting.org, stable@vger.kernel.org
References: <20250414183403.265943-1-sdl@nppct.ru>
 <20250416175835.687a5872@kernel.org>
Content-Language: en-US
From: Alexey <sdl@nppct.ru>
In-Reply-To: <20250416175835.687a5872@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 17.04.2025 03:58, Jakub Kicinski wrote:
> On Mon, 14 Apr 2025 18:34:01 +0000 Alexey Nepomnyashih wrote:
>>   		get_page(pdata);
> Please notice this get_page() here.
>
>>   		xdpf = xdp_convert_buff_to_frame(xdp);
>> +		if (unlikely(!xdpf)) {
>> +			trace_xdp_exception(queue->info->netdev, prog, act);
>> +			break;
>> +		}
Do you mean that it would be better to move the get_page(pdata) call lower,
after checking for NULL in xdpf, so that the reference count is only 
increased
after a successful conversion?

