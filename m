Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 431D258D070
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 01:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237021AbiHHXXJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 19:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiHHXXJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 19:23:09 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9141ADB3
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 16:23:08 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z2so13184603edc.1
        for <bpf@vger.kernel.org>; Mon, 08 Aug 2022 16:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=WQx29u/pxD0SaJZZU8Z3wqyyKyj94UPNM6ayS4UIcMA=;
        b=B1nxi8HIlzjwbO+o8AnR/TiyIukYMklNW9AF6+vrBn23Fw7E6kIeB3fhUyXLFsUbEN
         lg1HqyZctNZaxRcr/+2b3zuc1i++HlHEYTlnfYPGQSM0O3S6Tc0nl+2c46NYZQNYDhOK
         98xNQtdc8Rwf21oih7DMLz4X/zO1Ja+H/nLlf6pvTu9oqeRmhn8wIQXLYcB66mo1G7G5
         rOz/kzIhHsAFo6lbnpui6f6HKBgNkPjs90LwrgZPTIUdT6ecnntYIkwq5Zu4uPfQROXa
         tnqRY0gJgb025fsfVX0O+VgdKlhb8sMMmF5f5Q3y68T3iNAlLDByCxU9iZMoVM5mGpWA
         GTiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=WQx29u/pxD0SaJZZU8Z3wqyyKyj94UPNM6ayS4UIcMA=;
        b=JcNx3O0xmgr0Q4DtZ5AS3OWrif+SqxpppAiF4n6GUolBS7DjJu/ax0BlmXJMSbmLxn
         q42bIX0Q7FxJf8d6Jggo+t4lrzZAiSxSK08KI7W2mOirDkN/LtGTTI4Y48FGT0lM14nR
         dNiS7QA6xdq2FyQYUze6VUzCc3HTmfJssCBiJ+0AIxjB//BmTm5kd/nDQbId3ayFiPDS
         2TgOoGiQ3bVrlL8xXDN1KHHINoyF9jCOBAKJV/kmBF945bcFGMkpMzaY9+fscxvq+aE3
         T2ilAns1NyKKUJSTTT3C4dXPgujSdDPzVx6oYQFZZcPu75tAeMFAHVaYgJ/45gPjAInQ
         Q69g==
X-Gm-Message-State: ACgBeo1b2qG7aGwUv89zY+EZeeTpRKqzLpAPJeyTJVP8kmRml69Pwsy4
        4WYDcjsumcPwHnShLfnMITtS+LtKdSPmJIJmAE8=
X-Google-Smtp-Source: AA6agR6eGmr05O8rTBO/a5cmC4K+Lm6okENZ7bs9bimgL4UvIcpGepX/hosRlXIPqrdtiCMpCGuqMhLKHVQq1NbhJbw=
X-Received: by 2002:a05:6402:1945:b0:43b:d456:daf8 with SMTP id
 f5-20020a056402194500b0043bd456daf8mr19151631edz.81.1660000986705; Mon, 08
 Aug 2022 16:23:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220807175111.4178812-1-yhs@fb.com>
In-Reply-To: <20220807175111.4178812-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 8 Aug 2022 16:22:55 -0700
Message-ID: <CAEf4BzaG5pFRrWbviARB40+qL8abGrbCh9u3OuNctAC572XZRw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] bpf: Perform necessary sign/zero extension
 for kfunc return values
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Aug 7, 2022 at 10:51 AM Yonghong Song <yhs@fb.com> wrote:
>
> Tejun reported a bpf program kfunc return value mis-handling which
> may cause incorrect result. If the kfunc return value is boolean
> or u8, the bpf program produce incorrect results.
>
> The main reason is due to mismatch of return value expectation between
> native architecture and bpf. For example, for x86_64, if a kfunc
> returns a u8, the kfunc returns 64-bit %rax, the top 56 bits might
> be garbage. This is okay if the caller is x86_64 as the caller can
> use special instruction to access lower 8-bit register %al. But this
> will cause a problem for bpf program since bpf program assumes
> the whole r0 register should contain correct value.
> This patch set fixed the issue by doing necessary zero/sign extension
> for the kfunc return value to meet bpf requirement.
>
> For the rest of patches, Patch 1 is a preparation patch. Patch 2
> implemented kernel support to perform necessary zero/sign extension
> for kfunc return value. Patch 3 added two tests, one with return type
> u8 and another with s16.
>
> Yonghong Song (3):
>   bpf: Always return corresponding btf_type in __get_type_size()
>   bpf: Perform necessary sign/zero extension for kfunc return values
>   selftests/bpf: Add tests with u8/s16 kfunc return types
>
>  include/linux/bpf.h                           |  2 ++
>  kernel/bpf/btf.c                              | 18 +++++++---
>  kernel/bpf/verifier.c                         | 35 +++++++++++++++++--
>  net/bpf/test_run.c                            | 12 +++++++
>  .../selftests/bpf/prog_tests/kfunc_call.c     | 10 ++++++
>  .../selftests/bpf/progs/kfunc_call_test.c     | 32 +++++++++++++++++
>  6 files changed, 102 insertions(+), 7 deletions(-)
>
> --
> 2.30.2
>

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
