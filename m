Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2025937B19F
	for <lists+bpf@lfdr.de>; Wed, 12 May 2021 00:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbhEKWc7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 May 2021 18:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhEKWc7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 May 2021 18:32:59 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701E5C061574
        for <bpf@vger.kernel.org>; Tue, 11 May 2021 15:31:52 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id m9so28420193ybm.3
        for <bpf@vger.kernel.org>; Tue, 11 May 2021 15:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dmH60ZBdmLNPCBCDKDsgEweYeMnBNa5KbSW9Ql205v0=;
        b=eG5rlO9L46OaUmsdkOwxMXTxzwWaUzIRL0sAGmL8AiZgZwXlo+s8RuW00cMmGXgdgi
         VLTHXaUuHGyR0/DIhE+TZb27uaKi7M/gRbApGnmlMDC/9llQgqduhlWSIaRc0KAv9dtW
         rtSWCW/awEci+xhdJbxOhJ5D6XvoLwNUGAOipkYbicExqOty1xuhIWfzBQytM90soskQ
         vVlvWDF+Lu6fIhQcJtE5CVodQCnV7h1XY3L8q9BuQq7GXHR69twwnf9lx+mwpnjXUzwy
         EJtd0tgYl/HgACDDwBaUNOUqOwic6JSPiHPbwcK6G22iNbu44ZLzQHELwqIe7NIDcUFE
         Jt6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dmH60ZBdmLNPCBCDKDsgEweYeMnBNa5KbSW9Ql205v0=;
        b=FbIKXbaYJkricg+eRpIZzyKk995w5iSaiMCNfbHWc3sYs/g1u5Ie0yBh6yeHiHzivL
         Pb87+f64I16fE2FKwBhZnURVlINH1cdiGNz6Vj1cEuFkwr7iDNrZ5K34EC5gjGC0iL8x
         CFk6tYy1p246ksyLnLR6at3dK12KxJ8hs+v9wwWKpnuyFuHa5iLAPwHSkonOiEuRdrxA
         wOP/uHBBTQlhe+uwBg2wxYwHsmNDrhQ/MEtb6/v22asY6ycB50K9I/Cip5mRSMPwXeQN
         zvOlbCqXEih6DWB2s/f3BijGozokSkGqRgcrhh9uy5wwfqJ/gZtRnc20SASXxnka7fuK
         1XCw==
X-Gm-Message-State: AOAM533GcE2b5MTGeKff7vs6b5lo1RVVUkUkjP8DB32aZYCnSb1esuLy
        6E8AQsfsat2nItAVAMJDWAjgal+Wb+Ix70oZnkA=
X-Google-Smtp-Source: ABdhPJze7yt2rUKNeKHqV4syOhsl5WGDGRgWJJnLijUyYWmjDvzoo3qPGgx9lbI9VLin1MyzwggbNmuDsjVGMwabqTA=
X-Received: by 2002:a5b:f05:: with SMTP id x5mr364930ybr.425.1620772311651;
 Tue, 11 May 2021 15:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210508034837.64585-1-alexei.starovoitov@gmail.com> <20210508034837.64585-4-alexei.starovoitov@gmail.com>
In-Reply-To: <20210508034837.64585-4-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 11 May 2021 15:31:40 -0700
Message-ID: <CAEf4BzYomn2g3hS4goRkTb6NO83vqFYsen3vi2fOTdmRDixEJg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 03/22] bpf: Prepare bpf syscall to be used
 from kernel and user space.
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

On Fri, May 7, 2021 at 8:48 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> With the help from bpfptr_t prepare relevant bpf syscall commands
> to be used from kernel and user space.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  include/linux/bpf.h   |   8 +--
>  kernel/bpf/bpf_iter.c |  13 ++---
>  kernel/bpf/syscall.c  | 113 +++++++++++++++++++++++++++---------------
>  kernel/bpf/verifier.c |  34 +++++++------
>  net/bpf/test_run.c    |   2 +-
>  5 files changed, 104 insertions(+), 66 deletions(-)
>

[...]
