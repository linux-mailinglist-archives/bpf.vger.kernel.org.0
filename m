Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD6EB2AEC76
	for <lists+bpf@lfdr.de>; Wed, 11 Nov 2020 09:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgKKIzG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Nov 2020 03:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgKKIzF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Nov 2020 03:55:05 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198D6C0613D1
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2020 00:55:05 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id s8so1707898wrw.10
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2020 00:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ra6kH6CXvnZnVCGygEIu0AFfrjcGEfPgdjvBBBAYamU=;
        b=o/YUuPwZbKs6ahGsDini0uas3a/cayqbjo0RcnVoKFKgDeN4Hofq99mFt8+kp7vssT
         asXOW1Ed5KaoTegL3I2BfpCzUpKp8LRIy40oMR0/JmuHH34pR2xYDYApyBIiLh8fYfVp
         FQDK+qeu1Zrd/SN0M8s9KRq2e2sZ/BH5ENHzzskSLSWD+t6blrjobJlJ/AtCgNan1mmM
         CB7U6Z+h+0IpiKoMYptdHDwOayNRJ3Ixcx+oxVpk3y55MHDtsUbp5zW3vDn88cA8W2MF
         tYstXCvLnASsrkbVSUGajkOvFxgdnaDq7IXRnYG6zS7SuSRnkO66KmSztJFiaF4om6FZ
         jN4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ra6kH6CXvnZnVCGygEIu0AFfrjcGEfPgdjvBBBAYamU=;
        b=Vuc4MTz+qd/E8y8WAuMoRK+NNjfeK7mk2TvHPYfejAYjEfCs6QsZUAJnjqzc3hvffW
         lCNHlHsxpvA+DkC+aSQlVXDsGBCoewA/tK47LjspwPJxGlxcHxhIOE1pKLZ5BiuLFN2F
         Lr65yvvua9OaOFZFUUnleA3NefcXRbpKH9EIcU6NLQ3iph3K+05GswgBhJTnmdrFSJoc
         uxFVkzfRurnzfIaAq0/SMZDrLq3PV1ZVDn9W38vu3VFWTJrwroSg6Y22iiARl9nXKecv
         oryJZ1CeItMt23ZhQYMpzvkQ1GOGaa18sRGRxEFVXLEgr/eLt1ts70JHac0uBylaczDo
         IrOA==
X-Gm-Message-State: AOAM531y353C9Uk/ni49lc9wwqBOjVFs8y3Vv1fXxyrw39rs3VSNiSTi
        Y3ZECKHE63YNJhzPYTmPTrOYzg==
X-Google-Smtp-Source: ABdhPJzQgfAyesbskn2+A8++uEEm6okgpxc9NhHblq5w3+qxCC0vAcxOwKw535WPx8lylJy+4NE6vA==
X-Received: by 2002:adf:f304:: with SMTP id i4mr15997834wro.268.1605084903769;
        Wed, 11 Nov 2020 00:55:03 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id d63sm1709729wmd.12.2020.11.11.00.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 00:55:03 -0800 (PST)
Date:   Wed, 11 Nov 2020 09:54:45 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: Re: [PATCH bpf-next v3 2/7] tools/bpftool: Force clean of
 out-of-tree build
Message-ID: <20201111085445.GB2604446@myrica>
References: <20201110164310.2600671-1-jean-philippe@linaro.org>
 <20201110164310.2600671-3-jean-philippe@linaro.org>
 <CAEf4BzZSaEzg_v=bT_bLSFLpTxszTz-6j54WB=oHg5Zm5aD_wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZSaEzg_v=bT_bLSFLpTxszTz-6j54WB=oHg5Zm5aD_wg@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 10, 2020 at 08:57:51PM -0800, Andrii Nakryiko wrote:
> On Tue, Nov 10, 2020 at 8:46 AM Jean-Philippe Brucker
> <jean-philippe@linaro.org> wrote:
> >
> > Cleaning a partial build can fail if the output directory for libbpf
> > wasn't created:
> >
> > $ make -C tools/bpf/bpftool O=/tmp/bpf clean
> > /bin/sh: line 0: cd: /tmp/bpf/libbpf/: No such file or directory
> > tools/scripts/Makefile.include:17: *** output directory "/tmp/bpf/libbpf/" does not exist.  Stop.
> > make: *** [Makefile:36: /tmp/bpf/libbpf/libbpf.a-clean] Error 2
> >
> > As a result make never gets around to clearing the leftover objects. Add
> > the libbpf output directory as clean dependency to ensure clean always
> > succeeds (similarly to the "descend" macro). The directory is later
> > removed by the clean recipe.
> >
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> >  tools/bpf/bpftool/Makefile | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> > index f60e6ad3a1df..1358c093b812 100644
> > --- a/tools/bpf/bpftool/Makefile
> > +++ b/tools/bpf/bpftool/Makefile
> > @@ -27,11 +27,13 @@ LIBBPF = $(LIBBPF_PATH)libbpf.a
> >
> >  BPFTOOL_VERSION ?= $(shell make -rR --no-print-directory -sC ../../.. kernelversion)
> >
> > -$(LIBBPF): FORCE
> > -       $(if $(LIBBPF_OUTPUT),@mkdir -p $(LIBBPF_OUTPUT))
> > +$(LIBBPF_OUTPUT):
> > +       $(QUIET_MKDIR)mkdir -p $@
> > +
> > +$(LIBBPF): FORCE | $(LIBBPF_OUTPUT)
> >         $(Q)$(MAKE) -C $(BPF_DIR) OUTPUT=$(LIBBPF_OUTPUT) $(LIBBPF_OUTPUT)libbpf.a
> >
> > -$(LIBBPF)-clean:
> > +$(LIBBPF)-clean: $(LIBBPF_OUTPUT)
> 
> shouldn't this be `| $(LIBBPF_OUTPUT)` ?

It wouldn't have any effect here. Order-only prerequisites tell make to
only build the prerequisite before the target, but not to update the
target if the prerequisite was updated. Because $(LIBBPF)-clean is not a
file, the recipe is always run and adding the | doesn't make a difference.

Thanks,
Jean
