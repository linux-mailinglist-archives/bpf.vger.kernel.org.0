Return-Path: <bpf+bounces-8981-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E8678D46E
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 10:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACBB92811D7
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 08:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F7D1C16;
	Wed, 30 Aug 2023 08:56:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714C5636;
	Wed, 30 Aug 2023 08:56:06 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D38CC9;
	Wed, 30 Aug 2023 01:56:03 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RbJ6l5tbMz4f3mWf;
	Wed, 30 Aug 2023 16:55:59 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP1 (Coremail) with SMTP id cCh0CgD3aygfBO9kp4dNBw--.49911S2;
	Wed, 30 Aug 2023 16:56:00 +0800 (CST)
Message-ID: <04e4df50-eed7-8944-0f0b-19bded6f37ef@huaweicloud.com>
Date: Wed, 30 Aug 2023 16:55:59 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH bpf v3 3/4] selftests/bpf: fix a CI failure caused by
 vsock sockmap test
Content-Language: en-US
To: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Cong Wang <cong.wang@bytedance.com>
References: <20230804073740.194770-1-xukuohai@huaweicloud.com>
 <20230804073740.194770-4-xukuohai@huaweicloud.com>
 <13ccc3b5-a392-9391-79ec-143a8701c1f5@iogearbox.net>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <13ccc3b5-a392-9391-79ec-143a8701c1f5@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgD3aygfBO9kp4dNBw--.49911S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWF1UGrWfCFyfZrW3KFW3ZFb_yoW5AF4UpF
	W5tFZ3tr4Ykr9a9FsYkF1DGFy0yrWvqw1UJryUZFy7X345Grn3CrZ0qrsIkF13trs5Za4r
	tF4qgay7X34kGaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
	14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
	9x07UWE__UUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/30/2023 4:10 PM, Daniel Borkmann wrote:
> Hi Xu,
> 
> On 8/4/23 9:37 AM, Xu Kuohai wrote:
>> From: Xu Kuohai <xukuohai@huawei.com>
>>
>> BPF CI has reported the following failure:
>>
>> Error: #200/79 sockmap_listen/sockmap VSOCK test_vsock_redir
>>    Error: #200/79 sockmap_listen/sockmap VSOCK test_vsock_redir
>>    ./test_progs:vsock_unix_redir_connectible:1506: egress: write: Transport endpoint is not connected
>>    vsock_unix_redir_connectible:FAIL:1506
>>    ./test_progs:vsock_unix_redir_connectible:1506: ingress: write: Transport endpoint is not connected
>>    vsock_unix_redir_connectible:FAIL:1506
>>    ./test_progs:vsock_unix_redir_connectible:1506: egress: write: Transport endpoint is not connected
>>    vsock_unix_redir_connectible:FAIL:1506
>>    ./test_progs:vsock_unix_redir_connectible:1514: ingress: recv() err, errno=11
>>    vsock_unix_redir_connectible:FAIL:1514
>>    ./test_progs:vsock_unix_redir_connectible:1518: ingress: vsock socket map failed, a != b
>>    vsock_unix_redir_connectible:FAIL:1518
>>    ./test_progs:vsock_unix_redir_connectible:1525: ingress: want pass count 1, have 0
>>
>> It’s because the recv(... MSG_DONTWAIT) syscall in the test case is
>> called before the queued work sk_psock_backlog() in the kernel finishes
>> executing. So the data to be read is still queued in psock->ingress_skb
>> and cannot be read by the user program. Therefore, the non-blocking
>> recv() reads nothing and reports an EAGAIN error.
>>
>> So replace recv(... MSG_DONTWAIT) with xrecv_nonblock(), which calls
>> select() to wait for data to be readable or timeout before calls recv().
>>
>> Fixes: d61bd8c1fd02 ("selftests/bpf: add a test case for vsock sockmap")
>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> 
> This is unfortunately still flaky and showing up from time to time in BPF CI, e.g. a
> very recent one can be found here:
> 
> https://github.com/kernel-patches/bpf/actions/runs/6021475685/job/16335248421
> 
> [...]
> Error: #211 sockmap_listen
> Error: #211/79 sockmap_listen/sockmap VSOCK test_vsock_redir
>    Error: #211/79 sockmap_listen/sockmap VSOCK test_vsock_redir
>    ./test_progs:vsock_unix_redir_connectible:1501: egress: write: Transport endpoint is not connected
>    vsock_unix_redir_connectible:FAIL:1501
>    ./test_progs:vsock_unix_redir_connectible:1501: ingress: write: Transport endpoint is not connected
>    vsock_unix_redir_connectible:FAIL:1501
>    ./test_progs:vsock_unix_redir_connectible:1501: egress: write: Transport endpoint is not connected
>    vsock_unix_redir_connectible:FAIL:1501
> 
> Could you continue to look into it to make the test more robust?
> 

OK, it looks like I only noticed the recv failure and ignored the
write failure. I'll take it a look.

> Thanks a lot,
> Daniel


