Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0375B5A5759
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 01:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiH2XAU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 19:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiH2XAS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 19:00:18 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D141640BE1
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 16:00:15 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id h78so7861163iof.13
        for <bpf@vger.kernel.org>; Mon, 29 Aug 2022 16:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=SXSjsQulQUZhEBPyolmxKKos91OoddLanoYK6l3yQ0o=;
        b=e+LZwovHdInIQhvcg6Rz2dlYtRt/DQS0vq3iiJa5Ie0096/ZgrP8+0ayPoucvsFnhL
         5UPMOu80TM5ZU9SoVM1/JmsEvozKeJ9wxw86KrwIszyE96lKaYvP83hBQGYUyKSMpixq
         QByM0DEFwg6jV5PKdvhwudhB3c+DguQ+72BAZmtFj0zqO/fCZpKfhBSP03b7cMK/UXdq
         zJSX6tmHRlUeX1a2X8BtmiU9MC08P6nP7Rf+emWKASB5GfOGfypcGjsUnieIjzqXwHR5
         3cT7Uow4nzBxGtjnwoIx2gMnftgiEIOMrLw+Ub4hVLinroUxa0YRAS/neDhww/D7ZHV9
         dQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=SXSjsQulQUZhEBPyolmxKKos91OoddLanoYK6l3yQ0o=;
        b=AcGSOvb3kG4CMM1eQ6S73s/SrCvlMUo2oDUc/rTb9wqWFBaSJ8r+PwGFiukt6LW2Pm
         qll63pw+763YoZTD2fwU7+OrPq2v4pJRdXKess+vR7Bii1sI34SBMsgW1SvndinvKgeT
         70jn0EMwpXYUQRFZT/yEV6HVhsD0U1kt78Ibybvq9f80dvQpozDSSmLn/35GqpBPeB7w
         tlhgDif5hbYOjH5Sr3PPncDGevPBFJD2f6Qqp5KpeUttMyCz/Iq6FHWTBxrw7H0cObnd
         h7oNeEmncIjtNShUCYbpRUB6xgEmFN5ET2H2B0CiBjsiTxJKEVNd9K4JsISbPE4dcxkf
         GwGg==
X-Gm-Message-State: ACgBeo3AVcWOfd/esTrv/CgF7EfJKznFNfh6TCHYqAptR6UPhged0mqa
        51LT0NCGPnEWH+DA7M/bwrLe2T6tFFTZ9dCU04k=
X-Google-Smtp-Source: AA6agR6RYzUdkjRjd6mWABhe97j+fH9EyJWDrXsqNzRbcPd5HleLAsdiLPArL0Dwz8RKMtj2tq+PPjHp1EmFaQ83spQ=
X-Received: by 2002:a05:6638:2105:b0:34a:694:4fa4 with SMTP id
 n5-20020a056638210500b0034a06944fa4mr12023910jaj.116.1661814015254; Mon, 29
 Aug 2022 16:00:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220826024430.84565-1-alexei.starovoitov@gmail.com>
 <20220826024430.84565-2-alexei.starovoitov@gmail.com> <20220829223946.vfu4hi64ybitvt27@kafai-mbp.dhcp.thefacebook.com>
 <CAADnVQLR4nBvJ0RpEdcGF1MFOW=MmA5xicofCyt8sP_AHMzAsA@mail.gmail.com>
In-Reply-To: <CAADnVQLR4nBvJ0RpEdcGF1MFOW=MmA5xicofCyt8sP_AHMzAsA@mail.gmail.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Tue, 30 Aug 2022 00:59:39 +0200
Message-ID: <CAP01T76qn=+WZ3jVb=ue=+Zf5FyKbdQy0b9KxExzK9SN_4DeBA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 01/15] bpf: Introduce any context BPF specific
 memory allocator.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Martin KaFai Lau <kafai@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Tejun Heo <tj@kernel.org>,
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

On Tue, 30 Aug 2022 at 00:43, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Aug 29, 2022 at 3:39 PM Martin KaFai Lau <kafai@fb.com> wrote:
> >
> > On Thu, Aug 25, 2022 at 07:44:16PM -0700, Alexei Starovoitov wrote:
> > > +/* Mostly runs from irq_work except __init phase. */
> > > +static void alloc_bulk(struct bpf_mem_cache *c, int cnt, int node)
> > > +{
> > > +     struct mem_cgroup *memcg = NULL, *old_memcg;
> > > +     unsigned long flags;
> > > +     void *obj;
> > > +     int i;
> > > +
> > > +     memcg = get_memcg(c);
> > > +     old_memcg = set_active_memcg(memcg);
> > > +     for (i = 0; i < cnt; i++) {
> > > +             obj = __alloc(c, node);
> > > +             if (!obj)
> > > +                     break;
> > > +             if (IS_ENABLED(CONFIG_PREEMPT_RT))
> > > +                     /* In RT irq_work runs in per-cpu kthread, so disable
> > > +                      * interrupts to avoid preemption and interrupts and
> > > +                      * reduce the chance of bpf prog executing on this cpu
> > > +                      * when active counter is busy.
> > > +                      */
> > > +                     local_irq_save(flags);
> > > +             if (local_inc_return(&c->active) == 1) {
> > Is it because it is always '== 1' here so that there is
> > no need to free the obj when it is '!= 1' ?
>
> Great catch. It's a bug indeed.

Is it a bug? It seems it will always be true for alloc_bulk. IIUC it
is only needed to prevent NMI's unit_alloc, unit_free touching
free_llist, so that NMI llist_adds atomically to free_llist_nmi
instead. Since this runs from irq_work, we run exclusive to other
unit_free, otherwise the __llist_add wouldn't be safe either.
unit_free already does local_irq_save.
