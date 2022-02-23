Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B684C1EEF
	for <lists+bpf@lfdr.de>; Wed, 23 Feb 2022 23:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244544AbiBWWok (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Feb 2022 17:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244543AbiBWWoU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Feb 2022 17:44:20 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FD33F8A9
        for <bpf@vger.kernel.org>; Wed, 23 Feb 2022 14:43:47 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id s1so619075iob.9
        for <bpf@vger.kernel.org>; Wed, 23 Feb 2022 14:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7YKtPqg+tKLGOpt2hS0jSm7gg6qCVqChlbGRBfQdohQ=;
        b=Br++dvhIchNHYyHBsviR2BCGCqWkeyk4NVC6K2YqctoYjgkIOiIiP8sXFO3xpyPN1I
         zpxfSMiuacQEZUO7wTklPi3K2Z/F5gFIBjxuN3hO/LSjGMKb5MQZNC2NRd8XfPL06Vgz
         EwX/WQi9v9hwHBOqLrjg6OHMwCipU21TzcJcqclaaDGK31etcXF514ALk1rtvQcdDUjX
         MzVKo7tONGVEpeNeeUIVQXULMJlquXWpJEUR/eBI9ghG82n2ZVoFIb+avTw7i8Xu5eOB
         kwjbG+iT5nYAtjAikchM9MeQ6z0U96MJ0iX5HVxkTBWih3+Jxzf4ORM2sQJyugo77E9o
         Qkzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7YKtPqg+tKLGOpt2hS0jSm7gg6qCVqChlbGRBfQdohQ=;
        b=gWNLHPhp0rBj9H/e23tO7APQLF4RB/6Np/kzhcm9DqucukEfwN/GSsHvJKt4SXVUF2
         G6LiO5t0o2ZYjXk7Jmd9tkGP134r6ery9jR1tHvP6HBV8riFChgR7tS8aHVr/+zmBiQD
         203rIQb9oKfH764tPKOUoiV1jEKyyuohPet+S/DI3Ex4o8qIT9VUIgfgSlJribiJialu
         ExaRt5R7rKpu9cxlTizBm0NYEBWgOsSJTdMfUwY83iVQaMzsrPlX4bq/25lfvNPM9TUz
         iwG6ETS1x1C6k4tJSJe0NcgeamIzgV6/IMKhwJaRTdTjfxxpDN1x80oTFV7G77bx2zDJ
         SJJg==
X-Gm-Message-State: AOAM532GUKV+rsRUmhC0w9htm1Al9qO9DSMe9PCHt6RShIBSd5fjJ4yM
        bxCYnE9fHXagtA9fMdtSZf4nfNw6R9v6K4E6D5M=
X-Google-Smtp-Source: ABdhPJz/qIO3gAkf+R2I7bf2YbcsO7Y+G1voUHc1HUFJkqH0q/MO4x0VICL41TqBUDglE1JU9/PSamhBH9LEZgBP6Hg=
X-Received: by 2002:a05:6602:3c6:b0:63d:cac9:bd35 with SMTP id
 g6-20020a05660203c600b0063dcac9bd35mr1161536iov.144.1645656227183; Wed, 23
 Feb 2022 14:43:47 -0800 (PST)
MIME-Version: 1.0
References: <20220222074524.1027060-1-xukuohai@huawei.com>
In-Reply-To: <20220222074524.1027060-1-xukuohai@huawei.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 23 Feb 2022 14:43:36 -0800
Message-ID: <CAEf4Bza8BZywsL_B_ijW2Qg8SdjRFPbNKrX55X3xzmGwYUzrNw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/2] libbpf: Fix btf dump error for BTF_KIND_FWD
To:     Xu Kuohai <xukuohai@huawei.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, Shuah Khan <shuah@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>
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

On Mon, Feb 21, 2022 at 11:34 PM Xu Kuohai <xukuohai@huawei.com> wrote:
>

Please add a brief cover letter description.

> Xu Kuohai (2):
>   libbpf: Skip BTF_KIND_FWD when counting duplicated type names
>   selftests/bpf: Update btf_dump for conflict FWD and STRUCT name
>
>  tools/lib/bpf/btf_dump.c                         | 16 +++++++++-------
>  .../testing/selftests/bpf/prog_tests/btf_dump.c  | 11 +++++++++--
>  2 files changed, 18 insertions(+), 9 deletions(-)
>
> --
> 2.30.2
>
