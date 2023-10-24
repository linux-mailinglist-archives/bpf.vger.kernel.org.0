Return-Path: <bpf+bounces-13139-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BF37D56C5
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 17:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9012F1C20C71
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 15:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EE737C98;
	Tue, 24 Oct 2023 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="ee8COOfB"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF21273E1
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 15:43:23 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6D9BA
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 08:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=5xuaPMdhGEPkOAbBcl9hUBJw7r0v912sHBBgkDyp8lQ=; b=ee8COOfBgPN3rXIZbH3BnrNMGR
	r7+5tO44vxfAqkq9hfeJAvA6fAKSCNczSc2KmSIBXU+CRPS4QlMFpBapn+iLbw9LlHP1m+LU+XwU1
	7Yja1zuL4f/3sh/kihY/70HWtb122t3suQJJuKkopZNHYgsnXmUC5j7wysLJra/KfUa9xfoYu4BSc
	lhjdYcAjdL+rB8zoa2bKUIRCg+Y4sQWosleSE8jgzsoerj+RwscO3Q/S8M7B0j2IDmd07IcQU7Fo1
	f3TjfF7psULqtg5zYQ6fI5QsK8+2sWzTRZjDXfFD4GedHCc71Oled2kc/KYRHO/D3SMuAk2TEYxyS
	URIJODDg==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qvJYs-000GZO-22; Tue, 24 Oct 2023 17:43:18 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qvJYr-000KyE-Q9; Tue, 24 Oct 2023 17:43:17 +0200
Subject: Re: [PATCH v4 bpf-next 2/7] bpf: derive smin/smax from umin/max
 bounds
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@kernel.org, kernel-team@meta.com
References: <20231022205743.72352-1-andrii@kernel.org>
 <20231022205743.72352-3-andrii@kernel.org>
 <5fed076b-597d-1721-2430-155d27188dfe@iogearbox.net>
 <CAEf4BzafU5qofmEq3Kgpg77TLwLwnZ=8hth63gu5L9omT_USqw@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <562d13dd-6ef5-5088-b298-538b29f19b84@iogearbox.net>
Date: Tue, 24 Oct 2023 17:43:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAEf4BzafU5qofmEq3Kgpg77TLwLwnZ=8hth63gu5L9omT_USqw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27071/Tue Oct 24 09:43:50 2023)

On 10/24/23 4:53 PM, Andrii Nakryiko wrote:
> On Tue, Oct 24, 2023 at 6:08 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>> On 10/22/23 10:57 PM, Andrii Nakryiko wrote:
>>> Add smin/smax derivation from appropriate umin/umax values. Previously the
>>> logic was surprisingly asymmetric, trying to derive umin/umax from smin/smax
>>> (if possible), but not trying to do the same in the other direction. A simple
>>> addition to __reg64_deduce_bounds() fixes this.
>>
>> Do you have a concrete example case where bounds get further refined? Might be
>> useful to add this to the commit description or as comment in the code for future
>> reference to make this one here more obvious.
> 
> Yes, it's one of the crafted tests. I've been adding those issues
> where I found bugs or discrepancies between kernel and selftest to the
> "crafted list" to make sure all previously broken cases are covered.
> Unfortunately I didn't keep a detailed log of cases (as there were
> initially too many). I'll try to undo each of these changes and see
> what breaks, will take a bit to do this one by one, but it's fine.
> 
> What level of details is necessary? Just having a test case? Showing
> how the kernel adjusts stuff (I can get verbose debugging logs both
> from kernel and selftest)? I'm trying to understand the desired
> balance between too little and too much information (and save myself a
> lot of time, if I can ;)

I think a concrete walk-through example before/after with reg state would
be nice and some more analysis on how the change relates to the subsequent
adjustments done in __reg64_deduce_bounds() further below where we learn
from signed and later again from unsigned bounds.

(Btw, patch 1 looks good/trivial so I applied that one in the meantime.)

>>> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>>> ---
>>>    kernel/bpf/verifier.c | 7 +++++++
>>>    1 file changed, 7 insertions(+)
>>>
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index f8fca3fbe20f..885dd4a2ff3a 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>>> @@ -2164,6 +2164,13 @@ static void __reg32_deduce_bounds(struct bpf_reg_state *reg)
>>>
>>>    static void __reg64_deduce_bounds(struct bpf_reg_state *reg)
>>>    {
>>> +     /* u64 range forms a valid s64 range (due to matching sign bit),
>>> +      * so try to learn from that
>>> +      */
>>> +     if ((s64)reg->umin_value <= (s64)reg->umax_value) {
>>> +             reg->smin_value = max_t(s64, reg->smin_value, reg->umin_value);
>>> +             reg->smax_value = min_t(s64, reg->smax_value, reg->umax_value);
>>> +     }
>>>        /* Learn sign from signed bounds.
>>>         * If we cannot cross the sign boundary, then signed and unsigned bounds
>>>         * are the same, so combine.  This works even in the negative case, e.g.
>>>
>>
>>


