Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA9433DF79
	for <lists+bpf@lfdr.de>; Tue, 16 Mar 2021 21:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbhCPUrZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Mar 2021 16:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbhCPUou (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Mar 2021 16:44:50 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D027C0613D7
        for <bpf@vger.kernel.org>; Tue, 16 Mar 2021 13:44:46 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id q1so16010917vsq.6
        for <bpf@vger.kernel.org>; Tue, 16 Mar 2021 13:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tLa3leTdMzh1rknpkLUWnm0PAOSso4HRgQA5K7IK6MM=;
        b=e+TXEaCKvma4VGpnwpOaaFkLknHBGuDmEKybhDxTF83sGcUnhvMjnyd4FKoakznEV3
         L+49y3mjg3y9zPjYOau5jDdMUzS1QeQc8EZHIuCnYCEvlu/U3MIphrqZ/uP5UmkwxxeL
         +/myGc8pDphpzzZ7FTh/9hJKxPT9p26Ia2eDhTGk6iETFEiye/52lqU41RoUHrn74DWh
         Z9MX2qar1Tdy5UlVzs8F5VgOHw+sA5zNyUhbhgEJg7yulcKmANZ/MdTHXU3HQZNR3/3z
         jprq7sQ3GQvcxl+Y7QEUl59VHWT5WD2/UpeliEvsAr6IQyyxoheHA9cHYYw051xuDx5U
         BC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tLa3leTdMzh1rknpkLUWnm0PAOSso4HRgQA5K7IK6MM=;
        b=r3N+uSIFwa7RSi154VVijwG1BZsBuA1kDvqDFQbMKefPViVRY6Qf3AiWXuq27C2gep
         39ZLJX8kdam5ZTpsAmsgv2we1s0ItAIPulpGZRNrkGOjoej4DU2caPZhiPvt+1z4KGaB
         aTn0IJStHQipbb8OcRMhCUtkouEUPSelJ+nfFPNIGsv+GyNXY2mz+vOecqJ+5elJC5Ju
         TeSewe4jVnCvRWTm0Fg6I3QgzmzTpi1Saxt2Oku+Kysj7bmXuGysp841X8dy0iyodU+B
         2yJZQ+m119t1tcaz3AMNrYqxmMiEWp89OFU1Cm01hKOcUK2EjsdGfTZuY22wczzqohyE
         MlQA==
X-Gm-Message-State: AOAM533+qRZne1QHSNBcdWivJlEYx2EXdFR8euxOFsbokGffw9EF9mK4
        KoJVeOqybGSMYBf0gWbjXFGpUG+4NJiNgkmQjkTjOQ==
X-Google-Smtp-Source: ABdhPJwQSd1vGWBZTCJlQRmCK62EXrLyrNMXIW37KTTCmpBtYEbzwPtXhGB1KcQUzWMwYntm7fopfaHU36IppUu0V+Q=
X-Received: by 2002:a67:db98:: with SMTP id f24mr1241866vsk.13.1615927484959;
 Tue, 16 Mar 2021 13:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210312004919.669614-1-samitolvanen@google.com>
 <20210312004919.669614-18-samitolvanen@google.com> <202103111851.69AA6E59@keescook>
In-Reply-To: <202103111851.69AA6E59@keescook>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 16 Mar 2021 13:44:33 -0700
Message-ID: <CABCJKucpFHC-9rvT7uNF+E-Jh20fz69zdO49_4p8G_Sb634qmw@mail.gmail.com>
Subject: Re: [PATCH 17/17] arm64: allow CONFIG_CFI_CLANG to be selected
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        bpf@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 11, 2021 at 6:51 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Mar 11, 2021 at 04:49:19PM -0800, Sami Tolvanen wrote:
> > Select ARCH_SUPPORTS_CFI_CLANG to allow CFI to be enabled.
> >
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> Random thought: the vDSO doesn't need special handling because it
> doesn't make any indirect calls, yes?

That might be true, but we also filter out CC_FLAGS_LTO for the vDSO,
which disables CFI as well.

Sami
