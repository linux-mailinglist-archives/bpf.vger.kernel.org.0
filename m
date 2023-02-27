Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B720C6A4D9A
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 22:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjB0V4w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 16:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjB0V4v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 16:56:51 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2941BAD6;
        Mon, 27 Feb 2023 13:56:49 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id o12so31735861edb.9;
        Mon, 27 Feb 2023 13:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJALrH0qvCqbMwEFbG536Yy3GrjpY9F4GFFyhao32n8=;
        b=nPFELedxEitXSFxuF4a3UkqtLoOjSOIVIgWZ/dCYdEYPLSMHQFeyDYuL+h/r4azznz
         ITn84wc72qoEndruOZ8mZiRYzNZt+tKp39vYrJPcG3tE4zSNOM/0RPItGoOb3DIQ9aaA
         f2w18NOTYEZZ7ZuKpdY/4DR7iW8Ys/KjJadkKhxV50FOatrka47cOORC7dC54AiR7tky
         3LteRiIPjhenKLAKpBaQz/3KBqJmTQaeyZ9QPmPyCzAQRLdv9MOjh1xsaY0YPLxtY34A
         Ehypbux2YRMgD1S60xrn5X/r+0pFtwQlvjaBH1NDkb1pe8IWHePJkMz3OKtIlBchZ2pV
         5rRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJALrH0qvCqbMwEFbG536Yy3GrjpY9F4GFFyhao32n8=;
        b=vgeu8DkmultOwM14SjT4Hqxw+talz8h0GxbZNlCFucaDK+0JDwIz+m45mOZo8w1wSC
         JQdvzY9g9hsjmKeT/Pl55B4wGVku+JCHswPFVooJ1mn90VaxfLFKHZFD1MAmpllvlUo2
         Na+WxHATt2NLcCPthJN2S0pbATcwarbd4BdvOUJhhkqcJ6yenqKDE7undtIstV/TZkFh
         TNyIm/hMf0/D9dqQ0enFJwDqMyYRRaWC2vLMQgXmfXlBebpdB1FLZ1qphkW/HZL1lDMx
         xMrfELjGdlvHv/g0hGaAsuAmIbp2KYhiqLtWtLXQol6pkK2WOwlUFueunmm/X0j1XLQz
         2KrQ==
X-Gm-Message-State: AO0yUKU2I7ZxqGiLp1+j/EbZTXJERclE1pBr5JRbIXFJww0w+C6EPi2o
        CmvIcoMuW5YFT4QrdLh5pDQD7/0gjUXAQHxHZAw=
X-Google-Smtp-Source: AK7set9vPaieqm/YVuLrmmuuisW9bSf3ajBs//EY1m+zsqCmqDIx3KKNSfZM1/VhP+AiPRX5ehbXvm5GMz/y+6Jte1g=
X-Received: by 2002:a05:6402:2811:b0:4ac:ce81:9c1d with SMTP id
 h17-20020a056402281100b004acce819c1dmr833018ede.0.1677535007907; Mon, 27 Feb
 2023 13:56:47 -0800 (PST)
MIME-Version: 1.0
References: <20230221025347.389047-1-imagedong@tencent.com> <20230221025347.389047-4-imagedong@tencent.com>
In-Reply-To: <20230221025347.389047-4-imagedong@tencent.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 27 Feb 2023 13:56:35 -0800
Message-ID: <CAEf4BzbJoXsXRa_Rk+jOr+z6Q02FS2Jyp3wiJHGETrSGGE5DLg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/3] selftests/bpf: add test for legacy/perf
 kprobe/uprobe attach mode
To:     menglong8.dong@gmail.com
Cc:     alan.maguire@oracle.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        benbjiang@tencent.com, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 20, 2023 at 6:54=E2=80=AFPM <menglong8.dong@gmail.com> wrote:
>
> From: Menglong Dong <imagedong@tencent.com>
>
> Add the testing for kprobe/uprobe attaching in default, legacy, perf and
> link mode. And the testing passed:
>
> ./test_progs -t attach_probe
> $5/1     attach_probe/manual-default:OK
> $5/2     attach_probe/manual-legacy:OK
> $5/3     attach_probe/manual-perf:OK
> $5/4     attach_probe/manual-link:OK
> $5/5     attach_probe/auto:OK
> $5/6     attach_probe/kprobe-sleepable:OK
> $5/7     attach_probe/uprobe-lib:OK
> $5/8     attach_probe/uprobe-sleepable:OK
> $5/9     attach_probe/uprobe-ref_ctr:OK
> $5       attach_probe:OK
> Summary: 1/9 PASSED, 0 SKIPPED, 0 FAILED
>
> Reviewed-by: Biao Jiang <benbjiang@tencent.com>
> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  .../selftests/bpf/prog_tests/attach_probe.c   | 54 ++++++++++++++-----
>  .../selftests/bpf/progs/test_attach_probe.c   | 32 -----------
>  .../bpf/progs/test_attach_probe_manual.c      | 53 ++++++++++++++++++
>  3 files changed, 93 insertions(+), 46 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/test_attach_probe_m=
anual.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tool=
s/testing/selftests/bpf/prog_tests/attach_probe.c
> index 8afd3e6066b8..e71cb44bf2e7 100644
> --- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> +++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <test_progs.h>
>  #include "test_attach_kprobe_sleepable.skel.h"
> +#include "test_attach_probe_manual.skel.h"
>  #include "test_attach_probe.skel.h"
>
>  /* this is how USDT semaphore is actually defined, except volatile modif=
ier */
> @@ -33,33 +34,48 @@ static noinline void trigger_func4(void)
>  static char test_data[] =3D "test_data";
>
>  /* manual attach kprobe/kretprobe/uprobe/uretprobe testings */
> -static void test_attach_probe_manual(struct test_attach_probe *skel)
> +static void test_attach_probe_manual(enum probe_attach_mode attach_mode)
>  {
>         DECLARE_LIBBPF_OPTS(bpf_uprobe_opts, uprobe_opts);
> +       DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, kprobe_opts);
>         struct bpf_link *kprobe_link, *kretprobe_link;
>         struct bpf_link *uprobe_link, *uretprobe_link;
> +       struct test_attach_probe_manual *skel;
>         ssize_t uprobe_offset;
>
> +       skel =3D test_attach_probe_manual__open();
> +       if (!ASSERT_OK_PTR(skel, "skel_kprobe_manual_open"))
> +               return;
> +
> +       if (!ASSERT_OK(test_attach_probe_manual__load(skel), "skel_manual=
_load"))
> +               goto cleanup;

use test_attach_probe_manual__open_and_load() ?

> +       if (!ASSERT_OK_PTR(skel->bss, "manual_check_bss"))
> +               goto cleanup;
> +

no need to test this, lots of other tests validate this already, BPF
skeleton has been validated many times over, no need to add this in
new tests

>         uprobe_offset =3D get_uprobe_offset(&trigger_func);
>         if (!ASSERT_GE(uprobe_offset, 0, "uprobe_offset"))
> -               return;
> +               goto cleanup;

didn't you update all the `goto cleanup;` into `return;` in previous
patch, and now updating it back to `goto cleanup;`? Maybe just keep an
empty `cleanup:` label at the end to reduce churn?

>
>         /* manual-attach kprobe/kretprobe */
> -       kprobe_link =3D bpf_program__attach_kprobe(skel->progs.handle_kpr=
obe,
> -                                                false /* retprobe */,
> -                                                SYS_NANOSLEEP_KPROBE_NAM=
E);
> +       kprobe_opts.attach_mode =3D attach_mode;
> +       kprobe_opts.retprobe =3D false;
> +       kprobe_link =3D bpf_program__attach_kprobe_opts(skel->progs.handl=
e_kprobe,
> +                                                     SYS_NANOSLEEP_KPROB=
E_NAME,
> +                                                     &kprobe_opts);
>         if (!ASSERT_OK_PTR(kprobe_link, "attach_kprobe"))
> -               return;
> +               goto cleanup;
>         skel->links.handle_kprobe =3D kprobe_link;
>
> -       kretprobe_link =3D bpf_program__attach_kprobe(skel->progs.handle_=
kretprobe,
> -                                                   true /* retprobe */,
> -                                                   SYS_NANOSLEEP_KPROBE_=
NAME);
> +       kprobe_opts.retprobe =3D true;
> +       kretprobe_link =3D bpf_program__attach_kprobe_opts(skel->progs.ha=
ndle_kretprobe,
> +                                                        SYS_NANOSLEEP_KP=
ROBE_NAME,
> +                                                        &kprobe_opts);
>         if (!ASSERT_OK_PTR(kretprobe_link, "attach_kretprobe"))
> -               return;
> +               goto cleanup;
>         skel->links.handle_kretprobe =3D kretprobe_link;
>
>         /* manual-attach uprobe/uretprobe */
> +       uprobe_opts.attach_mode =3D attach_mode;
>         uprobe_opts.ref_ctr_offset =3D 0;
>         uprobe_opts.retprobe =3D false;
>         uprobe_link =3D bpf_program__attach_uprobe_opts(skel->progs.handl=
e_uprobe,

[...]
