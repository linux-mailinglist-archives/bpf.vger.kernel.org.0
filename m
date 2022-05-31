Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036575395E0
	for <lists+bpf@lfdr.de>; Tue, 31 May 2022 20:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346796AbiEaSHt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 May 2022 14:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343641AbiEaSHp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 May 2022 14:07:45 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82FE33354;
        Tue, 31 May 2022 11:07:43 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id jx22so28133076ejb.12;
        Tue, 31 May 2022 11:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TdEHc/Uw+inyC5GWXDZXvll7gWIHvknDeTsNyvF8rvg=;
        b=WVCzXBnrigrewUFX1bw5ZaZ6z/zutOdEWDOHMSqLNR1LeZ+9YGttJsFC4p1m2HHSJu
         2+33jRVU7lwAxFOQCHo7YyUuCnkOio+h3c7cHUQsuXxsoJyHB80uis7/NlwRW0kkDSSz
         hpqx3h0/hcM7YtB+jgZRy9wZcVyvNpUfxF60kIomXPpv7h60yhBE7V71hZ+c5M0S3fyy
         QnfYBACBqsQiq2BsXwmEDEymdN2MITKA+hcVdLmbVEVLkM2QfBWKpL/ZbMq8iEzXCxcW
         TMeHRRw5Ha67IYIOievPu32yAVDThuP8g7pH8rufNbLVRenWksEYcgeLS3FepGh5DvC7
         LmDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TdEHc/Uw+inyC5GWXDZXvll7gWIHvknDeTsNyvF8rvg=;
        b=nVaSfxaDMteT0a+3q4BEnffbEXphV8f6+AluywZHeKZzVg0CtSROf+DWczTrZ4auV5
         Zq2Ld1a4wqqRqpM+rcQ4GGcUrWGlvd1ucycXeeQCqmTy/cZtRlwdmS3UkOHXjKUrp45M
         ANU0AaJUwGM9QbwoOs0pr4CcIDtm8B/gwtkOmxK2BFtJ6jUGT81Bj5ATSGvgtdftSQL1
         2+QOBKMF0fy/QDfqXTDGWlVrFs0G2Xb0JO0Jyw6yzRPmVVr8afE+w6Avczkolja76zfs
         DNmRmZFd5mGF0PzlCgpkW/J2moToxcrXtqNe2dSiGMdc8k04Ht7621j8GfT3Mm3ig00B
         K8XA==
X-Gm-Message-State: AOAM530mq7+AedylIik5ic24tp9R/uFe3E1AmqA60iMptScuo6FccSve
        61nliFynF4wTbfsic/4pVl3BqgOYb3Vb5FxRHslQGJ4Ep30=
X-Google-Smtp-Source: ABdhPJwuMqun4m6j3HgIA2oqxhaM+PxnZAA1mMKnnvcfldyO94Iz0sVyPF1AGN+0zVl/AziZYX1vu7LHVg8hSEVmaB4=
X-Received: by 2002:a17:907:7da5:b0:6fe:d818:ee49 with SMTP id
 oz37-20020a1709077da500b006fed818ee49mr41567798ejc.58.1654020463276; Tue, 31
 May 2022 11:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1653861287.git.dxu@dxuuu.xyz> <b544771c7bce102f2a97a34e2f5e7ebbb9ea0a24.1653861287.git.dxu@dxuuu.xyz>
In-Reply-To: <b544771c7bce102f2a97a34e2f5e7ebbb9ea0a24.1653861287.git.dxu@dxuuu.xyz>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 31 May 2022 11:07:31 -0700
Message-ID: <CAADnVQL6Duc5qdwkqf+DWqYhngE3Dj-J37=7QoVA3ycFoWBU2w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf, test_run: Add PROG_TEST_RUN support to kprobe
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Sun, May 29, 2022 at 3:06 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> This commit adds PROG_TEST_RUN support to BPF_PROG_TYPE_KPROBE progs. On
> top of being generally useful for unit testing kprobe progs, this commit
> more specifically helps solve a relability problem with bpftrace BEGIN
> and END probes.
>
> BEGIN and END probes are run exactly once at the beginning and end of a
> bpftrace tracing session, respectively. bpftrace currently implements
> the probes by creating two dummy functions and attaching the BEGIN and
> END progs, if defined, to those functions and calling the dummy
> functions as appropriate. This works pretty well most of the time except
> for when distros strip symbols from bpftrace. Every now and then this
> happens and users get confused. Having PROG_TEST_RUN support will help
> solve this issue by allowing us to directly trigger uprobes from
> userspace.
>
> Admittedly, this is a pretty specific problem and could probably be
> solved other ways. However, PROG_TEST_RUN also makes unit testing more
> convenient, especially as users start building more complex tracing
> applications. So I see this as killing two birds with one stone.

bpftrace approach of uprobe-ing into BEGIN_trigger can
be solved with raw_tp prog.
"BEGIN" bpftrace's program doesn't have to be uprobe.
I can be raw_tp and prog_test_run command is
already implemented for raw_tp.

kprobe prog has pt_regs as arguments,
raw_tp has tracepoint args.
Both progs expect kernel addresses in args.
Passing 'struct pt_regs' filled with integers and non-kernel addresses
won't help to unit test bpf-kprobe programs.
There is little use in creating a dummy kprobe-bpf prog
that expects RDI to be 1 and RSI to be 2
(like selftest from patch 2 does) and running it.
We already have raw_tp with similar args and such
progs can be executed already.
Whether SEC() part says kprobe/ or raw_tp/ doesn't change
much in the prog itself.
More so raw_tp prog will work on all architectures,
whereas kprobe's pt_regs are arch specific.
So even if kprobe progs were runnable, bpftrace
should probably be using raw_tp to be arch independent.
