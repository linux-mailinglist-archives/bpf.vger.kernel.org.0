Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE830368F50
	for <lists+bpf@lfdr.de>; Fri, 23 Apr 2021 11:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhDWJ1k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Apr 2021 05:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbhDWJ1k (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Apr 2021 05:27:40 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DCCC061574
        for <bpf@vger.kernel.org>; Fri, 23 Apr 2021 02:27:03 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id l4so72881218ejc.10
        for <bpf@vger.kernel.org>; Fri, 23 Apr 2021 02:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sx864cJ9nz1GjChrLeVjiJWOVBxDhckrfyU12rLCtIM=;
        b=RVLGPUq/2uXKHX3VBqekN2rBvE6xjWWfHpG1V+dMk2KoZ3JMVvNdULeRLPPHdv0v+W
         c+sWQ0H6V+Izrh1Iod17fOG7mthcwptwZwCkaksW+6/eThf/Ov743lju8KJQy3CPQ7II
         Bi8SCS2eQndZKRRyyhd+CHa97zDl/sLiK7w2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sx864cJ9nz1GjChrLeVjiJWOVBxDhckrfyU12rLCtIM=;
        b=Qld4WjVK1nzj8ddwqG+qm1p2MxmkVGXDU7LSYoyQqQxNfpiQSFLBZbAmggckQOJPWu
         Du2rYr6pp/yAr8/C2dgap8XUo8zk4MGoHhHKi49gguqP/DQyH3Mz3Wpc3Y6w3Tqk6V3f
         DxeA5hAhKD7hCfjOmid65M8UHlI26/ai+HzHbXFkULc6jsaX41Mm5V7ciCmkLsXB/W7j
         Rv2gckrOft1zW0trf0R31Y5P2spEaZfWxSUUCXkRVKKdGLrd06JEEvgc+qagWF7IdiqK
         zN/avOYHDGPLBc+Y5r1+3aH98hNzOmDGBnCNaCCo54uvtryOowNtTkxTJ5M6pUa2r1w9
         YoUg==
X-Gm-Message-State: AOAM5327N+64dKkLXuiBhfrzDqDuo77j0ZDjtrhowfqddzB65Dh83c0z
        qYIlrSc5+akyGiol0cS+W1q98w==
X-Google-Smtp-Source: ABdhPJxkXQb5uiylmDY2V93WELe9Zadfag5FXoXKd0c2vGX77x04oLiMnKfVyynFHYyi0MCkYBLJmA==
X-Received: by 2002:a17:906:7257:: with SMTP id n23mr3255833ejk.412.1619170022630;
        Fri, 23 Apr 2021 02:27:02 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id x7sm4208167eds.67.2021.04.23.02.27.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 02:27:02 -0700 (PDT)
Subject: Re: [PATCH bpf-next 2/2] bpf: Implement formatted output helpers with
 bstr_printf
To:     Florent Revest <revest@chromium.org>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@kernel.org, jackmanb@google.com,
        linux-kernel@vger.kernel.org
References: <20210423011517.4069221-1-revest@chromium.org>
 <20210423011517.4069221-3-revest@chromium.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <ebe46a2a-92f8-8235-ecd8-566a46e41ed5@rasmusvillemoes.dk>
Date:   Fri, 23 Apr 2021 11:27:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210423011517.4069221-3-revest@chromium.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 23/04/2021 03.15, Florent Revest wrote:
> BPF has three formatted output helpers: bpf_trace_printk, bpf_seq_printf
> and bpf_snprintf. Their signatures specifies that arguments are always
> provided from the BPF world as u64s (in an array or as registers). All
> of these helpers are currently implemented by calling functions such as
> snprintf() whose signatures take arguments as a va_list.

It's nitpicking, but I'd prefer to keep the details accurate as this has
already caused enough confusion. snprintf() does not take a va_list, it
takes a variable number of arguments.

> To convert args from u64s to a va_list 

No, the args are not converted from u64 to a va_list, they are passed to
said variadic function (possibly after zeroing the top half via an
interim cast to u32) as 64-bit arguments.

"d9c9e4db bpf: Factorize
> bpf_trace_printk and bpf_seq_printf" introduced a bpf_printf_prepare
> function that fills an array of arguments and an array of modifiers.
> The BPF_CAST_FMT_ARG macro was supposed to consume these arrays and cast
> each argument to the right size. However, the C promotion rules implies
> that every argument is stored as a u64 in the va_list.

"that every argument is passed as a u64".

> 
> To comply with the format expected by bstr_printf, certain format
> specifiers also need to be pre-formatted: %pB and %pi6/%pi4/%pI4/%pI6.
> Because vsnprintf subroutines for these specifiers are hard to expose,

Indeed, as lib/vsnprintf.c reviewer I would very likely NAK that.

> we pre-format these arguments with calls to snprintf().

Nothing to do with this patch, but wouldn't it be better if one just
stored the 4 or 16 bytes of ip address in the buffer, and let
bstr_printf do the formatting?

The derefencing of the pointer must be done at "prepare" time, but I
don't see the point of actually doing the textual formatting at that
time, when the point of BINARY_PRINT is to get out of the way as fast as
possible and punt the decimal conversion slowness to a later time.

I also don't see why '%pB' needs to be handled specially, other than the
fact that bin_printf doesn't handle it currently; AFAICT it should be
just as safe as 'S' and 's' to just save the pointer and act on the
pointer value later.

Rasmus
