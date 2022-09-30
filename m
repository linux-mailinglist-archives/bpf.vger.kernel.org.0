Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A84E5F15EB
	for <lists+bpf@lfdr.de>; Sat,  1 Oct 2022 00:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbiI3WPL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Sep 2022 18:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbiI3WPI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Sep 2022 18:15:08 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830BA62AB0
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 15:15:04 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 29so7672069edv.7
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 15:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jbA/4W5FrMgfYA4qtVlgBy0v5lHc1QWLmOPlU0GBkHs=;
        b=gSJOOb1nJhSXR5vDWHvTcWNMU+AYmuThphXzwSPvBdJKIxlRS6IFcw4cvEMQdGuPC7
         PziaExOihobda0Ze1aBLiNCNNuqST2S7UxLEOUq/rWd4C3x/5cmVjgQi0+BUmeVMGUxA
         n9EB/Eg1bBYDCxUIqSDwHTI8VwKhDWsaxPWevwge0ywo2lEt5UsS0ZI1SrZqQkop3Osx
         FSRYJLpA781u7Bw8MnAp9qZzmWNQOZNIl+cQVJveH3cnC7C1uYFzPzD26p7DWmVkXYJ/
         HdroG+YtOS5FjSv1hdCq85NPLNSIfJ+W7n1/wzbKbonvM6etwk1DmsNaYc17mSayYE+9
         Pf+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jbA/4W5FrMgfYA4qtVlgBy0v5lHc1QWLmOPlU0GBkHs=;
        b=t+UEdIC7dc9VRIuUaaZzyLq2I1qJwZUeX/xK6m46I8R9VF7Hte0escmD39vFPp3f81
         qSOkiAH109BlYaS8IQHQz8nJ46MOTkXA027ix7jPk07JLUMk7Z0gGs4B/0YMmAE4Znfd
         ZRUEFPnoRndp1Inrz/vFOMky5AeoYR5ngaP1DTVzf9p2m63o6CwR4HMLiiCzahUgTr3H
         7G1DbY3pPFqUIbRkWbn2UzUmSSPScAgc4sVO9ObqCc4nq6EL3HueASue2gOm6RaJmbfu
         yzmg+VAm8aZEpMg0UUn//tvOFQXvBcOX0kG9JrWL7GfJPoRN+gZYJHlP3+wjEb6A8kKI
         CQWw==
X-Gm-Message-State: ACrzQf138n84GyBqlIB9U3wWpaNux9D+chAnPt1Wepbbd1Fm8VM5DbM9
        AwxTH1f3oFkIvAMe3KivzqJgdxR9vnH4+A06hfS9upHl03s=
X-Google-Smtp-Source: AMsMyM4O9EDwk9wKmBfJYtdesYgCXRy1sWVEubmcFJ54u/62yAShe/PPYorAm4r/eU99um2eV9tfj4jbrjVIyo4bs2E=
X-Received: by 2002:a05:6402:5406:b0:452:1560:f9d4 with SMTP id
 ev6-20020a056402540600b004521560f9d4mr9560808edb.333.1664576102801; Fri, 30
 Sep 2022 15:15:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAP-VjpyJxPNJ0438FbxEWxNbyL7zsCFwrEt6Tzw-vHz0ZQHxmg@mail.gmail.com>
 <CAP-Vjpzqw=_t61tyJ7SPCLHresuX7XXv2gyQgO8NW1p5dNsViQ@mail.gmail.com>
 <63365039486df_233df208aa@john.notmuch> <CAP-VjpyWM6dtyPfWJNrx79Q8WEWKLYL1gRjZwyP+NJdoy3bnjw@mail.gmail.com>
In-Reply-To: <CAP-VjpyWM6dtyPfWJNrx79Q8WEWKLYL1gRjZwyP+NJdoy3bnjw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 30 Sep 2022 15:14:50 -0700
Message-ID: <CAEf4Bza9gVfBZLFH4EHzBEhVTymHTsASUMx42cUWTf5cAOA3tw@mail.gmail.com>
Subject: Re: Fwd: bpf syscall failing on aarch64 with "Invalid argument"
 (Asahi Linux on M1)
To:     Owayss Kabtoul <owayssk@gmail.com>
Cc:     John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
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

On Fri, Sep 30, 2022 at 1:01 AM Owayss Kabtoul <owayssk@gmail.com> wrote:
>
> Hello John.
>
> The "minimal" program in question is the one from:
> https://github.com/libbpf/libbpf-bootstrap/blob/bc186797086bee39769e3f24bcccf292a94cdcb7/examples/c/minimal.c
>

Please don't top-post in kernel mailing lists, reply inline instead.

>
> On Fri, Sep 30, 2022 at 4:11 AM John Fastabend <john.fastabend@gmail.com> wrote:
> >
> > Owayss Kabtoul wrote:
> > > Hello.
> > >
> > > I have built libbpf from source (a7c0f7e). When running any of the
> > > provided examples, the bpf syscall fails with "Invalid argument":
> > >
> > > ```
> > > $ sudo strace ./minimal
> >
> > Could you post the minimal C code. Its likely easier to read than
> > trying to parse the strace output. Sure we could probably figure
> > it out from strace but lets go the easier route.
> >
> > Caveat I didn't bother to try and read the strace.
> >

:) I did bother a bit, it looks like maps are created, and trivial
SOCKET_FILTER prog is created successfully as well. So BPF is at least
minimally enabled.

But do check CONFIG_BPF_EVENTS=y in your kernel config, it seems to be
the requirement for bpf_trace_printk() BPF helper used from
bpf_printk() macro.


> > Thanks,
> > John
