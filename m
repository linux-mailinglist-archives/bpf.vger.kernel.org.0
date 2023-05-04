Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1111F6F70E3
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 19:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjEDRcW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 May 2023 13:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEDRcV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 May 2023 13:32:21 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203EE5266
        for <bpf@vger.kernel.org>; Thu,  4 May 2023 10:32:19 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1aaf21bb427so5441825ad.1
        for <bpf@vger.kernel.org>; Thu, 04 May 2023 10:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1683221538; x=1685813538;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPf8SWkj6xVegW4Uj/C6pMHeFHkKCTqzSHCKXXZuRVc=;
        b=B5tc+ueJdJxpup90QYRyj32L0bFGpkZGvwOdMrAp055PXLts5zqk674aa45b0dX9tx
         FqHukaAUS+OfzuQWLG2b9f+dvdxzZFBYnr/tJUoDj1Ah6andS/oDTfbeUpUjMXQeTuOm
         KUx6zNHiiROVBYnjSQauN780aXaiD+iCaCo7IS54gqHsovflBXKlsfvuF+02ScMJ6Qic
         zM+mh03p9eb++o++gfQWqCA2j6nUhcRa49jkybidLxf8FlfH6bfHIW6Z4ReKPw9A5gpH
         Ilm52aWAfsx31mHbwCIvDlpSsfezmDl0rvqlUayDIYwtK96G0mF7P/+37Fw0htjT65H3
         TkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683221538; x=1685813538;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RPf8SWkj6xVegW4Uj/C6pMHeFHkKCTqzSHCKXXZuRVc=;
        b=WyfvQGjJ091KLSKGRhoIQbNUqqyIVlid2hQsOBW9ADniCF34tnuujnXoFKAhgJ04CA
         UB9ODIHbEFVsOZfkggVl4V1PpS9aAhsT2/n/MWtAtbQjua9W115qRX7xHBx9dhuPOe32
         O31fLNHuEKYUS6nRcNyAt4TRaGi/9xDN9MkV5/Iz3seDwMbWiS+zE18IG1Pd5q6Wz+3M
         aa4HjmmCMbuvmIwGSsK6MIUrSPD1BoF141IAheltyIRGNM5D5+xRQmuFbPI0I1FAKnKj
         vIGyPuvWVEgq9vgAk18C5mLdtmjIcWV0g5r6N6v5M7yc+6yly7YYUgPZ+rL7JY47pzg7
         Oayw==
X-Gm-Message-State: AC+VfDySqvRssYjAwqkANvJdrUpIfmhMu2iLoPAqM5r0mwlqR7XzB53d
        Rjsufg4pZw8ANEd+HBy+FnET35BxwxtPJk8osTGpuQ==
X-Google-Smtp-Source: ACHHUZ6Kx8+7itTB47PqlURIRY4BC+R9FMPIpD0aIM53TSUC1SmbQlDv8CVEQB3Mwp8C6Li/1pN3yA==
X-Received: by 2002:a17:902:8ec5:b0:1a9:b91f:63fc with SMTP id x5-20020a1709028ec500b001a9b91f63fcmr4006983plo.12.1683221538328;
        Thu, 04 May 2023 10:32:18 -0700 (PDT)
Received: from ?IPv6:2601:647:4900:1fbb:b40e:b203:5bb6:ae0f? ([2601:647:4900:1fbb:b40e:b203:5bb6:ae0f])
        by smtp.gmail.com with ESMTPSA id c6-20020a170902b68600b001a4edbab9c4sm20532481pls.254.2023.05.04.10.32.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 May 2023 10:32:17 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH v6 bpf-next 0/7] bpf: Add socket destroy capability
From:   Aditi Ghag <aditi.ghag@isovalent.com>
In-Reply-To: <5083c2ab-4745-2a73-3fb1-f2769840ce4d@linux.dev>
Date:   Thu, 4 May 2023 10:32:16 -0700
Cc:     Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8CAFAB3F-D734-43FE-B7C7-5B5133AE5BE9@isovalent.com>
References: <20230418153148.2231644-1-aditi.ghag@isovalent.com>
 <76dcba72-4e52-9ea1-cabd-b4c9f431c556@linux.dev>
 <E6DB96AE-A7FA-4462-A0ED-4C53F3625BB1@isovalent.com>
 <2249BAC9-E23F-42CD-9F33-F09ABE24BAF6@isovalent.com>
 <5083c2ab-4745-2a73-3fb1-f2769840ce4d@linux.dev>
To:     Martin KaFai Lau <martin.lau@linux.dev>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On May 2, 2023, at 4:40 PM, Martin KaFai Lau <martin.lau@linux.dev> =
wrote:
>=20
> On 5/2/23 3:52 PM, Aditi Ghag wrote:
>>> On May 1, 2023, at 4:32 PM, Aditi Ghag <aditi.ghag@isovalent.com> =
wrote:
>>>=20
>>>=20
>>>=20
>>>> On Apr 24, 2023, at 3:15 PM, Martin KaFai Lau =
<martin.lau@linux.dev> wrote:
>>>>=20
>>>> On 4/18/23 8:31 AM, Aditi Ghag wrote:
>>>>> This patch adds the capability to destroy sockets in BPF. We plan =
to use
>>>>> the capability in Cilium to force client sockets to reconnect when =
their
>>>>> remote load-balancing backends are deleted. The other use case is
>>>>> on-the-fly policy enforcement where existing socket connections =
prevented
>>>>> by policies need to be terminated.
>>>>=20
>>>> If the earlier kfunc filter patch =
(https://lore.kernel.org/bpf/1ECC8AAA-C2E6-4F8A-B7D3-5E90BDEE7C48@isovalen=
t.com/) looks fine to you, please include it into the next revision. =
This patchset needs it. Usual thing to do is to keep my sob (and author =
if not much has changed) and add your sob. The test needs to be broken =
out into a separate patch though. It needs to use the '__failure =
__msg("calling kernel function bpf_sock_destroy is not allowed")'. There =
are many examples in selftests, eg. the dynptr_fail.c.
>>>>=20
>>>=20
>>> Yeah, ok. I was waiting for your confirmation. The patch doesn't =
need my sob though (maybe tested-by).
>>> I've created a separate patch for the test.
>> Here is the patch diff for the extended test case for your reference. =
I'm ready to push a new version once I get an ack from you.
> Looks reasonable to me.
>=20
> One thing I have been thinking is the bpf_sock_destroy kfunc should =
need a KF_TRUSTED_ARGS but I suspect that may need a change in the =
tcp_reg_info in tcp_ipv4.c. Not sure yet. Regardless, I don't think this =
will have a major effect on other patches in this set. Please go ahead =
to respin considering there are a few comments that need to be addressed =
already. At worst it can use one final revision to address =
KF_TRUSTED_ARGS.

Pushed the next revision.
Re KF_TRUSTED_ARGS: Looking at the description in the README, it's not =
entirely clear to me why we need it here now that we are restricting the =
kfunc to only the iterator programs. Is it somehow related to be able =
ensure that the socket argument needs to be locked?

> [ btw, I don't see your reply/confirmation on the Patch 1 discussion =
also. Please ensure those will also be clarified/addressed in the next =
respin. ]
>=20
>=20
>> diff --git a/tools/testing/selftests/bpf/prog_tests/sock_destroy.c =
b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
>> index a889c53e93c7..afed8cad94ee 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/sock_destroy.c
>> @@ -3,6 +3,7 @@
>>  #include <bpf/bpf_endian.h>
>>  #include "sock_destroy_prog.skel.h"
>> +#include "sock_destroy_prog_fail.skel.h"
>>  #include "network_helpers.h"
>>  #define TEST_NS "sock_destroy_netns"
>> @@ -207,6 +208,8 @@ void test_sock_destroy(void)
>>                 test_udp_server(skel);
>> +       RUN_TESTS(sock_destroy_prog_fail);
>> +
>>  cleanup:
>>         if (nstoken)
>>                 close_netns(nstoken);
>> diff --git =
a/tools/testing/selftests/bpf/progs/sock_destroy_prog_fail.c =
b/tools/testing/selftests/bpf/progs/sock_destroy_prog_fail.c
>> new file mode 100644
>> index 000000000000..dd6850b58e25
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/sock_destroy_prog_fail.c
>> @@ -0,0 +1,22 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include "vmlinux.h"
>> +#include <bpf/bpf_tracing.h>
>> +#include <bpf/bpf_helpers.h>
>> +
>> +#include "bpf_misc.h"
>> +
>> +char _license[] SEC("license") =3D "GPL";
>> +
>> +int bpf_sock_destroy(struct sock_common *sk) __ksym;
>> +
>> +SEC("tp_btf/tcp_destroy_sock")
>> +__failure __msg("calling kernel function bpf_sock_destroy is not =
allowed")
>> +int BPF_PROG(trace_tcp_destroy_sock, struct sock *sk)
>> +{
>> +       /* should not load */
>> +       bpf_sock_destroy((struct sock_common *)sk);
>> +
>> +       return 0;
>> +}
>>>=20
>>>=20
>>>> Please also fix the subject in the patches. They are all missing =
the bpf-next and revision tag.
>>>>=20
>>>=20
>>> Took me a few moments to realize that as I was looking at earlier =
series. Looks like I forgot to add the tags to subsequent patches in =
this series. I'll fix it up in the next push.

