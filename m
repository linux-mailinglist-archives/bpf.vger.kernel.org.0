Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56AB36A5F0D
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 19:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjB1SxS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Feb 2023 13:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjB1SxS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Feb 2023 13:53:18 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B749B1C333
        for <bpf@vger.kernel.org>; Tue, 28 Feb 2023 10:53:16 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id cy6so44170723edb.5
        for <bpf@vger.kernel.org>; Tue, 28 Feb 2023 10:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNU5+AzgzI4ss6Xwg57Q+7tRkv5dipXdyLF5zVysHMM=;
        b=f0EWN6SQFgbHmbotCsp2kSDCJUCco9mPXe9nMEzKG6GIFdWXpf2rQjQ14ZF1uhXkk4
         35RqU00fRwRNuTNMLCJFuXQdoNJc9cgXg27rV+GENcDjj8k6e6S+8FjZTCc7B9FQNavW
         oHvzad5mpzXlBn1iDi+DsyWU2lR/wat6fpluzVg+6n6yLlUkypCkCDYuDsC4tWaPZ2aC
         jbYkNTg7fa6KI+zDklbFkw4FhcqiovYhS3g4Ne2/D2NeRbubQrqgTNsnaD/S2+3AGlo4
         JW8Sq6jZ5zbZf2juICAh9dNFb69lSk0fOAZXvb+lB/ZW6PZHHIDKFp7v4ZTTI8JOjXq9
         w0Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rNU5+AzgzI4ss6Xwg57Q+7tRkv5dipXdyLF5zVysHMM=;
        b=ZT5bs2WjtSNRlNTc5VUfH6tlIzdXY+wM0ejHcVdiWHlRqWLCtORLIKE1BGqfOYZAOA
         /JXNHhOrLPZwABNNf2BvvP6GYVddiKx3nDwqKO0owWfFQXz9ybv/6FIaHfeSDEsNnhQd
         PiyqSWbPg2REyIcvXTDKrcjc/TPglD2Y395LkXewMAMOTpYf5Jc2qHiLusylbhPBA7Mk
         52tgGO2xmfV6snaTAl7ClL4O87VHIwNnMkkL9vsIQ80loR1XM6XJwbIJNmFfzCTTns3w
         iqAWKAKIFR3ySWp7hkT+wvjt1jCsDQi8o46cP1XQyYMmk275qmYpc/PjfNVM9drsUZdh
         LwGA==
X-Gm-Message-State: AO0yUKVhGvZH1UdkNkfdP454VK92iOiKLuhydoTi1STho1Pkf+4oiJup
        PeHHW/FHeZPAW3/ma5Xle4eY+Ges6XMqbu0zQcg=
X-Google-Smtp-Source: AK7set9NTbbg2Knpc+Ed9fR2H3n5Wc8k0kmve+rYy/Ete8wTNx0PX0Z3iLnwWIXPYo0nURWYs3+ZfB41xqdyqbsOOp0=
X-Received: by 2002:a17:906:720e:b0:8de:c6a6:5134 with SMTP id
 m14-20020a170906720e00b008dec6a65134mr1670099ejk.15.1677610395063; Tue, 28
 Feb 2023 10:53:15 -0800 (PST)
MIME-Version: 1.0
References: <20230123145148.2791939-1-eddyz87@gmail.com> <20230123145148.2791939-2-eddyz87@gmail.com>
In-Reply-To: <20230123145148.2791939-2-eddyz87@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 28 Feb 2023 10:53:03 -0800
Message-ID: <CAEf4BzZ-9iHzotYj2K3a+USFsxmqLEA+pHm4Ot6Nr2WtZ-AHeA@mail.gmail.com>
Subject: Re: [RFC bpf-next 1/5] selftests/bpf: support custom per-test flags
 and multiple expected messages
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 23, 2023 at 6:52=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> From: Andrii Nakryiko <andrii@kernel.org>
>
> Extend __flag attribute by allowing to specify one of the following:
>  * BPF_F_STRICT_ALIGNMENT
>  * BPF_F_ANY_ALIGNMENT
>  * BPF_F_TEST_RND_HI32
>  * BPF_F_TEST_STATE_FREQ
>  * BPF_F_SLEEPABLE
>  * BPF_F_XDP_HAS_FRAGS
>  * Some numeric value
>
> Extend __msg attribute by allowing to specify multiple exepcted messages.
> All messages are expected to be present in the verifier log in the
> order of application.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> [ Eduard: added commit message, formatting ]
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---

hey Eduard,

When you get a chance, can you please send this patch separately from
the rest of the test_verifier rework patch set (it probably makes
sense to also add #define __flags in this patch as well, given you are
parsing its definition in this patch).

This would great help me with my work that uses all this
assembly-level test facilities. Thanks!



>  tools/testing/selftests/bpf/test_loader.c | 69 ++++++++++++++++++++---
>  tools/testing/selftests/bpf/test_progs.h  |  1 +
>  2 files changed, 61 insertions(+), 9 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/se=
lftests/bpf/test_loader.c
> index 679efb3aa785..bf41390157bf 100644
> --- a/tools/testing/selftests/bpf/test_loader.c
> +++ b/tools/testing/selftests/bpf/test_loader.c
> @@ -13,12 +13,15 @@
>  #define TEST_TAG_EXPECT_SUCCESS "comment:test_expect_success"
>  #define TEST_TAG_EXPECT_MSG_PFX "comment:test_expect_msg=3D"
>  #define TEST_TAG_LOG_LEVEL_PFX "comment:test_log_level=3D"
> +#define TEST_TAG_PROG_FLAGS_PFX "comment:test_prog_flags=3D"
>

[...]
