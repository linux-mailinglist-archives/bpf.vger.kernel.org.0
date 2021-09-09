Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7D34046BE
	for <lists+bpf@lfdr.de>; Thu,  9 Sep 2021 10:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbhIIIHy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Sep 2021 04:07:54 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:15253 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhIIIHx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Sep 2021 04:07:53 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4H4s5B2ktcz1DGgL;
        Thu,  9 Sep 2021 16:05:50 +0800 (CST)
Received: from dggpemm500004.china.huawei.com (7.185.36.219) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 9 Sep 2021 16:06:43 +0800
Received: from [10.174.177.91] (10.174.177.91) by
 dggpemm500004.china.huawei.com (7.185.36.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 9 Sep 2021 16:06:42 +0800
Subject: Re: [PATCH -next] bpf: Add oversize check before call kvcalloc()
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>
References: <20210907060040.36222-1-cuibixuan@huawei.com>
 <CAEf4BzbEOpShbC1+iGo5DafFJc6U1gS9ytB2X_X0rqpWUfjbeg@mail.gmail.com>
From:   Bixuan Cui <cuibixuan@huawei.com>
Message-ID: <ecc54464-95dd-372d-a30a-9dac6c553a31@huawei.com>
Date:   Thu, 9 Sep 2021 16:06:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAEf4BzbEOpShbC1+iGo5DafFJc6U1gS9ytB2X_X0rqpWUfjbeg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500004.china.huawei.com (7.185.36.219)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2021/9/9 12:57, Andrii Nakryiko wrote:
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 047ac4b4703b..2a3955359156 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -9912,6 +9912,8 @@ static int check_btf_line(struct bpf_verifier_env *env,
>>         nr_linfo = attr->line_info_cnt;
>>         if (!nr_linfo)
>>                 return 0;
>> +       if (nr_linfo * sizeof(struct bpf_line_info) > INT_MAX)
>> +               return -EINVAL;
> I might be missing something, but on 64-bit architecture this can't
> overflow (because u32 is multiplied by fixed small sizeof()). And on
> 32-bit architecture if it overflows you won't catch it... So did you
> mean to do:
> 
> if (nr_lifo > INT_MAX / sizeof(struct bpf_line_info))
>     return -EINVAL;
> 
> ?
On 64-bit architecture, the value of INT_MAX may be equal to the 32-bit.
I get the same question:   https://stackoverflow.com/questions/9257065/int-max-in-32-bit-vs-64-bit-environment

And 'if (nr_lifo > INT_MAX / sizeof(struct bpf_line_info))' is correct on 32-bit architecture ;)

Thanks,
Bixuan Cui
> 
