Return-Path: <bpf+bounces-14554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 407427E6422
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 08:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70E721C2092D
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 07:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D715685;
	Thu,  9 Nov 2023 07:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xP7c/jwJ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01622D2FE
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 07:02:33 +0000 (UTC)
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [IPv6:2001:41d0:203:375::bc])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0943F1BD4
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 23:02:33 -0800 (PST)
Message-ID: <ff0266b2-8388-9027-4e85-4fee9d83f17f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1699513351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rg43e9EGuY29+DwLxNfHIdPIVijZmIPOE0t2Sf1Egco=;
	b=xP7c/jwJmgF8C+vgFMUwt/0j5UdcarvGEqOH2WR63q0LPiqSGgofeI+yt2nciK2kBOfjnU
	toLaaxYLF5wIiNdPoWm9MeeCFi6kluo9ccmBmiwE9rXRJuaGtt5G2T+q8YFn95kIGHsgQF
	6K3IumcTHlHQOA0Hc4Ke1jx+lkArRTk=
Date: Wed, 8 Nov 2023 23:02:23 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf 01/11] bpf: Check rcu_read_lock_trace_held() before
 calling bpf map helpers
Content-Language: en-US
To: Hou Tao <houtao@huaweicloud.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com,
 bpf@vger.kernel.org
References: <20231107140702.1891778-1-houtao@huaweicloud.com>
 <20231107140702.1891778-2-houtao@huaweicloud.com>
 <fcca87f3-8a92-2220-5a4a-cfa2851eac02@linux.dev>
 <94fcdeab-4095-fca9-d901-25e6dee0d832@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <94fcdeab-4095-fca9-d901-25e6dee0d832@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 11/8/23 7:46 PM, Hou Tao wrote:
> Hi,
> 
> On 11/9/2023 7:11 AM, Martin KaFai Lau wrote:
>> On 11/7/23 6:06 AM, Hou Tao wrote:
>>> From: Hou Tao <houtao1@huawei.com>
>>>
>>> These three bpf_map_{lookup,update,delete}_elem() helpers are also
>>> available for sleepable bpf program, so add the corresponding lock
>>> assertion for sleepable bpf program, otherwise the following warning
>>> will be reported when a sleepable bpf program manipulates bpf map under
>>> interpreter mode (aka bpf_jit_enable=0):
>>>
> SNIP
>>>    BPF_CALL_2(bpf_map_lookup_elem, struct bpf_map *, map, void *, key)
>>>    {
>>> -    WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_bh_held());
>>> +    WARN_ON_ONCE(!rcu_read_lock_held() &&
>>> !rcu_read_lock_trace_held() &&
>>> +             !rcu_read_lock_bh_held());
>>>        return (unsigned long) map->ops->map_lookup_elem(map, key);
>>>    }
>>>    @@ -53,7 +54,8 @@ const struct bpf_func_proto
>>> bpf_map_lookup_elem_proto = {
>>>    BPF_CALL_4(bpf_map_update_elem, struct bpf_map *, map, void *, key,
>>>           void *, value, u64, flags)
>>>    {
>>> -    WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_bh_held());
>>> +    WARN_ON_ONCE(!rcu_read_lock_held() &&
>>> !rcu_read_lock_trace_held() &&
>>> +             !rcu_read_lock_bh_held());
>>>        return map->ops->map_update_elem(map, key, value, flags);
>>>    }
>>>    @@ -70,7 +72,8 @@ const struct bpf_func_proto
>>> bpf_map_update_elem_proto = {
>>>      BPF_CALL_2(bpf_map_delete_elem, struct bpf_map *, map, void *, key)
>>>    {
>>> -    WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_bh_held());
>>> +    WARN_ON_ONCE(!rcu_read_lock_held() &&
>>> !rcu_read_lock_trace_held() &&
>>> +             !rcu_read_lock_bh_held());
>>
>> Should these WARN_ON_ONCE be removed from the helpers instead?
>>
>> For catching error purpose, the ops->map_{lookup,update,delete}_elem
>> are inlined  for the jitted case which I believe is the bpf-CI setting
>> also. Meaning the above change won't help to catch error in the common
>> normal case.
> 
> Removing these WARN_ON_ONCE is also an option. Considering JIT is not
> available for all architectures and there is no KASAN support in JIT,
> could we enable BPF interpreter mode in BPF CI to find more potential
> problems ?

ah. The test in patch 11 needs jit to be off because the map_gen_lookup inlined 
the code? Would it help to use bpf_map_update_elem(inner_map,...) to trigger the 
issue instead?

> 
>>
>>>        return map->ops->map_delete_elem(map, key);
>>>    }
>>>    
>>
>>
>> .
> 


