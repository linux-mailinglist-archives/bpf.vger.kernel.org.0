Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4A4D19CB43
	for <lists+bpf@lfdr.de>; Thu,  2 Apr 2020 22:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389613AbgDBUeh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Apr 2020 16:34:37 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40573 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389521AbgDBUeg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Apr 2020 16:34:36 -0400
Received: by mail-pg1-f195.google.com with SMTP id t24so2378512pgj.7
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2020 13:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yY13RK0cKLrRjyvVBZully+r67kfxos978vIN0ruhpk=;
        b=KM2DmTOwPos0F7tLttvMAVY1LIa4ppIAmoFp2MqTGkdJDILQMA+dZFGoZUczJkP06n
         tIY11T4DiaYxZ3XpYIcaUADijDTLfmnhM6w5KLWiXD/U/5E644jQ7tBWEtkWTvI15PEr
         VVKHw3OqKjW7vcSabDsfT8G6FUxq86I+tgWHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yY13RK0cKLrRjyvVBZully+r67kfxos978vIN0ruhpk=;
        b=aEH846EXDwJoc0Hco5EMbuyOIPGtuTjJ5SjGecpLYR4U7aEUOMsdDjKBzkV/2Ap/4Q
         CTZy5YLzPCuPe2lPsPEK+xt+BoaKtYx2fbG3tigGUHE9xyyIIRL5JfQMoZHIvLlOWLA/
         UksqLrMkrsqMGH9mXkLKx6wxeafdr/3//ILGnaO/YSy9GVDV4sb7faxalkvYhT9zNL4m
         3UxpeYoGKY69IzU1Cz0+AZWmeSxgeuaSccy3HmNX/eXV80sS4kgXENr/3QsstBGJ3E0p
         0D8GjnMvh0pYja1Ygt9gOcKE5l0OMFW7KBcYDhnPH1A9OHFNGjTWiFoYZZsaAAWIhare
         1pTQ==
X-Gm-Message-State: AGi0PuYCRIXqK8IEdNTXJUtukrEoOPuGdXCL5LZu63Mlv8XNMeNpCt93
        nUNuJemm7CRfYFmGAn7AkcUVUg==
X-Google-Smtp-Source: APiQypIs5T+kRG38bpYFVlAfcbXCyZRjGu+qpBmjvk/e/tatzFR3rVbYNciSAuDjjUc5Jz4/iCXxsA==
X-Received: by 2002:a63:8f17:: with SMTP id n23mr5078110pgd.417.1585859673922;
        Thu, 02 Apr 2020 13:34:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e126sm4276397pfa.122.2020.04.02.13.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 13:34:33 -0700 (PDT)
Date:   Thu, 2 Apr 2020 13:34:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Slava Bacherikov <slava@bacher09.org>,
        Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Liu Yiding <liuyd.fnst@cn.fujitsu.com>, kpsingh@google.com
Subject: Re: [PATCH v4 bpf] kbuild: fix dependencies for DEBUG_INFO_BTF
Message-ID: <202004021328.E6161480@keescook>
References: <202004010849.CC7E9412@keescook>
 <20200402153335.38447-1-slava@bacher09.org>
 <f43f4e17-f496-9ee1-7d89-c8f742720a5f@bacher09.org>
 <CAEf4Bzb2mgDPcdNGWnBgoqsuWYqDiv39U2irn4iCp=7B3kx1nA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzb2mgDPcdNGWnBgoqsuWYqDiv39U2irn4iCp=7B3kx1nA@mail.gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 02, 2020 at 12:31:36PM -0700, Andrii Nakryiko wrote:
> On Thu, Apr 2, 2020 at 8:40 AM Slava Bacherikov <slava@bacher09.org> wrote:
> >
> >
> >
> > 02.04.2020 18:33, Slava Bacherikov wrote:
> > > +     depends on DEBUG_INFO || COMPILE_TEST
> >
> > Andrii are you fine by this ?
> 
> I think it needs a good comment explaining this weirdness, at least.
> As I said, if there is no DEBUG_INFO, there is not point in doing
> DWARF-to-BTF conversion, even more -- it actually might fail, I
> haven't checked what pahole does in that case. So I'd rather drop
> GCC_PLUGIN_RANDSTRUCT is that's the issue here. DEBUG_INFO_SPLIT and
> DEBUG_INFO_REDUCED look good.

The DEBUG_INFO is separate, AIUI -- it sounds like BTF may entirely
break on a compile with weird DWARF configs.

The GCC_PLUGIN_RANDSTRUCT issue is separate: it doesn't make sense to
run a kernel built with BTF and GCC_PLUGIN_RANDSTRUCT. But they should
have nothing to do with each other with regard to compilation. So, to
keep GCC_PLUGIN_RANDSTRUCT disable for "real" builds but leave it on for
all*config, randconfig, etc, I'd like to keep the || COMPILE_TEST,
otherwise GCC_PLUGIN_RANDSTRUCT won't be part of the many CIs doing
compilation testing.

And FWIW, I'm fine to let GCC_PLUGIN_RANDSTRUCT and BTF build together.
But if they want to be depends-conflicted, I wanted to keep the test
compile trap door.

-- 
Kees Cook
