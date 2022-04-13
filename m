Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0A44FED6E
	for <lists+bpf@lfdr.de>; Wed, 13 Apr 2022 05:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiDMDUE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Apr 2022 23:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiDMDUE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Apr 2022 23:20:04 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762D9247
        for <bpf@vger.kernel.org>; Tue, 12 Apr 2022 20:17:44 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id x4so507827iop.7
        for <bpf@vger.kernel.org>; Tue, 12 Apr 2022 20:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4UQjjYWqmxOfJJBzJdrxYWYEuLv+9WugfhSWsQ4beqk=;
        b=n9eXAHqXtklUy78v22oNbHiP9V0pNd6w60VPojwRcXChwAB1m3sBqwaG28pxBDI5nK
         DRDMJP8LDTL7zCmo3WCGl8kd1vTgxANx5SxMq31XjqprPCKgLKJDqx3015A3WSk78L4x
         ODvs9Kra0Wy4rGTuNmZyccBxsOipMlwqnudmhTNpovSWHUeEQjgFV7WPsJbZEkqcs1ZW
         7eGtlPKSKvV8zT3YGG4uJSAWFCyzfsISr9pwfkD+m5Mhv7mHAyNVyWCvKK1TWZtbikbp
         KDYTfP05CEIGf4AnImzn2HjAcXeI36AKv8XGH6CpnU6LsDd5DeybI/hhxnfwQzVg5TS+
         wxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4UQjjYWqmxOfJJBzJdrxYWYEuLv+9WugfhSWsQ4beqk=;
        b=SDRveIRcJLNTrcmrX2uEYso/CE9Pitdx+ivGpDL8drYncK5/tXtxEMCo1b3h/v7cV8
         2rUbLt7/SDfk8UVG+pXtgeztmW0XAf8kBLDoxC62lOzcoCtbV3HnAGrnJRS4lL3vtiz2
         RGagLYjspxiancndbCshGAWL5ZeqqINvLm8aEon0XV1MVvUr8VZx6rApCpDz8MafLoRK
         g+xnSTp5m06tcuo9nTcJsThySsZzMgpRYwW9YTrrpA0kU10PrUVER8Oo2tKz4/xbYZQ8
         042aN3ojnZ6K478NJLJ3C2+y0y/57zs7IsLE+/lELD18RIMnIMsG9tByxVS1CfBZfdFj
         Ibng==
X-Gm-Message-State: AOAM530GcDJfduYiRko203UwEb/THNc3CpoIngXYxwOfpKHYvYTLy8wW
        zZ4JgvWGu+xyXvhigBDIMI8u2I7+xR2mFZIjdIs=
X-Google-Smtp-Source: ABdhPJySsMYlN2zX2f4yt9YDxXXmbVA+qbXWd112JUK1vdgxlgspdEZEwTaNM4vZPSppgcSszRXhdrolVcZ/oy5a0iE=
X-Received: by 2002:a05:6638:1696:b0:326:2d59:7b40 with SMTP id
 f22-20020a056638169600b003262d597b40mr7177773jat.103.1649819863907; Tue, 12
 Apr 2022 20:17:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220412165555.4146407-1-kuifeng@fb.com> <20220412165555.4146407-6-kuifeng@fb.com>
In-Reply-To: <20220412165555.4146407-6-kuifeng@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 12 Apr 2022 20:17:32 -0700
Message-ID: <CAEf4Bzbq+rcUJuXtBDb__M97xNAWH_5CbJAYrxCrDKytX_dJvw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 5/5] selftest/bpf: The test cses of BPF cookie
 for fentry/fexit/fmod_ret.
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
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

On Tue, Apr 12, 2022 at 9:56 AM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> Make sure BPF cookies are correct for fentry/fexit/fmod_ret.
>
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> ---
>  .../selftests/bpf/prog_tests/bpf_cookie.c     | 52 +++++++++++++++++++
>  .../selftests/bpf/progs/test_bpf_cookie.c     | 24 +++++++++
>  2 files changed, 76 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
> index 923a6139b2d8..7f05056c66d4 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
> @@ -410,6 +410,56 @@ static void pe_subtest(struct test_bpf_cookie *skel)
>         bpf_link__destroy(link);
>  }
>
> +static void tracing_subtest(struct test_bpf_cookie *skel)
> +{
> +       __u64 cookie;
> +       int prog_fd;
> +       int fentry_fd = -1, fexit_fd = -1, fmod_ret_fd = -1;
> +

unnecessary empty line

> +       LIBBPF_OPTS(bpf_test_run_opts, opts, .repeat = 1);

.repeat = 1 is not necessary, I think, .repeat = 0 is equivalent to that

> +       LIBBPF_OPTS(bpf_link_create_opts, link_opts);
> +
> +       skel->bss->fentry_res = 0;
> +       skel->bss->fexit_res = 0;
> +
> +       cookie = 0x100000;

nit: make this value bigger to make sure higher 32 bits of u64 are
preserved properly. Maybe 0x1000000010000000 (and similarly with 2 and
3)

> +       prog_fd = bpf_program__fd(skel->progs.fentry_test1);
> +       link_opts.tracing.bpf_cookie = cookie;
> +       fentry_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_FENTRY, &link_opts);
> +

ASSERT_GE?

> +       cookie = 0x200000;
> +       prog_fd = bpf_program__fd(skel->progs.fexit_test1);
> +       link_opts.tracing.bpf_cookie = cookie;
> +       fexit_fd = bpf_link_create(prog_fd, 0, BPF_TRACE_FEXIT, &link_opts);
> +       if (!ASSERT_GE(fexit_fd, 0, "fexit.open"))
> +               goto cleanup;
> +

[...]
