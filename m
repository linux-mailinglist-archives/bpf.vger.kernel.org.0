Return-Path: <bpf+bounces-20622-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 831908411E9
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 19:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEF2F1F22DB6
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 18:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FD46F082;
	Mon, 29 Jan 2024 18:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Tb6/F8is"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC618657A8
	for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 18:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706552225; cv=none; b=nVooooNY5WH+08saesOHqzNa8IURcqCqI9w4TkKRNztxb3e02GC5BRoqEYzAgJtTzUeDA5wvgcwnUgSiZ1vVnza3GZsdJi4PlUMKtQOfKgJ51i9dSU51XoVMzk3Eb8N+tEzX+ZH4jfooFAL+v0u3uZVR9UQy2GjJwnnZgSfcRCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706552225; c=relaxed/simple;
	bh=tVDboemijtHtOmKrcV7IP2Ch03czP1KghUj53/EdMKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u/lbWGauCYFO53QlVBtCyEeoEy7st4J2SsqAw+ijjJekg1B09tXS9TLEP4CA/BJk58Gdg/D2cmZ1LMYOgh/Bw5D51NdEcNqQX/Ox5RGx5Fn8jAx6RNk63eOQXYOwiTlmpJ1szmKSBHYHtwN5PQoqVWmQhxgwkx82sst/0br4+Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Tb6/F8is; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1b6daace-3c82-47c5-9b75-66051f8e3933@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706552220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p6N9y74uXgTRbRb4YM5KmEK5QeW+BD2LHY95mbbSRdQ=;
	b=Tb6/F8isvUpPdkcRHy9/kuPs84OLtHfEP8WsfuxpyC8Wo8MmWFe0hipY4iBoiGB8IX9oHg
	W34qmKeVwww82OfsmhVz5edYzKoYJW8TDLFxZ3t9frRxZF4m5amxYlWhf2/MfA8NUt4+TU
	O56r2TIhjTaWgw/MyZ0SJ7k5dyUDAO8=
Date: Mon, 29 Jan 2024 10:16:56 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: BPF selftests and strict aliasing
Content-Language: en-GB
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>,
 Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, david.faust@oracle.com,
 cupertino.miranda@oracle.com, Yonghong Song <yhs@meta.com>
References: <87plxmsg37.fsf@oracle.com>
 <b1906297-d784-479b-b2f3-07ab84ae99c1@linux.dev> <87a5opskz0.fsf@oracle.com>
 <04efa2a3-ca81-42c3-883f-5b91917f2bde@linux.dev>
 <6819204566bfae73c140938920eeb389d27abad8.camel@gmail.com>
 <87sf2gnk8w.fsf@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <87sf2gnk8w.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 1/29/24 9:05 AM, Jose E. Marchesi wrote:
>> On Sun, 2024-01-28 at 21:33 -0800, Yonghong Song wrote:
>> [...]
>>> I tried below example with the above prog/dynptr_fail.c case with gcc 11.4
>>> for native x86 target and didn't trigger the warning. Maybe this requires
>>> latest gcc? Or test C file is not sufficient enough to trigger the warning?
>>>
>>> [~/tmp1]$ cat t.c
>>> struct t {
>>>     char a;
>>>     short b;
>>>     int c;
>>> };
>>> void init(struct t *);
>>> long foo() {
>>>     struct t dummy;
>>>     init(&dummy);
>>>     return *(int *)&dummy;
>>> }
>>> [~/tmp1]$ gcc -Wall -Werror -O2 -g -Wno-compare-distinct-pointer-types -c t.c
>>> [~/tmp1]$ gcc --version
>>> gcc (GCC) 11.4.1 20230605 (Red Hat 11.4.1-2)
>> I managed to trigger this warning for gcc 13.2.1:
>>
>>      $ gcc -fstrict-aliasing -Wstrict-aliasing=1 -c test-punning.c -o /dev/null
>>      test-punning.c: In function ‘foo’:
>>      test-punning.c:10:19: warning: dereferencing type-punned pointer might break strict-aliasing rules [-Wstrict-aliasing]
>>         10 |    return *(int *)&dummy;
>>            |                   ^~~~~~
>>      
>> Note the -Wstrict-aliasing=1 option, w/o =1 suffix it does not trigger.
>>
>> Grepping words "strict-aliasing", "strictaliasing", "strict_aliasing"
>> through clang code-base does not show any diagnostic related tests or
>> detection logic. It appears to me clang does not warn about strict
>> aliasing violations at all and -Wstrict-aliasing=* are just stubs at
>> the moment.
> Detecting strict aliasing violations can only be done by looking at
> particular code constructions (casts immediately followed by
> dereferencing for example) so GCC provides these three levels: 1, 2, and
> 3 which is the default.  Level 1 can result in false positives (hence
> the "might" in the warning message) while higher levels have less false
> positives, but will likely miss lots of real positives.

clang has not implemented this yet.

>
> In this case, it seems to me clear that a pointer to int does not alias
> a pointer to struct t.  So I would say, in this little program
> strict-aliasing=1 catches a real positive, while strict-aliasing=3
> misses a real positive.

This make sense. But could you pose the exact bpf compilation command
line which triggers strict-aliasing warning? Does the compiler command
line have -fstrict-aliasing?


