Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5EF459850
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 00:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbhKVXSX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Nov 2021 18:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhKVXSW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Nov 2021 18:18:22 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59006C061574
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 15:15:15 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id x32so18150659ybi.12
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 15:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YC6VdIU0UWJK6VyKJxuBCfiNhFomInw30C3iLkpNRF0=;
        b=M2KZajmhsw6bcjIGK2QZCSEgJN8ChjmIv7sMatrImrVC8e8gUr9y8s0J+72oY5aTSr
         RflHZCqDWSrdfExKnSlUhwW34AKmy3uEwSsJ4rJI1sASThE30zmUWXA8eu+N07NJLKeA
         SVHVUxBkqYtHRQA7QjmuDPEZEzKX5cTktH/P09CN/NlPZ0gkdEKX5A44hrV4DK1bJAjk
         GTBElJ2ENHOxLQbe4o1RjW+8V3CkN3trv4MoQMtloY2x1vUT/ddMi6NZ9jn10AXY84Gk
         t46sXZ3Px4BJJOF/0iAWrlSimMEN5Hwi3wjNANiCYL34fMYNgdIVarwdF/J+uNZrb3pN
         2q5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YC6VdIU0UWJK6VyKJxuBCfiNhFomInw30C3iLkpNRF0=;
        b=1XpcPSXREX0pPXooeya7c9eA9pQtz/3GyJrT7UKda7rCHwhVLTJmazOieuJMRen/rf
         0/O1juC3OB/uvRKfiYvJN3KtIykp8jBeO6GWXs9ZNHfdp4Q3WDIB6K6Sk8tL5oj/1K8d
         PTz9og8PzoSUY/O3ekiOpLEjmiL4zUQLuDLEhSSy4nULp/k1Wq2Ic3maVwQFFrJJ3vyw
         B5Vm3E/kQKLh7mDSFtuaqJVQRhbBFbaunJmNMXkxn993kP2Ir+u4210/jUzcp7MNCLl2
         GVozwQTqNaaHBHkQ6ATa8NuRKznos59xnNNcwqFd79tbgx4xgxo+piaSI2UvtpSpKPLZ
         6L8w==
X-Gm-Message-State: AOAM531tMzHV1ti/UxmPRb8WSp/5EJ1Hpim34mKWjKFk2ibrhJwg6Mm9
        cNh5OnbNbgS7x2bAL71AVGRjDFCIkT1h+HFBtWSPX6KMOlgONg==
X-Google-Smtp-Source: ABdhPJxXMeRNrROjtT4jhuFxk7Rtf1Vk3FJ4yungPblf27HzoBJy6UWbShdzpUfcuSyiBawy7XVwqunCAlkf0gngajk=
X-Received: by 2002:a25:d310:: with SMTP id e16mr922428ybf.504.1637622914164;
 Mon, 22 Nov 2021 15:15:14 -0800 (PST)
MIME-Version: 1.0
References: <20211120033255.91214-1-alexei.starovoitov@gmail.com> <20211120033255.91214-4-alexei.starovoitov@gmail.com>
In-Reply-To: <20211120033255.91214-4-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 22 Nov 2021 15:15:03 -0800
Message-ID: <CAEf4BzaYR-MyRYhxT2wVA-qckRgbWL69STMRhqGnSBWKuKD5SA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 03/13] bpf: Prepare relo_core.c for kernel duty.
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
> Make relo_core.c to be compiled for the kernel and for user space libbpf.
>
> Note the patch is reducing BPF_CORE_SPEC_MAX_LEN from 64 to 32.
> This is the maximum number of nested structs and arrays.
> For example:
>  struct sample {
>      int a;
>      struct {
>          int b[10];
>      };
>  };
>
>  struct sample *s = ...;
>  int y = &s->b[5];
> This field access is encoded as "0:1:0:5" and spec len is 4.
>
> The follow up patch might bump it back to 64.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  include/linux/btf.h       | 81 +++++++++++++++++++++++++++++++++++++++
>  kernel/bpf/Makefile       |  4 ++
>  kernel/bpf/btf.c          | 26 +++++++++++++
>  tools/lib/bpf/relo_core.c | 76 ++++++++++++++++++++++++++++++------
>  4 files changed, 176 insertions(+), 11 deletions(-)
>

[...]
