Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9F82AF7DA
	for <lists+bpf@lfdr.de>; Wed, 11 Nov 2020 19:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgKKSYE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Nov 2020 13:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbgKKSYE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Nov 2020 13:24:04 -0500
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8F4C0613D1
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2020 10:24:03 -0800 (PST)
Received: by mail-yb1-xb42.google.com with SMTP id 10so2766089ybx.9
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2020 10:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0vb4hMeKAcY/qNUqVzHIkyMn/WFCVV7Hzb20dOrNP+Q=;
        b=UDoPEzSgXHTSmLgel1/g/FJ8jJPk0jxL97A2ejdr9wxr3d1B8Ial5q++WvfLYvy1uP
         J+XqJx1rqS6ge6vpSwHWeHEGelLcXZ8afqBo2FLbbVLObslKXllqQovmXD0g9iCvFq4Q
         MFRkpajYOuZg+D4UcnLlyF+P98eUTuFavKl+TEC4ixwyXThmu1Ee8CUPN+XDiqL6QK+7
         rTDan7K4qBgtX/aZQpu8n1rQR+m7LNv65nHBSRfP0n0IPjNJGoMC7OlmqoaOkQKQ/RUT
         kBa6yhuuftZppAD2tNcTkRKSMe4mAfyGcOKlGODp0t0QImrA60HfIta9/dVwZxRe20zA
         RVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0vb4hMeKAcY/qNUqVzHIkyMn/WFCVV7Hzb20dOrNP+Q=;
        b=TRmgub2xS5DZnuiEwV6cOWll09iEit5ZTQfYjlU/6pWQnAwPZSfihA2gkyf2qIaZzS
         80gQ/hGswO7os+H1CqYH08kART81rO7cZf/DjMkm17YEBfoiIBHE0F33FwELi/JsAQQH
         L14jkPhCutvsq2SJTqLVhEeJksTWPeVyoQfYds4VHE7WiBEb0r8wkwXE/LeaXfIpBX18
         YsbFsG3m19kD5cWtogeQSHICfaOyR40kkAXLn+dUqhUGDx99UXYsVtJX1tzZG527NonH
         ua/PTutuYaM/hSo0Qqa4+ga2G7DSEzB3NSHngdNhEuL9JWkRFAowRO3+G1qDajlCKXwZ
         DXFg==
X-Gm-Message-State: AOAM530pj5QrdOm4Q8WGSSoiOiMxdrB3QqnwPV2nwg6jaXahpkoLZQ+e
        Jwvl4MCaYK0RPhD+Pygq/CpcbsjqV7y/BUOhznM=
X-Google-Smtp-Source: ABdhPJxZ7+aiRs8uk53RlO99+L2JBjuYPgFEqQIpt9V4WR3z/ghKJBcnrCyRQwWc1CZwMx2LDQ+YPcC7peKiEenK0eo=
X-Received: by 2002:a25:df82:: with SMTP id w124mr7733112ybg.347.1605119043304;
 Wed, 11 Nov 2020 10:24:03 -0800 (PST)
MIME-Version: 1.0
References: <20201110164310.2600671-1-jean-philippe@linaro.org>
 <20201110164310.2600671-6-jean-philippe@linaro.org> <CAEf4BzYs998tBbeSAkoSvw1bYCnx7sG9s2gat=rNHsdUprrfjg@mail.gmail.com>
 <20201111085345.GA2604446@myrica>
In-Reply-To: <20201111085345.GA2604446@myrica>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 11 Nov 2020 10:23:52 -0800
Message-ID: <CAEf4BzYbrxDi12Xz=Ti=CRxU5WGpwfJfCXUJ9JtYzRdu2=84Cw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 5/7] tools/runqslower: Enable out-of-tree build
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 11, 2020 at 12:54 AM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> On Tue, Nov 10, 2020 at 09:11:05PM -0800, Andrii Nakryiko wrote:
> > On Tue, Nov 10, 2020 at 8:46 AM Jean-Philippe Brucker
> > <jean-philippe@linaro.org> wrote:
> > >
> > > Enable out-of-tree build for runqslower. Only set OUTPUT=.output if it
> > > wasn't already set by the user.
> > >
> > > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > ---
> > > v3:
> > > * Drop clean recipe for bpftool and libbpf, since the whole output
> > >   directories are removed by the clean recipe.
> > > * Use ?= for $(OUTPUT)
> > > ---
> > >  tools/bpf/runqslower/Makefile | 32 ++++++++++++++++++--------------
> > >  1 file changed, 18 insertions(+), 14 deletions(-)
> > >
> >
> > [...]
> >
> > >  clean:
> > >         $(call QUIET_CLEAN, runqslower)
> > > -       $(Q)rm -rf $(OUTPUT) runqslower
> > > +       $(Q)$(RM) -r $(BPFOBJ_OUTPUT) $(BPFTOOL_OUTPUT)
> > > +       $(Q)$(RM) $(OUTPUT)*.o $(OUTPUT)*.d
> > > +       $(Q)$(RM) $(OUTPUT)*.skel.h $(OUTPUT)vmlinux.h
> > > +       $(Q)$(RM) $(OUTPUT)runqslower
> > > +       $(Q)$(RM) -r .output
> >
> > hard-coding .output here doesn't seem right, didn't all the other
> > lines clean up everything already?
>
> Yes, but to clean the source tree, the .output directory needs to be
> removed. On the other hand when $(OUTPUT) is out-of-tree, we only want to
> remove its content but not the dir itself, because it was created by the
> user.

Right, this is fine.

>
> Thanks,
> Jean
>
> >
> > >
> > >  $(OUTPUT)/runqslower: $(OUTPUT)/runqslower.o $(BPFOBJ)
> > >         $(QUIET_LINK)$(CC) $(CFLAGS) $^ -lelf -lz -o $@
> > > @@ -59,8 +65,8 @@ $(OUTPUT)/%.bpf.o: %.bpf.c $(BPFOBJ) | $(OUTPUT)
> > >  $(OUTPUT)/%.o: %.c | $(OUTPUT)
> > >         $(QUIET_CC)$(CC) $(CFLAGS) $(INCLUDES) -c $(filter %.c,$^) -o $@
> > >
> >
> > [...]
