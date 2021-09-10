Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1E644070C5
	for <lists+bpf@lfdr.de>; Fri, 10 Sep 2021 20:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbhIJSHS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Sep 2021 14:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhIJSHR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Sep 2021 14:07:17 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B78C061574
        for <bpf@vger.kernel.org>; Fri, 10 Sep 2021 11:06:06 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id s16so5671182ybe.0
        for <bpf@vger.kernel.org>; Fri, 10 Sep 2021 11:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HjCNa30qBDjRtQxmqxmLE0vViW1A6L8fKlhhMGIPslM=;
        b=mp1MX7mQPYp27L7/WL16P6ijCnNBUpaDvNvndz+h8PSj2WHfDM/by9MTjCDvTnNTDZ
         yJXh0eWeTMKB6JddBo34YMxeO4a1TDzec6aPGNfP1LmnayUQgBiLh0QrYUKuCzsqf5jg
         G7UP0N+5t4+jtX6xDuIfR1Nz5LPAB4CPbghCFTXLkimv7IaeLhsSehehCcr6JVOvVbh1
         zhrGdQ3rXlaei3Ckx+5CZ2J20I3Rmuuhja1LE+MRNy+DOa4QV38NlszSoWlTeIZ0bzj/
         gs+hTDUlBjPtVxCpvLxnxt9MBdJgcEWHXfoU5k3w/5WRia6TtBbAlZm/z9+OEiZEB8+H
         Ip0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HjCNa30qBDjRtQxmqxmLE0vViW1A6L8fKlhhMGIPslM=;
        b=kS7cpX2H/Hzl2s3ykQyzSjmgGnMXcyq4QvLgC8JfgxdAqgEkSqCG8jAqxF6rsxSeeV
         QmpKm9Yb1YCah6CkFHeEDqw0tzxT7V0L+/R+Um4sfActxTOVepBKET3+3k5jYAwBJeNu
         XnIUY2Y9PwU6JscVOdj2q3jvmeoZCRR623hRtyBnkB1WgyySFkqHZ+4ivozYNg4P6PD5
         1goiqZrvMGw11Zvj3R+B5iNMcsAdkKZYkimW2XZ1LTNEBTfJ3GmQ7aM6YaMXgG9a+3PZ
         NzXiBQOzV7rNhnHB1B2Oz09sPoBB4RbzIT/o18Hgdnne+2KQzsT3t8DtYFXlVIm5qoPr
         I5Cw==
X-Gm-Message-State: AOAM531RdgaIT3MlsIXazKQFnEOrynN7ptXLfIAXfnC7fyVUYwUSF6I+
        IrMR8+ThjuNbLFF7J/iVDKFsa4NmO8AUNG7fe1U=
X-Google-Smtp-Source: ABdhPJwUJUGe0mo7tShACyW+29eZ32Z6OpuM5FQHy/9Riz01vC4LqDuFoPmAhOVC/JdzDfaJ+EYL5lGcq/6zgtgZduw=
X-Received: by 2002:a05:6902:725:: with SMTP id l5mr14098709ybt.178.1631297165468;
 Fri, 10 Sep 2021 11:06:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210907230050.1957493-1-yhs@fb.com> <20210907230138.1960995-1-yhs@fb.com>
 <CAEf4BzYy7_1jUHiNy6VWJ7nw4sUa5gABW1Mosc-1zcd+unvSZw@mail.gmail.com> <3ea879c6-3a83-8e09-c2b4-ae84161502d7@fb.com>
In-Reply-To: <3ea879c6-3a83-8e09-c2b4-ae84161502d7@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 10 Sep 2021 11:05:54 -0700
Message-ID: <CAEf4BzYW_UVVEp1=+-Ath5nG3bCqo2T3YwpKQqDp1cCVLyfA8A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 9/9] docs/bpf: add documentation for BTF_KIND_TAG
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 10, 2021 at 9:40 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 9/8/21 10:42 PM, Andrii Nakryiko wrote:
> > On Tue, Sep 7, 2021 at 4:01 PM Yonghong Song <yhs@fb.com> wrote:
> >>
> >> Add BTF_KIND_TAG documentation in btf.rst.
> >>
> >> Signed-off-by: Yonghong Song <yhs@fb.com>
> >> ---
> >>   Documentation/bpf/btf.rst | 30 ++++++++++++++++++++++++++++--
> >>   1 file changed, 28 insertions(+), 2 deletions(-)
> >>
> >
> > [...]
> >
> >> +2.2.17 BTF_KIND_TAG
> >> +~~~~~~~~~~~~~~~~~~~
> >> +
> >> +``struct btf_type`` encoding requirement:
> >> + * ``name_off``: offset to a non-empty string
> >> + * ``info.kind_flag``: 0 for tagging ``type``, 1 for tagging member/argument of the ``type``
> >> + * ``info.kind``: BTF_KIND_TAG
> >> + * ``info.vlen``: 0
> >> + * ``type``: ``struct``, ``union``, ``func`` or ``var``
> >> +
> >> +``btf_type`` is followed by ``struct btf_tag``.::
> >> +
> >> +    struct btf_tag {
> >> +        __u32   comp_id;
> >> +    };
> >> +
> >> +The ``name_off`` encodes btf_tag attribute string.
> >> +If ``info.kind_flag`` is 1, the attribute is attached to the ``type``.
> >
> > This contradicts "info.kind_flag" description above
>
> will remove info.kind_flag stuff in the next revision.
>
> >
> >> +If ``info.kind_flag`` is 0, the attribute is attached to either a
> >> +``struct``/``union`` member or a ``func`` argument.
> >> +Hence the ``type`` should be ``struct``, ``union`` or
> >> +``func``, and ``btf_tag.comp_id``, starting from 0,
> >> +indicates which member or argument is attached with
> >> +the attribute.
> >
> > Does the kernel validate this restriction for the VAR target type?
> > I.e., if we have kind_flag == 0 (member of type), we should disallow
> > VAR, right?
>
> Yes, I even has a selftest for that.

Great, must have missed it on initial review pass.

>
> >
> >> +
> >>   3. BTF Kernel API
> >>   *****************
> >>
> >> --
> >> 2.30.2
> >>
