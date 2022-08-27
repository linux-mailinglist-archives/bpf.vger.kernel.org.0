Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424F65A3A83
	for <lists+bpf@lfdr.de>; Sun, 28 Aug 2022 01:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiH0Xxq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 27 Aug 2022 19:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiH0Xxq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 27 Aug 2022 19:53:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1398652DF6
        for <bpf@vger.kernel.org>; Sat, 27 Aug 2022 16:53:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA559B80A3B
        for <bpf@vger.kernel.org>; Sat, 27 Aug 2022 23:53:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5935FC43470
        for <bpf@vger.kernel.org>; Sat, 27 Aug 2022 23:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661644422;
        bh=5qp97GO5qlOdBufR9H4wBkHKi8Dt3N6eLgoz9k8gINY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X9HH8M67LzKybdafH886JIcNGQo/Y6Kijaya/F9SHEY/aM7NpT5ClkSVZRlTloDkW
         CwD9SU7AW5Lhnz9YRG8S6gdi31EZ2vzG3Oo77inPV/6WCPH9H99Kh7RNEKvZJCxxrk
         mUKYddHEUcZHXZFoEXtiKXP+OFXWSn28moMwDZtH725/AR1bQHTh8CdpYvyyX9d/4X
         KWAQtqRNCS6YcnWM6LK6DQ02Fa/dFUdxGqWnPD9eAWaR16slAY2zOoKmurHJn/mSWe
         /aYpgeApyT3hkClhMINHTb/Xsql2Lbs2ZTwsQ/Nks2OX3zfY1uAAW+1FQVNgEmqk4p
         UaPb04oD9k5/g==
Received: by mail-qt1-f176.google.com with SMTP id c20so3843092qtw.8
        for <bpf@vger.kernel.org>; Sat, 27 Aug 2022 16:53:42 -0700 (PDT)
X-Gm-Message-State: ACgBeo09Rep36SPWrIWn6ovcrc0qNPLPY2bdj71aPdtRZHQEGdx799jf
        isiDx4yai6myEWg2LAqSoIEEzVR+yRMuLEO4GyOyFQ==
X-Google-Smtp-Source: AA6agR6cgFvySzVE2onx7MtrybWD5YCIpVqv3QDF5n0WcLN5Kb4xZKXBihqjowW4dGble9qLI+C+osHIKECG2bxs3uI=
X-Received: by 2002:a05:622a:5a07:b0:343:4e03:d5a with SMTP id
 fy7-20020a05622a5a0700b003434e030d5amr5017657qtb.357.1661644421322; Sat, 27
 Aug 2022 16:53:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220826231531.1031943-1-andrii@kernel.org> <20220826231531.1031943-4-andrii@kernel.org>
In-Reply-To: <20220826231531.1031943-4-andrii@kernel.org>
From:   KP Singh <kpsingh@kernel.org>
Date:   Sun, 28 Aug 2022 01:53:30 +0200
X-Gmail-Original-Message-ID: <CACYkzJ7dNQe58g58qUBQJ3kP86o-vvLoFw+e9_hgH-Ltb9ZAHQ@mail.gmail.com>
Message-ID: <CACYkzJ7dNQe58g58qUBQJ3kP86o-vvLoFw+e9_hgH-Ltb9ZAHQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: add veristat tool for
 mass-verifying BPF object files
To:     Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
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

On Sat, Aug 27, 2022 at 1:15 AM Andrii Nakryiko <andrii@kernel.org> wrote:
>
> Add a small tool, veristat, that allows mass-verification of
> a set of *libbpf-compatible* BPF ELF object files. For each such object
> file, veristat will attempt to verify each BPF program *individually*.
> Regardless of success or failure, it parses BPF verifier stats and
> outputs them in human-readable table format. In the future we can also
> add CSV and JSON output for more scriptable post-processing, if necessary.
>
> veristat allows to specify a set of stats that should be output and
> ordering between multiple objects and files (e.g., so that one can
> easily order by total instructions processed, instead of default file
> name, prog name, verdict, total instructions order).
>
> This tool should be useful for validating various BPF verifier changes
> or even validating different kernel versions for regressions.

Cool stuff!

I think this would be useful for cases beyond these (i.e. for users to get
stats about the verifier in general) and it's worth thinking if this should
be built into bpftool?

>
> Here's an example for some of the heaviest selftests/bpf BPF object
> files:
>
>   $ sudo ./veristat -s insns,file,prog {pyperf,loop,test_verif_scale,strobemeta,test_cls_redirect,profiler}*.linked3.o
>   File                                  Program                               Verdict  Duration, us  Total insns  Total states  Peak states
>   ------------------------------------  ------------------------------------  -------  ------------  -----------  ------------  -----------
>   loop3.linked3.o                       while_true                            failure        350990      1000001          9663         9663

[...]

> --
> 2.30.2
>
