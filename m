Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8ED3383D5
	for <lists+bpf@lfdr.de>; Fri, 12 Mar 2021 03:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbhCLCqE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Mar 2021 21:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbhCLCpp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Mar 2021 21:45:45 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605D6C061763
        for <bpf@vger.kernel.org>; Thu, 11 Mar 2021 18:45:45 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id l2so14914750pgb.1
        for <bpf@vger.kernel.org>; Thu, 11 Mar 2021 18:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QU0VzfL9/lfvk4BOo6El/Igfm4hUidBDqCnte6ObskA=;
        b=dCt656rf528kGz65pkdCCRwvvb6LHMDAt1mGWptf+qA1H+D1fqonFC8NIlOt/4mplW
         SfLgdS9gaLGlL2B9nrZb48Pz4kn/Ry2TH/6Oafm8iapyD2b38tCNNwVi2kChy9sqiaHI
         yYrFQdLV5XU/tYDIPz05PWQzC2cCC0g7WMHLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QU0VzfL9/lfvk4BOo6El/Igfm4hUidBDqCnte6ObskA=;
        b=aTbFez2Pv53yatfpX0JQZGLRiBhh8fo/d0FLcCIhYpr+HPfPvQmaiT4yFZfLvotDc6
         0Gx/LFyHpCadmLB5EknttYhNIHNjRR0SPxq5i4e5YPc8POdJWCGJFFjYIUqzgTP6IUQ/
         nY/OtzR/tHTvQkh2GYnbcF3PLZp0k9g/8ArocL5X06iourSTpGB5WsOu/u6zPcE9b946
         n1WJD2oP3SUVeh4xWd0exQQvI9pm1dyxcsgR1z78oA2sTP676w900Akx5dNA/5k0tuic
         xfUivnSRKtmhv4cfcAAwURHNN4PcY2mbc+hkHwdYfMxErjINDlr+IVffGY6JZJaqR7Ue
         q/DQ==
X-Gm-Message-State: AOAM531hEUKYlPj7W8p/Mf3jT74ytOrfzMqEqsl4AELoh5wFUTcd03Xi
        wkqsXV7jXysa9d/oxCtCfr65OQ==
X-Google-Smtp-Source: ABdhPJyZjX0dDYfZgQFE6j3eol5QYVolHh+A3d7V2uX9uhucCEXJOChGVC9n8UJhMoVf/kiUBIdI6A==
X-Received: by 2002:a05:6a00:22c6:b029:201:1166:fdad with SMTP id f6-20020a056a0022c6b02902011166fdadmr2389793pfj.58.1615517145009;
        Thu, 11 Mar 2021 18:45:45 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i7sm2934089pgq.16.2021.03.11.18.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 18:45:44 -0800 (PST)
Date:   Thu, 11 Mar 2021 18:45:43 -0800
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
Subject: Re: [PATCH 10/17] lkdtm: use __va_function
Message-ID: <202103111845.1D52CBC1@keescook>
References: <20210312004919.669614-1-samitolvanen@google.com>
 <20210312004919.669614-11-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312004919.669614-11-samitolvanen@google.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 11, 2021 at 04:49:12PM -0800, Sami Tolvanen wrote:
> To ensure we take the actual address of a function in kernel text, use
> __va_function. Otherwise, with CONFIG_CFI_CLANG, the compiler replaces
> the address with a pointer to the CFI jump table, which is actually in
> the module when compiled with CONFIG_LKDTM=m.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
