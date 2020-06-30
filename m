Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA3420FC9D
	for <lists+bpf@lfdr.de>; Tue, 30 Jun 2020 21:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgF3TUd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Jun 2020 15:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbgF3TUd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Jun 2020 15:20:33 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6A4C061755
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 12:20:33 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id v19so16475123qtq.10
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 12:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qyBHqzcxZqZaVy+lYU+69uzFhTFasCGQqeJ1yC56LIE=;
        b=b4CM5574ju4IHjaQ1sv/vlPOWKAxsVCZMTgKgBUUzKX/pBN4Wu/ks+xWRstRar+kv3
         HimR+4gXIiS4TPTszgQPYRl0zSexTI51IEr7uqQERU9oVOjuqenZAEuB+ZbwJQdUnDmW
         0ueUyJQrcCa8TUTjYbrsrEn4prZPZtJYqVGUo9jprd4QOk7aKc74oYZlKojjfostLFSz
         RupQ9xhsWFFzLth2OfOM9K9nPvcc4iLjxkXQiKkaerZc0zkoZ+q7FwFO0QMDCX4JYzrh
         2OdI7n8YFUv6/bJnCraGGr+5otagSbPFOxtj5KxJ2MzUOWr3KepcJRhRFq1aeQGM5umw
         H3kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qyBHqzcxZqZaVy+lYU+69uzFhTFasCGQqeJ1yC56LIE=;
        b=s0E/LKAaMsuRTTgXHxmDmu57C/yeUbTvvrqVu2rlGcengoeG0pE04rVrS7oBmwGBng
         QgNEHRZ1/oEufByygFd0mWuIg/4SFSmZpEBy/cNT9C/h+WDAal0g4a8lf4OB5UrDJN7O
         sSsSrjQLXPWfGJMxTzYXd243IwRGR6QqxamLVRLWh6KlelTSG9grNwda7BEVgXAzQy9N
         V1QeKBmkdz/mnt3RR58KIQZ/5Z8wLqFQHTXQMn6pNdA1mlojRxKOKHmp87LoIRCr5au8
         I3VyB9aj0yaFRdxzordcFmG/6f+KtbZFlraiGy6HzoUGzAvlb8UgDuytAwg8dnamyYWW
         yjgA==
X-Gm-Message-State: AOAM532+CVMyELdZ3mRhjMannO0uAA/BWDFUXDf1tOX0ctCJiByX048e
        wbrl7oxweCYq3XR8pY3HYwgchaB+gXEkW6Uygys=
X-Google-Smtp-Source: ABdhPJyJ543sHR5j6/hrsBgk1D9BD8bUN69b9o1KwkB6b+75qTcSBbbdJWQ4fcXNjuw//xbi58KlYGbeEP3+S12/bDk=
X-Received: by 2002:ac8:19c4:: with SMTP id s4mr18128277qtk.117.1593544832170;
 Tue, 30 Jun 2020 12:20:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200630171240.2523628-1-yhs@fb.com> <20200630171240.2523722-1-yhs@fb.com>
 <5efb7ba67bae6_3792b063d0145b4b4@john-XPS-13-9370.notmuch>
In-Reply-To: <5efb7ba67bae6_3792b063d0145b4b4@john-XPS-13-9370.notmuch>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 30 Jun 2020 12:20:20 -0700
Message-ID: <CAEf4Bza5Lvy0V=VHkMzUHe_urj5v5YFWbFZtkOweFPaDXnEnsw@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: fix an incorrect branch elimination by verifier
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Wenbo Zhang <ethercflow@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 30, 2020 at 12:09 PM John Fastabend
<john.fastabend@gmail.com> wrote:
>
> Yonghong Song wrote:
> > Wenbo reported an issue in [1] where a checking of null
> > pointer is evaluated as always false. In this particular
> > case, the program type is tp_btf and the pointer to
> > compare is a PTR_TO_BTF_ID.
> >
> > The current verifier considers PTR_TO_BTF_ID always
> > reprents a non-null pointer, hence all PTR_TO_BTF_ID compares
> > to 0 will be evaluated as always not-equal, which resulted
> > in the branch elimination.
> >
> > For example,
> >  struct bpf_fentry_test_t {
> >      struct bpf_fentry_test_t *a;
> >  };
> >  int BPF_PROG(test7, struct bpf_fentry_test_t *arg)
> >  {
> >      if (arg == 0)
> >          test7_result = 1;
> >      return 0;
> >  }
> >  int BPF_PROG(test8, struct bpf_fentry_test_t *arg)
> >  {
> >      if (arg->a == 0)
> >          test8_result = 1;
> >      return 0;
> >  }
> >
> > In above bpf programs, both branch arg == 0 and arg->a == 0
> > are removed. This may not be what developer expected.
> >
> > The bug is introduced by Commit cac616db39c2 ("bpf: Verifier
> > track null pointer branch_taken with JNE and JEQ"),
> > where PTR_TO_BTF_ID is considered to be non-null when evaluting
> > pointer vs. scalar comparison. This may be added
> > considering we have PTR_TO_BTF_ID_OR_NULL in the verifier
> > as well.
> >
> > PTR_TO_BTF_ID_OR_NULL is added to explicitly requires
> > a non-NULL testing in selective cases. The current generic
> > pointer tracing framework in verifier always
> > assigns PTR_TO_BTF_ID so users does not need to
> > check NULL pointer at every pointer level like a->b->c->d.
>
> Thanks for fixing this.
>
> But, don't we really need to check for null? I'm trying to
> understand how we can avoid the check. If b is NULL above
> we will have a problem no?

BPF JIT installs an exception handler for each direct memory access,
so that if it turns out to be NULL, it will be caught and 0 will be
assigned to the target register and BPF program will continue
execution. In that sense, it simulates bpf_probe_read() behavior and
significantly improves usability.

>
> Also, we probably shouldn't name the type PTR_TO_BTF_ID if
> it can be NULL. How about renaming it in bpf-next then although
> it will be code churn... Or just fix the comments? Probably
> bpf-next content though. wdyt? In my opinion the comments and
> type names are really misleading as it stands.
>

[...]
