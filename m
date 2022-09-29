Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2665EEC7D
	for <lists+bpf@lfdr.de>; Thu, 29 Sep 2022 05:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbiI2Dhw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Sep 2022 23:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbiI2Dhp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Sep 2022 23:37:45 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EAB123D8A
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 20:37:42 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MdJq75SjZzlX6y;
        Thu, 29 Sep 2022 11:33:23 +0800 (CST)
Received: from [10.174.179.191] (10.174.179.191) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 29 Sep 2022 11:37:40 +0800
Message-ID: <17cd848b-d8c8-aadc-c1d8-9620b1a4440d@huawei.com>
Date:   Thu, 29 Sep 2022 11:37:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [bpf-next 00/11] bpf/selftests: convert some tests to ASSERT_*
 macros
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <haoluo@google.com>, <jolsa@kernel.org>, <mykolal@fb.com>,
        <shuah@kernel.org>, <delyank@fb.com>, <zhudi2@huawei.com>,
        <jakub@cloudflare.com>, <kuba@kernel.org>, <kuifeng@fb.com>,
        <deso@posteo.net>, <zhuyifei@google.com>, <hengqi.chen@gmail.com>,
        <bpf@vger.kernel.org>
References: <1664169131-32405-1-git-send-email-wangyufen@huawei.com>
 <CAEf4BzY4GARZ7C+rYDuCHAbMRrC=Fx7eVSBZ60txme97it2FLg@mail.gmail.com>
From:   wangyufen <wangyufen@huawei.com>
In-Reply-To: <CAEf4BzY4GARZ7C+rYDuCHAbMRrC=Fx7eVSBZ60txme97it2FLg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.191]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


在 2022/9/29 8:37, Andrii Nakryiko 写道:
> On Sun, Sep 25, 2022 at 9:51 PM Wang Yufen <wangyufen@huawei.com> wrote:
>> Convert some tests to use the preferred ASSERT_* macros instead of the
>> deprecated CHECK().
>>
>> Wang Yufen (11):
>>    bpf/selftests: convert sockmap_basic test to ASSERT_* macros
>>    bpf/selftests: convert sockmap_ktls test to ASSERT_* macros
>>    bpf/selftests: convert sockopt test to ASSERT_* macros
>>    bpf/selftests: convert sockopt_inherit test to ASSERT_* macros
>>    bpf/selftests: convert sockopt_multi test to ASSERT_* macros
>>    bpf/selftests: convert sockopt_sk test to ASSERT_* macros
>>    bpf/selftests: convert tcp_estats test to ASSERT_* macros
>>    bpf/selftests: convert tcp_hdr_options test to ASSERT_* macros
>>    bpf/selftests: convert tcp_rtt test to ASSERT_* macros
>>    bpf/selftests: convert tcpbpf_user test to ASSERT_* macros
>>    bpf/selftests: convert udp_limit test to ASSERT_* macros
>>
>>   .../selftests/bpf/prog_tests/sockmap_basic.c       | 87 ++++++++--------------
>>   .../selftests/bpf/prog_tests/sockmap_ktls.c        | 39 +++-------
>>   tools/testing/selftests/bpf/prog_tests/sockopt.c   |  4 +-
>>   .../selftests/bpf/prog_tests/sockopt_inherit.c     | 30 ++++----
>>   .../selftests/bpf/prog_tests/sockopt_multi.c       | 10 +--
>>   .../testing/selftests/bpf/prog_tests/sockopt_sk.c  |  2 +-
>>   .../testing/selftests/bpf/prog_tests/tcp_estats.c  |  4 +-
>>   .../selftests/bpf/prog_tests/tcp_hdr_options.c     | 80 +++++++-------------
>>   tools/testing/selftests/bpf/prog_tests/tcp_rtt.c   | 13 ++--
>>   .../testing/selftests/bpf/prog_tests/tcpbpf_user.c | 32 +++-----
>>   tools/testing/selftests/bpf/prog_tests/udp_limit.c | 18 ++---
>>   11 files changed, 117 insertions(+), 202 deletions(-)
>>
>> --
>> 1.8.3.1
>>
> Thanks for the clean up! I've changed one ASSERT_OK(err && errno !=
> ENOENT) to ASSERT_EQ(errno, ENOENT) in patch #1, that expresses the
> intent more directly. Please also keep in mind that patch prefix
> should (conventionally) be "selftests/bpf: ". I've fixed that for all
> patches while applying.

I got it.Thanks for the fixes.

>
> We are down to:
>
> $ rg -w CHECK | wc -l
> 1186
> 09/28 17:36:39.381
> andriin@devbig019:~/linux/tools/testing/selftests/bpf (master)
> $ rg -w CHECK_FAIL | wc -l
> 463
>
> Some ways to go still, but slowly decreasing. Thank you for your contribution!
