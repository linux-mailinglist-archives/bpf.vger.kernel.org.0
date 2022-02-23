Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33A74C1F22
	for <lists+bpf@lfdr.de>; Wed, 23 Feb 2022 23:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbiBWWxC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Feb 2022 17:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244696AbiBWWwz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Feb 2022 17:52:55 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FED554BD;
        Wed, 23 Feb 2022 14:52:26 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id m185so633294iof.10;
        Wed, 23 Feb 2022 14:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2o+ZPlf2KURamdvg+hitpuro1zwcVnovw9N7uB+kYcU=;
        b=GNwrG9LNEfQa403fZ4H3zN/Oe8rCNfslVnKm+cOCLCMtObn+ci8qq8RbbAvRoYaAvZ
         EIWFI6XhbGaAxxnEru5zLypjGGTUbbm03h1RRVoAo6GvUE/TvbuENVVzQKh93ra/ofHI
         5sgOu1ynKF+rcdCX5tDxm/+D+fpERl7OJ1bYhVwH0LbTfCZZ5jbx1yY0AUtwkLHmwZre
         Wp7bhC3ZiI4z6KKWpcVU/qalR9M49nlwn0HNh96NQZ2fGtRVwbLGkUzZ+dS23iUWzPdv
         U6EOtI+MI0Qy3OeA+mx2nHMdC4ARdT08YDMwyjXfi12Q+9iixQgSzYzGukUcwA06urhi
         nUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2o+ZPlf2KURamdvg+hitpuro1zwcVnovw9N7uB+kYcU=;
        b=gO9x1BEZvCbI8if3yyfWS3+FFqe77LkZqnIVg1HX2izTE19+rK826gG2MH8UmOi+zr
         aZMMou7tWzV+OohyDDh7L8OwTCCCmNRktkAKv9P5RTv7SU1wj3Q/DIZOe+5DoUhPCwT2
         fgHnQFStJIubbV/0AqIgoBLNN1U+XbrU5S3NVLOsoY6ZAX0NZTlM9KipKbUpvzY6Z7vr
         4pCkjvIorZ2a5zE25sY00cu/xZJwCah5tfpuq+iJ99G77TAIepU+r/pzGoDI+DPeoivv
         o5tqAa+GEiF3sonJ68rzs1tp4lFOeiY6ErJFFYEuCMx8L3DdmS95lJwsUDTT4ifd4Kp1
         TrTw==
X-Gm-Message-State: AOAM53262qZXyPIhcxBMs6j+5s2dPcVSexJto8diFDk4SyaZxHRfApSC
        t+VtkLCJ8kLDyQX2wqsLO9c+cWSbvPmkaSizSw4=
X-Google-Smtp-Source: ABdhPJz/urE96ebSb5oQlMiktQGGc2XApVDdg7jhdQBEK0jHnKCRIdWEFWfGWeXsiji5qbp8XkMbtB8iIlafSUgeW1o=
X-Received: by 2002:a6b:e901:0:b0:640:7bf8:f61d with SMTP id
 u1-20020a6be901000000b006407bf8f61dmr1144042iof.112.1645656746186; Wed, 23
 Feb 2022 14:52:26 -0800 (PST)
MIME-Version: 1.0
References: <20220223222002.1085114-1-haoluo@google.com>
In-Reply-To: <20220223222002.1085114-1-haoluo@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 23 Feb 2022 14:52:15 -0800
Message-ID: <CAEf4BzbjxwEukaZfW9qCLwXeyS32WeNQ_8MvUqRd-JA7cZzuGw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Cache the last valid build_id.
To:     Hao Luo <haoluo@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Blake Jones <blakejones@google.com>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Greg Thelen <gthelen@google.com>
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

On Wed, Feb 23, 2022 at 2:20 PM Hao Luo <haoluo@google.com> wrote:
>
> For binaries that are statically linked, consecutive stack frames are
> likely to be in the same VMA and therefore have the same build id.
> As an optimization for this case, we can cache the previous frame's
> VMA, if the new frame has the same VMA as the previous one, reuse the
> previous one's build id. We are holding the MM locks as reader across
> the entire loop, so we don't need to worry about VMA going away.
>
> Tested through "stacktrace_build_id" and "stacktrace_build_id_nmi" in
> test_progs.
>
> Suggested-by: Greg Thelen <gthelen@google.com>
> Signed-off-by: Hao Luo <haoluo@google.com>
> ---
>  kernel/bpf/stackmap.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 22c8ae94e4c1..280b9198af27 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -132,7 +132,8 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
>         int i;
>         struct mmap_unlock_irq_work *work = NULL;
>         bool irq_work_busy = bpf_mmap_unlock_get_irq_work(&work);
> -       struct vm_area_struct *vma;
> +       struct vm_area_struct *vma, *prev_vma = NULL;
> +       const char *prev_build_id;
>
>         /* If the irq_work is in use, fall back to report ips. Same
>          * fallback is used for kernel stack (!user) on a stackmap with
> @@ -151,6 +152,11 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
>
>         for (i = 0; i < trace_nr; i++) {
>                 vma = find_vma(current->mm, ips[i]);

as a further optimization, shouldn't we first check if ips[i] is
within prev_vma and avoid rbtree walk altogether? Would this work:

if (prev_vma && range_in_vma(prev_vma, ips[i])) {
   /* reuse build_id */
}
vma = find_vma(current->mm, ips[i]);


?

> +               if (vma && vma == prev_vma) {
> +                       memcpy(id_offs[i].build_id, prev_build_id,
> +                              BUILD_ID_SIZE_MAX);
> +                       goto build_id_valid;
> +               }
>                 if (!vma || build_id_parse(vma, id_offs[i].build_id, NULL)) {
>                         /* per entry fall back to ips */
>                         id_offs[i].status = BPF_STACK_BUILD_ID_IP;
> @@ -158,9 +164,12 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
>                         memset(id_offs[i].build_id, 0, BUILD_ID_SIZE_MAX);
>                         continue;
>                 }
> +build_id_valid:
>                 id_offs[i].offset = (vma->vm_pgoff << PAGE_SHIFT) + ips[i]
>                         - vma->vm_start;
>                 id_offs[i].status = BPF_STACK_BUILD_ID_VALID;
> +               prev_vma = vma;
> +               prev_build_id = id_offs[i].build_id;
>         }
>         bpf_mmap_unlock_mm(work, current->mm);
>  }
> --
> 2.35.1.473.g83b2b277ed-goog
>
