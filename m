Return-Path: <bpf+bounces-13551-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE79D7DA64F
	for <lists+bpf@lfdr.de>; Sat, 28 Oct 2023 11:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E74D01C21043
	for <lists+bpf@lfdr.de>; Sat, 28 Oct 2023 09:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD336D2F8;
	Sat, 28 Oct 2023 09:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A64B5664;
	Sat, 28 Oct 2023 09:59:13 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0398BE0;
	Sat, 28 Oct 2023 02:59:12 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.55])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SHZg160GZz1L9Hs;
	Sat, 28 Oct 2023 17:56:13 +0800 (CST)
Received: from [10.174.176.93] (10.174.176.93) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 28 Oct 2023 17:59:08 +0800
Message-ID: <44fd7a97-0558-a741-87be-3c784c4dbb9e@huawei.com>
Date: Sat, 28 Oct 2023 17:59:08 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH bpf-next v6 0/7] add BPF_F_PERMANENT flag for sockmap
 skmsg redirect
To: Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
	<john.fastabend@gmail.com>, <jakub@cloudflare.com>, <ast@kernel.org>,
	<andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<dsahern@kernel.org>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
References: <20231014121706.967988-1-liujian56@huawei.com>
 <65383d6f3d15c_1969a2084a@john.notmuch>
 <6e117922-e249-37cf-2327-55355de200e2@iogearbox.net>
From: "liujian (CE)" <liujian56@huawei.com>
In-Reply-To: <6e117922-e249-37cf-2327-55355de200e2@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.93]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected



On 2023/10/26 21:56, Daniel Borkmann wrote:
> On 10/24/23 11:55 PM, John Fastabend wrote:
>> Liu Jian wrote:
>>> v5->v6: Modified the description of the helper function.
>>> v4->v5: Fix one refcount bug caused by patch1.
>>> v3->v4: Change the two helpers's description.
>>>     Let BPF_F_PERMANENT takes precedence over apply/cork_bytes.
>>>
>>> Liu Jian (7):
>>>    bpf, sockmap: add BPF_F_PERMANENT flag for skmsg redirect
>>>    selftests/bpf: Add txmsg permanently test for sockmap
>>>    selftests/bpf: Add txmsg redir permanently test for sockmap
>>>    selftests/bpf: add skmsg verdict tests
>>>    selftests/bpf: add two skmsg verdict tests for BPF_F_PERMANENT flag
>>>    selftests/bpf: add tests for verdict skmsg to itself
>>>    selftests/bpf: add tests for verdict skmsg to closed socket
>>>
>>>   include/linux/skmsg.h                         |   1 +
>>>   include/uapi/linux/bpf.h                      |  45 +++++--
>>>   net/core/skmsg.c                              |   6 +-
>>>   net/core/sock_map.c                           |   4 +-
>>>   net/ipv4/tcp_bpf.c                            |  12 +-
>>>   tools/include/uapi/linux/bpf.h                |  45 +++++--
>>>   .../selftests/bpf/prog_tests/sockmap_basic.c  | 122 ++++++++++++++++++
>>>   .../selftests/bpf/progs/test_sockmap_kern.h   |   3 +-
>>>   .../bpf/progs/test_sockmap_msg_verdict.c      |  25 ++++
>>>   tools/testing/selftests/bpf/test_sockmap.c    |  41 +++++-
>>>   10 files changed, 272 insertions(+), 32 deletions(-)
>>>   create mode 100644 
>>> tools/testing/selftests/bpf/progs/test_sockmap_msg_verdict.c
>>>
>>
>> Reviewed-by: John Fastabend <john.fastabend@gmail.com>
> 
> Looks like this needs one last rebase, doesn't apply against bpf-next:
> 
The rebased patchset has been sent, thank you~

https://lore.kernel.org/all/20231028100552.2444158-1-liujian56@huawei.com/

> Switched to a new branch 'mbox'
> Applying: bpf, sockmap: Add BPF_F_PERMANENT flag for skmsg redirect
> Applying: selftests/bpf: Add txmsg permanently test for sockmap
> Applying: selftests/bpf: Add txmsg redir permanently test for sockmap
> Applying: selftests/bpf: Add skmsg verdict tests
> error: patch failed: 
> tools/testing/selftests/bpf/prog_tests/sockmap_basic.c:475
> error: tools/testing/selftests/bpf/prog_tests/sockmap_basic.c: patch 
> does not apply
> Patch failed at 0004 selftests/bpf: Add skmsg verdict tests
> hint: Use 'git am --show-current-patch' to see the failed patch
> 
> Thanks,
> Daniel

