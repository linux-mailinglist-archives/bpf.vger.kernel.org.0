Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885245971F6
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 16:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240202AbiHQOwH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 10:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiHQOwH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 10:52:07 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA5D76478
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 07:52:04 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M79sR092gzmVpk;
        Wed, 17 Aug 2022 22:49:47 +0800 (CST)
Received: from [10.174.178.165] (10.174.178.165) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 17 Aug 2022 22:51:58 +0800
Subject: Re: [PATCH bpf-next] bpftool: Add trace subcommand
To:     Quentin Monnet <quentin@isovalent.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
References: <20220816151725.153343-1-weiyongjun1@huawei.com>
 <2ee546ac-cd2d-8418-1a54-7c799b626fa2@isovalent.com>
From:   "weiyongjun (A)" <weiyongjun1@huawei.com>
Message-ID: <e5968763-6ced-0f5e-9a2d-094b39e91256@huawei.com>
Date:   Wed, 17 Aug 2022 22:51:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <2ee546ac-cd2d-8418-1a54-7c799b626fa2@isovalent.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.165]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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


On 2022/8/17 18:14, Quentin Monnet wrote:
> On 16/08/2022 16:17, Wei Yongjun wrote:
>> Currently, only one command is supported
>>    bpftool trace pin <bpf_prog.o> <path>
>>
>> It will pin the trace bpf program in the object file <bpf_prog.o>
>> to the <path> where <path> should be on a bpffs mount.
>>
>> For example,
>>    $ bpftool trace pin ./mtd_mchp23k256.o /sys/fs/bpf/mchp23k256
>>
>> The implementation a BPF based backend for mockup mchp23k256 mtd
>> SPI device.
>>
>> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> Thanks a lot for the patch.
>
> However, I don't think it's a good idea to add the new "trace" command
> just for loading/attaching/pinning tracepoints programs. Instead I see
> two possible approaches.
>
> The first would be to extend support for program attachment. Bpftool is
> already able to load programs including tracepoints via "bpftool prog
> load", and it is able to attach some of them via "bpftool
> prog/net/cgroup attach". We don't support attaching tracing-related
> programs because at the time, BPF links didn't exist so we couldn't keep
> the programs running after bpftool exited, and after links were created
> nobody implemented it.
>
> So I would prefer that we extend this, by making bpftool able to attach
> (and pin the link for) tracing-related programs. Not necessarily just
> tracepoints by the way, it would be nice to have support for kprobes
> too. This could be by extending "bpftool prog attach" or creating
> "bpftool perf attach" ("bpftool perf" already focuses on tracing
> programs, so no need to add a new "trace" subcommand).


Thanks for your suggestion. I tried to make sense of what you mean.

With the first approach , we can attach program with following commands:

$ bpftool prog load smbus-xfer-default.o /sys/fs/bpf/testprog

$ bpftool prog

302: raw_tracepoint_writable  name smbus_xfer_default  tag 
90c6bea70fef5b14  gpl
         loaded_at 2022-08-17T14:17:44+0000  uid 0
         xlated 816B  not jited  memlock 4096B  map_ids 296,294,297
         btf_id 500

$ bpftool perf attach id 302 spi_transfer_writeable /sys/fs/bpf/tplink

Note: spi_transfer_writeable is the name of tracepoint


>
> Second approach: I realise that the above adds a constraint, because if
> we attach a program that was already loaded, we can't get the attach
> point from the section name in the ELF file, we need to pass it on the
> command line instead. I understand the desire for a one-step
> load-attach-pin_link, but with your new subcommand it would ignore all
> the work we've done on "bpftool prog load": support loading multiple
> programs from an ELF file, for reusing or pinning the maps, etc. So I
> would rather extend the existing "bpftool prog load(_all)" with a new
> keyword to tell bpftool to attach and create the link(s), if possible
> (when all relevant info for attaching is present in the ELF file), after
> loading the program(s).


Or add new keyword like 'pintp' to do one-step load-attach-pin_link:

$ bpftool prog load smbus-xfer-default.o /sys/fs/bpf/testprog pintp

and

$ bpftool prog loadall smbus-xfer-default.o /sys/fs/bpf/testprog pintp


>
> I'd really have the first approach in bpftool at some point, I haven't
> found the time to look into it just yet. The second one is probably
> closer to what you're looking to achieve, and would be nice to have as
> well. What do you think?


I will try to create the "bpftool perf attach" approach, if you agree 
with it.


Thanks,

Wei Yongjun


