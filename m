Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84CE13383B4
	for <lists+bpf@lfdr.de>; Fri, 12 Mar 2021 03:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbhCLCkm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Mar 2021 21:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbhCLCkf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Mar 2021 21:40:35 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCD8C061764
        for <bpf@vger.kernel.org>; Thu, 11 Mar 2021 18:40:34 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id t29so842836pfg.11
        for <bpf@vger.kernel.org>; Thu, 11 Mar 2021 18:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wQ2W9gu3Osj3MdqScThl5MpYybHbMYo3x9B6R2Mk6L8=;
        b=NZXDAK2nVsB5XLAK6iQkiJruNlfdqCk+PJ5VanZ25OXi+Q7zOTY+NZjcnHTYoiEtfi
         5wk/CnP+uAgWsZoZ/bHZzWMDdnp91wseWZkkXoKIWJYj/tDgoqrTmJkkLAGNo4onaoRj
         d0ViJy+d71HMPrIzKYMvvRJfOnUHCkn/TdDgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wQ2W9gu3Osj3MdqScThl5MpYybHbMYo3x9B6R2Mk6L8=;
        b=Zf1Z7W1fz3Nn8yNOweKh2mHjorgHA7LLk1s6h9HCicjh3jexafq5T+F19HDJFjlzeo
         5gVOoWAZsN6GMeeayBxLQ7NjogDVT0e1+Hvkav3MfdPCZWnoX0sx3BWAAdqXkwWC8wTf
         +WCuayNZJeKSZ88SsSXj8T8r1FRimZFTq/Hydczff1W5KRsHWycDvgvXqNOBogxU103k
         3mmeh3BzMTJs1Cv0P2+oMjV61cBZbnrCHr3ZWYtIaea6oqzEggt1cJ1W6t6pVKAI3X5g
         ZygqxkAZsXYgcWnrMtUAtSi3+UaiFcofW6P3yiRWJU5wbQl0drNjF5OTM3GO6usgg09+
         iKQQ==
X-Gm-Message-State: AOAM533P8g00oXERRfk+UcbOpqIwQ5vCpOUJLbMjQlZ5S8nYe4wOu1Nr
        zqWEPPMh468D5w7Oot+hG4murA==
X-Google-Smtp-Source: ABdhPJz9mHRexfp/qVZ4vgjUgGk0DFoPnlAxOoA8yf6zI0h/vMdT7tBN76386sP73c1cfoYW99A5EA==
X-Received: by 2002:a63:4c55:: with SMTP id m21mr9740097pgl.29.1615516834269;
        Thu, 11 Mar 2021 18:40:34 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s62sm3689109pfb.148.2021.03.11.18.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 18:40:33 -0800 (PST)
Date:   Thu, 11 Mar 2021 18:40:32 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        bpf@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kbuild@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/17] mm: add generic __va_function and __pa_function
 macros
Message-ID: <202103111840.73C55A4A@keescook>
References: <20210312004919.669614-1-samitolvanen@google.com>
 <20210312004919.669614-4-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312004919.669614-4-samitolvanen@google.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 11, 2021 at 04:49:05PM -0800, Sami Tolvanen wrote:
> With CONFIG_CFI_CLANG, the compiler replaces function addresses
> in instrumented C code with jump table addresses. This means that
> __pa_symbol(function) returns the physical address of the jump table
> entry instead of the actual function, which may not work as the jump
> table code will immediately jump to a virtual address that may not be
> mapped.
> 
> To avoid this address space confusion, this change adds generic
> definitions for __va_function and __pa_function, which architectures
> that support CFI can override. The typical implementation of the
> __va_function macro would use inline assembly to take the function
> address, which avoids compiler instrumentation.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
