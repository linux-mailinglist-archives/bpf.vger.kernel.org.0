Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08DE347D0E
	for <lists+bpf@lfdr.de>; Wed, 24 Mar 2021 16:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236787AbhCXPyh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Mar 2021 11:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236803AbhCXPyc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Mar 2021 11:54:32 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76573C0613E1
        for <bpf@vger.kernel.org>; Wed, 24 Mar 2021 08:54:31 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id t71so4080261vst.3
        for <bpf@vger.kernel.org>; Wed, 24 Mar 2021 08:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jvdMNpuLDTAr72CZhKMnuvvxwLSHQueODNwVd/tQkSw=;
        b=fB+V4oDpRcxIY7NRezv/LgYAX+HS0KhU+rJZTEOffFFfAiDhycklq7vjJKyxwAyN6d
         FwVooeLY/l/eF0g2TiN+AEb+pWaU9Yjy4oeAuL2EjKqlXuPDwvNse4NeL0O8VLQsYJrj
         MduPgnhW4BoOEKm+9blk0AOlC9ZFe2MWNVdXg05XsLH8u13/F+l8TvAs/zdYNo204lOb
         UO2ejvr4schD5aphabcQ/rkR6XZAgxxn8+gOR3cZyqZ26gf7fuyTuc2VNfchDyeH/tfJ
         /ihpDMwEMU+3K5BBUlLCDwOe8gCAWXmR5ilixiAwXqQwXtxAH6TLPNups0PP1aS/TPeQ
         E9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jvdMNpuLDTAr72CZhKMnuvvxwLSHQueODNwVd/tQkSw=;
        b=K3CylVOqrjXrQpFxjCfwMXgu/FnVtf2go8k7xXcJrOdz/OFP+92oom4et0XpciwTqr
         AY35BpEUbjwUBMkg0HyOtJJJLdthxxWPMBaVILo5j+qb2yyeDIQ3++bOifXvOVkBNEL5
         GUDr1dq95XR7zktUDPqXtmYBKNNXzyeyeHK78Rqocj3QRYCzkVSvLIz4UKGH+0uNmabd
         HM3xRTidLDvTW1EeTBnuELAsN3iLksrllust0abdGWjbjhOTYy2bvfwG2sF6FAjEZcfU
         aPH0aPLfcgAZt1Vkzg8iufV0qpb2fZ8hIbWWv5OGfrwRtrlieVqf7UOVnMgOtWVbVQMn
         YQ6Q==
X-Gm-Message-State: AOAM5325zgoMSbebmLH8kWMbOCclipZGqMhtYuBQK/2TbEqImrIC9+zp
        1zALoAxinwoKDX1DWSHiiyv0JkLtkwbKXW+nwmIpZnItG2s=
X-Google-Smtp-Source: ABdhPJw/Tt5Eglhjkk3DSFJmZtQNB1612Zn3Mq7A5Is3NYScePeRKnpnTe64INtZMtYBNux7wDX2SFzRZ2Nc/eNRj+g=
X-Received: by 2002:a67:b447:: with SMTP id c7mr2227327vsm.54.1616601270219;
 Wed, 24 Mar 2021 08:54:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210323203946.2159693-1-samitolvanen@google.com>
 <20210323203946.2159693-4-samitolvanen@google.com> <20210324071357.GB2639075@infradead.org>
In-Reply-To: <20210324071357.GB2639075@infradead.org>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 24 Mar 2021 08:54:18 -0700
Message-ID: <CABCJKufRHCb0sjr1tMGCoVMzV-5dKPPn-t8=+ihNFAgTr2k0DA@mail.gmail.com>
Subject: Re: [PATCH v3 03/17] mm: add generic __va_function and __pa_function macros
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        bpf <bpf@vger.kernel.org>, linux-hardening@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 24, 2021 at 12:14 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Mar 23, 2021 at 01:39:32PM -0700, Sami Tolvanen wrote:
> > With CONFIG_CFI_CLANG, the compiler replaces function addresses
> > in instrumented C code with jump table addresses. This means that
> > __pa_symbol(function) returns the physical address of the jump table
> > entry instead of the actual function, which may not work as the jump
> > table code will immediately jump to a virtual address that may not be
> > mapped.
> >
> > To avoid this address space confusion, this change adds generic
> > definitions for __va_function and __pa_function, which architectures
> > that support CFI can override. The typical implementation of the
> > __va_function macro would use inline assembly to take the function
> > address, which avoids compiler instrumentation.
>
> I think these helper are sensible, but shouldn't they have somewhat
> less arcane names and proper documentation?

Good point, I'll add comments in the next version. I thought
__pa_function would be a fairly straightforward replacement for
__pa_symbol, but I'm fine with renaming these. Any suggestions for
less arcane names?

Sami
