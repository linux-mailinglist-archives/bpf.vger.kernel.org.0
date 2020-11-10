Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED0D52AD68D
	for <lists+bpf@lfdr.de>; Tue, 10 Nov 2020 13:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729227AbgKJMne (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Nov 2020 07:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728478AbgKJMne (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Nov 2020 07:43:34 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2BFC0613CF
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2020 04:43:33 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id 23so12507392wrc.8
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2020 04:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Dea9mV8db4LtYr0U9uD1ZrCBN0AdEoqGcb3jcog05c0=;
        b=gmphOjW3/vu07h6U8eKyPDCyKW4PIVJohQF4OS5aZ06Rt+vK4bO5cIy4UezC5XncpL
         AWsUxe10ncSMdUZQBTGiE4DpCiOd16+fS1bWym07rb8yHzU66W+3H5pWpLAA+UQJKJr/
         HZkwMkCc+lLT1Q3auUl8JXPjJhnDk3KXnGAOSYEjHl+qbaJvLzMuDXHCAgavUhF0+2bI
         McKnyCMXDUInLMSKlWfHcIRM2KMHmRxyrYgw1eqNH8jJ4JGx2vVJxPFSBmYieUYwi+IH
         bPDUNc9Zo+P0MLf6pmxKqxgEAdHBuHbZaV7forl9g633hws8U+d1bp5aGXHzpdLvHlkc
         egSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dea9mV8db4LtYr0U9uD1ZrCBN0AdEoqGcb3jcog05c0=;
        b=Zs/Tx5zeaCyGbF5RNjIQ9DPqSRRnfHPbHQKi9hO7p1Yp+HG5r4DjOCDEeWZUbH0ATM
         Rk2dXRyVJdlb6bbAdxEvdqrw4SmtGloYsN26mmyTNILQbNeb0B8t2ephTYBPZqLMzLWo
         Ds/1hm1idyqChvp3lKkL+FEGz9aayLcgtQHSAXIj4c+2iDprHQyapSC+WmU1ONA6+0oB
         mOfIKERd3lYVgZwRtSdjtFE5EYflql1pVwrsE8nP0yDcn7d33BjYxuXyOZBunYlO1Knn
         ZOtcO9b9AonlCsIICS0pAa2KrQNTOCMHFZ9ymW9Fw1Hdx81SKdpjW8mps6Va/zQM5k39
         KkdA==
X-Gm-Message-State: AOAM530mlql4zi32DxJVTAY0jSyouri32WYA+WWJutacL65nXWqHw8ap
        BnxhaFNywNxaeRLU1wZIEDeNdA==
X-Google-Smtp-Source: ABdhPJxvKB5mfn9xV4cTZzPCzfTTPd4cxSMMt+1jWxG7jeQ8kRywbec3OkJ2wCXedDVS3SFbk/0M8w==
X-Received: by 2002:a5d:4f12:: with SMTP id c18mr5133531wru.304.1605012212644;
        Tue, 10 Nov 2020 04:43:32 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id u8sm2915354wmg.6.2020.11.10.04.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 04:43:31 -0800 (PST)
Date:   Tue, 10 Nov 2020 13:43:13 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: Re: [PATCH bpf-next v2 3/6] tools/bpftool: Fix cross-build
Message-ID: <20201110124313.GB1521675@myrica>
References: <20201109110929.1223538-1-jean-philippe@linaro.org>
 <20201109110929.1223538-4-jean-philippe@linaro.org>
 <CAEf4Bzaw9Fox6FZcT+ipFsnrHFRKrno27Y4Uh13eiNpd08es2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzaw9Fox6FZcT+ipFsnrHFRKrno27Y4Uh13eiNpd08es2g@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 09, 2020 at 12:17:49PM -0800, Andrii Nakryiko wrote:
> On Mon, Nov 9, 2020 at 3:11 AM Jean-Philippe Brucker
> <jean-philippe@linaro.org> wrote:
> >
> > The bpftool build first creates an intermediate binary, executed on the
> > host, to generate skeletons required by the final build. When
> > cross-building bpftool for an architecture different from the host, the
> > intermediate binary should be built using the host compiler (gcc) and
> > the final bpftool using the cross compiler (e.g. aarch64-linux-gnu-gcc).
> >
> > Generate the intermediate objects into the bootstrap/ directory using
> > the host toolchain.
> >
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> >  tools/bpf/bpftool/Makefile | 32 +++++++++++++++++++++++++-------
> >  1 file changed, 25 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> > index 1358c093b812..0705c48e0ce0 100644
> > --- a/tools/bpf/bpftool/Makefile
> > +++ b/tools/bpf/bpftool/Makefile
> > @@ -19,24 +19,36 @@ BPF_DIR = $(srctree)/tools/lib/bpf/
> >  ifneq ($(OUTPUT),)
> >    LIBBPF_OUTPUT = $(OUTPUT)/libbpf/
> >    LIBBPF_PATH = $(LIBBPF_OUTPUT)
> > +  BOOTSTRAP_OUTPUT = $(OUTPUT)/bootstrap/
> >  else
> 
> LIBBPF_OUTPUT is not set here, can you please fix that as well?

Ok. I'll set it to "", so the clean receipe doesn't remove the source tree

> 
> >    LIBBPF_PATH = $(BPF_DIR)
> > +  BOOTSTRAP_OUTPUT = $(CURDIR)/bootstrap/
> >  endif
> >
> 
> [...]
> 
> > -clean: $(LIBBPF)-clean feature-detect-clean
> > +clean: $(LIBBPF)-clean $(LIBBPF_BOOTSTRAP)-clean feature-detect-clean
> >         $(call QUIET_CLEAN, bpftool)
> >         $(Q)$(RM) -- $(OUTPUT)bpftool $(OUTPUT)*.o $(OUTPUT)*.d
> > -       $(Q)$(RM) -- $(BPFTOOL_BOOTSTRAP) $(OUTPUT)*.skel.h $(OUTPUT)vmlinux.h
> > +       $(Q)$(RM) -- $(OUTPUT)*.skel.h $(OUTPUT)vmlinux.h
> >         $(Q)$(RM) -r -- $(OUTPUT)libbpf/
> > +       $(Q)$(RM) -r -- $(BOOTSTRAP_OUTPUT)
> 
> Can you combine it with the previous line, maybe also specify more
> explicitly $(LIBBPF_OUTPUT) instead of $(OUTPUT)libbpf/?

Sure

Thanks,
Jean

> 
> >         $(call QUIET_CLEAN, core-gen)
> >         $(Q)$(RM) -- $(OUTPUT)FEATURE-DUMP.bpftool
> >         $(Q)$(RM) -r -- $(OUTPUT)feature/
> > --
> > 2.29.1
> >
