Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C57E5FAD4E
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 09:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiJKHSI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Oct 2022 03:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiJKHSG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Oct 2022 03:18:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06E185AA1
        for <bpf@vger.kernel.org>; Tue, 11 Oct 2022 00:17:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9EC8BB811FC
        for <bpf@vger.kernel.org>; Tue, 11 Oct 2022 07:17:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ABBFC43149
        for <bpf@vger.kernel.org>; Tue, 11 Oct 2022 07:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665472677;
        bh=ovHEAwVJhyLuZMOxv50Pu6AbElu3DYoa0jpFCJYl04Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=u5ZETWdR3KdcsRAKPpmirN9h0oQoCeXjFwyLl25k9PEBtsnokmZCFBPAiqAfBoagr
         ET+Hr7UM1oV4LvQ52zp5oaCVFGwqQENqmxFWQkPjNQCAybdyoe7GjnjuhoxK6cKi+R
         hc5LjcqtEgrf17lwRfXoiMJ/YXrDi18r8FwRsdmhhLnHf5IbZM/nWezeEQuTL2NdWm
         oBzSZQ5AfZKNyb32Jm2/8KBuO5X+uOyRHLUiQWEyw2QN0hciCvnNN9eg8ziUZFuxSB
         ETaUbQy/M9UiXpcTw/bfYwIbaEdht8wCOCQ6ejnqVcUPRq5B5yYTmJToRD7yXTTa13
         6lK1b+9spbfGA==
Received: by mail-ej1-f44.google.com with SMTP id nb11so29444212ejc.5
        for <bpf@vger.kernel.org>; Tue, 11 Oct 2022 00:17:57 -0700 (PDT)
X-Gm-Message-State: ACrzQf01l0yPLGfGoTk9gnVF+CFhvkmfVe3CPEINQvCdshsqKSwU4Jvn
        W4zqQChyXfttDoSQGWDXjelWVS6cLotjhVZffyk=
X-Google-Smtp-Source: AMsMyM6ObaWL+CLaYTD3UqVCIMO8FKx8t0ZsdSGZc4CkMcd8iVHLxzvwSrLAik+6AMMyxElACAs85lpKwFUQsvgtjGo=
X-Received: by 2002:a17:907:8a0a:b0:78d:b87d:e68a with SMTP id
 sc10-20020a1709078a0a00b0078db87de68amr6461463ejc.301.1665472675630; Tue, 11
 Oct 2022 00:17:55 -0700 (PDT)
MIME-Version: 1.0
References: <20221009215926.970164-1-jolsa@kernel.org> <20221009215926.970164-6-jolsa@kernel.org>
In-Reply-To: <20221009215926.970164-6-jolsa@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Tue, 11 Oct 2022 00:17:43 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7LfqVv+dzDMBf9aO=FRsTPFS7sH8z31GD6z2jHJ-K47Q@mail.gmail.com>
Message-ID: <CAPhsuW7LfqVv+dzDMBf9aO=FRsTPFS7sH8z31GD6z2jHJ-K47Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/8] selftests/bpf: Add load_kallsyms_refresh function
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Christoph Hellwig <hch@lst.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Martynas Pumputis <m@lambda.lt>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Oct 9, 2022 at 3:00 PM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding load_kallsyms_refresh function to re-read symbols from
> /proc/kallsyms file.
>
> This will be needed to get proper functions addresses from
> bpf_testmod.ko module, which is loaded/unloaded several times
> during the tests run, so symbols might be already old when
> we need to use them.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Song Liu <song@kernel.org>

> ---
>  tools/testing/selftests/bpf/trace_helpers.c | 20 +++++++++++++-------
>  tools/testing/selftests/bpf/trace_helpers.h |  2 ++
>  2 files changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
> index 9c4be2cdb21a..09a16a77bae4 100644
> --- a/tools/testing/selftests/bpf/trace_helpers.c
> +++ b/tools/testing/selftests/bpf/trace_helpers.c
> @@ -23,7 +23,7 @@ static int ksym_cmp(const void *p1, const void *p2)
>         return ((struct ksym *)p1)->addr - ((struct ksym *)p2)->addr;
>  }
>
> -int load_kallsyms(void)
> +int load_kallsyms_refresh(void)
>  {
>         FILE *f;
>         char func[256], buf[256];
> @@ -31,12 +31,7 @@ int load_kallsyms(void)
>         void *addr;
>         int i = 0;
>
> -       /*
> -        * This is called/used from multiplace places,
> -        * load symbols just once.
> -        */
> -       if (sym_cnt)
> -               return 0;
> +       sym_cnt = 0;
>
>         f = fopen("/proc/kallsyms", "r");
>         if (!f)
> @@ -57,6 +52,17 @@ int load_kallsyms(void)
>         return 0;
>  }
>
> +int load_kallsyms(void)
> +{
> +       /*
> +        * This is called/used from multiplace places,
> +        * load symbols just once.
> +        */
> +       if (sym_cnt)
> +               return 0;
> +       return load_kallsyms_refresh();
> +}
> +
>  struct ksym *ksym_search(long key)
>  {
>         int start = 0, end = sym_cnt;
> diff --git a/tools/testing/selftests/bpf/trace_helpers.h b/tools/testing/selftests/bpf/trace_helpers.h
> index 238a9c98cde2..53efde0e2998 100644
> --- a/tools/testing/selftests/bpf/trace_helpers.h
> +++ b/tools/testing/selftests/bpf/trace_helpers.h
> @@ -10,6 +10,8 @@ struct ksym {
>  };
>
>  int load_kallsyms(void);
> +int load_kallsyms_refresh(void);
> +
>  struct ksym *ksym_search(long key);
>  long ksym_get_addr(const char *name);
>
> --
> 2.37.3
>
