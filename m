Return-Path: <bpf+bounces-44798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 866AD9C7B23
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 19:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 131161F24E2E
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 18:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0720920DD47;
	Wed, 13 Nov 2024 18:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tK59r/pI"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF332076A6;
	Wed, 13 Nov 2024 18:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731522464; cv=none; b=jqT03nKTZ2JFJjG7IwjHfKryXvdQnV43kQbKkS7iJTxi+BoxRXvToIvpoftR8vc2r4L3v1aQBL9kx+LbiVvs5QyWqXjl+pHXa+OazcXVlEgvs+maioI3ZXwKTAk/+NenNFowdRvcTAcpURwM4MBfyscVopdHWkBIZpCEoe60NZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731522464; c=relaxed/simple;
	bh=E6exQRgO4sdK82FYXUgJ7ORg1cC4LHmn/GIadt+Xi3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DASnv8JFmwdODlsS7W7JFFKMQS38ljMSmD794nirlvH3l+dv1YZutLmoxKb1R8b+WUTa3BHt3miadoWOD5g3LoKFmihCPsYxV5/PPFx5dDHaqX3YUkfw3m62C647FYMdwIQ7kwpZGHUFRiBwSDKaPXq3U9XAuNMFCmnIplTK4PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tK59r/pI; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <548c7b6b-3b84-4053-baa7-72976731ab87@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731522460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wtq/hCa1avqHR2oznEXfOIIBcgWPUCwPcwLPqp3rxH0=;
	b=tK59r/pI3vHGzA1E1Vb/b0Or2d9yDK/P7Ko0+iD3P+ZEgxb0tosMamBfp5VYJuettaOUW7
	kpXUXSk4AnKUk7FY2UHXRI10MuJg5wvbtOfBOQ/M7Yt5rQSfdlNT9PVhHud+w4Y+kCjVRK
	6Ku2bmKNEQWyyUy/ycvlHr8IsnTK6Rs=
Date: Wed, 13 Nov 2024 10:27:32 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH dwarves 3/3] dwarf_loader: Check DW_OP_[GNU_]entry_value
 for possible parameter matching
Content-Language: en-GB
To: Alan Maguire <alan.maguire@oracle.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
 dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Song Liu <song@kernel.org>
References: <20241108180508.1196431-1-yonghong.song@linux.dev>
 <20241108180524.1198900-1-yonghong.song@linux.dev>
 <b32b2892-31b1-4dc0-8398-d8fadfaafcc6@oracle.com>
 <5be88704-1bb0-4332-8626-26e7c908184c@linux.dev>
 <e311899e-5502-4d46-b9ee-edc0ee9dd023@oracle.com>
 <48a2d5a2-38e0-4c36-90cc-122602ff6386@linux.dev>
 <5e640168-7753-413a-ab00-f297948e84ef@oracle.com> <ZzOoGJBiL-l6BfQd@x1>
 <71778df3-62a6-4b1d-9ccf-4a8eb0e23828@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <71778df3-62a6-4b1d-9ccf-4a8eb0e23828@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT




On 11/13/24 9:33 AM, Alan Maguire wrote:
> On 12/11/2024 19:10, Arnaldo Carvalho de Melo wrote:
>> On Tue, Nov 12, 2024 at 06:33:38PM +0000, Alan Maguire wrote:
>>> On 12/11/2024 17:07, Yonghong Song wrote:
>>>> On 11/12/24 8:56 AM, Alan Maguire wrote:
>>>>> On 12/11/2024 01:51, Yonghong Song wrote:
>>>>>> On 11/11/24 7:39 AM, Alan Maguire wrote:
>>>>> "for one of internal 6.11 kernel, there are 62498 functions in BTF and
>>>>> perf_event_read() is not there. With this patch, there are 61552
>>>>> functions in BTF and perf_event_read() is included."
>>>>> These numbers suggest you lost nearly 1000 functions when building
>>>>> vmlinux BTF with pahole using this series. That's the part I don't
>>>>> understand - we should just see a gain in numbers of functions in
>>>>> vmlinux BTF, right? Did you mean 62552 functions rather than 61552
>>>>> perhaps?tion
>>   
>>>> Sorry, really embarrassing. it is typo. Indeed it should be 62552 functions
>>>> in BTF instead.
>>   
>>> No problem, makes perfect sense now, thanks! I'm trying to reproduce the
>>> core dumps Eduard saw now with this setup; I'll report back if I manage
>>> to do so and see if locks as Jiri and Arnaldo suggested help. If so a v2
>>> along the lines of Eduard's suggested change plus locking might be the
>>> best approach, what do you think? Thanks!
>> So the idea is to try to see what are the data structures that are
>> being corrupted in the features we use from elfutils libraries and check
>> how they are being protected via their non-default enabled experimental
>> thread safety locks and then use it before calling their functions that
>> would use those locks.
>>
>> At some point we need to do some feature check to see if the lock is
>> enabled there and avoid adding it from pahole's side.
>>
>> I.e. a transitional strategy to keep pahole -j feature that works with
>> older elfutils versions as well as with modern, thread safe ones.
>>
>> This was used with the existing libdw__lock we have in the pahole
>> codebase with, AFAIK, good results.
>>
> Thanks for the additional info! From Eduard's analysis, it seems like it
> is safer to take the libdw__lock around dwarf_getlocation(s), since
> multiple threads can access the CU location cache. I've tried tweaking
> Eduard's modification of Yonghong's original patch and adding a second
> patch to add locking; with these two patches applied
>
> - we see the desired behaviour where perf_event_read() is present in
> BTF; and
> - we don't see any segmentation faults after ~700 iterations where I saw
> one every 200 or so before
>
> Yonghong, Eduard - do these changes look okay from your side? Feel free
> to resubmit if so (fixing up attributions as you see fit if they look
> wrong of course). Thanks!

Thanks Alan for working on this. The following are some suggestions for patch one:
   1. rename __dwarf_getlocations() to __parameter__locations()?
   2. rename param_reg_at_entry to parameter__locations()?
   3. You missed the following:
static int param_reg_at_entry(Dwarf_Attribute *attr, int expected_reg)
{
...
         if (first_expr)                     // this line
                 return first_expr->atom;    // this line
         return -1;
}

Patch 2 needs adjustment as well due to the above point #3.
Otherwise, LGTM. Since you are already preparing the patch,
please go ahead to pose v2 after you fixing the above things.

>
> Alan


