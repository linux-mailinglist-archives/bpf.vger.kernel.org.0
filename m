Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104B563B21D
	for <lists+bpf@lfdr.de>; Mon, 28 Nov 2022 20:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbiK1TVp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Nov 2022 14:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233265AbiK1TVn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Nov 2022 14:21:43 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B321176
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 11:21:42 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-3691e040abaso116202197b3.9
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 11:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9fOVYPzEWq03ZFs/br8EZa62mEXCmkPoiRaAFeq48n8=;
        b=tlNVXfVGaV5WTwnE3QftjwVNJpo07fKwGOE8OVPMzncvUz7BLPlXyEe1fiQNErhG8K
         EgxRCHAhWOcmG2kTBlypb6EUius4Oe0RAKFWAob9lWbHA6e39YA85m+/1wDj9pJZoz9m
         MEB2n/6FuqXCzRz/3HbRNKxHW7ZONwO//IbWpjOg4PPyPaAJ5Ng0SkuEg7cOfGflOFL/
         Zg35M8B5nR9Jntrmpa3Tv3EiRekvGUOEmMXBsYL6Y9wWP88IuZmgR21Jcz/B5ybehrWg
         YtebGxJQqfoI5WOEe1BUrawVDwyfHUOcWgYiJg00pNf+SXrOdwPJLetFBV2DL+up7ec9
         DLpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9fOVYPzEWq03ZFs/br8EZa62mEXCmkPoiRaAFeq48n8=;
        b=e/ZdnmnwIikVFRF9p36g2tgau10gfiK2FnvQseVVnd3LUBnsqFP38mIbmfuhavpLj/
         anqwgYtT6EmCePCiEccHqRJHI2epbRoN/iisGvq1lOWppEnKySB2q4AtdqD8RTDd3TLs
         EdUVs47nSe0l6aGfOi83WqfoTE9hqIIn7k1WWwv8JBhfZd+bsw7+6nruNyOzeN2LPkQt
         9xRgS3GRsnF2iHoRPzwiEFcMEfVWOguFK32k6bnJTooGAISDZ2Z8E6wm1FL8RXNLJuui
         BTlzEgiH82vMAN0NpivXTOLSAShIfqN8wUI1OUmRE8PUA5S9FsT8wiXldkCZiD5eh9RQ
         hrFg==
X-Gm-Message-State: ANoB5plvJ0npPUA5BhDClbyaD3mDNw3fsSu9Ngt5MkeyCXiODMGMZBpk
        HeozLLz19JRMSjHOhFPeOE7ULJZcSu9BcNuAmsmeckJHsCvung==
X-Google-Smtp-Source: AA0mqf6k6HXyPC/PpKrtNAujIUK+WjOOKfg0txkcCsyrNCvHUXpXW5YMBMr3afcgUS4mmpFVcRhU35l+ooCYkkcdo14=
X-Received: by 2002:a81:7dd5:0:b0:387:f835:77ec with SMTP id
 y204-20020a817dd5000000b00387f83577ecmr32439804ywc.125.1669663301321; Mon, 28
 Nov 2022 11:21:41 -0800 (PST)
MIME-Version: 1.0
References: <20221128132915.141211-1-jolsa@kernel.org> <20221128132915.141211-5-jolsa@kernel.org>
In-Reply-To: <20221128132915.141211-5-jolsa@kernel.org>
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 28 Nov 2022 11:21:30 -0800
Message-ID: <CA+khW7h_4GGGsyszYVfSKtbv0nnUSKc-_oCqXgsj=JQ9RaVy7A@mail.gmail.com>
Subject: Re: [PATCHv4 bpf-next 4/4] selftests/bpf: Add bpf_vma_build_id_parse
 task vma iterator test
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 28, 2022 at 5:30 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding tests for using new bpf_vma_build_id_parse kfunc in task_vma
> iterator program.
>
> On bpf program side the iterator filters test proccess and proper
> vma by provided function pointer and reads its build id with the
> new kfunc.
>
> On user side the test uses readelf to get test_progs build id and
> compares it with the one read from iterator.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../selftests/bpf/prog_tests/bpf_iter.c       | 44 +++++++++++++++++++
>  .../selftests/bpf/progs/bpf_iter_build_id.c   | 41 +++++++++++++++++
>  2 files changed, 85 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_build_id.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> index 6f8ed61fc4b4..b2cad9f70b32 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> @@ -33,6 +33,9 @@
<...>
>
> +static void test_task_vma_build_id(void)
> +{
> +       struct bpf_iter_build_id *skel;
> +       char buf[BUILDID_STR_SIZE] = {};

Jiri, do you mean buf[BUILDID_STR_SIZE + 1]? I see you have
buf[BUILDID_STR_SIZE] = 0; below.

> +       int iter_fd, len;
> +       char *build_id;
<...>
> +
> +       while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
> +               ;

I think you need to pass 'buf + len' to read(), otherwise the last
iteration will overwrite the content read from the previous
iterations.

> +       buf[BUILDID_STR_SIZE] = 0;
> +
> +       /* Read build_id via readelf to compare with iterator buf. */
> +       if (!ASSERT_OK(read_self_buildid(&build_id), "read_buildid"))
> +               goto exit;

We need to close iter_fd before going to exit.

> +
> +       ASSERT_STREQ(buf, build_id, "build_id_match");
> +       ASSERT_GT(skel->data->size, 0, "size");
> +
> +       free(build_id);
> +       close(iter_fd);
> +exit:
> +       bpf_iter_build_id__destroy(skel);
> +}
> +
<...>
> --
> 2.38.1
>
