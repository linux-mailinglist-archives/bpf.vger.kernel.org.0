Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75AC55F37B
	for <lists+bpf@lfdr.de>; Wed, 29 Jun 2022 04:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiF2CtS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jun 2022 22:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiF2CtQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jun 2022 22:49:16 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B7821E3A
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 19:49:14 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id q6so29646067eji.13
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 19:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G/Y5+lP8LqqHGKaor3ash/7uQ/mp2B3+t9LF61KTzys=;
        b=RVvz5sv6xGBFyHt5D92muxlfvhAJt5qRhb5/Sx2UG/Cqq5zA5ntZfTAXJhC188fQ82
         RaG6IRxI5BOw3Z8W4/XiCLNqHhpIMOctPs6jLClj+I2vVdjSAa41zBtcU6lAwt4lCIMt
         l0Oy/i79LqRz71n5Llqlhm1afX5RmicivzGc63GSHjaxQqnIzYH+RScZaY6gGMcMS3xM
         /43AJXz8ZzR23Ri7zOKAdQmIjtepIIsAPjfpMYudPQFI3KAt5+p3boMA0NaGK/FBWa8V
         ctYnYEppN/jtnG7jhb1yg5XvYSkCiotFOS0Y1wnIob5tURbeDf6rWu5aBvCA32+dO90q
         p9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G/Y5+lP8LqqHGKaor3ash/7uQ/mp2B3+t9LF61KTzys=;
        b=H98kgbeHoT91OiwTq7KoLQ7Br96u7ZZsiASVGUJucj8Lsep469mEGooKn5xMB5MDBm
         9u75HVHSyHR2mXtssh/m1IdDu7DD90snJL44QNV9t/ogcrIfbbd2tqjrUZXHnz7xRNxo
         NwD/fM9xKjLPa7jeR+DsZNH7ICek+h/YED1imvVpSiQMXp0CAkbaXNUy1x2MlOtj7ijV
         2qd3GyNC8IrPVcg7N7+YwDT9pXVyGtyMJLXdcUs1MfPnZGiXPfWsk7jCCwz8xiJTCP/e
         lOEQWX2wcBdgq3aBnkQ+0UL67GfuBuINnxv7hyLRu5YK4QB7+M3/2myjk3CPvPNPozcT
         5HYw==
X-Gm-Message-State: AJIora8loDylivnLA4BJYG3xrEF7CwFCFiGoOuwyax0uGXEobdk9Wd88
        pivE+GjkXVNtFjN4fHfPZ6QWo55Wp45QiNLpKYi0wOT/8Yg=
X-Google-Smtp-Source: AGRyM1tEQ7AHcBCTpsoylVDeYDTjPSzZwGlaNVBU/7FH4JLU+kpwQVZnFKSEEXo0jNAxb9wBvEsXd3LIOTvvxfdtSD8=
X-Received: by 2002:a17:906:5189:b0:722:dc81:222a with SMTP id
 y9-20020a170906518900b00722dc81222amr1138261ejk.502.1656470952942; Tue, 28
 Jun 2022 19:49:12 -0700 (PDT)
MIME-Version: 1.0
References: <YrlWLLDdvDlH0C6J@infradead.org> <alpine.DEB.2.22.394.2206280213510.280764@gentwo.de>
 <CAADnVQKfLE6mwh8BrijgJeLL60DNaGgVy9b133vZ6edZmugong@mail.gmail.com>
 <alpine.DEB.2.22.394.2206281550210.328950@gentwo.de> <20220628170343.ng46xfwi32vefiyp@MacBook-Pro-3.local>
 <alpine.DEB.2.22.394.2206290431540.371188@gentwo.de>
In-Reply-To: <alpine.DEB.2.22.394.2206290431540.371188@gentwo.de>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 28 Jun 2022 19:49:01 -0700
Message-ID: <CAADnVQ+6BQsunu+ipDJpEuikUU402bZPevK9+MuaBoNC_rAu_A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/5] bpf: BPF specific memory allocator.
To:     Christoph Lameter <cl@gentwo.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Miller <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Tejun Heo <tj@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        linux-mm <linux-mm@kvack.org>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
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

On Tue, Jun 28, 2022 at 7:35 PM Christoph Lameter <cl@gentwo.de> wrote:
>
> On Tue, 28 Jun 2022, Alexei Starovoitov wrote:
>
> > > That is a relatively new feature due to RT logic support. without RT this
> > > would be a simple irq disable.
> >
> > Not just RT.
> > It's a slow path:
> >         if (IS_ENABLED(CONFIG_PREEMPT_RT) ||
> >             unlikely(!object || !slab || !node_match(slab, node))) {
> >               local_unlock_irqrestore(&s->cpu_slab->lock,...);
> > and that's not the only lock in there.
> > new_slab->allocate_slab... alloc_pages grabbing more locks.
>
>
> Its not a lock for !RT.
>
> The fastpath is lockless if hardware allows that but then we go into more
> and more serialiation needs as the allocation gets more into the page
> allocator logic.

On RT fast path == slow path with a lock.
On !RT fast path is lock less.
That's all correct.
bpf side has to make sure safety in all possible paths
therefore RT or !RT makes no difference.
