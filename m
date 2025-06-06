Return-Path: <bpf+bounces-59885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FA3AD06C5
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 18:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 704AB7A9097
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 16:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597A4289343;
	Fri,  6 Jun 2025 16:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V4MRcB0w"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454551448E3
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 16:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749227873; cv=none; b=iWIPfw5o5TwTxOC8AVzafqAWY+Oe7CPVEAsYKXVZEGyH3kZ0rFf/oRWunAIt4F7aTxsQCtXgNCOGePF4ZhLK7rInK5lUB2g7eea6iq5LAISSrAzilL75QQljsQd9QlHCdVBb3ArOvvDw+7Pu1zgSh9MTasQnzUTVbSpb816d4lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749227873; c=relaxed/simple;
	bh=iNM4P6pKkuhu/6ob32+PYtBHFblWYXa1rhn7uHON4UU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HnfT2qoXhHDoUzMtg1QPznzI0Q//wtu9mYPa/UD9eRy8Ggnqk7SfGj/TE2vLF039SQT1f7Sh7v7Xtd9FFTxrynnKUKfyvEjWDjz2iAkTY7KLMb4tA1oP7nC+bmYoORKv1bLjKurvObmRxi/hM6IkWvuja9gn68U0xxAksMnr/I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V4MRcB0w; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <711f5fb8-b4c2-49d7-9c7a-bd300f6da040@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749227869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FxZmL24CoSYk40DKoSFiJPJVDRCxlaz9j9+YxgOKfbM=;
	b=V4MRcB0w+0sPrgejXOgKldglidboL7yZsoKKUmB5fZLNkhQ4jrbgYsrgIjNwnjC2g0iW8/
	pEfRYsQO13srhHi5/ybOqg/7BU0V14CSUTGde8pmzuZWc1P7uM0zM8Jb8ha7GKfaxa07AZ
	r+UwaK0qvFsKToVxKueMfEuT1Zu9eXY=
Date: Fri, 6 Jun 2025 09:37:37 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 0/4] selftests/bpf: Fix a few test failures with
 arm64 64KB page
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20250606032309.444401-1-yonghong.song@linux.dev>
 <CAEf4Bzb+rPo6bfYe71vOzAsqQb4JM6Gu-Hi66qPj0ioF=PFF9g@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAEf4Bzb+rPo6bfYe71vOzAsqQb4JM6Gu-Hi66qPj0ioF=PFF9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 6/6/25 9:30 AM, Andrii Nakryiko wrote:
> On Thu, Jun 5, 2025 at 8:23 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> My local arm64 host has 64KB page size and the VM to run test_progs
>> also has 64KB page size. There are a few self tests assuming 4KB page
>> and hence failed in my envorinment. Patch 1 tries to reduce long assert
> 
> typo: environment
> 
>> logs when tail failed. Patches 2-4 fixed three selftest failures.
> 
> How come our BPF CI doesn't catch this on aarch64?.. Ihor, any thoughts?

Because our aarch64 hosts use 4K pagesize...

$ uname -a
Linux ip-10-0-0-103.us-west-1.compute.internal 
5.10.228-219.884.amzn2.aarch64 #1 SMP Wed Oct 23 17:17:31 UTC 2024 
aarch64 aarch64 aarch64 GNU/Linux
[ec2-user@ip-10-0-0-103 ~]$ getconf PAGESIZE
4096


> 
>>
>> Yonghong Song (4):
>>    selftests/bpf: Reduce test_xdp_adjust_frags_tail_grow logs
>>    selftests/bpf: Fix bpf_mod_race test failure with arm64 64KB page size
>>    selftests/bpf: Fix ringbuf/ringbuf_write test failure with arm64 64KB
>>      page size
>>    selftests/bpf: Fix a user_ringbuf failure with arm64 64KB page size
>>
>>   .../selftests/bpf/prog_tests/bpf_mod_race.c    |  2 +-
>>   .../testing/selftests/bpf/prog_tests/ringbuf.c |  5 +++--
>>   .../selftests/bpf/prog_tests/user_ringbuf.c    |  6 ++++--
>>   .../selftests/bpf/prog_tests/xdp_adjust_tail.c | 18 ++++++++++++------
>>   .../selftests/bpf/progs/test_ringbuf_write.c   |  5 +++--
>>   5 files changed, 23 insertions(+), 13 deletions(-)
>>
>> --
>> 2.47.1
>>


