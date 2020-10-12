Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2BB628AE48
	for <lists+bpf@lfdr.de>; Mon, 12 Oct 2020 08:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgJLGoN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Oct 2020 02:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgJLGnU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Oct 2020 02:43:20 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE47C0613D0
        for <bpf@vger.kernel.org>; Sun, 11 Oct 2020 23:43:18 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id dt13so21615175ejb.12
        for <bpf@vger.kernel.org>; Sun, 11 Oct 2020 23:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8L82QjxMFG+r7QSsdjzTxfz9BqpiVnaUpK+324xJ45o=;
        b=liJEn3P8GhTC9buz4u9pgXW2jZr7I9OZqGoH9rI6dOu/SvvD+mgE2tMDI/XC8+UyEa
         hkRR2uD0cJ3mxMZQwctrmWg6mIC/iBQIHjYQkAe/7TE3UoNtaU9H280J2Jlc1756UknI
         6CrZmT9ZxNGkPJncUXIO0tIyvokI7yydua6P/beBqwQ2PddwXuLQnhJ0g5sNDtEwrz94
         4vlCC4C0QnujNTx1CIx8/jDcfCZyohwTZePfYMDYQpSCyOKl12t3iOAnIHnMmOU9Muz8
         HmeEpOwTDkslb4i6FqVRfZZ0Yp9vKV+KTVJTsqEwFCvDWpg5M/taMPJ1xppOvFG87pH7
         MFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8L82QjxMFG+r7QSsdjzTxfz9BqpiVnaUpK+324xJ45o=;
        b=PaooIZrj7JZGpXaxF9JbQtpnzG461wfJNSSxkHzax+JUTGT/x40xYUa/GAKmoO7MBv
         8WuzSdBgshYtmANYfjkbBwBQ/Giy0F6tlvOgc37UsPeTHnxRi8FoqNL2CoCfWkBF8a5t
         ucFxPrawenRprPx8cVAQqAINIyF0S6+VaI2EyptfXx6Ml9xhbrTyh4glcjOy0Ql0NpSj
         JKJbjc46624jJ518Jsq5mvHrZ/Q9AvpBDQVf43Qj6xxmCy/7ZkhgWq6NfKZx4+Oyei9T
         U9B7SsrnFeMDp3hY3hmQzCiTKuFMFFNRLMRKDf1RB34zvR/IwW4c5OCZalVEHhuM0Gml
         Jt5A==
X-Gm-Message-State: AOAM533F9agWMkapQ1NjMELmVqk9AeIjIldBay3/+WmtSE7Fy92IPEha
        l7d41JAh47ZrHhVpPL0cwIeXVnHTEsQOEJ/SAAD7fADBEmg=
X-Google-Smtp-Source: ABdhPJx1VUYEvitmxLWOydKL99dOpXcnBPMRcX+FVk/fF9o/nqN8xeAbbK0V+dWHQlFYCOYOHNrS5SDijBDnSR1H8x4=
X-Received: by 2002:a17:906:86c3:: with SMTP id j3mr27448642ejy.493.1602484997186;
 Sun, 11 Oct 2020 23:43:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602431034.git.yifeifz2@illinois.edu> <10f91a367ec4fcdea7fc3f086de3f5f13a4a7436.1602431034.git.yifeifz2@illinois.edu>
In-Reply-To: <10f91a367ec4fcdea7fc3f086de3f5f13a4a7436.1602431034.git.yifeifz2@illinois.edu>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 12 Oct 2020 08:42:50 +0200
Message-ID: <CAG48ez0fcG=+tpzqNNKvK=+NS25z4zTN55sUhECRGAfBrjhuQQ@mail.gmail.com>
Subject: Re: [PATCH v5 seccomp 1/5] seccomp/cache: Lookup syscall allowlist
 bitmap for fast path
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
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

On Sun, Oct 11, 2020 at 5:48 PM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
> The overhead of running Seccomp filters has been part of some past
> discussions [1][2][3]. Oftentimes, the filters have a large number
> of instructions that check syscall numbers one by one and jump based
> on that. Some users chain BPF filters which further enlarge the
> overhead. A recent work [6] comprehensively measures the Seccomp
> overhead and shows that the overhead is non-negligible and has a
> non-trivial impact on application performance.
>
> We observed some common filters, such as docker's [4] or
> systemd's [5], will make most decisions based only on the syscall
> numbers, and as past discussions considered, a bitmap where each bit
> represents a syscall makes most sense for these filters.
>
> The fast (common) path for seccomp should be that the filter permits
> the syscall to pass through, and failing seccomp is expected to be
> an exceptional case; it is not expected for userspace to call a
> denylisted syscall over and over.
>
> When it can be concluded that an allow must occur for the given
> architecture and syscall pair (this determination is introduced in
> the next commit), seccomp will immediately allow the syscall,
> bypassing further BPF execution.
>
> Each architecture number has its own bitmap. The architecture
> number in seccomp_data is checked against the defined architecture
> number constant before proceeding to test the bit against the
> bitmap with the syscall number as the index of the bit in the
> bitmap, and if the bit is set, seccomp returns allow. The bitmaps
> are all clear in this patch and will be initialized in the next
> commit.
>
> When only one architecture exists, the check against architecture
> number is skipped, suggested by Kees Cook [7].
>
> [1] https://lore.kernel.org/linux-security-module/c22a6c3cefc2412cad00ae14c1371711@huawei.com/T/
> [2] https://lore.kernel.org/lkml/202005181120.971232B7B@keescook/T/
> [3] https://github.com/seccomp/libseccomp/issues/116
> [4] https://github.com/moby/moby/blob/ae0ef82b90356ac613f329a8ef5ee42ca923417d/profiles/seccomp/default.json
> [5] https://github.com/systemd/systemd/blob/6743a1caf4037f03dc51a1277855018e4ab61957/src/shared/seccomp-util.c#L270
> [6] Draco: Architectural and Operating System Support for System Call Security
>     https://tianyin.github.io/pub/draco.pdf, MICRO-53, Oct. 2020
> [7] https://lore.kernel.org/bpf/202010091614.8BB0EB64@keescook/
>
> Co-developed-by: Dimitrios Skarlatos <dskarlat@cs.cmu.edu>
> Signed-off-by: Dimitrios Skarlatos <dskarlat@cs.cmu.edu>
> Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>

Reviewed-by: Jann Horn <jannh@google.com>
