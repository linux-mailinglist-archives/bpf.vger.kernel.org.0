Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00557294E4E
	for <lists+bpf@lfdr.de>; Wed, 21 Oct 2020 16:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443327AbgJUONC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Oct 2020 10:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443322AbgJUONC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Oct 2020 10:13:02 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7993FC0613D2
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2020 07:13:02 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id y20so3303790iod.5
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2020 07:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uIZP42Vh+ckbjFikdJfke/JG3gnAQkbegdmiTzAtVuQ=;
        b=qr0IsgILjZxYrcVxGnK0xMFQSsO4X2yUBYbxxx5/nLK7I4WUdVcGC+34t4t24//QSL
         lTi4C0rDLabB3WIATPVWq7Gx/tClFCZ26ycN9QS95x4RDvZp0J2sXw5D+VUWn4HeevL5
         9mlEyDGjiTobyQUQ1YoHuLvss6/a2hI2Ib37yCMMxKF4C+EtpbfKXE2vZDIEdir5FO5t
         bdD5Z5+CdQOc8gOIcQ1DIcd8CmBk0YUtQLxA/TQEDeSKFQWQ/gFiITJ6VXJsfUHk+84M
         XmTk8SnOYNiwPKDMCnkIhk1n0PZuZLgZsSosmhg96ZH/wYjZ8O5PZ3awgID9f+9DFC98
         DMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uIZP42Vh+ckbjFikdJfke/JG3gnAQkbegdmiTzAtVuQ=;
        b=TtopLqPsCsUZ651jnlheidWYHiLB25FLXa4LzSY46RKrtJnEIy4laW0I/Djsg+1n6j
         4MTlztgEStueo9nrCFx8Kak57t7uikeKfMd3uyNb7fPFvtBnBiFKoR+IXEOoNSZmscGH
         RLYj66ek4unKO5Q4Z+BfLDCK1bObUGDz2yVccrO9qogAXM8VasBuSMPOGxvodV/NrwDx
         m2EhbpMfmpzzEOhadjOJnoYxnfm5VmEjHWc2nh8Okrq5D+QQYfWqpwhWvuu24p5dxMwl
         mdIKofl1qCbni9C1rNo8W6mMkQ0YhMC4Ge1piASXvHCd5SaP8uabhXCkfAgIVLexbaQY
         C17Q==
X-Gm-Message-State: AOAM530DfLAVpz6HmfVPQiqCFU9pX1RUt1IJKC5z+WB4fBneTY6RNWIB
        1Wbocj9bweLgWp9Y6cLhYa7i7dTsAmkqqscwskdeXg==
X-Google-Smtp-Source: ABdhPJwb36VWE/96YU44fNuEzYtyD4OBEaEHy05VO9xeNMg79V+hWEmkV1UktkKwfQgUqer4fxUfs/k/5T92j2nxOgY=
X-Received: by 2002:a6b:8b95:: with SMTP id n143mr442371iod.36.1603289581571;
 Wed, 21 Oct 2020 07:13:01 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20201021063555eucas1p24f8486354866fea4640a8f28e487d3c4@eucas1p2.samsung.com>
 <CA+G9fYuL9O2BLDfCWN7+aJRER3sQW=C-ayo4Tb7QKdffjMYKDw@mail.gmail.com> <12dfa2bb-e567-fb42-d74f-5aaa0c5c43df@samsung.com>
In-Reply-To: <12dfa2bb-e567-fb42-d74f-5aaa0c5c43df@samsung.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 21 Oct 2020 19:42:50 +0530
Message-ID: <CA+G9fYsoJgvVi0rU-HgvKWEYFTtXopxd+0-L0Um41-g2HMHL3Q@mail.gmail.com>
Subject: Re: arm64 build broken on linux next 20201021 - include/uapi/asm-generic/unistd.h:862:26:
 error: array index in initializer exceeds array bounds
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Netdev <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian@brauner.io>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 21 Oct 2020 at 12:06, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> Hi Naresh,
>
> On 21.10.2020 07:05, Naresh Kamboju wrote:
> > arm64 build broken while building linux next 20201021 tag.
> >
> > include/uapi/asm-generic/unistd.h:862:26: error: array index in
> > initializer exceeds array bounds
> > #define __NR_watch_mount 441
> >                           ^
> >
> > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
>
> Conflict resolution in commit 5394c6318b32f is incomplete.
>
> This fixes the build:

Thanks for the patch.
I have applied this patch and build pass on arm64.
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>

>
> diff --git a/arch/arm64/include/asm/unistd.h
> b/arch/arm64/include/asm/unistd.h
> index b3b2019f8d16..86a9d7b3eabe 100644
> --- a/arch/arm64/include/asm/unistd.h
> +++ b/arch/arm64/include/asm/unistd.h
> @@ -38,7 +38,7 @@
>   #define __ARM_NR_compat_set_tls (__ARM_NR_COMPAT_BASE + 5)
>   #define __ARM_NR_COMPAT_END            (__ARM_NR_COMPAT_BASE + 0x800)
>
> -#define __NR_compat_syscalls           441
> +#define __NR_compat_syscalls           442
>   #endif
>
>   #define __ARCH_WANT_SYS_CLONE
> diff --git a/include/uapi/asm-generic/unistd.h
> b/include/uapi/asm-generic/unistd.h
> index 094a685aa0f9..5df46517260e 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -863,7 +863,7 @@ __SYSCALL(__NR_process_madvise, sys_process_madvise)
>   __SYSCALL(__NR_watch_mount, sys_watch_mount)
>
>   #undef __NR_syscalls
> -#define __NR_syscalls 441
> +#define __NR_syscalls 442
>
>   /*
>    * 32 bit systems traditionally used different
>

- Naresh
