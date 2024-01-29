Return-Path: <bpf+bounces-20631-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 201EA84153B
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 22:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DE971F2451D
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 21:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422441586ED;
	Mon, 29 Jan 2024 21:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P6ymOUpa"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4792212B86
	for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 21:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706564934; cv=none; b=STkruxJyQzDri37fcr2u/FUzJnaVcYyJ3Q4Lh+yykF4gGz7mIYuvIWh32ZMiHjo/58xrjIujPyxYdIrFJwH0sYmvQvfKogkyDltsZvWKvTIB/HjcVWywpgEO7KZjBAicnEIc1bK9sj5vLQ1bn/e1Gbjn41sUf5mex2yHb13bYpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706564934; c=relaxed/simple;
	bh=MkF0aZ+WHQB4t2zAqaWKQUkGQPM8ehzdm3P+/haYSJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pL6NQeqcbhvSF+vIjO9KrJcUEsXDMeh21le9cY0kUN2LufbfwRHLa8A0LaFs213pekMuFe8aNxUQkUXQkH9utD4rXIPSfSWWFYCD4t5s25ywYAjrFkqiYfGSWN4BX8zj8e8748py7vDW8o8Eannk/V+UKGei9XQwqWoJgOlXK4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P6ymOUpa; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4653f596-ee27-417d-a590-5fdbd9ffc781@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706564929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g3ThxSCdgL98MzJBGlkUYaB0KA8o+FA60nzcbvXqWPY=;
	b=P6ymOUpa+pPyLgTHMLF1Hbabn2UgmB0wiyHGsP58myFaYkkmQrOuvLomPe/DOD3wfUecp7
	Vwf+D0Tuaa9GAUmu+6vZ9LudOiOsOH4DOjEylRIJw5f4tt5zJxOI5zmDr/FTIpjQaCNanH
	ZM9wqGMVUvh0EIr4L9H63hxBMu+I07k=
Date: Mon, 29 Jan 2024 13:48:42 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: BPF selftests and strict aliasing
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 david.faust@oracle.com, cupertino.miranda@oracle.com,
 Yonghong Song <yhs@meta.com>
References: <87plxmsg37.fsf@oracle.com>
 <b1906297-d784-479b-b2f3-07ab84ae99c1@linux.dev> <87a5opskz0.fsf@oracle.com>
 <04efa2a3-ca81-42c3-883f-5b91917f2bde@linux.dev>
 <6819204566bfae73c140938920eeb389d27abad8.camel@gmail.com>
 <87sf2gnk8w.fsf@oracle.com> <1b6daace-3c82-47c5-9b75-66051f8e3933@linux.dev>
 <875xzcnfp2.fsf@oracle.com>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <875xzcnfp2.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 1/29/24 10:43 AM, Jose E. Marchesi wrote:
>> On 1/29/24 9:05 AM, Jose E. Marchesi wrote:
>>>> On Sun, 2024-01-28 at 21:33 -0800, Yonghong Song wrote:
>>>> [...]
>>>>> I tried below example with the above prog/dynptr_fail.c case with gcc 11.4
>>>>> for native x86 target and didn't trigger the warning. Maybe this requires
>>>>> latest gcc? Or test C file is not sufficient enough to trigger the warning?
>>>>>
>>>>> [~/tmp1]$ cat t.c
>>>>> struct t {
>>>>>      char a;
>>>>>      short b;
>>>>>      int c;
>>>>> };
>>>>> void init(struct t *);
>>>>> long foo() {
>>>>>      struct t dummy;
>>>>>      init(&dummy);
>>>>>      return *(int *)&dummy;
>>>>> }
>>>>> [~/tmp1]$ gcc -Wall -Werror -O2 -g -Wno-compare-distinct-pointer-types -c t.c
>>>>> [~/tmp1]$ gcc --version
>>>>> gcc (GCC) 11.4.1 20230605 (Red Hat 11.4.1-2)
>>>> I managed to trigger this warning for gcc 13.2.1:
>>>>
>>>>       $ gcc -fstrict-aliasing -Wstrict-aliasing=1 -c test-punning.c -o /dev/null
>>>>       test-punning.c: In function ‘foo’:
>>>>       test-punning.c:10:19: warning: dereferencing type-punned pointer might break strict-aliasing rules [-Wstrict-aliasing]
>>>>          10 |    return *(int *)&dummy;
>>>>             |                   ^~~~~~
>>>>       Note the -Wstrict-aliasing=1 option, w/o =1 suffix it does not
>>>> trigger.
>>>>
>>>> Grepping words "strict-aliasing", "strictaliasing", "strict_aliasing"
>>>> through clang code-base does not show any diagnostic related tests or
>>>> detection logic. It appears to me clang does not warn about strict
>>>> aliasing violations at all and -Wstrict-aliasing=* are just stubs at
>>>> the moment.
>>> Detecting strict aliasing violations can only be done by looking at
>>> particular code constructions (casts immediately followed by
>>> dereferencing for example) so GCC provides these three levels: 1, 2, and
>>> 3 which is the default.  Level 1 can result in false positives (hence
>>> the "might" in the warning message) while higher levels have less false
>>> positives, but will likely miss lots of real positives.
>> clang has not implemented this yet.
>>
>>> In this case, it seems to me clear that a pointer to int does not alias
>>> a pointer to struct t.  So I would say, in this little program
>>> strict-aliasing=1 catches a real positive, while strict-aliasing=3
>>> misses a real positive.
>> This make sense. But could you pose the exact bpf compilation command
>> line which triggers strict-aliasing warning? Does the compiler command
>> line have -fstrict-aliasing?
> In GCC -fstrict-aliasing is activated at levels -O2, -O3 and -Os.  From
> a quick look at Clang.cpp, I _think_ it generally assumes strict
> aliasing when optimizing except when it tries to be compatible with
> Visual Studio C++ compilers (that clang-cl driver thingie.)

I double checked again. You are right, -fno-strict-aliasing does work
to disable strict-aliasing. Looks like clang also has -fstrict-alaising
as the default if optimization level is not O0. But somehow, clang
did not issue warnings...

>
>  From the GCC manual:
>
> '-fstrict-aliasing'
>       Allow the compiler to assume the strictest aliasing rules
>       applicable to the language being compiled.  For C (and C++), this
>       activates optimizations based on the type of expressions.  In
>       particular, an object of one type is assumed never to reside at the
>       same address as an object of a different type, unless the types are
>       almost the same.  For example, an 'unsigned int' can alias an
>       'int', but not a 'void*' or a 'double'.  A character type may alias
>       any other type.
>
>       Pay special attention to code like this:
>            union a_union {
>              int i;
>              double d;
>            };
>
>            int f() {
>              union a_union t;
>              t.d = 3.0;
>              return t.i;
>            }
>       The practice of reading from a different union member than the one
>       most recently written to (called "type-punning") is common.  Even
>       with '-fstrict-aliasing', type-punning is allowed, provided the
>       memory is accessed through the union type.  So, the code above
>       works as expected.  *Note Structures unions enumerations and
>       bit-fields implementation::.  However, this code might not:
>            int f() {
>              union a_union t;
>              int* ip;
>              t.d = 3.0;
>              ip = &t.i;
>              return *ip;
>            }
>
>       Similarly, access by taking the address, casting the resulting
>       pointer and dereferencing the result has undefined behavior, even

This is an alarm since enabling -fstrict-aliasing may produce
undefined behavior if the code is written in a strange way which
violates some casting rules. So -fno-strict-aliasing is the
right solution to address this potential undefined behavior.
We probably should not recommend -fno-strict-aliasing sicne it
may hurt performance and production bpf programs should be
more type friendly.

So I think your option (b) sounds good. Thanks!

>       if the cast uses a union type, e.g.:
>            int f() {
>              double d = 3.0;
>              return ((union a_union *) &d)->i;
>            }
>
>       The '-fstrict-aliasing' option is enabled at levels '-O2', '-O3',
>       '-Os'.

