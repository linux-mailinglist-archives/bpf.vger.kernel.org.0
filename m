Return-Path: <bpf+bounces-34969-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4569E9344FB
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 01:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94EEF283AA4
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 23:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494195381B;
	Wed, 17 Jul 2024 23:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="FJF7XIGG"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DED61C36;
	Wed, 17 Jul 2024 23:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721257572; cv=none; b=Z/29vw2+NvK6GVWV1pOupkLUBOtA3b9cf3hJpsSjwe7bvqTXJWhadr7SrhrJYMO7LP4ww/2DZQerHQznU41VxIpFiPGM9gRgCfwCH6fTuqzPmKjnflrYugSM65OZyFZmcx+c8lowyMpYCCY56mwnSJ++iOzs7+vI7XXG9lQaz4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721257572; c=relaxed/simple;
	bh=NAEl5BO6t+UhvzUxdMP1MqTiP61LVnti4s4gJOVxsp4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=AZ0YTJtQ9wi9YCAmwBkZ5gZ8xhJpehyDZ/mAz7qf/lRRBhYeb91HtRGizOGG8URiHd/Yb49VFCsmKMRq4XiUq0Y2TSRDvh0jg/dUoY1VCde5M/gQN/OyYDBg33BRdWmDHFRmalFKagqGnHSK5j20v4n7WleFLf+bdQfVmqhjKv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=FJF7XIGG; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=z9pdZ21hvYIwVRiPXazOclxmW+YuoQrndU0f/vyzFq4=; b=FJF7XIGGlyUGv8xIOQKc/gmeey
	WIe1tZwybuYe8Sh3hkXGe9gRuNkETTLVzccLAh8uiikbzTQG3Lpx8IgA9UYyyh0DHF0B749paMN3X
	GzkQRCd4QOK0SyP8nxt3j210BHMRIUj1tm02Q5rUG74jkeMVOduak9uyy6xKI+QTGeGM3Ua7MQ+LN
	esAAjIbbIp0AIcGumfIEojZUkpZm8XfK9JzvifnFCIEfmtfiMkP2Elh4L8RpxfRlsqqmRBOpNGvI+
	cIifep9TZC0QTfVs1OUlyRrCBiq2ukbjCqqshk0OBaXPmTuhYgsnBasEU4/rdV/9K/qJMAkD4UIGH
	3iUaRnWQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sUDHx-000L1Q-BE; Thu, 18 Jul 2024 00:38:21 +0200
Received: from [178.197.248.43] (helo=linux.home)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sUDHw-000Bnj-2K;
	Thu, 18 Jul 2024 00:38:20 +0200
Subject: Re: [PATCH 1/2] MAINTAINERS: Update email address of Naveen
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Naveen N Rao <naveen@kernel.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bpf@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Hari Bathini <hbathini@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>
References: <fb6ef126771c70538067709af69d960da3560ce7.1720944897.git.naveen@kernel.org>
 <20240716190222.f3278a2ef0c6a35bd51cfd63@kernel.org>
 <87sew8wtxw.fsf@mail.lhotse>
 <20240718064331.834e1359f9c3f285f2dd7eb5@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <6f979810-4992-13ba-c154-a4b5f838844d@iogearbox.net>
Date: Thu, 18 Jul 2024 00:38:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240718064331.834e1359f9c3f285f2dd7eb5@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27339/Wed Jul 17 10:36:14 2024)

On 7/17/24 11:43 PM, Masami Hiramatsu (Google) wrote:
> On Wed, 17 Jul 2024 13:58:35 +1000
> Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Masami Hiramatsu (Google) <mhiramat@kernel.org> writes:
>>> On Sun, 14 Jul 2024 14:04:23 +0530
>>> Naveen N Rao <naveen@kernel.org> wrote:
>>>
>>>> I have switched to using my @kernel.org id for my contributions. Update
>>>> MAINTAINERS and mailmap to reflect the same.
>>>
>>> Looks good to me.
>>>
>>> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>>
>>> Would powerpc maintainer pick this?
>>
>> Yeah I can take both.
> 
> Thank you for pick them up!

Looks like patchbot did not send a reply, but I already took them
to bpf tree.

Thanks,
Daniel

