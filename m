Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7266DF8BA
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 16:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbjDLOiQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 10:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjDLOiA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 10:38:00 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD3893CD;
        Wed, 12 Apr 2023 07:37:44 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id ay7so10933736qkb.6;
        Wed, 12 Apr 2023 07:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681310263; x=1683902263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b09CrhD67oV9Nc91i6UQuqChgusxN1E7ggWKfvHWW5E=;
        b=WrjlJ5j31NPotp7JiePq/XbNUAJIcRBrvGr/2oGw6GCqLHlOWRwksUVEBbMONhiijp
         cpDUiFivtC5NO4+1BZp78+QUQGXDIh+6RMs7Zzjvnq92fttFuCeFqa+eBboz3YPwSTZU
         FTfKxepiJuHRHxDtX1Q46fsi4Zjimlbb7rDNL/1+b10XJqzEI6JHxCYZL1E+5llyVrlN
         ySnqORQikS93EjvpmtQ4iEm574NHbRZZVXRXYOmytGDx3OKzLQtg4EIehAkYhHCxq6fC
         qVL0gzKa9aUbyzRQIICp0yPu4j4KuFqr84uAN9bCVyIafEyns7Bl4S7QzVRjQISsMXEa
         E+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681310263; x=1683902263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b09CrhD67oV9Nc91i6UQuqChgusxN1E7ggWKfvHWW5E=;
        b=DF+Cn6pIjfyMo6HrUh/WAdVXonJQ7oCkrf6lwdte4ACovJk1Ugm7ss8n5RbqdowzOK
         s6Lnc9EbRmJuTQRkttoNFO8ZBvNPm/9Aijf+4ArY0f9+ptSVjjoDl1Ai17LDU6KKb/Sl
         BUWf/95Z5VYwVhIepU4oo2kAYjB87/nr3m7zLc9BtCUum38ibe1sCkaKa1oF+Zcf14Ap
         omSZx/vNCClFiREs6dQRX1A8GToKw2jvDGBC6FQq5fIvD1fsFmEjyNGc4GarvTTIMun9
         Uu1xfhRT6U07ZvWTHSf1s2tbATJfVxUnzAJMjYizo7RCNwIvwp4Xy3G0G9cJdXzsADDz
         1Lbg==
X-Gm-Message-State: AAQBX9fvy9dbtKvx6pLteZOS8hfPwuG5EJbU3iqf8m6eAlY4K/2iNT8p
        M/RqFO67rkm0oGHCD63kf5Z1mGTpjZ11BKLJkZQ=
X-Google-Smtp-Source: AKy350bh83dXX/NNxSuzJvoGWlVf21/bwGqVgqgxZO35fqxfRMpj+2VelWyXcycwSOt3Cpf2es/qYnSlvpjdZcIbYlM=
X-Received: by 2002:a05:620a:1918:b0:743:9b78:d97e with SMTP id
 bj24-20020a05620a191800b007439b78d97emr6062195qkb.14.1681310263035; Wed, 12
 Apr 2023 07:37:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230409075515.2504db78@rorschach.local.home> <CALOAHbBALsJrkO-tPKoEtrdm42fLnRoYs-46tz0J7yDwrxC0Tg@mail.gmail.com>
 <20230409225414.2b66610f4145ade7b09339bb@kernel.org> <CALOAHbBQFSm=rXvzJJnOqrK04f9j1opbgRoYKwSUAd5g64r-jA@mail.gmail.com>
 <20230409220239.0fcf6738@rorschach.local.home> <CALOAHbC5UvoU2EUM+YzNSaJyNNq_OOXYZYcqXu6nUfB0AyX0bA@mail.gmail.com>
 <20230410063046.391dd2bd@rorschach.local.home> <CALOAHbCXgksmdYRRxrjVrW1-AWiTr1u24yJAdh2+0ou15vvKiA@mail.gmail.com>
 <20230410101224.7e3b238c@gandalf.local.home> <CALOAHbBQgPqhBhOVukWG9FNL23m3EOFm1QN6+pi5SN8cP2ztBw@mail.gmail.com>
 <ZDSBD6UvUdA73TSv@krava>
In-Reply-To: <ZDSBD6UvUdA73TSv@krava>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 12 Apr 2023 22:37:07 +0800
Message-ID: <CALOAHbACzCwu-VeMczEJw8A4WFgkL-uQDS1NkcVR2pqEMZyAQQ@mail.gmail.com>
Subject: Re: [PATCH] tracing: Refuse fprobe if RCU is not watching
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        alexei.starovoitov@gmail.com, linux-trace-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 11, 2023 at 5:35=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Mon, Apr 10, 2023 at 10:20:31PM +0800, Yafang Shao wrote:
> > On Mon, Apr 10, 2023 at 10:12=E2=80=AFPM Steven Rostedt <rostedt@goodmi=
s.org> wrote:
> > >
> > > On Mon, 10 Apr 2023 21:56:16 +0800
> > > Yafang Shao <laoar.shao@gmail.com> wrote:
> > >
> > > > Thanks for your explanation again.
> > > > BPF trampoline is a little special. It includes three parts, as fol=
lows,
> > > >
> > > >     ret =3D __bpf_prog_enter();
> > > >     if (ret)
> > > >         prog->bpf_func();
> > > >      __bpf_prog_exit();
> > > >
> > > > migrate_disable() is called in __bpf_prog_enter() and migrate_enabl=
e()
> > > > in __bpf_prog_exit():
> > > >
> > > >     ret =3D __bpf_prog_enter();
> > > >                 migrate_disable();
> > > >     if (ret)
> > > >         prog->bpf_func();
> > > >      __bpf_prog_exit();
> > > >           migrate_enable();
> > > >
> > > > That said, if we haven't executed migrate_disable() in
> > > > __bpf_prog_enter(), we shouldn't execute migrate_enable() in
> > > > __bpf_prog_exit().
> > > > Can ftrace_test_recursion_trylock() be applied to this pattern ?
> > >
> > > Yes, it can! And in this you would need to not call migrate_enable()
> > > because if the trace_recursion_trylock() failed, it would prevent
> > > migrate_disable() from being called (and should not let the bpf_func(=
) from
> > > being called either. And then the migrate_enable in __bpf_prog_exit()=
 would
> > > need to know not to call migrate_enable() which checking the return v=
alue
> > > of ftrace_test_recursion_trylock() would give the same value as what =
the
> > > one before migrate_disable() had.
> > >
> >
> > That needs some changes in invoke_bpf_prog() in files
> > arch/${ARCH}/net/bpf_jit_comp.c.
> > But I will have a try. We can then remove the bpf_prog->active, that
> > will be a good cleanup as well.
>
> I was wondering if it's worth the effort to do that just to be able to at=
tach
> bpf prog to preempt_count_add/sub and was going to suggest to add them to
> btf_id_deny as Steven pointed out earlier as possible solution
>
> but if that might turn out as alternative to prog->active, that'd be grea=
t
>

I think we can do it in two steps,
1. Fix this crash by adding preempt_count_{sub,add} into btf_id deny list.
   The stable kernel may need this fix, so we'd better make it
simpler, then it can be backported easily.

2. Replace prog->active with the new
test_recursion_try_{acquire,release} introduced by Steven
   That's an improvement. We can do it in a separate patchset.

WDYT?

BTW, maybe we need to add a new fentry test case to attach all
available FUNCs parsed from /sys/kernel/btf/vmlinux.

--=20
Regards
Yafang
