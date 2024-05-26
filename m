Return-Path: <bpf+bounces-30613-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D078CF3E8
	for <lists+bpf@lfdr.de>; Sun, 26 May 2024 12:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 119B81F21D0E
	for <lists+bpf@lfdr.de>; Sun, 26 May 2024 10:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F715B646;
	Sun, 26 May 2024 10:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="jfoKv5KH"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068BC944D;
	Sun, 26 May 2024 10:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716718348; cv=none; b=sjS+j+wW7ZZY93+6zdG+Y9HiOQFW0zhe73ES25znda5DsMTt8cvgTVHLcidPoQcSZqO50BUBJqUi+myxuJY4WwzOA2lgwW4df7Cv8YCpcw7e5L+uXYK7ylT1wZ+7aQTK7Z80gX76pUdtNdgokpm1Cp+YjfKlR7f7yOFFybCADGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716718348; c=relaxed/simple;
	bh=8oUxUxZJg4KKPtTzJx66f3/wv9+1zWEIBduvh5jiAkE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=KJQ1fSqZIkAkg0fNtc7CdgPatvXJCmH0XnwZ6ygrZjOzoDX2C9TnWcGtDXzpUCzu7vuBEi9iVgYntcDmFBT7odbQAU+RNQRsK8oOghTBlTp0qsaaa4En9gnYfkdlPZ9jqel4HbhZO2qMy+l3A7jDR0XfNQeaZRukDOXtZhR2aZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=jfoKv5KH; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=N3C2+7Y+QSPTOxNU7PnuOKCuJ1uAfob26BSoj4QvzwI=; b=jfoKv5KHLQ73zNzGwZvRcNvqPv
	T8cWw8FZdMu4W3lrVLXSDbrEoSV7qOIPSUWI4zffoNoj531VUwQ/8SQ2PIqBCBjfVBPrsyqkAuvSE
	pPqxwbx2M/mCBs0YMLm8A5wNF7xxJjBgJFzPq7dvF1Nj27z7Zp6Qg07CxDzwINQ3kz81ZBGE57HFH
	KCg2DNDJ1JfAZYkD/H+waXC8thZIXwyAf7H0KxdoFV9JVeHBEsI45HLif6XtFCVgMXHPrBTxMhMLW
	tdK8UiHYUpY8IsPqCnfT7O+Hp84BrEYpiygqOChvm6Z8JiWTlvmJUbUCrzm3URNqWl5wI9W9Fk9xT
	A9QnJoMw==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sBArR-000HrP-5c; Sun, 26 May 2024 12:12:17 +0200
Received: from [178.197.248.14] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sBArQ-000J3i-2z;
	Sun, 26 May 2024 12:12:16 +0200
Subject: Re: [PATCH bpf v2 4/4] selftests/bpf: Add netkit test for pkt_type
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: Nikolay Aleksandrov <razor@blackwall.org>, bpf <bpf@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>
References: <20240524163619.26001-1-daniel@iogearbox.net>
 <20240524163619.26001-4-daniel@iogearbox.net>
 <31b97318-38fc-4540-a4a9-201c619c4412@linux.dev>
 <CAADnVQK5nL2Pkh0pUanHvVh0auYmdbc2yEfMxquknoX0vjiUAA@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <36231a20-ebe1-5846-9609-f895c4379596@iogearbox.net>
Date: Sun, 26 May 2024 12:12:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQK5nL2Pkh0pUanHvVh0auYmdbc2yEfMxquknoX0vjiUAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27287/Sun May 26 10:27:50 2024)

On 5/25/24 7:55 PM, Alexei Starovoitov wrote:
> On Fri, May 24, 2024 at 3:05 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 5/24/24 9:36 AM, Daniel Borkmann wrote:
>>> diff --git a/tools/testing/selftests/bpf/progs/test_tc_link.c b/tools/testing/selftests/bpf/progs/test_tc_link.c
>>> index 992400acb957..b64fcb70ef2f 100644
>>> --- a/tools/testing/selftests/bpf/progs/test_tc_link.c
>>> +++ b/tools/testing/selftests/bpf/progs/test_tc_link.c
>>> @@ -4,6 +4,7 @@
>>>
>>>    #include <linux/bpf.h>
>>>    #include <linux/if_ether.h>
>>> +#include <linux/if_packet.h>
>>
>> The set looks good.
>>
>> A minor thing is that I am hitting this compilation issue in my environment:
>>
>> In file included from progs/test_tc_link.c:7:
>> In file included from /usr/include/linux/if_packet.h:5:
>> In file included from /usr/include/asm/byteorder.h:5:
>> In file included from /usr/include/linux/byteorder/little_endian.h:13:
>> /usr/include/linux/swab.h:136:8: error: unknown type name '__always_inline'
>>     136 | static __always_inline unsigned long __swab(const unsigned long y)
>>         |        ^
>>
>> Adding '#include <linux/stddef.h>' solved it. If the addition is fine, this can
>> be adjusted before landing.
> 
> I hit the same build issue. So added stddef.h before if_packet.h as
> Martin suggested before applying.

Awesome, thanks all!

