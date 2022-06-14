Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22FAB54A8E3
	for <lists+bpf@lfdr.de>; Tue, 14 Jun 2022 07:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235605AbiFNFtR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Jun 2022 01:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238283AbiFNFtQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Jun 2022 01:49:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351A03A706
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 22:49:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C42CE61656
        for <bpf@vger.kernel.org>; Tue, 14 Jun 2022 05:49:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30589C341C4
        for <bpf@vger.kernel.org>; Tue, 14 Jun 2022 05:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655185755;
        bh=xC9nc6hjDJdmDDsUrJ8cHEdfjMjJwhmiRdJ+fCyY6CA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rdMW3F9usVGYKc6Ex3Grkmffbw80VuVfD9obidbfka66XdbbkwotA3tZETdenVy0l
         HC6be5+EkdVVhE3++AKUvAsCSmgyicqWU4MGyX/VbiX7X1YBiiRZQ4vjhn8tjiqQ3l
         NZ7fmjkFBgx6E3VPisBCZpchZlQsJwlf5RxNi8go3Qr+mRrExCo5C1dmq1ASY69lVW
         d7ilUWVFIwXPs2gqhlTWsPQw2VAPIb0AgAgIaWWnjIalDOz1y1W/yAlORdLdvyiDFm
         Xm+jLQnmeT89RsIxX9xXQiVI9GJEnU0+y4+iAqXecuZPRIqkZSMUZm5Gcg3O6HLEHy
         41QsGCn4M6rxg==
Received: by mail-yb1-f169.google.com with SMTP id h27so13445508ybj.4
        for <bpf@vger.kernel.org>; Mon, 13 Jun 2022 22:49:15 -0700 (PDT)
X-Gm-Message-State: AJIora95BXV9+KrvxpQxu93/hKUjUbF3CW8SzODeZRvRF38bHekz4Zov
        risoDUafPCAwY9Gx1XroRjDu9KkGeHtb5nm6NjQ=
X-Google-Smtp-Source: AGRyM1urESQ8XU4njteemVU+9CCulH/qLUpWL7b4IgQavh7NU+sdXH2Ra/x4RAiiyF4BxssjCa4OA8kMtWmLvm23+5Q=
X-Received: by 2002:a25:642:0:b0:664:be67:41e with SMTP id 63-20020a250642000000b00664be67041emr3099619ybg.257.1655185754132;
 Mon, 13 Jun 2022 22:49:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220613205008.212724-1-eddyz87@gmail.com> <20220613205008.212724-4-eddyz87@gmail.com>
In-Reply-To: <20220613205008.212724-4-eddyz87@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 13 Jun 2022 22:49:03 -0700
X-Gmail-Original-Message-ID: <CAPhsuW586DeN2mpPmvKQUPcw9y1t-3o24mRvdvd25XRArsQhoA@mail.gmail.com>
Message-ID: <CAPhsuW586DeN2mpPmvKQUPcw9y1t-3o24mRvdvd25XRArsQhoA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 3/5] bpf: Inline calls to bpf_loop when
 callback is known
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 13, 2022 at 1:50 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> Calls to `bpf_loop` are replaced with direct loops to avoid
> indirection. E.g. the following:
>
>   bpf_loop(10, foo, NULL, 0);
>
> Is replaced by equivalent of the following:
>
>   for (int i = 0; i < 10; ++i)
>     foo(i, NULL);
>
> This transformation could be applied when:
> - callback is known and does not change during program execution;
> - flags passed to `bpf_loop` are always zero.
>
> Inlining logic works as follows:
>
> - During execution simulation function `update_loop_inline_state`
>   tracks the following information for each `bpf_loop` call
>   instruction:
>   - is callback known and constant?
>   - are flags constant and zero?
> - Function `optimize_bpf_loop` increases stack depth for functions
>   where `bpf_loop` calls can be inlined and invokes `inline_bpf_loop`
>   to apply the inlining. The additional stack space is used to spill
>   registers R6, R7 and R8. These registers are used as loop counter,
>   loop maximal bound and callback context parameter;
>
> Measurements using `benchs/run_bench_bpf_loop.sh` inside QEMU / KVM on
> i7-4710HQ CPU show a drop in latency from 14 ns/op to 2 ns/op.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

LGTM.
Acked-by: Song Liu <songliubraving@fb.com>
