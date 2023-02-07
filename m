Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4C868DD42
	for <lists+bpf@lfdr.de>; Tue,  7 Feb 2023 16:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjBGPqV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Feb 2023 10:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbjBGPqU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Feb 2023 10:46:20 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCBA3BD80
        for <bpf@vger.kernel.org>; Tue,  7 Feb 2023 07:46:18 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id d16so1844075ioz.12
        for <bpf@vger.kernel.org>; Tue, 07 Feb 2023 07:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=inKpBBjLn4HB9oNrk7TSDa44nRCr2tMX+kQDTOL7TwM=;
        b=HVIzX/8RgBuE8HiTN1h1+gDODQMpd2kk5X8eZ70erMfv8vhbwEJV+dPAHUFWgEKZF3
         mMjGJqvr7p0LBGLQ+OkWf+Fk9sSU+dMt6JcLn/Cd+f8R5hKWTdPTB2t0WZDamawdEldm
         SGDd7LVkBX3Ova0STulXPjLb4bFYHd6oXsphmVFck6S59kxow+Hx7ZPPjVQ9tOMKk+OF
         oC6CqGFfdF0vmVWYMzDsXmKVhRwhQvfJTbobsCmvF6fq56auzbBCOYioW0zNtDsQt30+
         m4Npzy+2Rt5lDC/jA8zDrmJKJY+R6XrYnoMnzV9VZQOt97kaUf9+ZxcqA2mGGDhLvEjH
         pE3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=inKpBBjLn4HB9oNrk7TSDa44nRCr2tMX+kQDTOL7TwM=;
        b=mb160iIMJmUD/c2V4OwTD+gWJs5Q5hreBU1YG94GjErJTGoVulX61lMl/F+2GV31rf
         puDBQ4e5EKeH2EzNb9YN1Sno84nMMYiarqM/6TSyNgtfhDD+DeKdHS5KrmrRusfuB7yF
         bhnFZpG04MTVEyyfiCtSP4om7dFwrARIbJ61KzDUDDXyIHpfudBnU8oFrCwlswTQIPNL
         V3aRFH8xZZ5n9ku1JCx7asuL3YVe427FSUR9kqrjmX/xM1Af5yVQYk7WLgi0yBWfWeS5
         wDnh/4/5eqU1YvD4wKuF11Mv4EdBrJ+jbF7JfbLlyzxhwAv7Vbq+twufQ6OYMS5xntTS
         2gGw==
X-Gm-Message-State: AO0yUKUa45xpcXDLWeLaCEIvLJyhPKQvJCK6dIqshAcc3UHGl/m55kq8
        PfbE9XM6nC6LVwfd0LRcZ0cBqxGUU6DEJKc8Iv4Q8aQEKTelAlA9
X-Google-Smtp-Source: AK7set9fl/1cc6wa8ujng9V49yloAUmhDOf2nVq6eJzq0CROTYsuJglCy4YHuHJFPVCyYIOIlPAsgApqlsyJFBNsolg=
X-Received: by 2002:a02:970d:0:b0:3c2:9ccd:a865 with SMTP id
 x13-20020a02970d000000b003c29ccda865mr2517974jai.34.1675784777600; Tue, 07
 Feb 2023 07:46:17 -0800 (PST)
MIME-Version: 1.0
References: <20230203182812.20657-1-grantseltzer@gmail.com>
 <6433db0e-5cc6-8acc-b92f-eb5e17f032d6@linux.dev> <CAO658oVRQTL8HfKFJ3X8zjYRLJCQWROjzyOcXeP=uVRML1UYOw@mail.gmail.com>
 <f2afdc22-a9c1-eaad-fab4-2ff61b409282@linux.dev>
In-Reply-To: <f2afdc22-a9c1-eaad-fab4-2ff61b409282@linux.dev>
From:   Grant Seltzer Richman <grantseltzer@gmail.com>
Date:   Tue, 7 Feb 2023 10:46:06 -0500
Message-ID: <CAO658oUUZf2eAA-hRvGm8=u9bX-g2xXxB_Vvr1b5Bg=wKX6xQw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] Add support for tracing programs in BPF_PROG_RUN
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     andrii@kernel.org, kpsingh@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 6, 2023 at 3:37 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> On 2/5/23 9:29 AM, Grant Seltzer Richman wrote:
> > On Sat, Feb 4, 2023 at 1:58 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
> >>
> >> On 2/3/23 10:28 AM, Grant Seltzer wrote:
> >>> This patch changes the behavior of how BPF_PROG_RUN treats tracing
> >>> (fentry/fexit) programs. Previously only a return value is injected
> >>> but the actual program was not run.
> >>
> >> hmm... I don't understand this. The actual program is run by attaching to the
> >> bpf_fentry_test{1,2,3...}. eg. The test in fentry_test.c
> >
> > I'm not sure what you mean. Are you saying in order to use the
> > BPF_PROG_RUN bpf syscall command the user must first attach to
> > `bpf_fentry_test1` (or any 1-8), and then execute the BPF_PROG_RUN?
>
> It is how the fentry/fexit/fmod_ret...BPF_PROG_TYPE_TRACIN_xxx prog is setup to
> run now in test_run. afaik, these tracing progs require the trampoline setup
> before calling the bpf prog, so don't understand how __bpf_prog_test_run_tracing
> will work safely.

My goal is to be able to take a bpf program of type
BPF_PROG_TYPE_TRACING and run it via BPF_PROG_TEST_RUN without having
to attach it. The motivation is testing. You can run tracing programs
but the actual program isn't run, from the users perspective the
syscall just returns 0. You can see how I'm testing this here [1].

If I understand you correctly, it's possible to do something like
this, can you give me more information on how I can and I'll be sure
to submit documentation for it?

[1] https://github.com/grantseltzer/bpf-prog-test-run/tree/main/programs

>
> A selftest will help how this will work without the traompline but may be first
> need to understand what it is trying to solve.
