Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9061165375F
	for <lists+bpf@lfdr.de>; Wed, 21 Dec 2022 21:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbiLUUK0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Dec 2022 15:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiLUUKV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Dec 2022 15:10:21 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8641C26AD0
        for <bpf@vger.kernel.org>; Wed, 21 Dec 2022 12:10:20 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id b2so3938061pld.7
        for <bpf@vger.kernel.org>; Wed, 21 Dec 2022 12:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MRo9Es4TETaumZ0Gxh+CRtCG1EOUJSXBFePVu0YqELs=;
        b=Gdp/X9ZO8QsRjK2/43/LcFJUwmY+g/lSRUEsJVySFafLQDUptRrB4Xy2ykTmmcJiTz
         +1sKFk/UGU0Ch5nn2zZ+BAav12RGnOcgMNNt8K73TkM2ywbkF/dAw8AbqCLsDj65omTo
         YL/WuNKJ2qTSq9ECNo5hso0vVqjn1H+4QUSZBAgWtKV3ZIuQ03SzKPLFNCPg4QhxKkKl
         yFcmJDe0+JIa79wfcZXOXVom/WbeZFzSFVyNjxBu1+oj9WCiu/eAvMHaMU2Sgfcm5sDi
         iNb8FFFxhp+1Kv0DRnJu47oxG+bCHvFH7EzOZnUSeDl4nt31gOt2tjX9fxpirasQhg+W
         bedg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MRo9Es4TETaumZ0Gxh+CRtCG1EOUJSXBFePVu0YqELs=;
        b=PCsyMwsfqT81afukAfLGV8db0tE8G+PzaOA+IeGjWJayC71FndfE5iNlYbjM6Az8jc
         WZeK6FOwfxfOQxKCCYyIgYD13q3qtHMqX+I9BzSITKhtCU4d4g+qxc0TAWERi0p3P06d
         of5Kp4BC4QPTypL0CNIFIF1Iy7FmVtBB+9AyfKLsFOYzdwb2X5mdUz0JGKH84U5/I4dE
         vqhxfEuioNvW0UmSkRzop71+g3469qzezLWYNodmSOGk3II1A95MbwMtauu3D51/jBBO
         /FTkkPm83dt06Q2TqfKLCg36Z6UftL9Sumjt4oM9GTkGupWNhKHkGSNXYu/I8H3gv2rw
         yOSg==
X-Gm-Message-State: AFqh2koatRVvSN2DjKhxcitHe94u5LvDRSvl7rT1luvLhAGpg5Bhh6X5
        0VnVzy2M+xXEo4n3/qlyg7ZFMcdJY+hETOthHshtVA==
X-Google-Smtp-Source: AMrXdXtSL2991sZl7FGLuAbG6D0mSxAHu9HjVO6nlaX2DvQw3r/xb2+aTruwlTYuMd0rb3bMrWxUQuviChgfgDLTJoY=
X-Received: by 2002:a17:902:a506:b0:189:97e2:ab8b with SMTP id
 s6-20020a170902a50600b0018997e2ab8bmr301811plq.131.1671653419884; Wed, 21 Dec
 2022 12:10:19 -0800 (PST)
MIME-Version: 1.0
References: <20221221-bpf-syscall-v1-0-9550f5f2c3fc@chromium.org>
In-Reply-To: <20221221-bpf-syscall-v1-0-9550f5f2c3fc@chromium.org>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 21 Dec 2022 12:10:08 -0800
Message-ID: <CAKH8qBuLhZ+T9fvP=DXeYevdrNofTPpEiQqq2RenBUKVghPmtA@mail.gmail.com>
Subject: Re: [PATCH] bpf: Remove unused field initialization
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Hao Luo <haoluo@google.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Song Liu <song@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Wed, Dec 21, 2022 at 11:55 AM Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Maxlen is used by standard proc_handlers such as proc_dointvec(), but in this
> case we have our own proc_handler. Remove the initialization.

Are you sure?

bpf_stats_handler
  proc_dointvec_minmax
    do_proc_dointvec
      __do_proc_dointvec
        vleft = table->maxlen / sizeof(*i);

Maybe we should really do the following instead?

.maxlen: sizeof(int)

?

> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
> bpf: Trivial remove of unitialised field.
>
> I have inspired myself in your code and heritaded this bug :). Fixing this
> here so none else makes the same mistake.
>
> To: Alexei Starovoitov <ast@kernel.org>
> To: Daniel Borkmann <daniel@iogearbox.net>
> To: John Fastabend <john.fastabend@gmail.com>
> To: Andrii Nakryiko <andrii@kernel.org>
> To: Martin KaFai Lau <martin.lau@linux.dev>
> To: Song Liu <song@kernel.org>
> To: Yonghong Song <yhs@fb.com>
> To: KP Singh <kpsingh@kernel.org>
> To: Stanislav Fomichev <sdf@google.com>
> To: Hao Luo <haoluo@google.com>
> To: Jiri Olsa <jolsa@kernel.org>
> Cc: bpf@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  kernel/bpf/syscall.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 35972afb6850..8e55456bd648 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -5319,7 +5319,6 @@ static struct ctl_table bpf_syscall_table[] = {
>         {
>                 .procname       = "bpf_stats_enabled",
>                 .data           = &bpf_stats_enabled_key.key,
> -               .maxlen         = sizeof(bpf_stats_enabled_key),
>                 .mode           = 0644,
>                 .proc_handler   = bpf_stats_handler,
>         },
>
> ---
> base-commit: b6bb9676f2165d518b35ba3bea5f1fcfc0d969bf
> change-id: 20221221-bpf-syscall-58d1ac3f817a
>
> Best regards,
> --
> Ricardo Ribalda <ribalda@chromium.org>
