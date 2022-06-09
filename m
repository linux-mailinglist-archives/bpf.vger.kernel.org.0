Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C964544DF6
	for <lists+bpf@lfdr.de>; Thu,  9 Jun 2022 15:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239732AbiFINoW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Jun 2022 09:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237172AbiFINoV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Jun 2022 09:44:21 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8472D25597
        for <bpf@vger.kernel.org>; Thu,  9 Jun 2022 06:44:20 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id a15so23966623wrh.2
        for <bpf@vger.kernel.org>; Thu, 09 Jun 2022 06:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YW9wU4Ml3Gc4v0WwfEHU9uvOu4YoxGdWNjzJgfnoTJI=;
        b=SDgk8MraMWSRR84fFBZDM7VtJ6s33T966lYq9TnLKu9jmKxXt1Ta5z73fVzUb1EWdW
         s4a3pIFDbaGEIllsvnrzvTl9wmyPGEhBvmSxFiz36pQiqqa/uwjzwtmt03AmrbxpeFh7
         8nBC2oq7J4K+PcVTEcHidmAmSU+PDUGPm9NW3T+MHeIXYOdPasaH0xj8n70Gh1nBd3zZ
         60lZu0jwhuIfbsD0rIZiNj2sa29f3fSZbpOhYeNOTPjeO5+J7vGbzmoMyaP6vl+rleeU
         BLLfGecaBVXRhSmnw94l+T/569ViYolnQFvkn2VvQmaWL1YneORqFPi50DMI4zYBn6iu
         T2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YW9wU4Ml3Gc4v0WwfEHU9uvOu4YoxGdWNjzJgfnoTJI=;
        b=qumuVeNDKgN/XJXvFVPmM3+VV5E0jmfSKx/3zdZPsYf4UtV1yvO62QIEA9cqOswhpA
         YRTJysREZizAdyFSwE4rYcHl6+nPLO46e/IdhHRMoKMgp+eW4vhJvsMKc8WMpZW5blQH
         cVZNADTebtZtIqN9gDW/w7xagXPIPlytp5fdijsjODfqmi+MIEqnYueBSWduBCwo8EVe
         vyCNWhq5AB1KaWsEJnCq69GPV+vzQmeTZ55B0VkN3s34d7PK657baRvk6XrN8jM1SuhB
         H0NHN8/KYI7k2vDbmuFvsGVOKDRTlfUzXBkDF8IGQprO0k7gANg4uWfFxyVivpjXe97F
         ybSg==
X-Gm-Message-State: AOAM533ivDe4Gs+ggz/I9R02+LHxtEtRuVRvzjKczcafDJu67Dj9jiUX
        pKwi3KbJYWugvwUy6vqNxAmthg==
X-Google-Smtp-Source: ABdhPJyR/nh7pgv6msGgRl8oYN0HcwBjF4d5M4UNp1VbhaJHDKn3gUSp1+VdDCN5SoPLoYOD2Xd3Vg==
X-Received: by 2002:a5d:484d:0:b0:215:e7bf:3e71 with SMTP id n13-20020a5d484d000000b00215e7bf3e71mr30112232wrs.435.1654782259036;
        Thu, 09 Jun 2022 06:44:19 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id k5-20020adff285000000b002101ed6e70fsm20541472wro.37.2022.06.09.06.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 06:44:18 -0700 (PDT)
Date:   Thu, 9 Jun 2022 14:43:55 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Shahab Vahedi <Shahab.Vahedi@synopsys.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH] bpftool: Fix bootstrapping during a cross compilation
Message-ID: <YqH5G1DlKgbmRZzO@myrica>
References: <8d297f0c-cfd0-ef6f-3970-6dddb3d9a87a@synopsys.com>
 <474e37a8-0ce2-9d2e-5632-755a0746c8a8@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <474e37a8-0ce2-9d2e-5632-755a0746c8a8@isovalent.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 08, 2022 at 05:49:41PM +0100, Quentin Monnet wrote:
> 2022-06-08 14:29 UTC+0000 ~ Shahab Vahedi <Shahab.Vahedi@synopsys.com>
> > This change adjusts the Makefile to use "HOSTAR" as the archive tool
> > to keep the sanity of the build process for the bootstrap part in
> > check. For the rationale, please continue reading.
> > 
> > When cross compiling bpftool with buildroot, it leads to an invocation
> > like:
> > 
> > $ AR="/path/to/buildroot/host/bin/arc-linux-gcc-ar" \
> >   CC="/path/to/buildroot/host/bin/arc-linux-gcc"    \
> >   ...
> >   make
> > 
> > Which in return fails while building the bootstrap section:
> > 
> > ----------------------------------8<----------------------------------
> > 
> >   make: Entering directory '/src/bpftool-v6.7.0/src'
> >   ...                        libbfd: [ on  ]
> >   ...        disassembler-four-args: [ on  ]
> >   ...                          zlib: [ on  ]
> >   ...                        libcap: [ OFF ]
> >   ...               clang-bpf-co-re: [ on  ] <-- triggers bootstrap
> > 
> >   .
> >   .
> >   .
> > 
> >     LINK     /src/bpftool-v6.7.0/src/bootstrap/bpftool
> >   /usr/bin/ld: /src/bpftool-v6.7.0/src/bootstrap/libbpf/libbpf.a:
> >                error adding symbols: archive has no index; run ranlib
> >                to add one
> >   collect2: error: ld returned 1 exit status
> >   make: *** [Makefile:211: /src/bpftool-v6.7.0/src/bootstrap/bpftool]
> >             Error 1
> >   make: *** Waiting for unfinished jobs....
> >     AR       /src/bpftool-v6.7.0/src/libbpf/libbpf.a
> >     make[1]: Leaving directory '/src/bpftool-v6.7.0/libbpf/src'
> >     make: Leaving directory '/src/bpftool-v6.7.0/src'
> > 
> > ---------------------------------->8----------------------------------
> > 
> > This occurs because setting "AR" confuses the build process for the
> > bootstrap section and it calls "arc-linux-gcc-ar" to create and index
> > "libbpf.a" instead of the host "ar".
> > 
> > Signed-off-by: Shahab Vahedi <shahab@synopsys.com>
> > ---
> >  tools/bpf/bpftool/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> > index c6d2c77d0252..c19e0e4c41bd 100644
> > --- a/tools/bpf/bpftool/Makefile
> > +++ b/tools/bpf/bpftool/Makefile
> > @@ -53,7 +53,7 @@ $(LIBBPF_INTERNAL_HDRS): $(LIBBPF_HDRS_DIR)/%.h: $(BPF_DIR)/%.h | $(LIBBPF_HDRS_
> >  $(LIBBPF_BOOTSTRAP): $(wildcard $(BPF_DIR)/*.[ch] $(BPF_DIR)/Makefile) | $(LIBBPF_BOOTSTRAP_OUTPUT)
> >  	$(Q)$(MAKE) -C $(BPF_DIR) OUTPUT=$(LIBBPF_BOOTSTRAP_OUTPUT) \
> >  		DESTDIR=$(LIBBPF_BOOTSTRAP_DESTDIR:/=) prefix= \
> > -		ARCH= CROSS_COMPILE= CC=$(HOSTCC) LD=$(HOSTLD) $@ install_headers
> > +		ARCH= CROSS_COMPILE= CC=$(HOSTCC) LD=$(HOSTLD) AR=$(HOSTAR) $@ install_headers
> >  
> >  $(LIBBPF_BOOTSTRAP_INTERNAL_HDRS): $(LIBBPF_BOOTSTRAP_HDRS_DIR)/%.h: $(BPF_DIR)/%.h | $(LIBBPF_BOOTSTRAP_HDRS_DIR)
> >  	$(call QUIET_INSTALL, $@)
> 
> +Cc Jean-Philippe
> 
> Looks good to me, thank you!
> Reviewed-by: Quentin Monnet <quentin@isovalent.com>

Thanks, it makes sense to me as well

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
