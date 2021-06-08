Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650F73A07BE
	for <lists+bpf@lfdr.de>; Wed,  9 Jun 2021 01:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbhFHX02 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Jun 2021 19:26:28 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:38473 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbhFHX02 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Jun 2021 19:26:28 -0400
Received: by mail-lf1-f53.google.com with SMTP id r5so34872087lfr.5
        for <bpf@vger.kernel.org>; Tue, 08 Jun 2021 16:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y05BgSUNRKtQgGVFWHoDe7i62qxD+Ta6n7N8OVyaJiU=;
        b=Eybyqq77zEYI/ErCjzQ5Auh+//RDduJQq0yS84EMu2hTenRj035DGbuyab3RzybXbU
         yS1CeN+1js4d3TSO/fuyTKvZc/qkVmCmxiqsTynF60JmXy9Pv4UshddOZPW8dbKoHOb9
         IqKfuwe4JwkCdFMP5aN5mt8ba3TODySgoHIld/GW0uKUyjxaRpcUhjEGP+GVOXmZp6KR
         KbcLQjzVFaYsit5V3FszmHZbmUlDo6EX5T3M51PO9XvFkgq4CsLx5ItVz9IAL+fK8M9/
         wuLNOOr7Yu6YN2PgSE90+sdIg/AEEu/QfRd6iuMasBv3EZUrqcEX388vZ6wpVEiLjnzu
         B4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y05BgSUNRKtQgGVFWHoDe7i62qxD+Ta6n7N8OVyaJiU=;
        b=eFJKDfd0uZWtXeTzApG2Eu9ce/wyJuEZOI7TabC091kdMtyLD6S5vXaM5dOJs/ig8Z
         T5aoqv6maCZO2FsbUuE/gJufSeCfcqw3Z4O8nrroHA9Ca57iazUX8kmKAu77r+QD7V+v
         OCyhtLSogGRZmwbZX3YvtUEMatbYQG9jRoViLRZ6SOQIahWaGgNML/fIIRolLfU26Gah
         ZroZZg1ui+kZY9be4o6pAqmsCSOUaN9cT5xchASZd16mdUoH71JmcgiOyxVfhWzCrdh7
         H/J/ME7gF5ekr1Ge5jYMXReWt0Y48CzTgAhQ4zQLRhkbK7G8rbLloSLKRU+9aSgV/Yhd
         tHDw==
X-Gm-Message-State: AOAM533TiZeaeUxcVGoQZOGLP6+/EqLXznNszFSti23qWO7xRQJ6lH/T
        F0lwpWVPyfc6lXnDRo+pYs2DQnDHAht+uLc9Gc4=
X-Google-Smtp-Source: ABdhPJyUw+kJ4jnWo4JCOvJ07t1lB2a9G9VTzcZCQu6Lsclld4AoObXuNlk5kl9Dqq7b8yp+B/pWqfq8ifWO2bZNeO4=
X-Received: by 2002:ac2:4649:: with SMTP id s9mr17832642lfo.540.1623194600355;
 Tue, 08 Jun 2021 16:23:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210525033314.3008878-1-yhs@fb.com> <20210525182948.4wk3kd7vrvgdr2lu@google.com>
 <dd95b896-3b37-a398-68cd-549fb249f2e0@fb.com> <CAFP8O3JM3SrKXYA2SF-zRJZCiipHdcyF1usPOykm6Yqb6xs6dQ@mail.gmail.com>
 <4410f328-58ae-24e4-5e63-cfde6e891bf4@fb.com> <CAFP8O3J4_aaT+POmB6H6mihuP1-VQ4ww1nVrHxEvd70S5ODEUw@mail.gmail.com>
 <8abe01cb-da8f-514c-6b52-b92686a16662@fb.com> <CAFP8O3JeGtDMATPsnjhRO3Ru+Lap2uJSG_jYzWcK4AWeBtXquw@mail.gmail.com>
 <CAADnVQ+sD7ELvEwKf5Ui1dVkXPYEyjkwFxogxP5_4vrH3nMhPA@mail.gmail.com>
 <CAFP8O3KayCgP6OqF1Vx8afav==jkL038m0rK66b7jJ0DOO=uJQ@mail.gmail.com>
 <20210608183205.l22q43hinv6lzb4h@ast-mbp.dhcp.thefacebook.com> <CAFP8O3LUNWP69fJznwcH6QYvDjK427WZBeS0F-L390Y5=Szkdg@mail.gmail.com>
In-Reply-To: <CAFP8O3LUNWP69fJznwcH6QYvDjK427WZBeS0F-L390Y5=Szkdg@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 8 Jun 2021 16:23:07 -0700
Message-ID: <CAADnVQJa=b=hoMGU213wMxyZzycPEKjAPFArKNatbVe4FvzVUA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] docs/bpf: add llvm_reloc.rst to explain llvm
 bpf relocations
To:     =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Cc:     elfutils-devel@sourceware.org, Yonghong Song <yhs@fb.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 8, 2021 at 4:10 PM F=C4=81ng-ru=C3=AC S=C3=B2ng <maskray@google=
.com> wrote:
>
> On Tue, Jun 8, 2021 at 11:32 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Jun 08, 2021 at 09:33:28AM -0700, F=C4=81ng-ru=C3=AC S=C3=B2ng =
wrote:
> > > On Tue, Jun 8, 2021 at 8:49 AM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Mon, Jun 7, 2021 at 10:51 PM F=C4=81ng-ru=C3=AC S=C3=B2ng <maskr=
ay@google.com> wrote:
> > > > >
> > > > > You can rename R_BPF_64_64 to something more meaningful, e.g. R_B=
PF_64_LDIMM64.
> > > > > Then I am fine that such a relocation type applies inconsecutive =
bytes.
> > > > >
> > > > > See below. Just change every occurrence of the old name in llvm-p=
roject.
> > > >
> > > > No. We cannot rename them, because certain gnu tools resolve relos =
by name
> > > > and not by number.
> > >
> > > How do the GNU tools resolve relocations by name instead of by
> > > relocation type number?
> > > I don't think this should and can be supported.
> > >
> > > Most tools should do:
> > > if (type =3D=3D R_BPF_64_64) do_something();
> > >
> > > You are free to change them to
> > > if (type =3D=3D R_BPF_64_LDIMM64) do_something();
> > > as long as R_BPF_64_LDIMM64 is defined as the number.
> >
> > If you're going to succeed convincing elfutils maintainers to change
> > their whole design then we can realistically talk about renaming.
> > As a homework try cloning elfutils.git then change the name in backends=
/x86_64_reloc.def
> > or bpf_reloc.def while keeping the numbers and observe how the standard=
 tools stop working.
> >
> > Also R_BPF_64_64 may not be the best name, but R_BPF_64_LDIMM64 is
> > not a good name either.
>
> I used R_BPF_64_LDIMM64 as an example. Surely you could name it more
> appropriately.
>
> > Most architectures avoid using instruction mnemonic
> > in relo names. The relo name should describe what it does instead of in=
sn
> > it applies to. TLS, GOT, PLT, ABS are good suffixes to use. LDIMM64 - n=
ot really.
> > Instead of R_BPF_64_32 we could have used R_BPF_64_PC32, but not R_BPF_=
64_CALL32.
> > Anyway it's too late to change.
>
> R_X86_64_PC32/R_X86_64_PLT32 are different.
> Please see https://sourceware.org/pipermail/binutils/2020-April/000424.ht=
ml
> for why a dedicated branch relocation
> is preferred for a branch instruction.
>
>
> elfutils folks,
>
> BPF is adding new relocation types R_BPF_64_ABS64/R_BPF_64_ABS32 which
> will can cause ongoing confusion with the existing
> R_BPF_64_32/R_BPF_64_64.

Not true. There is no confusion.
Everything is clearly documented:
https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/Docum=
entation/bpf/llvm_reloc.rst

> Can you comment on why elfutils cannot rename R_BPF_64_32/R_BPF_64_64
> while keep R_BPF_64_32/R_BPF_64_64 as deprecated aliases for the new
> names?

To make it clear... we're not proposing to rename or deprecate them.
That's Fang-Rui's suggestion that doesn't make sense to us
due to overhead involved and backward compatibility issues it brings.
