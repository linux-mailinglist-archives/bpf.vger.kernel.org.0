Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85F8B338407
	for <lists+bpf@lfdr.de>; Fri, 12 Mar 2021 03:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbhCLCv0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Mar 2021 21:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbhCLCvB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Mar 2021 21:51:01 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD44C061762
        for <bpf@vger.kernel.org>; Thu, 11 Mar 2021 18:51:00 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id kr3-20020a17090b4903b02900c096fc01deso10347537pjb.4
        for <bpf@vger.kernel.org>; Thu, 11 Mar 2021 18:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jgKB3A92D5gwIxX7ZNPTWJNkyox2kFXe9uVkjxxztms=;
        b=Byp8VJLq4cTqNlyW1jcVtPh0g5LN5iNS4eR11K81JCbvgPvNMAhVXh9Gd+468WpnBc
         lejZk+bqLROi5s87MT9mO+QL80AzVMLefAwEp4YN4MFXFOgzdc//xji3nbCrTC8EviEH
         //3c1oVgTFeQhQtFuqphdUQ4neW/w26ZyRino=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jgKB3A92D5gwIxX7ZNPTWJNkyox2kFXe9uVkjxxztms=;
        b=uCJPJ4S8uW548HN7tZc8cqibxShS6Vw7VSPxWDEJxkG67jQrGfGLOfR83H30MnonQk
         wHPSlV78PnCbvoT+elmjDk6Q47OH5ugUAyDzV3iwwhG1ewAY9gI0ZFqMujiXaTVOMFaQ
         zCpeDgpBrSoYCDrS+1mMAhsAooxtJGOqJ9nFfVpSA8hMxibanmYkG35XZcOZ1zdID96S
         VZ9g9nTIiWBXdQMLE9kRkvnmVofBqPXkWQ8J7ejvjCWvFAdyAFlCPJ/4tTdghAGQibXl
         7b4PZKMk4E4r3kEI8Y45jKGdZI/Lpa5ZxZdz2b3ZBdaQrrNID0CI2GjR5xgagjypi7r3
         VxJg==
X-Gm-Message-State: AOAM533RBg+ZKq1Vmos9IQja0jhCVVsTih9JSdeF8aOTh6DU5xXXB7on
        CZ3Dk+aokJs326OdY5QDvlQGfg==
X-Google-Smtp-Source: ABdhPJwAHxl/NS7FlgAJRz5QaAvQOXkfhkHGZcnAZkR6rCdXdtzDyILaDAk8TTtJWufQKkWHZbPLwA==
X-Received: by 2002:a17:903:4093:b029:e5:b933:fab7 with SMTP id z19-20020a1709034093b02900e5b933fab7mr11028894plc.11.1615517460606;
        Thu, 11 Mar 2021 18:51:00 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w188sm3656858pfw.177.2021.03.11.18.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 18:50:59 -0800 (PST)
Date:   Thu, 11 Mar 2021 18:50:59 -0800
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
Subject: Re: [PATCH 16/17] KVM: arm64: Disable CFI for nVHE
Message-ID: <202103111850.163D807@keescook>
References: <20210312004919.669614-1-samitolvanen@google.com>
 <20210312004919.669614-17-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312004919.669614-17-samitolvanen@google.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 11, 2021 at 04:49:18PM -0800, Sami Tolvanen wrote:
> Disable CFI for the nVHE code to avoid address space confusion.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
