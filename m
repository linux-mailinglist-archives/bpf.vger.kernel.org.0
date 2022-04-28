Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDFA513BBD
	for <lists+bpf@lfdr.de>; Thu, 28 Apr 2022 20:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351200AbiD1So6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Apr 2022 14:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351212AbiD1So5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Apr 2022 14:44:57 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18541BC854
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 11:41:42 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id b5so2560601ile.0
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 11:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PXSvEzA/jERzo5bB4mw/DBC5ixH6ZP9IoR/dgeYCET0=;
        b=lhXiTUGmbUTd7cTrK3t0qUQnjxuyGqGIyxF77dzTZkM6GHXKN+L3acgWGuR2nvKATd
         IFBsAgOKPmpw4aM8J8iar4dHiABz/9uKib0BUqk5/3lG+cZkoEfCqZY2Q6pZeIroP0Dg
         mPkC7ZlxHHgzIuhIfYvans3YauXW8E9W+y96e8xVY4ljRJWJNXF7LV+vKpxUkiYSXD3D
         U0cZM17BrPupWJxGMes3xeWhMo5VHpxsdJ4qHod7+nWbj93oV8owKJLs5flhC9UeJx8X
         CxCm0VERusYWvGB58/zMkdtHOo/P3bzA/Ny+hfVbFgZe3ltK8Qj5qPVDjuCKPecQ9cWx
         05rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PXSvEzA/jERzo5bB4mw/DBC5ixH6ZP9IoR/dgeYCET0=;
        b=M0j4gBETM6aKj6F1d3bb9VQHB+5QHHeWmZ7I3uXTqHraoFU4LMrOoWCS+WG5W6akt9
         u06DoitQk21NVC6yR1njrWNRGKsH3Ee3OHhMi/JLNmQM+16k6Sa5mYExj6XfeLu62sYy
         Oqkezs99fwx2zLPYO6ScBaoRK7tClQyq+fjbLFJLOBq73/0IS/3hsfWUGdUcQEiwd2sw
         HmnPThr4oZbYfIioQ4Ob001JIJaqVqGvzaoXbJZuPnBbfc+VLNiTTNaJAxrXt3EA/CN+
         osn1V/V9KDIdr51ndyh59Vvkugmyv6DTkQTduxcxKwRWoytD7t0PtTWqBJpdp/fQ63sR
         wMNA==
X-Gm-Message-State: AOAM530zhoOxT+QmuCpwJFcqPYw5wJUa5jxB0aeH721fztnuy5VJwLQO
        IKvsPyyyLkVQ+WhAW+SIBnWRgvsp89IPccMENQpmvMrFFoQ=
X-Google-Smtp-Source: ABdhPJymHuWgVovPTZvqyOC1IQanbI2gvhHl/Y/Qdp1dKpmF9tFFKZsPgAm96dzEcgn0AvmePUBRaduDbp9jvRHgteY=
X-Received: by 2002:a92:c247:0:b0:2cc:1798:74fe with SMTP id
 k7-20020a92c247000000b002cc179874femr13725586ilo.239.1651171301478; Thu, 28
 Apr 2022 11:41:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1651103126.git.delyank@fb.com> <d460d5b8a184a9d431efa3a016f56389415a1fc6.1651103126.git.delyank@fb.com>
In-Reply-To: <d460d5b8a184a9d431efa3a016f56389415a1fc6.1651103126.git.delyank@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 28 Apr 2022 11:41:30 -0700
Message-ID: <CAEf4BzaYcPG47G=vpukUjbLpGxKjDAAQu+t5tUY3tUWnSf4NhA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/5] selftests/bpf: add tests for sleepable
 kprobes and uprobes
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
> Add tests that ensure sleepable kprobe programs cannot attach.
>
> Also attach both sleepable and non-sleepable uprobe programs to the same
> location (i.e. same bpf_prog_array).
>

Yep, great thinking! I left a few comments below, otherwise looks good.

> Signed-off-by: Delyan Kratunov <delyank@fb.com>
> ---
>  .../selftests/bpf/prog_tests/attach_probe.c   | 35 +++++++++++++++
>  .../selftests/bpf/progs/test_attach_probe.c   | 44 +++++++++++++++++++
>  2 files changed, 79 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> index c0c6d410751d..c5c601537eea 100644
> --- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> +++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> @@ -17,6 +17,12 @@ static void trigger_func2(void)
>         asm volatile ("");
>  }
>
> +/* attach point for byname sleepable uprobe */
> +static void trigger_func3(void)
> +{
> +       asm volatile ("");
> +}
> +
>  void test_attach_probe(void)
>  {
>         DECLARE_LIBBPF_OPTS(bpf_uprobe_opts, uprobe_opts);
> @@ -143,6 +149,28 @@ void test_attach_probe(void)
>         if (!ASSERT_OK_PTR(skel->links.handle_uretprobe_byname2, "attach_uretprobe_byname2"))
>                 goto cleanup;
>
> +       /* sleepable kprobes should not attach successfully */
> +       skel->links.handle_kprobe_sleepable = bpf_program__attach(skel->progs.handle_kprobe_sleepable);
> +       if (!ASSERT_NULL(skel->links.handle_kprobe_sleepable, "attach_kprobe_sleepable"))

we have ASSERT_ERR_PTR() which is more in line with ASSERT_OK_PTR(),
let's use that one.

With dropping SEC("kprobe.s") you'll have to do one extra step to make
sure that handle_kprobe_sleepable is actually sleepable program during
BPF verification. Please use bpf_program__set_flags() before load step
for that.

> +               goto cleanup;
> +
> +       /* test sleepable uprobe and uretprobe variants */
> +       skel->links.handle_uprobe_byname3_sleepable = bpf_program__attach(skel->progs.handle_uprobe_byname3_sleepable);
> +       if (!ASSERT_OK_PTR(skel->links.handle_uprobe_byname3_sleepable, "attach_uprobe_byname3_sleepable"))
> +               goto cleanup;
> +

[...]

> diff --git a/tools/testing/selftests/bpf/progs/test_attach_probe.c b/tools/testing/selftests/bpf/progs/test_attach_probe.c
> index af994d16bb10..265a23af74d4 100644
> --- a/tools/testing/selftests/bpf/progs/test_attach_probe.c
> +++ b/tools/testing/selftests/bpf/progs/test_attach_probe.c
> @@ -14,6 +14,10 @@ int uprobe_byname_res = 0;
>  int uretprobe_byname_res = 0;
>  int uprobe_byname2_res = 0;
>  int uretprobe_byname2_res = 0;
> +int uprobe_byname3_sleepable_res = 0;
> +int uprobe_byname3_res = 0;
> +int uretprobe_byname3_sleepable_res = 0;
> +int uretprobe_byname3_res = 0;
>
>  SEC("kprobe/sys_nanosleep")
>  int handle_kprobe(struct pt_regs *ctx)
> @@ -22,6 +26,13 @@ int handle_kprobe(struct pt_regs *ctx)
>         return 0;
>  }
>
> +SEC("kprobe.s/sys_nanosleep")

can you please leave comment here that this is supposed to fail to be
attached? It took me a bit to notice that you do negative test with
this program

> +int handle_kprobe_sleepable(struct pt_regs *ctx)
> +{
> +       kprobe_res = 2;
> +       return 0;
> +}
> +

[...]
