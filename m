Return-Path: <bpf+bounces-7591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11151779501
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 18:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFBEF2824B3
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 16:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68DD11737;
	Fri, 11 Aug 2023 16:45:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F09F63B6
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 16:45:20 +0000 (UTC)
Received: from out-125.mta0.migadu.com (out-125.mta0.migadu.com [91.218.175.125])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF633599
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 09:45:18 -0700 (PDT)
Message-ID: <70aa78ee-5cc5-479a-efc6-d80eb4ede3ae@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691772316; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WyFmzg+gBIqGS8qSGxq1KY2vAHdT4jlo4y1hs1UML70=;
	b=Ame/n4pXu0tZtuDoE/KjPs77huRAlSWwkG76khhLo3tk+8GVvIRWC4V/4FNOzDQ6mqJo4X
	U15qOCzk0taNxxhdUAn7BafJjrBvb6fbDvdSVJzmTEAVSxDwf4B5YvMm2dVYAWWiquoqYI
	2N7/xUVI8kNBtW5UwjMTJA7uPtrb9kA=
Date: Fri, 11 Aug 2023 09:45:10 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCHv7 bpf-next 04/28] bpf: Add cookies support for
 uprobe_multi link
Content-Language: en-US
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Yafang Shao <laoar.shao@gmail.com>, bpf@vger.kernel.org,
 Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@chromium.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>
References: <20230809083440.3209381-1-jolsa@kernel.org>
 <20230809083440.3209381-5-jolsa@kernel.org>
 <ad33766a-3be9-0d77-bf98-add0ec42b206@linux.dev> <ZNY1asYGaZ9k3BtV@krava>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <ZNY1asYGaZ9k3BtV@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/11/23 6:19 AM, Jiri Olsa wrote:
> On Wed, Aug 09, 2023 at 09:39:53AM -0700, Yonghong Song wrote:
>>
>>
>> On 8/9/23 1:34 AM, Jiri Olsa wrote:
>>> Adding support to specify cookies array for uprobe_multi link.
>>>
>>> The cookies array share indexes and length with other uprobe_multi
>>> arrays (offsets/ref_ctr_offsets).
>>>
>>> The cookies[i] value defines cookie for i-the uprobe and will be
>>> returned by bpf_get_attach_cookie helper when called from ebpf
>>> program hooked to that specific uprobe.
>>>
>>> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>>> Acked-by: Yafang Shao <laoar.shao@gmail.com>
>>> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
>>
>> Ack with a minor nit below.
>>
>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
>>
>>> ---
>>>    include/uapi/linux/bpf.h       |  1 +
>>>    kernel/bpf/syscall.c           |  2 +-
>>>    kernel/trace/bpf_trace.c       | 45 +++++++++++++++++++++++++++++++---
>>>    tools/include/uapi/linux/bpf.h |  1 +
>>>    4 files changed, 44 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>>> index e48780951fc7..d7f4f50b1e58 100644
>>> --- a/include/uapi/linux/bpf.h
>>> +++ b/include/uapi/linux/bpf.h
>>> @@ -1639,6 +1639,7 @@ union bpf_attr {
>>>    				__aligned_u64	path;
>>>    				__aligned_u64	offsets;
>>>    				__aligned_u64	ref_ctr_offsets;
>>> +				__aligned_u64	cookies;
>>>    				__u32		cnt;
>>>    				__u32		flags;
>>>    			} uprobe_multi;
>>
>> The 'cookies' field is inserted into the middle of 'uprobe_multi'
>> struct. Not sure whether this may cause bug bisecting issue or not.
> 
> the idea is to have all fields related to the 'cnt' field grouped
> 
> so the problem is that the bisect reproducer would fail on previous
> patch because of the changed uprobe_multi layout, but it only got
> introduced in previous patch, so we are close ;-)
> 
> I don't think it's real problem but I guess I could add 'cookie'
> field in previous patch

I agree it should not be a real issue. Maybe let maintainers
to step in with their opinion.

> 
> thanks,
> jirka
> 

