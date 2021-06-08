Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2EEB39ED6F
	for <lists+bpf@lfdr.de>; Tue,  8 Jun 2021 06:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbhFHEYY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Jun 2021 00:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhFHEYY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Jun 2021 00:24:24 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70AEC061574
        for <bpf@vger.kernel.org>; Mon,  7 Jun 2021 21:22:23 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id g38so28222116ybi.12
        for <bpf@vger.kernel.org>; Mon, 07 Jun 2021 21:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RwMymPAodDhrrbY+6woflL4lnszODa4/Msasy9KqAN0=;
        b=HxNuDXa/XWSeayXg0Cedrmo5PUDqija3IVrjTRiC7lJB6q+TMH6yQ7N9EzFG/1S3pG
         2WPKfstKE+TCh6dDev+2l7uY3Anl3QPyXcxzdvaVkFRVneIGpcp2wMtI6RH2vZffavuv
         PpQJeZCS1uk5hwyChEnsvJUBqAt9Tr35kYwO8YHz7CH7b54ErIgR2b/LTrS9UuvMG0c/
         EzMLyUKW1Wp50yR7JlvoQIMgO0acUUwer4RwlmfNlamkTZRtmVo3MjZ4miF3YecQG5jd
         6zS8Ok/M9CTfdpj1zAD12jwDu/cQT8VEuXIxDipDC7sBqcTfOqRUs8yI5sSY2mUNiCwP
         f+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RwMymPAodDhrrbY+6woflL4lnszODa4/Msasy9KqAN0=;
        b=nAUUtm6XVJRiyP+OOaOO+k+ABIkQr5+54S/kTDXVNbHWX/rqxYlauTWdpdCC8vgrwy
         8p4V11eFciyk3XKRHKV72Vi3ffoKC6Nxm4dfpktgwbYosr5G7DlzHxR7vJdoGCPG80r9
         5M4rJ/Kcwb60DEdDt1zgEhr+TE8OLEUDj9I6QxtLHo2sCn3Sx8C2AnfHWvsBBCctfJsY
         IVOxVa+BCPHY1SarOb/FqTeFEni1eXQn6zALpijNZqoRyKQlx5bTobe8BkdyPcaFHwTr
         EeSO/yyJh8zCjsWh5c0q/KFA59qZ1dUe4aEGNUp//uNTBiOI9w9fCU2NpKjpFcDjeIfh
         yLDA==
X-Gm-Message-State: AOAM533yRWOuGiqFgFw5ciNeRxr6ep0XtObJrOu9Qm/i3YIpyJIhINSn
        lzlNnLLPeXEDeaijzT41vfEPxmqS3lN3DAmRc3Q=
X-Google-Smtp-Source: ABdhPJzYM3uv9xTZ2U+5YzXJf8cYMKL7KpMfPsj3ZUJxcJ+FsOcNMRHk8iJZmiXsd1rYcZsHECZgNzrZ1gQuyT7q9UQ=
X-Received: by 2002:a25:9942:: with SMTP id n2mr29208243ybo.230.1623126143052;
 Mon, 07 Jun 2021 21:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210525033314.3008878-1-yhs@fb.com> <20210525182948.4wk3kd7vrvgdr2lu@google.com>
 <dd95b896-3b37-a398-68cd-549fb249f2e0@fb.com> <CAFP8O3JM3SrKXYA2SF-zRJZCiipHdcyF1usPOykm6Yqb6xs6dQ@mail.gmail.com>
 <4410f328-58ae-24e4-5e63-cfde6e891bf4@fb.com> <CAFP8O3J4_aaT+POmB6H6mihuP1-VQ4ww1nVrHxEvd70S5ODEUw@mail.gmail.com>
In-Reply-To: <CAFP8O3J4_aaT+POmB6H6mihuP1-VQ4ww1nVrHxEvd70S5ODEUw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 7 Jun 2021 21:22:12 -0700
Message-ID: <CAEf4BzZF6aQsR-y=tVObq_euvmu92gmm8TPUTc_XY3VmZjpLEA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] docs/bpf: add llvm_reloc.rst to explain llvm
 bpf relocations
To:     =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
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

On Mon, Jun 7, 2021 at 3:08 PM F=C4=81ng-ru=C3=AC S=C3=B2ng <maskray@google=
.com> wrote:
>
> On Mon, Jun 7, 2021 at 2:06 PM Yonghong Song <yhs@fb.com> wrote:
> >
> >
> >
> > On 6/5/21 2:03 PM, F=C4=81ng-ru=C3=AC S=C3=B2ng wrote:
> > > On Tue, May 25, 2021 at 11:52 AM Yonghong Song <yhs@fb.com> wrote:
> > >>
> > >>
> > >>
> > >> On 5/25/21 11:29 AM, Fangrui Song wrote:
> > >>> I have a review queue with a huge pile of LLVM patches and have onl=
y
> > >>> skimmed through this.
> > >>>
> > >>> First, if the size benefit of REL over RELA isn't deem that necessa=
ry,
> > >>> I will highly recommend RELA for simplicity and robustness.
> > >>> REL is error-prone.
> > >>
> > >> The worry is backward compatibility. Because of BPF ELF format
> > >> is so intervened with bpf eco system (loading, bpf map, etc.),
> > >> a lot of tools in the wild already implemented to parse REL...
> > >> It will be difficult to change...
> > >
> > > It seems that the design did not get enough initial scrutiny...
> > > (On https://reviews.llvm.org/D101336  , a reviewer who has apparently
> > > never contributed to lld/ELF clicked LGTM without actual reviewing th=
e
> > > patch and that was why I have to click "Request Changes").
> > >
> > > I worry that keeping the current state as-is can cause much
> > > maintenance burden in the LLVM MC layer, linker, and other binary
> > > utilities.
> > > Some things can be improved without breaking backward compatibility.
> > >
> > >>>
> > >>> On 2021-05-24, Yonghong Song wrote:
> > >>>> LLVM upstream commit
> > >>>> https://reviews.llvm.org/D102712
> > >>>> made some changes to bpf relocations to make them
> > >>>> llvm linker lld friendly. The scope of
> > >>>> existing relocations R_BPF_64_{64,32} is narrowed
> > >>>> and new relocations R_BPF_64_{ABS32,ABS64,NODYLD32}
> > >>>> are introduced.
> > >>>>
> > >>>> Let us add some documentation about llvm bpf
> > >>>> relocations so people can understand how to resolve
> > >>>> them properly in their respective tools.
> > >>>>
> > >>>> Cc: John Fastabend <john.fastabend@gmail.com>
> > >>>> Cc: Lorenz Bauer <lmb@cloudflare.com>
> > >>>> Signed-off-by: Yonghong Song <yhs@fb.com>
> > >>>> ---
> > >>>> Documentation/bpf/index.rst            |   1 +
> > >>>> Documentation/bpf/llvm_reloc.rst       | 240 +++++++++++++++++++++=
++++
> > >>>> tools/testing/selftests/bpf/README.rst |  19 ++
> > >>>> 3 files changed, 260 insertions(+)
> > >>>> create mode 100644 Documentation/bpf/llvm_reloc.rst
> > >>>>

[...]

> > >>>> +  Enum  ELF Reloc Type     Description      BitSize  Offset
> > >>>> Calculation
> > >>>> +  0     R_BPF_NONE         None
> > >>>> +  1     R_BPF_64_64        ld_imm64 insn    32       r_offset + 4=
  S
> > >>>> + IA
> > >>>> +  2     R_BPF_64_ABS64     normal data      64       r_offset    =
  S
> > >>>> + IA
> > >>>> +  3     R_BPF_64_ABS32     normal data      32       r_offset    =
  S
> > >>>> + IA
> > >>>> +  4     R_BPF_64_NODYLD32  .BTF[.ext] data  32       r_offset    =
  S
> > >>>> + IA
> > >>>> +  10    R_BPF_64_32        call insn        32       r_offset + 4=
  (S
> > >>>> + IA) / 8 - 1
> > >>>
> > >>> Shifting the offset by 4 looks weird. R_386_32 applies at r_offset.
> > >>> The call instruction  R_BPF_64_32 is strange. Such special calculat=
ion
> > >>> should not be named R_BPF_64_32.
> > >>
> > >> Again, we have a backward compatibility issue here. I would like to
> > >> provide an alias for it in llvm relocation header file, but I don't
> > >> know how to do it.
> > >
> > > It is very confusing that R_BPF_64_64 has a 32-bit value.
> >
> > If you like, we can make it as 64bit value.
> > R_BPF_64_64 is for ld_imm64 insn which is a 16byte insn.
> > The bytes 4-7 and 12-15 forms a 64bit value for the instruction.
> > We can do
> >       write32/read32 for bytes 4-7
> >       write32/read32 for bytes 12-15
> > for the relocation. Currently, we limit to bytes 4-7 since
> > in BPF it is really unlikely we have section offset > 4G.
> > But we could extend to full 64bit section offset.
>
> Such semantics have precedents, e.g. R_AARCH64_ADD_ABS_LO12_NC.
>
> For BPF, the name can be ABS_LO32: absolute, the low 32-bit value,
> with relocation overflow checking.
> There will be an out-of-range relocation if the value is outside
> [-2**31, 2**32).
>
> If the value is byte aligned, it will be more natural if you shift r_offs=
et
> so that the linker just relocates some bytes starting at r_offset, instea=
d of
> r_offset+4 or r_offset+12.
>
> ABS_LO32_NC (no-checking) + ABS_HI32 (absolute, the high 32-bit value) ca=
n be
> introduced in the fugure.
>
> > > Since its computation is the same as R_BPF_64_ABS32, can R_BPF_64_64
> > > be deprecated in favor of R_BPF_64_ABS32?
> >
> > Its computation is the same but R_BPF_64_ABS32 starts from offset
> > and R_BPF_64_64 starts from offset + 4.
> >
> > For R_BPF_64_64, the relocation offset is the *start* of the instructio=
n
> > hence +4 is needed to actually read/write addend.
> >
> > To deprecate R_BPF_64_64 to be the same as R_BPF_64_ABS32, we will
> > need to change relocation offset. This will break existing libbpf
> > and cilium and likely many other tools, so I would prefer not
> > to do this.
>
> You can add a new relocation type. Backward compatibility is good.
> There can only be forward compatibility issues.

New relocation emitted by compiler for cases where R_BPF_64_64 is
emitted today will break all the existing BPF applications using
anything but bleeding-edge libbpf. It was kind of ok (but even that
already breaks selftests/bpf on bpf tree, for instance) to emit new
kinds of relocations (R_BPF_64_ABS32 and R_BPF_64_ABS64) for some
cases where normally R_BPF_64_64/R_BPF_64_32 would be used, but only
because r_offset and the rest of semantics didn't change and because
most existing uses (including libbpf) weren't strict about checking
relocation type.

But emitting new relocation that changes the meaning of r_offset is
absolutely not acceptable.

>
> I see some relocation types which are deemed fundamental on other archite=
ctures
> are just being introduced. How could they work without these new relocati=
on
> types anyway?
>
> > >
> > > There is nothing preventing a relocation type from being used as data
> > > in some cases while code in other cases.
> > > R_BPF_64_64 can be renamed to indicate that it is deprecated.
> > > R_BPF_64_32 can be confused with R_BPF_64_ABS32. You may rename
> > > R_BPF_64_32 to say, R_BPF_64_CALL32.
> > >
> > > For compatibility, only the values matter, not the names.
> > > E.g. on x86, some unused GNU_PROPERTY values were renamed to
> > > GNU_PROPERTY_X86_COMPAT_ISA_1_USED ("COMPAT" for compatibility) while
> > > their values were kept.
> > > Two aarch64 relocation types have been renamed.
> >
> > Renaming sounds a more attractive choice. But a lot of other tools
> > have already used the name and it will be odd and not user friendly
> > to display a different name from llvm.
> >
> > For example elfutils, we have
> >    backends/bpf_symbol.c:    case R_BPF_64_64:
> >    libelf/elf.h:#define R_BPF_64_64
> >
> > My /usr/include/elf.h (from glibc-headers-2.28-149.el8.x86_64) has:
> >    /* BPF specific declarations.  */
> >
> >    #define R_BPF_NONE              0       /* No reloc */
> >    #define R_BPF_64_64             1
> >    #define R_BPF_64_32             10
> >
> > I agree the name is a little misleading, but renaming may cause
> > some confusion in bpf ecosystem. So we prefer to stay as is, but
> > with documentation to explain what each relocation intends to do.
>
> There are only 3 relocation types. R_BPF_NONE is good.
> There is still time figuring out proper naming and fixing them today.
> Otherwise I foresee that the naming problem will cause continuous confusi=
on to
> other toolchain folks.
>
> Assuming R_BPF_64_ABS_LO32 convey the correct semantics, you can do
>
>     #define R_BPF_64_ABS_LO32       1
>     #define R_BPF_64_64             1 /* deprecated alias */
>
> Similarly, for BPF_64_32:
>
>     #define R_BPF_64_CALL32         10
>     #define R_BPF_64_32             10 /* deprecated alias */
>

I think renaming is fine given we leave old constants as aliases to
new ones. llvm-readelf output would change, but I doubt anyone is
doing anything programmatic with such human-oriented output, so I
think that's ok.

> > >>>
> > >>>> +For example, ``R_BPF_64_64`` relocation type is used for ``ld_imm=
64``
> > >>>> instruction.
> > >>>> +The actual to-be-relocated data (0 or section offset)
> > >>>> +is stored at ``r_offset + 4`` and the read/write
> > >>>> +data bitsize is 32 (4 bytes). The relocation can be resolved with
> > >>>> +the symbol value plus implicit addend. Note that the ``BitSize`` =
is
> > >>>> 32 which
> > >>>> +means the section offset must be less than or equal to ``UINT32_M=
AX``
> > >>>> and this
> > >>>> +is enforced by LLVM BPF backend.
> > >>>> +

[...]

> > But we don't want relocations in .BTF/.BTF.ext to be resolved with
> > actually addresses. They will be processed by bpf libraries and the
> > kernel. The reason not to have relocation resolution
> > is not due to their names, but due
> > to their functionality. If we intend to load dwarf to kernel, we
> > will issue R_BPF_64_NODYLD32 to dwarf as well.
>
> Is the problem due to REL relocations not being idempotent?
>
> > One can argue we should have fine control in RuntimeDyld so
> > that which section to have runtime relocation resolution
> > and which section does not. I don't know whether
> > ExecutionEngine/RuntimeDyld agree with that or not. But
> > BPF backend perspective, R_BPF_64_ABS32 and R_BPF_64_NODYLD32
> > are two different relocations, they may do something common
> > in some places like lld, but they may do different things
> > in other places like dyld.
>
> If RELA is used, will the tool be happy if you just unconditionally
> apply relocations?
>
> You are introducing new relocation types anyway, so migrating to RELA may
> simplify a bunch of things. The issue is only about forward compatibility
> for some tools.

It's not about breaking some tools, it's about breaking *every*
libbpf-based application. Emitting new relocation where either
semantics change (different meaning for r_offset) or its type changes
(REL vs RELA) is breaking everything with 100% reliability.

[...]
