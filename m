Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E022C403ABA
	for <lists+bpf@lfdr.de>; Wed,  8 Sep 2021 15:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhIHNdG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Sep 2021 09:33:06 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9408 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbhIHNdG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Sep 2021 09:33:06 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H4NGv5MFyz8yMW;
        Wed,  8 Sep 2021 21:27:35 +0800 (CST)
Received: from dggpeml500025.china.huawei.com (7.185.36.35) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 8 Sep 2021 21:31:56 +0800
Received: from [10.174.176.117] (10.174.176.117) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 8 Sep 2021 21:31:56 +0800
Subject: Re: [PATCH bpf] bpf: handle return value of BPF_PROG_TYPE_STRUCT_OPS
 prog
To:     Martin KaFai Lau <kafai@fb.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "KP Singh" <kpsingh@kernel.org>
References: <20210901085344.3052333-1-houtao1@huawei.com>
 <20210908060611.jylpjegug3gs5gys@kafai-mbp.dhcp.thefacebook.com>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <8e8dd070-ba19-2153-bf9b-8bbb16a70abb@huawei.com>
Date:   Wed, 8 Sep 2021 21:31:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210908060611.jylpjegug3gs5gys@kafai-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.176.117]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 9/8/2021 2:06 PM, Martin KaFai Lau wrote:
> On Wed, Sep 01, 2021 at 04:53:44PM +0800, Hou Tao wrote:
>> Currently if a function ptr in struct_ops has a return value, its
>> caller will get a random return value from it, because the return
>> value of related BPF_PROG_TYPE_STRUCT_OPS prog is just dropped.
>>
>> So adding a new flag BPF_TRAMP_F_RET_FENTRY_RET to tell bpf trampoline
>> to save and return the return value of struct_ops prog if ret_size of
>> the function ptr is greater than 0. Also restricting the flag to be
>> used alone.
> Thanks for the report and fix!  Sorry for the late reply.
>
> This bug is missed because the tcp-cc func is not always called.
> A better test needs to be created to force exercising these funcs
> in bpf_test_run(), which can be a follow-up patch in the bpf-next.
> Could you help to create this test as a follow up?

Yes, will do. The first thought comes into my mind is implementing .get_info hook

in a bpf tcp_congestion_ops and checking its return value in userspace by

getsockopt(fd, TCP_CC_INFO).  I also consider to add a new BPF struct_ops

for testing purpose, but it may be a little overkill.

> The patch lgtm.  However, it does not apply cleanly on bpf,
> so please rebase and repost.  I applied it manually and
> tested it by hard coding to call the ->ssthresh() and
> observes the return value.

I just check that it can be applied both on bpf and bpf-next, do you

have other commits in your tree ?

> .
