Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5606DFE53
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 21:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjDLTFQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 15:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjDLTFO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 15:05:14 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4D17EF4;
        Wed, 12 Apr 2023 12:04:47 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id ga37so31775586ejc.0;
        Wed, 12 Apr 2023 12:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681326278; x=1683918278;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GdWT1yIsNgL1eH2gkAxj2WxUd3oDPoUVsi6y2aWeInU=;
        b=V+L1HItt+DJdcISnhvZu6Aro028t6e5wOS318MSKl39rYgx5dxfWbPzAwkMzpOwHZX
         ZpqmyR+u7Orbq8yW+YuydeYqnBVpqsF1i5wn62TalO84JMgdda4wEho5koYUsklS8Yx5
         mJo6bWRE9PAQ2SgVRs+PoLEjpsXc52/8igX2BvAltLKRqx8hoOuUZdLdVj8gUVqfCvpw
         P/ALvU7gf0BP4ioI106e5CYH6h71cNlAo2J74EScYPuRTwsyHLQexS4rmlqbfs9VDyLC
         jaHd85kMR9ZZEmEiFPdcEKGvwlc+mdHbLAlooBtiBqfHogmFhIwx6Gvx4Y9XrRZ3EWB/
         lA2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681326278; x=1683918278;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GdWT1yIsNgL1eH2gkAxj2WxUd3oDPoUVsi6y2aWeInU=;
        b=Y69SHiGhpTD9C3Yz0TQmtz/zvIirKiXQZSflAfS3NWHHOg/92NTpfHyWCrbyWQhs/s
         GC8v0UEt32d6p78Lk+cBplFC7MdH9ale1bKA2yifJRqWNG14rYtMkNBQGfOdpT0tSrG0
         1JE48aqfjoD03B3PnhJDrlG30WdcVtmrX+saECXFE3OqVywpQb0/J0BC88b22yhoj6Hh
         YRamXnC/o3gSj+WjjNtXIXxrexuSqXz5AusAx62ditraus6OexQIFacYMYmICfyvcyjl
         CSH1t+D2Dvth9B7Cgv8lBbEpnAY13XQ2QabD6Z/escvuc/Ska9xVG9yrBWulkLz9t1nV
         SUpA==
X-Gm-Message-State: AAQBX9cOFqUtJvcyaOm+R/8ILR6O3xGVzMUlulhi7JZqE2kA7SZ5mNPM
        yKGT7OuCwvz6E7j9sBkMZ58=
X-Google-Smtp-Source: AKy350afwFML+ThFkw9PgmWYTJ6p7J5K9ezPoqtwyWxtpTR7PdWWubEPC/UdO+KsY+bBdSOWuEl2Sg==
X-Received: by 2002:a17:906:3954:b0:8b1:77bf:3bdd with SMTP id g20-20020a170906395400b008b177bf3bddmr3172352eje.36.1681326278010;
        Wed, 12 Apr 2023 12:04:38 -0700 (PDT)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id tf8-20020a1709078d8800b0094e4e3344f6sm1242497ejc.164.2023.04.12.12.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 12:04:37 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 12 Apr 2023 21:04:30 +0200
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        alexei.starovoitov@gmail.com, linux-trace-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] tracing: Refuse fprobe if RCU is not watching
Message-ID: <ZDcAvr0JuNE445FZ@krava>
References: <20230409225414.2b66610f4145ade7b09339bb@kernel.org>
 <CALOAHbBQFSm=rXvzJJnOqrK04f9j1opbgRoYKwSUAd5g64r-jA@mail.gmail.com>
 <20230409220239.0fcf6738@rorschach.local.home>
 <CALOAHbC5UvoU2EUM+YzNSaJyNNq_OOXYZYcqXu6nUfB0AyX0bA@mail.gmail.com>
 <20230410063046.391dd2bd@rorschach.local.home>
 <CALOAHbCXgksmdYRRxrjVrW1-AWiTr1u24yJAdh2+0ou15vvKiA@mail.gmail.com>
 <20230410101224.7e3b238c@gandalf.local.home>
 <CALOAHbBQgPqhBhOVukWG9FNL23m3EOFm1QN6+pi5SN8cP2ztBw@mail.gmail.com>
 <ZDSBD6UvUdA73TSv@krava>
 <CALOAHbACzCwu-VeMczEJw8A4WFgkL-uQDS1NkcVR2pqEMZyAQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbACzCwu-VeMczEJw8A4WFgkL-uQDS1NkcVR2pqEMZyAQQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 12, 2023 at 10:37:07PM +0800, Yafang Shao wrote:
> On Tue, Apr 11, 2023 at 5:35 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Mon, Apr 10, 2023 at 10:20:31PM +0800, Yafang Shao wrote:
> > > On Mon, Apr 10, 2023 at 10:12 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> > > >
> > > > On Mon, 10 Apr 2023 21:56:16 +0800
> > > > Yafang Shao <laoar.shao@gmail.com> wrote:
> > > >
> > > > > Thanks for your explanation again.
> > > > > BPF trampoline is a little special. It includes three parts, as follows,
> > > > >
> > > > >     ret = __bpf_prog_enter();
> > > > >     if (ret)
> > > > >         prog->bpf_func();
> > > > >      __bpf_prog_exit();
> > > > >
> > > > > migrate_disable() is called in __bpf_prog_enter() and migrate_enable()
> > > > > in __bpf_prog_exit():
> > > > >
> > > > >     ret = __bpf_prog_enter();
> > > > >                 migrate_disable();
> > > > >     if (ret)
> > > > >         prog->bpf_func();
> > > > >      __bpf_prog_exit();
> > > > >           migrate_enable();
> > > > >
> > > > > That said, if we haven't executed migrate_disable() in
> > > > > __bpf_prog_enter(), we shouldn't execute migrate_enable() in
> > > > > __bpf_prog_exit().
> > > > > Can ftrace_test_recursion_trylock() be applied to this pattern ?
> > > >
> > > > Yes, it can! And in this you would need to not call migrate_enable()
> > > > because if the trace_recursion_trylock() failed, it would prevent
> > > > migrate_disable() from being called (and should not let the bpf_func() from
> > > > being called either. And then the migrate_enable in __bpf_prog_exit() would
> > > > need to know not to call migrate_enable() which checking the return value
> > > > of ftrace_test_recursion_trylock() would give the same value as what the
> > > > one before migrate_disable() had.
> > > >
> > >
> > > That needs some changes in invoke_bpf_prog() in files
> > > arch/${ARCH}/net/bpf_jit_comp.c.
> > > But I will have a try. We can then remove the bpf_prog->active, that
> > > will be a good cleanup as well.
> >
> > I was wondering if it's worth the effort to do that just to be able to attach
> > bpf prog to preempt_count_add/sub and was going to suggest to add them to
> > btf_id_deny as Steven pointed out earlier as possible solution
> >
> > but if that might turn out as alternative to prog->active, that'd be great
> >
> 
> I think we can do it in two steps,
> 1. Fix this crash by adding preempt_count_{sub,add} into btf_id deny list.
>    The stable kernel may need this fix, so we'd better make it
> simpler, then it can be backported easily.
> 
> 2. Replace prog->active with the new
> test_recursion_try_{acquire,release} introduced by Steven
>    That's an improvement. We can do it in a separate patchset.
> 
> WDYT?

sounds good

> 
> BTW, maybe we need to add a new fentry test case to attach all
> available FUNCs parsed from /sys/kernel/btf/vmlinux.

that might be tricky because we don't have multi trampoline attach
support at the moment, so it will take forever

jirka
