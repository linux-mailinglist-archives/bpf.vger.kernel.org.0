Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89C15F1614
	for <lists+bpf@lfdr.de>; Sat,  1 Oct 2022 00:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbiI3WZ6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Sep 2022 18:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbiI3WZo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Sep 2022 18:25:44 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947DFC6962;
        Fri, 30 Sep 2022 15:25:43 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id e18so7713173edj.3;
        Fri, 30 Sep 2022 15:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XSB2fgyM7mwVlglUIENBxNasqUhFjmrYfDkQjbr4j8w=;
        b=IE2kpqaFyz3n9bL5USI7d0A8Dk+IbQxHxoiXT/PgY+dDDJQnrTaL1/MnCWMPi2aYku
         koYDeuXfM9X1zNqh3dUjLCCNSmd3JyxxsosVAjsB6RTH2tMOy0i+hGGWouH6WWpsBhZw
         o4FCsVhYZiZRiljwPULzV4gmWTLD/3Skv4io1nmB0/iJ2ndqk9bzy5+rptMnQX/gh/hr
         a6IFW96Tuzpqghm36zhwCk/EC1kzigQ2WG2SFq0j1FAPSKC625MDowRcStb+LOxc/WAI
         GK3uJ4vagpku+Or2qxl2SF0ePkDfXzyAfGHj9rm9/be8cSV8P9iEn0ulRHRzu+MYs7/8
         A3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XSB2fgyM7mwVlglUIENBxNasqUhFjmrYfDkQjbr4j8w=;
        b=vPevTsv4M2O1gFtI/fMQZ87VwZuR+h+OqMNdmiNbOVKBrK2nP4xy3Ct8IKXX2CrTDc
         7o6B18nv2fMq3hU5OE7w+22HSajZM40PAmFeDYlbKabGe0+N6MgpidsnCz4ABTCT+/0j
         W24FgZw2WgNuiCsK9ji1x/hI+kOZzcb0Tjo85IWpH1qtNFvYxaivLxvZeAEQe3uOjiDI
         066hpJj2x9BhlJ9RZyb8/JcCIP+0HwJef6ds2CnCL4MVTO1m4Xj8A6Hipssy4V3V3X6i
         3bF/jDfTAIkXrdaGLv8GmIPIUG+SAYxI+OJWI6fexPb2QXrQSgCeGtZ5xM8GoMC0DUlZ
         ATVQ==
X-Gm-Message-State: ACrzQf1MI7JhqTeMlkUie/1Gs31VuzJ0pbVSg5GJy4Hq7qYbCCrnQxaN
        TpiyKtnRapS0in2pC0rdNRAnCcSKRv+KkWgBDgkEcanr
X-Google-Smtp-Source: AMsMyM4QZDO+CkV5kLgWMbGQrIZIdEFKYCdjz/MPBAkK3wH/j8CkVxIIxNappnmw2xyqoRBwZBFgMzeMEBUidaMdSDs=
X-Received: by 2002:a05:6402:3603:b0:451:fdda:dddd with SMTP id
 el3-20020a056402360300b00451fddaddddmr9177305edb.81.1664576741982; Fri, 30
 Sep 2022 15:25:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220922115257.99815-1-donald.hunter@gmail.com>
 <20220922115257.99815-2-donald.hunter@gmail.com> <87tu4zsfse.fsf@meer.lwn.net>
 <m2h70y87eh.fsf@gmail.com> <m2wn9l6v7e.fsf@gmail.com>
In-Reply-To: <m2wn9l6v7e.fsf@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 30 Sep 2022 15:25:30 -0700
Message-ID: <CAEf4Bzb8f+Oy5okz38yq+Vm0Pse5gMbWwWrj+6d8-BDaCtHJKg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] Add subdir support to Documentation makefile
To:     Donald Hunter <donald.hunter@gmail.com>,
        grantseltzer <grantseltzer@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org
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

On Fri, Sep 30, 2022 at 2:58 AM Donald Hunter <donald.hunter@gmail.com> wrote:
>
> Donald Hunter <donald.hunter@gmail.com> writes:
>
> > Jonathan Corbet <corbet@lwn.net> writes:
> >
> >> Beyond that, I would *really* like to see more use of Sphinx extensions
> >> for this kind of special-case build rather than hacking in more
> >> special-purpose scripts.  Is there a reason why it couldn't be done that
> >> way?
> >
> > I looked at writing the BPF program types as a Sphinx extension but
> > found that approach problematic for the following reasons:
> >
> > - This needs to run both in the kernel tree and the libbpf Github
> >   project. The tree layouts are different so the relative paths to
> >   source files are different. I don't see an elegant way to handle this
> >   inline in a .rst file. This can easily be handled in Makefiles
> >   that are specific to each project.
> >
> > - It makes use of csv-table which does all the heavy lifting to produce
> >   the desired output.
> >
> > - I have zero experience of extending Sphinx.
> >
> > I thought about submitting this directly to the libbpf Github project
> > and then just linking from the kernel docs to the page about program
> > types in the libbpf project docs. But I think it is preferable to master
> > the gen-bpf-progtypes.sh script in the kernel tree where it can be
> > maintained in the same repo as the libbpf.c source file it parses.
>
> Given the pushback on Makefile changes and the need for this patch to be
> compatible with both the kernel tree and the libbpf repo, can I suggest
> a pragmatic way forward.
>
> I suggest that I drop the gen-bpf-progtypes.sh script and Makefile

It's way too easy to forget to update this table when adding new
program type support in libbpf. So if possible I think script is the
way to go.

Jonathan, given the script is really minimal and allows to keep
documentation in sync with libbpf source code, do you have a strong
objection? Writing a custom plugin seems like a too high bar for
something pretty straightforward like this?

Also, should this be routed through your tree or you'd like us to take
it through bpf-next tree?


Donald, if Jonathan is feeling really strongly, then I guess manually
generated table is ok approach as well, but let's hear from Jonathan
first.

Also cc Grant about logistics of kernel vs libbpf docs.


> changes from the patchset and just submit static documentation contents
> for the table of BPF program types. This would avoid any downstream
> breakage when syncing from the kernel tree to the libbpf github
> repo. The table of BPF program types can be maintained manually which
> should not be a burden going forward. Another benefit would be that the
> resulting documentation can be curated more easily than if it were
> auto-generated.
