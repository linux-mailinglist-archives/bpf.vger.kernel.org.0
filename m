Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E839A2DD878
	for <lists+bpf@lfdr.de>; Thu, 17 Dec 2020 19:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgLQSfb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Dec 2020 13:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728143AbgLQSfb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Dec 2020 13:35:31 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D357C061794;
        Thu, 17 Dec 2020 10:34:50 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id b8so9627800plx.0;
        Thu, 17 Dec 2020 10:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=im+tZE/kWm/ZYSPYhJ4SO9Qym9+PRjpn700kp4DBAS8=;
        b=FQzovURv8bA6Lx3cQIIXpJewCy4TM5boS6zU16dq/LKS3boHJ4pUrZApa66UZzb/+c
         RpT2UlDCXIaqUTTBnin9bzjgxz4HrIkSj97aiBbvJKVnHxZ0Oo3YwkJ3AxPNs7uLB3WE
         JAREWoaAiCNffkYS9FPXb6ATVq0H8eUa/AQ1UKztU75+MN0V/O0l+JB1AgiadqzujsgL
         tzPsT0upVO9DuFoM7lrsOoQ7jbVdb/4hzOfnymU3D3NrachozPpPW9OLL3ec/IuBIw2X
         7eIGg20lBao9pO9kDnSL2pMaAQYyw+vwjzt3AhfD8+9+kEYz2ogPFaH+qX5N+moHaDT4
         g5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=im+tZE/kWm/ZYSPYhJ4SO9Qym9+PRjpn700kp4DBAS8=;
        b=KTz9SWSvl7oJp7duowr/r2wyBK9OgmppdGaZvKUw7RADRCQdFja/ia+JTOPWdPrHrT
         KlG6EAphjvvXNmmoIii9sV7nr0EZA3YzsuRaDJGd4tcbVM8YhOcJFg0HYjvWvt8lq4AC
         kpOITR14fJD/ISe68O4uBj0mWn+1vXO/13jEk9FVT42KWY4Fjyx9RjuZi/UZkGzqsGvh
         xDv9xLTRMvGPMNg1I1yblu7Gf2gMBvqJYp1ctW7QhcNDgKst+KUBtGX3DlF7E1D1G92K
         a69MoTSesbN8TariaIYQrb8NEcMBckiE2/oITiVoDIQINydw2zyIfO1FqqrgCY/9GQdd
         xjpw==
X-Gm-Message-State: AOAM530hxRG7wiTWiS4JOt/zYtptC1YxFB5B/Vv1TFh18hKxxOkEQYmE
        lTXQTYYjjntnHmcN7lc0PKYsOigLLM145f5MfXI=
X-Google-Smtp-Source: ABdhPJwOSQIe23TJljX/SbIcNXl50XKjszrEFNraiEVK67gWjnJ97PCFnGYsDQ/8nukeG47lVxPUC1QJ2b/ituOwIjs=
X-Received: by 2002:a17:90a:3cc6:: with SMTP id k6mr494700pjd.204.1608230090020;
 Thu, 17 Dec 2020 10:34:50 -0800 (PST)
MIME-Version: 1.0
References: <cover.1602431034.git.yifeifz2@illinois.edu> <4706b0ff81f28b498c9012fd3517fe88319e7c42.1602431034.git.yifeifz2@illinois.edu>
 <CAMuHMdVU1BhmwMiHKDYmnyRHtQfeMtwtwkFLQwinfBPto-rtOQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVU1BhmwMiHKDYmnyRHtQfeMtwtwkFLQwinfBPto-rtOQ@mail.gmail.com>
From:   YiFei Zhu <zhuyifei1999@gmail.com>
Date:   Thu, 17 Dec 2020 12:34:39 -0600
Message-ID: <CABqSeARw2tcxEPiU4peuURZybVsFo5K+OkAK0ojADUEENMoKuA@mail.gmail.com>
Subject: Re: [PATCH v5 seccomp 5/5] seccomp/cache: Report cache data through /proc/pid/seccomp_cache
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 17, 2020 at 6:14 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Should there be a dependency on SECCOMP_ARCH_NATIVE?
> Should all architectures that implement seccomp have this?
>
> E.g. mips does select HAVE_ARCH_SECCOMP_FILTER, but doesn't
> have SECCOMP_ARCH_NATIVE?
>
> (noticed with preliminary out-of-tree seccomp implementation for m68k,
>  which doesn't have SECCOMP_ARCH_NATIVE

Hi Geert

You are correct. This specific patch in this series was not applied,
and this was addressed in a follow up patch series [1]. MIPS does not
define SECCOMP_ARCH_NATIVE because the bitmap expects syscall numbers
to start from 0, whereas MIPS does not (defines
CONFIG_HAVE_SPARSE_SYSCALL_NR). The follow up patch makes it so that
any arch with HAVE_SPARSE_SYSCALL_NR (currently just MIPS) cannot have
CONFIG_SECCOMP_CACHE_DEBUG on, by the depend on clause.

I see that you are doing an out of tree seccomp implementation for
m68k. Assuming unchanged arch/xtensa/include/asm/syscall.h, something
like this to arch/m68k/include/asm/seccomp.h should make it work:

#define SECCOMP_ARCH_NATIVE        AUDIT_ARCH_M68K
#define SECCOMP_ARCH_NATIVE_NR        NR_syscalls
#define SECCOMP_ARCH_NATIVE_NAME    "m68k"

If the file does not exist already, arch/xtensa/include/asm/seccomp.h
is a good example of how the file should look like, and remember to
remove `generic-y += seccomp.h` from arch/m68k/include/asm/Kbuild.

[1] https://lore.kernel.org/lkml/cover.1605101222.git.yifeifz2@illinois.edu/T/

YiFei Zhu
