Return-Path: <bpf+bounces-9072-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBD078F065
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 17:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBC5128163F
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 15:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0051F134BE;
	Thu, 31 Aug 2023 15:34:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB59EE57F;
	Thu, 31 Aug 2023 15:34:43 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255088F;
	Thu, 31 Aug 2023 08:34:42 -0700 (PDT)
Received: from kwepemd100003.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Rc4qm6QpmztSCQ;
	Thu, 31 Aug 2023 23:30:44 +0800 (CST)
Received: from [10.67.111.192] (10.67.111.192) by
 kwepemd100003.china.huawei.com (7.221.188.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.23; Thu, 31 Aug 2023 23:34:37 +0800
Message-ID: <818ce7b6-96ca-2644-de41-2c05de13a77c@huawei.com>
Date: Thu, 31 Aug 2023 23:34:36 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [BUG bpf-next] bpf/net: Hitting gpf when running selftests
Content-Language: en-US
To: Eduard Zingerman <eddyz87@gmail.com>, Jiri Olsa <olsajiri@gmail.com>
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>, Martin KaFai Lau
	<kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Hou Tao
	<houtao1@huawei.com>
References: <ZO+RQwJhPhYcNGAi@krava> <ZO+vetPCpOOCGitL@krava>
 <de816b89073544deb2ce34c4b242d583a6d4660f.camel@gmail.com>
 <082a6db6838d3aee5ca39eabd35d4da0c9691a0d.camel@gmail.com>
From: Xu Kuohai <xukuohai@huawei.com>
In-Reply-To: <082a6db6838d3aee5ca39eabd35d4da0c9691a0d.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.192]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd100003.china.huawei.com (7.221.188.180)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/31/2023 11:03 PM, Eduard Zingerman wrote:
> On Thu, 2023-08-31 at 13:52 +0300, Eduard Zingerman wrote:
>> On Wed, 2023-08-30 at 23:07 +0200, Jiri Olsa wrote:
>>> On Wed, Aug 30, 2023 at 08:58:11PM +0200, Jiri Olsa wrote:
>>>> hi,
>>>> I'm hitting crash below on bpf-next/master when running selftests,
>>>> full log and config attached
>>>
>>> it seems to be 'test_progs -t sockmap_listen' triggering that
>>
>> Hi,
>>
>> I hit it as well, use the following command to reproduce:
>>
>>    for i in $(seq 1 100); do \
>>      ./test_progs -a 'sockmap_listen/sockmap VSOCK test_vsock_redir' \
>>      | grep Summary; \
>>    done
>>
> 
> For what its worth, bisect points to the following commit:
> 147f3efaa241 ("sched/fair: Implement an EEVDF-like scheduling policy")
> 
> Which was merged into bpf-next 3 days ago as a part of:
> 3ca9a836ff53 ("Merge tag 'sched-core-2023-08-28' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip")
> 
> Scheduling changes uncovered some old race condition?
>

As replied in another mail, I think the issue is introduced by this commit:

405df89dd52c ("bpf, sockmap: Improved check for empty queue")


> [...]
> 
> 
> .


