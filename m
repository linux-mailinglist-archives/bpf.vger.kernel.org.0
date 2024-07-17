Return-Path: <bpf+bounces-34961-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90073934287
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 21:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02400B21E7E
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 19:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8D618410A;
	Wed, 17 Jul 2024 19:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AJIYf0vC"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742CA17545
	for <bpf@vger.kernel.org>; Wed, 17 Jul 2024 19:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721243791; cv=none; b=m6GfZH/Q6MDmamYmrge3OSQkNlcz/pNBXGM19DF9449D8nbBCV6c8lsPpm5M6dDaYAgd6i/VfrSA+qg8yY7fMkff6SmrvMuNoPj10oe7/pQfg+BS73BGs3wetdP8jmSwDV9DIKk/TwgFRCw7osHIVOAIl9j9RNvzNlqqOpxsySY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721243791; c=relaxed/simple;
	bh=dWEsRQH395VEBrUpm8P8J+4vocY7M+svKcuuXSmZKfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GqXObNmXbnSNNUYL/ClL3MJqgJtO/U0pb7YDs6VTOMjV3/Smxk8yBoMU1rOi1nGsFrSN1v6O8x1nNfx7W78oRDYXOfXvJMk3MUiK634xD4qUjXCGUOiQqCP1bbtvkn9uwEiUsHZoqfOr02L7z1H4YNGWD2GbLxuYokuxJlxTVXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AJIYf0vC; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: toke@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721243786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fH5ALR4dDh/EwVo7Sy+L0QyU76WKYRhmEvdApIz7gxM=;
	b=AJIYf0vCQIqtT+G8toHuUXyxX6UKx63dh2phO8HRTMyABIBm0ElvPqfGN4sacZWt9dfDfq
	E3JoxXbxz8DaOoCvl8L4yimqmMiwKgj1zVg7glTTqEMaE40eWshNh6DWutqncuMVXZFcXX
	MMH5Y0vBNbQGyj6g5jvrPl4gpKR0DCU=
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: netdev@vger.kernel.org
X-Envelope-To: revest@google.com
X-Envelope-To: syzbot+cca39e6e84a367a7e6f6@syzkaller.appspotmail.com
X-Envelope-To: alexei.starovoitov@gmail.com
X-Envelope-To: michal.switala@infogain.com
Message-ID: <bf687c6d-50ae-4252-9861-3e58f82f42f9@linux.dev>
Date: Wed, 17 Jul 2024 12:16:16 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: Ensure BPF programs testing skb context
 initialization
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, revest@google.com,
 syzbot+cca39e6e84a367a7e6f6@syzkaller.appspotmail.com,
 alexei.starovoitov@gmail.com, Michal Switala <michal.switala@infogain.com>
References: <CAADnVQJPzya3VkAajv02yMEnQLWtXKsHuzjZ1vQ6R19N_BZkTQ@mail.gmail.com>
 <20240715181339.2489649-1-michal.switala@infogain.com>
 <250854fc-ce22-4866-95f9-d61f6653af64@linux.dev> <87y160407o.fsf@toke.dk>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <87y160407o.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 7/17/24 6:28 AM, Toke Høiland-Jørgensen wrote:
>> It looks very similar to
>> https://lore.kernel.org/bpf/000000000000f6531b061494e696@google.com/. It has
>> been fixed in commit 5bcf0dcbf906 ("xdp: use flags field to disambiguate
>> broadcast redirect")
>>
>> I tried the C repro. I can reproduce in the bpf tree also which should have the
>> fix. I cannot reproduce in the bpf-next though.
>>
>> Cc Toke who knows more details here.
> 
> Hmm, yeah, it does look kinda similar. Do you mean that the C repro from
> this new report triggers the crash for you on the current -bpf tree?

I was able to repro in bpf tree ~two days ago but not now. The bpf tree has been 
fast forwarded and has the 6.10 changes. I just tried linux-stable/linux-6.9.y 
which has the fix in the commit 5bcf0dcbf906. The syzbot report (against the 
36534d3c5453) also has that fix.

In particular, the syzbot repro I tried:
https://syzkaller.appspot.com/text?tag=ReproC&x=17caa30a980000


