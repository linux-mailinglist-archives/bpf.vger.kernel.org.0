Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1888053D3C0
	for <lists+bpf@lfdr.de>; Sat,  4 Jun 2022 01:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244659AbiFCXB2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Jun 2022 19:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240486AbiFCXB2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Jun 2022 19:01:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB01957119
        for <bpf@vger.kernel.org>; Fri,  3 Jun 2022 16:01:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 954D8B824CB
        for <bpf@vger.kernel.org>; Fri,  3 Jun 2022 23:01:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B341C34115
        for <bpf@vger.kernel.org>; Fri,  3 Jun 2022 23:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654297284;
        bh=neTs2UogVGsv7hMlLFROJzXJHiBK4N737TkIAoFMFU8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ed03jMLS5fKYhDCEiZ0XhS9BDdulCcuEb/9oAIauC3JObql/95p/njrP5Y2Bq/eH9
         UOtdxkv8+iRPyvFy1bMrwTF7J5EtFBjfXn9dUlEh/VrUH5ZApNU6G3bqYwQ3rXNGII
         tAyMifnh8/V+WyhdaVKGfnW0DliKtG7QKJ1r0SchGWMrTMUGA1lnwDaKNB0uhL09cK
         4vRoGWT1v7o9otwNUdbZRDjAg+4JD3REW3lFOa/TT7d8xXXEG0K3St4fWYy6QDNpxc
         X5GUWBW/mNr0BvPdfQQh0/Zj8bWLW0t7SqKhW1ogumZJSjMUpTkdyyrcwAb2Wky6BI
         U/49T+g763JJw==
Received: by mail-yb1-f175.google.com with SMTP id p13so16240536ybm.1
        for <bpf@vger.kernel.org>; Fri, 03 Jun 2022 16:01:24 -0700 (PDT)
X-Gm-Message-State: AOAM530PwXW51IphWuuW23QS7D9CACAyz/b/YOPkACNOVtco3WqYheXk
        hI6UU6e+8ua1wHJlERgH64jlizguN1SaADJqIm0=
X-Google-Smtp-Source: ABdhPJyP6WdLlX4hJjeymqU1fPilU3evefiDH0DIypZErHTgj+S416qqXeKgYW/GYMF3KrKpVv1C+s7jrjBYUy0qOUQ=
X-Received: by 2002:a25:7e84:0:b0:650:10e0:87bd with SMTP id
 z126-20020a257e84000000b0065010e087bdmr13312405ybc.257.1654297283306; Fri, 03
 Jun 2022 16:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220603141047.2163170-1-eddyz87@gmail.com> <20220603141047.2163170-2-eddyz87@gmail.com>
 <CAPhsuW5WrL-4qZz-NPufj7SWbWe+z4rVzc0cN3ufU2M_PnTwoQ@mail.gmail.com> <cd7821030cd2fca945592a935c2c0853dd2852a4.camel@gmail.com>
In-Reply-To: <cd7821030cd2fca945592a935c2c0853dd2852a4.camel@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 3 Jun 2022 16:01:12 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6CgZQn_-uc1i7WVXcv2kGczEPEQRHGWAM5+S6dQyp9qQ@mail.gmail.com>
Message-ID: <CAPhsuW6CgZQn_-uc1i7WVXcv2kGczEPEQRHGWAM5+S6dQyp9qQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/5] selftests/bpf: specify expected
 instructions in test_verifier tests
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 3, 2022 at 3:08 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
[...]

> >
> > for (int i = 0; ...)
>
> Sorry, just to clarify, you want me to pull all loop counter
> declarations to the top of the relevant functions, right? (Affecting 4
> functions in this patch).

Right. There are a few more in later patches.

>
> [...]
>
> > > +static int find_insn_subseq(struct bpf_insn *seq, struct bpf_insn *subseq,
> > > +       if (check_unexpected &&
> > > +           find_all_insn_subseqs(buf, test->unexpected_insns,
> > > +                                 cnt, MAX_UNEXPECTED_INSNS)) {
> >
> > I wonder whether we want different logic for unexpected_insns. With multiple
> > sub sequences, say seq-A and seq-B, it is more natural to reject any results
> > with either seq-A or seq-B. However, current logic will reject seq-A => seq-B,
> > but will accept seq-B => seq-A. Does this make sense?
>
> Have no strong opinion on this topic. In theory different variants
> might be useful in different cases.
>
> In the test cases for bpf_loop inlining I only had to match a single
> unexpected instruction, so I opted to use same match function in both
> expected and unexpected cases to keep things simple.

I think we can wait until we have an actual use case for multiple seq.
For now, let's keep current logic and document this clearly in struct
bpf_test.

Thanks,
Song
[...]
