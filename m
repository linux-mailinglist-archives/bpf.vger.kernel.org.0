Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4C663B231
	for <lists+bpf@lfdr.de>; Mon, 28 Nov 2022 20:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbiK1TZS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Nov 2022 14:25:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiK1TZP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Nov 2022 14:25:15 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993A62714A
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 11:25:14 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id e141so14644791ybh.3
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 11:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CZR/NpVrP+wUH1RLg6lAhmsTcEHOzTefoN3Eh20n/Qo=;
        b=MvzPAV1T/oa8VravfU6VorFSnASAn8h91DHI/HhmaOeyc6qiZfxF5w5JlS+7L30Goo
         cG+8EtRdyE6m2Vl6maCpC1Jma8F2/XZidfL5CseA7zqC6a40SZzR/tFTrqKGEn4HuYR0
         JFgd7tvDd2EbLC6I6gntIVCO00GCWtyK2rL3ysNWxxHTvdldpMKJPF+PP4AQRfOPPv8Q
         yymjum/q0s0ta7/x7vz6tQpOYtlBXPsgt73uCQYkfHrsX5ufeHye9lQXRmizDTcopskO
         TNnWt70Qg3jdQZXtvvAWj/Hwt9j4NQWEZGchv2fFZDzo6WkYpdnuEFpsrDZERdfiSuw+
         j3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CZR/NpVrP+wUH1RLg6lAhmsTcEHOzTefoN3Eh20n/Qo=;
        b=DjcDKaYM0KdduZ2TCJ9c66plcj/W3mO9RdqVYFmRohU+g7Skd/pSv5wtbSMommLO7r
         75s0wER6Ntkis85lEKCe63esh7r/0fUS9UZBD5iI7nT9QcvD/OCSCZV9Q/m9tl9kg4xd
         33apO6brcCaAdT5xDSfEewW2MKdhZqGpjmOL4gvI22c4nZfB7kbylyFBS1I/2IqqDQ6K
         ST4u7CdZ4WUpnatfXufJiuejpyeAWh3G3/kN+//e3oYNk1CBvX6DMNTJyQ6KIie/SYhe
         Z8PA3gSCm+ox7iDeKKl0zsFhxaRadN5O1fhGQKwC67RNv0gvqjozC4y236IvA8yZQk6h
         TRSg==
X-Gm-Message-State: ANoB5plhEg4ZyyiJX7bZ/zqQn/+WyutAW/Ird5YXWlqO2LuE1IHSNWZz
        5bB7dtTav3ENBUd3p4xf7tMHLmDwPjvdbi31uYVa7w==
X-Google-Smtp-Source: AA0mqf76+WVJR8OXO9oNToAHbBoiN+bbj5sGx2eTOZ+a+dY1ZcaDs/fskLPcusvCrFEp7NSAWZqwh6o6QADG8+02l/A=
X-Received: by 2002:a25:50f:0:b0:6f0:9351:486a with SMTP id
 15-20020a25050f000000b006f09351486amr26593726ybf.198.1669663513595; Mon, 28
 Nov 2022 11:25:13 -0800 (PST)
MIME-Version: 1.0
References: <20221128132915.141211-1-jolsa@kernel.org> <20221128132915.141211-4-jolsa@kernel.org>
In-Reply-To: <20221128132915.141211-4-jolsa@kernel.org>
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 28 Nov 2022 11:25:02 -0800
Message-ID: <CA+khW7hks-xqS-w7ZhKkSaj6eBDWu8QEW1qgaXi5oG5KdRQoWw@mail.gmail.com>
Subject: Re: [PATCHv4 bpf-next 3/4] selftests/bpf: Add bpf_vma_build_id_parse
 find_vma callback test
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
> Adding tests for using new bpf_vma_build_id_parse kfunc in find_vma
> callback function.
>
> On bpf side the test finds the vma of the test_progs text through the
> test function pointer and reads its build id with the new kfunc.
>
> On user side the test uses readelf to get test_progs build id and
> compares it with the one from bpf side.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
<...>
> diff --git a/tools/testing/selftests/bpf/progs/bpf_vma_build_id_parse.c b/tools/testing/selftests/bpf/progs/bpf_vma_build_id_parse.c
> new file mode 100644
> index 000000000000..8937212207db
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bpf_vma_build_id_parse.c
<...>
> +
> +SEC("fentry/bpf_fentry_test1")
> +int BPF_PROG(test1, int a)
> +{
> +       struct task_struct *task = bpf_get_current_task_btf();
> +
> +       if (task->pid != target_pid)
> +               return 0;

I think here we should use task->tgid. IIRC, task->pid corresponds to
thread id in the userspace. task->tgid is the process id.

> +
> +       ret = bpf_find_vma(task, addr, check_vma, NULL, 0);
> +       return 0;
> +}
<...>
> --
> 2.38.1
>
