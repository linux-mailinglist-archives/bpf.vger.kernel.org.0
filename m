Return-Path: <bpf+bounces-7849-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D111077D6DB
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 02:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D80028167C
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 00:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E10319D;
	Wed, 16 Aug 2023 00:03:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5815617E
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 00:03:31 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8D5E74
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 17:03:28 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3a76d882080so5056479b6e.2
        for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 17:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692144208; x=1692749008;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1XhzdFjgVgO/3VAGZ9uw1F0IAdh1VrpUGZOM37KLPFA=;
        b=OiLggksNXueqviOHm8B6SO8zNYIGOPsDFkpRb7bQQlPFeqQwmnDLjl7MqjUtt7M3Y8
         /njfbjuZ4GQV0IFi3yc7kJJZxrxEwjVg4SAsMUpKcl23c2xAoqnBG1yCyRjE4D6XrBcO
         Te/YW+DTYLMO/VG0mbdDblbKC3oAaMeKto2Izzk9kfy+dhbwyV1ZQEv8WlqUNQ+jzWeK
         djaFcLw8VP0XxL/4wo1Tw9ykTt5pq6IqKeY0U6UMt4kqnY7pc4igIBdNDiw1NrG5sc/3
         r4yjPKGR6dQl5DQR2BeGv+YZ89ftL/HVuVmMh+0+rXcvgjsWFFVRYEs7kFCqpJRykQJ4
         EBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692144208; x=1692749008;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1XhzdFjgVgO/3VAGZ9uw1F0IAdh1VrpUGZOM37KLPFA=;
        b=WQniRQHvtsAv60HosReKdaIzyO7/XszBu/hb4lv6tpzfMUA1OdTVoHQybAkQU8fkb3
         EKLPOm06TIcCtiaLCj1S/1dz3EqwLPL6n3Iu4ZJ36tcNIj7d+ThPxhe7+8gUDJNXvauJ
         vRpdFowkktjxdoyOHzUyLpWHDUxX8rLFeTSasIFfhjeGkMJN/L3sIW1myiGt525fXJgp
         ZCLZ1hN3+O41b7XFjx4KjP4gWktBZwgqpjs2kcd2GqtH6HfcP+B9BOzJ+yjs4bWixV26
         5QWBkCphX55q9v5VpknKtuUB1Jg98/CwCU9zJHcDY0fyRqOtT1UmGj997kwxHyYcj8Si
         KzFQ==
X-Gm-Message-State: AOJu0Yx2CmrrcgNo0dSJlBdGlJm8oJRHZj3UgmEGBJspfq8z5WchEpWh
	F3vJvrwmdaKerfmlgjlb56w=
X-Google-Smtp-Source: AGHT+IG8bBsbqGjr4L51ca/RvUvbJsmzPjJNT7FOCgl78DZqevzu1rOg0AzSWcB7vPzgVGq7ghTh7Q==
X-Received: by 2002:aca:f12:0:b0:3a3:9df9:1928 with SMTP id 18-20020aca0f12000000b003a39df91928mr257955oip.17.1692144207941;
        Tue, 15 Aug 2023 17:03:27 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:a357:dfb7:2b03:4d5e? ([2600:1700:6cf8:1240:a357:dfb7:2b03:4d5e])
        by smtp.gmail.com with ESMTPSA id db4-20020a05690c0dc400b005844ae2bfa3sm3702625ywb.95.2023.08.15.17.03.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 17:03:27 -0700 (PDT)
Message-ID: <c7833c94-59fe-23da-7ac8-a2dd81124d4c@gmail.com>
Date: Tue, 15 Aug 2023 17:03:25 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC bpf-next v3 5/5] selftests/bpf: Add test cases for sleepable
 BPF programs of the CGROUP_SOCKOPT type
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
To: Stanislav Fomichev <sdf@google.com>, thinker.li@gmail.com
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 yonghong.song@linux.dev, kuifeng@meta.com
References: <20230815174712.660956-1-thinker.li@gmail.com>
 <20230815174712.660956-6-thinker.li@gmail.com> <ZNvm1INWVulkWM8d@google.com>
 <93e2d6f7-e661-5c83-6a86-246e231da52d@gmail.com>
In-Reply-To: <93e2d6f7-e661-5c83-6a86-246e231da52d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/15/23 16:37, Kui-Feng Lee wrote:
> 
> 
> On 8/15/23 13:57, Stanislav Fomichev wrote:
>> On 08/15, thinker.li@gmail.com wrote:
>>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>>
>>> Do the same test as non-sleepable ones.
>>>
>>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>>> ---
>>>   .../testing/selftests/bpf/bpf_experimental.h  |  36 +++
>>>   tools/testing/selftests/bpf/bpf_kfuncs.h      |  41 +++
>>>   .../selftests/bpf/prog_tests/sockopt_sk.c     | 112 +++++++-
>>>   .../testing/selftests/bpf/progs/sockopt_sk.c  | 257 ++++++++++++++++++
>>>   .../selftests/bpf/verifier/sleepable.c        |   2 +-
>>>   5 files changed, 445 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h 
>>> b/tools/testing/selftests/bpf/bpf_experimental.h
>>> index 209811b1993a..9b5dfefe65dc 100644
>>> --- a/tools/testing/selftests/bpf/bpf_experimental.h
>>> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
>>> @@ -131,4 +131,40 @@ extern int bpf_rbtree_add_impl(struct 
>>> bpf_rb_root *root, struct bpf_rb_node *nod
>>>    */
>>>   extern struct bpf_rb_node *bpf_rbtree_first(struct bpf_rb_root 
>>> *root) __ksym;
>>> +/*
>>> + *     Description
>>> + *             Copy data from *ptr* to *sopt->optval*.
>>> + *     Return
>>> + *             >= 0 on success, or a negative error in case of failure.
>>> + */
>>> +extern int bpf_sockopt_dynptr_copy_to(struct bpf_sockopt *sopt,
>>> +                      struct bpf_dynptr *ptr) __ksym;
>>> +
>>> +/* Description
>>> + *    Allocate a buffer of 'size' bytes for being installed as optval.
>>> + * Returns
>>> + *    > 0 on success, the size of the allocated buffer
>>> + *    -ENOMEM or -EINVAL on failure
>>> + */
>>> +extern int bpf_sockopt_dynptr_alloc(struct bpf_sockopt *sopt, int size,
>>> +                    struct bpf_dynptr *ptr__uninit) __ksym;
>>> +
>>> +/* Description
>>> + *    Install the buffer pointed to by 'ptr' as optval.
>>> + * Returns
>>> + *    0 on success
>>> + *    -EINVAL if the buffer is too small
>>> + */
>>> +extern int bpf_sockopt_dynptr_install(struct bpf_sockopt *sopt,
>>> +                      struct bpf_dynptr *ptr) __ksym;
>>> +
>>> +/* Description
>>> + *    Release the buffer allocated by bpf_sockopt_dynptr_alloc.
>>> + * Returns
>>> + *    0 on success
>>> + *    -EINVAL if the buffer was not allocated by 
>>> bpf_sockopt_dynptr_alloc
>>> + */
>>> +extern int bpf_sockopt_dynptr_release(struct bpf_sockopt *sopt,
>>> +                      struct bpf_dynptr *ptr) __ksym;
>>> +
>>>   #endif
>>> diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h 
>>> b/tools/testing/selftests/bpf/bpf_kfuncs.h
>>> index 642dda0e758a..772040225257 100644
>>> --- a/tools/testing/selftests/bpf/bpf_kfuncs.h
>>> +++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
>>> @@ -41,4 +41,45 @@ extern bool bpf_dynptr_is_rdonly(const struct 
>>> bpf_dynptr *ptr) __ksym;
>>>   extern __u32 bpf_dynptr_size(const struct bpf_dynptr *ptr) __ksym;
>>>   extern int bpf_dynptr_clone(const struct bpf_dynptr *ptr, struct 
>>> bpf_dynptr *clone__init) __ksym;
>>> +extern int bpf_sockopt_dynptr_copy_to(struct bpf_sockopt *sopt,
>>> +                      struct bpf_dynptr *ptr) __ksym;
>>> +
>>> +/* Description
>>> + *    Allocate a buffer of 'size' bytes for being installed as optval.
>>> + * Returns
>>> + *    > 0 on success, the size of the allocated buffer
>>> + *    -ENOMEM or -EINVAL on failure
>>> + */
>>> +extern int bpf_sockopt_dynptr_alloc(struct bpf_sockopt *sopt, int size,
>>> +                    struct bpf_dynptr *ptr__uninit) __ksym;
>>> +
>>> +/* Description
>>> + *    Install the buffer pointed to by 'ptr' as optval.
>>> + * Returns
>>> + *    0 on success
>>> + *    -EINVAL if the buffer is too small
>>> + */
>>> +extern int bpf_sockopt_dynptr_install(struct bpf_sockopt *sopt,
>>> +                      struct bpf_dynptr *ptr) __ksym;
>>> +
>>> +/* Description
>>> + *    Release the buffer allocated by bpf_sockopt_dynptr_alloc.
>>> + * Returns
>>> + *    0 on success
>>> + *    -EINVAL if the buffer was not allocated by 
>>> bpf_sockopt_dynptr_alloc
>>> + */
>>> +extern int bpf_sockopt_dynptr_release(struct bpf_sockopt *sopt,
>>> +                      struct bpf_dynptr *ptr) __ksym;
>>> +
>>> +/* Description
>>> + *    Initialize a dynptr to access the content of optval passing
>>> + *      to {get,set}sockopt()s.
>>> + * Returns
>>> + *    > 0 on success, the size of the allocated buffer
>>> + *    -ENOMEM or -EINVAL on failure
>>> + */
>>> +extern int bpf_sockopt_dynptr_from(struct bpf_sockopt *sopt,
>>> +                   struct bpf_dynptr *ptr__uninit,
>>> +                   unsigned int size) __ksym;
>>> +
>>>   #endif
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c 
>>> b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
>>> index 05d0e07da394..85255648747f 100644
>>> --- a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
>>> +++ b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
>>> @@ -92,6 +92,7 @@ static int getsetsockopt(void)
>>>       }
>>>       if (buf.u8[0] != 0x01) {
>>>           log_err("Unexpected buf[0] 0x%02x != 0x01", buf.u8[0]);
>>> +        log_err("optlen %d", optlen);
>>>           goto err;
>>>       }
>>> @@ -220,7 +221,7 @@ static int getsetsockopt(void)
>>>       return -1;
>>>   }
>>> -static void run_test(int cgroup_fd)
>>> +static void run_test_nonsleepable(int cgroup_fd)
>>>   {
>>>       struct sockopt_sk *skel;
>>> @@ -246,6 +247,106 @@ static void run_test(int cgroup_fd)
>>>       sockopt_sk__destroy(skel);
>>>   }
>>> +static void run_test_nonsleepable_mixed(int cgroup_fd)
>>> +{
>>> +    struct sockopt_sk *skel;
>>> +
>>> +    skel = sockopt_sk__open_and_load();
>>> +    if (!ASSERT_OK_PTR(skel, "skel_load"))
>>> +        goto cleanup;
>>> +
>>> +    skel->bss->page_size = getpagesize();
>>> +    skel->bss->skip_sleepable = 1;
>>> +
>>> +    skel->links._setsockopt_s =
>>> +        bpf_program__attach_cgroup(skel->progs._setsockopt_s, 
>>> cgroup_fd);
>>> +    if (!ASSERT_OK_PTR(skel->links._setsockopt_s, "setsockopt_link 
>>> (sleepable)"))
>>> +        goto cleanup;
>>> +
>>> +    skel->links._getsockopt_s =
>>> +        bpf_program__attach_cgroup(skel->progs._getsockopt_s, 
>>> cgroup_fd);
>>> +    if (!ASSERT_OK_PTR(skel->links._getsockopt_s, "getsockopt_link 
>>> (sleepable)"))
>>> +        goto cleanup;
>>> +
>>> +    skel->links._setsockopt =
>>> +        bpf_program__attach_cgroup(skel->progs._setsockopt, cgroup_fd);
>>> +    if (!ASSERT_OK_PTR(skel->links._setsockopt, "setsockopt_link"))
>>> +        goto cleanup;
>>> +
>>> +    skel->links._getsockopt =
>>> +        bpf_program__attach_cgroup(skel->progs._getsockopt, cgroup_fd);
>>> +    if (!ASSERT_OK_PTR(skel->links._getsockopt, "getsockopt_link"))
>>> +        goto cleanup;
>>> +
>>> +    ASSERT_OK(getsetsockopt(), "getsetsockopt");
>>> +
>>> +cleanup:
>>> +    sockopt_sk__destroy(skel);
>>> +}
>>> +
>>> +static void run_test_sleepable(int cgroup_fd)
>>> +{
>>> +    struct sockopt_sk *skel;
>>> +
>>> +    skel = sockopt_sk__open_and_load();
>>> +    if (!ASSERT_OK_PTR(skel, "skel_load"))
>>> +        goto cleanup;
>>> +
>>> +    skel->bss->page_size = getpagesize();
>>> +
>>> +    skel->links._setsockopt_s =
>>> +        bpf_program__attach_cgroup(skel->progs._setsockopt_s, 
>>> cgroup_fd);
>>> +    if (!ASSERT_OK_PTR(skel->links._setsockopt_s, "setsockopt_link"))
>>> +        goto cleanup;
>>> +
>>> +    skel->links._getsockopt_s =
>>> +        bpf_program__attach_cgroup(skel->progs._getsockopt_s, 
>>> cgroup_fd);
>>> +    if (!ASSERT_OK_PTR(skel->links._getsockopt_s, "getsockopt_link"))
>>> +        goto cleanup;
>>> +
>>> +    ASSERT_OK(getsetsockopt(), "getsetsockopt");
>>> +
>>> +cleanup:
>>> +    sockopt_sk__destroy(skel);
>>> +}
>>> +
>>> +static void run_test_sleepable_mixed(int cgroup_fd)
>>> +{
>>> +    struct sockopt_sk *skel;
>>> +
>>> +    skel = sockopt_sk__open_and_load();
>>> +    if (!ASSERT_OK_PTR(skel, "skel_load"))
>>> +        goto cleanup;
>>> +
>>> +    skel->bss->page_size = getpagesize();
>>> +    skel->bss->skip_nonsleepable = 1;
>>> +
>>> +    skel->links._setsockopt =
>>> +        bpf_program__attach_cgroup(skel->progs._setsockopt, cgroup_fd);
>>> +    if (!ASSERT_OK_PTR(skel->links._setsockopt, "setsockopt_link 
>>> (nonsleepable)"))
>>> +        goto cleanup;
>>> +
>>> +    skel->links._getsockopt =
>>> +        bpf_program__attach_cgroup(skel->progs._getsockopt, cgroup_fd);
>>> +    if (!ASSERT_OK_PTR(skel->links._getsockopt, "getsockopt_link 
>>> (nonsleepable)"))
>>> +        goto cleanup;
>>> +
>>> +    skel->links._setsockopt_s =
>>> +        bpf_program__attach_cgroup(skel->progs._setsockopt_s, 
>>> cgroup_fd);
>>> +    if (!ASSERT_OK_PTR(skel->links._setsockopt_s, "setsockopt_link"))
>>> +        goto cleanup;
>>> +
>>> +    skel->links._getsockopt_s =
>>> +        bpf_program__attach_cgroup(skel->progs._getsockopt_s, 
>>> cgroup_fd);
>>> +    if (!ASSERT_OK_PTR(skel->links._getsockopt_s, "getsockopt_link"))
>>> +        goto cleanup;
>>> +
>>> +    ASSERT_OK(getsetsockopt(), "getsetsockopt");
>>> +
>>> +cleanup:
>>> +    sockopt_sk__destroy(skel);
>>> +}
>>> +
>>>   void test_sockopt_sk(void)
>>>   {
>>>       int cgroup_fd;
>>> @@ -254,6 +355,13 @@ void test_sockopt_sk(void)
>>>       if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup /sockopt_sk"))
>>>           return;
>>> -    run_test(cgroup_fd);
>>> +    if (test__start_subtest("nonsleepable"))
>>> +        run_test_nonsleepable(cgroup_fd);
>>> +    if (test__start_subtest("sleepable"))
>>> +        run_test_sleepable(cgroup_fd);
>>> +    if (test__start_subtest("nonsleepable_mixed"))
>>> +        run_test_nonsleepable_mixed(cgroup_fd);
>>> +    if (test__start_subtest("sleepable_mixed"))
>>> +        run_test_sleepable_mixed(cgroup_fd);
>>>       close(cgroup_fd);
>>>   }
>>> diff --git a/tools/testing/selftests/bpf/progs/sockopt_sk.c 
>>> b/tools/testing/selftests/bpf/progs/sockopt_sk.c
>>> index cb990a7d3d45..efacd3b88c40 100644
>>> --- a/tools/testing/selftests/bpf/progs/sockopt_sk.c
>>> +++ b/tools/testing/selftests/bpf/progs/sockopt_sk.c
>>> @@ -5,10 +5,16 @@
>>>   #include <netinet/in.h>
>>>   #include <bpf/bpf_helpers.h>
>>> +typedef int bool;
>>> +#include "bpf_kfuncs.h"
>>> +
>>>   char _license[] SEC("license") = "GPL";
>>>   int page_size = 0; /* userspace should set it */
>>> +int skip_sleepable = 0;
>>> +int skip_nonsleepable = 0;
>>> +
>>>   #ifndef SOL_TCP
>>>   #define SOL_TCP IPPROTO_TCP
>>>   #endif
>>> @@ -34,6 +40,9 @@ int _getsockopt(struct bpf_sockopt *ctx)
>>>       struct sockopt_sk *storage;
>>>       struct bpf_sock *sk;
>>> +    if (skip_nonsleepable)
>>> +        return 1;
>>> +
>>>       /* Bypass AF_NETLINK. */
>>>       sk = ctx->sk;
>>>       if (sk && sk->family == AF_NETLINK)
>>> @@ -136,6 +145,134 @@ int _getsockopt(struct bpf_sockopt *ctx)
>>>       return 1;
>>>   }
>>> +SEC("cgroup/getsockopt.s")
>>> +int _getsockopt_s(struct bpf_sockopt *ctx)
>>> +{
>>> +    struct tcp_zerocopy_receive *zcvr;
>>> +    struct bpf_dynptr optval_dynptr;
>>> +    struct sockopt_sk *storage;
>>> +    __u8 *optval, *optval_end;
>>> +    struct bpf_sock *sk;
>>> +    char buf[1];
>>> +    __u64 addr;
>>> +    int ret;
>>> +
>>> +    if (skip_sleepable)
>>> +        return 1;
>>> +
>>> +    /* Bypass AF_NETLINK. */
>>> +    sk = ctx->sk;
>>> +    if (sk && sk->family == AF_NETLINK)
>>> +        return 1;
>>> +
>>> +    optval = ctx->optval;
>>> +    optval_end = ctx->optval_end;
>>> +
>>> +    /* Make sure bpf_get_netns_cookie is callable.
>>> +     */
>>> +    if (bpf_get_netns_cookie(NULL) == 0)
>>> +        return 0;
>>> +
>>> +    if (bpf_get_netns_cookie(ctx) == 0)
>>> +        return 0;
>>> +
>>> +    if (ctx->level == SOL_IP && ctx->optname == IP_TOS) {
>>> +        /* Not interested in SOL_IP:IP_TOS;
>>> +         * let next BPF program in the cgroup chain or kernel
>>> +         * handle it.
>>> +         */
>>> +        return 1;
>>> +    }
>>> +
>>> +    if (ctx->level == SOL_SOCKET && ctx->optname == SO_SNDBUF) {
>>> +        /* Not interested in SOL_SOCKET:SO_SNDBUF;
>>> +         * let next BPF program in the cgroup chain or kernel
>>> +         * handle it.
>>> +         */
>>> +        return 1;
>>> +    }
>>> +
>>> +    if (ctx->level == SOL_TCP && ctx->optname == TCP_CONGESTION) {
>>> +        /* Not interested in SOL_TCP:TCP_CONGESTION;
>>> +         * let next BPF program in the cgroup chain or kernel
>>> +         * handle it.
>>> +         */
>>> +        return 1;
>>> +    }
>>> +
>>> +    if (ctx->level == SOL_TCP && ctx->optname == 
>>> TCP_ZEROCOPY_RECEIVE) {
>>> +        /* Verify that TCP_ZEROCOPY_RECEIVE triggers.
>>> +         * It has a custom implementation for performance
>>> +         * reasons.
>>> +         */
>>> +
>>> +        bpf_sockopt_dynptr_from(ctx, &optval_dynptr, sizeof(*zcvr));
>>> +        zcvr = bpf_dynptr_data(&optval_dynptr, 0, sizeof(*zcvr));
>>> +        addr = zcvr ? zcvr->address : 0;
>>> +        bpf_sockopt_dynptr_release(ctx, &optval_dynptr);
>>
>> This starts to look more usable, thank you for the changes!
>> Let me poke the api a bit more, I'm not super familiar with the dynptrs.
>>
>> here: bpf_sockopt_dynptr_from should probably be called
>> bpf_dynptr_from_sockopt to match bpf_dynptr_from_mem?
> 
> agree!
> 
>>
>>> +
>>> +        return addr != 0 ? 0 : 1;
>>> +    }
>>> +
>>> +    if (ctx->level == SOL_IP && ctx->optname == IP_FREEBIND) {
>>> +        if (optval + 1 > optval_end)
>>> +            return 0; /* bounds check */
>>> +
>>> +        ctx->retval = 0; /* Reset system call return value to zero */
>>> +
>>> +        /* Always export 0x55 */
>>> +        buf[0] = 0x55;
>>> +        ret = bpf_sockopt_dynptr_alloc(ctx, 1, &optval_dynptr);
>>> +        if (ret >= 0) {
>>> +            bpf_dynptr_write(&optval_dynptr, 0, buf, 1, 0);
>>> +            ret = bpf_sockopt_dynptr_copy_to(ctx, &optval_dynptr);
>>> +        }
>>> +        bpf_sockopt_dynptr_release(ctx, &optval_dynptr);
>>
>> Does bpf_sockopt_dynptr_alloc and bpf_sockopt_dynptr_release need to be
>> sockopt specific? Seems like we should provide, instead, some generic
>> bpf_dynptr_alloc/bpf_dynptr_release and make
>> bpf_sockopt_dynptr_copy_to/install work with them? WDYT?
> 
> I found that kmalloc can not be called in the context of nmi, slab or
> page alloc path. It is why we don't have functions like
> bpf_dynptr_alloc/bpf_dynptr_release yet. That means we need someone
> to implement an allocator for BPF programs. And, then, we can have
> bpf_dynptr_alloc unpon it. (There is an implementation of
> bpf_dynptr_alloc() in the early versions of the patchset of dynptr.
> But, be removed before landing.)
> 
> 
>>
>>> +        if (ret < 0)
>>> +            return 0;
>>> +        ctx->optlen = 1;
>>> +
>>> +        /* Userspace buffer is PAGE_SIZE * 2, but BPF
>>> +         * program can only see the first PAGE_SIZE
>>> +         * bytes of data.
>>> +         */
>>> +        if (optval_end - optval != page_size && 0)
>>> +            return 0; /* unexpected data size */
>>> +
>>> +        return 1;
>>> +    }
>>> +
>>> +    if (ctx->level != SOL_CUSTOM)
>>> +        return 0; /* deny everything except custom level */
>>> +
>>> +    if (optval + 1 > optval_end)
>>> +        return 0; /* bounds check */
>>> +
>>> +    storage = bpf_sk_storage_get(&socket_storage_map, ctx->sk, 0,
>>> +                     BPF_SK_STORAGE_GET_F_CREATE);
>>> +    if (!storage)
>>> +        return 0; /* couldn't get sk storage */
>>> +
>>> +    if (!ctx->retval)
>>> +        return 0; /* kernel should not have handled
>>> +               * SOL_CUSTOM, something is wrong!
>>> +               */
>>> +    ctx->retval = 0; /* Reset system call return value to zero */
>>> +
>>> +    buf[0] = storage->val;
>>> +    ret = bpf_sockopt_dynptr_alloc(ctx, 1, &optval_dynptr);
>>> +    if (ret >= 0) {
>>> +        bpf_dynptr_write(&optval_dynptr, 0, buf, 1, 0);
>>> +        ret = bpf_sockopt_dynptr_copy_to(ctx, &optval_dynptr);
>>> +    }
>>> +    bpf_sockopt_dynptr_release(ctx, &optval_dynptr);
>>> +    if (ret < 0)
>>> +        return 0;
>>> +    ctx->optlen = 1;
>>> +
>>> +    return 1;
>>> +}
>>> +
>>>   SEC("cgroup/setsockopt")
>>>   int _setsockopt(struct bpf_sockopt *ctx)
>>>   {
>>> @@ -144,6 +281,9 @@ int _setsockopt(struct bpf_sockopt *ctx)
>>>       struct sockopt_sk *storage;
>>>       struct bpf_sock *sk;
>>> +    if (skip_nonsleepable)
>>> +        return 1;
>>> +
>>>       /* Bypass AF_NETLINK. */
>>>       sk = ctx->sk;
>>>       if (sk && sk->family == AF_NETLINK)
>>> @@ -236,3 +376,120 @@ int _setsockopt(struct bpf_sockopt *ctx)
>>>           ctx->optlen = 0;
>>>       return 1;
>>>   }
>>> +
>>> +SEC("cgroup/setsockopt.s")
>>> +int _setsockopt_s(struct bpf_sockopt *ctx)
>>> +{
>>> +    struct bpf_dynptr optval_buf;
>>> +    struct sockopt_sk *storage;
>>> +    __u8 *optval, *optval_end;
>>> +    struct bpf_sock *sk;
>>> +    __u8 tmp_u8;
>>> +    __u32 tmp;
>>> +    int ret;
>>> +
>>> +    if (skip_sleepable)
>>> +        return 1;
>>> +
>>> +    optval = ctx->optval;
>>> +    optval_end = ctx->optval_end;
>>> +
>>> +    /* Bypass AF_NETLINK. */
>>> +    sk = ctx->sk;
>>> +    if (sk && sk->family == AF_NETLINK)
>>> +        return -1;
>>> +
>>> +    /* Make sure bpf_get_netns_cookie is callable.
>>> +     */
>>> +    if (bpf_get_netns_cookie(NULL) == 0)
>>> +        return 0;
>>> +
>>> +    if (bpf_get_netns_cookie(ctx) == 0)
>>> +        return 0;
>>> +
>>> +    if (ctx->level == SOL_IP && ctx->optname == IP_TOS) {
>>> +        /* Not interested in SOL_IP:IP_TOS;
>>> +         * let next BPF program in the cgroup chain or kernel
>>> +         * handle it.
>>> +         */
>>> +        ctx->optlen = 0; /* bypass optval>PAGE_SIZE */
>>> +        return 1;
>>> +    }
>>> +
>>> +    if (ctx->level == SOL_SOCKET && ctx->optname == SO_SNDBUF) {
>>> +        /* Overwrite SO_SNDBUF value */
>>> +
>>> +        ret = bpf_sockopt_dynptr_alloc(ctx, sizeof(__u32),
>>> +                           &optval_buf);
>>> +        if (ret < 0)
>>> +            bpf_sockopt_dynptr_release(ctx, &optval_buf);
>>> +        else {
>>> +            tmp = 0x55AA;
>>> +            bpf_dynptr_write(&optval_buf, 0, &tmp, sizeof(tmp), 0);
>>> +            ret = bpf_sockopt_dynptr_install(ctx, &optval_buf);
>>
>> One thing I'm still slightly confused about is
>> bpf_sockopt_dynptr_install vs bpf_sockopt_dynptr_copy_to. I do
>> understand that it comes from getsockopt vs setsockopt (and the ability,
>> in setsockopt, to allocate larger buffers), but I wonder whether
>> we can hide everything under single bpf_sockopt_dynptr_copy_to call?
>>
>> For getsockopt, it stays as is. For setsockopt, it would work like
>> _install currently does. Would that work? From user perspective,
>> if we provide a simple call that does the right thing, seems a bit
>> more usable? The only problem is probably the fact that _install
>> explicitly moves the ownership, but I don't see why copy_to can't
>> have the same "consume" semantics?

Sorry for missing this part!
This overloading is counterintuitive for me.
*_copy_to() will not copy/overwrite the buffer, but replace the buffer
instead. And, it will change its side-effects according to its context.
I would prefer a different name instead of reusing *_copy_to().

We probably need a better name, instead of copy_to, in order to merge
these two functions if we want to.




