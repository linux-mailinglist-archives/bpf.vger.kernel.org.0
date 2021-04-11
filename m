Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2DC735B312
	for <lists+bpf@lfdr.de>; Sun, 11 Apr 2021 12:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbhDKKXe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Apr 2021 06:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235232AbhDKKXe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Apr 2021 06:23:34 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519A2C061574
        for <bpf@vger.kernel.org>; Sun, 11 Apr 2021 03:23:18 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id c3so2376187ils.5
        for <bpf@vger.kernel.org>; Sun, 11 Apr 2021 03:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=EZbI6zXVkEKBWVckHFqRhQCzijJJcTjRddzax2FzWv4=;
        b=sjMwFfTKq1ySwZgwfaRGHuX6+VJtzudtPqQfIJM8tjGpOZRDejrXFN4uX4FB9dK93L
         ICIlRGoDKyMBv2zFMJQNdRgaDxODMvQkxxFrSTVIZYnEG9hI7EF5uc7Ukv7sE/xm3Vdv
         1d+uZAOO2xvHZdPZAStbolMdbBu3Qv/KEihKjnI+XbKaMPcaMQYSQ0Rqm5EL9m8pQ5Gi
         JTHiKmi75IxAI6neFBxHw1675MKyLQ9Ec4G1SaQw0OjLhUbg/qxOjIPiZgbHc9B0mOTz
         TMQ8LRkrvDdmIoJ5F5jENEU1d/4BzEUTrK3TuCVPR5Tmd6HNf3N7iS545B2STzmPRiJc
         zOag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=EZbI6zXVkEKBWVckHFqRhQCzijJJcTjRddzax2FzWv4=;
        b=jD0dgHJyoxpEbxp4aN5MbkGWi6kAC+9iU/thaPuFW3GAcCfHamhWchQbgm5L7o7RAt
         4NLh0kJiwDtg/FQBoQmtMpYDFomHGMXZqyqcx1DS0N+hpiJqymRR7/ucmx5BLtxyLUob
         0VHk4keCUEUPgAezw2WMo/m8RgU9PhbFkoQCviCBfAuINqSyUBnS9b5F+u/j96jjZtHs
         Vj1MUaVAnMPSOK8E9pgbV/Mc9Xlri/b5EnxjS7Ag1K619z/IvMJzHK6pfxQIOCVgTLFe
         /lamxKraAcc4dMVWFwbD7IEVA1WsxOwwOTAYfdxYqBoT6qEBOgmSUb64k7sg+eh0Qbnm
         XaNg==
X-Gm-Message-State: AOAM531j/UWE2eA5nrQWBv0AvqSPjcH9DPZjAR76Ze04piQIhOmVTKQJ
        E2UDv7WxLxUqw2V+ZLmhn+R7NjDvpGANHpRv4iA=
X-Google-Smtp-Source: ABdhPJzvJJEszJA+R6LeGUee4XsmeAFQn9hEnW6bouRXmeVy5gcmKWnh0ACpXulxxvhkItFRjMtdy8FwUp2+A7jgEXU=
X-Received: by 2002:a05:6e02:dea:: with SMTP id m10mr11609586ilj.112.1618136597797;
 Sun, 11 Apr 2021 03:23:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210410164925.768741-1-yhs@fb.com> <20210410164930.769251-1-yhs@fb.com>
In-Reply-To: <20210410164930.769251-1-yhs@fb.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 11 Apr 2021 12:22:41 +0200
Message-ID: <CA+icZUVf9RPxBHZvTaEK0scNoPkF3pf__wWCy3K=TeacgBq98g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/5] selftests: set CC to clang in lib.mk if LLVM
 is set
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        kernel-team@fb.com, Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Apr 10, 2021 at 6:49 PM Yonghong Song <yhs@fb.com> wrote:
>
> selftests/bpf/Makefile includes lib.mk. With the following command
>   make -j60 LLVM=1 LLVM_IAS=1  <=== compile kernel
>   make -j60 -C tools/testing/selftests/bpf LLVM=1 LLVM_IAS=1 V=1
> some files are still compiled with gcc. This patch
> fixed lib.mk issue which sets CC to gcc in all cases.
>
> Cc: Sedat Dilek <sedat.dilek@gmail.com>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/testing/selftests/lib.mk | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index a5ce26d548e4..9a41d8bb9ff1 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -1,6 +1,10 @@
>  # This mimics the top-level Makefile. We do it explicitly here so that this
>  # Makefile can operate with or without the kbuild infrastructure.
> +ifneq ($(LLVM),)
> +CC := clang
> +else
>  CC := $(CROSS_COMPILE)gcc
> +endif
>

Why not use include "include ../../../scripts/Makefile.include" here
and include CC and GNU or LLVM (bin)utils from there?

Should the CC line have a $(CROSS_COMPILE) for people doing cross-compilation?

CC := $(CROSS_COMPILE)clang

- Sedat -


>  ifeq (0,$(MAKELEVEL))
>      ifeq ($(OUTPUT),)
> --
> 2.30.2
>
