Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889836ADCC6
	for <lists+bpf@lfdr.de>; Tue,  7 Mar 2023 12:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjCGLGD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 06:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbjCGLFL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 06:05:11 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA377D0B1
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 03:02:29 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id ce8-20020a17090aff0800b0023a61cff2c6so1358632pjb.0
        for <bpf@vger.kernel.org>; Tue, 07 Mar 2023 03:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678186909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JKgMKmj9fxNW4q/ffaedYBUPNR5kD3itB1lqEnw62og=;
        b=Wr/wDIGdDy3Vs1to6xJHLNER6aV51mgsjl9zaWCBB6P4sRbVUCOVqZn8YSy0qUtzd0
         xhsFbZwMKCiES7buzfQXxp3giJJJ1H03UlDXFVJ9Im7VU4N21pFb3KGortRtF58d00xM
         Ydw+YSLWT6XL5I9km9AfiR5qU0h63JUSl/oZUNjAZzxfhpN4I5XkugQB6vjekfe3vb5A
         lZlf3phggl5noo6U+/N5xK002OL5lubEUvejSQigcCpuKgyJY8dTIFhLprL6Mu3joSVg
         BlVpwTh/E+OeB6p0Lep7/Vl8i5ZZfC/tLXIsyb7eccwiKucIWiqCxVHJ/6N8egVhrL7g
         JHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678186909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JKgMKmj9fxNW4q/ffaedYBUPNR5kD3itB1lqEnw62og=;
        b=WxG0NWRHZIEJkGVZSiqTTh1ky+i4Jx+rjJR6DhjMUB+2X5wC4r05GTlmV7tp+pk0S9
         Svy9n0GG6LJeGDcL4asV1ayK0Z5/jusi2E1zVpBYSYk0FXtZ0dJFHQFbTFItRu7qlXNL
         piPofLVMJ5jL/NSr6/nRkCtobxJCc6gnXjz671txIV/PLtwpK8UJ6l0pMHXqZMZcu0Wi
         XG5hdpZWXgelrKcyV0UibmX/hC7wf7daeX8WrpXAJEQM+chxdd5buX7gcRuO+6UCqT0j
         NNGpeLmpIz3AEjOK9S297SXo19jesQiUt6qGL0VU5YGjOGFPKDFf2e0lzhObAwMmVXmE
         roog==
X-Gm-Message-State: AO0yUKUPMLQfYq1gB+8JYdz3jpPS8D5VvOWXPX6ACJ5vJsexnbJNjQN5
        Uj9JpdGjfBwr1mu6RwXdjdhd8U++hPmjuG2vYqa4eBlyz0kNPmPf
X-Google-Smtp-Source: AK7set/ir3LQnxWNYHND0W1JshXWg0NcsA9BSmXQkCopsPhVuGYUOi7AnK4y012o3gvJ+9TDnUoHddlsXMnxVMljDPY=
X-Received: by 2002:a17:902:ef8a:b0:19a:9434:af24 with SMTP id
 iz10-20020a170902ef8a00b0019a9434af24mr5558367plb.10.1678186908965; Tue, 07
 Mar 2023 03:01:48 -0800 (PST)
MIME-Version: 1.0
References: <CAJxriS2W9S7xQC-gVPSAAkfim5EBfQhKBSLzYaq6EyOAWG-sCQ@mail.gmail.com>
 <d62f77e9-bd0d-9461-63e5-f9dfb6d19a5d@oracle.com>
In-Reply-To: <d62f77e9-bd0d-9461-63e5-f9dfb6d19a5d@oracle.com>
From:   Dominic <d.dropify@gmail.com>
Date:   Tue, 7 Mar 2023 16:31:37 +0530
Message-ID: <CAJxriS0epJmsN+VPOOFAQfq3dFhXFEsNXqYHr8r+HWyj_-cjaA@mail.gmail.com>
Subject: Re: Selectively delay loading of eBPF program.
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     bpf@vger.kernel.org
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

Thanks for the reply Alan.

One of the eBPF program needs to attach to the TC qdisc. If the
associated userspace program gets killed (for whatever reason), the
eBPF program attached to TC will continue to be loaded & attached.
When the userspace program restarts, it will load the required eBPF TC
program only if not already loaded. (But it will load all others that
were attached to lets say tracepoint).

This can be achieved by bpf_program__set_autoload() but that requires
all the logic to decide which program to load and skip at one place. I
was looking at a way for each component to make its own decision and
load only its own set of programs. Another option is to have two
seperate skeleton files.

Thanks & Regards,
Dominic

On Tue, Mar 7, 2023 at 3:46=E2=80=AFPM Alan Maguire <alan.maguire@oracle.co=
m> wrote:
>
> On 07/03/2023 09:52, Dominic wrote:
> > Hi, I have multiple eBPF programs compiled into a single skeleton file
> > and I need a way to delay loading of one of the programs.
> >
> > I am aware of `bpf_program__set_autoload()` API but once an object is
> > loaded using `bpf_object__load()`, there are no APIs to selectively
> > load a program (bpf_prog_load() has been deprecated). Calling
> > bpf_object__load() again fails.
> >
> > Wondering if there are any options to achieve the above mentioned behav=
ior.
> >
>
> I ran into a similar problem recently; in my case, the problem
> was that one of the functions that one of my BPF programs attached
> to could be inlined on some kernel versions.  As a result the
> whole skeleton would fail on auto-attach. If that is the
> problem you are facing, you can try a full load/attach and
> if that fails, start again - you'll need to destroy the
> skeleton and go back to the open if I remember correctly -
> and mark the problematic program using bpf_program__set_autoload()
> to false the second time round.
>
> Failing that, is separating into two skeletons and using
> bpf_map__reuse_fd() to share fds across both skeletons
> feasible?
>
> If not, can you provide more details on why the delayed load
> is required - that might help us figure out a solution. One
> thing to figure out - is it definitely delayed load you need,
> or just delayed attach? Thanks!
>
> Alan
>
> > Thanks & Regards,
> > Dominic
