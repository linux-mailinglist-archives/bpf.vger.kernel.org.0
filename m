Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233F15697CB
	for <lists+bpf@lfdr.de>; Thu,  7 Jul 2022 04:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234748AbiGGCJh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jul 2022 22:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbiGGCJg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 22:09:36 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CFD2F012
        for <bpf@vger.kernel.org>; Wed,  6 Jul 2022 19:09:35 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id u15so5565737ejx.9
        for <bpf@vger.kernel.org>; Wed, 06 Jul 2022 19:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kGIHS1Q8whoejLOanjZ8Dl2VaVkwGN34JapXBn0P4vU=;
        b=jI2x4p7wqFu5HJhU18RIQrMJqQVMGJ2X9iUSfFfj9TgIlFMb1RVkRJm9XFc8+q33S0
         Q6bnHYhiuCYUz/r0+RNHMBBPslxZFFnlllFeYQkdoZ+dMeolRdFCfcXMv0yYHJCTku4W
         oDN1xsvTUro5Ws/jIvYGKBnLkxb+evFNAYTdQ+mH8yPnzzHIPsVMjQBkgxmH7nUcKFj/
         QfAIkFVSVGkjUuavLHu+apA5Ev/O3qt2yRv53q3LA9z01pEpt7vipRF4LwcNRsD/j7Ry
         XYtnXcg/iBFbPUS/yVW6EkyY7zd/c7DsM6OM16KX4zPaIhVbz4xze5Rm4ROuIedsf6C3
         eIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kGIHS1Q8whoejLOanjZ8Dl2VaVkwGN34JapXBn0P4vU=;
        b=SifTYULVeL4V6wxTlMzzZ5rnmQejKzaoKsIqkZwYZKq2sR04HfnGYSx2d7vdEKL1m8
         PVgISsAi/ieI8PV59bOTAr8M8BzVLLuy17+G0zSr+08weyBjHL/lrP8F+4m3UKGAuJYB
         udj1o+sstfrXTivmirjuZbKDK6j6pB5UahKVvUH0UdUtrdAq6mpie2Kxv2S//usXtKlu
         YPI0CMkpRYjtYBYe1Iantr1Qo5ymxbel98qmxOLTZAS+vQrqDZ79oyqQc0wYUatPRFm6
         rigUgu37L5f3j91NQInarl3mQ1SgBECcGkDQ1TUmC7+e9fe7LWf3uD+hju82IfoekAPT
         FSMQ==
X-Gm-Message-State: AJIora+3ic6TGDRpvliwFa65rw7iDUCr74aVvvT9cAF1voOtRdgupQVy
        ODAh4Mc8AUdvLrfTDJ7/HZlijMpyd1wFuE5/Ik0=
X-Google-Smtp-Source: AGRyM1toQrfGgxgYAAOJJEN/r72o9z8KCv/glel0a8cviUSb0Ia6uU0QHWwyPXPkcvZjNPII0bloMksUJ7EgKP6VY8U=
X-Received: by 2002:a17:907:9725:b0:726:c820:7653 with SMTP id
 jg37-20020a170907972500b00726c8207653mr43515771ejc.633.1657159774014; Wed, 06
 Jul 2022 19:09:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220706155848.4939-1-laoar.shao@gmail.com> <20220706155848.4939-2-laoar.shao@gmail.com>
 <20220707000721.dtl356trspb23ctp@google.com> <YsYn3HoqQ4JtTaO6@castle>
In-Reply-To: <YsYn3HoqQ4JtTaO6@castle>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 6 Jul 2022 19:09:22 -0700
Message-ID: <CAADnVQKxKMcXcVra-+A8UVEUmp2h8GWotbLRi65-gBfAzJ37Ew@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Make non-preallocated allocation low priority
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Hao Luo <haoluo@google.com>, bpf <bpf@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 6, 2022 at 5:25 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
>
> On Thu, Jul 07, 2022 at 12:07:21AM +0000, Shakeel Butt wrote:
> > On Wed, Jul 06, 2022 at 03:58:47PM +0000, Yafang Shao wrote:
> > > GFP_ATOMIC doesn't cooperate well with memcg pressure so far, especially
> > > if we allocate too much GFP_ATOMIC memory. For example, when we set the
> > > memcg limit to limit a non-preallocated bpf memory, the GFP_ATOMIC can
> > > easily break the memcg limit by force charge. So it is very dangerous to
> > > use GFP_ATOMIC in non-preallocated case. One way to make it safe is to
> > > remove __GFP_HIGH from GFP_ATOMIC, IOW, use (__GFP_ATOMIC |
> > > __GFP_KSWAPD_RECLAIM) instead, then it will be limited if we allocate
> > > too much memory.
> >
> > Please use GFP_NOWAIT instead of (__GFP_ATOMIC | __GFP_KSWAPD_RECLAIM).
> > There is already a plan to completely remove __GFP_ATOMIC and mm-tree
> > already have a patch for that.
>
> Oh, I didn't know this, thanks for heads up!
> I agree that GFP_NOWAIT is the best choice then.
>
> Btw, we probably shouldn't even add GFP_NOWAIT if the allocation is performed
> from the bpf syscall context. Why would we fail to pre-allocate a map if
> we can easily go into the reclaim? But probably better to leave it for
> a separate change.

The places affected by this patch are in atomic context.
Prealloc path from syscall is using GFP_USER.
