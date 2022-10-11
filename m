Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527235FAD74
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 09:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiJKH2B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Oct 2022 03:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiJKH2A (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Oct 2022 03:28:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A280631C9
        for <bpf@vger.kernel.org>; Tue, 11 Oct 2022 00:27:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D97B1B810B2
        for <bpf@vger.kernel.org>; Tue, 11 Oct 2022 07:27:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD29C433D6
        for <bpf@vger.kernel.org>; Tue, 11 Oct 2022 07:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665473276;
        bh=fH+Va1J4tOuAfJNkokoYNYuPO5f38dQ3kijlR8xSdQg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DPqiOaW/a34bBKGUMFj2QB9T87NLj5zxTtE2hZn/HTKdPVGcyOvBcM989QgI2bjS0
         uYdeRR6DzclH7DvS15VubhK2jXJCSyj2UkKoDRkdt9Psrt5YsalyaPxWpEOiZefVoF
         QYW0XwPbtMRu86FRvvQ+9xuPSwjNB7pEZN12UsX+FwD0LwbDq1x5Sp24rxRaKVgLJo
         ZrvqlBc8NsS0YND/lEdv6KdYObYcKoalFQEWnTRYTCgryKWHNaQN5dwN9jeeQq2jCD
         RfOOR+TKAFz3HquwC54aDvu+1uRs5KHrEwScC53MUehwKKV1/Vv8os4uj1I6yA42uz
         z0QZ5Et/eDF7g==
Received: by mail-ej1-f42.google.com with SMTP id b2so29473083eja.6
        for <bpf@vger.kernel.org>; Tue, 11 Oct 2022 00:27:56 -0700 (PDT)
X-Gm-Message-State: ACrzQf23CaTivsuLKM4xKavmIsruuMToPapRz+DTZGQQMA+Tm/BQMYvN
        sJySohuoFXW/HgPzVrfRl6JYBEWzNyNrYqCcQfg=
X-Google-Smtp-Source: AMsMyM4as1lXLGlEv8FpjPNyv40sFcUN0CLGGIvwCSWc/+mTHq5nbHUBmiPpEADf3TCmNozpoeQFnMZeiW0kRfKQMV0=
X-Received: by 2002:a17:907:8a0a:b0:78d:b87d:e68a with SMTP id
 sc10-20020a1709078a0a00b0078db87de68amr6490709ejc.301.1665473274760; Tue, 11
 Oct 2022 00:27:54 -0700 (PDT)
MIME-Version: 1.0
References: <20221009215926.970164-1-jolsa@kernel.org> <20221009215926.970164-9-jolsa@kernel.org>
In-Reply-To: <20221009215926.970164-9-jolsa@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Tue, 11 Oct 2022 00:27:42 -0700
X-Gmail-Original-Message-ID: <CAPhsuW63gieC_RqyE3LWSCLZ_HKKKJY7P1Jd2CDQq_BV-Jh_Lg@mail.gmail.com>
Message-ID: <CAPhsuW63gieC_RqyE3LWSCLZ_HKKKJY7P1Jd2CDQq_BV-Jh_Lg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 8/8] selftests/bpf: Add kprobe_multi check to
 module attach test
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

On Sun, Oct 9, 2022 at 3:01 PM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding test that makes sure the kernel module won't be removed
> if there's kprobe multi link defined on top of it.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Song Liu <song@kernel.org>

> ---
>  tools/testing/selftests/bpf/prog_tests/module_attach.c | 7 +++++++
>  tools/testing/selftests/bpf/progs/test_module_attach.c | 6 ++++++
>  2 files changed, 13 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/module_attach.c b/tools/testing/selftests/bpf/prog_tests/module_attach.c
> index 6d0e50dcf47c..7fc01ff490db 100644
> --- a/tools/testing/selftests/bpf/prog_tests/module_attach.c
> +++ b/tools/testing/selftests/bpf/prog_tests/module_attach.c
> @@ -103,6 +103,13 @@ void test_module_attach(void)
>         ASSERT_ERR(delete_module("bpf_testmod", 0), "delete_module");
>         bpf_link__destroy(link);
>
> +       link = bpf_program__attach(skel->progs.kprobe_multi);
> +       if (!ASSERT_OK_PTR(link, "attach_kprobe_multi"))
> +               goto cleanup;
> +
> +       ASSERT_ERR(delete_module("bpf_testmod", 0), "delete_module");
> +       bpf_link__destroy(link);
> +
>  cleanup:
>         test_module_attach__destroy(skel);
>  }
> diff --git a/tools/testing/selftests/bpf/progs/test_module_attach.c b/tools/testing/selftests/bpf/progs/test_module_attach.c
> index 08628afedb77..8a1b50f3a002 100644
> --- a/tools/testing/selftests/bpf/progs/test_module_attach.c
> +++ b/tools/testing/selftests/bpf/progs/test_module_attach.c
> @@ -110,4 +110,10 @@ int BPF_PROG(handle_fmod_ret,
>         return 0; /* don't override the exit code */
>  }
>
> +SEC("kprobe.multi/bpf_testmod_test_read")
> +int BPF_PROG(kprobe_multi)
> +{
> +       return 0;
> +}
> +
>  char _license[] SEC("license") = "GPL";
> --
> 2.37.3
>
