Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E096F4DC4
	for <lists+bpf@lfdr.de>; Wed,  3 May 2023 01:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjEBXkd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 May 2023 19:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjEBXkd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 May 2023 19:40:33 -0400
Received: from out-41.mta0.migadu.com (out-41.mta0.migadu.com [91.218.175.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DED13594
        for <bpf@vger.kernel.org>; Tue,  2 May 2023 16:40:31 -0700 (PDT)
Message-ID: <5083c2ab-4745-2a73-3fb1-f2769840ce4d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683070829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fWQntvoyeQw4VKSwu60PUNusIvNulQu43oXV/Zd08pY=;
        b=gJmalWk8fUPbRXx4vtG8K6nMh5omzp5xxy2Q5JdkHBWgQVeuHqNBVOuidG7/akuZn3dkMD
        ZG1QvQ1dZ9xnbKZ02JQxpD1Nv+E5VT9WiOvjICZ6+fmugp9MCytFiERcltNI4M6/586Asi
        WJlZMrHgeI3vEMnq302SeH951xlE2zw=
Date:   Tue, 2 May 2023 16:40:27 -0700
MIME-Version: 1.0
Subject: Re: [PATCH v6 bpf-next 0/7] bpf: Add socket destroy capability
Content-Language: en-US
To:     Aditi Ghag <aditi.ghag@isovalent.com>
Cc:     Stanislav Fomichev <sdf@google.com>, edumazet@google.com,
        bpf@vger.kernel.org
References: <20230418153148.2231644-1-aditi.ghag@isovalent.com>
 <76dcba72-4e52-9ea1-cabd-b4c9f431c556@linux.dev>
 <E6DB96AE-A7FA-4462-A0ED-4C53F3625BB1@isovalent.com>
 <2249BAC9-E23F-42CD-9F33-F09ABE24BAF6@isovalent.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <2249BAC9-E23F-42CD-9F33-F09ABE24BAF6@isovalent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/2/23 3:52 PM, Aditi Ghag wrote:
> 
> 
>> On May 1, 2023, at 4:32 PM, Aditi Ghag <aditi.ghag@isovalent.com> wrote:
>>
>>
>>
>>> On Apr 24, 2023, at 3:15 PM, Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>>
>>> On 4/18/23 8:31 AM, Aditi Ghag wrote:
>>>> This patch adds the capability to destroy sockets in BPF. We plan to use
>>>> the capability in Cilium to force client sockets to reconnect when their
>>>> remote load-balancing backends are deleted. The other use case is
>>>> on-the-fly policy enforcement where existing socket connections prevented
>>>> by policies need to be terminated.
>>>
>>> If the earlier kfunc filter patch (https://lore.kernel.org/bpf/1ECC8AAA-C2E6-4F8A-B7D3-5E90BDEE7C48@isovalent.com/) looks fine to you, please include it into the next revision. This patchset needs it. Usual thing to do is to keep my sob (and author if not much has changed) and add your sob. The test needs to be broken out into a separate patch though. It needs to use the '__failure __msg("calling kernel function bpf_sock_destroy is not allowed")'. There are many examples in selftests, eg. the dynptr_fail.c.
>>>
>>
>> Yeah, ok. I was waiting for your confirmation. The patch doesn't need my sob though (maybe tested-by).
>> I've created a separate patch for the test.
> 
> 
> Here is the patch diff for the extended test case for your reference. I'm ready to push a new version once I get an ack from you.
Looks reasonable to me.

One thing I have been thinking is the bpf_sock_destroy kfunc should need a 
KF_TRUSTED_ARGS but I suspect that may need a change in the tcp_reg_info in 
tcp_ipv4.c. Not sure yet. Regardless, I don't think this will have a major 
effect on other patches in this set. Please go ahead to respin considering there 
are a few comments that need to be addressed already. At worst it can use one 
final revision to address KF_TRUSTED_ARGS.
[ btw, I don't see your reply/confirmation on the Patch 1 discussion also. 
Please ensure those will also be clarified/addressed in the next respin. ]


> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/sock_destroy.c b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
> index a889c53e93c7..afed8cad94ee 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
> @@ -3,6 +3,7 @@
>   #include <bpf/bpf_endian.h>
> 
>   #include "sock_destroy_prog.skel.h"
> +#include "sock_destroy_prog_fail.skel.h"
>   #include "network_helpers.h"
> 
>   #define TEST_NS "sock_destroy_netns"
> @@ -207,6 +208,8 @@ void test_sock_destroy(void)
>                  test_udp_server(skel);
> 
> 
> +       RUN_TESTS(sock_destroy_prog_fail);
> +
>   cleanup:
>          if (nstoken)
>                  close_netns(nstoken);
> diff --git a/tools/testing/selftests/bpf/progs/sock_destroy_prog_fail.c b/tools/testing/selftests/bpf/progs/sock_destroy_prog_fail.c
> new file mode 100644
> index 000000000000..dd6850b58e25
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/sock_destroy_prog_fail.c
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_tracing.h>
> +#include <bpf/bpf_helpers.h>
> +
> +#include "bpf_misc.h"
> +
> +char _license[] SEC("license") = "GPL";
> +
> +int bpf_sock_destroy(struct sock_common *sk) __ksym;
> +
> +SEC("tp_btf/tcp_destroy_sock")
> +__failure __msg("calling kernel function bpf_sock_destroy is not allowed")
> +int BPF_PROG(trace_tcp_destroy_sock, struct sock *sk)
> +{
> +       /* should not load */
> +       bpf_sock_destroy((struct sock_common *)sk);
> +
> +       return 0;
> +}
> 
>>
>>
>>> Please also fix the subject in the patches. They are all missing the bpf-next and revision tag.
>>>
>>
>> Took me a few moments to realize that as I was looking at earlier series. Looks like I forgot to add the tags to subsequent patches in this series. I'll fix it up in the next push.
> 

