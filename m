Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6484C5CCE
	for <lists+bpf@lfdr.de>; Sun, 27 Feb 2022 17:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbiB0QSb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 27 Feb 2022 11:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbiB0QSb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 27 Feb 2022 11:18:31 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915D1B86A
        for <bpf@vger.kernel.org>; Sun, 27 Feb 2022 08:17:54 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id bn33so14231073ljb.6
        for <bpf@vger.kernel.org>; Sun, 27 Feb 2022 08:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=gf3YuKO0H7NtVxX02stte8OIS+WixFn0tC6EKCIyFQQ=;
        b=x3F1LTRtxREVlptXqFbCZpUgWRYOvhqlr/vA+/5AdtGhtMsSGNMm5ENeLoYIXXrT/5
         p8BcxO3aeNIQP2HiJY4uiXw9vvvLBe6N1Nsl+eWeNbNQlsYFLY3mqn1we4B0SmceZnRS
         LJJtnXF4ws1AttvXXxISH6x3KGpzB8pnq845c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=gf3YuKO0H7NtVxX02stte8OIS+WixFn0tC6EKCIyFQQ=;
        b=D9Wxm7y1PMASWjKww1JicrfoF9L9u0uj/FHdqNYHGZrBt5C5kpl6bvh/ZJzmwAUoNA
         5snqsh1k6mGdZy6jOyfYCXN9/SwiWbfatDgYqIWS4BWiV7HqTwgQPVhWZ32tnkGZMmqG
         bqJnqgc3TiSYGQzL/nXiLpGay7hz/vCNSTSfGZwayBaa3sCB6o56Pr0x6cJowfAXJ3z6
         +6yjIL+uj/409RoBIqDVwSYi4HNog4NGXqRGRScoPQd2JRDUJhGxl3cpMEEIPr5w2CDY
         TsNk+a7u5zXtSXy5iVpaLtW7qVsRO4yeECyLenrI31kzRsamht1mHg+BGYDialxTEkQf
         LoAg==
X-Gm-Message-State: AOAM530AZxhM3KddoaiAFKbKco0X1b4M+CiMgZ08aQYZzOgyrz0ixWn8
        idfs4VTuMn5UTSlPqCVdTFl6rbWqFe0KPA==
X-Google-Smtp-Source: ABdhPJwWBznGKdQmf2x6V10XI/zOWherdqfJDlgHF2hhrl1Y5euUeXPxQZVJSeLPmOdAWYt6vpRlxA==
X-Received: by 2002:a05:651c:1a29:b0:246:40e7:6360 with SMTP id by41-20020a05651c1a2900b0024640e76360mr11860529ljb.61.1645978672694;
        Sun, 27 Feb 2022 08:17:52 -0800 (PST)
Received: from cloudflare.com (2a01-110f-4809-d800-0000-0000-0000-0f9c.aa.ipv6.supernova.orange.pl. [2a01:110f:4809:d800::f9c])
        by smtp.gmail.com with ESMTPSA id v11-20020a2e924b000000b0024649082c0dsm958781ljg.118.2022.02.27.08.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 08:17:52 -0800 (PST)
References: <20220225184130.483208-1-jakub@cloudflare.com>
 <20220225201357.anwrlqkzlztprujr@kafai-mbp>
User-agent: mu4e 1.6.10; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        kernel-team@cloudflare.com
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix error reporting from
 sock_fields programs
Date:   Sun, 27 Feb 2022 17:16:24 +0100
In-reply-to: <20220225201357.anwrlqkzlztprujr@kafai-mbp>
Message-ID: <8735k4jnbk.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On Fri, Feb 25, 2022 at 12:13 PM -08, Martin KaFai Lau wrote:
> On Fri, Feb 25, 2022 at 07:41:30PM +0100, Jakub Sitnicki wrote:
>> The helper macro that records an error in BPF programs that exercise sock
>> fields access has been indavertedly broken by adaptation work that happened
>> in commit b18c1f0aa477 ("bpf: selftest: Adapt sock_fields test to use skel
>> and global variables").
>> 
>> BPF_NOEXIST flag cannot be used to update BPF_MAP_TYPE_ARRAY. The operation
>> always fails with -EEXIST, which in turn means the error never gets
>> recorded, and the checks for errors always pass.
>> 
>> Revert the change in update flags.
>> 
>> Fixes: b18c1f0aa477 ("bpf: selftest: Adapt sock_fields test to use skel and global variables")
>> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
>> ---
>>  tools/testing/selftests/bpf/progs/test_sock_fields.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/tools/testing/selftests/bpf/progs/test_sock_fields.c b/tools/testing/selftests/bpf/progs/test_sock_fields.c
>> index 246f1f001813..3e2e3ee51cc9 100644
>> --- a/tools/testing/selftests/bpf/progs/test_sock_fields.c
>> +++ b/tools/testing/selftests/bpf/progs/test_sock_fields.c
>> @@ -114,7 +114,7 @@ static void tpcpy(struct bpf_tcp_sock *dst,
>>  
>>  #define RET_LOG() ({						\
>>  	linum = __LINE__;					\
>> -	bpf_map_update_elem(&linum_map, &linum_idx, &linum, BPF_NOEXIST);	\
>> +	bpf_map_update_elem(&linum_map, &linum_idx, &linum, BPF_ANY);	\
> Acked-by: Martin KaFai Lau <kafai@fb.com>

Thanks for the quick review.

I need to follow up with a v2. Was too quick to send this patch out by
itself. Now that the error reporting works, the test sock_fields tests
are failing on little- and big-endian.
