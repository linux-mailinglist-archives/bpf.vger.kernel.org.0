Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3EF41AB242
	for <lists+bpf@lfdr.de>; Wed, 15 Apr 2020 22:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634808AbgDOUEW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Apr 2020 16:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2634793AbgDOUEU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 15 Apr 2020 16:04:20 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4962C061A0C
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2020 13:04:19 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id r7so5089343ljg.13
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2020 13:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+5ngEtqk4+rEsaduachf7G1tbT/D3VTQmFzbcpoKpNM=;
        b=ueCsf6g41MIOfwfJdaP/MsSMVnE+hRNy9Eh4qETPtRzgKO80VvYYrf3aAkVUdZLmKH
         P8hsFieQLNGZFeB/pX1c2ZfEFqmsc8O6XIw4omdxP0zH/OGrHSKv6grVkDAfUR/ynSK/
         ZvhlMOCC6RJBxhzdcgGHi7lpMtN+UUGYTg4/ItwF1/oU5hI4904mNZ5D1SSGAx9hIygl
         VY5uIBf9YNj/D9ai0kCSYtMbNvmFOfISGW6YjI1rh1oRyOtSz7dgtQxBdBc3gQt9tKWx
         pjpCfNewdmQOD4fQMKIUdijDGsFWcOcuRH37Z/56ymFApR4OmMmOAeAoxDnm5STYP/80
         kkuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+5ngEtqk4+rEsaduachf7G1tbT/D3VTQmFzbcpoKpNM=;
        b=JmUs+RMFsUEq9U6hiH/E1Cyl0DkTLJpM9bbZhoSkkkXpejWgTa4BbFcxJu8F0YglXv
         45vXW/uWjmo8PG07xlCldhkQDSUpuBmd++K/fmBcfHnqalli5psGcLs0L5coSLbw5uyC
         F0x5dq8bSsm5PniPdiGxvLrdNZ6+tzHlam9YExRf7zMo+lggN/Qg8j/1x82gvXLp06JI
         MzD2hEpnmT1vwC/G+NajCfuzRU9iCFLa4GswmBBMclLOTmxqyLNAizb2Ob0ym1hpsJZ0
         T31ddH0ZdWu3Tma5vYpfD3tuovOfkL3hpw5KQ2q3K6Wk88oByLI60INmmdpc4sNtXBQc
         U/5Q==
X-Gm-Message-State: AGi0PuYPzWlq5fj0Apgzfcz3vg6XG7FLYhty1XGlnLtiVJyAtQAfWxE8
        1WzUJo+VyXwZjsxFlU0jKT1KvCIK/pUX+4nCkrJvbQ==
X-Google-Smtp-Source: APiQypIxOmpT2c/hzpP6t7MdmsMSbjBG6iNGr58nF8lSprP9AT2bcCFQrZDis78cCgx0Z064iE3GhmN9feXWjwH6UWA=
X-Received: by 2002:a2e:a419:: with SMTP id p25mr3394342ljn.215.1586981057855;
 Wed, 15 Apr 2020 13:04:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez2R5nZA91j7cf2Z5o3dOEz0QNZK7cxecjmw0B-ZQ7AjmA@mail.gmail.com>
 <CAEf4Bzb2zcfJt6ujAN8zY_=x7-dFO92mPzkbCE+UMHVDGL7J+Q@mail.gmail.com>
 <CAG48ez20KjiYjcYzWnnVCyNTMjNFf+YgnwbbF9BUovZxDzsuEw@mail.gmail.com>
 <CAEf4BzbEcbgAmXSzKx70rEhzmWcZ_8ECuX98_wsfvRkprKQgbQ@mail.gmail.com>
 <CAG48ez15gsNtjiwFtLR_eBGAZnfXAt4O+ykuaopVf+jW5KTeRQ@mail.gmail.com>
 <CAEf4Bzak3FnhD3kUZ4Dn9ZRz=yWSfZ+nkYa1Gz1WeZO7PC7Wkw@mail.gmail.com>
 <CAG48ez0mmVtBVTjy-KmpUnvJ52O=EYKwJWoCxcXH8O6zCG1QHA@mail.gmail.com>
 <CAEf4BzZ2vmdmn111KXXrp3qp1qLb4iMjUJ11Cj06SOGeOB6_Qg@mail.gmail.com> <CAG48ez0G5q8CouLsTDHjkOcJ7WKJE09OB9FHFPQJUzQrCmZG1w@mail.gmail.com>
In-Reply-To: <CAG48ez0G5q8CouLsTDHjkOcJ7WKJE09OB9FHFPQJUzQrCmZG1w@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 15 Apr 2020 22:03:51 +0200
Message-ID: <CAG48ez1Bs8_3_+uUB69Qe3RN7tDgD8PcBrzv1H0fqbvd0f4jPw@mail.gmail.com>
Subject: Re: BPF map freezing is unreliable; can we instead just inline constants?
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Matthew Garrett <mjg59@google.com>,
        KP Singh <kpsingh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 15, 2020 at 9:07 PM Jann Horn <jannh@google.com> wrote:
> On Wed, Apr 15, 2020 at 6:59 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > On Tue, Apr 14, 2020 at 3:50 PM Jann Horn <jannh@google.com> wrote:
> > > On Tue, Apr 14, 2020 at 9:46 PM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > > On Tue, Apr 14, 2020 at 9:07 AM Jann Horn <jannh@google.com> wrote:
> > > > > On Fri, Apr 10, 2020 at 10:48 PM Andrii Nakryiko
> > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > > On Fri, Apr 10, 2020 at 1:47 AM Jann Horn <jannh@google.com> wrote:
> > > > > > > On Fri, Apr 10, 2020 at 1:33 AM Andrii Nakryiko
> > > > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > > > > On Wed, Apr 8, 2020 at 12:42 PM Jann Horn <jannh@google.com> wrote:
> > > > > > > > >
> > > > > > > > > Hi!
> > > > > > > > >
> > > > > > > > > I saw that BPF allows root to create frozen maps, for which the
> > > > > > > > > verifier then assumes that they contain constant values. However, map
> > > > > > > > > freezing is pretty wobbly:
[...]
> > > > I'd say
> > > > the better way would be to implement immutable BPF maps from the time
> > > > they are created. E.g., at the time of creating map, you specify extra
> > > > flag BPF_F_IMMUTABLE and specify pointer to a blob of memory with
> > > > key/value pairs in it.
> > >
> > > It seems a bit hacky to me to add a new special interface for
> > > populating an immutable map. Wouldn't it make more sense to add a flag
> > > for "you can't use mmap on this map", or "I plan to freeze this map",
> > > or something like that, and keep the freezing API?
> >
> > "you can't use mmap on this map" is default behavior, unless you
> > specify BPF_F_MMAPABLE.
>
> Ah, right.
>
> > "I plan to freeze this map" could be added,
> > but how that would help existing users that freeze and mmap()?
> > Disallowing those now would be a breaking change.
> > Currently, libbpf is using freezing for .rodata variables, but it
> > doesn't mmap() before freezing.
>
> Okay, so it sounds like there are probably no actual users that use
> both BPF_F_MMAPABLE and freezing, and so we can just forbid that
> combination? That sounds great.

kpsingh pointed out to me that bpf_object__load_skeleton() has code
specifically for mmap()ing BPF_F_RDONLY_PROG maps, so this might not
work... but perhaps we could make `BPF_F_RDONLY_PROG|BPF_F_MMAPABLE`
imply "you can only map with PROT_READ, not with PROT_WRITE"?
bpf_object__load_skeleton() only maps BPF_F_RDONLY_PROG maps with
PROT_READ.
