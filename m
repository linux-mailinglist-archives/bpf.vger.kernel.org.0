Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE4F352604
	for <lists+bpf@lfdr.de>; Fri,  2 Apr 2021 06:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhDBEOi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Apr 2021 00:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhDBEOh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Apr 2021 00:14:37 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F625C06178A
        for <bpf@vger.kernel.org>; Thu,  1 Apr 2021 21:14:35 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j7so3692256wrd.1
        for <bpf@vger.kernel.org>; Thu, 01 Apr 2021 21:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aTF4DSgy0PHbD8hdS+0qJlLOgVDSXpSKNN+yUg9A0Hs=;
        b=IOwAv1pJyRJV4gn9mjCUoyrx9uKAxA+FBfNG9Mf4HIXV+pvQHAitUv7k5D3+aOt41l
         GgTI/wiTUT5w5zeKpjSfD/MrilhGKYx/6q2TpM7IabcdfcmJOlAjTqWunt61zo7wi708
         CGGDUhtD+1zL/KGi9MTQdV0YcKnKiDUn+wcriEoGsN9rH9BZ++dDSV4jof7EyvkIkNXI
         NNcdilvjzbV3PJxlQf0UEA3QYia9hqMrQl8WTpV0itVsIDOcez06rZ9/cRYZ9Rk3UFNu
         hg9I/2eIGjJ47UU7VT2oRMh14v1ZJQaKH9Zi8YWoZZCH+xi5ybGoghfYn4cHqMlRz8z1
         1dmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aTF4DSgy0PHbD8hdS+0qJlLOgVDSXpSKNN+yUg9A0Hs=;
        b=spJAtG21O8oTAm9L6T/O6wMmTukd6zHOrrwikzXYz05wg8zD+NIy1hlK3imDnV7uo3
         q3wWvV/qyZSonIAZV3z8+4z0CMIY91mc+sPOzr1qR7eIWR77h0QN8PpAkTsmCyrL6UvC
         4QT2OEXEL1X233PudO04oVXc6k8H1ZnFhzfjL/aE0U4sijnVOgr5IfhWodht9mOe9qZf
         l8RuNerzfL48nuse6ojVNyVkfRs9xsirPXuSVdyMAk4hjuMsnckCAzhug89AfXNJJ0tN
         XQdaIPiUKXWV4MfaRFsDi0ksoRypcQAcROowawy0vMRysi3/zcMXm6vAJzptPzNu7H/Q
         IZ8Q==
X-Gm-Message-State: AOAM530WKtQ3MZg/PeQKZhDJ6OcCysdwN8oqwODSJRY/jfyKX7HDUMTE
        l+iK8pa4zIFBA7++xXqgAbviKEZNv0cIkYyYkdne9Q==
X-Google-Smtp-Source: ABdhPJy7kkYMQxTXJp2WyoNHqq3yHqeByHqHc7dSE27OX8CeJmSRxaQ0rEoYl8xvHJs4qnnACcmvyAiguHo7lXT6Tuw=
X-Received: by 2002:a05:6000:c7:: with SMTP id q7mr13176764wrx.356.1617336873672;
 Thu, 01 Apr 2021 21:14:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210401002442.2fe56b88@xhacker> <20210401002949.2d501560@xhacker>
In-Reply-To: <20210401002949.2d501560@xhacker>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 2 Apr 2021 09:44:22 +0530
Message-ID: <CAAhSdy0p4g1o2xLbHXzMer7P=DgLjYfbiO4nYTU1gqPbLgLUKg@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] riscv: Set ARCH_HAS_STRICT_MODULE_RWX if MMU
To:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Luke Nelson <luke.r.nels@gmail.com>,
        Xi Wang <xi.wang@gmail.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        kasan-dev@googlegroups.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 31, 2021 at 10:05 PM Jisheng Zhang
<jszhang3@mail.ustc.edu.cn> wrote:
>
> From: Jisheng Zhang <jszhang@kernel.org>
>
> Now we can set ARCH_HAS_STRICT_MODULE_RWX for MMU riscv platforms, this
> is good from security perspective.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 87d7b52f278f..9716be3674a2 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -28,6 +28,7 @@ config RISCV
>         select ARCH_HAS_SET_DIRECT_MAP
>         select ARCH_HAS_SET_MEMORY
>         select ARCH_HAS_STRICT_KERNEL_RWX if MMU
> +       select ARCH_HAS_STRICT_MODULE_RWX if MMU
>         select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
>         select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
>         select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
> --
> 2.31.0
>
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
