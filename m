Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F7F3383BD
	for <lists+bpf@lfdr.de>; Fri, 12 Mar 2021 03:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbhCLCnV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Mar 2021 21:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbhCLCnU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Mar 2021 21:43:20 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC46C061763
        for <bpf@vger.kernel.org>; Thu, 11 Mar 2021 18:43:20 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id lr1-20020a17090b4b81b02900ea0a3f38c1so2572023pjb.0
        for <bpf@vger.kernel.org>; Thu, 11 Mar 2021 18:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BNPsz0QLD3vM6+qNFMQ0OL0lFNeTebIONp/Q9dpVBmA=;
        b=QFHHVkV6BruBDLSqpSS5ZgpkzbKbFL9XcSmhEzK11y2mzkKvPQY9xpKatfo/Os2Tcd
         vIbekihgbpvMJcPrRh8gScKUhr1OSYBQOHteZqL4n+5ye8SOoMq6eXo3GEVPYy8bBb5Y
         7GtOMqPoVrJccKwnjRy9eXNFAdum8kSTxSXaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BNPsz0QLD3vM6+qNFMQ0OL0lFNeTebIONp/Q9dpVBmA=;
        b=hp+jvc7H1OYjrwpaoSoLKYRkBa9H9cOCYG3OB+LDn3QHgfub6B9JgGiDVgLnhhN9qG
         K2I6H7sUA0HP1Yu8xlOa4B3hco79E1AKs9shTTi6f1UvYJ4CRmBacjS2IoQ6fQOcOA8y
         0PceITfStmXLXZp+rf/vte/eTsmcYUy/GH9O+jk0SLAxyStIbeG7u1gY5epDg6X9iZ4i
         uUBt27S2U9P8g+rQNH9YM1IY/r0fGVenJpIIuGjeX9sltNw+CsLrra7TbRzTy7twnlR5
         iwb3xNSbYq1q+nt1uPvOSmmeUprDH4Fy3zkrH7Yiyc5VD2jQMIEGyU0+rLh/09rrxWDV
         am/Q==
X-Gm-Message-State: AOAM5333OaGrtOBvIIMANAbk7iGzcg/tkeyQOuxpL2GBvF/GJbS4dlZs
        bWBVhIu5GPFpbhfwxZtpFwm7Rw==
X-Google-Smtp-Source: ABdhPJwFKoCF8whxDXdLUhHjkHxm4/5ycmKLMkKhBI3hwmAY7tNoQI3rQR7e3wSMLF56vcYEDo4ITg==
X-Received: by 2002:a17:902:9a45:b029:e6:1444:5287 with SMTP id x5-20020a1709029a45b02900e614445287mr11337807plv.54.1615517000236;
        Thu, 11 Mar 2021 18:43:20 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d2sm382256pjx.42.2021.03.11.18.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 18:43:19 -0800 (PST)
Date:   Thu, 11 Mar 2021 18:43:18 -0800
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
Subject: Re: [PATCH 05/17] workqueue: cfi: disable callback pointer check
 with modules
Message-ID: <202103111840.58C5D95F@keescook>
References: <20210312004919.669614-1-samitolvanen@google.com>
 <20210312004919.669614-6-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312004919.669614-6-samitolvanen@google.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 11, 2021 at 04:49:07PM -0800, Sami Tolvanen wrote:
> With CONFIG_CFI_CLANG, a callback function passed to
> __queue_delayed_work from a module points to a jump table entry
> defined in the module instead of the one used in the core kernel,
> which breaks function address equality in this check:
> 
>   WARN_ON_ONCE(timer->function != delayed_work_timer_fn);
> 
> Disable the warning when CFI and modules are enabled.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
