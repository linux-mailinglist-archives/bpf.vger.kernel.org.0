Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8E464CEFA
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 18:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiLNRva (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Dec 2022 12:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236910AbiLNRv2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 12:51:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8252B5F88
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 09:51:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4BEF0B819D6
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 17:51:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B4C3C433D2
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 17:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671040285;
        bh=QZGTnJ5vy3oxKuR9uZJz/zB0rSB7Oeqk5s/W6CQtiKo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EI+CxTutq6jMABNXQxCpjdgYiaIFYkEHorDpilq9ONYlZycmnnB6/zNQRtUd0mLtG
         3netwpA5cU/RygmSrSOhdchidN5U1c8l86yIWwkHRsfBLSY0MpC74CWiWxvnnPYpQV
         N/sjDFCU4C6K9cYr09FKvdnNBf4bxhkR9gtCIWUGCxasNJNnZo+1F9npAKJygo5rw3
         kdzmB4mv0MziCPZDE9qTf+EgT0aZ2kUIvGeSg8yFmTgHTGzpTq9E/L4bjlv1flvzvh
         /PBv6ys3xBFFBzpxoT4OihVc+RS26kK8nBPzyBZ4i0cvDtXdIo1cWJWucS6c+HEpm+
         BgCbIdV2FePkA==
Received: by mail-lf1-f50.google.com with SMTP id z26so11719171lfu.8
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 09:51:24 -0800 (PST)
X-Gm-Message-State: ANoB5pntWC+FOSJh7PmS2IjvhmQtE68JZ0a1otrE+M+XytNSjb65nBjg
        1xOImUsUs2hV/qwbzTDC2mtSUZwHEGTExxk9ATg=
X-Google-Smtp-Source: AA0mqf4QBdr3vxc8Sk5w8XpXzCHDFaYKJbqf4DDJ/zt8nwTEK2bKo+3f/YAzlcSE5vHNR1GDP08PcR0xdLcuNgtE/mw=
X-Received: by 2002:a05:6512:34ce:b0:4b5:8f03:a2b6 with SMTP id
 w14-20020a05651234ce00b004b58f03a2b6mr5849411lfr.643.1671040283075; Wed, 14
 Dec 2022 09:51:23 -0800 (PST)
MIME-Version: 1.0
References: <20221214100424.1209771-1-jolsa@kernel.org>
In-Reply-To: <20221214100424.1209771-1-jolsa@kernel.org>
From:   Song Liu <song@kernel.org>
Date:   Wed, 14 Dec 2022 09:51:11 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5A4DmhBdVP44TZNH+uiizT4wkeey+O-_2oryD6D4rXrg@mail.gmail.com>
Message-ID: <CAPhsuW5A4DmhBdVP44TZNH+uiizT4wkeey+O-_2oryD6D4rXrg@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next] bpf: Remove trace_printk_lock
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Sun <sunhao.th@gmail.com>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 14, 2022 at 2:04 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Both bpf_trace_printk and bpf_trace_vprintk helpers use static buffer
> guarded with trace_printk_lock spin lock.
>
> The spin lock contention causes issues with bpf programs attached to
> contention_begin tracepoint [1] [2].
>
> Andrii suggested we could get rid of the contention by using trylock,
> but we could actually get rid of the spinlock completely by using
> percpu buffers the same way as for bin_args in bpf_bprintf_prepare
> function.
>
> Adding 4 per cpu buffers (1k each) which should be enough for all
> possible nesting contexts (normal, softirq, irq, nmi) or possible
> (yet unlikely) probe within the printk helpers.
>
> In very unlikely case we'd run out of the nesting levels the printk
> will be omitted.
>
> [1] https://lore.kernel.org/bpf/CACkBjsakT_yWxnSWr4r-0TpPvbKm9-OBmVUhJb7hV3hY8fdCkw@mail.gmail.com/
> [2] https://lore.kernel.org/bpf/CACkBjsaCsTovQHFfkqJKto6S4Z8d02ud1D7MPESrHa1cVNNTrw@mail.gmail.com/
>
> Reported-by: Hao Sun <sunhao.th@gmail.com>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Song Liu <song@kernel.org>
