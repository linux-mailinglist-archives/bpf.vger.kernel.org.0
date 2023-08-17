Return-Path: <bpf+bounces-8029-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73843780159
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 00:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C87C281279
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 22:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF4D1B7C7;
	Thu, 17 Aug 2023 22:56:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92774F9D5
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 22:56:55 +0000 (UTC)
Received: from out-26.mta1.migadu.com (out-26.mta1.migadu.com [IPv6:2001:41d0:203:375::1a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018D73A95
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 15:56:45 -0700 (PDT)
Message-ID: <fc66a75f-312e-8efd-2da9-d55e2391ea90@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692313004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/a2bfr+Ome5DVxPp6kaI5B+TytOOHJD7dEJCbU4E2ao=;
	b=iV3bx2Of85rhRy7102au3UOEDESzPwow/JwnQHdcfxS0zzRUDrulnJBh2mnQ2RAQEX7Kgf
	67kpmWmb94J1c8/kovAFtw/WzCUUuqHnTiFtL42VAFbCqF7o6wxDBvFT/6DMopKPzbWrZr
	Tog5p7o5q1RrFUEoc4aolv66639FmmM=
Date: Thu, 17 Aug 2023 15:56:40 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC bpf-next v3 4/5] bpf: Add a new dynptr type for
 CGRUP_SOCKOPT.
Content-Language: en-US
To: yonghong.song@linux.dev
Cc: bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, sdf@google.com,
 sinquersw@gmail.com, kuifeng@meta.com, thinker.li@gmail.com,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <20230815174712.660956-1-thinker.li@gmail.com>
 <20230815174712.660956-5-thinker.li@gmail.com>
 <20230817012518.erfkm4tgdm3isnks@MacBook-Pro-8.local>
 <f903808f-13c3-c440-c720-2051fe6ec4fe@linux.dev>
 <8e0fd701-0128-06a5-004e-c82a562691ee@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <8e0fd701-0128-06a5-004e-c82a562691ee@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/17/23 2:37 PM, Yonghong Song wrote:
> 
> 
> On 8/17/23 1:41 PM, Martin KaFai Lau wrote:
>> On 8/16/23 6:25 PM, Alexei Starovoitov wrote:
>>> But I think we have to step back. Why do we need this whole thing in the 
>>> first place?
>>> _why_  sockopt bpf progs needs to read and write user memory?
>>>
>>> Yes there is one page limit, but what is the use case to actually read and write
>>> beyond that? iptables sockopt was mentioned, but I don't think bpf prog can do
>>> anything useful with iptables binary blobs. They are hard enough for kernel 
>>> to parse.
>>
>> Usually the bpf prog is only interested in a very small number of optnames and 
>> no need to read the optval at all for most cases. The max size for our use 
>> cases is 16 bytes. The kernel currently is kind of doing it the opposite and 
>> always assumes the bpf prog needing to use the optval, allocate kernel memory 
>> and copy_from_user such that the non-sleepable bpf program can read/write it.
>>
>> The bpf prog usually checks the optname and then just returns for most cases:
>>
>> SEC("cgroup/getsockopt")
>> int get_internal_sockopt(struct bpf_sockopt *ctx)
>> {
>>      if (ctx->optname != MY_INTERNAL_SOCKOPT)
>>          return 1;
>>
>>      /* change the ctx->optval and return to user space ... */
>> }
>>
>> When the optlen is > PAGE_SIZE, the kernel only allocates PAGE_SIZE memory and 
>> copy the first PAGE_SIZE data from the user optval. We used to ask the bpf 
>> prog to explicitly set the optlen to 0 for > PAGE_SIZE case even it has not 
>> looked at the optval. Otherwise, the kernel used to conclude that the bpf prog 
>> had set an invalid optlen because optlen is larger than the optval_end - 
>> optval and returned -EFAULT incorrectly to the end-user.
>>
>> The bpf prog started doing this > PAGE_SIZE check and set optlen = 0 due to an 
>> internal kernel PAGE_SIZE limitation:
>>
>> SEC("cgroup/getsockopt")
>> int get_internal_sockopt(struct bpf_sockopt *ctx)
>> {
>>      if (ctx->optname != MY_INTERNAL_SOCKOPT) {
>>          /* only do that for ctx->optlen > PAGE_SIZE.
>>           * otherwise, the following cgroup bpf prog will
>>           * not be able to use the optval that it may
>>           * be interested.
>>           */
>>          if (ctx->optlen > PAGE_SIZE)
>>              ctx->optlen = 0;
>>          return 1;
>>      }
>>
>>      /* change the ctx->optval and return to user space ... */
>> }
>>
>> The above has been worked around in commit 29ebbba7d461 ("bpf: Don't EFAULT 
>> for {g,s}setsockopt with wrong optlen").
>>
>> Later, it was reported that an optname (NETLINK_LIST_MEMBERSHIPS) that the 
>> kernel allows a user passing NULL optval and using the optlen returned by 
>> getsockopt to learn the buffer space required. The bpf prog then needs to 
>> remove the optlen > PAGE_SIZE check and set optlen to 0 for _all_ optnames 
>> that it is not interested while risking the following cgroup prog may not be 
>> able to use some of the optval:
>>
>> SEC("cgroup/getsockopt")
>> int get_internal_sockopt(struct bpf_sockopt *ctx)
>> {
>>      if (ctx->optname != MY_INTERNAL_SOCKOPT) {
>>
>>          /* Do that for all optname that you are not interested.
>>           * The latter cgroup bpf will not be able to use the optval.
>>           */
>>           ctx->optlen = 0;
>>          return 1;
>>      }
>>
>>      /* chage the ctx->optval and return to user space ... */
>> }
>>
>> The above case has been addressed in commit 00e74ae08638 ("bpf: Don't EFAULT 
>> for getsockopt with optval=NULL").
>>
>> To avoid other potential optname cases that may run into similar situation and 
>> requires the bpf prog work around it again like the above, it needs a way to 
>> track whether a bpf prog has changed the optval in runtime. If it is not 
>> changed, use the result from the kernel 
> 
> Can we add a field in bpf_sockopt uapi struct so bpf_prog can set it
> if optval is changed?

This new interface should work. If there is an old-existing prog staying with 
the old interface (didn't set this bool but changed the optval) in the cgroup 
prog array, it probably end up not improving anything also?

or the verifier can enforce setting this bool in runtime when writing to optval? 
do not know how demanding the verifier change is. I am not sure if this would be 
an overkill for the verifier.

> 
> struct bpf_sockopt {
>          __bpf_md_ptr(struct bpf_sock *, sk);
>          __bpf_md_ptr(void *, optval);
>          __bpf_md_ptr(void *, optval_end);
> 
>          __s32   level;
>          __s32   optname;
>          __s32   optlen;
>          __s32   retval;
> };
> 
>> set/getsockopt. If reading/writing to optval is done through a kfunc, this can 
>> be tracked. The kfunc can also directly read/write the user memory in optval, 
>> avoid the pre-alloc kernel memory and the PAGE_SIZE limit but this is a minor 
>> point.


