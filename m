Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C349D520986
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 01:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiEIXrT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 May 2022 19:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234705AbiEIXrD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 May 2022 19:47:03 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB79B2CBE54
        for <bpf@vger.kernel.org>; Mon,  9 May 2022 16:37:44 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id j12so7494712ila.12
        for <bpf@vger.kernel.org>; Mon, 09 May 2022 16:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n5fkPy0oYoTPi/KkPpKe0WZcAq9Um6hCwfQcDJaadUE=;
        b=FbrWMu91jtAFdb7PcGY702blcrSc0Co7bH61mMdz55kM2JxnSjGSVWBr2XlcMeysgU
         AFtw7qMU80sFzrJOAal85ARoB0dMk54Nk4SrytdB3hKNtjCNlSvI3fPc/57FnDzbo64y
         FP3DOzEve2prWgve9IZNkUTaTk/PsB2IphZJkBOjN2LP9OyFcST8J5PT5aVAGA51A32C
         8MwImDhNxpn4zVHb0Uf94Gk2PXTgpq+JFj2nFcYpCroAkGA4Lo8mEYpRKc8m4rynwHyo
         Kp6H+UF9JRr6M62ZPVTHRvGne1gLWj9/BFSX7EmeyKKJMNdklsjP2rMngakDgIyxxTng
         m+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n5fkPy0oYoTPi/KkPpKe0WZcAq9Um6hCwfQcDJaadUE=;
        b=Djx9VjbZzWNj/lqNWzEEjoWRHLOv5l6qBoQEj5W1et4MqOsUQTb4edRjIr5CB/UxNX
         I8iGD5juF2IcYUykxi2AP1Gk5sOE6bWeJj49a7WdNOVuKDjQJAi040I79HkLVSahXKyT
         JxEZ6z3cP+RSD4QJYOLP2Wp8pj5lAmhQ2Gx936la3SyGpHWhMGlRgtX2k4DsBa+UW2Ew
         havqAswDpNOdg8Jvebvy0mSGaoHqUp+LyB0As6Aipn+MCAaLAMILgpqeDUu7//LkXYZj
         YD0IPXObp7MB2GEJz3GxK2r907cBZ4AhZ4JGzmY6SPT//Vea8U54OAlM39tMr6cJDMiI
         62EQ==
X-Gm-Message-State: AOAM530KraqZ607yWeSU0/mQ5aEw1QZCsh43ny+iOMlA9XUoziFOxrWR
        eX9aCIKo5GP6eCxsnmUSkUClNqD0c7G5Pr0u8HY=
X-Google-Smtp-Source: ABdhPJwKS+bD59UlpaWEbCRUm0AKjoM7JqyzSFD5Z8HRr/tbLIWRc9oR76uu0zIFxI5aqts18xw6Z9b6xpaofDLNhhM=
X-Received: by 2002:a05:6e02:1c03:b0:2cf:2a1d:d99c with SMTP id
 l3-20020a056e021c0300b002cf2a1dd99cmr7764383ilh.98.1652139464182; Mon, 09 May
 2022 16:37:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220501190002.2576452-1-yhs@fb.com> <20220501190049.2580282-1-yhs@fb.com>
In-Reply-To: <20220501190049.2580282-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 9 May 2022 16:37:33 -0700
Message-ID: <CAEf4BzaY1St3YwYJirkvXWumYYK9zBi2HX8ru3PbjEXRurr9Ng@mail.gmail.com>
Subject: Re: [PATCH bpf-next 09/12] selftests/bpf: Test BTF_KIND_ENUM64 for deduplication
To:     Yonghong Song <yhs@fb.com>
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

On Sun, May 1, 2022 at 12:00 PM Yonghong Song <yhs@fb.com> wrote:
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

Please add some commit message, however trivial.

Can you please add a simple test to validate that enum and enum64 are
not deduplicated against each other?


>  tools/testing/selftests/bpf/prog_tests/btf.c | 70 +++++++++++++++++++-
>  1 file changed, 68 insertions(+), 2 deletions(-)
>

[...]
