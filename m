Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADD95F1675
	for <lists+bpf@lfdr.de>; Sat,  1 Oct 2022 01:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiI3XEO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Sep 2022 19:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiI3XEN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Sep 2022 19:04:13 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7305618F903
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 16:04:12 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id lc7so11948398ejb.0
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 16:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=I94V6y70CS7ZknUGMMDHDBN3y6MtPtr35AYAJcFsNHo=;
        b=oxvOwPpeaViTeoVjkTaDLr2szteUmPpCLS/aojGJzMzVDZuIsrch72+XVXA5NE9M2G
         KUcEz/C9hPR8JSVJxeR88RAxbkUuJ5g9tTp/tr6FODUoi9aLJ0s0w8R8ZkLqMiro8UAp
         kX9gj9qopKVYLWBRBvkrUndDQ7fGIVkj4ahpf66eD7wZPtAJfrh9dtphfIgxNsA40D89
         djyqFLPz5WkomxnEWsnESGHdkRBOmHle5flcIj0WaSMSkGgO+N+8wmUv3p3Ytq9oLoBc
         X0XoIEqOLP56CP526tN6Z14Q0RAnGqpiYLJEnCwZKwh+EXbOVy9tGeweynVfDynOv2rP
         Vsbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I94V6y70CS7ZknUGMMDHDBN3y6MtPtr35AYAJcFsNHo=;
        b=oFvdQCVATNxvWGj6igjsNo06SUj3Ghggee7Otelc9ka0m8tD3nDRujujtlLEio4/yw
         ujzLh0yZlMgmoIGCv7nlAkQE+ijtzftp/DMM4P/cYj1QxqEqTlWBNiKRFuU8bD7NeWZl
         Go8j55sd/zLk+xzRFEYIcNTxP4w+v3KOyjiYAp6wCocrDEkmWqIK6FElgPm27gP5JCHS
         FFgGZ1rZfl1mn8Xk63aJEYHi1xFAaH/bUfQuMGIL/ZudoT3zkWOF+ntpECkvu2n8DcH5
         NQysQYT2wCpKFARfe1zHxE/6f9DMIO5rt1X4O2Ooi++kAGn3mqykyub2hlYAbbuJF1zp
         eHPA==
X-Gm-Message-State: ACrzQf0K3WcjOVb/NDZOLFOLBY8Nt+fR//dWJxqZo15WTaPp9RG6xLoQ
        tpD6HPvyvXU75M/EYchuI0GhMgm7wsIkYpoG3t0+5ACRqvk=
X-Google-Smtp-Source: AMsMyM4mAEvIYOs6/d1rA0uZQ/EKRM6tlhV/Wx4/W3+QHfuv2ZeL4SlsbqEgVeBJ9qp+DP1LJfXyKBsHtlyPHYwj5Uo=
X-Received: by 2002:a17:907:3d86:b0:782:1175:153f with SMTP id
 he6-20020a1709073d8600b007821175153fmr7980570ejc.226.1664579050955; Fri, 30
 Sep 2022 16:04:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220930164918.342310-1-eddyz87@gmail.com> <20220930164918.342310-3-eddyz87@gmail.com>
In-Reply-To: <20220930164918.342310-3-eddyz87@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 30 Sep 2022 16:03:58 -0700
Message-ID: <CAEf4BzZ+HNb98cF=kTJaRUM1r9f1JmEurwQXnE=pgOFsEw53YQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: verify newline for struct
 with padding only fields
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
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

On Fri, Sep 30, 2022 at 9:50 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> Verify that `bpftool btf dump file ... format c` correctly prints
> newlines for structures that consist of anonymous-only padding fields.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  .../bpf/progs/btf_dump_test_case_padding.c       | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/btf_dump_test_case_padding.c b/tools/testing/selftests/bpf/progs/btf_dump_test_case_padding.c
> index f2661c8d2d90..08e43ee38188 100644
> --- a/tools/testing/selftests/bpf/progs/btf_dump_test_case_padding.c
> +++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_padding.c
> @@ -102,12 +102,28 @@ struct zone {
>         struct zone_padding __pad__;
>  };
>
> +/* ----- START-EXPECTED-OUTPUT ----- */
> +/*
> + *struct padding_wo_named_members {
> + *     long: 64;
> + *     long: 64;
> + *};
> + *
> + */
> +/* ------ END-EXPECTED-OUTPUT ------ */
> +
> +struct padding_wo_named_members {
> +       long: 64;
> +       long: 64;
> +} __attribute__((aligned(8)));

you don't really need aligned(8) attribute, if you drop it you can
have a single copy of the struct (just like padded_implicitly above)

> +
>  int f(struct {
>         struct padded_implicitly _1;
>         struct padded_explicitly _2;
>         struct padded_a_lot _3;
>         struct padded_cache_line _4;
>         struct zone _5;
> +       struct padding_wo_named_members _6;
>  } *_)
>  {
>         return 0;
> --
> 2.37.3
>
