Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0B5459900
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 01:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhKWANY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Nov 2021 19:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbhKWANU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Nov 2021 19:13:20 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D36C061574
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 16:10:13 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id f186so17668471ybg.2
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 16:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gOZP0v5yZMzxpC2Rp0pU2jAv52teL4j8gXL2e9CWKzo=;
        b=Zdz3+9CcbfK1dgar3w/lQrAn8kAsR3zZ+SwNh2vm/tfGb+mtGg7Muh3W99ddzg5T/b
         tnZ81d4OLx11SuwzbDY6/N3BIGJwZvqzWv+8r6UwKlClbez1WgWVoXkLS/yM82S2JwDA
         RU3Mcs8s0v+jOdPLd7MzR6+3Sw7CLlFo3499EPgS/VEny014r48ygxYtz5+mcFmaLiek
         fB6iUDfD9xwJuAenhaAujy0kwoUZRe8mNHU8iwlqTxaPDVYhOGyPtnHa4A098hEnRttj
         y9hMrDp4kgeDOLKNKK2ls6SfyRDzfRR1dh0/evrGYjkxn7C6r0vx2n+Cu0b0Cyn32ru6
         d6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gOZP0v5yZMzxpC2Rp0pU2jAv52teL4j8gXL2e9CWKzo=;
        b=L4ehdrZ01TRom3AOANxHLaH+ylKlUm9KmnHjCOaeMlyvxBe2W008TGZJ7tSmQnWNp1
         czs0J+UTCC5g6ygdTZjgMOsr1ekAG4Ha6W509vGF45RK2G0wPTX9ggMZAI/IAN+tuOEf
         ijA5bT9W3BmUkrqbAas7YGA4WyW88JdZwJAkRzJ0AWKOHYY8yRQxez/ChQnBxmcf2T+2
         ueXAnzwm98EeoeEBW/DXxRsgLBgspCPmJt8DbkUL9FTkj30oGY5j0yzRxVEMy7tcY9Vi
         HxeMGSbailtb3YktjnIoopbukwzODy0yvZF72if+rzZ2G5MxZOr8OsJPWp9JShxtNIya
         ZM5w==
X-Gm-Message-State: AOAM5334YcXoTTHAtjBdEkWc4LS3SZWFXl5BQuLtP/iLPGdhZO/2U9ZZ
        HZLxO8RsDLUyVQRLWDtTc7C+Fpnc7lN/H4eFPMs=
X-Google-Smtp-Source: ABdhPJwEt1t4fE2l0IKvzuA7WKlt71FdCoQvyz+AScExa+AhnN8bGybERbLfJFKrTHVhOdLNT19fhjmHr0Mucb2fsrY=
X-Received: by 2002:a25:cc4c:: with SMTP id l73mr1407750ybf.114.1637626212308;
 Mon, 22 Nov 2021 16:10:12 -0800 (PST)
MIME-Version: 1.0
References: <20211120033255.91214-1-alexei.starovoitov@gmail.com> <20211120033255.91214-14-alexei.starovoitov@gmail.com>
In-Reply-To: <20211120033255.91214-14-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 22 Nov 2021 16:10:01 -0800
Message-ID: <CAEf4BzaGND+DM9Gi0+LDRVC4ipQOvtrZDh+FGVQsfxmN6kiYuw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 13/13] selftest/bpf: Revert CO-RE removal in test_ksyms_weak.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 19, 2021 at 7:33 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> The commit 087cba799ced ("selftests/bpf: Add weak/typeless ksym test for light skeleton")
> added test_ksyms_weak to light skeleton testing, but remove CO-RE access.
> Revert that part of commit, since light skeleton can use CO-RE in the kernel.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Great!

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/testing/selftests/bpf/prog_tests/ksyms_btf.c  | 4 ++--
>  tools/testing/selftests/bpf/progs/test_ksyms_weak.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>

[...]
