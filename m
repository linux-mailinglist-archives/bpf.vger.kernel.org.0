Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B10862EE79
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 08:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbiKRHeP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 02:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241089AbiKRHeO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 02:34:14 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD73725C3
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 23:34:13 -0800 (PST)
Message-ID: <339eae51-675d-64a4-eef7-9ff70dba880c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668756851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fj2WqsQNSxfjRva/CHL8bOT8QlIwvQVBunEb7DsdmWw=;
        b=H2Wxkk4hDwgTWRK1jchRx5acX7YVSVxzVYBV65hoxo3fPWc39HPLqxr6lgx3RaRLclXKjy
        pNnnXZ20WG6qQ4n/Bb6Tftzv51huJKC/2HJ5Wxou5V+fPfyaYv33599ovaGBUkMOFPrFh5
        91b/+c5Lmnx+dwA53vk4YJmCn6iX3XE=
Date:   Thu, 17 Nov 2022 23:34:03 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2 1/3] bpf: Pin iterator link when opening iterator
Content-Language: en-US
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf <bpf@vger.kernel.org>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Hou Tao <houtao1@huawei.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Hao Luo <haoluo@google.com>
References: <20221111063417.1603111-1-houtao@huaweicloud.com>
 <20221111063417.1603111-2-houtao@huaweicloud.com>
 <33b5fc4e-be12-3aa8-b063-47aa998b951c@linux.dev>
 <CAADnVQ+Mxb8Wj3pODPovh9L1S+VDsj=4ufP3M70LQz4fSBaDww@mail.gmail.com>
 <CA+khW7gA3PgMwX5SmZELRdOATYeKN3XkAN9qKUWpjFU-M6YZjw@mail.gmail.com>
 <43bcd243-eea0-6cbe-b24b-640311fa1a83@linux.dev>
 <6159bf91-21c7-3fb0-e211-a40e85fd5bdc@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <6159bf91-21c7-3fb0-e211-a40e85fd5bdc@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/17/22 5:52 PM, Hou Tao wrote:
> Hi,
> 
> On 11/17/2022 2:48 PM, Martin KaFai Lau wrote:
>> On 11/15/22 6:48 PM, Hao Luo wrote:
>>> On Tue, Nov 15, 2022 at 5:37 PM Alexei Starovoitov
>>> <alexei.starovoitov@gmail.com> wrote:
>>>>
>>>> On Tue, Nov 15, 2022 at 11:16 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>>>>
>>>>> On 11/10/22 10:34 PM, Hou Tao wrote:
>>>>>> From: Hou Tao <houtao1@huawei.com>
>>>>>>
>>>>>> For many bpf iterator (e.g., cgroup iterator), iterator link acquires
>>>>>> the reference of iteration target in .attach_target(), but iterator link
>>>>>> may be closed before or in the middle of iteration, so iterator will
>>>>>> need to acquire the reference of iteration target as well to prevent
>>>>>> potential use-after-free. To avoid doing the acquisition in
>>>>>> .init_seq_private() for each iterator type, just pin iterator link in
>>>>>> iterator.
>>>>>
>>>>> iiuc, a link currently will go away when all its fds closed and pinned file
>>>>> removed.  After this change, the link will stay until the last iter is
>>>>> closed().
>>>>>     Before then, the user space can still "bpftool link show" and even get the
>>>>> link back by bpf_link_get_fd_by_id().  If this is the case, it would be useful
>>>>> to explain it in the commit message.
>>>>>
>>>>> and does this new behavior make sense when comparing with other link types?
>>>
>>> I think this is a unique problem in iter link. Because iter link is
>>> the only link type that can generate another object.
>>
>> Should a similar solution as in the current map iter be used then?
>>
>> I am thinking, after all link fds are closed and its pinned files are removed,
>> if it cannot stop the already created iter, it should at least stop new iter
>> from being created?
> Rather than adding the above logic for iterator link, just pinning the start
> cgroup in .init_seq_private() will be much simpler.

Yeah, it is better to fix the bug without changing the behavior when all the 
link fds are closed and pinned files are removed.  In particular this will make 
the link iter works differently from other link types.

I can see pinning a link inside an iter is a generic solution for all iter types 
but lets continue to explore other ways to refactor this within the kernel if it 
is really needed instead of leaking it to the user space.  (not saying this 
refactoring belongs to the same patch set.  lets fix the current bug first.)

> prepare_seq_file() has already acquired an extra reference of the currently
> attached program, so it is OK to read the iterator after the close of iterator
> link fd. So what do you think ?

Right, it is my understanding also that the prog refcnt has been acquired during 
the iter creation.
