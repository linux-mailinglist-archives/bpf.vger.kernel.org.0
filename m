Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B9231715F
	for <lists+bpf@lfdr.de>; Wed, 10 Feb 2021 21:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbhBJU3V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Feb 2021 15:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbhBJU3N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Feb 2021 15:29:13 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097CAC06174A
        for <bpf@vger.kernel.org>; Wed, 10 Feb 2021 12:28:33 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id b187so3327827ybg.9
        for <bpf@vger.kernel.org>; Wed, 10 Feb 2021 12:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RjfHmAjUmDnO1YwUmTSiDzhzzBxFTy7C218GxUy7dtw=;
        b=BCnaDcCrek6IizGB2ukbKGIMHkxpB0TJwuOWNTOfzeBhQfHlL5G3wfyutb2wLCi9C1
         XT3fKqvPahncoEJDhSE0CkEjG7cS8ES1R5adLCmt3hZmAix0Q9jQC8eb3TfpFx7WoFRj
         HH4kSsbkkfgFuxsaqA0tOYsa7Ft35tAhHiACuar/ux8bSJuhSdnypcNuWf2yczjmWG6B
         zRD4uyl8UfMPJSp9k4cyZkPbA6/P2JzaaLcs7xVYDyhCZuPl2zg3oHr2MRp/9uo3IiRA
         YuHIV0dxWvk/h+q4cdmfoq4anSANxbnVMx6RUnci4m9zWU/22Ijk3u2/DyyZYDonBSWX
         Lwhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RjfHmAjUmDnO1YwUmTSiDzhzzBxFTy7C218GxUy7dtw=;
        b=CMosHYcjRRpMXFGkhtFKjsas0jybXc+k8CUmF8DJ0AHd6nM6xik4IypXteCNeWLnky
         kpEWO/wAEwLG3wLWJdnSGgqvLZcjT1QnlebR03syJTvI0kRR5XZXoPS9c1G5FY5XA6+f
         mJehs7Yei9WDFZGF7RnaIqTRMVSbGoRwnru5gH8RmnLe8SJz4j0B8a1f0ZdROUs1NyZi
         OBj665+Y3WD7u0spTgQq1VaFHioyCq8f8klxKDcXSJirvfXMHiB/4eZnH6azZbAszD8v
         L/uSevE2hNqAPfl+8A4gGuwLmHz9BzxB8WOaaIfAOT3u4DFyp61xvQAQmNz8Z2oYHs8y
         860w==
X-Gm-Message-State: AOAM532TNX6ccKoO+2h4uUDVt8QFlGxTlI339ajcPs7dMIGEGykJYWKM
        AYGmCDkKJ92I2xkuP1nlePxJIUY0mxMY/9tqkZmcgtcDDOI=
X-Google-Smtp-Source: ABdhPJxHS68Y0d67z+C/V61wjFVtkdDouQ9vcDjt0SqUQCYcgrctfZexybjvsGjjwu/1VhcI7y3vwZjG+TS03E4em8Y=
X-Received: by 2002:a25:4b86:: with SMTP id y128mr6459714yba.403.1612988912422;
 Wed, 10 Feb 2021 12:28:32 -0800 (PST)
MIME-Version: 1.0
References: <20210210020713.77911-1-iii@linux.ibm.com>
In-Reply-To: <20210210020713.77911-1-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 10 Feb 2021 12:28:21 -0800
Message-ID: <CAEf4BzY2xgxU11bKBo-UazPDaC_zZ4=dgLUhQc5AKabwEAGdRw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix endianness issues in atomic tests
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 9, 2021 at 6:11 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> Atomic tests store a DW, but then load it back as a W from the same
> address. This doesn't work on big-endian systems, and since the point
> of those tests is not testing narrow loads, fix simply by loading a
> DW.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Fixes: 98d666d05a1d ("bpf: Add tests for new BPF atomic operations")
> ---

Applied to bpf-next.

>  tools/testing/selftests/bpf/verifier/atomic_and.c | 2 +-
>  tools/testing/selftests/bpf/verifier/atomic_or.c  | 2 +-
>  tools/testing/selftests/bpf/verifier/atomic_xor.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
