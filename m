Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B417D2C7720
	for <lists+bpf@lfdr.de>; Sun, 29 Nov 2020 02:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbgK2BOz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 28 Nov 2020 20:14:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgK2BOy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 28 Nov 2020 20:14:54 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5648C0613D1;
        Sat, 28 Nov 2020 17:14:08 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id s2so4504304plr.9;
        Sat, 28 Nov 2020 17:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7Vdc2IIjLuJX89GJ0THfSs30PM6I9wmP3XLI+A572XE=;
        b=iSRE5RRozVE0f7VVMTLVYqaEiIHzerZCbN2ogjnFS39fxGsLj2JcNHlZk812i090oN
         v5lQRCWuc/Jap3tICWNtHI+2Db5tBfGzatAtY7KVSAzdYV9K6ev9TuEKi1EHMJHiki8B
         wh229CzCH6qGVqhpZHjJ8itTsPCRBrrnjACK6IX6Ta2r0Hzz75RxPhwpo/JSfqBZJmFu
         JcOtzLJOZgyVhbBblP0JiIJXLoRqVA4SgokWZLUXDIY2Ept38NKiSBDrlkXVj+28j+Hl
         3SHuyDuvHs0rrs0mQzoen4OoX8OtF28TB7ltfeAvDdt8ScB93OCJrCzgcV7l5u8f/2hj
         G9sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7Vdc2IIjLuJX89GJ0THfSs30PM6I9wmP3XLI+A572XE=;
        b=Troublc+xsy1uRaukGfOLwdT6UwOTbiTlyjwpi1tEQs4apRJH6p/xsdQRlKPKuJ9Ry
         fD40m4c5/2fq7zutrprxT5PMMo3I6xhdbydAnZM/ZElcjo3nPZ7Daldy0Tqg/YlWEMnw
         h3REsgJQ+AKz0/22WSjnWV8GicckcT39XL5fHH2zKcdkwJmfc/pDjzblwzZ8v8o8AzCi
         mM903BkMtcOof+6bTtfMjTjtk1rZT9NzMECu/zFvjO9r6man9hB9QDIIzFt1arcQvmqV
         AtHer7/Fd9QxwD8AupbAyFvyZt6nDo9VeCM0CR/TPVN806VQCLBX//WUiTk8Ryh6KPCj
         R8fA==
X-Gm-Message-State: AOAM533d+O/0XGdpM2IcZ/ShoqnOZ0GbCanIcHHsNHEszjMGopi89zEt
        RYQi/yXQapF8h6izKsoSxmc=
X-Google-Smtp-Source: ABdhPJwtmh6uQ5W/I5bhdKWJRhsVSplRyXRucPcu6ktBa/eUR6evtbouOZ51E+wlplns9EBfCmFMmA==
X-Received: by 2002:a17:902:8f82:b029:da:23e0:17d7 with SMTP id z2-20020a1709028f82b02900da23e017d7mr13111355plo.37.1606612448067;
        Sat, 28 Nov 2020 17:14:08 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:400::5:5925])
        by smtp.gmail.com with ESMTPSA id r68sm12030337pfr.113.2020.11.28.17.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 17:14:06 -0800 (PST)
Date:   Sat, 28 Nov 2020 17:14:05 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Brendan Jackman <jackmanb@google.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 bpf-next 02/13] bpf: x86: Factor out emission of REX
 byte
Message-ID: <20201129011405.vai66tyexpphpacb@ast-mbp>
References: <20201127175738.1085417-1-jackmanb@google.com>
 <20201127175738.1085417-3-jackmanb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201127175738.1085417-3-jackmanb@google.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 27, 2020 at 05:57:27PM +0000, Brendan Jackman wrote:
> The JIT case for encoding atomic ops is about to get more
> complicated. In order to make the review & resulting code easier,
> let's factor out some shared helpers.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  arch/x86/net/bpf_jit_comp.c | 39 ++++++++++++++++++++++---------------
>  1 file changed, 23 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 94b17bd30e00..a839c1a54276 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -702,6 +702,21 @@ static void emit_modrm_dstoff(u8 **pprog, u32 r1, u32 r2, int off)
>  	*pprog = prog;
>  }
>  
> +/*
> + * Emit a REX byte if it will be necessary to address these registers

What is "REX byte" ?
May be rename it to maybe_emit_mod() ?

> + */
> +static void maybe_emit_rex(u8 **pprog, u32 reg_rm, u32 reg_reg, bool wide)

could you please keep original names as dst_reg/src_reg instead of reg_rm/reg_reg ?
reg_reg reads really odd and reg_rm is equally puzzling unless the reader studied
intel's manual. I didn't. All these new abbreviations are challenging for me.
> +{
> +	u8 *prog = *pprog;
> +	int cnt = 0;
> +
> +	if (wide)

what is 'wide' ? Why not to call it 'bool is_alu64' ?

> +		EMIT1(add_2mod(0x48, reg_rm, reg_reg));
> +	else if (is_ereg(reg_rm) || is_ereg(reg_reg))
> +		EMIT1(add_2mod(0x40, reg_rm, reg_reg));
> +	*pprog = prog;
> +}
