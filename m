Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B246686F3
	for <lists+bpf@lfdr.de>; Thu, 12 Jan 2023 23:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240429AbjALW3t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Jan 2023 17:29:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240502AbjALW3J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Jan 2023 17:29:09 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A6F38AEE
        for <bpf@vger.kernel.org>; Thu, 12 Jan 2023 14:27:23 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id c85so11581071pfc.8
        for <bpf@vger.kernel.org>; Thu, 12 Jan 2023 14:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SoyTSSdu+Qcthx/gmW86aii0JkzJszbHW58pSnxY3i4=;
        b=OiP440+IvYPWlSWv71v8WSyQn6M0UDc0mC7ow4jdFp2waA//CoDvJBJzaS61vkasoy
         L/lnTBD/K9Tt/AeOdzokC82fnG6oJaXXmqDi6nHYWjUad+4RWbydvWW2VMNFW1q8WEBv
         xdI6KdE+HXOa1qjbHgp2VnnVslei00IkG0wEqvwv3L+/HuVjU01mPiBHDFjlMIIfCfKO
         cDiVPO1FvGkHBy/zlRFmms6tcsbAyxnCa1eKHEdO7uCPWftO9ZEbfg96rHrJ7LvlO4rp
         Abh4UXuKJrhn6wNjOH3B8eW9Z/LQxGvoPPeEiD+fdvs7d/r5q8ou21+Y0gAVV19O9wLa
         5T9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SoyTSSdu+Qcthx/gmW86aii0JkzJszbHW58pSnxY3i4=;
        b=LGEhKZ7ylRPyCDv4v3FDLMiiPXIkpi2qwJpOawFLmvgvH3YT5JXCYiKnDLzHXuKpRN
         vWkfQ2Zd4nE8sg5rbKWONGtq+b/72q2tdCSbvgKe4Qhi3KK/Kb1yk4VmbyLGELuaX7rx
         Vt03kDMdtj3sjGShxRKg7J65LnB2OK/eBSwV9V9i+HCRceYTzOQXl7JhPDmqrvk/zwMG
         RAAzBO6ZSuMbSM5nmHuisxF7776SyROFVUwA8zEIxGRKDHB7LpwYqd0Bpy4mGLO+XjQq
         NKz9l9LcjCnzo/LtTsGj5/21Nz2vb3+lliP8NqN/w+0sKYrAiXtZ0Z1dFY2AX9KRQwEq
         6vvQ==
X-Gm-Message-State: AFqh2kpNJlbAoEnm/cq5YWuMhksIN6dCR09KArKE1/MzUkpJQt0+RLc9
        RJgK7427lyj+MZVcQZXNv1w=
X-Google-Smtp-Source: AMrXdXvmBzF6ZsbnrX41SNRN+nj7ML3YRAPAq/PqL5TStW4bMryWDj9WjAXmb4UFLKsY11FtLOr8mw==
X-Received: by 2002:aa7:86cb:0:b0:588:d6c1:66f9 with SMTP id h11-20020aa786cb000000b00588d6c166f9mr15378253pfo.31.1673562443169;
        Thu, 12 Jan 2023 14:27:23 -0800 (PST)
Received: from MacBook-Pro-6.local.dhcp.thefacebook.com ([2620:10d:c090:400::5:df0a])
        by smtp.gmail.com with ESMTPSA id d206-20020a621dd7000000b00589ed7ae132sm6931257pfd.13.2023.01.12.14.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 14:27:22 -0800 (PST)
Date:   Thu, 12 Jan 2023 14:27:19 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com,
        david.faust@oracle.com, James Hilliard <james.hilliard1@gmail.com>
Subject: Re: [RFC bpf-next 0/5] Support for BPF_ST instruction in LLVM C
 compiler
Message-ID: <20230112222719.gdxwdocfutpbxust@MacBook-Pro-6.local.dhcp.thefacebook.com>
References: <20221231163122.1360813-1-eddyz87@gmail.com>
 <CAEf4BzbNM_U4b3gi4AwiTV5GMXEsAsJx8sMVA32ijJRygrVpFg@mail.gmail.com>
 <874jt5mh2j.fsf@oracle.com>
 <1155fda8d54188f04270bb72c625d91f772e9999.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1155fda8d54188f04270bb72c625d91f772e9999.camel@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 05, 2023 at 02:07:05PM +0200, Eduard Zingerman wrote:
> On Thu, 2023-01-05 at 11:06 +0100, Jose E. Marchesi wrote:
> > > On Sat, Dec 31, 2022 at 8:31 AM Eduard Zingerman <eddyz87@gmail.com> wrote:
> > > > 
> > > > BPF has two documented (non-atomic) memory store instructions:
> > > > 
> > > > BPF_STX: *(size *) (dst_reg + off) = src_reg
> > > > BPF_ST : *(size *) (dst_reg + off) = imm32
> > > > 
> > > > Currently LLVM BPF back-end does not emit BPF_ST instruction and does
> > > > not allow one to be specified as inline assembly.
> > > > 
> > > > Recently I've been exploring ways to port some of the verifier test
> > > > cases from tools/testing/selftests/bpf/verifier/*.c to use inline assembly
> > > > and machinery provided in tools/testing/selftests/bpf/test_loader.c
> > > > (which should hopefully simplify tests maintenance).
> > > > The BPF_ST instruction is popular in these tests: used in 52 of 94 files.
> > > > 
> > > > While it is possible to adjust LLVM to only support BPF_ST for inline
> > > > assembly blocks it seems a bit wasteful. This patch-set contains a set
> > > > of changes to verifier necessary in case when LLVM is allowed to
> > > > freely emit BPF_ST instructions (source code is available here [1]).
> > > 
> > > Would we gate LLVM's emitting of BPF_ST for C code behind some new
> > > cpu=v4? What is the benefit for compiler to start automatically emit
> > > such instructions? Such thinking about logistics, if there isn't much
> > > benefit, as BPF application owner I wouldn't bother enabling this
> > > behavior risking regressions on old kernels that don't have these
> > > changes.
> > 
> > Hmm, GCC happily generates BPF_ST instructions:
> > 
> >   $ echo 'int v; void foo () {  v = 666; }' | bpf-unknown-none-gcc -O2 -xc -S -o foo.s -
> >   $ cat foo.s
> >         .file	"<stdin>"
> >         .text
> >         .align	3
> >         .global	foo
> >         .type	foo, @function
> >   foo:
> >         lddw	%r0,v
> >         stw	[%r0+0],666
> >         exit
> >         .size	foo, .-foo
> >         .global	v
> >         .type	v, @object
> >         .lcomm	v,4,4
> >         .ident	"GCC: (GNU) 12.0.0 20211206 (experimental)"
> > 
> > Been doing that since October 2019, I think before the cpu versioning
> > mechanism was got in place?
> > 
> > We weren't aware this was problematic.  Does the verifier reject such
> > instructions?
> 
> Interesting, do BPF selftests generated by GCC pass the same way they
> do if generated by clang?
> 
> I had to do the following changes to the verifier to make the
> selftests pass when BPF_ST instruction is allowed for selection:
> 
> - patch #1 in this patchset: track values of constants written to
>   stack using BPF_ST. Currently these are tracked imprecisely, unlike
>   the writes using BPF_STX, e.g.:
>   
>     fp[-8] = 42;   currently verifier assumes that fp[-8]=mmmmmmmm
>                    after such instruction, where m stands for "misc",
>                    just a note that something is written at fp[-8].
>                    
>     r1 = 42;       verifier tracks r1=42 after this instruction.
>     fp[-8] = r1;   verifier tracks fp[-8]=42 after this instruction.
> 
>   So the patch makes both cases equivalent.
>   
> - patch #3 in this patchset: adjusts verifier.c:convert_ctx_access()
>   to operate on BPF_ST alongside BPF_STX.
>   
>   Context parameters for some BPF programs types are "fake" data
>   structures. The verifier matches all BPF_STX and BPF_LDX
>   instructions that operate on pointers to such contexts and rewrites
>   these instructions. It might change an offset or add another layer
>   of indirection, etc. E.g. see filter.c:bpf_convert_ctx_access().
>   (This also implies that verifier forbids writes to non-constant
>    offsets inside such structures).
>    
>   So the patch extends this logic to also handle BPF_ST.

The patch 3 is necessary to land before llvm starts generating 'st' for ctx access.
That's clear, but I'm missing why patch 1 is necessary.
Sure, it's making the verifier understand scalar spills with 'st' and
makes 'st' equivalent to 'stx', but I'm missing why it's necessary.
What kind of programs fail to be verified when llvm starts generating 'st' ?

Regarind -mcpu=v4.
I think we need to add all of our upcoming instructions as a single flag.
Otherwise we'll have -mcpu=v5,v6,v7 and full combinations of them.

-mcpu=v4 could mean:
- ST
- sign extending loads
- sign extend a register
- 32-bit JA
- proper bswap insns: bswap16, bswap32, bswap64

The sign and 32-bit JA we've discussed earlier.
The bswap was on my wish list forever.
The existing TO_LE, TO_BE insns are really odd from compiler pov.
The compiler should translate bswap IR op into proper bswap insn
just like it does on all cpus.

Maybe add SDIV to -mcpu=v4 as well?
