Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73269446759
	for <lists+bpf@lfdr.de>; Fri,  5 Nov 2021 17:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbhKEQ4G (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Nov 2021 12:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234059AbhKEQ4G (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Nov 2021 12:56:06 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8AEC061714
        for <bpf@vger.kernel.org>; Fri,  5 Nov 2021 09:53:26 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id v138so24329282ybb.8
        for <bpf@vger.kernel.org>; Fri, 05 Nov 2021 09:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2zzJ6oKaagBQD2C7ZUnz9Q4I9PhFT71i3fvJTYMBqnE=;
        b=IhtxAn63KuLaPKgA0lCkXe/s8kbGHkeyl7+3ACiZ1WKodTqeJv3pfjzI3t8Gkv+UvY
         l5QDkOiG8JJ7wYxKSzbspuwrZffd/8XStA3Qowno+UvjBWuKdahXxNDohUglpa+hvIUp
         /+zPBZdpXoMxwIgGJAvLcAgB6xZUNb1G8L0cT6rQs7XZDFD4QQneAc4ifpiiC+AXAV0O
         uV4zbPDcYAILvarxHOYdWI1uYXmGNIl0ixVD4hfcITFNQLqQCnQtgy/ibcpohK8RmVtP
         IV6XLi7zNQCe0aRsf3g8MRzzRrLdrUkHRgh1z4IurK5vJGk1j+CdWn8ACT3QzRraAQ0W
         dqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2zzJ6oKaagBQD2C7ZUnz9Q4I9PhFT71i3fvJTYMBqnE=;
        b=QzbpfQ5gbTxp77/TPf9NUKxd9L6Ibjspcjp7aFQ3SVv8BMiS5kSNHBfCjSZuSLVAsn
         qICmuvHrf6IK5qxZEiwehBU0rHK/E6PM6hg88JzJlycNstvR8tuhIRFOu+C6JkZ0atcB
         hNEqaUz8eq/Xgq5iGryHEnQK3TgESO7aOBEhlBuGnsIn1Bdt7wz2FsVmzT++VKVXJDCC
         RZtSsVdH5eNuk0TpeHs1ZlDVHe/4sAirSIEaxXJYI8pe8x2z/4+NA9pcFjR1GXII6RxI
         gEJiA69/YJtEyqk+8pNhbrx4EAuCfLVh+P6cAiLCpayZbggz1dt8ezoYrdA2dlPThgAE
         ZOPA==
X-Gm-Message-State: AOAM532vSbZ2yFlHXr4rPQFXvf3Or5ysOC1Fya+nmDmIbUbZoOV1izyI
        bxTfZEUlcqaSt4jbN/pW8eRueTTGtD2gKvCCmCY=
X-Google-Smtp-Source: ABdhPJytnEHqhxMt51najY7Nl6DvBxe0AebHv1qHuzuLnnOduAjxVuCAtKiu9/y3PAhWNdl56cjOGvTEMo6I/PVs6DA=
X-Received: by 2002:a25:d010:: with SMTP id h16mr58321425ybg.225.1636131205812;
 Fri, 05 Nov 2021 09:53:25 -0700 (PDT)
MIME-Version: 1.0
References: <20211103220845.2676888-1-andrii@kernel.org> <20211103220845.2676888-3-andrii@kernel.org>
 <bc6ddd1f-b614-294a-5d6a-1a6af4ee5259@fb.com>
In-Reply-To: <bc6ddd1f-b614-294a-5d6a-1a6af4ee5259@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 5 Nov 2021 09:53:14 -0700
Message-ID: <CAEf4BzbYDuv2XP=VrorB=b2HU09-wzUVB+s-MvUeOm1pxPU9mA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 02/12] libbpf: pass number of prog load
 attempts explicitly
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 4, 2021 at 11:43 PM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>
> On 11/3/21 6:08 PM, Andrii Nakryiko wrote:
> > Allow to control number of BPF_PROG_LOAD attempts from outside the
> > sys_bpf_prog_load() helper.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  tools/lib/bpf/bpf.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> > index c09cbb868c9f..8e6a23c42560 100644
> > --- a/tools/lib/bpf/bpf.c
> > +++ b/tools/lib/bpf/bpf.c
> > @@ -74,14 +74,15 @@ static inline int sys_bpf_fd(enum bpf_cmd cmd, union bpf_attr *attr,
> >       return ensure_good_fd(fd);
> >  }
> >
> > -static inline int sys_bpf_prog_load(union bpf_attr *attr, unsigned int size)
> > +#define PROG_LOAD_ATTEMPTS 5
> > +
> > +static inline int sys_bpf_prog_load(union bpf_attr *attr, unsigned int size, int attempts)
>
> nit: Should attempts be unsigned? Although, with the pre-decrement below, I can
> see the case for leaving as is.

Yeah, I find signed integers a bit "safer" in practice for all sorts
of counters. Overflows and underflows have higher chances of being
detected.

>
> Regardless,
>
> Acked-by: Dave Marchevsky <davemarchevsky@fb.com>
>
> >  {
> > -     int retries = 5;
> >       int fd;
> >
> >       do {
> >               fd = sys_bpf_fd(BPF_PROG_LOAD, attr, size);
> > -     } while (fd < 0 && errno == EAGAIN && retries-- > 0);
> > +     } while (fd < 0 && errno == EAGAIN && --attempts > 0);
> >
> >       return fd;
> >  }
>
> [...]
