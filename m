Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6792AF7D6
	for <lists+bpf@lfdr.de>; Wed, 11 Nov 2020 19:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgKKSWx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Nov 2020 13:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgKKSWx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Nov 2020 13:22:53 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE626C0613D1
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2020 10:22:52 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id c129so2778118yba.8
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2020 10:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=El5Hx0zxVy9enL6a+sfGB4GoJYxxkpnGG8szmKjKFQY=;
        b=QEVV/OfPwOHXxxq4rFyU92RnM/oBP0TQ+i7wQt84Lf+Zdu4xnwahrLCe+O0aUD9UZB
         42VLrFl4SLkXVKOn6VZ/ouJ1EmrLZRMq0knRNfaCgfougcvLUIYGKq9OMsHrAnIuQNkZ
         wWHuHwYgeFybDWyJaKy030ORST/82OZRdU3SUrv9tOgy94SIYq5tq/VIFL/IPG37YhN/
         pZXvE8zf2s5Wlc7pYVkOy2x8sQ1e3dRExBaZ9Px3KPlHNnTEf+wc+8374pfe4p9QwP75
         W2gXMIPJLNHRdrcD+ivkiUE7Rv4U85Tdlw2iOecm74L1qmZLXAVzHHjUZGgv2Zqu9toR
         4LwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=El5Hx0zxVy9enL6a+sfGB4GoJYxxkpnGG8szmKjKFQY=;
        b=uhDxLYCSZl00ZyueGXdItvl6S4ILUyv8G7NYh393lQjbRvtfo4bB0WY/oZ1BliKqjM
         SFLshjULg3UXw+5X5xSscfVnTNoRt1YinB4/4KhSsGi3pLf2lr6qrRyj4yBfecrzjh+W
         YZkfCXTFgRRQIsQHSBjx5Wu59v+y+Q3nfCGrJvA83XSXyOms+wuv44BBcesekH9jGdYz
         wBNhdCxr+VCRoVOmuZpRS3eTy2ihA4Wj0FUFT/0G6i8jhNEa0F3XvSzS8uAOknnz9OZy
         moQ6BjJPCOs4OqzoruRQeflj4noJoo62EUv+4oCL4xAgjAzwEclXSawCJ0iseu3RRuyE
         ItXA==
X-Gm-Message-State: AOAM533Y4x2M8ouCs4F8oANbbWA6QFB5v9PTwePnVmYFn/CFCvBgH0WP
        rkY1/XWWlz5cHX/7fn+qzYCkMxrpT37+LBJ2vbc=
X-Google-Smtp-Source: ABdhPJwnylSv4dtERIDsVhkRSh/AE8kpyMsgWYsL4pXWMn2PjVvz1SI76b0LVowFac1F6SpadiihcMPK7TVuxIVekWI=
X-Received: by 2002:a25:3d7:: with SMTP id 206mr23262882ybd.27.1605118972127;
 Wed, 11 Nov 2020 10:22:52 -0800 (PST)
MIME-Version: 1.0
References: <20201110164310.2600671-1-jean-philippe@linaro.org>
 <20201110164310.2600671-3-jean-philippe@linaro.org> <CAEf4BzZSaEzg_v=bT_bLSFLpTxszTz-6j54WB=oHg5Zm5aD_wg@mail.gmail.com>
 <20201111085445.GB2604446@myrica>
In-Reply-To: <20201111085445.GB2604446@myrica>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 11 Nov 2020 10:22:41 -0800
Message-ID: <CAEf4BzZqiFeLVYq-X7Z7cypRYSgLFw3dr=-EEoyzWaDJVFfzug@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/7] tools/bpftool: Force clean of out-of-tree build
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

On Wed, Nov 11, 2020 at 12:55 AM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> On Tue, Nov 10, 2020 at 08:57:51PM -0800, Andrii Nakryiko wrote:
> > On Tue, Nov 10, 2020 at 8:46 AM Jean-Philippe Brucker
> > <jean-philippe@linaro.org> wrote:
> > >
> > > Cleaning a partial build can fail if the output directory for libbpf
> > > wasn't created:
> > >
> > > $ make -C tools/bpf/bpftool O=/tmp/bpf clean
> > > /bin/sh: line 0: cd: /tmp/bpf/libbpf/: No such file or directory
> > > tools/scripts/Makefile.include:17: *** output directory "/tmp/bpf/libbpf/" does not exist.  Stop.
> > > make: *** [Makefile:36: /tmp/bpf/libbpf/libbpf.a-clean] Error 2
> > >
> > > As a result make never gets around to clearing the leftover objects. Add
> > > the libbpf output directory as clean dependency to ensure clean always
> > > succeeds (similarly to the "descend" macro). The directory is later
> > > removed by the clean recipe.
> > >
> > > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > ---
> > >  tools/bpf/bpftool/Makefile | 8 +++++---
> > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> > > index f60e6ad3a1df..1358c093b812 100644
> > > --- a/tools/bpf/bpftool/Makefile
> > > +++ b/tools/bpf/bpftool/Makefile
> > > @@ -27,11 +27,13 @@ LIBBPF = $(LIBBPF_PATH)libbpf.a
> > >
> > >  BPFTOOL_VERSION ?= $(shell make -rR --no-print-directory -sC ../../.. kernelversion)
> > >
> > > -$(LIBBPF): FORCE
> > > -       $(if $(LIBBPF_OUTPUT),@mkdir -p $(LIBBPF_OUTPUT))
> > > +$(LIBBPF_OUTPUT):
> > > +       $(QUIET_MKDIR)mkdir -p $@
> > > +
> > > +$(LIBBPF): FORCE | $(LIBBPF_OUTPUT)
> > >         $(Q)$(MAKE) -C $(BPF_DIR) OUTPUT=$(LIBBPF_OUTPUT) $(LIBBPF_OUTPUT)libbpf.a
> > >
> > > -$(LIBBPF)-clean:
> > > +$(LIBBPF)-clean: $(LIBBPF_OUTPUT)
> >
> > shouldn't this be `| $(LIBBPF_OUTPUT)` ?
>
> It wouldn't have any effect here. Order-only prerequisites tell make to
> only build the prerequisite before the target, but not to update the
> target if the prerequisite was updated. Because $(LIBBPF)-clean is not a
> file, the recipe is always run and adding the | doesn't make a difference.

I know. I wanted it just for consistency, because everything after |
means "make sure it's completed, but it's not my direct input". But
I'm ok either way, it's not that important. Also $(LIBBPF)-clean and
$(LIBBPF_BOOTSTRAP)-clean should be .PHONY targets, but then again in
practice won't matter, because unlikely that we'll have such files.
Would be nice to follow up with a fix, but I'll apply your patch set
as is.

>
> Thanks,
> Jean
