Return-Path: <bpf+bounces-27089-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B14E18A900A
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 02:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2D741C20FAE
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 00:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AD0628;
	Thu, 18 Apr 2024 00:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QuBm9MOT"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3889410E6
	for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 00:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713400147; cv=none; b=ue9oMO7wTI6KQi+VHvn0sFdEE/bytw0FgMkYs+Ulby6VKwKqywfrPD0rQkdj2WadmPZuH4zQ28fjYOdK/APl4ZQkE6sOyzJnBmeNUbCWKFRZ7/JkjJ9wfF/6VOT0FMVbRrNR4Bq9CWpTWRu3iw+W2kxDIUQw/F+BtjAqOJP6Y0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713400147; c=relaxed/simple;
	bh=GdggoZ1K60FrBpgzx76J4MEqArzYmkNfQKJR2YwNJ+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gCNyQEtixBQDgOAhQmZf0oHUg3H0QBGnxpg6dRCUv2QjxW7VfwdBxXkUImdkxlvZv8U78WsjAgOpRdi2J9Lh4amOHjpuvnCX8D6ccn6v/kkprOb+YMjmtsT+dFmccrbrdI0Wxe8Yuz1c+aLkOFfZ0Y6f+9vw4l6/yy++QcDRzuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QuBm9MOT; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f3f0388e-8884-4371-b96c-80d4ee34592d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713400144;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UfHNlhqRN7By/vmcB62J/IvapY2Y6zwl/VeN5q7bk08=;
	b=QuBm9MOTxx7wh8bAZC0nUNqpBFOifJvkES3LY/KhExjGmWDKIGxbwz+06VQcLsoD9VqdEv
	35LAR/8z6LEAcwHacElaCbuF5TR0c+3taQA067F/abUQgvh8IiLs5oaZ0nlToIEbtQRDK6
	C/H20xtMWM5AWfnDOz+kb7gGK3yUPBM=
Date: Wed, 17 Apr 2024 17:28:58 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v4 1/2] selftests/bpf: Add F_SETFL for fcntl in
 test_sockmap
To: Geliang Tang <geliang@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>,
 John Fastabend <john.fastabend@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org
References: <cover.1712639568.git.tanggeliang@kylinos.cn>
 <e4efa52c26ca5ae97c7e4e7570d8da9cd44df533.1712639568.git.tanggeliang@kylinos.cn>
 <e2aaa0f0-7641-4d26-9256-1151976235f1@linux.dev> <Zh+E5JlEM6fisrFS@t480>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <Zh+E5JlEM6fisrFS@t480>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/17/24 1:14 AM, Geliang Tang wrote:
> Hi Martin,
> 
> On Thu, Apr 11, 2024 at 11:10:49AM -0700, Martin KaFai Lau wrote:
>> On 4/8/24 10:18 PM, Geliang Tang wrote:
>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>
>>> Incorrect arguments are passed to fcntl() in test_sockmap.c when invoking
>>> it to set file status flags. If O_NONBLOCK is used as 2nd argument and
>>> passed into fcntl, -EINVAL will be returned (See do_fcntl() in fs/fcntl.c).
>>> The correct approach is to use F_SETFL as 2nd argument, and O_NONBLOCK as
>>> 3rd one.
>>>
>>> In nonblock mode, if EWOULDBLOCK is received, continue receiving, otherwise
>>> some subtests of test_sockmap fail.
>>>
>>> Fixes: 16962b2404ac ("bpf: sockmap, add selftests")
>>> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
>>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>>> ---
>>>    tools/testing/selftests/bpf/test_sockmap.c | 5 ++++-
>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
>>> index 024a0faafb3b..4feed253fca2 100644
>>> --- a/tools/testing/selftests/bpf/test_sockmap.c
>>> +++ b/tools/testing/selftests/bpf/test_sockmap.c
>>> @@ -603,7 +603,9 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
>>>    		struct timeval timeout;
>>>    		fd_set w;
>>> -		fcntl(fd, fd_flags);
>>> +		if (fcntl(fd, F_SETFL, fd_flags))
>>> +			goto out_errno;
>>> +
>>>    		/* Account for pop bytes noting each iteration of apply will
>>>    		 * call msg_pop_data helper so we need to account for this
>>>    		 * by calculating the number of apply iterations. Note user
>>> @@ -678,6 +680,7 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
>>>    					perror("recv failed()");
>>>    					goto out_errno;
>>>    				}
>>> +				continue;
>>
>>  From looking at it again, there is a select() earlier, so it should not hit
>> EWOULDBLOCK.
> 
> Can the patch in the attachment be accepted? It can work, but I'm not sure
> if it has changed the behavior of this test. Anyway, I would like to hear
> your opinion.

I don't know what is the correct expectation also. John and JakubS, can you take 
a look?

