Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546C86DCCD8
	for <lists+bpf@lfdr.de>; Mon, 10 Apr 2023 23:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjDJVfS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Apr 2023 17:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDJVfR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Apr 2023 17:35:17 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD92172D;
        Mon, 10 Apr 2023 14:35:16 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5049a1085cbso1220112a12.3;
        Mon, 10 Apr 2023 14:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681162514; x=1683754514;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rc4V4a4tCJSui2sn08n+mk8Q22U/XQOyhuZaLhrce2U=;
        b=XxW4gpw7N42SvL5t6psjxn4IUtriVOJE4g77JiSsGGOO1bBoWCxMJtGn+varv23zcB
         5HAesLKZpoZAXoZpe0amQowTuKYEZKhSxSlpyf55/e00EWYWee8fg4CNe32SO6Oxi0kv
         p/8l53UaXRf41l5hA9x1C8BCW2E2yYufomGI9oX1Wf+i8vpbqeVcpIUheVTm4Vch42PX
         xoROUEpXxi4Uv/4u1VHbnwWgCf2c1QldcTft0N8KM9zF03W/E+njF4KXHk4Gjc5VMOO9
         2d5wuDYwDf883+s4Tca+dON+O1hdM6mDsS8ENIeVxruTTv1bwQffnwIJrx2qPDY9GDeV
         HVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681162514; x=1683754514;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rc4V4a4tCJSui2sn08n+mk8Q22U/XQOyhuZaLhrce2U=;
        b=xdl82+Zrp2ncny5JkIRanR17lnhEO0Y4hdUN2XW6TsC9GzTwq0ao3Ugo0aMtaZAUcS
         BeDGWlCJXvPUqHvLnWL1kib/Xytmvw0DM90lQw/fc+ZgT+SW7UxT288DIrOhlxIYCpFM
         WqTIIqrBnga2rWo/mJzU4kXowRmL5ObE+LzZsZ0tyMubQVmw0LqgXL3xsPuaH0QL0PGX
         18AgqIxedrtuwsmDzB5GH9Q/VkGc4WLsgtK/+ms0nQ4qzD/EwMiCtGwjWssu0RyhgTcw
         97PFRYj+ebOYZfqTpU6H7xoEzZkX1sEM1epyJ3hQgntPeCpcFzm/EWJGGrh8rpXZTlZD
         4CHg==
X-Gm-Message-State: AAQBX9fVhhTQEwJJJVRtYFpbi88vr9oGQhsjpjnkR2jz4fgut2Q3a73h
        SnvPeN96OYhy3l7Sn/4TPyc=
X-Google-Smtp-Source: AKy350bSwEMsvWNJy3ScLA73dn0aYaGJUe0gkhDeXTByyZ7uTaBA3ujVFVgYmWmttWrOYT168NhTIw==
X-Received: by 2002:a50:ec8f:0:b0:504:a2c9:c657 with SMTP id e15-20020a50ec8f000000b00504a2c9c657mr4777357edr.42.1681162514299;
        Mon, 10 Apr 2023 14:35:14 -0700 (PDT)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id w4-20020a50c444000000b004bf999f8e57sm5153932edf.19.2023.04.10.14.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 14:35:13 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 10 Apr 2023 23:35:11 +0200
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        alexei.starovoitov@gmail.com, linux-trace-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <olsajiri@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] tracing: Refuse fprobe if RCU is not watching
Message-ID: <ZDSBD6UvUdA73TSv@krava>
References: <20230409075515.2504db78@rorschach.local.home>
 <CALOAHbBALsJrkO-tPKoEtrdm42fLnRoYs-46tz0J7yDwrxC0Tg@mail.gmail.com>
 <20230409225414.2b66610f4145ade7b09339bb@kernel.org>
 <CALOAHbBQFSm=rXvzJJnOqrK04f9j1opbgRoYKwSUAd5g64r-jA@mail.gmail.com>
 <20230409220239.0fcf6738@rorschach.local.home>
 <CALOAHbC5UvoU2EUM+YzNSaJyNNq_OOXYZYcqXu6nUfB0AyX0bA@mail.gmail.com>
 <20230410063046.391dd2bd@rorschach.local.home>
 <CALOAHbCXgksmdYRRxrjVrW1-AWiTr1u24yJAdh2+0ou15vvKiA@mail.gmail.com>
 <20230410101224.7e3b238c@gandalf.local.home>
 <CALOAHbBQgPqhBhOVukWG9FNL23m3EOFm1QN6+pi5SN8cP2ztBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbBQgPqhBhOVukWG9FNL23m3EOFm1QN6+pi5SN8cP2ztBw@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 10, 2023 at 10:20:31PM +0800, Yafang Shao wrote:
> On Mon, Apr 10, 2023 at 10:12 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Mon, 10 Apr 2023 21:56:16 +0800
> > Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > > Thanks for your explanation again.
> > > BPF trampoline is a little special. It includes three parts, as follows,
> > >
> > >     ret = __bpf_prog_enter();
> > >     if (ret)
> > >         prog->bpf_func();
> > >      __bpf_prog_exit();
> > >
> > > migrate_disable() is called in __bpf_prog_enter() and migrate_enable()
> > > in __bpf_prog_exit():
> > >
> > >     ret = __bpf_prog_enter();
> > >                 migrate_disable();
> > >     if (ret)
> > >         prog->bpf_func();
> > >      __bpf_prog_exit();
> > >           migrate_enable();
> > >
> > > That said, if we haven't executed migrate_disable() in
> > > __bpf_prog_enter(), we shouldn't execute migrate_enable() in
> > > __bpf_prog_exit().
> > > Can ftrace_test_recursion_trylock() be applied to this pattern ?
> >
> > Yes, it can! And in this you would need to not call migrate_enable()
> > because if the trace_recursion_trylock() failed, it would prevent
> > migrate_disable() from being called (and should not let the bpf_func() from
> > being called either. And then the migrate_enable in __bpf_prog_exit() would
> > need to know not to call migrate_enable() which checking the return value
> > of ftrace_test_recursion_trylock() would give the same value as what the
> > one before migrate_disable() had.
> >
> 
> That needs some changes in invoke_bpf_prog() in files
> arch/${ARCH}/net/bpf_jit_comp.c.
> But I will have a try. We can then remove the bpf_prog->active, that
> will be a good cleanup as well.

I was wondering if it's worth the effort to do that just to be able to attach
bpf prog to preempt_count_add/sub and was going to suggest to add them to
btf_id_deny as Steven pointed out earlier as possible solution

but if that might turn out as alternative to prog->active, that'd be great

jirka

> 
> >
> > >
> > > > Note, the ftrace_test_recursion_*() code needs to be updated because it
> > > > currently does disable preemption, which it doesn't have to. And that
> > > > can cause migrate_disable() to do something different. It only disabled
> > > > preemption, as there was a time that it needed to, but now it doesn't.
> > > > But the users of it will need to be audited to make sure that they
> > > > don't need the side effect of it disabling preemption.
> > > >
> > >
> > > disabling preemption is not expected by bpf prog, so I think we should
> > > change it.
> >
> > The disabling of preemption was just done because every place that used it
> > happened to also disable preemption. So it was just a clean up, not a
> > requirement. Although the documentation said it did disable preemption :-/
> >
> >  See ce5e48036c9e7 ("ftrace: disable preemption when recursion locked")
> >
> > I think I can add a ftrace_test_recursion_try_aquire() and release() that
> > is does the same thing without preemption. That way, we don't need to
> > revert that patch, and use that instead.
> >
> > -- Steve
> 
> 
> 
> -- 
> Regards
> Yafang
