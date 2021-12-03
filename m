Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC583467F49
	for <lists+bpf@lfdr.de>; Fri,  3 Dec 2021 22:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353858AbhLCV2x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Dec 2021 16:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344120AbhLCV2x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Dec 2021 16:28:53 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFF2C061751
        for <bpf@vger.kernel.org>; Fri,  3 Dec 2021 13:25:29 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id w33-20020a17090a6ba400b001a722a06212so5935298pjj.0
        for <bpf@vger.kernel.org>; Fri, 03 Dec 2021 13:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k1HLRshyBiD/n6fwLJydFVHErVTIRC4zpCbU5GzEFX4=;
        b=cJuQ6HFUrKNgejsV89/VtC0ZNtI7Zwsajm5N7he75pim2zU5vV+qvF7CyAo/XDKbOp
         e2BUDNLto5w3Xz7g/QKVIojoKk187rvfUxpT2mCwiW+vSQozK61c21mXNUvsqi4F/Aij
         X8Z4xF/82j0WTKsMyUORaP+u2s2xidSBnpfBA8NE691H9Zif8TJHy3FV1o1t67dP1Bdz
         BwcsruYB1Xij5BqzVMbtw8iY18IIaSWxAI4BrQxELF5jYRe6Jo1Ga6BPOAv7wnmSvSw6
         L4z3cmTz7jCCWcLrL/sMiVOXy7mVA2c8sL9zslCIfV/Cp2SHpJzDhks4/Q22kcuZWGQs
         9bdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k1HLRshyBiD/n6fwLJydFVHErVTIRC4zpCbU5GzEFX4=;
        b=dFztAneyg+p2u0jwnT+N42tJa3LNBfAYeusxkoQTH9QJHxipDpaZ+LGoYDN3aDUJ2b
         XYrlGVDxaaLcENkGdGValgN+eSBgrLeuOXzVT2DzEztdDZBO1ZvuYhQHlyYcjYAaWrek
         YQvh+fCQd/Ww2+5QJovV5QqmMAuE5z2jIx91SmS4TUvhxshON6jn8XbzgAljeenkUZfE
         YTo0qHEfO10d4Wr87aNnnAm9CcV3KK/QFre45PZt5srftSzdIUbeIIvxpKy2cwdTYQid
         SI0Gu+vaniODQ7skcUuhf6qrffnI1e6LFXLnLshUYMN7LgnF4hD2piGWcHPtEbva0wt1
         6kQQ==
X-Gm-Message-State: AOAM533rzFUfblfVs+XrPTUOy5OXWHFHAswtMXea3iRodhzNYl2cYUI/
        gDBTgYZN5TmHayi3Szgm2qjHEljjyEZguv6UcD8=
X-Google-Smtp-Source: ABdhPJzg0YBVfTryDlIblDlENiMLf+y6CkwibnmgxwoqQUQOleKCkkJ6N81z/n20xQfhStg5pAo6KAlIZL40YI5ff1A=
X-Received: by 2002:a17:903:2306:b0:141:e52e:457d with SMTP id
 d6-20020a170903230600b00141e52e457dmr25531071plh.3.1638566728475; Fri, 03 Dec
 2021 13:25:28 -0800 (PST)
MIME-Version: 1.0
References: <20211203182836.16646-1-alexei.starovoitov@gmail.com>
 <CAEf4BzaYwWw1tCiu0Kk34YpEJeqDTLCKmrxgDCKr8fyZbTQYYw@mail.gmail.com>
 <CAADnVQJ8y6ZUw5L1TLwUrBviq5DFJShfi+EBjkgMnSb23QBd3Q@mail.gmail.com> <CAEf4Bzbvvinya8dQFCBpAYazYEEa0Na=zaeYXay0MH33a9NQuA@mail.gmail.com>
In-Reply-To: <CAEf4Bzbvvinya8dQFCBpAYazYEEa0Na=zaeYXay0MH33a9NQuA@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 3 Dec 2021 13:25:17 -0800
Message-ID: <CAADnVQKq4hdy9vafKTN8pQ_2vJmM6g61JD3pHghEJXZTmjz0gg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Reduce bpf_core_apply_relo_insn() stack usage.
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 3, 2021 at 1:22 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> > > > -                            struct bpf_core_cand_list *cands)
> > > > +                            struct bpf_core_cand_list *cands,
> > > > +                            struct bpf_core_spec *specs)
> > >
> > > same here, let's pass three separate arguments instead of having to
> > > remember which array element corresponds to which (local vs cand vs
> > > targ). It doesn't prevent kernel-side from using an array and just
> > > passing pointers.
> >
> > I don't understand the suggestion.
> > There is nothing to remember. It could have been just raw bytes
> > of appropriate size. It's temp data.
> > Passing them as 3 different args would make an impression
> > that they're actually meaningful. They're not. It's a scratch space.
>
> Ok, fair enough. I've renamed specs to specs_scratch to make this more
> explicit and pushed to bpf-next.

Yep. Such name makes sense. Thanks
