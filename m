Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE716AFAE3
	for <lists+bpf@lfdr.de>; Wed,  8 Mar 2023 01:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjCHAK6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 19:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjCHAK5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 19:10:57 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD25AE136
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 16:10:56 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id i34so59303526eda.7
        for <bpf@vger.kernel.org>; Tue, 07 Mar 2023 16:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678234254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UD1UnmLS/m8vXi5OpwbvtCSOUAm4JmGfyLcI8DA0Cgg=;
        b=QatzbV40Iu7sUovWbnfI4Zj88pZQkT2NX6a4Kk6lF5/WKf7Eu5COZX6jfZp1dY821y
         QaNSbpTO+Imn8XzBt1vHHblMZ5RRd2MggybsJzp0QyvpP6eHU/JyNdkP3hA8vBtN0HKM
         2WMb87K39BoamFJUujjjrLn25GVwMkumNQ7oiuYFb10F8CzPvDkfTtI1sKh73gStdeXj
         F3Y7nUo9f7xUCqyhVDkc8buKOHQEfCvPWEHKBfLY56SL4yKc6LAudOlWYrE9QSc4b5Ju
         7SCV1bRd51oyovGNwKzc2eMYWEZh3SYh4vUGTWp7zQ1AB/gzyiMu+oSwlTVrk8NDq+5W
         pVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678234254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UD1UnmLS/m8vXi5OpwbvtCSOUAm4JmGfyLcI8DA0Cgg=;
        b=7CQsh7Vzs03hjp3eJIoKcFiQIusBEfu/hJqfBoi5ChvrUq1gvSgUUJf79Jdyp2nt4j
         7XZvUjxHHyNnUzxRssAI+Hl03Gw6xA+edQy//RQ32ix4V13nmp+C0knE2qC4NREPxYBG
         tVqd3CM6NN8wTB1ajufv/fhPFkBwrfDTrB1nQrsiqmBRjsuMvA5r1n2Lkm1Gbhoexqle
         oCpye5LZ+bnSsTgTbB1R82iWcGXo1Um5Hq7dLQyprT9nn9vjobfEX+VEb9TGsPBclaro
         d0Q0ONj0I+4AKbbiY0t6ucMmIC0e8IrtKvjXyCtafKiDsD6GdSEKGi4+yL9nW1OOWYda
         7fUA==
X-Gm-Message-State: AO0yUKWuL6NmYxWuGIW1bfKsm4fUlvADT1S5+NdizsY1xMp7YZaZGQUZ
        DymJWrSpdUB1ddDyqopPxSgxKyMvK5U+4AuCLzU=
X-Google-Smtp-Source: AK7set9LWKBBzC7NJK17DK1LHx/ol2qaHDZ+VQ3Os63fYXfDuYWa2gleLTg2pB6b2tpQsbBNWEKZ5GY+6Y/2WlMU0Qw=
X-Received: by 2002:a17:906:2adb:b0:8de:c6a6:5134 with SMTP id
 m27-20020a1709062adb00b008dec6a65134mr7287567eje.15.1678234254455; Tue, 07
 Mar 2023 16:10:54 -0800 (PST)
MIME-Version: 1.0
References: <CAJxriS2W9S7xQC-gVPSAAkfim5EBfQhKBSLzYaq6EyOAWG-sCQ@mail.gmail.com>
 <d62f77e9-bd0d-9461-63e5-f9dfb6d19a5d@oracle.com> <CAJxriS0epJmsN+VPOOFAQfq3dFhXFEsNXqYHr8r+HWyj_-cjaA@mail.gmail.com>
In-Reply-To: <CAJxriS0epJmsN+VPOOFAQfq3dFhXFEsNXqYHr8r+HWyj_-cjaA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 7 Mar 2023 16:10:42 -0800
Message-ID: <CAEf4BzbQLLq+hSHXmw8M_yg=wvDu1PT9cshuoc39+wiM1dEDBQ@mail.gmail.com>
Subject: Re: Selectively delay loading of eBPF program.
To:     Dominic <d.dropify@gmail.com>
Cc:     Alan Maguire <alan.maguire@oracle.com>, bpf@vger.kernel.org
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

On Tue, Mar 7, 2023 at 3:07=E2=80=AFAM Dominic <d.dropify@gmail.com> wrote:
>
> Thanks for the reply Alan.
>
> One of the eBPF program needs to attach to the TC qdisc. If the
> associated userspace program gets killed (for whatever reason), the
> eBPF program attached to TC will continue to be loaded & attached.
> When the userspace program restarts, it will load the required eBPF TC
> program only if not already loaded. (But it will load all others that
> were attached to lets say tracepoint).
>
> This can be achieved by bpf_program__set_autoload() but that requires
> all the logic to decide which program to load and skip at one place. I
> was looking at a way for each component to make its own decision and
> load only its own set of programs. Another option is to have two
> seperate skeleton files.
>

please don't top post on the mailing list

As for your question, libbpf currently doesn't support loading
individual programs after bpf_object (or skeleton for that matter) was
loaded. This might change in the future, but for now this is the
approach we stick to.

I'd try to organize code such that decision about what needs to be
loaded was done before bpf_object__load(), even if it's done across
multiple components (can you poll each of them somehow?)


> Thanks & Regards,
> Dominic
>
> On Tue, Mar 7, 2023 at 3:46=E2=80=AFPM Alan Maguire <alan.maguire@oracle.=
com> wrote:
> >
> > On 07/03/2023 09:52, Dominic wrote:
> > > Hi, I have multiple eBPF programs compiled into a single skeleton fil=
e
> > > and I need a way to delay loading of one of the programs.
> > >
> > > I am aware of `bpf_program__set_autoload()` API but once an object is
> > > loaded using `bpf_object__load()`, there are no APIs to selectively
> > > load a program (bpf_prog_load() has been deprecated). Calling
> > > bpf_object__load() again fails.
> > >
> > > Wondering if there are any options to achieve the above mentioned beh=
avior.
> > >
> >
> > I ran into a similar problem recently; in my case, the problem
> > was that one of the functions that one of my BPF programs attached
> > to could be inlined on some kernel versions.  As a result the
> > whole skeleton would fail on auto-attach. If that is the
> > problem you are facing, you can try a full load/attach and
> > if that fails, start again - you'll need to destroy the
> > skeleton and go back to the open if I remember correctly -
> > and mark the problematic program using bpf_program__set_autoload()
> > to false the second time round.
> >
> > Failing that, is separating into two skeletons and using
> > bpf_map__reuse_fd() to share fds across both skeletons
> > feasible?
> >
> > If not, can you provide more details on why the delayed load
> > is required - that might help us figure out a solution. One
> > thing to figure out - is it definitely delayed load you need,
> > or just delayed attach? Thanks!
> >
> > Alan
> >
> > > Thanks & Regards,
> > > Dominic
