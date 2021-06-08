Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0194239FFC4
	for <lists+bpf@lfdr.de>; Tue,  8 Jun 2021 20:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbhFHSgM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Jun 2021 14:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234524AbhFHSeR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Jun 2021 14:34:17 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D87C0611C6
        for <bpf@vger.kernel.org>; Tue,  8 Jun 2021 11:32:11 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id l184so1689904pgd.8
        for <bpf@vger.kernel.org>; Tue, 08 Jun 2021 11:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/ghbDDpkhxQWfGQGcpXrxZAOmcEo+SBxxpkHciBBh6M=;
        b=N7fYizNpT03lvIxnSh1rB+i+FZ0KMYcQDeixOOgGLwYDQp56XK7Jv5Im2cpllWivdR
         IG/PLJ/4LS98ajgE4sOVl2Lk6FSjdRZ8rqBU4eQunf2nv2I3NII7jp02ycp/0TvSNw0j
         OQlfbwQfxyaBWBLDzj+TX+de90TlJQ5ONaoM6U1A86HjMDFI0zuKEYiOQ/FXheaiIT+N
         jWlPj2NTsp0CnP3Pkp8QhCixVB11DTLOmvlT66grPywa5+xOg3rnk49k1EcOXRBIAYWe
         wVA8x9WVH3rSHZTT1GuquXofA7uBD6APK0Np0xOzOfeux9r7Hn1M7RV6RO6X8MkVxt1P
         vb5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/ghbDDpkhxQWfGQGcpXrxZAOmcEo+SBxxpkHciBBh6M=;
        b=OfVLRC0BtLEHxg6f2VXW6o+iKvBh2pz133L97UAMfXDzL3wKCaB1FRtIQi4pXHEttD
         sb9aXqDuCZyg+NmGUDN7dptLPdVDn9mHm0RZ/XNayp5FBKRuOc9/894+7Z1syWVp87t9
         Bo+Caa6ty4tuBdDdDQyXYAG+hyWvkDLHve4SAumg8wy6A2S5/46O+sV8epux0VbTGIIq
         Dpryq00IBtHYq2ir6h4qns7DyLXr7bf5VnuSvbmmC0//tm66NbxMJfh5bycPf6Z1H9B3
         0Zuw2bD8vCyTfAhcWlkdmIynf0D7hoo/C4O19Gv4rac79axEbsJASJh2RBO8qZXcAwTg
         A3sw==
X-Gm-Message-State: AOAM533jJmc93DtUg/wSX4NuujJe/QbePudBNJVEaV8HN4Aokr9Ow2It
        Csm0rNjEoNUh1VhBH+JqpZwLX/zmm50=
X-Google-Smtp-Source: ABdhPJzHV/DoE36tp6qyIS4D4dsxbx+2RcUcLKd6Y+swa6a94DHlm0kiXiscP/vNbinc4rO9XxG2fg==
X-Received: by 2002:aa7:8244:0:b029:2ec:968d:c1b4 with SMTP id e4-20020aa782440000b02902ec968dc1b4mr1278947pfn.32.1623177130029;
        Tue, 08 Jun 2021 11:32:10 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:336e])
        by smtp.gmail.com with ESMTPSA id x22sm11476378pfn.10.2021.06.08.11.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 11:32:09 -0700 (PDT)
Date:   Tue, 8 Jun 2021 11:32:05 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: Re: [PATCH bpf-next v2] docs/bpf: add llvm_reloc.rst to explain llvm
 bpf relocations
Message-ID: <20210608183205.l22q43hinv6lzb4h@ast-mbp.dhcp.thefacebook.com>
References: <20210525033314.3008878-1-yhs@fb.com>
 <20210525182948.4wk3kd7vrvgdr2lu@google.com>
 <dd95b896-3b37-a398-68cd-549fb249f2e0@fb.com>
 <CAFP8O3JM3SrKXYA2SF-zRJZCiipHdcyF1usPOykm6Yqb6xs6dQ@mail.gmail.com>
 <4410f328-58ae-24e4-5e63-cfde6e891bf4@fb.com>
 <CAFP8O3J4_aaT+POmB6H6mihuP1-VQ4ww1nVrHxEvd70S5ODEUw@mail.gmail.com>
 <8abe01cb-da8f-514c-6b52-b92686a16662@fb.com>
 <CAFP8O3JeGtDMATPsnjhRO3Ru+Lap2uJSG_jYzWcK4AWeBtXquw@mail.gmail.com>
 <CAADnVQ+sD7ELvEwKf5Ui1dVkXPYEyjkwFxogxP5_4vrH3nMhPA@mail.gmail.com>
 <CAFP8O3KayCgP6OqF1Vx8afav==jkL038m0rK66b7jJ0DOO=uJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFP8O3KayCgP6OqF1Vx8afav==jkL038m0rK66b7jJ0DOO=uJQ@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 08, 2021 at 09:33:28AM -0700, Fāng-ruì Sòng wrote:
> On Tue, Jun 8, 2021 at 8:49 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Jun 7, 2021 at 10:51 PM Fāng-ruì Sòng <maskray@google.com> wrote:
> > >
> > > You can rename R_BPF_64_64 to something more meaningful, e.g. R_BPF_64_LDIMM64.
> > > Then I am fine that such a relocation type applies inconsecutive bytes.
> > >
> > > See below. Just change every occurrence of the old name in llvm-project.
> >
> > No. We cannot rename them, because certain gnu tools resolve relos by name
> > and not by number.
> 
> How do the GNU tools resolve relocations by name instead of by
> relocation type number?
> I don't think this should and can be supported.
> 
> Most tools should do:
> if (type == R_BPF_64_64) do_something();
> 
> You are free to change them to
> if (type == R_BPF_64_LDIMM64) do_something();
> as long as R_BPF_64_LDIMM64 is defined as the number.

If you're going to succeed convincing elfutils maintainers to change
their whole design then we can realistically talk about renaming.
As a homework try cloning elfutils.git then change the name in backends/x86_64_reloc.def
or bpf_reloc.def while keeping the numbers and observe how the standard tools stop working.

Also R_BPF_64_64 may not be the best name, but R_BPF_64_LDIMM64 is
not a good name either. Most architectures avoid using instruction mnemonic
in relo names. The relo name should describe what it does instead of insn
it applies to. TLS, GOT, PLT, ABS are good suffixes to use. LDIMM64 - not really.
Instead of R_BPF_64_32 we could have used R_BPF_64_PC32, but not R_BPF_64_CALL32.
Anyway it's too late to change.
