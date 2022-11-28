Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE7563B18A
	for <lists+bpf@lfdr.de>; Mon, 28 Nov 2022 19:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbiK1Snx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Nov 2022 13:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbiK1Snv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Nov 2022 13:43:51 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B07D132
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 10:43:49 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id gu23so9954144ejb.10
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 10:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yBBHhpyBYLPQgMLfH/zJ3o5fSQv64gI73TYzfu4ReJ4=;
        b=DGnKqOhM1n0MtfTlZG4a/b0Sim0nnRXxLgpZ4Tr3wFn/2jG5XU0wgcZGO4Pieyiuun
         hRxTRlGZH1RHjRM+Qv1YkrvKR1R/lqfNMqOGlJXBwthbYeLbEfbhG9LsnUqLrNNKbj8n
         taY5gxiKznBQUYlPpkAU0A9JAIdUhcEyq0s5b3PY8C1ahjDq0LXMVtK758axiZGGXsaJ
         TPvxVgjmzMZvjvSMDhcBX2wBdY9uQcwv9Dk+To0fmLPnlxwZ79jMy0XHGhMDZNSm4A/2
         zW47Lj2OCaSZ8lm91Yp3byyCM4JAS0ENryE8JX2yeznKIy4/vLBi87WYeBlq1H5mKr3n
         zTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yBBHhpyBYLPQgMLfH/zJ3o5fSQv64gI73TYzfu4ReJ4=;
        b=JtU1p1bMv+1/ieF4rUMqICIHj7VauZP7zh/XCF59WxQENHPF+jZ8d1AOROGmwgpsV4
         raC4LFU7siwvOKSPpIRPT89B3CEeBsy3pzBx/YeIdWFlmEHNjYSwMqf93mOKgmdYLw25
         1d25lvDpXSx49P/7b3BJkFuPV46oqAr/O4bxCKL6pa9WXstqhTHEIE70mcmOtMKPns06
         ffqS0Y1gx2tDAtT9molsu3Uu6BcgI8tOcALIbEQAvHNMwPYHHXgJCdunkBmUShBHI3f4
         wwE32677p5STH23g9jZVBrGO1QFSr1M3hpY0H3gWHew0Hjq5uZGwTxwfgu5Zp0TFhSYB
         lrjQ==
X-Gm-Message-State: ANoB5pmMmyfrFI8zX68UD/Hy7FNmalkg9QpR2QiydT5yEZN63jai+I4y
        ubGArdRgXK+MStioHwkhW0pKiEGEVXnre/PHBEA=
X-Google-Smtp-Source: AA0mqf7PQzDw8IX+G/5DYyX4W1cNWq30IogGZylA1itHuoe8alfaInQhjfiAe7zg+avXacMcsZUfR2TEsyQ7dq+0pWk=
X-Received: by 2002:a17:906:4ed9:b0:7ae:664a:a7d2 with SMTP id
 i25-20020a1709064ed900b007ae664aa7d2mr45564319ejv.676.1669661027819; Mon, 28
 Nov 2022 10:43:47 -0800 (PST)
MIME-Version: 1.0
References: <20221128132915.141211-1-jolsa@kernel.org> <20221128132915.141211-2-jolsa@kernel.org>
In-Reply-To: <20221128132915.141211-2-jolsa@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 28 Nov 2022 10:43:36 -0800
Message-ID: <CAADnVQKED=Ue_s88Ru25s1UQ+xe2eWXTq_02v_h=qiuxXTck=g@mail.gmail.com>
Subject: Re: [PATCHv4 bpf-next 1/4] bpf: Mark vma objects as trusted for
 task_vma iter and find_vma callback
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
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
> Marking following vma objects as trusted so they can be used
> as arguments for kfunc function added in following changes:
>
>   - vma object argument in find_vma callback function
>   - vma object in context of task_vma iterator program
>
> Both places lock vma object so it can't go away while running
> the bpf program.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/bpf/task_iter.c | 2 +-
>  kernel/bpf/verifier.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index c2a2182ce570..cd67b3cadd91 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -755,7 +755,7 @@ static struct bpf_iter_reg task_vma_reg_info = {
>                 { offsetof(struct bpf_iter__task_vma, task),
>                   PTR_TO_BTF_ID_OR_NULL },
>                 { offsetof(struct bpf_iter__task_vma, vma),
> -                 PTR_TO_BTF_ID_OR_NULL },
> +                 PTR_TO_BTF_ID_OR_NULL | PTR_TRUSTED },

Yonghong, Song,

Do you remember when task or vma is NULL here?
Maybe we can do: if (!task || !vma) skip prog run
in __task_vma_seq_show()
and make both pointers as PTR_TO_BTF_ID | PTR_TRUSTED?
