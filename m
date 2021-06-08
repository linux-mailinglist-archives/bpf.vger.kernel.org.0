Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A84E3A079A
	for <lists+bpf@lfdr.de>; Wed,  9 Jun 2021 01:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbhFHXNc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Jun 2021 19:13:32 -0400
Received: from mail-yb1-f175.google.com ([209.85.219.175]:36719 "EHLO
        mail-yb1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234298AbhFHXNb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Jun 2021 19:13:31 -0400
Received: by mail-yb1-f175.google.com with SMTP id c14so3595778ybk.3
        for <bpf@vger.kernel.org>; Tue, 08 Jun 2021 16:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FUD9YIYr3ZqvUfG9O54AzvdECXzZfKyWamdIgRHxwEk=;
        b=KQvKIFWZp69iNDsNxjuW88hx0wnPbQvAF1qrvoP9F/i+2rZET4vyJcuSCwe7VoRAFN
         AO4lyTvZAUC/ytuZs9lpdKDy56IJmSKCRhNHR7GKMyea1boQCIMe1zW215eu7+by9nBE
         eymcEnbAIUpiDSBawmK/qzWBM3/wDGSQB8WXeM9W5nLg4153bvcCKGPtakLfXeqtsmux
         4/eoVv/0NYjAT83avWTtT+JPUhS6t1QcggCWehdtK/hpCssPj0j0bNrHamVCtRIvm1vk
         zxzg/A4nfDg9+cTii0M/ZgnLiOLaxPXHia4aarxP0+F4OVspU3a2QplkpTZz95IEn71Z
         gzkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FUD9YIYr3ZqvUfG9O54AzvdECXzZfKyWamdIgRHxwEk=;
        b=OUJg0c4UCXbZ3s503mmYdw9AmKndIOezl4xXmpV7XTEl72JMAyaQYS6VfHg52g6WQE
         yRja2xSol9yLZpYN4QxKo8Rs4cyhV71siYL84M11o8NBfDmAnoAifkQX2+exQM/+8lkB
         v20WarAjXuIwALQlaTOqzP1dAB4ph5i3triNku0G2LSiv9XWNJEGb85afsxKbhwyElTR
         RTAy7elPYuK0PukhSR/6lr/vrJ1dUcvi4gZAoL08I2vZrzOYyWCO/DzcaUyv4hzM1UZu
         Su+g7Jc/3IodmEI786e6vm82+91wvUhM4wE4De//+0US9tqZO2c3MGC4FEikmcK4zPZL
         o0FQ==
X-Gm-Message-State: AOAM533muSJnTGXsMC2tQmmFehnqV/7kLwd5FDT1cU9NnM4CbR8TfgK0
        SRuJmBaeL8vRYJlwrXsip0Iu7yY2c/ccgHtZvhBuQA==
X-Google-Smtp-Source: ABdhPJyGHyjPmNC9b6TrdGe5YUyVumuLZ9vHch2ktSx9c6Ngg+c/AoEbcPNEvcjr3R9t0SETOnhnHxFR6PQQ/vD8J3o=
X-Received: by 2002:a25:11c5:: with SMTP id 188mr34575738ybr.322.1623193837537;
 Tue, 08 Jun 2021 16:10:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210525033314.3008878-1-yhs@fb.com> <20210525182948.4wk3kd7vrvgdr2lu@google.com>
 <dd95b896-3b37-a398-68cd-549fb249f2e0@fb.com> <CAFP8O3JM3SrKXYA2SF-zRJZCiipHdcyF1usPOykm6Yqb6xs6dQ@mail.gmail.com>
 <4410f328-58ae-24e4-5e63-cfde6e891bf4@fb.com> <CAFP8O3J4_aaT+POmB6H6mihuP1-VQ4ww1nVrHxEvd70S5ODEUw@mail.gmail.com>
 <8abe01cb-da8f-514c-6b52-b92686a16662@fb.com> <CAFP8O3JeGtDMATPsnjhRO3Ru+Lap2uJSG_jYzWcK4AWeBtXquw@mail.gmail.com>
 <CAADnVQ+sD7ELvEwKf5Ui1dVkXPYEyjkwFxogxP5_4vrH3nMhPA@mail.gmail.com>
 <CAFP8O3KayCgP6OqF1Vx8afav==jkL038m0rK66b7jJ0DOO=uJQ@mail.gmail.com> <20210608183205.l22q43hinv6lzb4h@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20210608183205.l22q43hinv6lzb4h@ast-mbp.dhcp.thefacebook.com>
From:   =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Date:   Tue, 8 Jun 2021 16:10:26 -0700
Message-ID: <CAFP8O3LUNWP69fJznwcH6QYvDjK427WZBeS0F-L390Y5=Szkdg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] docs/bpf: add llvm_reloc.rst to explain llvm
 bpf relocations
To:     elfutils-devel@sourceware.org
Cc:     Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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

On Tue, Jun 8, 2021 at 11:32 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Jun 08, 2021 at 09:33:28AM -0700, F=C4=81ng-ru=C3=AC S=C3=B2ng wr=
ote:
> > On Tue, Jun 8, 2021 at 8:49 AM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Jun 7, 2021 at 10:51 PM F=C4=81ng-ru=C3=AC S=C3=B2ng <maskray=
@google.com> wrote:
> > > >
> > > > You can rename R_BPF_64_64 to something more meaningful, e.g. R_BPF=
_64_LDIMM64.
> > > > Then I am fine that such a relocation type applies inconsecutive by=
tes.
> > > >
> > > > See below. Just change every occurrence of the old name in llvm-pro=
ject.
> > >
> > > No. We cannot rename them, because certain gnu tools resolve relos by=
 name
> > > and not by number.
> >
> > How do the GNU tools resolve relocations by name instead of by
> > relocation type number?
> > I don't think this should and can be supported.
> >
> > Most tools should do:
> > if (type =3D=3D R_BPF_64_64) do_something();
> >
> > You are free to change them to
> > if (type =3D=3D R_BPF_64_LDIMM64) do_something();
> > as long as R_BPF_64_LDIMM64 is defined as the number.
>
> If you're going to succeed convincing elfutils maintainers to change
> their whole design then we can realistically talk about renaming.
> As a homework try cloning elfutils.git then change the name in backends/x=
86_64_reloc.def
> or bpf_reloc.def while keeping the numbers and observe how the standard t=
ools stop working.
>
> Also R_BPF_64_64 may not be the best name, but R_BPF_64_LDIMM64 is
> not a good name either.

I used R_BPF_64_LDIMM64 as an example. Surely you could name it more
appropriately.

> Most architectures avoid using instruction mnemonic
> in relo names. The relo name should describe what it does instead of insn
> it applies to. TLS, GOT, PLT, ABS are good suffixes to use. LDIMM64 - not=
 really.
> Instead of R_BPF_64_32 we could have used R_BPF_64_PC32, but not R_BPF_64=
_CALL32.
> Anyway it's too late to change.

R_X86_64_PC32/R_X86_64_PLT32 are different.
Please see https://sourceware.org/pipermail/binutils/2020-April/000424.html
for why a dedicated branch relocation
is preferred for a branch instruction.



elfutils folks,

BPF is adding new relocation types R_BPF_64_ABS64/R_BPF_64_ABS32 which
will can cause ongoing confusion with the existing
R_BPF_64_32/R_BPF_64_64.

Can you comment on why elfutils cannot rename R_BPF_64_32/R_BPF_64_64
while keep R_BPF_64_32/R_BPF_64_64 as deprecated aliases for the new
names?
