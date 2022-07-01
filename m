Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCBC563446
	for <lists+bpf@lfdr.de>; Fri,  1 Jul 2022 15:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiGANWC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Jul 2022 09:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiGANWB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Jul 2022 09:22:01 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AA76051C
        for <bpf@vger.kernel.org>; Fri,  1 Jul 2022 06:22:00 -0700 (PDT)
Received: from sslproxy04.your-server.de ([78.46.152.42])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1o7Gas-0008IS-2V; Fri, 01 Jul 2022 15:21:58 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1o7Gar-000May-Po; Fri, 01 Jul 2022 15:21:57 +0200
Subject: Re: [PATCH bpf-next] selftests/bpf: skip lsm_cgroup when don't have
 trampolines
To:     Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org
References: <20220630224203.512815-1-sdf@google.com>
 <CA+khW7ixZWuKPXk0f-8=BNSUUWopKgkKJ8ev+KJ9oJdf8AyUQg@mail.gmail.com>
 <CAKH8qBv=3hMzpTy=K-n5+rObPhkns0gjJibVFHhNgG7ojrrMVQ@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <bf5f2bcb-9c19-f5a7-f74c-cee874def883@iogearbox.net>
Date:   Fri, 1 Jul 2022 15:21:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAKH8qBv=3hMzpTy=K-n5+rObPhkns0gjJibVFHhNgG7ojrrMVQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26590/Fri Jul  1 09:25:21 2022)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 7/1/22 2:16 AM, Stanislav Fomichev wrote:
> On Thu, Jun 30, 2022 at 4:48 PM Hao Luo <haoluo@google.com> wrote:
>> On Thu, Jun 30, 2022 at 3:42 PM Stanislav Fomichev <sdf@google.com> wrote:
[...]
>>> With arch_prepare_bpf_trampoline removed on x86:
>>>
>>>   #98/1    lsm_cgroup/functional:SKIP
>>>   #98      lsm_cgroup:SKIP
>>>   Summary: 1/0 PASSED, 1 SKIPPED, 0 FAILED
>>>
>>> Fixes: dca85aac8895 ("selftests/bpf: lsm_cgroup functional test")
>>> Signed-off-by: Stanislav Fomichev <sdf@google.com>
>>> ---
>>>   tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c | 8 ++++++++
>>>   1 file changed, 8 insertions(+)
>>>
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c b/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
>>> index d40810a742fa..c542d7e80a5b 100644
>>> --- a/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
>>> +++ b/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
>>> @@ -9,6 +9,10 @@
>>>   #include "cgroup_helpers.h"
>>>   #include "network_helpers.h"
>>>
>>> +#ifndef ENOTSUPP
>>> +#define ENOTSUPP 524
>>> +#endif
>>> +
>>>   static struct btf *btf;
>>>
>>>   static __u32 query_prog_cnt(int cgroup_fd, const char *attach_func)
>>> @@ -100,6 +104,10 @@ static void test_lsm_cgroup_functional(void)
>>>          ASSERT_EQ(query_prog_cnt(cgroup_fd, "bpf_lsm_sk_alloc_security"), 0, "prog count");
>>>          ASSERT_EQ(query_prog_cnt(cgroup_fd, NULL), 0, "total prog count");
>>>          err = bpf_prog_attach(alloc_prog_fd, cgroup_fd, BPF_LSM_CGROUP, 0);
>>> +       if (err == -ENOTSUPP) {
>>> +               test__skip();
>>> +               goto close_cgroup;
>>> +       }
>>
>> It seems ENOTSUPP is only used in the kernel. I wonder whether we
>> should let libbpf map ENOTSUPP to ENOTSUP, which is the errno used in
>> userspace and has been used in libbpf.
> 
> Yeah, this comes up occasionally, I don't think we've agreed on some
> kind of general policy about what to do with these :-(
> Thanks for the review!

Consensus was that for existing code, the ship has sailed to change it given
applications could one way or another depend on this error code, but it should
be avoided for new APIs (e.g. [0]).

Thanks,
Daniel

   [0] https://lore.kernel.org/bpf/20211209182349.038ac2b8@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com/
