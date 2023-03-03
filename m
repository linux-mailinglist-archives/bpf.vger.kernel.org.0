Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4EEC6AA20D
	for <lists+bpf@lfdr.de>; Fri,  3 Mar 2023 22:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjCCVo7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Mar 2023 16:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbjCCVoS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Mar 2023 16:44:18 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD2D64211
        for <bpf@vger.kernel.org>; Fri,  3 Mar 2023 13:43:30 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id m6so5357442lfq.5
        for <bpf@vger.kernel.org>; Fri, 03 Mar 2023 13:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677879761;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vYQgWOfYyG1Uv3g0NPIjxURYknFwzXv5N817+zPdmY4=;
        b=avgYsU3Hf9G2HVhHC1HFteCFhNh1BeL59SzCDAtbALI5Iv8qYo15lqEFifjkxkZ/m8
         bX9lPK8HJG7Mv9BMzu6ukrfZrsHQDRznDHkmedMDxRsDOgtBCbyf84A+l4ccULc4v9W5
         HfkG9EVSxynOdiQclOxj6a/2B8fTVKQgvtj2bm2W9qzUEc/FW0VWEwsThWjZaOqzqur5
         xU3X5nDxYMVMhx73vWguQcPH/T56rB+y95NJ8FAY04BksUnwOxaCY83TvTgzoWNIbawg
         oLT8WMso5PrVYsrt4CnKNzXHvsreWXVxUJMZguIssXCmv5lO68QflQAQwPjnyDVFetkn
         fLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677879761;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vYQgWOfYyG1Uv3g0NPIjxURYknFwzXv5N817+zPdmY4=;
        b=ckc+KVm+y/KXzjqLNrGsE604RN+5zPz6ZyxQKHHh5dvYGoGJon/xSBL1LdTrOzGL1D
         r3CVy6zQbsRGsRb90lfwhNJRa9V1F5zIDzlWg5gEnt5XDqBx+Nsb3P8/dJ/fb1xCshVk
         RCJVxp5wVeaG8vqucX+63v+vGes1RVul+nB1fyEJoG7tM//TPkVYX/CyNMTQfp/Oh3Eq
         Z6Ot6h2LZyCbDtCZ9To8EYwI2uaSmWqUgOC+qfxxt9gvp4a3PP3AO8W0npJM+77cgLPq
         5DSanFj07YpMJ/WIr9qEd+S4nIJqB8f5UkieYsvaQc2ia/p9K66dMK5wXgsR95r2PU5M
         tiZg==
X-Gm-Message-State: AO0yUKWY0cGsKhtwR0Po1NZJZGXGco7mWC3bqBI8I71DgFU71oawOawl
        6bBerPNyjL+tL6FY3PDQD1w=
X-Google-Smtp-Source: AK7set81aJme9Rpe7B84O2utg0kns+sftuA6iKcUoeoT36G3c0uAW+5Czx22s2lG/MoVvTQ/u2uuHw==
X-Received: by 2002:ac2:539c:0:b0:4dd:dd28:31c7 with SMTP id g28-20020ac2539c000000b004dddd2831c7mr1028492lfh.38.1677879761126;
        Fri, 03 Mar 2023 13:42:41 -0800 (PST)
Received: from [192.168.1.94] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id d3-20020ac24c83000000b004dded2d1965sm541687lfl.267.2023.03.03.13.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 13:42:40 -0800 (PST)
Message-ID: <d9e1b0397daed0bad7b82e4696e1dcd530a678a3.camel@gmail.com>
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Disassembler tests for
 verifier.c:convert_ctx_access()
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        "Jose E. Marchesi" <jose.marchesi@oracle.com>
Date:   Fri, 03 Mar 2023 23:42:38 +0200
In-Reply-To: <CAADnVQ+abjckxC=KY9M_21scmHbqzA_5NvxYu1FTHrTPDz5=TA@mail.gmail.com>
References: <20230302225507.3413720-1-eddyz87@gmail.com>
         <20230302225507.3413720-4-eddyz87@gmail.com>
         <20230303202825.7y2icy3hto6xoveb@MacBook-Pro-6.local>
         <17d521cdc6b0b635b57dff540f3a5a48f5901e61.camel@gmail.com>
         <CAADnVQ+abjckxC=KY9M_21scmHbqzA_5NvxYu1FTHrTPDz5=TA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2023-03-03 at 13:35 -0800, Alexei Starovoitov wrote:
> On Fri, Mar 3, 2023 at 1:24=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
> >=20
> > On Fri, 2023-03-03 at 12:28 -0800, Alexei Starovoitov wrote:
> > > On Fri, Mar 03, 2023 at 12:55:07AM +0200, Eduard Zingerman wrote:
> > > > Function verifier.c:convert_ctx_access() applies some rewrites to B=
PF
> > > > instructions that read or write BPF program context. This commit ad=
ds
> > > > machinery to allow test cases that inspect BPF program after these
> > > > rewrites are applied.
> > > >=20
> > > > An example of a test case:
> > > >=20
> > > >   {
> > > >         // Shorthand for field offset and size specification
> > > >     N(CGROUP_SOCKOPT, struct bpf_sockopt, retval),
> > > >=20
> > > >         // Pattern generated for field read
> > > >     .read  =3D "$dst =3D *(u64 *)($ctx + bpf_sockopt_kern::current_=
task);"
> > > >              "$dst =3D *(u64 *)($dst + task_struct::bpf_ctx);"
> > > >              "$dst =3D *(u32 *)($dst + bpf_cg_run_ctx::retval);",
> > > >=20
> > > >         // Pattern generated for field write
> > > >     .write =3D "*(u64 *)($ctx + bpf_sockopt_kern::tmp_reg) =3D r9;"
> > > >              "r9 =3D *(u64 *)($ctx + bpf_sockopt_kern::current_task=
);"
> > > >              "r9 =3D *(u64 *)(r9 + task_struct::bpf_ctx);"
> > > >              "*(u32 *)(r9 + bpf_cg_run_ctx::retval) =3D $src;"
> > > >              "r9 =3D *(u64 *)($ctx + bpf_sockopt_kern::tmp_reg);" ,
> > > >   },
> > > >=20
> > > > For each test case, up to three programs are created:
> > > > - One that uses BPF_LDX_MEM to read the context field.
> > > > - One that uses BPF_STX_MEM to write to the context field.
> > > > - One that uses BPF_ST_MEM to write to the context field.
> > > >=20
> > > > The disassembly of each program is compared with the pattern specif=
ied
> > > > in the test case.
> > > >=20
> > > > Kernel code for disassembly is reused (as is in the bpftool).
> > > > To keep Makefile changes to the minimum, symbolic links to
> > > > `kernel/bpf/disasm.c` and `kernel/bpf/disasm.h ` are added.
> > > ...
> > > > +static regex_t *compile_regex(char *pat)
> > > > +{
> > > > +   regex_t *re;
> > > > +   int err;
> > > > +
> > > > +   re =3D malloc(sizeof(regex_t));
> > > > +   if (!re) {
> > > > +           PRINT_FAIL("Can't alloc regex\n");
> > > > +           return NULL;
> > > > +   }
> > > > +
> > > > +   err =3D regcomp(re, pat, REG_EXTENDED);
> > >=20
> > > Fancy.
> >=20
> > In a good or in a bad way?
> > It is the shortest form I came up with...
> >=20
> > > What is the cost of running this in test_progs?
> > > How many seconds does it add to run time?
> >=20
> > About 0.13sec (including modprobe and process initialization):
> >=20
> >   # time ./test_progs -a "ctx_rewrite/*"
> >   #58/1    ctx_rewrite/SCHED_CLS.tstamp:OK
> >   ...
> >   #58/20   ctx_rewrite/CGROUP_SOCKOPT.optval_end:OK
> >   #58      ctx_rewrite:OK
> >   Summary: 1/20 PASSED, 0 SKIPPED, 0 FAILED
> >=20
> >   real  0m0.131s
> >   user  0m0.027s
> >   sys   0m0.046s
> >=20
> > It loads 52 programs.
>=20
> That's fine then. I was worried that compiling regex in a loop
> might be slow.

Oh... Regexes are compiled only once at test entry (in test_ctx_rewrite()),
sub-tests do not re-compile.

