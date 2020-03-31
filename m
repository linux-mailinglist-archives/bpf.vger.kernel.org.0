Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1099B199DD4
	for <lists+bpf@lfdr.de>; Tue, 31 Mar 2020 20:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgCaSMe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Mar 2020 14:12:34 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:38036 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgCaSMe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Mar 2020 14:12:34 -0400
Received: by mail-pj1-f67.google.com with SMTP id m15so1408803pje.3
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2020 11:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v3yIssPSEeZvWeAW+pdQM2euAxC0fXaMIWj8OAY6zQs=;
        b=KAsI4MWLqfiUvnxtz3qcVOWb/O7CFrFTtX5VD0apn31zbo3A4d99vRUqzJMbtgQGC4
         rr4iSH58raWCTtFXk/Q48QZSY1mF4WgnvPYR2SbvYbKzI2w7CfMLf/aZwplbNEK+tpMB
         APIJ6D/gCcjy5Et/eokKCAyBXSw9nebphAIiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v3yIssPSEeZvWeAW+pdQM2euAxC0fXaMIWj8OAY6zQs=;
        b=Ja9m4Kix4YkxGqQrA8AZjWIrqpf69ACtBAJwbQ1yQby5CC/L97TU4C+jAY/SJWLMoP
         aTaGTQedKPgun89WQQMbm3fg+M6g4W6YCubSIegc/KB/2QtXKdFAxqLxHH7jgd1ElKmd
         GSqWrhmSELvrnmL3w5FXEI7wSz5kOSrQ5in6268nDmADxJQMqFtgLlpvzEoQA2xlTU9l
         Gj8Uqyp2wA8ibd8hje89tzoxH/5z7500n53AqylUdnUBRFe4Y3wdPulMjLSjPRofp1WD
         T3nJzmqPVcj6ZhAa3OIaS2ve+GpH/9rE34zZPPfCodh4gNq2/m8N+7f1l4LuJ9GO+T7C
         Xcig==
X-Gm-Message-State: AGi0PuZk8XKHS8fb4UFcw2FvGzXZetr2tuLGBKWMGdsEmq/pDQF/v8L1
        vZWSs6txzqQL4FMgPTsraKHxCg==
X-Google-Smtp-Source: APiQypKAD4nnkDQY07cbX5cUOamNGJvBmbvTc5RjhrDUWve16ZurG5HNZ5oMAs0m9fu7vmRcXbZiGg==
X-Received: by 2002:a17:90a:30a9:: with SMTP id h38mr129206pjb.184.1585678350979;
        Tue, 31 Mar 2020 11:12:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c126sm13103902pfb.83.2020.03.31.11.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 11:12:30 -0700 (PDT)
Date:   Tue, 31 Mar 2020 11:12:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Jann Horn <jannh@google.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: CONFIG_DEBUG_INFO_BTF and CONFIG_GCC_PLUGIN_RANDSTRUCT
Message-ID: <202003311110.2B08091E@keescook>
References: <CAG48ez2sZ58VQ4+LJu39H1M0Y98LhRYR19G_fDAPJPBf7imxuw@mail.gmail.com>
 <CAADnVQ+Ux3-D_7ytRJx_Pz4fStRLS1vkM=-tGZ0paoD7n+JCLQ@mail.gmail.com>
 <CAG48ez0ajun-ujQQqhDRooha1F0BZd3RYKvbJ=8SsRiHAQjUzw@mail.gmail.com>
 <202003301016.D0E239A0@keescook>
 <c332da87-a770-8cf9-c252-5fb64c06c17e@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c332da87-a770-8cf9-c252-5fb64c06c17e@iogearbox.net>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 31, 2020 at 12:41:04AM +0200, Daniel Borkmann wrote:
> On 3/30/20 7:20 PM, Kees Cook wrote:
> > On Mon, Mar 30, 2020 at 06:17:32PM +0200, Jann Horn wrote:
> > > On Mon, Mar 30, 2020 at 5:59 PM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > > On Mon, Mar 30, 2020 at 8:14 AM Jann Horn <jannh@google.com> wrote:
> > > > > 
> > > > > I noticed that CONFIG_DEBUG_INFO_BTF seems to partly defeat the point
> > > > > of CONFIG_GCC_PLUGIN_RANDSTRUCT.
> > > > 
> > > > Is it a theoretical stmt or you have data?
> > > > I think it's the other way around.
> > > > gcc-plugin breaks dwarf and breaks btf.
> > > > But I only looked at gcc patches without applying them.
> > > 
> > > Ah, interesting - I haven't actually tested it, I just assumed
> > > (perhaps incorrectly) that the GCC plugin would deal with DWARF info
> > > properly.
> > 
> > Yeah, GCC appears to create DWARF before the plugin does the
> > randomization[1], so it's not an exposure, but yes, struct randomization
> > is pretty completely incompatible with a bunch of things in the kernel
> > (by design). I'm happy to add negative "depends" in the Kconfig if it
> > helps clarify anything.
> 
> Is this expected to get fixed at some point wrt DWARF? Perhaps would make

No, gcc closed the issue as "won't fix".

> sense then to add a negative "depends" for both DWARF and BTF if the option
> GCC_PLUGIN_RANDSTRUCT is set given both would be incompatible/broken.

I hadn't just to keep wider randconfig build test coverage. That said, I
could make it be: depends COMPILE_TEST || !DWARF ...

I can certainly do that.

-Kees

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84052

-- 
Kees Cook
