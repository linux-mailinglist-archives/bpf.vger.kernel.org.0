Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8373262D396
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 07:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbiKQGtE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 01:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbiKQGtD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 01:49:03 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09B7532E1
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 22:49:01 -0800 (PST)
Message-ID: <43bcd243-eea0-6cbe-b24b-640311fa1a83@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668667739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DbFdZqyR/IcbE2815pvpT0gkN9Pqj+nQe3cjmyP0e4s=;
        b=gfM3Hl6UhOZsf88yQpkkRe7DOVIc37je6lIN/f8Rr8hObRu5CUrhpOBIVC9n6We7suh7RO
        5MCu5AhqhhpXN1RIj8FyMH6s+pzqH4dJ/e5UgircIKQqLic11vzvRXI2D2T5O6HH0uZTgh
        bjTYt80797NzZ1VOASdqsyz10uMQXQ8=
Date:   Wed, 16 Nov 2022 22:48:54 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2 1/3] bpf: Pin iterator link when opening iterator
Content-Language: en-US
To:     Hao Luo <haoluo@google.com>, Hou Tao <houtao@huaweicloud.com>
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
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <20221111063417.1603111-1-houtao@huaweicloud.com>
 <20221111063417.1603111-2-houtao@huaweicloud.com>
 <33b5fc4e-be12-3aa8-b063-47aa998b951c@linux.dev>
 <CAADnVQ+Mxb8Wj3pODPovh9L1S+VDsj=4ufP3M70LQz4fSBaDww@mail.gmail.com>
 <CA+khW7gA3PgMwX5SmZELRdOATYeKN3XkAN9qKUWpjFU-M6YZjw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CA+khW7gA3PgMwX5SmZELRdOATYeKN3XkAN9qKUWpjFU-M6YZjw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/15/22 6:48 PM, Hao Luo wrote:
> On Tue, Nov 15, 2022 at 5:37 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Tue, Nov 15, 2022 at 11:16 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>>
>>> On 11/10/22 10:34 PM, Hou Tao wrote:
>>>> From: Hou Tao <houtao1@huawei.com>
>>>>
>>>> For many bpf iterator (e.g., cgroup iterator), iterator link acquires
>>>> the reference of iteration target in .attach_target(), but iterator link
>>>> may be closed before or in the middle of iteration, so iterator will
>>>> need to acquire the reference of iteration target as well to prevent
>>>> potential use-after-free. To avoid doing the acquisition in
>>>> .init_seq_private() for each iterator type, just pin iterator link in
>>>> iterator.
>>>
>>> iiuc, a link currently will go away when all its fds closed and pinned file
>>> removed.  After this change, the link will stay until the last iter is closed().
>>>    Before then, the user space can still "bpftool link show" and even get the
>>> link back by bpf_link_get_fd_by_id().  If this is the case, it would be useful
>>> to explain it in the commit message.
>>>
>>> and does this new behavior make sense when comparing with other link types?
> 
> I think this is a unique problem in iter link. Because iter link is
> the only link type that can generate another object.

Should a similar solution as in the current map iter be used then?

I am thinking, after all link fds are closed and its pinned files are removed, 
if it cannot stop the already created iter, it should at least stop new iter 
from being created?


