Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8620560AFE
	for <lists+bpf@lfdr.de>; Wed, 29 Jun 2022 22:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiF2U0C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Jun 2022 16:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiF2U0C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Jun 2022 16:26:02 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4B339BAF
        for <bpf@vger.kernel.org>; Wed, 29 Jun 2022 13:26:01 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id h23so34782891ejj.12
        for <bpf@vger.kernel.org>; Wed, 29 Jun 2022 13:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jf3D1j9CIcO+WkUMZHuEdL7/5dCWXo0gdy+GeZIG/H8=;
        b=DydcTUXIPh07kW/27+s3fz2Ag2DI/zx3ASW5PKEgQu6E5iTeEr/95UzF5FEX8a0OsL
         efMhgytpJ1zRpI78vswlk++lxqZT881TmMvy5mhOQIQZfvWo190eRhsKQWicvwE6kviV
         5KN3jzXiNxisBAVugy/850Z6J8e6Degvc/yv0vB4D0hDQjRI1Rb5iQBv3NKqemCCwggj
         rUYRVvwmmzHboShyqRvv/3XuI+xzMFtz7QJ7Kx8SUPYUs93oW+PaKsqA+5o7G1HIpXcp
         H+XpX6Lzn053FSB6p3AYV2QA9mLRwzltPdZAjfi/RCZtStlQDmbMpQP0kEer79TFHU1g
         cpzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jf3D1j9CIcO+WkUMZHuEdL7/5dCWXo0gdy+GeZIG/H8=;
        b=BnGdYPD+HtLq7lyVhTDVbailDjPiZNDI2gyxbiXBeZ8aokvHJjIq3Bll1ND0y4wzCH
         koodJc55vi2E+Axumq9GnmkRJHm8D+2N8Z9+IM2dm81CwKP8/4uO/R3Lg6/EQnR1IDWA
         i+QTvlw/be1hvX5PtS0AIodloimBNuHYX3XUYUFk0Wtu2+TLBqPewZEizwZWYG45rm4l
         /2C9lO4mIkFgy1jJ3afM6o9AVzSME9WOwfmMj9ao6IiCphxVLzRU4cb/8qIwIUrk9UwX
         G7APmzGZJKMdYzYscJxPr1A36Z2L5oooK48UWqPBbvWCecjTn7yD130h8ytIkyrFcNVX
         2I4Q==
X-Gm-Message-State: AJIora8ovM6zhCvW/4jnudxgKKxpqLQwGaSy+YS9cMvu6tHFaXD8ZX1K
        rqFJNZ7CufbLcB+loaAzZdw7MhuMxwclqKUEKyU=
X-Google-Smtp-Source: AGRyM1vAwjKXX9+parQQRyeBl7Ysbeod7gRtGG7GX2UxyD60ypgwyGpsQp0o1IZdefYeDW8gIJXkSuEGtRTQhOo7TW0=
X-Received: by 2002:a17:906:5189:b0:722:dc81:222a with SMTP id
 y9-20020a170906518900b00722dc81222amr5168729ejk.502.1656534360059; Wed, 29
 Jun 2022 13:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220628174314.1216643-1-sdf@google.com> <20220628174314.1216643-12-sdf@google.com>
In-Reply-To: <20220628174314.1216643-12-sdf@google.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 29 Jun 2022 13:25:48 -0700
Message-ID: <CAADnVQJHKtYd2XKiWRj_5fnVdT7aP2NEwi4eVUdqCO7q2nQ6Og@mail.gmail.com>
Subject: Re: [PATCH bpf-next v11 11/11] selftests/bpf: lsm_cgroup functional test
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>
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

On Tue, Jun 28, 2022 at 10:43 AM Stanislav Fomichev <sdf@google.com> wrote:
> +
> +static void test_lsm_cgroup_functional(void)

It fails BPF CI on s390:

test_lsm_cgroup_functional:FAIL:attach alloc_prog_fd unexpected error:
-524 (errno 524)
test_lsm_cgroup_functional:FAIL:detach_create unexpected
detach_create: actual -2 < expected 0
test_lsm_cgroup_functional:FAIL:detach_alloc unexpected detach_alloc:
actual -2 < expected 0
test_lsm_cgroup_functional:FAIL:detach_clone unexpected detach_clone:
actual -2 < expected 0

https://github.com/kernel-patches/bpf/runs/7100626120?check_suite_focus=true

but I pushed it to bpf-next anyway.
Thanks a lot for this work and please follow up with a fix.

Thanks a lot Martin for the code reviews.
