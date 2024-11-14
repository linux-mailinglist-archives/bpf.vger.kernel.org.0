Return-Path: <bpf+bounces-44850-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9409E9C8FC8
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 17:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58CE8282441
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 16:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F89217A583;
	Thu, 14 Nov 2024 16:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r69F1I7U"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0762F51C4A
	for <bpf@vger.kernel.org>; Thu, 14 Nov 2024 16:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731601759; cv=none; b=CNRrhpJxOBcFBlfBPNwCfxC1KqoaqNgSYCRSCeYEc8oW5WuryDG52JjaU95V2yAHRw049F0rAfPpnYLud5+R3CDRXRIqM+wfAJYNnfyikOTQGBH9IYvR9GDCFfOUY7OrkqPqPjlgwblaMeC/DMfnCRDaFyyG3fNhrgdPrC9z/V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731601759; c=relaxed/simple;
	bh=jHldP1zFkwmIw1b+wrZoVG3viZlbK8CqR1ZO3jsgYBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BQWd9EnNUjqoMjZa3FRqQKRE/rDV9kLXB5PqX1soqhLQrvwbS+k4d7dy1q6DCBX9Ep+1i+bXAEXbSQvx1/Z7BGfKSDC6OxyLNEFBZhjqc0FnJrNjvC3vML2RSqtOvn00HsdaxTNHwIO+wBGNr6QIxfmR4/XQlWCJq1cg/OBXuec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r69F1I7U; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5b777915-ef7f-4d21-8b23-cc79016aef32@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731601755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ACbkQ9EQubbduYBGoGWvNxCoW7nZ5amK3ybGUy2gQO8=;
	b=r69F1I7U+fciAP5/ZN8fYGBq4LZ5V16uzwLJ8BccECQ/HOeK4c94uLGw8dOu4T+Exbreys
	IZJDLfWkUVKxqgaCklS5c0RH3vJkJ4jU5y1ECbHGrPZyo0bFsIvUAyY5tTnxPx8CG2QgOh
	lyA9Me1QARcTehKwm8lOxOoGglWYb1Y=
Date: Thu, 14 Nov 2024 08:29:09 -0800
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
 <548c7b6b-3b84-4053-baa7-72976731ab87@linux.dev>
 <9bfe242b-b09b-47a5-9446-1cfc0897aef2@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <9bfe242b-b09b-47a5-9446-1cfc0897aef2@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT




On 11/14/24 4:16 AM, Alan Maguire wrote:
> On 13/11/2024 18:27, Yonghong Song wrote:
>>> Thanks for the additional info! From Eduard's analysis, it seems like it
>>> is safer to take the libdw__lock around dwarf_getlocation(s), since
>>> multiple threads can access the CU location cache. I've tried tweaking
>>> Eduard's modification of Yonghong's original patch and adding a second
>>> patch to add locking; with these two patches applied
>>>
>>> - we see the desired behaviour where perf_event_read() is present in
>>> BTF; and
>>> - we don't see any segmentation faults after ~700 iterations where I saw
>>> one every 200 or so before
>>>
>>> Yonghong, Eduard - do these changes look okay from your side? Feel free
>>> to resubmit if so (fixing up attributions as you see fit if they look
>>> wrong of course). Thanks!
>> Thanks Alan for working on this. The following are some suggestions for
>> patch one:
>>    1. rename __dwarf_getlocations() to __parameter__locations()?
>>    2. rename param_reg_at_entry to parameter__locations()?
> Since it returns the register number, what about
> __parameter_reg/parameter_reg()?
>
>>    3. You missed the following:
>> static int param_reg_at_entry(Dwarf_Attribute *attr, int expected_reg)
>> {
>> ...
>>          if (first_expr)                     // this line
>>                  return first_expr->atom;    // this line
>>          return -1;
>> }
>>
> I _think_ I've preserved the behaviour described by the comment at the
> start without using the first_expr code. Note that we set "ret" in the
> "case DW_OP_reg0 ... DW_OP_reg31:" clause of the switch statement, so
> will return that value; either directly, if the register number matches
> expected reg, or eventually if we don't find any DW_OP_*entry_value
> location info to return. This I think matches the described behaviour:
>
> /* For DW_AT_location 'attr':
>   * - if first location is DW_OP_regXX with expected number, returns the
> register;
>   * - if location DW_OP_entry_value(DW_OP_regXX) is in the list, returns
> the register;
>   * - if first location is DW_OP_regXX, returns the register;
>   * - otherwise returns -1.
>   */
>
> ...but again I may have missed something here.

I have some comments in v2 and will reply there.

>
>> Patch 2 needs adjustment as well due to the above point #3.
>> Otherwise, LGTM. Since you are already preparing the patch,
>> please go ahead to pose v2 after you fixing the above things.
>>
> Sure; if the above sounds okay, I'll submit the patches with updates.
> After testing over 2000 iterations of pahole, I haven't seen a
> segmentation fault so I _think_ the locking in patch 2 is sufficient to
> avoid crashes.
>
> Thanks!
>
> Alan
>
>>> Alan


