Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509EF55389B
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 19:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352794AbiFURLr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jun 2022 13:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352680AbiFURLq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jun 2022 13:11:46 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8672252B7
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 10:11:44 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ay16so9510313ejb.6
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 10:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=5if4vWcK03ZvFcUQc81+FDfDj1EnlPgb15mAzztZsWA=;
        b=CqujiHmn4NkmjTXOWLT60V0CMET4thnoVQ5XSaqBbzzWPjdm40bILvjlZk7wFABsiZ
         uBCUjz2LeF4UxZQNKqm0YgSBpt7pSDC9WCvfyViydsv1u1JPkZJIPVUbsfZsCLNVbj1R
         aBpjair/i3jf0EdZmjVmSAiUzyCtKksztEYSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=5if4vWcK03ZvFcUQc81+FDfDj1EnlPgb15mAzztZsWA=;
        b=Gazu4L2yFHIJe+1n9zy/juIVGqlzNyK7Tyceh5LcrdToW4t5cce5N50T50t5kDpEem
         EFrPOg64j727J8B2SB/i+W/SM9hSVJl6fKQ4azsKA4r6jo3h9D2/lzdxlo1KUlY6/8at
         b4yL1URDbPWQRA1Bh3WQSsvkj6su72/Py/3eL+PNCekhn5JT/bCU9bW4IDrnh0S8/Itu
         mz4z/MH0r8kQHVmfM0MgYDma9/D31ANIW/Ea9cMIjXiBsAISC/DznEArEG46RNlXzB0n
         KTWqxRRHP/g5QVptXtsfvzD+xoJhZh9nq53hm2Dhdam754Ye4LcH3/sDlF5LTBAelF33
         s5IA==
X-Gm-Message-State: AJIora92zFqF4lB3uoanXRTJzXOOWNzUfafHrtBF2QtzFtk5grw9Gmj/
        oTW4frvn4UUkhw1IR5tnxLm5mw==
X-Google-Smtp-Source: AGRyM1t+dNi9d8UUM9gzZG3DUjgXrL82tC7Buce5jcxlQzJ/HqZE8h1ElUzlSHbu6rvjGTKnM/i4EQ==
X-Received: by 2002:a17:907:1ca8:b0:706:9ee2:dbc with SMTP id nb40-20020a1709071ca800b007069ee20dbcmr26938169ejc.398.1655831503445;
        Tue, 21 Jun 2022 10:11:43 -0700 (PDT)
Received: from cloudflare.com (79.184.138.130.ipv4.supernova.orange.pl. [79.184.138.130])
        by smtp.gmail.com with ESMTPSA id l2-20020a1709060cc200b006feed200464sm8044243ejh.131.2022.06.21.10.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 10:11:43 -0700 (PDT)
References: <20220621070116.307221-1-jthinz@mailbox.tu-berlin.de>
 <6f2b2c24-22e8-9fbe-10d3-9347be3ac067@iogearbox.net>
User-agent: mu4e 1.6.10; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        =?utf-8?Q?J=C3=B6rn-Thorben?= Hinz <jthinz@mailbox.tu-berlin.de>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix rare segfault in
 sock_fields prog test
Date:   Tue, 21 Jun 2022 19:09:06 +0200
In-reply-to: <6f2b2c24-22e8-9fbe-10d3-9347be3ac067@iogearbox.net>
Message-ID: <87k09a3prl.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 21, 2022 at 07:00 PM +02, Daniel Borkmann wrote:
> On 6/21/22 9:01 AM, J=C3=B6rn-Thorben Hinz wrote:
>> test_sock_fields__detach() got called with a null pointer here when one
>> of the CHECKs or ASSERTs up to the test_sock_fields__open_and_load()
>> call resulted in a jump to the "done" label.
>> A skeletons *__detach() is not safe to call with a null pointer, though.
>> This led to a segfault.
>> Go the easy route and only call test_sock_fields__destroy() which is
>> null-pointer safe and includes detaching.
>> Came across this while looking[1] to introduce the usage of
>> bpf_tcp_helpers.h (included in progs/test_sock_fields.c) together with
>> vmlinux.h.
>> [1]
>> https://lore.kernel.org/bpf/629bc069dd807d7ac646f836e9dca28bbc1108e2.cam=
el@mailbox.tu-berlin.de/
>> Fixes: 8f50f16ff39d ("selftests/bpf: Extend verifier and bpf_sock tests =
for
>> dst_port loads")
>> Signed-off-by: J=C3=B6rn-Thorben Hinz <jthinz@mailbox.tu-berlin.de>
>> ---
>>   tools/testing/selftests/bpf/prog_tests/sock_fields.c | 1 -
>>   1 file changed, 1 deletion(-)
>> diff --git a/tools/testing/selftests/bpf/prog_tests/sock_fields.c
>> b/tools/testing/selftests/bpf/prog_tests/sock_fields.c
>> index 9d211b5c22c4..7d23166c77af 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/sock_fields.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/sock_fields.c
>> @@ -394,7 +394,6 @@ void serial_test_sock_fields(void)
>>   	test();
>>     done:
>> -	test_sock_fields__detach(skel);
>>   	test_sock_fields__destroy(skel);
>>   	if (child_cg_fd >=3D 0)
>>   		close(child_cg_fd);
>>=20
>
> Great catch! I think we have similar detach & destroy pattern in a number
> of places in selftests.
>
> Should we rather just move the label, like:
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sock_fields.c b/tools=
/testing/selftests/bpf/prog_tests/sock_fields.c
> index 9d211b5c22c4..e8a947241e37 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sock_fields.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sock_fields.c
> @@ -393,8 +393,8 @@ void serial_test_sock_fields(void)
>
>         test();
>
> -done:
>         test_sock_fields__detach(skel);
> +done:
>         test_sock_fields__destroy(skel);
>         if (child_cg_fd >=3D 0)
>                 close(child_cg_fd);

*__destroy() will call bpf_object__detach_skeleton(), so it LGTM.

Thanks for the fix.

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
