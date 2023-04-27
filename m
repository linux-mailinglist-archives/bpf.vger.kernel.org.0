Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5426F0679
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 15:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243737AbjD0NP2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 09:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjD0NP1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 09:15:27 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7907846B8
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 06:15:15 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f178da21b5so58535105e9.3
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 06:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682601314; x=1685193314;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=opITWvbQjziI/E5SCjAz3QLLB0CM6Oc6df+55w3op8s=;
        b=X7A9NQy4qRLJeZ6IOrCmxTEvuTSCxBiQ4FGQRuMqKzaf4R6P/OUwU2ASWWNkwj0f7T
         vp0RyNxDXz46JPVyVYk+I8nWZXd8D4lJBZCBeINE9XSAkP9RzSoVJU7DtsXGhVMKHjfI
         GhXVf48EYHJBsWpsuJ/iTrAWDHOneHRbMyux4CTXs3GnTgZBRp8Q+1hI2kZXxiwBe+q/
         23v3voirnomp61s5K2GM3853FMfGydYFusO1yCFxJRaYcINDKsadtwgO0U84F0fhkflR
         CzQfeJlJk/qk36QO+Em/pJsCSdmXV8hYdy4LM9T8/D6Izn8X95bcUESU50XBMqjNBhP8
         Sefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682601314; x=1685193314;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=opITWvbQjziI/E5SCjAz3QLLB0CM6Oc6df+55w3op8s=;
        b=Tv2CaQPrXCahQtNdSGPjGAdqG+z7bL9TwBGbjrh4YGOlgAFj7rWyhfEOtepwE2Zk41
         2mJsCvKyqiMaf5mkM6uQO7OjjuGROrXvD2QwMs7MnPvK/5wP4MSBdZf/AQ2F1XAunref
         PnFSDttKE8mCimOuQ0/2FnPfndccgw0GobsvMKxYZZ63/HZKwPMSnDh5ZttrvPRg1k6I
         MCsRoq48/ppAAOCksY43Vf2fWw2rJQsdJTnCXcT0oqFzVa5XsTMk6m3d7b1A61dNclql
         Y3M03qD571WZWIB7EXXLUIm853wgUXHoWrT4VMgmgYI3CJNaBdY5sfYas6uQhJEj+ODQ
         KoWQ==
X-Gm-Message-State: AC+VfDwQx+DcTa35JkyxHzXXXzVJ3mZcWm/LY1TrjdmAxhnfCGjDoErg
        GfUAdLpzcWp1FzlwDw1d7fEVohBlikbG8A==
X-Google-Smtp-Source: ACHHUZ4X83z3XZ5wUtBadv3q3N71EcVbeEBOcdrQi478dHxfzwG2WVFynP+5wsth9LoSB2URRu97Uw==
X-Received: by 2002:adf:f491:0:b0:2f7:780e:ee0a with SMTP id l17-20020adff491000000b002f7780eee0amr1296667wro.64.1682601313779;
        Thu, 27 Apr 2023 06:15:13 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-8b88-53b7-c55c-8535.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:8b88:53b7:c55c:8535])
        by smtp.gmail.com with ESMTPSA id j3-20020a5d5643000000b002e4cd2ec5c7sm18511961wrw.86.2023.04.27.06.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 06:15:13 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 27 Apr 2023 15:15:11 +0200
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [RFC/PATCH bpf-next 01/20] bpf: Add multi uprobe link
Message-ID: <ZEp1X0Uk4QNl+NI5@krava>
References: <20230424160447.2005755-1-jolsa@kernel.org>
 <20230424160447.2005755-2-jolsa@kernel.org>
 <20230424221120.h3vdmuehxi33st4n@dhcp-172-26-102-232.dhcp.thefacebook.com>
 <ZEejcYDRbxDGebAr@krava>
 <CAEf4BzbuKeukcsch7NRFwLPGD7nkLEJXEm8ps+3RYzopy2YiUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbuKeukcsch7NRFwLPGD7nkLEJXEm8ps+3RYzopy2YiUA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 26, 2023 at 12:01:47PM -0700, Andrii Nakryiko wrote:
> On Tue, Apr 25, 2023 at 2:55 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Mon, Apr 24, 2023 at 03:11:20PM -0700, Alexei Starovoitov wrote:
> > > On Mon, Apr 24, 2023 at 06:04:28PM +0200, Jiri Olsa wrote:
> > > > +
> > > > +static int uprobe_prog_run(struct bpf_uprobe *uprobe,
> > > > +                      unsigned long entry_ip,
> > > > +                      struct pt_regs *regs)
> > > > +{
> > > > +   struct bpf_uprobe_multi_link *link = uprobe->link;
> > > > +   struct bpf_uprobe_multi_run_ctx run_ctx = {
> > > > +           .entry_ip = entry_ip,
> > > > +   };
> > > > +   struct bpf_run_ctx *old_run_ctx;
> > > > +   int err;
> > > > +
> > > > +   preempt_disable();
> > >
> > > preempt_disable? Which year is this? :)
> > > Let's allow sleepable from the start.
> > > See bpf_prog_run_array_sleepable.
> >
> > ok, we should probably add also 'multi.uprobe.s' section so the program
> > gets loaded with the BPF_F_SLEEPABLE flag.. or maybe we can enable that
> > by default for 'multi.uprobe' section
> 
> "uprobe.multi.s" rather, to follow "kprobe.multi.s". But we can't make
> it sleepable always/by default. Sleepable BPF programs are not just
> better types of programs, they have their own limitations, so it has
> to be the user's choice to go with sleepable or non-sleepable.

ok, will add uprobe.multi.s

thanks,
jirka

> 
> >
> > >
> > > Other than this the set looks great.
> > >
> > > > +
> > > > +   if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1)) {
> > > > +           err = 0;
> > > > +           goto out;
> > > > +   }
> > > > +
> > > > +   rcu_read_lock();
> > > > +   old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
> > > > +   err = bpf_prog_run(link->link.prog, regs);
> > > > +   bpf_reset_run_ctx(old_run_ctx);
> > > > +   rcu_read_unlock();
> > > > +
> 
> [...]
