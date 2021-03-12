Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1F43383C2
	for <lists+bpf@lfdr.de>; Fri, 12 Mar 2021 03:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbhCLCnz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Mar 2021 21:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbhCLCna (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Mar 2021 21:43:30 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251DEC061761
        for <bpf@vger.kernel.org>; Thu, 11 Mar 2021 18:43:30 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id nh23-20020a17090b3657b02900c0d5e235a8so10345613pjb.0
        for <bpf@vger.kernel.org>; Thu, 11 Mar 2021 18:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/xpt2hBBtW7abKxiGDhtHzeOxtHyWoss9DJQhg+zWHw=;
        b=fS3ImwrxxM2DE3EPiSqkkSbtg7AkezrPZEd01kE1dWcZszmGj9zSpFTelfDiqstTga
         WftPqqERieBGyxCVAYbjYrgDbk6A5YKAfLzSpkArBkvYk41+DSZTjZOqaRsE43dgsGh6
         xNgvTqcdZWxl1z22bhI6cbBrEqddMCMIaR2WM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/xpt2hBBtW7abKxiGDhtHzeOxtHyWoss9DJQhg+zWHw=;
        b=NmJ7BxJhFoR7AOvO0DLODciYcyEPiu7d205UnXr1bR3R29W3TKYbEnWaj+0vg7Ys6h
         FaEpEm9wgcy9zdJzT1P6wn4Aumy+tWCpMBuOB/i3RcdluKl1Gt+g0fRZ+gxwP3KdfjlN
         fgbvMkXVX3m5ZDs0SqU+zzoF8+T3QHwVpEUtszwyt2fbh4zjP1NJNHQzlymuVph4gBuw
         TyT8hLAoFkPGXS1lRkWMZMUZnSK+Phswk9TLitKizi5nbXRFjfNurhUrHT8pzbqHOoX7
         C3PRseGcXpc/bQ5pBZS33wC6q+Bxh68GaHnPblQkD0iGn2gpV1r+UzSbesHHgnwVE3VE
         0pmw==
X-Gm-Message-State: AOAM533URhv1zwamzihfrboRb7bxkaSMaBYPMVeB0WFNgOi/fWLIGf5G
        2XMvOfW1GpE4XfvpFnedYlSkDw==
X-Google-Smtp-Source: ABdhPJwJNeCPNAMR2ch3Yz24PwKhscrbLVrh74rWQAy51W9PeIe5O7weL/Cd+eYEYu9YKFOgM7LJSw==
X-Received: by 2002:a17:90b:686:: with SMTP id m6mr11513193pjz.26.1615517009803;
        Thu, 11 Mar 2021 18:43:29 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s19sm3652536pfh.168.2021.03.11.18.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 18:43:29 -0800 (PST)
Date:   Thu, 11 Mar 2021 18:43:28 -0800
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
Subject: Re: [PATCH 06/17] kthread: cfi: disable callback pointer check with
 modules
Message-ID: <202103111843.9456B460@keescook>
References: <20210312004919.669614-1-samitolvanen@google.com>
 <20210312004919.669614-7-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312004919.669614-7-samitolvanen@google.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 11, 2021 at 04:49:08PM -0800, Sami Tolvanen wrote:
> With CONFIG_CFI_CLANG, a callback function passed to
> __kthread_queue_delayed_work from a module points to a jump table
> entry defined in the module instead of the one used in the core
> kernel, which breaks function address equality in this check:
> 
>   WARN_ON_ONCE(timer->function != kthread_delayed_work_timer_fn);
> 
> Disable the warning when CFI and modules are enabled.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
