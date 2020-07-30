Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA9AC233962
	for <lists+bpf@lfdr.de>; Thu, 30 Jul 2020 21:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgG3TzR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Jul 2020 15:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgG3TzR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Jul 2020 15:55:17 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9DAC061574
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2020 12:55:17 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id m200so10912969ybf.10
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2020 12:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KX7TeDjPQ7EVZGMXY4RQRx8bYziXlBMDvDcMgfig7vo=;
        b=tChmC1csY+mS7x5Nv7xbVkbjeIDEXIKZ3YjDLEky36CBdGVzLcBN6dfXujiJkfzgQB
         +kMHvvuP0ny7tHd2TzZ9Fs/VoZEFg5wl9Em1QQ6DeAQeuQFTAsulhqkx+iQSvaFrQkyc
         rF8qiRnCl00kYK9lFCY5XHNhsdPMm3ajt8/5aq4vYm81rbbdf/EFu1PxK99X3J6/GxjZ
         9YVz38fMWfCpY7xpWO2vOF13SuMnwHwxH1Y/plubQ0/nTNImROwCffIodBYs5gKWFS/P
         0FwXRiZnoSCqdlXRJkLNtK4ughvkHud2aP4OMxPvTF0nbJLyMGGG2lp4N2KsE60Ko58O
         y1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KX7TeDjPQ7EVZGMXY4RQRx8bYziXlBMDvDcMgfig7vo=;
        b=CJ1spK4X+ehmraohUizuGKMgYZbQqV62ryhf2P8Aq518TX+MrwsEHrlAW3ls9EDwFy
         5KsRyaOIYwyy5/jlHSJ9XaDFYYRj9eXhgW/w57bm8wqoXA1MGXeSzCfkZZ2C9nxGpuN7
         J56tWowIBAgNPvtBJ9YUIir9Mw4LwuSUxfbjm3NrSDedO+sMcz8bKXHfk8pjogkJGKVb
         X8ctD0By/b2mJoDIeiyhCzJ5lgG2uH+v+nDT8w7VHcwgyKt1PEdGOeKd/EUOeh5oSrHP
         3/Dv70TAhCEKNnjvx7Mj0M9IErHdybrH0y+61DozQDmkfbb1v1X3LXkCEEyAciv7zSA/
         pTLA==
X-Gm-Message-State: AOAM533783fhbvgx4PP41/8t5qCKgKob6fUgZYAhpeW/QooTTLWVRsk2
        SNlXw3+6tlsMQDDBnITrVBxNEMw3cetHx6jQS7/u5w==
X-Google-Smtp-Source: ABdhPJxF9wa4aypFj6Cv/cec1CkkRRYgt4PAHsJZD1DSIIwG367Ocpw/IbCHRF2OITibw3Ez15SRVi6DEaBm8kNM3ck=
X-Received: by 2002:a25:824a:: with SMTP id d10mr875050ybn.260.1596138916622;
 Thu, 30 Jul 2020 12:55:16 -0700 (PDT)
MIME-Version: 1.0
References: <05fb9d72-d1a7-5346-b55b-4495cdf54124@web.de>
In-Reply-To: <05fb9d72-d1a7-5346-b55b-4495cdf54124@web.de>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 30 Jul 2020 12:55:05 -0700
Message-ID: <CAEf4BzZfa0m2O4rBEMdN2N2dLeXCfMbwAohCZLevZ3F+mKenvA@mail.gmail.com>
Subject: Re: [PATCH bpf] libbpf: Fix register in PT_REGS MIPS macros
To:     Jerry Cruntime <jerry.c.t@web.de>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 30, 2020 at 4:45 AM Jerry Cruntime <jerry.c.t@web.de> wrote:
>
> The o32, n32 and n64 calling conventions require the return
> value to be stored in $v0 which maps to $2 register, i.e.,
> the second register.
>
> Fixes: c1932cd ("bpf: Add MIPS support to samples/bpf.")
> ---
>   tools/lib/bpf/bpf_tracing.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> index 58eceb884..ae205dcf8 100644
> --- a/tools/lib/bpf/bpf_tracing.h
> +++ b/tools/lib/bpf/bpf_tracing.h
> @@ -215,7 +215,7 @@ struct pt_regs;
>   #define PT_REGS_PARM5(x) ((x)->regs[8])

I've quickly looked up some doc on MIPS calling convention, doesn't
seem like regs[8] is actually used for 5th input argument (the doc I
found documented only the use of $4 through $7 for first 4 args).
Should we drop PT_REGS_PARM5() for MIPS, while at it?

>   #define PT_REGS_RET(x) ((x)->regs[31])
>   #define PT_REGS_FP(x) ((x)->regs[30]) /* Works only with
> CONFIG_FRAME_POINTER */
> -#define PT_REGS_RC(x) ((x)->regs[1])
> +#define PT_REGS_RC(x) ((x)->regs[2])

This looks good, though.

>   #define PT_REGS_SP(x) ((x)->regs[29])
>   #define PT_REGS_IP(x) ((x)->cp0_epc)
>
> --
> 2.17.1
