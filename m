Return-Path: <bpf+bounces-20620-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F0B8411CC
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 19:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A39A1F23735
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 18:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48903F9DC;
	Mon, 29 Jan 2024 18:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jPHgsN95"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0A73F9E0
	for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 18:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706551939; cv=none; b=ABWXBGI0ydD6zC9RtJmf7QuzbAgAa1po6n5pIox/7OULnOFM8R83Dd8fGMAcBFfMueQkWk2fgmbRu0imD6C8OcnD0Q0XMJ8R8YbIYTiHaI8uXQPyK2gDrYf3GmIqxqslaLTlnMhe6bhxpOQgt7De31QE4MEAGObY3E+SQ3G6ylU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706551939; c=relaxed/simple;
	bh=/aPw/Vras4z5qrqUBTReUDMq4mb8pNZE32Zbg4S6Eos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IKmwblvyKpSyaN59+sLgEneShc8ABBfm0sVIQZymXfavSC28/d55pLVwPOhxTHBYQtdfhr4adq0l5a5/as42SahMqo+xgzuVswYV4oItIsM/TF3Xwh19OfLTRwVxtXKgtYpUr9P4XxbDwOUjnXxIstfUWszxxuP566OeAwuRgU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jPHgsN95; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bae1205a-b6e5-4e46-8e20-520d7c327f7a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706551934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mBbm0/mie6m3In5I/whNFHUIJb0ZIvdLo/QMlbD3dRE=;
	b=jPHgsN95fk5JTAA6dDalr0XrHlgZxF5ko8bnjTaUmXa7tt7zHpUDqP4AhtRY1Jqc8WfV28
	ArmjkWyxPb1+Aidd5oVxpKVekUvcXqMuxTMKKHNFmoSPhI5SYPh4lSqPpDixmFBiX64jjE
	377dhxQ7RsOW58kih2x2bEGjjUhcYa0=
Date: Mon, 29 Jan 2024 10:12:10 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: BPF selftests and strict aliasing
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>,
 "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: bpf@vger.kernel.org, david.faust@oracle.com,
 cupertino.miranda@oracle.com, Yonghong Song <yhs@meta.com>
References: <87plxmsg37.fsf@oracle.com>
 <b1906297-d784-479b-b2f3-07ab84ae99c1@linux.dev> <87a5opskz0.fsf@oracle.com>
 <04efa2a3-ca81-42c3-883f-5b91917f2bde@linux.dev>
 <6819204566bfae73c140938920eeb389d27abad8.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <6819204566bfae73c140938920eeb389d27abad8.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 1/29/24 8:15 AM, Eduard Zingerman wrote:
> On Sun, 2024-01-28 at 21:33 -0800, Yonghong Song wrote:
> [...]
>> I tried below example with the above prog/dynptr_fail.c case with gcc 11.4
>> for native x86 target and didn't trigger the warning. Maybe this requires
>> latest gcc? Or test C file is not sufficient enough to trigger the warning?
>>
>> [~/tmp1]$ cat t.c
>> struct t {
>>     char a;
>>     short b;
>>     int c;
>> };
>> void init(struct t *);
>> long foo() {
>>     struct t dummy;
>>     init(&dummy);
>>     return *(int *)&dummy;
>> }
>> [~/tmp1]$ gcc -Wall -Werror -O2 -g -Wno-compare-distinct-pointer-types -c t.c
>> [~/tmp1]$ gcc --version
>> gcc (GCC) 11.4.1 20230605 (Red Hat 11.4.1-2)
> I managed to trigger this warning for gcc 13.2.1:
>
>      $ gcc -fstrict-aliasing -Wstrict-aliasing=1 -c test-punning.c -o /dev/null
>      test-punning.c: In function ‘foo’:
>      test-punning.c:10:19: warning: dereferencing type-punned pointer might break strict-aliasing rules [-Wstrict-aliasing]
>         10 |    return *(int *)&dummy;
>            |                   ^~~~~~
>      
> Note the -Wstrict-aliasing=1 option, w/o =1 suffix it does not trigger.

Thanks for confirmation. My question is that in our selftests bpf compilation, we do
not have -fstrict-aliasing flag, so even for gcc we should not have strict-aliasing
warning, right?

Jose, did I miss anything? Or you added -fstrict-aliasing to the compilation flag
to selftests/bpf Makefile?

>
> Grepping words "strict-aliasing", "strictaliasing", "strict_aliasing"
> through clang code-base does not show any diagnostic related tests or
> detection logic. It appears to me clang does not warn about strict
> aliasing violations at all and -Wstrict-aliasing=* are just stubs at
> the moment.

I also did some search in clang source. This appears indeed the case.


