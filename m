Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCED5A288D
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 15:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344349AbiHZN3o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 09:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344335AbiHZN3l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 09:29:41 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C51D9D7B
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 06:29:39 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MDgcp56VTzGpcB;
        Fri, 26 Aug 2022 21:27:54 +0800 (CST)
Received: from [10.174.178.165] (10.174.178.165) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 26 Aug 2022 21:29:36 +0800
Subject: Re: [PATCH bpf-next v2] bpftool: implement perf attach command
To:     Quentin Monnet <quentin@isovalent.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
References: <20220824033837.458197-1-weiyongjun1@huawei.com>
 <b942bf8f-204b-6bf1-7847-ec5f11c50ca0@isovalent.com>
 <CAEf4BzafSAZfhkun5PBGODw6v1s10Nh4JeH8azdqZY-62kBCKg@mail.gmail.com>
 <ee620e99-dc04-aa2c-f53b-b875dba79feb@isovalent.com>
From:   "weiyongjun (A)" <weiyongjun1@huawei.com>
Message-ID: <8679b084-c22c-aca2-a9c1-003984a443c5@huawei.com>
Date:   Fri, 26 Aug 2022 21:29:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <ee620e99-dc04-aa2c-f53b-b875dba79feb@isovalent.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.165]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Quentin,

On 2022/8/26 18:45, Quentin Monnet wrote:
> Hi Andrii,
> 
> On 25/08/2022 19:37, Andrii Nakryiko wrote:
>> On Thu, Aug 25, 2022 at 8:28 AM Quentin Monnet <quentin@isovalent.com> wrote:
>>>
>>> Hi Wei,
>>>
>>> Apologies for failing to answer to your previous email and for the delay
>>> on this one, I just found out GMail had classified them as spam :(.
>>>
>>> So as for your last message, yes: your understanding of my previous
>>> answer was correct. Thanks for the patch below! Some comments inline.
>>>
>>
>> Do we really want to add such a specific command to bpftool that would
>> attach BPF object files with programs of only RAW_TRACEPOINT and
>> RAW_TRACEPOINT_WRITABLE type?
>>
>> I could understand if we added something that would be equivalent of
>> BPF skeleton's auto-attach method. That would make sense in some
>> contexts, especially for some quick testing and validation, to avoid
>> writing (a rather simple) user-space loading code.
> 
> Do you mean loading and attaching in a single step, or keeping the
> possibility to load first as in the current proposal?
> 
>>
>> But "perf attach" for raw_tp programs only? Seem way too limited and
>> specific, just adding bloat to bpftool, IMO.
> 
> We already support attaching some kinds of program types through
> "prog|cgroup|net attach". Here I thought we could add support for other
> types as a follow-up, but thinking again, you're probably right, it
> would be best if all the types were supported from the start. Wei, have
> you looked into how much work it would be to add support for
> tracepoints, k(ret)probes, u(ret)probes as well? The code should be
> mostly identical?


Will post in next version with all other comments fixed after some 
testing for them.


Regrads,

Wei Yongjun
