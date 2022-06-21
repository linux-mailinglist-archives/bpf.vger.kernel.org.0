Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D3A55289E
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 02:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbiFUAgI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jun 2022 20:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbiFUAgI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jun 2022 20:36:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392D718397
        for <bpf@vger.kernel.org>; Mon, 20 Jun 2022 17:36:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB1A66156A
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 00:36:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12378C341C4
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 00:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655771762;
        bh=078G3k0mx2k2JritaykYfo/+lB+pfXNreOc/q/w7kiA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rHHCE5eaUiEKDga3fU64T1bprzB26ic7fod4Nte4ODWyrwUu10MzymcdZVnOPgKu8
         MJDlF9Fhrz3bR9k+CXbCpl9H8HZVs8lshzpyBhU1Ya6Wk2iAxOMcfLcRL+MBvAc52r
         glzzoJKrZOtTSqbiVKpDHMYKU/8kYCDYwDlhekhjIishokvsGM9FVSarYkrNNyWOJy
         2/xwMSbSOf8J47O2VJd9LEkpUq+wpxG6TZ9EEfVzt0b24qLL3LYDQs1LopkCId+p6m
         9xhGCLgC7koh+eAxvRVfg2URTfk7KUTyCKk8Az2DxLf5d68o71v5r/CbPpUPBISkKx
         VxKvRcVTDCdiQ==
Received: by mail-yb1-f169.google.com with SMTP id n144so17755499ybf.12
        for <bpf@vger.kernel.org>; Mon, 20 Jun 2022 17:36:02 -0700 (PDT)
X-Gm-Message-State: AJIora8dKdWhwf5vKbSXHMJ0Rtsi9FGbpUng6iM6WzfCyRNWboJKJCeb
        q3YBC1gaHdGiirzuMzPVK7SOnbZ3Zm9nMII9EV8=
X-Google-Smtp-Source: AGRyM1uT7TTz+IE7L6D/f2HagdIqTOylNsassJwA9z/m3OPswQq9vofsxE0S8TfUtuRRO9cKBwVSJ4MXhlVYhc8YDa4=
X-Received: by 2002:a25:8682:0:b0:669:12e1:d7e7 with SMTP id
 z2-20020a258682000000b0066912e1d7e7mr8958878ybk.9.1655771761113; Mon, 20 Jun
 2022 17:36:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220620235344.569325-1-eddyz87@gmail.com> <20220620235344.569325-4-eddyz87@gmail.com>
In-Reply-To: <20220620235344.569325-4-eddyz87@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 20 Jun 2022 17:35:50 -0700
X-Gmail-Original-Message-ID: <CAPhsuW71KmBRza2N+9T7RXUTxLbBJh-7U3taZ662TSHvy8jaEQ@mail.gmail.com>
Message-ID: <CAPhsuW71KmBRza2N+9T7RXUTxLbBJh-7U3taZ662TSHvy8jaEQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 3/5] bpf: Inline calls to bpf_loop when
 callback is known
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 20, 2022 at 4:54 PM Eduard Zingerman <eddyz87@gmail.com> wrote:
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

Acked-by: Song Liu <songliubraving@fb.com>
