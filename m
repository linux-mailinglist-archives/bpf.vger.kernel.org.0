Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 701FE44DBCD
	for <lists+bpf@lfdr.de>; Thu, 11 Nov 2021 19:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbhKKSyN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Nov 2021 13:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbhKKSyM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Nov 2021 13:54:12 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F53BC061766
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 10:51:23 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id d10so17476653ybe.3
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 10:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LycaEWu8cJ4w0orrmStlTMNUwDaL32lnn+va76iLR7s=;
        b=QSGe9bWmtbFL07HnocSjxtmoiHpO2YWkS3jg+TJYhkNHoyG4PnuEiWP17uRpXusu8X
         tywsQRaft4/pARuD16RCVBi/mDICpS15VO3AT7iMRtQugysvfpe9lXtTLM50zEAfsPpA
         jjbGZEOe1a01JDtd4cWuCHBUJ95zfmzxT7LE9UG8XM8fHi9NFc6bhZK9QSjLOTdSwSro
         0G5IgX0qVFKGHqAegdmBUGGbpw60/fPa8XgbdWat8xJKlYafUaawvP8BUjjp/FW+hkOM
         koWcbLeevR21NvI7LiB2o3FUXB4a5um5KtNAsq2LimWyJBobc+V0NAHanFrGQ5KOQuha
         fOuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LycaEWu8cJ4w0orrmStlTMNUwDaL32lnn+va76iLR7s=;
        b=uUTxqFlbvEla//twRh2ky7dFHg92U0cWkURa/PtrrbAq/YEZcA/lN0Vn/3BJ0rSw/N
         i7MjLaFpnwUbLXBNMTIZjCwDEAK4XOC14mo0q1vLPn6SJsKciTqfoZR1ZHi9almm4tvH
         XskB5hxA+mHSmbL2PvJK8JPYfhCry1nANpVWFePoLABb8OU4RlcG4iAZgi/XNHZb9qgt
         dfkfP1/8T5CZ3tA94JblBK69dv/dN5PP6vboF8Zhqbc7F7ivT/u/Hu4B0Uofq2yXgmNW
         pRVZrhhqGyKJUO66p0qs2xUujkyD6kTQXTJbY0BsY8JC18DG6L9+xk+5gH/nAE13GQMQ
         jThA==
X-Gm-Message-State: AOAM530wyecWWaMNNouEOoKePj3ieNp00vYxI9HSsvlOTxiQMfTv4Kaq
        znuonELBS2h/jzkxvzEpxpITJdrzGTRaSxS8yPE=
X-Google-Smtp-Source: ABdhPJwbPAW0THWP05i27IZdhUeI9nDujG4W45w0FVVbM6v2Vh+3s/PdIflPmjDR0U4eX941IZ2/AZ7sYF2o40SCB5A=
X-Received: by 2002:a25:afcd:: with SMTP id d13mr10630234ybj.504.1636656682747;
 Thu, 11 Nov 2021 10:51:22 -0800 (PST)
MIME-Version: 1.0
References: <20211110051940.367472-1-yhs@fb.com> <20211110052017.372003-1-yhs@fb.com>
In-Reply-To: <20211110052017.372003-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 11 Nov 2021 10:51:11 -0800
Message-ID: <CAEf4Bza8=+rWdkLNfNhi68yFCf0sqh+0Q5GGRt89RMNW0T=adw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 07/10] selftests/bpf: Rename progs/tag.c to progs/btf_decl_tag.c
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 9, 2021 at 9:20 PM Yonghong Song <yhs@fb.com> wrote:
>
> Rename progs/tag.c to progs/btf_decl_tag.c so we can introduce
> progs/btf_type_tag.c in the next patch.
>
> Also create a subtest for btf_decl_tag in prog_tests/btf_tag.c
> so we can introduce btf_type_tag subtest in the next patch.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  .../selftests/bpf/prog_tests/btf_tag.c        | 20 ++++++++++++-------
>  .../bpf/progs/{tag.c => btf_decl_tag.c}       |  0
>  2 files changed, 13 insertions(+), 7 deletions(-)
>  rename tools/testing/selftests/bpf/progs/{tag.c => btf_decl_tag.c} (100%)
>

[...]
