Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE591D2756
	for <lists+bpf@lfdr.de>; Thu, 14 May 2020 08:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbgENGPI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 May 2020 02:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725794AbgENGPH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 14 May 2020 02:15:07 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF75C061A0C
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 23:15:07 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id d1so1158395qvl.6
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 23:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ttk0Dc53VxRHCcu55jb/Qb4uH2o3CTC+TSR8cg2tB4s=;
        b=lX9klwj3FGgwFYR5IYoQeAFOQkqUbGvkMsYobBjJ90QF97CEtOUgaV99UUH5rv6rDc
         SfEeSm8yayHPi4/6m7rny+KS3GG5uC9T0XbME5YZxkXGv6BajS3VB58jJyrQh22JLR5k
         fa777sMS+/ghthw75R0jlG3x0taI3a73Yov9epXz1agMblM8fSOi3Zrn7EATiXnH1HqB
         4v9CyJzK45a3MM28PZVSuSUyyqJDcpvaAM0ZSKwc2EOgJ8Wjhp6RsIQvdIpzv3p6mi2H
         w8NvQp5mzpi6DhvbBsFc1bsbqEICgjgC5YeQFTOU2yOANPZqaEmmzTsJUCQbi/0S/PGI
         XDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ttk0Dc53VxRHCcu55jb/Qb4uH2o3CTC+TSR8cg2tB4s=;
        b=l5jaUALX0aY4BU5jKO3GNqAChFdq2iojZxFemKZvJ+4iDlIqNfltQvM5RkQdM6tn/I
         57qUm/9/BOQusXhDmkq6XCGm9lZkyTOPquSXzH+sSM4mYwa45We9utfK0K2Y2Juosa8A
         WMLlb12gXrh4NzdjIybMvJ+K3ZVjM/F3uNqsqqke8ttJd+Aorv5QrKTGgRuE4mhkwtNs
         bMyLvqP8G+RIuYuQBrGqE362TBEv1WzeV1KcdAZu24M8hKOJfOC1YzKRSh2mQ80G+a9N
         D8x9Xjl7TQbq7MhWZhn1xg7PXNIwfN8dw+kAtrNU9ifczZom4yJ16IFg9FvdS/6kBO9M
         gVEw==
X-Gm-Message-State: AOAM531W7CNBRgkacpdPWzOyD+ttsOfc7xT8CPYbOR1O3DsrVSWc2Plu
        lkGXfP/yMcZ/ldkfxVYg2UHr/QT4fSxiYBet64A=
X-Google-Smtp-Source: ABdhPJxcx9+xXOoU69o3NDcFFrP+DgsplFPkgjkqgdj49P7bsxS0AqLlMa9zMZG1x1r7m/onsvSp2IVhNKjpQHhlZbo=
X-Received: by 2002:a0c:e542:: with SMTP id n2mr3246081qvm.224.1589436906877;
 Wed, 13 May 2020 23:15:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200514053205.1298315-1-yhs@fb.com> <20200514053207.1298479-1-yhs@fb.com>
In-Reply-To: <20200514053207.1298479-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 13 May 2020 23:14:56 -0700
Message-ID: <CAEf4BzaEyf=hOJi0=1Ndu5MDo19wDLAkoBoF++OZgahO_LYJ3Q@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: enforce returning 0 for
 fentry/fexit programs
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 13, 2020 at 10:33 PM Yonghong Song <yhs@fb.com> wrote:
>
> There are a few fentry/fexit programs returning non-0.
> The tests with these programs will break with the previous
> patch which enfoced return-0 rules. Fix them properly.
>
> Fixes: ac065870d928 ("selftests/bpf: Add BPF_PROG, BPF_KPROBE, and BPF_KRETPROBE macros")
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

Acked-by: Andrii Nakryiko <andriin@fb.com>

[...]
