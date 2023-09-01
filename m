Return-Path: <bpf+bounces-9101-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A3678FA0D
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 10:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 427C7281897
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 08:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8B6881E;
	Fri,  1 Sep 2023 08:38:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDCBEBE;
	Fri,  1 Sep 2023 08:38:15 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7503CDB;
	Fri,  1 Sep 2023 01:38:12 -0700 (PDT)
Received: from kwepemd100003.china.huawei.com (unknown [172.30.72.55])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RcWbJ22r0z1L8xr;
	Fri,  1 Sep 2023 16:36:28 +0800 (CST)
Received: from [10.67.111.192] (10.67.111.192) by
 kwepemd100003.china.huawei.com (7.221.188.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.23; Fri, 1 Sep 2023 16:38:08 +0800
Message-ID: <ee9ee99d-115a-f488-2de5-f402daa892a8@huawei.com>
Date: Fri, 1 Sep 2023 16:38:08 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next v2] selftests/bpf: fix a CI failure caused by
 vsock write
Content-Language: en-US
To: Daniel Borkmann <daniel@iogearbox.net>, Xu Kuohai
	<xukuohai@huaweicloud.com>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
CC: Bobby Eshleman <bobby.eshleman@bytedance.com>
References: <20230901031037.3314007-1-xukuohai@huaweicloud.com>
 <485647ed-e791-0781-afed-03c2d636a00b@iogearbox.net>
From: Xu Kuohai <xukuohai@huawei.com>
In-Reply-To: <485647ed-e791-0781-afed-03c2d636a00b@iogearbox.net>
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

On 9/1/2023 4:22 PM, Daniel Borkmann wrote:
> On 9/1/23 5:10 AM, Xu Kuohai wrote:
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
>> ---
>> v1->v2: initialize esize to sizeof(eval) to avoid getsockopt() reading
>> uninitialized value
>> ---
>>   .../bpf/prog_tests/sockmap_helpers.h          | 29 +++++++++++++++++++
>>   .../selftests/bpf/prog_tests/sockmap_listen.c |  5 ++++
>>   2 files changed, 34 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
>> index d12665490a90..abd13d96d392 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
>> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
>> @@ -179,6 +179,35 @@
>>           __ret;                                                         \
>>       })
>> +static inline int poll_connect(int fd, unsigned int timeout_sec)
>> +{
>> +    struct timeval timeout = { .tv_sec = timeout_sec };
>> +    fd_set wfds;
>> +    int r;
>> +    int eval;
>> +    socklen_t esize = sizeof(eval);
>> +
>> +    FD_ZERO(&wfds);
>> +    FD_SET(fd, &wfds);
>> +
>> +    r = select(fd + 1, NULL, &wfds, NULL, &timeout);
>> +    if (r == 0)
>> +        errno = ETIME;
>> +
>> +    if (r != 1)
>> +        return -1;
>> +
>> +    if (getsockopt(fd, SOL_SOCKET, SO_ERROR, &eval, &esize) < 0)
>> +        return -1;
>> +
>> +    if (eval != 0) {
>> +        errno = eval;
>> +        return -1;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   static inline int poll_read(int fd, unsigned int timeout_sec)
>>   {
>>       struct timeval timeout = { .tv_sec = timeout_sec };
>> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
>> index 5674a9d0cacf..2d3bf38677b6 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
>> @@ -1452,6 +1452,11 @@ static int vsock_socketpair_connectible(int sotype, int *v0, int *v1)
>>       if (p < 0)
>>           goto close_cli;
>> +    if (poll_connect(c, IO_TIMEOUT_SEC) < 0) {
>> +        FAIL_ERRNO("poll_connect");
>> +        goto close_cli;
>> +    }
>> +
>>       *v0 = p;
>>       *v1 = c;
>>
> 
> Should the error path rather be ?
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> index 2d3bf38677b6..8df8cbb447f1 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
> @@ -1454,7 +1454,7 @@ static int vsock_socketpair_connectible(int sotype, int *v0, int *v1)
> 
>          if (poll_connect(c, IO_TIMEOUT_SEC) < 0) {
>                  FAIL_ERRNO("poll_connect");
> -               goto close_cli;
> +               goto close_acc;
>          }
> 
>          *v0 = p;
> @@ -1462,6 +1462,8 @@ static int vsock_socketpair_connectible(int sotype, int *v0, int *v1)
> 
>          return 0;
> 
> +close_acc:
> +       close(p);
>   close_cli:
>          close(c);
>   close_srv:
> 
> 
> Let me know and I'll squash this into the fix.
>

Right, the accepted connection should be closed, thanks.

> Anyway, BPF CI went through fine, only the ongoing panic left to be fixed after that.
> 
> Thanks,
> Daniel
> 
> .


