Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8FC644F49
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 00:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiLFXF7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 18:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLFXF7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 18:05:59 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F192AFF
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 15:05:57 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id n21so9933228ejb.9
        for <bpf@vger.kernel.org>; Tue, 06 Dec 2022 15:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yZauhxxwmrYfOMeuOWUl0PZxWvonpbud43F5Nsp1C5Y=;
        b=LmGujw5xbC+VB04FKPhvIsYJU8/z6R0UqFg78DC0dLKvx4SMiY89pyDOEZ9iOh277+
         YDDEWn0FzYrN40rn3/gnWtnTRm456kRjqgfNxfMPrANhVeyyeZ8lIDG/GLyOLW5zilDf
         b60UzTOs1cV6nUn1K706xTsHmVc8CL1GT7deswEvuaOva1l1VIZQqTh9R8j82rNt7hLL
         aDJ9QGENJEBudzPxNjF0Hxrh/F8QmzqCd+xrZ5xyJu7vKWty1Mzsfp6pYBPhojRdCnXX
         8DBIcxkvLr5e5dm3CqNdJylKIkYu/W378+/4UUo3ZymedoST36HT5hPP/2pk0YYKUFjJ
         RP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yZauhxxwmrYfOMeuOWUl0PZxWvonpbud43F5Nsp1C5Y=;
        b=I690aBD2agwLEN0uzR5faf63bhdiwIrHCZ+4pbpNhfi1SJhUALk4z5InKd9xVt3Xm+
         4tVWP7YeuCQ08iGxwVLoKJiDGP+ppq9nhV4fT68Niku+DlW+JEEPueBc4AXWwQAq14Kp
         mdT/GYSL+N3l2VpTMdT9GNw4UDFl51ZfJ7d5/qLbU8cCNUK/J/BCVhwxBREwF2Z2ky79
         Be2opzT8mbmTahUXo8M2NPEhtf6S9WHjDG+2tuXdjgudF9Mxd3RnnmwuO1l0lEvYpzfj
         6ojuyK5nqjXN4oI/G3xNcX3JLOdDL154g26UwEb1Kcg3Xqx11cnUqnABM7Gp294zmXsy
         gJPg==
X-Gm-Message-State: ANoB5pntLzKqbUlbMPjWqLdDdRtAJ7itrtPqTqtq7PP4cZjrr4h4sJCd
        cGZSJj4gg6RXh6c8IaQ0zGAVW+Vj4kVWZOQbMXCszpEz
X-Google-Smtp-Source: AA0mqf7fMyC8c2LlBSkigmRfgTywW03ElMsN8BtOptjiBI+91xT5DWlXDpC2bNPQ7jbhN/V3tz3vTCPdbvSdElrUfAk=
X-Received: by 2002:a17:906:94e:b0:7ba:4617:3f17 with SMTP id
 j14-20020a170906094e00b007ba46173f17mr52729838ejd.226.1670367955957; Tue, 06
 Dec 2022 15:05:55 -0800 (PST)
MIME-Version: 1.0
References: <20221202051030.3100390-1-andrii@kernel.org> <20221202051030.3100390-2-andrii@kernel.org>
 <638fb72bec402_8a9120872@john.notmuch>
In-Reply-To: <638fb72bec402_8a9120872@john.notmuch>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 6 Dec 2022 15:05:43 -0800
Message-ID: <CAEf4BzaiOW+ozRt4oNwTKhGEqKHcPAqWZgdA+UJW2ATxiXnz3w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: decouple prune and jump points
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 6, 2022 at 1:42 PM John Fastabend <john.fastabend@gmail.com> wrote:
>
> Andrii Nakryiko wrote:
> > BPF verifier marks some instructions as prune points. Currently these
> > prune points serve two purposes.
> >
> > It's a point where verifier tries to find previously verified state and
> > check current state's equivalence to short circuit verification for
> > current code path.
> >
> > But also currently it's a point where jump history, used for precision
> > backtracking, is updated. This is done so that non-linear flow of
> > execution could be properly backtracked.
> >
> > Such coupling is coincidental and unnecessary. Some prune points are not
> > part of some non-linear jump path, so don't need update of jump history.
> > On the other hand, not all instructions which have to be recorded in
> > jump history necessarily are good prune points.
> >
> > This patch splits prune and jump points into independent flags.
> > Currently all prune points are marked as jump points to minimize amount
> > of changes in this patch, but next patch will perform some optimization
> > of prune vs jmp point placement.
> >
> > No functional changes are intended.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> Acked-by: John Fastabend <john.fastabend@gmail.com>
>
> > ---
> >  include/linux/bpf_verifier.h |  1 +
> >  kernel/bpf/verifier.c        | 57 +++++++++++++++++++++++++++---------
> >  2 files changed, 44 insertions(+), 14 deletions(-)
> >
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> > index b5090e89cb3f..9870d1d0df01 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -452,6 +452,7 @@ struct bpf_insn_aux_data {
> >       /* below fields are initialized once */
> >       unsigned int orig_idx; /* original instruction index */
> >       bool prune_point;
> > +     bool jmp_point;
>
> Random thought we might want to make these flags in the future so you
> can have,
>
>    type = BPF_PRUNE_POINT | BPF_JMP_POINT | BPF_ITERATOR_POINT
>
> and so on without a bunch of bools.

Bunch of bools are nice because they are explicit :) As long as we
have up to 8 of them, we should be fine, I think. I don't envision
adding BPF_ITERATOR_POINT, I just need prune_point on a few special
helpers.

>
> >  };
> >
