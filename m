Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77CDB37B211
	for <lists+bpf@lfdr.de>; Wed, 12 May 2021 01:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhEKXDq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 May 2021 19:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbhEKXDq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 May 2021 19:03:46 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0F4C061574
        for <bpf@vger.kernel.org>; Tue, 11 May 2021 16:02:38 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id e190so28426284ybb.10
        for <bpf@vger.kernel.org>; Tue, 11 May 2021 16:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nRJJvXZONAxXa3vxLWepTCjyWKXh1YzMxgTEyyRGq64=;
        b=pjIxkmiuKuR+bnOt583ZyMaiZ6wHsY64V87D/UwGqKwRflZirCngp1hJXqvNaEfQPn
         54ryu0RJ1E+KYGray03C+1KbjquDitVKGFl8N5rmetxU7D3h4vHjbgJEp7UBj49Nxkin
         dmLhQDcUbx+pvsyu3T2QiSYx2C5pW4tJcwNV5GUhaQ5lfdVVYrZfhPt2VfVXuCvVsv1H
         uUxS49uG9cev4atTG3yzFPzxb0WKEmVzYWcAvd4uY6RaYPMevpB5bNqto9WdWxRGkXEm
         1UlYFgblC1YkTWn3OJW1G7d2yPiJI5Jgo2aAEV+uO7pnHRGrBHGxgT/FFBJelfjUqLK5
         HKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nRJJvXZONAxXa3vxLWepTCjyWKXh1YzMxgTEyyRGq64=;
        b=HWZPvUjIjbCL3bbDoRKywXNr1m4d61MkTf82eCKfhNNrZbZRI5GiUPiTSeF/NJtwiG
         4O6nzlyuwTZBXzJ9JDkuZc9ZNgzPRjeJjW56jUxQdqO5xtgvyVe79EdNg7wPcwRbFwoK
         GxXBmP8LNx26zhHDueEQizw3qn5+w0Q4ksZSQJcpzxsHwa2cte3ewy7zVKBMNLp+kCIg
         KXo+j5GBNfYC8fd8NuVa9N0ZFTWRoW2BR/goyuROD+69sOWiN0FjSeJnsqcEe9U8bGLK
         RoY4Wh09ImEgvamOY65ZMbw5j01TB4a5SJNmn/DgizrRRF9v5peDMFJyuXyzgIXmVhAg
         6row==
X-Gm-Message-State: AOAM533qiW07QyNuXsCP8b5GpCZly5hUpJ1bZn/IYeP+FshlH5h1OFqh
        qtoEh0JwTP44RvDY+jNjAeCzg0qFq6Ts4BhGmhg=
X-Google-Smtp-Source: ABdhPJxOwhgTClwENHh90OEUiZAJ3rQ3ZsrbuhO9uJG4yC61WJ8mU8bwvG12r10lewQA//9+4Qw3QSnfN9Gso+VUg2s=
X-Received: by 2002:a25:9942:: with SMTP id n2mr45890923ybo.230.1620774158152;
 Tue, 11 May 2021 16:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210508034837.64585-1-alexei.starovoitov@gmail.com> <20210508034837.64585-11-alexei.starovoitov@gmail.com>
In-Reply-To: <20210508034837.64585-11-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 11 May 2021 16:02:27 -0700
Message-ID: <CAEf4BzapxD-p49cPEtRveiWYa8CFC=zp6C2WLJmDROAwbJX2fA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 10/22] bpf: Add bpf_btf_find_by_name_kind() helper.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        john fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 7, 2021 at 8:49 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Add new helper:
> long bpf_btf_find_by_name_kind(char *name, int name_sz, u32 kind, int flags)
> Description
>         Find BTF type with given name and kind in vmlinux BTF or in module's BTFs.
> Return
>         Returns btf_id and btf_obj_fd in lower and upper 32 bits.
>
> It will be used by loader program to find btf_id to attach the program to
> and to find btf_ids of ksyms.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  include/linux/bpf.h            |  1 +
>  include/uapi/linux/bpf.h       |  7 ++++
>  kernel/bpf/btf.c               | 62 ++++++++++++++++++++++++++++++++++
>  kernel/bpf/syscall.c           |  2 ++
>  tools/include/uapi/linux/bpf.h |  7 ++++
>  5 files changed, 79 insertions(+)
>

[...]
