Return-Path: <bpf+bounces-70839-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D43CBD662C
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 23:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 004AC4F42D0
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 21:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB8C2F0C71;
	Mon, 13 Oct 2025 21:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ISUOs2Ip"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456F1246778
	for <bpf@vger.kernel.org>; Mon, 13 Oct 2025 21:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760391500; cv=none; b=VVv2J9BByaioYfCZ4iGHzRCPevuCrfJjEwz6gUl1OGWlHDSL4lAFx4fNA+0m45WACzHxQLaLx5e9zXHgqiUTCuVQawq908oSJyULJHUigA/W5I6sEv1zPe/Wj7HFA0U+APTrcHgg5QWMPZRcMDlRdOiibt3MuO2pITN5hKIrwV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760391500; c=relaxed/simple;
	bh=pECFziXIhSdziHO8AnV7jP8nihk0dFHntK2WI54iu1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kaux6W5ATZJ/rR+bZlK8noxY2lpUJmBXEebCTU21iJvFY0Mi+mRoikVGWltBYD1BysKD5l316TnjV4hG5d/UJQnQVGwQMPlRg+PI8n4Q0MpcKHl1GPYBtd4rcoE7qNMj6EdUgCYnprdUNo72g1f4CZ9Fs3a9iH6yI2gvEJfjpkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ISUOs2Ip; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3cf98c31-4475-4e4a-8ce0-bc9c62922313@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760391484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gWGxPhiuc07ov79HbmH+SO4fH0CF737w7R6sHM69aMo=;
	b=ISUOs2Ip2da67r7nxHfXeRWMbeyMY0blBbjnfFfmYRpJ3fE3gJmrPs54TqC3pholQwqqxn
	hQ5HajFfDCb9GuwNEIv64PjCZeSbAFAEyu0+hCGONLuuqT6rfX0HST16t53c+wzcmcKubl
	2HCZZ3AqHJRt1UyRQGROdXATYhGm4wY=
Date: Mon, 13 Oct 2025 14:37:54 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next RFC 0/2] Pass external callchain entry to
 get_perf_callchain
Content-Language: en-GB
To: Jiri Olsa <olsajiri@gmail.com>, Tao Chen <chen.dylane@linux.dev>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, song@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20251013174721.2681091-1-chen.dylane@linux.dev>
 <aO1j747N7pkBTBAb@krava>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <aO1j747N7pkBTBAb@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 10/13/25 1:41 PM, Jiri Olsa wrote:
> On Tue, Oct 14, 2025 at 01:47:19AM +0800, Tao Chen wrote:
>> Background
>> ==========
>> Alexei noted we should use preempt_disable to protect get_perf_callchain
>> in bpf stackmap.
>> https://lore.kernel.org/bpf/CAADnVQ+s8B7-fvR1TNO-bniSyKv57cH_ihRszmZV7pQDyV=VDQ@mail.gmail.com
>>
>> A previous patch was submitted to attempt fixing this issue. And Andrii
>> suggested teach get_perf_callchain to let us pass that buffer directly to
>> avoid that unnecessary copy.
>> https://lore.kernel.org/bpf/20250926153952.1661146-1-chen.dylane@linux.dev
>>
>> Proposed Solution
>> =================
>> Add external perf_callchain_entry parameter for get_perf_callchain to
>> allow us to use external buffer from BPF side. The biggest advantage is
>> that it can reduce unnecessary copies.
>>
>> Todo
>> ====
>> If the above changes are reasonable, it seems that get_callchain_entry_for_task
>> could also use an external perf_callchain_entry.
>>
>> But I'm not sure if this modification is appropriate. After all, the
>> implementation of get_callchain_entry in the perf subsystem seems much more
>> complex than directly using an external buffer.
>>
>> Comments and suggestions are always welcome.
>>
>> Tao Chen (2):
>>    perf: Use extern perf_callchain_entry for get_perf_callchain
>>    bpf: Pass external callchain entry to get_perf_callchain
> hi,
> I can't get this applied on bpf-next/master, what do I miss?

This path is not based on top of latest bpf/bpf-next tree.
The current diff:

  struct perf_callchain_entry *
-get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
-		   u32 max_stack, bool crosstask, bool add_mark)
+get_perf_callchain(struct pt_regs *regs, struct perf_callchain_entry *external_entry,
+		   u32 init_nr, bool kernel, bool user, u32 max_stack, bool crosstask,
+		   bool add_mark)
  {

The actual signature in kernel/events/callchain.c

struct perf_callchain_entry *
get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
                    u32 max_stack, bool crosstask, bool add_mark)
{


>
> thanks,
> jirka
>
>
>>   include/linux/perf_event.h |  5 +++--
>>   kernel/bpf/stackmap.c      | 19 +++++++++++--------
>>   kernel/events/callchain.c  | 18 ++++++++++++------
>>   kernel/events/core.c       |  2 +-
>>   4 files changed, 27 insertions(+), 17 deletions(-)
>>
>> -- 
>> 2.48.1
>>


