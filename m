Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35F740BC82
	for <lists+bpf@lfdr.de>; Wed, 15 Sep 2021 02:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbhIOARE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 20:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhIOARE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 20:17:04 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D51C061574
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 17:15:46 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id r4so1959932ybp.4
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 17:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mGNT91VwgWPRgnH71m+dunNNB2YVsKilJXUnZq9rA/0=;
        b=ZlXov9sYl7gjhQnZGECBC2N94RNoDtBu1T8Rz4ik/R5FYedukTMpgEA34rvst1rsRB
         ImYnEwhJnM+AzXHvgDLITRIHX2QdsOVMrW2kep68ti/ZeOptvxAJ7WUhQemLR/NKB5vF
         kq1D1u4ur6rTAnCkye9JrPLgxzXQdV65wFkjgXJ6kkswTZyPy73SRL9sO4/c1K3GeNS3
         2Bk6dTBfuyPtAk54ktV3woZtJGIAd6kz39HChkKhxCJ6n1dQwlS4PkfAqSgGYpG6ni0b
         nj/+xVSnJnBlf6beOEuZSTaB9FV0kqt0A4aobvI2ZVj5UU3ZGiJ+nzuJ2A1nHXLc5vRp
         p6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mGNT91VwgWPRgnH71m+dunNNB2YVsKilJXUnZq9rA/0=;
        b=rwZr7+zlJYSHPOjFLu9N+kQQZakO1qaoufuJs45AXDe0fFNpFtm8xTj7xaRr4OdgEe
         4mNm97R4QWUeMhKD2O3vqVatuTm2v0E0N5qtAfSh4jdxMuWcZEG7pYyLqAoI+Kd97I12
         S94JqUzuNmrK8SYmCUF4hWXvgOfhhaHlPWY/XKePm/sSD6leYQtMtZKByw3wgFsWg2c/
         MRk92HwMFbRKcQTcgN8+6MqP6SkkGC2DilmKmCTWBCDpxJhZqQpWMeakeQbvRDoz8P6U
         lozGkRxcSuBzj9hvYhrcLfrIg/kdTkFBqt5LXGrv07PMtjm7eiro85PsZ+0AQtO+zX9e
         ouuQ==
X-Gm-Message-State: AOAM530IF2+SVBi2BKYEU65x/xw6zyN5gFrMFV0aU4fvvEuycyteQiYh
        VBFB83GGyWJFPa0eLU+5cpvd8L/mih10+VCPkDk=
X-Google-Smtp-Source: ABdhPJypfAqf5M8rMhNMH5G0MI2M2GD+xO9rBP4ND6qgdfNtoForRbt8NXLpCuFORJS0BA+oU2F6c+YMZHu+/5JxBJM=
X-Received: by 2002:a25:afcd:: with SMTP id d13mr2495592ybj.504.1631664945459;
 Tue, 14 Sep 2021 17:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210914223004.244411-1-yhs@fb.com> <20210914223015.245546-1-yhs@fb.com>
In-Reply-To: <20210914223015.245546-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 14 Sep 2021 17:15:34 -0700
Message-ID: <CAEf4Bzbp=j_5FGfoQ5a1ByP0uZ+Cg8i7u_A19Z9ZTWkrsPGQ6A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 02/11] bpf: support for new btf kind BTF_KIND_TAG
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 14, 2021 at 3:30 PM Yonghong Song <yhs@fb.com> wrote:
>
> LLVM14 added support for a new C attribute ([1])
>   __attribute__((btf_tag("arbitrary_str")))
> This attribute will be emitted to dwarf ([2]) and pahole
> will convert it to BTF. Or for bpf target, this
> attribute will be emitted to BTF directly ([3], [4]).
> The attribute is intended to provide additional
> information for
>   - struct/union type or struct/union member
>   - static/global variables
>   - static/global function or function parameter.
>
> For linux kernel, the btf_tag can be applied
> in various places to specify user pointer,
> function pre- or post- condition, function
> allow/deny in certain context, etc. Such information
> will be encoded in vmlinux BTF and can be used
> by verifier.
>
> The btf_tag can also be applied to bpf programs
> to help global verifiable functions, e.g.,
> specifying preconditions, etc.
>
> This patch added basic parsing and checking support
> in kernel for new BTF_KIND_TAG kind.
>
>  [1] https://reviews.llvm.org/D106614
>  [2] https://reviews.llvm.org/D106621
>  [3] https://reviews.llvm.org/D106622
>  [4] https://reviews.llvm.org/D109560
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  include/uapi/linux/btf.h       |  14 +++-
>  kernel/bpf/btf.c               | 128 +++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/btf.h |  14 +++-
>  3 files changed, 154 insertions(+), 2 deletions(-)
>

[...]
