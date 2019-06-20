Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC964C4AC
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2019 02:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbfFTA6i (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Jun 2019 20:58:38 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40052 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbfFTA6i (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Jun 2019 20:58:38 -0400
Received: by mail-ot1-f65.google.com with SMTP id e8so998101otl.7
        for <bpf@vger.kernel.org>; Wed, 19 Jun 2019 17:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Pv6DYs/rgMUhmFVTIlv6mQtmI4/e3SRdgmeYYSiE/gY=;
        b=oTUnU1I9Q3P6mnwGmSHo8VtVE9FzfceDm8JYzas75iB8Vpe9bONAVPH2S3TkqM2T1F
         AfMa+uPb+HeX3Uw62WFDmNKu7P8wioRQ2b3H0FBzHxKQnhgOOWvrNf5guNAdwAaDrF/I
         xpJ/tV30aZvykXO0oOcH6KE4RQNKoOOFP/boZ/cieuj+impdRqlqR+E45fvl9LeIx1Md
         p91138c9GCF1m2LJIz2xmLR3PzI9z8/c1OIFmPjKktYAjHDR16lNQgi3V8PXARwSA4Tr
         pDxI9ygK81Mrd5QIssaBJhkHuqk1eXDNVLVe7aTsXm1Oyh8sR7oGawQguh8x4lYDolkK
         OGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pv6DYs/rgMUhmFVTIlv6mQtmI4/e3SRdgmeYYSiE/gY=;
        b=A96D+TNwGuccvRzCR/yG3brcStUYhHN64BLeBz5ivZ36CHfM+/VeRAbxm1Yd98VEaq
         7aRoFxIHdtO/tMybXiZY3XTAkFDEvczlB1rxuBJqWP9GTv6cwC+ypZJ9UFXNm8mYV1DW
         v6kyWpIUzCi7AbLRbWconPkHVHxjBsw+I92TTesxqxx2Tx4xGsGrdlFMBQqyDMLS52p9
         zV36LqBEd9KijUnCydMaRClmE2H2TgxRvU7+Htc0GxE3co3cCLRkCnf49dEd1JOxnBZf
         HyW4IObTHYxs64NRR91NFOwR8mAyyIYneKdq1MGwzkpjS8DTBlK00gxDUG9ROCmcKl23
         ysbA==
X-Gm-Message-State: APjAAAUTvxZttcaFTTJxTuBosSubc+RrjOQtl3fZbmNlrBSzq1xdyz5U
        bc8FqoTp/66Ru72x+WjfWzIT4ouVKYuyIQ==
X-Google-Smtp-Source: APXvYqyGWcBsRjlJt5apXMRax/dVlTZbIM5JD9/pIw5q+E7QvXP98lnAmkC5vhNUCGfuVZN3B0sKsA==
X-Received: by 2002:a9d:7d05:: with SMTP id v5mr8624081otn.245.1560992317485;
        Wed, 19 Jun 2019 17:58:37 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li964-79.members.linode.com. [45.33.10.79])
        by smtp.gmail.com with ESMTPSA id j135sm1940279oib.19.2019.06.19.17.58.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Jun 2019 17:58:36 -0700 (PDT)
Date:   Thu, 20 Jun 2019 08:58:29 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Coresight ML <coresight@lists.linaro.org>
Subject: Re: [PATCH] perf cs-etm: Improve completeness for kernel address
 space
Message-ID: <20190620005829.GH24549@leoy-ThinkPad-X240s>
References: <20190617150024.11787-1-leo.yan@linaro.org>
 <CANLsYkyMW=WG+=yWTLSyMT3JXqd_2kvsrx9c-EwCoKEnRZvErA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANLsYkyMW=WG+=yWTLSyMT3JXqd_2kvsrx9c-EwCoKEnRZvErA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Mathieu,

On Wed, Jun 19, 2019 at 11:49:44AM -0600, Mathieu Poirier wrote:

[...]

> > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > index 51dd00f65709..4776c2c1fb6d 100644
> > --- a/tools/perf/Makefile.config
> > +++ b/tools/perf/Makefile.config
> > @@ -418,6 +418,30 @@ ifdef CORESIGHT
> >      endif
> >      LDFLAGS += $(LIBOPENCSD_LDFLAGS)
> >      EXTLIBS += $(OPENCSDLIBS)
> > +    ifneq ($(wildcard $(srctree)/arch/arm64/kernel/vmlinux.lds),)
> > +      # Extract info from lds:
> > +      #  . = ((((((((0xffffffffffffffff)) - (((1)) << (48)) + 1) + (0)) + (0x08000000))) + (0x08000000))) + 0x00080000;
> > +      # ARM64_PRE_START_SIZE := (0x08000000 + 0x08000000 + 0x00080000)
> > +      ARM64_PRE_START_SIZE := $(shell egrep ' \. \= \({8}0x[0-9a-fA-F]+\){2}' \
> > +        $(srctree)/arch/arm64/kernel/vmlinux.lds | \
> > +        sed -e 's/[(|)|.|=|+|<|;|-]//g' -e 's/ \+/ /g' -e 's/^[ \t]*//' | \
> > +        awk -F' ' '{print "("$$6 "+"  $$7 "+" $$8")"}' 2>/dev/null)
> > +    else
> > +      ARM64_PRE_START_SIZE := 0
> > +    endif
> > +    CFLAGS += -DARM64_PRE_START_SIZE="$(ARM64_PRE_START_SIZE)"
> > +    ifneq ($(wildcard $(srctree)/arch/arm/kernel/vmlinux.lds),)
> > +      # Extract info from lds:
> > +      #   . = ((0xC0000000)) + 0x00208000;
> > +      # ARM_PRE_START_SIZE := 0x00208000
> > +      ARM_PRE_START_SIZE := $(shell egrep ' \. \= \({2}0x[0-9a-fA-F]+\){2}' \
> > +        $(srctree)/arch/arm/kernel/vmlinux.lds | \
> > +        sed -e 's/[(|)|.|=|+|<|;|-]//g' -e 's/ \+/ /g' -e 's/^[ \t]*//' | \
> > +        awk -F' ' '{print "("$$2")"}' 2>/dev/null)
> > +    else
> > +      ARM_PRE_START_SIZE := 0
> > +    endif
> > +    CFLAGS += -DARM_PRE_START_SIZE="$(ARM_PRE_START_SIZE)"
> >      $(call detected,CONFIG_LIBOPENCSD)
> >      ifdef CSTRACE_RAW
> >        CFLAGS += -DCS_DEBUG_RAW
> > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > index 0c7776b51045..ae831f836c70 100644
> > --- a/tools/perf/util/cs-etm.c
> > +++ b/tools/perf/util/cs-etm.c
> > @@ -613,10 +613,34 @@ static void cs_etm__free(struct perf_session *session)
> >  static u8 cs_etm__cpu_mode(struct cs_etm_queue *etmq, u64 address)
> >  {
> >         struct machine *machine;
> > +       u64 fixup_kernel_start = 0;
> > +       const char *arch;
> >
> >         machine = etmq->etm->machine;
> > +       arch = perf_env__arch(machine->env);
> >
> > -       if (address >= etmq->etm->kernel_start) {
> > +       /*
> > +        * Since arm and arm64 specify some memory regions prior to
> > +        * 'kernel_start', kernel addresses can be less than 'kernel_start'.
> > +        *
> > +        * For arm architecture, the 16MB virtual memory space prior to
> > +        * 'kernel_start' is allocated to device modules, a PMD table if
> > +        * CONFIG_HIGHMEM is enabled and a PGD table.
> > +        *
> > +        * For arm64 architecture, the root PGD table, device module memory
> > +        * region and BPF jit region are prior to 'kernel_start'.
> > +        *
> > +        * To reflect the complete kernel address space, compensate these
> > +        * pre-defined regions for kernel start address.
> > +        */
> > +       if (!strcmp(arch, "arm64"))
> > +               fixup_kernel_start = etmq->etm->kernel_start -
> > +                                    ARM64_PRE_START_SIZE;
> > +       else if (!strcmp(arch, "arm"))
> > +               fixup_kernel_start = etmq->etm->kernel_start -
> > +                                    ARM_PRE_START_SIZE;
> 
> I will test your work but from a quick look wouldn't it be better to
> have a single define name here?  From looking at the modifications you
> did to Makefile.config there doesn't seem to be a reason to have two.

Thanks for suggestion.  I changed to use single define
ARM_PRE_START_SIZE and sent patch v2 [1].

If possible, please test patch v2.

Thanks,
Leo Yan

[1] https://lore.kernel.org/linux-arm-kernel/20190620005428.20883-1-leo.yan@linaro.org/T/#u

> > +
> > +       if (address >= fixup_kernel_start) {
> >                 if (machine__is_host(machine))
> >                         return PERF_RECORD_MISC_KERNEL;
> >                 else
> > --
> > 2.17.1
> >
