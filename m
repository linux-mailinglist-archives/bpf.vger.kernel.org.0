Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8AE937A8F9
	for <lists+bpf@lfdr.de>; Tue, 11 May 2021 16:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhEKOVx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 May 2021 10:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbhEKOVw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 May 2021 10:21:52 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4871C061574
        for <bpf@vger.kernel.org>; Tue, 11 May 2021 07:20:45 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id v6so25329193ljj.5
        for <bpf@vger.kernel.org>; Tue, 11 May 2021 07:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KlV/7BsWaMdFmjVNM47bjPE88kmbK/F0nN7RZRISW9o=;
        b=QVIviV+W/LUrsNHihwhTCAD6/mot2p9ptz7SuDaLwGpZ2GW+uqBEXUivFF16L131G3
         8la4KbaDfHCNekx2PdctUcKISsZHrL5GgorJzSCvJXOhit0rQ+2npuA3dPT2bOUyL2Ys
         tIlpeJ0zsi3i6p3kqs2q31LFaSfy8NTbsN060=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KlV/7BsWaMdFmjVNM47bjPE88kmbK/F0nN7RZRISW9o=;
        b=GurUElPKnWx1/WaMv25dSbx9HL1uXQjhCnM+xY64OGUwetfLgRZcb+LxHZGTf9Caq2
         fr7poSyP4UK0ILlqvT/8pRPH6BsjbpZJdBKagedm5yHG79kLFWbDbIeXoCQkQuEe4N+H
         Cx/iSpNCfJojzcmOtQaISS2s/1NyyOMH/SfHS8eMHzz6c9ewIiwqBWiqEc6iB6idvDMo
         gKMxEyAJ/M5swLPuXvNJ9pRS3enPIz0hkP86yqbF4SwoPNegaQPAcOfmNG6M4YWZPma2
         y5EEnftcrl/hLv4Bt4Ttd5kTeRsOI/cBHdWrXsu3ODZUmEPswraz8/+YEU3MlQUj7f/t
         3IhA==
X-Gm-Message-State: AOAM531aGEKjQ3nyesqdLXq69u0T2przd4j8/IOhxC7AACdNRHdV1rso
        isDmZLXdvbymluBKPK7RUSW8aP9+7bUX7ehuDd/BIg==
X-Google-Smtp-Source: ABdhPJxpGwHe5ZHj38wx8SpfmWh114YHDe3MfEiCrBM7SfZzw7IOUEmHCxZO87v1vB8m31K3LkPqr1amNSZCotH7gKk=
X-Received: by 2002:a2e:91cb:: with SMTP id u11mr20100492ljg.83.1620742843705;
 Tue, 11 May 2021 07:20:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAADnVQKo+efxMvgrqYqVvUEgiz_GXgBVOt4ddPTw_mLuvr2HUw@mail.gmail.com>
 <CAEf4BzZifOFHr4gozUuSFTh7rTWu2cE_-L4H1shLV5OKyQ92uw@mail.gmail.com>
 <CAADnVQ+h78QijAjbkNqAWn+TAFxrd6vE=mXqWRcy815hkTFvOw@mail.gmail.com>
 <CAEf4BzZOmCgmbYDUGA-s5AF6XJFkT1xKinY3Jax3Zm2OLNmguA@mail.gmail.com>
 <20210426223449.5njjmcjpu63chqbb@ast-mbp.dhcp.thefacebook.com>
 <CAEf4BzYZX9YJcoragK20cvQvr_tPTWYBQSRh7diKc1KoCtu4Dg@mail.gmail.com>
 <20210427022231.pbgtrdbxpgdx2zrw@ast-mbp.dhcp.thefacebook.com>
 <CAEf4BzZOwTp4vQxvCSXaS4-94fz_eZ7Q4n6uQfkAnMQnLRaTbQ@mail.gmail.com>
 <20210428045545.egqvhyulr4ybbad6@ast-mbp.dhcp.thefacebook.com>
 <CAEf4BzZo7_r-hsNvJt3w3kyrmmBJj7ghGY8+k4nvKF0KLjma=w@mail.gmail.com>
 <20210504044204.kpt6t5kaomj7oivq@ast-mbp> <CAADnVQ+WV8xZqJfWx8em5Ch8aKA8xcPqR0wT0BdFf9M==W5_FQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+WV8xZqJfWx8em5Ch8aKA8xcPqR0wT0BdFf9M==W5_FQ@mail.gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Tue, 11 May 2021 15:20:32 +0100
Message-ID: <CACAyw99uiX2rkAcqXXHivc0NZ-t2fwZSZfORpe2h_y3AvDDueQ@mail.gmail.com>
Subject: Re: bpf libraries and static variables. Was: [PATCH v2 bpf-next 2/6]
 libbpf: rename static variables during linking
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 5 May 2021 at 06:22, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> > All of the above is up for discussion. I'd love to hear what golang folks
> > are thinking, since above proposal is C centric.

Sorry for the late reply, I was on holiday.

Regarding your conntrack library example:
- what is the difference between impl.bpf.c and ct_api.bpf.c? If I
understand correctly, ct_api is used to generate the skel.h, but impl
isn't?
- what file would main.bpf.c include? ct_api or skel.h?

Regarding Andrii's proposal in the forwarded email to use __hidden,
__internal etc. Are these correct:
- static int foo: this is only available in the same .o, not
accessible from user space. Can be referenced via extern int foo?
- __hidden int foo: only available in same .o, not accessible from user space
- __internal int foo: only available in same .a via extern, not
accessible from user space
- int foo: available / conflicts in all .o, accessible from user space
(aka included in skel.h)

When you speak of the linker, do you mean libbpf or the clang / llvm
linker? The Go toolchain has a simplistic linker to support bpf2bpf
calls from the same .o so I imagine libbpf has something similar.

> I want to clarify a few things that were brought up in offline discussions.
> There are several options:
> 1. don't emit statics at all.
> That will break some skeleton users and doesn't solve the name conflict issue.
> The library authors would need to be careful and use a unique enough
> prefix for all global vars (including attribute("hidden") ones).
> That's no different with traditional static linking in C.
> bpf static linker already rejects linking if file1.bpf.c is trying to
> 'extern int foo()'
> when it was '__hidden int foo();' in file2.bpf.c
> That's safer than traditional linker and the same approach can be
> applied to vars.
> So externing of __hidden vars won't be possible, but they will name conflict.
>
> 2. emit statics when they don't conflict and fail skel gen where there
> is a naming conflict.
> That helps a bit, but library authors still have to be careful with
> both static and global names.
> Which is more annoying than traditional C.

The only way I see this affecting the Go toolchain is if main.bpf.c
includes skel.h, not some other .c (or .h?) Otherwise I would work
hard to keep libraries / programs in their own namespace. The Go
toolchain might end up doing the final link of main.bpf.o and
libct.bpf.a (assuming the .a is linked by llvm or libbpf).

In general I'm with Daniel here that I prefer traditional C static
semantics aka option #1.

>
> 3. do #2 style of failing skel gen if there is a naming conflict, but
> also introduce namespacing concept, so that both global and static
> vars can be automatically namespaced.
> That's the proposal above.
> This way, I'm guessing, some libraries will use namespaces to avoid
> prefixing everything.
> The folks that hate namespaces and #pragmas will do manual prefixes for
> both static and global vars.
>
> For approaches
> char library[]="lru";'
> and
> #pragma comment(lib, "lru")
> the scope of namespace is the whole .bpf.c file.
> The clang/llvm already support it, so the job of name mangling would
> belong to linker.

I think this would work well for Go, because it makes the namespace
explicit. I can imagine that #pragma comment(lib,
"github.com/some/go/package") might be useful. How is the pragma
encoded into the ELF? Would this solve name conflict from multiple
files with the same names?

>
> For __attribute__((annotate("lib=lru"))) the scope could be any number
> of lines in C files between pragma push/pop and can be nested.
> This attribute is supported by clang, but not in the bpf backend.
> The llvm would prefix both global and static names
> in elf file and in btf.

Would there be a way to recover the "lru" part from the mangled ELF somehow?

> If another file.bpf.c needs to call a function from namespace "lru"
> it would need to prefix such a call.
> The skel gen job would be #2 above (emit both static and globals if
> they don't conflict).
> Such namespacing concept would be the closest to c++ namespaces.
>
> If I understood what folks were saying no one is excited about namespaces in C.
> So probably #3 is out and sounds like 1 is prefered?

I think at least allowing for namespaces would be great. Most
languages besides C that will wish to integrate with eBPF allow
namespacing.

--
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
