Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67FA66AA14C
	for <lists+bpf@lfdr.de>; Fri,  3 Mar 2023 22:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjCCVft (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Mar 2023 16:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbjCCVfo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Mar 2023 16:35:44 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2273D921
        for <bpf@vger.kernel.org>; Fri,  3 Mar 2023 13:35:42 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id ay14so11976842edb.11
        for <bpf@vger.kernel.org>; Fri, 03 Mar 2023 13:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hSw8OnokF7YVnBy+GL+Awgtls424pL6FVO4uylm68Q=;
        b=E5y6PUsPPYP/5tAYXmk04/Xc2XO6ObNuD+rlrr/vvaT2vcCHRlVxw8aDXDE6JF3kFk
         aBGkAdRby/wgVgDCIOyBNdcroeHNiw+jY0wvD8oWKAVCAVZfti50KQfLNRymgDlJ56Sa
         wp/24tvb5ivUejnZ45QjASi6mQmtpc0bWADl6ncK/y7JclNGz1BDdVcliZDL5ZzE5PkK
         LAUy5awP6OOpojs6m2riCFRcVAzeT9WVAWWT4xkkLsEjS2M9f0sL1qDb6MiqTy831bwV
         zg5Yqac+l3j2ERjMJvx/I/G+EULovq+KaDh+Et1kXbQWDSgoIdQWx+jXhMNnsZHidAgb
         SlEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7hSw8OnokF7YVnBy+GL+Awgtls424pL6FVO4uylm68Q=;
        b=7idK9/RC3x8Qn3WuYJ96CWdoGW2Ec9nYnzWmoVxavFQkymZ0OYrQ3/bsz3a3+/orOL
         75hGiSl4ODMSBXz2oJv0mwJDayAogenMMEMBondbM53AVmWQFcfFbf+jnLmvFHITYlgM
         o/n6nYDr7nI+LGO2Aq5grz1S2bmihxExzrTDuij/Etx63UWURKqhW4dstvgPoJt3xnJN
         WdWv8agOjtBVEMUpBH2EeAbuSh43hxpFfmxNTDRBS872pPVJ6v2lKHshHa97zH9Rdzs/
         zoea8pyNAxl+4NY9R+t3KieSYNrQZ2jcl9KGk8dcznW8GCeO4KgQzC5HxRZA4hyBRTV0
         S84w==
X-Gm-Message-State: AO0yUKWoqJoYpn+l4T7rnk41lWUiZWdK96qGGPpTXenm346D0scuY9Cw
        7mc0JHZQcI17U37ov1queYjCldWWAFdxiOQp/Uz6N/yY
X-Google-Smtp-Source: AK7set9zBn9lXGlkThhGCH3kok/2T5BIk5WhyyFeTGGEs7b0jT0iqrUijBhTR1ygcP07AReywjZuy2mPvrFQ92+Cjt8=
X-Received: by 2002:a50:c05b:0:b0:4c0:2126:ac34 with SMTP id
 u27-20020a50c05b000000b004c02126ac34mr1858832edd.6.1677879340899; Fri, 03 Mar
 2023 13:35:40 -0800 (PST)
MIME-Version: 1.0
References: <20230302225507.3413720-1-eddyz87@gmail.com> <20230302225507.3413720-4-eddyz87@gmail.com>
 <20230303202825.7y2icy3hto6xoveb@MacBook-Pro-6.local> <17d521cdc6b0b635b57dff540f3a5a48f5901e61.camel@gmail.com>
In-Reply-To: <17d521cdc6b0b635b57dff540f3a5a48f5901e61.camel@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 3 Mar 2023 13:35:29 -0800
Message-ID: <CAADnVQ+abjckxC=KY9M_21scmHbqzA_5NvxYu1FTHrTPDz5=TA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Disassembler tests for verifier.c:convert_ctx_access()
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        "Jose E. Marchesi" <jose.marchesi@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 3, 2023 at 1:24=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Fri, 2023-03-03 at 12:28 -0800, Alexei Starovoitov wrote:
> > On Fri, Mar 03, 2023 at 12:55:07AM +0200, Eduard Zingerman wrote:
> > > Function verifier.c:convert_ctx_access() applies some rewrites to BPF
> > > instructions that read or write BPF program context. This commit adds
> > > machinery to allow test cases that inspect BPF program after these
> > > rewrites are applied.
> > >
> > > An example of a test case:
> > >
> > >   {
> > >         // Shorthand for field offset and size specification
> > >     N(CGROUP_SOCKOPT, struct bpf_sockopt, retval),
> > >
> > >         // Pattern generated for field read
> > >     .read  =3D "$dst =3D *(u64 *)($ctx + bpf_sockopt_kern::current_ta=
sk);"
> > >              "$dst =3D *(u64 *)($dst + task_struct::bpf_ctx);"
> > >              "$dst =3D *(u32 *)($dst + bpf_cg_run_ctx::retval);",
> > >
> > >         // Pattern generated for field write
> > >     .write =3D "*(u64 *)($ctx + bpf_sockopt_kern::tmp_reg) =3D r9;"
> > >              "r9 =3D *(u64 *)($ctx + bpf_sockopt_kern::current_task);=
"
> > >              "r9 =3D *(u64 *)(r9 + task_struct::bpf_ctx);"
> > >              "*(u32 *)(r9 + bpf_cg_run_ctx::retval) =3D $src;"
> > >              "r9 =3D *(u64 *)($ctx + bpf_sockopt_kern::tmp_reg);" ,
> > >   },
> > >
> > > For each test case, up to three programs are created:
> > > - One that uses BPF_LDX_MEM to read the context field.
> > > - One that uses BPF_STX_MEM to write to the context field.
> > > - One that uses BPF_ST_MEM to write to the context field.
> > >
> > > The disassembly of each program is compared with the pattern specifie=
d
> > > in the test case.
> > >
> > > Kernel code for disassembly is reused (as is in the bpftool).
> > > To keep Makefile changes to the minimum, symbolic links to
> > > `kernel/bpf/disasm.c` and `kernel/bpf/disasm.h ` are added.
> > ...
> > > +static regex_t *compile_regex(char *pat)
> > > +{
> > > +   regex_t *re;
> > > +   int err;
> > > +
> > > +   re =3D malloc(sizeof(regex_t));
> > > +   if (!re) {
> > > +           PRINT_FAIL("Can't alloc regex\n");
> > > +           return NULL;
> > > +   }
> > > +
> > > +   err =3D regcomp(re, pat, REG_EXTENDED);
> >
> > Fancy.
>
> In a good or in a bad way?
> It is the shortest form I came up with...
>
> > What is the cost of running this in test_progs?
> > How many seconds does it add to run time?
>
> About 0.13sec (including modprobe and process initialization):
>
>   # time ./test_progs -a "ctx_rewrite/*"
>   #58/1    ctx_rewrite/SCHED_CLS.tstamp:OK
>   ...
>   #58/20   ctx_rewrite/CGROUP_SOCKOPT.optval_end:OK
>   #58      ctx_rewrite:OK
>   Summary: 1/20 PASSED, 0 SKIPPED, 0 FAILED
>
>   real  0m0.131s
>   user  0m0.027s
>   sys   0m0.046s
>
> It loads 52 programs.

That's fine then. I was worried that compiling regex in a loop
might be slow.
