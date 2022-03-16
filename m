Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52FC4DA9EE
	for <lists+bpf@lfdr.de>; Wed, 16 Mar 2022 06:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243218AbiCPFiO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Mar 2022 01:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237378AbiCPFiN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Mar 2022 01:38:13 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6B55FF33
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 22:37:00 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id l18so1220272ioj.2
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 22:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=coUA3YUf5pTCCMjmNUCv2EX0wd4KHeKfTEVUciybZBA=;
        b=VmR8lbzDyKwUrXJuPPJgPimUGU2qNbYvifMLhODbAMD9P283rSnpFPR587nmfCELQ7
         ysKExYWJylF2KSnPhtte7yRnGvjnTsRgFKPtoKcQhj1LeBneOevvX9EdQZQ/C+5imDZ3
         sCxUOtQ0QzJ+61lbge0BEJHYlfdRfCn5ewROnrU275rlLcpw4LqLW73pl6AZbjKkdOdX
         BG/8TOBsDvkSN8h4cs3KGMVO2BAqxJsoL0W8YlRIrDZfbIEVUqfakU1Sp8Hf72N7C6PM
         IrHpbHx2kYbXV7olSenGqcsllL8MujpyGwZ+mM9NASQukCxK9PZVW14qcdCI2tjjNPmM
         dkqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=coUA3YUf5pTCCMjmNUCv2EX0wd4KHeKfTEVUciybZBA=;
        b=lvqP0C/35PMvrvsrQ/qhCyVdp8dbZOQW/cENFbNHhQT9lRP9qWdmTXg2hP59A42NWx
         P81OkpYQheToTFtoGWZ+Cu9g+QcH20xBMQgrB7XQ7pMW5mNF04v7j1N0wy6stiosJG9P
         EJJiZhabUlyXhOuO6W/2imqtzylBSbW2780xnlwpufu5q3bmS7BRgmHWJ4Afjf2clsHn
         t4PJll5cAhnOiXSNC7uwOg3hjFqjNr1HY/MR7VSBaBtqLDSUqJBGJeUT82Aep1pP0+oH
         bnPiuxJt7PaM1FpiiZWGtFb7/eOCFhZO6OrcBG8ABOOn9wzL3OrkkKNJE260jU4ZB4aG
         9+zQ==
X-Gm-Message-State: AOAM531w1NNDTKMLG4nR+Uel1Q0FYDmGqDmqnBL7Uky34TTSBgFTYV6M
        ZZiRvt8eMpsO70S3xeCHQaveXMtRlekDIl6Myxs=
X-Google-Smtp-Source: ABdhPJzyzGFc7G9w5pMh0KyDNzy+lxzTfyK00eayaYgQSPtjQ9WWqYkLfB2dQiTbBCn0Qb1gvIuu4WMgzxSRFtMl6zY=
X-Received: by 2002:a05:6638:1035:b0:306:e5bd:36da with SMTP id
 n21-20020a056638103500b00306e5bd36damr25920868jan.145.1647409019879; Tue, 15
 Mar 2022 22:36:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220316014841.2255248-1-kafai@fb.com>
In-Reply-To: <20220316014841.2255248-1-kafai@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 15 Mar 2022 22:36:48 -0700
Message-ID: <CAEf4BzbcDJWy+JMGAawm5Q+_YOYjw6BJWOQBvLOZCmcjL5FGkA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] Remove libcap dependency from bpf selftests
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
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

On Tue, Mar 15, 2022 at 6:48 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> After upgrading to the newer libcap (>= 2.60),
> the libcap commit aca076443591 ("Make cap_t operations thread safe.")
> added a "__u8 mutex;" to the "struct _cap_struct".  It caused a few byte
> shift that breaks the assumption made in the "struct libcap" definition
> in test_verifier.c.
>
> This set is to remove the libcap dependency from the bpf selftests.
>
> Martin KaFai Lau (3):
>   bpf: selftests: Add helpers to directly use the capget and capset
>     syscall
>   bpf: selftests: Remove libcap usage from test_verifier
>   bpf: selftests: Remove libcap usage from test_progs
>

Love the clean up and dropping the dependency on libcap! But it
currently breaks CI, probably because of missing CAP_BPF definitions
due to old system headers. Let's add #ifndef CAP_BPF/#define CAP_BPF
XXX/#endif guards for newer capabilities to make it work in CI as
well?

  [0] https://github.com/kernel-patches/bpf/runs/5563642266?check_suite_focus=true

>  tools/testing/selftests/bpf/Makefile          |  8 +-
>  tools/testing/selftests/bpf/cap_helpers.c     | 68 ++++++++++++++
>  tools/testing/selftests/bpf/cap_helpers.h     | 10 +++
>  .../selftests/bpf/prog_tests/bind_perm.c      | 45 ++--------
>  tools/testing/selftests/bpf/test_verifier.c   | 89 ++++++-------------
>  5 files changed, 118 insertions(+), 102 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/cap_helpers.c
>  create mode 100644 tools/testing/selftests/bpf/cap_helpers.h
>
> --
> 2.30.2
>
