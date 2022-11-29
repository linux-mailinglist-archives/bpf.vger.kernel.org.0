Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C75263B6F5
	for <lists+bpf@lfdr.de>; Tue, 29 Nov 2022 02:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbiK2BQH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Nov 2022 20:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234928AbiK2BQE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Nov 2022 20:16:04 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D702E419B3
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 17:15:58 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id vp12so28953197ejc.8
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 17:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bmu40HLckJB5aRmynI/s0RADSWR/TToHnS6y5mV1BNA=;
        b=lYzjwUPKU0OcU5H0kbQFmIitEUx44FaM8R3Qy8ohF6GGU3E34oM7ORxALA5d8MaPZZ
         YnXrVV/xo5FUyqD4F1qmLWDe0ffqMlkFyROa7D/crIchZdDxdTVxeLNH6zwantBHlIx+
         XlexYVn6oTwt0lkLDpBQSCQ+u0vI02Lnt68GLuqDdPqNtjtAjaolMq1giZqQVGre28E9
         34rQ80K5KW5VJR5kEeseN7XULyGNXLubrQRkxQot0vW7DjfvKQ0HEhPlk7QPkmo8qWL2
         XbBf4f9BFEVHdwggtT005RoPG0mQvCnIFmVXF/PjV+J4cCAwXirmJyV3BoK4fcgQDYDy
         b6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bmu40HLckJB5aRmynI/s0RADSWR/TToHnS6y5mV1BNA=;
        b=jtoGgdcrrhZtzilRQp/vz+lpstcitosOSQjHvaMGhjCj9zV4dE03h7DM57l7xYKxhO
         r8ksN8Lh+PX5oODs3XkXyX9dGwcE9kF7o/z4uMDgKDFDu8XkisX3tITJh5DnyGTghpu9
         aDG9Cb8cDmX6Hz6W5vAWrx+Rb0tseQVx9nr/RscETZa3Zj09ziIMzZ1x9/I7gGg8SPQH
         9hfjZr1di+3xBxQDynWBuaTGyrqotaowdMeb27cd+9ewTswPAzzsetUZALwRPgMGpECn
         w/ei9tlS7biPyEfcHifY4WBjKFaoFc8JucrYqMgVNmHYPaXkrY1jyNMx/XL6BUGnBorl
         7nHw==
X-Gm-Message-State: ANoB5pl5OhhYaxLyff21WygQizYaxF3Le5lh810d67QZh+GvLw1T8sf2
        pIbx4AwPn3xG4wxqzJhJ4o9tHbTm17SwCCdXZXg=
X-Google-Smtp-Source: AA0mqf6NXUB5uWYqNpspxS0WvNHVgYO1ewlrzkzSKbVzfs1Zzj/heFVAXO9aczws8dqC5uv7f8piq/kI0mBegMsx3Uo=
X-Received: by 2002:a17:906:68a:b0:78d:3188:9116 with SMTP id
 u10-20020a170906068a00b0078d31889116mr46661680ejb.176.1669684557316; Mon, 28
 Nov 2022 17:15:57 -0800 (PST)
MIME-Version: 1.0
References: <20221128132915.141211-1-jolsa@kernel.org> <20221128132915.141211-3-jolsa@kernel.org>
In-Reply-To: <20221128132915.141211-3-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 28 Nov 2022 17:15:44 -0800
Message-ID: <CAEf4BzaZCUoxN_X2ALXwQeFTCwtL17R4P_B_-hUCcidfyO2xyQ@mail.gmail.com>
Subject: Re: [PATCHv4 bpf-next 2/4] bpf: Add bpf_vma_build_id_parse function
 and kfunc
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 28, 2022 at 5:29 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding bpf_vma_build_id_parse function to retrieve build id from
> passed vma object and making it available as bpf kfunc.

As a completely different way of solving this problem of retrieving
build_id for tracing needs, can we teach kernel itself to parse and
store build_id (probably gated behind Kconfig option) in struct file
(ideally)? On exec() and when mmap()'ing with executable permissions,
Linux kernel will try to fetch build_id from ELF file and if
successful store it in struct file. Given build_id can be up to 20
bytes (currently) and not each struct file points to executable, we
might want to only add a pointer field to `struct file` itself, which,
if build_id is present, will point to

struct build_id {
    char sz;
    char data[];
};

This way we don't increase `struct file` by much.

And then any BPF program would be able to easily probe_read_kernel
such build_id from vma_area_struct->vm_file->build_id?

I'm sure I'm oversimplifying, but this seems like a good solution for
all kinds of profiling BPF programs without the need to maintain all
these allowlists and adding new helpers/kfuncs?

I know Hao was looking at the problem of getting build_id, I'm curious
if something like this would work for their use cases as well?


>
> We can't use build_id_parse directly as kfunc, because we would
> not have control over the build id buffer size provided by user.
>
> Instead we are adding new bpf_vma_build_id_parse function with
> 'build_id__sz' argument that instructs verifier to check for the
> available space in build_id buffer.
>
> This way we check that there's always available memory space
> behind build_id pointer. We also check that the build_id__sz is
> at least BUILD_ID_SIZE_MAX so we can place any buildid in.
>
> The bpf_vma_build_id_parse kfunc is marked as KF_TRUSTED_ARGS,
> so it can be only called with trusted vma objects. These are
> currently provided only by find_vma callback function and
> task_vma iterator program.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/bpf.h      |  4 ++++
>  kernel/trace/bpf_trace.c | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
>

[...]
