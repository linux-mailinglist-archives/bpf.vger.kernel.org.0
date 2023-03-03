Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408066AA114
	for <lists+bpf@lfdr.de>; Fri,  3 Mar 2023 22:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjCCVY2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Mar 2023 16:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjCCVY1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Mar 2023 16:24:27 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BB416334
        for <bpf@vger.kernel.org>; Fri,  3 Mar 2023 13:24:26 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id g17so5308541lfv.4
        for <bpf@vger.kernel.org>; Fri, 03 Mar 2023 13:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677878664;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qX7E22khTd6jcUPaQMviWOYpKo+S19iJMucow8bTVnE=;
        b=fChU7SA/M3LahYnL4VqJZ7ydqZy8g7oCYMKxoaX8tGbsD+3Lac8c2AX4906dpsgUwB
         x3Jslaarc3sL5uUrEVg0b8LvsjtBOyRTJx3xZdjoFp2R2yR1Inq+Dq8SuY2FjKWY0Nam
         jYvVQVl9W+neBkychyFDasbBpWChjx9xLQuYxR2HbBDKM3xlu5wP8c6SX/O9X/8FipoK
         Iyc5UBtBr+u1ce32M1/PMC+E+Yq9uOt46BT/YF+kAHRGG7Xr8EFxkyruCzEkrhEomoP2
         YtH1qzEbROJPditfr6YPG2h9QHsa0lX8lB8XABfHghVSlKenTzzCTQK87QyBfVjOJqK3
         JRWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677878664;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qX7E22khTd6jcUPaQMviWOYpKo+S19iJMucow8bTVnE=;
        b=s7M3hEEu8F/HxI8gIgXyzt1IbTUYdpyNOQXl9wFvskVDH7gem7BV6u3xrGVsa/6W+i
         qjEQEAWG/av536oI10o7eQfS5mDE+Dd+dwatzbXQIpBGzYfSxQ7ItS9452BcWMADKxr4
         6DgxQnSbrTU63+xsNpl4Pk0/GNnGL701XYzuhgTyPWaSiTULVjxYxiISalUSnbR5wPi7
         IADyNhm9ChiwPGrkV+IqqSWGq6smiXzH0kpmGp7PbD7/lDfYYI5stW6Mfuz7cIC2t5RW
         aSDot6qdSYsf4gAHmdx0KSQIa7KWxsJcInmvS1hEIynqaRTfrpkkvokptP1APUXbckeR
         +vdg==
X-Gm-Message-State: AO0yUKUYdyQSXCVXPxdnpRzIis8CSQ9HGCxpQhXNzyNiYlKlBn1Vfpf9
        Nx77osEKrJMCqIX+6RSrt0k=
X-Google-Smtp-Source: AK7set/ypRx4KQnEWdQsiM1ea1b89/OEhtY1xcrzBl1BuyI4m0scj3gOaWp3G92gQOOuSBRJmwzUWQ==
X-Received: by 2002:ac2:514f:0:b0:4b5:61c5:8927 with SMTP id q15-20020ac2514f000000b004b561c58927mr892663lfd.42.1677878664146;
        Fri, 03 Mar 2023 13:24:24 -0800 (PST)
Received: from [192.168.1.94] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id l3-20020a2e9083000000b00295a7f35206sm483916ljg.48.2023.03.03.13.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 13:24:23 -0800 (PST)
Message-ID: <17d521cdc6b0b635b57dff540f3a5a48f5901e61.camel@gmail.com>
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Disassembler tests for
 verifier.c:convert_ctx_access()
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
        yhs@fb.com, jose.marchesi@oracle.com
Date:   Fri, 03 Mar 2023 23:24:22 +0200
In-Reply-To: <20230303202825.7y2icy3hto6xoveb@MacBook-Pro-6.local>
References: <20230302225507.3413720-1-eddyz87@gmail.com>
         <20230302225507.3413720-4-eddyz87@gmail.com>
         <20230303202825.7y2icy3hto6xoveb@MacBook-Pro-6.local>
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

On Fri, 2023-03-03 at 12:28 -0800, Alexei Starovoitov wrote:
> On Fri, Mar 03, 2023 at 12:55:07AM +0200, Eduard Zingerman wrote:
> > Function verifier.c:convert_ctx_access() applies some rewrites to BPF
> > instructions that read or write BPF program context. This commit adds
> > machinery to allow test cases that inspect BPF program after these
> > rewrites are applied.
> >=20
> > An example of a test case:
> >=20
> >   {
> >         // Shorthand for field offset and size specification
> > 	N(CGROUP_SOCKOPT, struct bpf_sockopt, retval),
> >=20
> >         // Pattern generated for field read
> > 	.read  =3D "$dst =3D *(u64 *)($ctx + bpf_sockopt_kern::current_task);"
> > 		 "$dst =3D *(u64 *)($dst + task_struct::bpf_ctx);"
> > 		 "$dst =3D *(u32 *)($dst + bpf_cg_run_ctx::retval);",
> >=20
> >         // Pattern generated for field write
> > 	.write =3D "*(u64 *)($ctx + bpf_sockopt_kern::tmp_reg) =3D r9;"
> > 		 "r9 =3D *(u64 *)($ctx + bpf_sockopt_kern::current_task);"
> > 		 "r9 =3D *(u64 *)(r9 + task_struct::bpf_ctx);"
> > 		 "*(u32 *)(r9 + bpf_cg_run_ctx::retval) =3D $src;"
> > 		 "r9 =3D *(u64 *)($ctx + bpf_sockopt_kern::tmp_reg);" ,
> >   },
> >=20
> > For each test case, up to three programs are created:
> > - One that uses BPF_LDX_MEM to read the context field.
> > - One that uses BPF_STX_MEM to write to the context field.
> > - One that uses BPF_ST_MEM to write to the context field.
> >=20
> > The disassembly of each program is compared with the pattern specified
> > in the test case.
> >=20
> > Kernel code for disassembly is reused (as is in the bpftool).
> > To keep Makefile changes to the minimum, symbolic links to
> > `kernel/bpf/disasm.c` and `kernel/bpf/disasm.h ` are added.
> ...
> > +static regex_t *compile_regex(char *pat)
> > +{
> > +	regex_t *re;
> > +	int err;
> > +
> > +	re =3D malloc(sizeof(regex_t));
> > +	if (!re) {
> > +		PRINT_FAIL("Can't alloc regex\n");
> > +		return NULL;
> > +	}
> > +
> > +	err =3D regcomp(re, pat, REG_EXTENDED);
>=20
> Fancy.

In a good or in a bad way?
It is the shortest form I came up with...

> What is the cost of running this in test_progs?
> How many seconds does it add to run time?

About 0.13sec (including modprobe and process initialization):

  # time ./test_progs -a "ctx_rewrite/*"
  #58/1    ctx_rewrite/SCHED_CLS.tstamp:OK
  ...
  #58/20   ctx_rewrite/CGROUP_SOCKOPT.optval_end:OK
  #58      ctx_rewrite:OK
  Summary: 1/20 PASSED, 0 SKIPPED, 0 FAILED
 =20
  real	0m0.131s
  user	0m0.027s
  sys	0m0.046s
 =20
It loads 52 programs.
