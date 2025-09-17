Return-Path: <bpf+bounces-68676-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5F0B80905
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 17:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88CC846781B
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 15:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0111330C111;
	Wed, 17 Sep 2025 15:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VzbT8W8n"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9179430C100;
	Wed, 17 Sep 2025 15:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758122930; cv=none; b=LcnHPGGkKms+fF9zAI0C5h8Pu9bMf1bLrsu9n0PEF6ni1xAIh05CPvVKAIePVSzhDJUR8DyoA1O/he8h94/bWmrwN6wCa9CY+U46N42YTcfPrR1UKnpy92DiooQJ2YSi9Do2e4vn0BQAKsW1FPjVqMlloSTuXng+YSU/erebO2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758122930; c=relaxed/simple;
	bh=VpoFPhTwmm+WWukzSN7f5WNcO6XoGwtY7ZzuWmn9+lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZyY6hzavTXa1oolB5KE0MEO2eZiLn/ykQOnWhYbHCyozFD5QYM6+/WoIU9pfUO4nbffrhVSVxSqEKZx+jilMl8Gd2MRm+ZZ4sJiYVaR5t7x6dIjqZvfedq3kYg7kyo0v6vsP+zu4V4NH1HdM/hSBNkWU/BWzjWkQa0IW8TZOKZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VzbT8W8n; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 28151C0078E;
	Wed, 17 Sep 2025 15:28:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9801A6063E;
	Wed, 17 Sep 2025 15:28:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BADAB102F1BF4;
	Wed, 17 Sep 2025 17:28:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758122924; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=BFIVUZm5xuzuhfpRFg3QFSYuUBaBVnTUcSVoLhOrwf4=;
	b=VzbT8W8n/UBPmcEza93b9wYmwQXZ05Yy8SthzG0kUy+NcfHlsxg7W9HcgcKVoWjhL7FE2E
	Outq7VvZEGdkcqxNqc0m1OstRoquJTw6VgFfU88C0LlZdYF7bKL+Av7MxsWzxUPoj4SBW8
	8HYzaNOh26u/Au9nqoJ5SiB+kJEAjuP/2tWHEZofJEVISWpoWHcR6eSH138JJDIV7McPjb
	KNpoefIhS6ZtOlmXqHLo/dOnT8KclXhVjSfTw7zcxk8C5/lP7yagBp38SRAYsA5Tau/o25
	J7YpionBrmZnKqLY0gjXfGvbSAgCwiJBGhd7+QH3pYGVtFd8cCMouQ+xrzNDiQ==
Message-ID: <be4cd796-e47e-444a-97b9-b1d537e495f3@bootlin.com>
Date: Wed, 17 Sep 2025 17:28:25 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 01/14] selftests/bpf: test_xsk: Split
 xskxceiver
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Alexis Lothore <alexis.lothore@bootlin.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250904-xsk-v3-0-ce382e331485@bootlin.com>
 <20250904-xsk-v3-1-ce382e331485@bootlin.com> <aMlyUX999WOmUNMP@boxer>
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Language: en-US
In-Reply-To: <aMlyUX999WOmUNMP@boxer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Maciej,

On 9/16/25 4:21 PM, Maciej Fijalkowski wrote:
> On Thu, Sep 04, 2025 at 12:10:16PM +0200, Bastien Curutchet (eBPF Foundation) wrote:
>> AF_XDP features are tested by the test_xsk.sh script but not by the
>> test_progs framework. The tests used by the script are defined in
>> xksxceiver.c which can't be integrated in the test_progs framework as is.
>>
>> Extract these test definitions from xskxceiver{.c/.h} to put them in new
>> test_xsk{.c/.h} files.
>> Keep the main() function and its unshared dependencies in xksxceiver to
>> avoid impacting the test_xsk.sh script which is often used to test real
>> hardware.
>>
>> Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
>> ---
> 
> Hi Bastien,
> 
> after this patch the way summary is reported is different.
> 
> Before:
> # 16 skipped test(s) detected. Consider enabling relevant config options to improve coverage.
> # Totals: pass:53 fail:3 xfail:0 xpass:0 skip:16 error:0
> 
> After:
> # Planned tests != run tests (72 != 53)
> # Totals: pass:53 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> We lose the count of failed tests. Could you take a look?

Good catch, I'll take a look at it.

Best regards,
-- 
Bastien Curutchet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


