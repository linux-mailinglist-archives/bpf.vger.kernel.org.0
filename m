Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D815AF8D0
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 02:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiIGAGS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Sep 2022 20:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiIGAGR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Sep 2022 20:06:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5CC870B3
        for <bpf@vger.kernel.org>; Tue,  6 Sep 2022 17:06:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7ACB6B81AD5
        for <bpf@vger.kernel.org>; Wed,  7 Sep 2022 00:06:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30CD4C43140
        for <bpf@vger.kernel.org>; Wed,  7 Sep 2022 00:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662509174;
        bh=lksmMkeJtUtJ4ZoAjx+rumXJPiKVk+nmPXS5geVhNWc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=scOH92eFXAgEByhimfQI7IX7/t6BI07jkcgryXscNnJ4NppRHP4AJUL5CMCNLemq+
         hzLfTwcoNAO5SFpUsEj33O61W5ge88YfCotAzzA7+qKXRCVZxoY2sbx68JCcZ2TjSg
         XYYw6ZpyQRwNTCC/HKgVdZ/2IrRYsFfmWozhXVuZ41U08JP5EN6r4d1tgkfkHl0OOX
         haK5yP/VHqxqM86rlAK9JjxkyphY5XmNweMU18ucpl1O0JMFXxTxaHl+yBOrRBIFc/
         AyAlRhHMLjO52HOuQlekg0ImVMkRO1rYAktlh9+boLehwQAR+DFjYOd7D9gp0fXDHj
         TfY2L5+sg5KIQ==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-127ba06d03fso8626327fac.3
        for <bpf@vger.kernel.org>; Tue, 06 Sep 2022 17:06:14 -0700 (PDT)
X-Gm-Message-State: ACgBeo3WyC8qkcQV1IVuO9vdxblek3hjIGjd+BboUR6HzNRgyEvqBLvo
        vfa8enryFVqh0LRgZ5SolrzbL/fl2u3SZm7GHgU=
X-Google-Smtp-Source: AA6agR5/0wfyU8QJDv3F6Kk2elxsgf6K/zbluayxZFHYZ+2QoeloS8Q2uvfVqiz2vKNt1xJhbbrvuz2mznp7Pm6Q8Uc=
X-Received: by 2002:a05:6808:195:b0:342:ed58:52b5 with SMTP id
 w21-20020a056808019500b00342ed5852b5mr437689oic.22.1662509173262; Tue, 06 Sep
 2022 17:06:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220906133613.54928-1-quentin@isovalent.com> <20220906133613.54928-7-quentin@isovalent.com>
In-Reply-To: <20220906133613.54928-7-quentin@isovalent.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 6 Sep 2022 17:06:02 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6iH0qFfJFxcWfGAnsD1FqOM_ThZLp5H+MARvkBxq8K7w@mail.gmail.com>
Message-ID: <CAPhsuW6iH0qFfJFxcWfGAnsD1FqOM_ThZLp5H+MARvkBxq8K7w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 6/7] bpftool: Add LLVM as default library for
 disassembling JIT-ed programs
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@corigine.com>,
        Simon Horman <simon.horman@corigine.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 6, 2022 at 6:46 AM Quentin Monnet <quentin@isovalent.com> wrote:
>
[...]
> +
> +static int
> +init_context(disasm_ctx_t *ctx, const char *arch,
> +            __maybe_unused const char *disassembler_options,
> +            __maybe_unused unsigned char *image, __maybe_unused ssize_t len)
> +{
> +       char *triple;
> +
> +       if (arch) {
> +               p_err("Architecture %s not supported", arch);
> +               return -1;
> +       }

Does this mean we stop supporting arch by default (prefer llvm
over bfd)?

Thanks,
Song
