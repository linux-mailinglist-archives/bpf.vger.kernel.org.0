Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610674C2067
	for <lists+bpf@lfdr.de>; Thu, 24 Feb 2022 01:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245166AbiBXALd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Feb 2022 19:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245164AbiBXALd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Feb 2022 19:11:33 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A665F4D1;
        Wed, 23 Feb 2022 16:11:04 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id z7so483470ilb.6;
        Wed, 23 Feb 2022 16:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ol9UlquthQunriKvzPUzEkP+k0xGTuihXIeBY0Lwb0c=;
        b=ZbbAlKNfVyVK58hbGxvH4SKkthcj2BPZwJvOA0LlQUi0+WzYsSxLEDu5B/A/dcNS4b
         xfUuEBa7qZqIVmsKP7dxJhkWMYk8R1GQOvs3wmapoqk0I8QvCb4eqhb6VVr3hTH1fJJe
         iHsxWSXRANyXCY7RtGeDJSf7BVnqVNgiSWP32gT4ARErzOEkMJefNeLTftXD4jOKTTPB
         tcaCrMVOD6dDQnzhDrQUX4tuzrrFLLa/T9I9Uj5MPBfrDVujD+NTV2BAtwDzRmFmPqpw
         vzAlh6BdyY3KZ4bEGGqTFiR2anVtVExgDtiAHkKtW9YDGcvhL7LzhrA/xArjMCRaeWfX
         p3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ol9UlquthQunriKvzPUzEkP+k0xGTuihXIeBY0Lwb0c=;
        b=yHBM1TJelV1PXDR6Kri3byrSzrxqvqOO7SospMleL+f6P+OUnCyawJYokC8Fbf7xhW
         XtvPWCjwETsZd/CiHswgAEksmNsB3dP9kPiVxj0YO8Igd5DuBXD4BnBYGUQqAPSsvzvo
         VkDEuLX516vyL9ZwgoPk2VBXMyJP2CvkXW23S9ueMNWsPIQBiORTngKwax7DasMIkzM9
         ZVdYVuwAvJOJc1zDpzNu9fiXmUB/nsZlszARRFT6HGhzP+/Kk/wIGLTzlZKSiTz4+qVN
         bjNt8Pn0KRVvE0tl3dDjceqVcDsYW8E7WBH7VuttpzgWxbwJrAMbAAqrAb8JPttHV0tH
         6l8Q==
X-Gm-Message-State: AOAM530vvz+NVpYRNf4gUARaU/c0kd/PLUYh7/xCtQaoKQyCzZTgJ/RK
        jsssbdOnOS1Si7LEqbcY0uMLCDYADZQKL4jaPOg=
X-Google-Smtp-Source: ABdhPJyYcvOQ6ZrWIVNZoHD4OvZijlUKAfnRmdgayO+GwnDTQC48gQQGpnItr42lWNRrLzwAwx7fCcXlCqs0op6SaGQ=
X-Received: by 2002:a92:c148:0:b0:2c2:615a:49e9 with SMTP id
 b8-20020a92c148000000b002c2615a49e9mr113780ilh.98.1645661463988; Wed, 23 Feb
 2022 16:11:03 -0800 (PST)
MIME-Version: 1.0
References: <20220224000531.1265030-1-haoluo@google.com>
In-Reply-To: <20220224000531.1265030-1-haoluo@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 23 Feb 2022 16:10:52 -0800
Message-ID: <CAEf4Bzb44WR2LiYchxB5JZ=Jdie6FEEi90mh=SCv07v4h4W11w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Cache the last valid build_id.
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

On Wed, Feb 23, 2022 at 4:05 PM Hao Luo <haoluo@google.com> wrote:
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

LGTM. Can you share performance numbers before and after?

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  kernel/bpf/stackmap.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 22c8ae94e4c1..38bdfcd06f55 100644
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
> @@ -150,6 +151,12 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
>         }
>
>         for (i = 0; i < trace_nr; i++) {
> +               if (range_in_vma(prev_vma, ips[i], ips[i])) {
> +                       vma = prev_vma;
> +                       memcpy(id_offs[i].build_id, prev_build_id,
> +                              BUILD_ID_SIZE_MAX);
> +                       goto build_id_valid;
> +               }
>                 vma = find_vma(current->mm, ips[i]);
>                 if (!vma || build_id_parse(vma, id_offs[i].build_id, NULL)) {
>                         /* per entry fall back to ips */
> @@ -158,9 +165,12 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
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
