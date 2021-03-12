Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0205E3383DB
	for <lists+bpf@lfdr.de>; Fri, 12 Mar 2021 03:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbhCLCqE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Mar 2021 21:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbhCLCpx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Mar 2021 21:45:53 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1712C061763
        for <bpf@vger.kernel.org>; Thu, 11 Mar 2021 18:45:52 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 16so8488276pgo.13
        for <bpf@vger.kernel.org>; Thu, 11 Mar 2021 18:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fac5qEwtGUhYp0i9UgwCZogHJ9c5ndld0feZGyCBugw=;
        b=Yf1jNw5HL2aTwVR53Xw1DAzotE73G/J5yX4CJQJM+XgSnLG8J+vcgPlTdkWIsbuxH6
         QLetB8TZJzSr1rGbx8bLv9sUGwRivp/1eoW5SZQo+X5smcoP6bJxSpB38YAMtOOcS0+B
         DCLkvZloqcKPnWQPN8dAzDhjkMWed0N6lx+N8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fac5qEwtGUhYp0i9UgwCZogHJ9c5ndld0feZGyCBugw=;
        b=QfEHDPfyR558+OGJtXofbLZzNCrZZF0/iStczdWyl/SwBNqo7UcRG9XZDDgF8pdM+G
         wNiwH6+/hMZ3a/dyORmjl3epLGjesIhm01KwBuIysjlf204qjHC/KZ3kSSCGLyfvZ34M
         q19jTTfEQVUXmxABSjASAZBPLQKP2ACMx62aXWURHrRCj0norHS3GdxdSBh2lYEFYdg2
         tgRuHF8eBy5mDJVlnFoBdp9rFyxA7opBMLBnzIzEkkwWaLRQubEHhWJWGkERMec66kG+
         GH6tAsxmXZq8g5edygLUcWxJc3rFVo6mHt/fAJiuyrK+s32/qN7PHg1eW1Vlao6IjZEg
         3jbg==
X-Gm-Message-State: AOAM531RHxlBEJjDkrwDP06rS6uWRBey16+YtgJFlwzKahskJIArGiQ6
        qqX4Fb1BN5i02KaUNQDxtkRygjuO8hIkpg==
X-Google-Smtp-Source: ABdhPJwkatQTgQrGNraBkT/X2lsgOwTQFo5tDOWcr2Yd9maNZVjYw6Sy3JQXdf01TBLr7xwbPU4otA==
X-Received: by 2002:a62:35c2:0:b029:1f1:3a8b:83d5 with SMTP id c185-20020a6235c20000b02901f13a8b83d5mr10327491pfa.29.1615517152536;
        Thu, 11 Mar 2021 18:45:52 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n184sm3522810pfd.205.2021.03.11.18.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 18:45:51 -0800 (PST)
Date:   Thu, 11 Mar 2021 18:45:51 -0800
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
Subject: Re: [PATCH 11/17] psci: use __pa_function for cpu_resume
Message-ID: <202103111845.6E00D2E@keescook>
References: <20210312004919.669614-1-samitolvanen@google.com>
 <20210312004919.669614-12-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312004919.669614-12-samitolvanen@google.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 11, 2021 at 04:49:13PM -0800, Sami Tolvanen wrote:
> With CONFIG_CFI_CLANG, the compiler replaces function pointers with
> jump table addresses, which results in __pa_symbol returning the
> physical address of the jump table entry. As the jump table contains
> an immediate jump to an EL1 virtual address, this typically won't
> work as intended. Use __pa_function instead to get the address to
> cpu_resume.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
