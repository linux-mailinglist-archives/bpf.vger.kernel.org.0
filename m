Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3828C5A5738
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 00:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiH2WnM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 18:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiH2WnL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 18:43:11 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AF4A2633
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 15:43:10 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id cu2so18680844ejb.0
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 15:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=nB3G0Zv39kvmVIMxWXDEfEHm0/oHTjvgK70XgH2kXHs=;
        b=bQ/MW08nxw4kxemHxuQoyJu8CgSLv94v3iLshmlqWM6+IQvCOIn0rhEIYT/XkNXIOz
         YzeUvaI/tZkXE3Na6PMnyEFofXzJ753HK7yfpak8RsgOoxcYQHI3c3B0d/PvPdvqsRsz
         RVTjUWC3oK4c81WbeLsV/fRCuGkwq7OwiUS8crigT+GXl3nKHYW/jtbed5kwIf8ZTwat
         PM/02NwPeYzpEnAm2PuVv2pQs/+1QqBg6CDIXZ0HNkBzybrnPZWhVwlugqoMnu1oTk8l
         eofNTYiFNVSZr9HPf09Yy5ojSUznVZXipH7iuh4Z8lww/lHDe5ArL63C+Qqs8ketSHjB
         DzVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=nB3G0Zv39kvmVIMxWXDEfEHm0/oHTjvgK70XgH2kXHs=;
        b=xKZOuz3LPqn7JKfE9rxfuLU5nTdsLhycrZYr/FXRi3NX7jG2HVX/ta/dLXozG9hOJ/
         OsIWaA4mDt7zujkCJvwNkMTrBv1ru0XUCd+DnuiyV4qNCePdDx3t1+1rqnQ4O0M/eol1
         G6GWL3lpOr1UkqKGQTIVKbk4f/G0lOgXjpg5A9N4PYr2uY670Y1k2MfCQo1squ+1zn2P
         +J6HIK//YTNtiLTDWnwhtRW/nR4RWeuxQEyj7rxceGFJKH+ozSXfuenIhQ7/rKtQB6Vt
         CAS3Ek4Xl+LDG/qY5CKPUdkmZBAwZMidLZMmoxlyLMhLsnfgv98mwS319z4S2IJrl335
         WUCg==
X-Gm-Message-State: ACgBeo3lZ8GPKnldMLz2HuwrXY9R/drBS8DLBVlyaiXvuGaK476KeT4T
        8KDkuLK1LQtK29aBbkxf4vjSmuCGhSCERiwN+1E=
X-Google-Smtp-Source: AA6agR4EZgtSg9KGAtxiJiFpOYodeXtzvV1OsuZ/VFLeGV2lsrJFjXto8xjFTcS0Y4kgHarfBKdK/86DpvzyJdHblOg=
X-Received: by 2002:a17:907:2c74:b0:741:657a:89de with SMTP id
 ib20-20020a1709072c7400b00741657a89demr6646552ejc.58.1661812989097; Mon, 29
 Aug 2022 15:43:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220826024430.84565-1-alexei.starovoitov@gmail.com>
 <20220826024430.84565-2-alexei.starovoitov@gmail.com> <20220829223946.vfu4hi64ybitvt27@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220829223946.vfu4hi64ybitvt27@kafai-mbp.dhcp.thefacebook.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 29 Aug 2022 15:42:57 -0700
Message-ID: <CAADnVQLR4nBvJ0RpEdcGF1MFOW=MmA5xicofCyt8sP_AHMzAsA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 01/15] bpf: Introduce any context BPF specific
 memory allocator.
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Tejun Heo <tj@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Delyan Kratunov <delyank@fb.com>,
        linux-mm <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
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

On Mon, Aug 29, 2022 at 3:39 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Thu, Aug 25, 2022 at 07:44:16PM -0700, Alexei Starovoitov wrote:
> > +/* Mostly runs from irq_work except __init phase. */
> > +static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
> > +{
> > +     struct mem_cgroup *memcg = NULL, *old_memcg;
> > +     unsigned long flags;
> > +     void *obj;
> > +     int i;
> > +
> > +     memcg = get_memcg(c);
> > +     old_memcg = set_active_memcg(memcg);
> > +     for (i = 0; i < cnt; i++) {
> > +             obj = __alloc(c, node);
> > +             if (!obj)
> > +                     break;
> > +             if (IS_ENABLED(CONFIG_PREEMPT_RT))
> > +                     /* In RT irq_work runs in per-cpu kthread, so disable
> > +                      * interrupts to avoid preemption and interrupts and
> > +                      * reduce the chance of bpf prog executing on this cpu
> > +                      * when active counter is busy.
> > +                      */
> > +                     local_irq_save(flags);
> > +             if (local_inc_return(&c->active) == 1) {
> Is it because it is always '== 1' here so that there is
> no need to free the obj when it is '!= 1' ?

Great catch. It's a bug indeed.
