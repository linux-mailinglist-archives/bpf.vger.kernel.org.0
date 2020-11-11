Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF612AEC73
	for <lists+bpf@lfdr.de>; Wed, 11 Nov 2020 09:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbgKKIyG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Nov 2020 03:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgKKIyG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Nov 2020 03:54:06 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A4FC0613D1
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2020 00:54:05 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id a3so1545683wmb.5
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2020 00:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zGlkTt93I56FdkfoMWlIYd8INgxOMR6w9olDOSzQtFA=;
        b=nDTkeJSLe6040mcz9hr+xl5Yxok/PwHwWHUxF1pXAXNlsgDEBVhXCCyG22DgUzVbVa
         fJVVfs3d687QHikIp6YlwjyZMhty09Lfrg1/ecsh3AtVRPjBq22b2vpL/J4YDkHryivV
         HltX5mLuyW0gNJ0Kw3yFa2SocrWn3g4C+zslk709eeEpWGkPK1wrr7h6LveVkp1+JEbb
         YoaE+6D6wpo//IHwHTTsgY7fCNDKT2K/kqohmajUuiJjIC8NHjQyi7JSEh3s5VkCiKEG
         x2ePj29+QpIBEtP8vGUm1jHZ2feAU2HjB3fZV+Jw6HiN15WF521qYktFNDxmK+mmfm04
         l7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zGlkTt93I56FdkfoMWlIYd8INgxOMR6w9olDOSzQtFA=;
        b=MG0iGgDFPK6o8Z1pJtadJxexo4j3TwO03aFmwMg+5yG3hW1Dz6e4GHEKjZHZyok9Ot
         OjMHv6GdKprVXKPauYqdp3CMArLMoCo5GqCoog2qMTl4/CvmOf/c+I0khwJRCM4Wof3P
         lb9wM8sBc8WpVGyD1M+szyQxf1fZgZ+P684+YuBOjD5aFYDSqr4weLYLm3sGI2ahf9xk
         pXV5L+41D5JU5oQu0AVmphmzscN7q7KowoD47OK7L1olwSOa4vwknSXSIxcCpOBK9zG/
         LwSVNXogBxqN/u2RLc3ViI2q1eN8BcHerlF6b3pzBYxAqvO/LsrkMElKTrJHQnWDGXZb
         1W8g==
X-Gm-Message-State: AOAM532G+Oo2YYHppck0vaF+tC3bAzYoFqcHNTAK2EXl3yVguRV62EuR
        u7kBm/TX0dtibq4HQQUPGg1OgA==
X-Google-Smtp-Source: ABdhPJy20LVTZ4jyyS9/jZ57n4j9V/ViAToArdn33VXCagurbmn7RjzqqtgexHzAniJQ0yY4yDnbUg==
X-Received: by 2002:a1c:230e:: with SMTP id j14mr2692551wmj.187.1605084844080;
        Wed, 11 Nov 2020 00:54:04 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id f5sm1696268wmh.16.2020.11.11.00.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 00:54:03 -0800 (PST)
Date:   Wed, 11 Nov 2020 09:53:45 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: Re: [PATCH bpf-next v3 5/7] tools/runqslower: Enable out-of-tree
 build
Message-ID: <20201111085345.GA2604446@myrica>
References: <20201110164310.2600671-1-jean-philippe@linaro.org>
 <20201110164310.2600671-6-jean-philippe@linaro.org>
 <CAEf4BzYs998tBbeSAkoSvw1bYCnx7sG9s2gat=rNHsdUprrfjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYs998tBbeSAkoSvw1bYCnx7sG9s2gat=rNHsdUprrfjg@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 10, 2020 at 09:11:05PM -0800, Andrii Nakryiko wrote:
> On Tue, Nov 10, 2020 at 8:46 AM Jean-Philippe Brucker
> <jean-philippe@linaro.org> wrote:
> >
> > Enable out-of-tree build for runqslower. Only set OUTPUT=.output if it
> > wasn't already set by the user.
> >
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> > v3:
> > * Drop clean recipe for bpftool and libbpf, since the whole output
> >   directories are removed by the clean recipe.
> > * Use ?= for $(OUTPUT)
> > ---
> >  tools/bpf/runqslower/Makefile | 32 ++++++++++++++++++--------------
> >  1 file changed, 18 insertions(+), 14 deletions(-)
> >
> 
> [...]
> 
> >  clean:
> >         $(call QUIET_CLEAN, runqslower)
> > -       $(Q)rm -rf $(OUTPUT) runqslower
> > +       $(Q)$(RM) -r $(BPFOBJ_OUTPUT) $(BPFTOOL_OUTPUT)
> > +       $(Q)$(RM) $(OUTPUT)*.o $(OUTPUT)*.d
> > +       $(Q)$(RM) $(OUTPUT)*.skel.h $(OUTPUT)vmlinux.h
> > +       $(Q)$(RM) $(OUTPUT)runqslower
> > +       $(Q)$(RM) -r .output
> 
> hard-coding .output here doesn't seem right, didn't all the other
> lines clean up everything already?

Yes, but to clean the source tree, the .output directory needs to be
removed. On the other hand when $(OUTPUT) is out-of-tree, we only want to
remove its content but not the dir itself, because it was created by the
user.

Thanks,
Jean

> 
> >
> >  $(OUTPUT)/runqslower: $(OUTPUT)/runqslower.o $(BPFOBJ)
> >         $(QUIET_LINK)$(CC) $(CFLAGS) $^ -lelf -lz -o $@
> > @@ -59,8 +65,8 @@ $(OUTPUT)/%.bpf.o: %.bpf.c $(BPFOBJ) | $(OUTPUT)
> >  $(OUTPUT)/%.o: %.c | $(OUTPUT)
> >         $(QUIET_CC)$(CC) $(CFLAGS) $(INCLUDES) -c $(filter %.c,$^) -o $@
> >
> 
> [...]
