Return-Path: <bpf+bounces-3244-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF74173B2E9
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 10:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 533981C2108A
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 08:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB79717FC;
	Fri, 23 Jun 2023 08:50:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1BA10F7
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 08:50:58 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6C31706;
	Fri, 23 Jun 2023 01:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=TK9RukHDlDjrby2IyF7+J31ZsckbWp6T46JLpvbSxlc=; b=H0lw14iivXlqc3vMBLxKIMpWdT
	typiAsoDN7KmImH7Oi2XvfY5lKgMmUz+nD/jimGt7mS2jdfoCbXxlVOhyyduIFnQ38j8h5DaWT2pN
	zUZoepuuXx7/N5C/BTYwBcN/TO30bkdWw8Ga1r2iYkQ/Cpyr3fzW0+A/ImYy3I88C7JfYeulCg82e
	EZ8qHOS8qOhGmRfjcrg37Xsg4rsrBcqtK7C9R1RIXuAKGWlMtLb7mz0581U12E25YG7MZAUz0lCAV
	ni7ioufDkt4TY/9v8MT3uKCWrITVO+lnrnpEDVIPEOAABp60i1/JM7d1VnF5lx9QO4QRUaWYsML81
	mQhPw9NQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qCcVF-0009Zf-Qu; Fri, 23 Jun 2023 10:50:49 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qCcVF-0007SR-6L; Fri, 23 Jun 2023 10:50:49 +0200
Subject: Re: [PATCH bpf-next v3 1/2] net: bpf: Always call BPF cgroup filters
 for egress.
To: Kui-Feng Lee <sinquersw@gmail.com>, Yonghong Song <yhs@meta.com>,
 Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org, yhs@fb.com, kpsingh@kernel.org, shuah@kernel.org,
 john.fastabend@gmail.com, sdf@google.com, mykolal@fb.com,
 linux-kselftest@vger.kernel.org, jolsa@kernel.org, haoluo@google.com
Cc: Kui-Feng Lee <kuifeng@meta.com>
References: <20230620171409.166001-1-kuifeng@meta.com>
 <20230620171409.166001-2-kuifeng@meta.com>
 <4d46ba3a-61e9-2482-a359-7a8805f1dbc8@meta.com>
 <2693aaa4-eb33-553c-291c-3eb555452ea6@gmail.com>
 <94226479-8d79-cc83-9ecf-6db0b376a7fd@meta.com>
 <461e9be3-d533-d727-8ef9-0e20972ae0b4@iogearbox.net>
 <e22923d0-3241-2b2e-6c9e-c41cd6c10997@gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <674a12a9-3776-1637-f132-9c0bf692b18a@iogearbox.net>
Date: Fri, 23 Jun 2023 10:50:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <e22923d0-3241-2b2e-6c9e-c41cd6c10997@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26948/Fri Jun 23 09:28:15 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/23/23 1:55 AM, Kui-Feng Lee wrote:
> On 6/22/23 13:06, Daniel Borkmann wrote:
>> On 6/22/23 8:28 PM, Yonghong Song wrote:
>>> On 6/22/23 10:15 AM, Kui-Feng Lee wrote:
>>>> On 6/21/23 20:37, Yonghong Song wrote:
>>>>> On 6/20/23 10:14 AM, Kui-Feng Lee wrote:
>>>>>> Always call BPF filters if CGROUP BPF is enabled for EGRESS without
>>>>>> checking skb->sk against sk.
>>>>>>
>>>>>> The filters were called only if skb is owned by the sock that the
>>>>>> skb is sent out through.  In another words, skb->sk should point to
>>>>>> the sock that it is sending through its egress.  However, the filters would
>>>>>> miss SYNACK skbs that they are owned by a request_sock but sent through
>>>>>> the listening sock, that is the socket listening incoming connections.
>>>>>> This is an unnecessary restrict.
>>>>>
>>>>> The original patch which introduced 'sk == skb->sk' is
>>>>>    3007098494be  cgroup: add support for eBPF programs
>>>>> There are no mentioning in commit message why 'sk == skb->sk'
>>>>> is needed. So it is possible that this is just restricted
>>>>> for use cases at that moment. Now there are use cases
>>>>> where 'sk != skb->sk' so removing this check can enable
>>>>> the new use case. Maybe you can add this into your commit
>>>>> message so people can understand the history of 'sk == skb->sk'.
>>>>
>>>> After checking the code and the Alexei's comment[1] again, this check
>>>> may be different from what I thought. In another post[2],
>>>> Daniel Borkmann mentioned
>>>>
>>>>      Wouldn't that mean however, when you go through stacked devices that
>>>>      you'd run the same eBPF cgroup program for skb->sk multiple times?
>>>>
>>>> I read this paragraph several times.
>>>> This check ensures the filters are only called for the device on
>>>> the top of a stack.  So, I probably should change the check to
>>>>
>>>>      sk == skb_to_full_sk(skb)
>>>
>>> I think this should work. It exactly covers your use case:
>>>    they are owned by a request_sock but sent through
>>>    the listening sock, that is the socket listening incoming connections
>>> and sk == skb->sk for non request_sock/listening_sock case.
>>
>> Just a thought, should the test look like the below?
>>
>>          int __ret = 0;                                                         \
>>          if (cgroup_bpf_enabled(CGROUP_INET_EGRESS) && sk) {                    \
>>                  typeof(sk) __sk = sk_to_full_sk(sk);                           \
>>                  if (sk_fullsock(__sk) && __sk == skb_to_full_sk(skb) &&        \
>>                      cgroup_bpf_sock_enabled(__sk, CGROUP_INET_EGRESS))         \
>>                          __ret = __cgroup_bpf_run_filter_skb(__sk, skb,         \
>> CGROUP_INET_EGRESS); \
>> }                                                                      \
>>
>> Iow, we do already convert __sk to full sk, so we should then also use that
>> for the test with skb_to_full_sk(skb).
> 
> Agree!

It would also be useful to do an in-depth analysis for the commit msg in which
cases the sk == skb->sk matches and sk was not a full sock (but __sk is) given
the __sk = sk_to_full_sk(sk) exists in the code to document which situation this
is covering in the existing code (... perhaps it used to work back then for
synack just that later changes altered it without anyone noticing until now).

Thanks,
Daniel

