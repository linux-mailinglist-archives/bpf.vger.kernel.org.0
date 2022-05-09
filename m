Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D295209BA
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 01:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbiEJABl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 May 2022 20:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbiEJABf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 May 2022 20:01:35 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116B12BD0EE
        for <bpf@vger.kernel.org>; Mon,  9 May 2022 16:57:38 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id s23so5438226iog.13
        for <bpf@vger.kernel.org>; Mon, 09 May 2022 16:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TTEBUUSsJliv3Aa9AZPPsVnef5IJaRTdXm4qQO5UOhQ=;
        b=br3q9Q11ykYcll9pIavl/nT9nt+shEEnU5jhZHNWdzUKmiMaH09htolAAg2IbReRQe
         ESEUh4lDS+3sEq84eJZEn/j4wwEVTYSCLT4mxuArH76sM44beSsXTcZBOCFsg7yy1KfV
         TkGFHjarTxgfvFfx+/pYAxtf1XIK69HRTnU3vRbThRvMn23ziPDIoVZx7PDdLgfGfPRK
         1cpKXJ23dJnz/zhbQpUxWRpekyNLwesEP1p5lAQX47HCQAjtyjQj0irJEYdR0rqSlJOc
         GY4XWlIHi2TvGXJgUfIkhJAaWHyL3gOZvAwaqUalYFtx4bIbkcq6ALBanLSJhb3UfSvX
         AhBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TTEBUUSsJliv3Aa9AZPPsVnef5IJaRTdXm4qQO5UOhQ=;
        b=6+ClLxv1tubZ6VJ+BJag9prNhNg8tRrm0pwqAoITnhz0MklgOPgujSyUR2KQYvUetW
         QJn/nGCFJK808XVXIfglu1ssJhcAUgE5e1pW6qy5HffUT2WekxGnyPmvuFZsU31f/K6L
         edT1Ybxt5cOYrpHlwvQGgUwXxipzUYljBIXEBhI30oRYW4oz5VWYTrgGXRQfKsnCgCyE
         ySOYclR7bprazuoC25uKfY8P92zjwf5PbbKDuizvGzLvorIn6g5f9qmzcDwsNOiMAme9
         H9ETv3xvqGWILS8LFRXBLZwtKX1aYyQBhr1hmyEwEVFu1stVfmpVEN4YX6YkSCtlZflZ
         bOXg==
X-Gm-Message-State: AOAM530ZyNa8zF123p3nzK2g979OcKc8oYvKYBvBoHrZjGrl5PAIjYbC
        RIgjNCqzFJZh6axWCah2TRC8ZTV0NpbHtDgyW3o=
X-Google-Smtp-Source: ABdhPJx4IeYgm7sU8c+x1wxCKTG36J9ddvCRmDc3owGoJ3yU4+3WhLvNQuw1Fg2C9pEQo/euglsjRPC2S6/9Rd2nflM=
X-Received: by 2002:a5d:9316:0:b0:657:a364:ceb with SMTP id
 l22-20020a5d9316000000b00657a3640cebmr7354608ion.63.1652140657492; Mon, 09
 May 2022 16:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1651532419.git.delyank@fb.com> <50290e7abc06f4aa7ea355a7aeb64f059a998c7f.1651532419.git.delyank@fb.com>
In-Reply-To: <50290e7abc06f4aa7ea355a7aeb64f059a998c7f.1651532419.git.delyank@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 9 May 2022 16:57:26 -0700
Message-ID: <CAEf4BzZj1wffF0WShEO7f85g1QrT4kjz7R7yfCKATtKMP2ghoQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 5/5] selftests/bpf: add tests for sleepable
 kprobes and uprobes
To:     Delyan Kratunov <delyank@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
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

On Mon, May 2, 2022 at 4:09 PM Delyan Kratunov <delyank@fb.com> wrote:
>
> Add tests that ensure sleepable kprobe programs cannot attach.
>
> Also attach both sleepable and non-sleepable uprobe programs to the same
> location (i.e. same bpf_prog_array).
>
> Signed-off-by: Delyan Kratunov <delyank@fb.com>
> ---
>  .../selftests/bpf/prog_tests/attach_probe.c   | 51 +++++++++++++++-
>  .../selftests/bpf/progs/test_attach_probe.c   | 58 +++++++++++++++++++
>  2 files changed, 108 insertions(+), 1 deletion(-)
>

LGTM, suggestion below is just about making flag setting less verbose,
but it's minor.

Acked-by: Andrii Nakryiko <andrii@kernel.org>


> diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> index 08c0601b3e84..cddb17ab0588 100644
> --- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> +++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> @@ -17,6 +17,14 @@ static void trigger_func2(void)
>         asm volatile ("");
>  }
>
> +/* attach point for byname sleepable uprobe */
> +static void trigger_func3(void)
> +{
> +       asm volatile ("");
> +}
> +
> +static char test_data[] = "test_data";
> +
>  void test_attach_probe(void)
>  {
>         DECLARE_LIBBPF_OPTS(bpf_uprobe_opts, uprobe_opts);
> @@ -27,6 +35,7 @@ void test_attach_probe(void)
>         struct bpf_link *uprobe_err_link;
>         bool legacy;
>         char *mem;
> +       int kprobe_s_flags;
>
>         /* Check if new-style kprobe/uprobe API is supported.
>          * Kernels that support new FD-based kprobe and uprobe BPF attachment
> @@ -49,9 +58,18 @@ void test_attach_probe(void)
>         if (!ASSERT_GE(ref_ctr_offset, 0, "ref_ctr_offset"))
>                 return;
>
> -       skel = test_attach_probe__open_and_load();
> +       skel = test_attach_probe__open();
>         if (!ASSERT_OK_PTR(skel, "skel_open"))
>                 return;
> +
> +       /* sleepable kprobe test case needs flags set before loading */
> +       kprobe_s_flags = bpf_program__flags(skel->progs.handle_kprobe_sleepable);
> +       if (!ASSERT_OK(bpf_program__set_flags(skel->progs.handle_kprobe_sleepable,
> +               kprobe_s_flags | BPF_F_SLEEPABLE), "kprobe_sleepable_flags"))
> +               goto cleanup;

This feels like unnecessary checks and fetching of the flag. We
control all this, so just doing

bpf_program__set_flag(skel->progs.handle_kprobe_sleepable, BPF_F_SLEEPABLE);

seems totally justified and reliable

> +
> +       if (!ASSERT_OK(test_attach_probe__load(skel), "skel_load"))
> +               goto cleanup;
>         if (!ASSERT_OK_PTR(skel->bss, "check_bss"))
>                 goto cleanup;
>

[...]
