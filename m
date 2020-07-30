Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D45102339E2
	for <lists+bpf@lfdr.de>; Thu, 30 Jul 2020 22:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgG3Unr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Jul 2020 16:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbgG3Unr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Jul 2020 16:43:47 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD80C061574
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2020 13:43:47 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id y17so15121846ybm.12
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2020 13:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ds0prSsPKKNjln+hB/VMxkyNaySHhI1HKB2O0pgKb0M=;
        b=HssOSb94JJaHtehBNSfUhHm8sSxLSeSESaQgXx/T0mqDRsthMxeC7Qdba+0aeO0qyA
         DUy55WHrTjBcnpkAcHBYKgEFPOIQeF4BlOnG4pYU3OLQq8azB+/m5woERv6WHbETLvyZ
         4UqUI75iA1NMoWTsm+X8QfOcVuLspqyaxKPm8PkrxEjhzDeNg7J21rBf+OYxJea/XPGe
         OsPhRT6Cdwtdu0ipcxG7cp83Deilmvhx6Cf7u+5vuF7iFgH/e3Z/1xApAzhOFCGJRcqJ
         xpno7SgSAmV4n/RHjZiqJq5Aa29fnHJtrgJzm66xYWbfteObK4tHF9Z/6kbc4wEwDmE5
         LpXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ds0prSsPKKNjln+hB/VMxkyNaySHhI1HKB2O0pgKb0M=;
        b=kxkGP2pkWIgx5DPUT3edyT8WxjkWM0VgrvDEWHaQ4j+P/cPFq47DgZYWMTQoE1plNw
         u8PoyWVX0imcrVuYEpfn5CMJMcLJqfzDIR+mjYz0F6j5h5UQgkxquq4guV4hg9xqe9dP
         pgtpb2bb1WDjJ6htEn0p4tpTRvlAqETue78vBCL6FoA51HIvdenz/ctdUM6DX3zF0hM5
         a1xkgYbBgc8VRMFBcasoN8glw/0SE9dVSQq7GMAPC38wbEiRq/dhlMpPEk0Iqp6y8bpa
         YgDQ1XSPedcozSVBpeeV3NkzKN3jfUxNw+YfWI/HkKrRf9FKElzGNbgqfWfgdQ4dkxou
         5J4A==
X-Gm-Message-State: AOAM5304V7FJBFtUaUjFeydUs5eMJbmaD66JUQEgYWoGwnf1jhPA1W4N
        zPKMcS9Pl5gGCqZN6bSHAXVmSjzmAsVhFdwA/z4=
X-Google-Smtp-Source: ABdhPJynPgJ/Nqw+lNiPRJQ3l17TiAdcXoxm+BPkC7Xj2QtCkSfKQEjklEb8NhqaIQ0qwlXCkRw4pRODa0jMiBJ+bLk=
X-Received: by 2002:a25:d84a:: with SMTP id p71mr1143582ybg.347.1596141826255;
 Thu, 30 Jul 2020 13:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <05fb9d72-d1a7-5346-b55b-4495cdf54124@web.de> <CAEf4BzZfa0m2O4rBEMdN2N2dLeXCfMbwAohCZLevZ3F+mKenvA@mail.gmail.com>
 <6ac86da0-16f0-eb9e-010e-277cfdd555be@web.de>
In-Reply-To: <6ac86da0-16f0-eb9e-010e-277cfdd555be@web.de>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 30 Jul 2020 13:43:17 -0700
Message-ID: <CAEf4BzZE4a6Zz=zFdSg5j8dvu4PY_B8ZfznDv47R2ivaa-we-g@mail.gmail.com>
Subject: Re: [PATCH bpf] libbpf: Fix register in PT_REGS MIPS macros
To:     Jerry Cruntime <jerry.c.t@web.de>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 30, 2020 at 1:38 PM Jerry Cruntime <jerry.c.t@web.de> wrote:
>
> Hi,
>
>  > I've quickly looked up some doc on MIPS calling convention, doesn't
>  > seem like regs[8] is actually used for 5th input argument (the doc I
>  > found documented only the use of $4 through $7 for first 4 args).
>  > Should we drop PT_REGS_PARM5() for MIPS, while at it?
>
> My understanding is that with o32 only 4 arguments can be passed in
> registers ($4-$7). But n32 and n64 extended it to pass 8 arguments in
> registers ($4-$11).
>
> My source is "MIPS Run, Second Edition" from Dominic Sweetman table 11.2
> on page 327. It is also described here:
>
> https://en.wikipedia.org/wiki/Calling_convention#MIPS
>

Oh, right, I should have used Wikipedia instead. :)

Acked-by: Andrii Nakryiko <andriin@fb.com>

>
> On 7/30/20 9:55 PM, Andrii Nakryiko wrote:
> > On Thu, Jul 30, 2020 at 4:45 AM Jerry Cruntime <jerry.c.t@web.de> wrote:
> >>
> >> The o32, n32 and n64 calling conventions require the return
> >> value to be stored in $v0 which maps to $2 register, i.e.,
> >> the second register.
> >>
> >> Fixes: c1932cd ("bpf: Add MIPS support to samples/bpf.")
> >> ---
> >>    tools/lib/bpf/bpf_tracing.h | 2 +-
> >>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> >> index 58eceb884..ae205dcf8 100644
> >> --- a/tools/lib/bpf/bpf_tracing.h
> >> +++ b/tools/lib/bpf/bpf_tracing.h
> >> @@ -215,7 +215,7 @@ struct pt_regs;
> >>    #define PT_REGS_PARM5(x) ((x)->regs[8])
> >
> > I've quickly looked up some doc on MIPS calling convention, doesn't
> > seem like regs[8] is actually used for 5th input argument (the doc I
> > found documented only the use of $4 through $7 for first 4 args).
> > Should we drop PT_REGS_PARM5() for MIPS, while at it?
> >
> >>    #define PT_REGS_RET(x) ((x)->regs[31])
> >>    #define PT_REGS_FP(x) ((x)->regs[30]) /* Works only with
> >> CONFIG_FRAME_POINTER */
> >> -#define PT_REGS_RC(x) ((x)->regs[1])
> >> +#define PT_REGS_RC(x) ((x)->regs[2])
> >
> > This looks good, though.
> >
> >>    #define PT_REGS_SP(x) ((x)->regs[29])
> >>    #define PT_REGS_IP(x) ((x)->cp0_epc)
> >>
> >> --
> >> 2.17.1
