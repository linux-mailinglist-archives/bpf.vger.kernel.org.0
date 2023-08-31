Return-Path: <bpf+bounces-9054-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6B178ED67
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 14:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A5D928154F
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 12:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AA111708;
	Thu, 31 Aug 2023 12:40:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085979470;
	Thu, 31 Aug 2023 12:40:20 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5948DCF2;
	Thu, 31 Aug 2023 05:40:19 -0700 (PDT)
Received: from kwepemd100003.china.huawei.com (unknown [172.30.72.57])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Rc1190zvcz1L9Cw;
	Thu, 31 Aug 2023 20:38:37 +0800 (CST)
Received: from [10.67.111.192] (10.67.111.192) by
 kwepemd100003.china.huawei.com (7.221.188.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.23; Thu, 31 Aug 2023 20:40:16 +0800
Message-ID: <0d01f06e-3f06-ba85-cd7e-34303e6ae043@huawei.com>
Date: Thu, 31 Aug 2023 20:40:16 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next] selftests/bpf: fix a CI failure caused by vsock
 write
Content-Language: en-US
To: Daniel Borkmann <daniel@iogearbox.net>, Xu Kuohai
	<xukuohai@huaweicloud.com>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC: Bobby Eshleman <bobby.eshleman@bytedance.com>
References: <20230831013105.2930824-1-xukuohai@huaweicloud.com>
 <9cf7982c-ec8a-4af9-98a8-549cd87dca70@iogearbox.net>
From: Xu Kuohai <xukuohai@huawei.com>
In-Reply-To: <9cf7982c-ec8a-4af9-98a8-549cd87dca70@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.192]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100003.china.huawei.com (7.221.188.180)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/31/2023 8:09 PM, Daniel Borkmann wrote:
> On 8/31/23 3:31 AM, Xu Kuohai wrote:
>> From: Xu Kuohai <xukuohai@huawei.com>
>>
>> While commit 90f0074cd9f9 ("selftests/bpf: fix a CI failure caused by vsock sockmap test")
>> fixes a receive failure of vsock sockmap test, there is still a write failure:
>>
>> Error: #211/79 sockmap_listen/sockmap VSOCK test_vsock_redir
>> Error: #211/79 sockmap_listen/sockmap VSOCK test_vsock_redir
>>    ./test_progs:vsock_unix_redir_connectible:1501: egress: write: Transport endpoint is not connected
>>    vsock_unix_redir_connectible:FAIL:1501
>>    ./test_progs:vsock_unix_redir_connectible:1501: ingress: write: Transport endpoint is not connected
>>    vsock_unix_redir_connectible:FAIL:1501
>>    ./test_progs:vsock_unix_redir_connectible:1501: egress: write: Transport endpoint is not connected
>>    vsock_unix_redir_connectible:FAIL:1501
>>
>> The reason is that the vsock connection in the test is set to ESTABLISHED state
>> by function virtio_transport_recv_pkt, which is executed in a workqueue thread,
>> so when the user space test thread runs before the workqueue thread, this
>> problem occurs.
>>
>> To fix it, before writing the connection, wait for it to be connected.
>>
>> Fixes: d61bd8c1fd02 ("selftests/bpf: add a test case for vsock sockmap")
>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> 
> Thanks for the fix! Looks like this is gone now at least in the tests which succeed,
> but there are still two issues:
> 
> 1) s390x fails in BPF CI as below:
> 
> https://github.com/kernel-patches/bpf/actions/runs/6031993528/job/16366784236
> 
> Error: #211 sockmap_listen
> Error: #211/79 sockmap_listen/sockmap VSOCK test_vsock_redir
>    Error: #211/79 sockmap_listen/sockmap VSOCK test_vsock_redir
>    ./test_progs:vsock_socketpair_connectible:1456: poll_connect: Invalid argument
>    vsock_socketpair_connectible:FAIL:1456
>    ./test_progs:vsock_unix_redir_connectible:1494: vsock_socketpair_connectible() failed
>    vsock_unix_redir_connectible:FAIL:1494
>    ./test_progs:vsock_socketpair_connectible:1456: poll_connect: Invalid argument
>    vsock_socketpair_connectible:FAIL:1456
>    ./test_progs:vsock_unix_redir_connectible:1494: vsock_socketpair_connectible() failed
>    vsock_unix_redir_connectible:FAIL:1494
>    ./test_progs:vsock_socketpair_connectible:1456: poll_connect: Invalid argument
>    vsock_socketpair_connectible:FAIL:1456
>    ./test_progs:vsock_unix_redir_connectible:1494: vsock_socketpair_connectible() failed
>    vsock_unix_redir_connectible:FAIL:1494
>    ./test_progs:vsock_socketpair_connectible:1456: poll_connect: Invalid argument
>    vsock_socketpair_connectible:FAIL:1456
>    ./test_progs:vsock_unix_redir_connectible:1494: vsock_socketpair_connectible() failed
>    vsock_unix_redir_connectible:FAIL:1494
> Error: #211/158 sockmap_listen/sockhash VSOCK test_vsock_redir
>    Error: #211/158 sockmap_listen/sockhash VSOCK test_vsock_redir
>    ./test_progs:vsock_socketpair_connectible:1456: poll_connect: Invalid argument
>    vsock_socketpair_connectible:FAIL:1456
>    ./test_progs:vsock_unix_redir_connectible:1494: vsock_socketpair_connectible() failed
>    vsock_unix_redir_connectible:FAIL:1494
>    ./test_progs:vsock_socketpair_connectible:1456: poll_connect: Invalid argument
>    vsock_socketpair_connectible:FAIL:1456
>    ./test_progs:vsock_unix_redir_connectible:1494: vsock_socketpair_connectible() failed
>    vsock_unix_redir_connectible:FAIL:1494
>    ./test_progs:vsock_socketpair_connectible:1456: poll_connect: Invalid argument
>    vsock_socketpair_connectible:FAIL:1456
>    ./test_progs:vsock_unix_redir_connectible:1494: vsock_socketpair_connectible() failed
>    vsock_unix_redir_connectible:FAIL:1494
>    ./test_progs:vsock_socketpair_connectible:1456: poll_connect: Invalid argument
>    vsock_socketpair_connectible:FAIL:1456
>    ./test_progs:vsock_unix_redir_connectible:1494: vsock_socketpair_connectible() failed
>    vsock_unix_redir_connectible:FAIL:1494
> 

Oops, I think it's because the esize variable is not initialized,
causing getsockopt to read a garbage value.

> 2) Various panics, some GPFs but also seen NULL pointer derefs, discussed in the other
>     thread: https://lore.kernel.org/bpf/ZO+RQwJhPhYcNGAi@krava/
>

still debugging ...

> I believe issue 1) might still be related to your fix in here, ptal.
> 
Sorry for introducing issue 1), will post a fix soon.

> Thanks,
> Daniel
> 
> .


