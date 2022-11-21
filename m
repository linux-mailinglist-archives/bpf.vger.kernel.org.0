Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E744B63259B
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 15:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbiKUOXe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 09:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiKUOXS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 09:23:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CFD14D3D
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 06:23:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74A06B81056
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 14:23:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D69C43155
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 14:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669040594;
        bh=t75YIu+UPAu41yPDuzOhCo6W2uJLeqXvu5pM58UviwA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YzH3M4U40FihLZiXVb/AOeaQTFwQ0QZvTk8jwZ/IBI0hX4SuxomAYnUddYbJ/ziRk
         L/OvXQK2O8geJ7Ax/Kb5HbbqKfAcNCy8RBvhMuOsYpMnVlcx3tmXVbK4beiZTBcosO
         VjvGSWmfBpIqlXckGfiJfcy80F5Tb5FyAhvf61JYUuSsN9OIFsnh44FnY3+gAA0KeD
         Jgsnem/ON4kcTlruRIl35ZvtvPLH5Nb320Cc7SmPJ7bpjhvbSbQB4h2cmioq71GMDx
         oKQHrfpU6XT2Zu33L+nMuXzPmUMg5Pklq3/ClLCihySmZj8RapaEPiKFECjQMs9H9X
         /aseua7z6aTKg==
Received: by mail-lf1-f49.google.com with SMTP id d6so19049002lfs.10
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 06:23:13 -0800 (PST)
X-Gm-Message-State: ANoB5pm6KgssSingJKbPqM0gPAByNhP9Sv3wJ93xTckXZDT+LICBMqIK
        PlEW+HmkTp0VsAYyyz8EsAWo+y2q5F5qSgj0RvGcVA==
X-Google-Smtp-Source: AA0mqf6BRE+r8TLVvNfPooaiywM831JQ6tLdkl/vISK9vwNLCanj9H8Q7lCcIDVpW0Mm2pTUkQFMOUaD03Ry+yYcHJA=
X-Received: by 2002:a19:6755:0:b0:4ac:3f87:151f with SMTP id
 e21-20020a196755000000b004ac3f87151fmr6631422lfj.398.1669040591780; Mon, 21
 Nov 2022 06:23:11 -0800 (PST)
MIME-Version: 1.0
References: <CAADnVQ+BWpzqOV8dGCR=A3dR3u60CkBkqSXEQHe2kVqFzsgnHw@mail.gmail.com>
 <20221117121617.4e1529d3@gandalf.local.home> <d24cded7-87b1-89f5-fc2a-5346669f6d57@meta.com>
 <20221117174030.0170cd36@gandalf.local.home> <Y3e0KtnQrudxiZbz@FVFF77S0Q05N.cambridge.arm.com>
 <20221118114519.2711d890@gandalf.local.home> <43d5d1f5-c01d-c0db-b421-386331c2b8c1@meta.com>
 <20221118130608.5ba89bd8@gandalf.local.home> <2ab2b854-723a-5f15-8c18-0b5730d1b535@meta.com>
 <CACYkzJ613nhXViBpDuGWeEWzjfSJjbB1=KNpYtNDC6Xn7yizbw@mail.gmail.com> <Y3uIVknDWTS0bMTT@hirez.programming.kicks-ass.net>
In-Reply-To: <Y3uIVknDWTS0bMTT@hirez.programming.kicks-ass.net>
From:   KP Singh <kpsingh@kernel.org>
Date:   Mon, 21 Nov 2022 15:23:00 +0100
X-Gmail-Original-Message-ID: <CACYkzJ7S_Oz5ExCS0bjreUfDVQ_CFHZPtOOVZ2_4s1v8RFa55w@mail.gmail.com>
Message-ID: <CACYkzJ7S_Oz5ExCS0bjreUfDVQ_CFHZPtOOVZ2_4s1v8RFa55w@mail.gmail.com>
Subject: Re: [RFC 0/1] BPF tracing for arm64 using fprobe
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Chris Mason <clm@meta.com>, Steven Rostedt <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Florent Revest <revest@chromium.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Brendan Jackman <jackmanb@google.com>, markowsky@google.com,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Xu Kuohai <xukuohai@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 21, 2022 at 3:17 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Nov 21, 2022 at 02:47:10PM +0100, KP Singh wrote:
>
> > > > How do I know that a function return was modified by BPF? If I'm debugging
> >
> > You can list the BPF programs that are loaded in the kernel with
> >
> > # bpftool prog list
>
> Only when you have access to the machine; most cases it's people sending
> random splats by email.

Good point, What about having information about loaded BPF programs in the
kernel stack traces and sharing bytecode, somehow, like in crash dumps?

>
> > Also, the BPF programs show up in call stacks when you are debugging.
>
> Only when it splats inside the BPF part, not when it splats after
> because BPF changed semantics of a function.
>
>
