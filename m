Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA697349CE2
	for <lists+bpf@lfdr.de>; Fri, 26 Mar 2021 00:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhCYX2c (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Mar 2021 19:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbhCYX2F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Mar 2021 19:28:05 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FB1C061763
        for <bpf@vger.kernel.org>; Thu, 25 Mar 2021 16:28:04 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id e5so1818625vse.4
        for <bpf@vger.kernel.org>; Thu, 25 Mar 2021 16:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sMIbLViyZj8/HlFK24+Kb6qHIJjqUM2GzqLOFEtB9oc=;
        b=L88zRiGVrc72dQhmDgR/gl8qiK4rX7wM+JKPd8gbrtbUdlgOq2qWt3hK/quHaVP65Z
         bO4L3tHQpHfPaRVNRTTnhWNEDjMxu1A8FIfWK6N3BgKWI7s/X8tWJ8JR/RN2kkJVQhtS
         s0kCqEIXJIfEpxWuw2lb+ancWufqeGs6cNlvu5zr1OPdoN77VELBfuVwv2098G1gVR1W
         qLssJpMKWs+sQI35oQtwqkRZkSmOqgSPEwWfmGUGgOs/3NzBSWZ7JE5XtmxzVrvSmrTS
         gbGr91kGamtH5beo2ZAoGW55Z6UpbyOfe0e7CVs3RKgb/23UoHpUO9eD2rAPuR6LB0Lr
         b6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sMIbLViyZj8/HlFK24+Kb6qHIJjqUM2GzqLOFEtB9oc=;
        b=ILFK6HtbXI3GAxTJ7sHw0LJvK/GYM3KOH97NOyNrZ9m8XLhmuoLuThhJXTPJJ19QVR
         xxsnwu0ojhK5GvRZsToU+3jbsUHmhdKIWWo9c9uroE6waHlaM+ic4kQ8EfPLNnDgkg98
         2uCoTKLJIEwKCoROAn5LQvZkcgGa+WDmTPO+BJuAH4GdttZ6HQmpGezDFtYGRyhtomNz
         HF1wBvNXgJWw1rva92NT5DwAQUZTpY89mQf1IIMc/u7S24tEoy3noVOz6mYn9nrZnJRG
         hVCnpfdISscZF2FLJEW4sbNthxSKxb/YBIx/pLIHrPPKD59D6cqdzpkwOMEkVho/5mgu
         Zi/A==
X-Gm-Message-State: AOAM530NciLMIQdmkOiGrZrSFwHU7H0qOvV6o4TMDp2RbYB6w1wRy/PX
        klqdh5LEmUUy3fNgtsckfHwrEQWfM7J2fci039Zkgg==
X-Google-Smtp-Source: ABdhPJzXZpIDBEM17dpJFRhj46QNwU1LqTcjFes5q+MSMb/XfPVQl0PcMMMDnIa0KNr2ybRRsJDqEF2yBb4XZozL71I=
X-Received: by 2002:a05:6102:a49:: with SMTP id i9mr6830290vss.14.1616714882733;
 Thu, 25 Mar 2021 16:28:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210323203946.2159693-1-samitolvanen@google.com>
 <20210323203946.2159693-13-samitolvanen@google.com> <20210325103757.GD36570@C02TD0UTHF1T.local>
In-Reply-To: <20210325103757.GD36570@C02TD0UTHF1T.local>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Thu, 25 Mar 2021 16:27:51 -0700
Message-ID: <CABCJKud_VC_vAn_7PdZzDja0gpk5ych0CBJpBw45pvivFoePgQ@mail.gmail.com>
Subject: Re: [PATCH v3 12/17] arm64: implement __va_function
To:     Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
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

On Thu, Mar 25, 2021 at 3:38 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Tue, Mar 23, 2021 at 01:39:41PM -0700, Sami Tolvanen wrote:
> > With CONFIG_CFI_CLANG, the compiler replaces function addresses in
> > instrumented C code with jump table addresses. This change implements
> > the __va_function() macro, which returns the actual function address
> > instead.
> >
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
>
> Is there really no attribute or builtin that can be used to do this
> without assembly?

I don't think the compiler currently offers anything that could help
us here. Peter, can you think of another way to avoid the function
address to jump table address conversion with
-fno-sanitize-cfi-canonical-jump-tables?

> IIUC from other patches the symbol tables will contain the "real"
> non-cfi entry points (unless we explciitly asked to make the jump table
> address canonical), so AFAICT here the compiler should have all the
> necessary information to generate either the CFI or non-CFI entry point
> addresses, even if it doesn't expose an interface for that today.
>
> It'd be a lot nicer if we could get the compiler to do this for us.

I agree, that would be quite useful in the kernel.

Sami
