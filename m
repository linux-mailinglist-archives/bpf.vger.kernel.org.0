Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9C839C552
	for <lists+bpf@lfdr.de>; Sat,  5 Jun 2021 04:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbhFEC5f (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Jun 2021 22:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhFEC5f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Jun 2021 22:57:35 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2A8C061766;
        Fri,  4 Jun 2021 19:55:36 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id q21so16351904ybg.8;
        Fri, 04 Jun 2021 19:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kFAeb4hs4UVnuPEAb7Qf4+evjqswzGUFc01xkzxilbc=;
        b=ovtIHkihJUASDy3i7jvAePiUSrNbrSjnikZxoZa/GZbkt34NTTgapHWr9yUM51/eS5
         V90370f7dxZe2ZJr+qse5nvjfUQxU7Au7RADgm5PBubBjShWjRW1ew9GHiXIOJ7xkz2m
         dE6dSGbdx8gQd2dkHbYIf6QceAGezP3wPSe13PYtwa1Nf86wizl+2hkHmgbl24pRlH1X
         lmOIHVDUn/666LaIOpiKgDCYdfvXdVmhtBRN7PMHkHMVYiUDPOEW5Q41BzcOqb6Nlt+l
         vya/Z5wet8W9vAUrTBvbCLU1ckI7eiEgCwvNrlXVP7vx94fzASNH8rPVbEJU0yNqhkRS
         L0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kFAeb4hs4UVnuPEAb7Qf4+evjqswzGUFc01xkzxilbc=;
        b=ZQjM/FOpn0REwnS3TP/9wuL9SE2ssSxlFW81lNHqAAJHcBqHlGq/whBBGNtp2E0bCU
         zpizqorNgwkhxiMUYL1e3Q8q30EnmNrw82rRUp+1KCv/7cLOlNB3g6rg7uq9n+d9nCBQ
         owQO+Fok0Y84Z9LxrIeLLRTr6cg3XZnJ0YHAcAjGv0sgZHagsGqjkljopTnLNy6tkEMM
         RLQZ89VI+GJPfPldG9+RV+67R8fNl3cxOYJqRTjqd796fJW2FaXGRFPPsq2Q3RoEqxsj
         EghEx7KNBVchR/xo6Sw4Sqpy7BqXvBPeyV7oPYt9ufF/JQW7iD1ctrfeOiDGW1faW5D7
         Vz7A==
X-Gm-Message-State: AOAM5327LbCy5bpDMKZRT5YrcPhirsxrSS4zq9OW6Rdi+CthETggFKRa
        4wXao8SRGB5BfwiQ6a+hco9Lns5s579s6heBtP3KVKHi0JE=
X-Google-Smtp-Source: ABdhPJxnLYLrCNfZlnpNO0hQ45yYQUt5DWHNXCYfp0v04O9SVv+IuhBl2VobnlB5ejSJ1nZ3RurqzBR6I01PM9jLkrI=
X-Received: by 2002:a25:1455:: with SMTP id 82mr9468639ybu.403.1622861728805;
 Fri, 04 Jun 2021 19:55:28 -0700 (PDT)
MIME-Version: 1.0
References: <YK+41f972j25Z1QQ@kernel.org> <CAEf4BzaTP_jULKMN_hx6ZOqwESOmsR6_HxWW-LnrA5xwRNtSWg@mail.gmail.com>
 <4615C288-2CFD-483E-AB98-B14A33631E2F@gmail.com> <CAEf4BzaQmv1+1bPF=1aO3dcmNu2Mx0EFhK+ZU6UFsMjv3v6EZA@mail.gmail.com>
 <4901AF88-0354-428B-9305-2EDC6F75C073@gmail.com> <CAEf4BzZk8bcSZ9hmFAmgjbrQt0Yj1usCHmuQTfU-pwZkYQgztA@mail.gmail.com>
 <YLFIW9fd9ZqbR3B9@kernel.org> <CAEf4BzYCCWM0WBz0w+vL1rVBjGvLZ7wVtgJCUVr3D-NmVK0MEg@mail.gmail.com>
 <YLjtwB+nGYvcCfgC@kernel.org>
In-Reply-To: <YLjtwB+nGYvcCfgC@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 4 Jun 2021 19:55:17 -0700
Message-ID: <CAEf4BzbQ9w2smTMK5uwGGjyZ_mjDy-TGxd6m8tiDd3T_nJ7khQ@mail.gmail.com>
Subject: Re: [RFT] Testing 1.22
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 3, 2021 at 7:57 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Sat, May 29, 2021 at 05:40:17PM -0700, Andrii Nakryiko escreveu:
> > On Fri, May 28, 2021 at 12:45 PM Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> > > commit b579a18a1ea0ee84b90b5302f597dda2edf2f61b
> > > Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > Date:   Fri May 28 16:41:30 2021 -0300
> > >
> > >     pahole: Allow encoding BTF into a detached file
> > >
> > >     Previously the newly encoded BTF info was stored into a ELF section in
> > >     the file where the DWARF info was obtained, but it is useful to just
> > >     dump it into a separate file, do it.
> > >
> > >     Requested-by: Andrii Nakryiko <andrii@kernel.org>
> > >     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > >
> >
> > Looks good, see few minor comments below. At some point it probably
> > would make sense to formalize "btf_encoder" as a struct with its own
> > state instead of passing in multiple variables. It would probably also
>
> Take a look at the tmp.master branch at:
>
> https://git.kernel.org/pub/scm/devel/pahole/pahole.git/log/?h=tmp.master

Oh wow, that's a lot of commits! :) Great that you decided to do this
refactoring, thanks!

>
> that btf_elf class isn't used anymore by btf_loader, that uses only
> libbpf's APIs, and now we have a btf_encoder class with all the globals,
> etc, more baby steps are needed to finally ditch btf_elf altogether and
> move on to the parallelization.

So do you plan to try to parallelize as a next step? I'm pretty
confident about BTF encoding part: dump each CU into its own BTF, use
btf__add_type() to merge multiple BTFs together. Just need to re-map
IDs (libbpf internally has API to visit each field that contains
type_id, it's well-defined enough to expose that as a public API, if
necessary). Then final btf_dedup().

But the DWARF loading and parsing part is almost a black box to me, so
I'm not sure how much work it would involve.

>
> I'm doing 'pahole -J vmlinux && btfdiff' after each cset and doing it
> very piecemeal as I'm doing will help bisecting any subtle bug this may
> introduce.
>
> > allow to parallelize BTF generation, where each CU would proceed in
> > parallel generating local BTF, and then the final pass would merge and
> > dedup BTFs. Currently reading and processing DWARF is the slowest part
> > of the DWARF-to-BTF conversion, parallelization and maybe some other
> > optimization seems like the only way to speed the process up.
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
>
> Thanks!
>
> - Arnaldo
