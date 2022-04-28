Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46AA513B72
	for <lists+bpf@lfdr.de>; Thu, 28 Apr 2022 20:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350692AbiD1SZq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Apr 2022 14:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350661AbiD1SZq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Apr 2022 14:25:46 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC7D58E49
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 11:22:31 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id f5so2527532ilj.13
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 11:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qrbI+ikSOG8RuqX7EPHqMC7F7u0xBiQGJBScjGgiZXs=;
        b=cdWWEPc+I3gyLYq1rSnfetT+wytzzcYndfxeBVWh49e/zoYty+IXW2g1No5+3XVApp
         +wCLWoIdBMumBLHhITsbJLoCIS0Bg1w/PN5bltq/z4DTcUKORuSVEhMz6x441LnTSHSc
         BjGvl0xK/AH3DZSDOi1nfFIpTwj742JvpGzHOd/QW8en64EuKxYQ+0djckbYss7CNQZr
         0miif3KkFZOKiYv0zTu3Q7bdZ0OFRdCKoEJTgNy9CCz4PbI01lOZI4Jg1qDL/uKbFc+R
         rSCdxf1uc/l+fGE45OMYlfra6G9Y9fneTElCxz2X5fSfhMBggMRdx6O1Ax1ZGJdofDCY
         y4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qrbI+ikSOG8RuqX7EPHqMC7F7u0xBiQGJBScjGgiZXs=;
        b=T15dygOeMrIEsw2IsM9f5uvbi0g/0uqrBOtHiL9z956Jg5BKhjZnq8JpQD4Dha5Bde
         m5KMzhVjc0uiOh8jdlvUh+XnD8uB9hXFB5AO3WbNZ7Ii9cS3wPr46T3RgYvWwPO6PBso
         gIpoh80EVALVbOEyACM2RAWomY8MAMaxu7F69xKm35Sg4z3YGNve4NQc1kJppZ3UE//1
         ahPq/tuKNs//Em2bsgzoNSNBgaP6jdT8sccJSAE55isGhIis1mms1JjLP29zsOKJbQhW
         niO4FJ2T/9E2PDh0pEVgKJcIRiC4i7zaHruwGFxtkfXSGuzdfq+hmI3/GS0p0V1Sk9FL
         Uu/A==
X-Gm-Message-State: AOAM531kFX4K77frNspcHzMbSR0nlxy6z2MsRJfBBBXESSpdCPs6hcFY
        Jf56tsmcCme+rD/P5g7dICclrqdqlXZ9wsE/5a+1JHiKPrFfEg==
X-Google-Smtp-Source: ABdhPJzArb8Ee48r9DdqORLdnhd34db3RucexFPlsu/Ka5tvVPDJD18/62Hrv8nMxUluUOrh8CqG7YTzmEJkm9EuMlo=
X-Received: by 2002:a05:6e02:1b89:b0:2cd:942d:86e3 with SMTP id
 h9-20020a056e021b8900b002cd942d86e3mr9213893ili.71.1651170150330; Thu, 28 Apr
 2022 11:22:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1651103126.git.delyank@fb.com> <9bae67335d76cfffadf9777be79c32c0f1deb897.1651103126.git.delyank@fb.com>
In-Reply-To: <9bae67335d76cfffadf9777be79c32c0f1deb897.1651103126.git.delyank@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 28 Apr 2022 11:22:19 -0700
Message-ID: <CAEf4BzZb5t5L4MuTxfm0QK0z9c_PmeBrYsj4qByZCWq0v8378A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/5] bpf: allow sleepable uprobe programs to attach
To:     Delyan Kratunov <delyank@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
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

On Thu, Apr 28, 2022 at 9:54 AM Delyan Kratunov <delyank@fb.com> wrote:
>
> uprobe and kprobe programs have the same program type, KPROBE, which is
> currently not allowed to load sleepable programs.
>
> To avoid adding a new UPROBE type, we instead allow sleepable KPROBE
> programs to load and defer the is-it-actually-a-uprobe-program check
> to attachment time, where we're already validating the corresponding
> perf_event.
>
> A corollary of this patch is that you can now load a sleepable kprobe
> program but cannot attach it.
>
> Signed-off-by: Delyan Kratunov <delyank@fb.com>
> ---
>  kernel/bpf/syscall.c  | 8 ++++++++
>  kernel/bpf/verifier.c | 4 ++--
>  2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index e9e3e49c0eb7..3ce923f489d7 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3009,6 +3009,14 @@ static int bpf_perf_link_attach(const union bpf_attr *attr, struct bpf_prog *pro
>         }
>
>         event = perf_file->private_data;
> +       if (prog->aux->sleepable) {
> +               if (!event->tp_event || (event->tp_event->flags & TRACE_EVENT_FL_UPROBE) == 0) {

so far TRACE_EVENT_FL_UPROBE was contained to within kernel/trace so
far, maybe it's better to instead expose a helper function to check if
perf_event represents uprobe?

> +                       err = -EINVAL;
> +                       bpf_link_cleanup(&link_primer);
> +                       goto out_put_file;
> +               }
> +       }
> +
>         err = perf_event_set_bpf_prog(event, prog, attr->link_create.perf_event.bpf_cookie);
>         if (err) {
>                 bpf_link_cleanup(&link_primer);
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 71827d14724a..c6258118dd75 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -14313,8 +14313,8 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
>         }
>
>         if (prog->aux->sleepable && prog->type != BPF_PROG_TYPE_TRACING &&
> -           prog->type != BPF_PROG_TYPE_LSM) {
> -               verbose(env, "Only fentry/fexit/fmod_ret and lsm programs can be sleepable\n");
> +           prog->type != BPF_PROG_TYPE_LSM && prog->type != BPF_PROG_TYPE_KPROBE) {
> +               verbose(env, "Only fentry/fexit/fmod_ret, lsm, and kprobe/uprobe programs can be sleepable\n");
>                 return -EINVAL;
>         }
>
> --
> 2.35.1
