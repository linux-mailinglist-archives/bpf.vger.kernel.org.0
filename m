Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0123D6B18F1
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 02:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjCIBx5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Mar 2023 20:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjCIBx4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Mar 2023 20:53:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948256A9EB
        for <bpf@vger.kernel.org>; Wed,  8 Mar 2023 17:53:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3018961A00
        for <bpf@vger.kernel.org>; Thu,  9 Mar 2023 01:53:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66304C433D2;
        Thu,  9 Mar 2023 01:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678326834;
        bh=39gG0P6R7hMNDud2fPY7aCgEa3mHeB8FhJLhF9sV0d8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NLP42wbckXup3+2HYTgJzwIPM0Yhg2px+rLjh3mjZL145YUr5S3TUrskxRpARJOFt
         Vq9ot1O2KunTLMCCTSX6942u2o3NdRUTYTJpVp7U6i1VnCmBSKJh9J66MiEo46Sb03
         I2SMdKpY+6ExgQ1Z3ZNLGLMtnsZnC1TNKBnJpU0YLSoQo67SvdHTm0i3/AuMiBRyTO
         GYO2o3atG0xcuKskd3V1JaKkomFoC2HFoPW4AZJsKFNG3qGMTv9vO4gLQPAAYgS09I
         lz3T/DWgsfqw6HWqjAkYusPcZu7UydeAAmZ+7RKR/cuJW8hO7/xEfS5Fqj0d0j+pTE
         z6SA7CY6wVphw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EAE994049F; Wed,  8 Mar 2023 22:53:51 -0300 (-03)
Date:   Wed, 8 Mar 2023 22:53:51 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alan Maguire <alan.maguire@oracle.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next] bpf: add
 --skip_encoding_btf_inconsistent_proto, --btf_gen_optimized to pahole flags
 for v1.25
Message-ID: <ZAk8L17/EfR8siaz@kernel.org>
References: <1675949331-27935-1-git-send-email-alan.maguire@oracle.com>
 <CAADnVQ+hfQ9LEmEFXneB7hm17NvRniXSShrHLaM-1BrguLjLQw@mail.gmail.com>
 <CAADnVQJe6dRnhbSk92g5Np0tXyMxWLD+8LqUxYfYPr7dWkxzSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJe6dRnhbSk92g5Np0tXyMxWLD+8LqUxYfYPr7dWkxzSw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Feb 13, 2023 at 10:09:21PM -0800, Alexei Starovoitov escreveu:
> On Mon, Feb 13, 2023 at 7:12 PM Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > On Thu, Feb 9, 2023 at 5:29 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> > > +++ b/scripts/pahole-flags.sh
> > > @@ -23,5 +23,8 @@ if [ "${pahole_ver}" -ge "124" ]; then
> > >         # see PAHOLE_HAS_LANG_EXCLUDE
> > >         extra_paholeopt="${extra_paholeopt} --lang_exclude=rust"
> > >  fi
> > > +if [ "${pahole_ver}" -ge "125" ]; then
> > > +       extra_paholeopt="${extra_paholeopt} --skip_encoding_btf_inconsistent_proto --btf_gen_optimized"
> > > +fi
> >
> > We landed this too soon.
> > #229     tracing_struct:FAIL
> > is failing now.
> > since bpf_testmod.ko is missing a bunch of functions though they're global.
> >
> > I've tried a bunch of different flags and attributes, but none of them
> > helped.
> > The only thing that works is:
> > diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > index 46500636d8cd..5fd0f75d5d20 100644
> > --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > @@ -28,6 +28,7 @@ struct bpf_testmod_struct_arg_2 {
> >         long b;
> >  };
> >
> > +__attribute__((optimize("-O0")))
> >  noinline int
> >  bpf_testmod_test_struct_arg_1(struct bpf_testmod_struct_arg_2 a, int
> > b, int c) {
> >
> > We cannot do:
> > --- a/tools/testing/selftests/bpf/bpf_testmod/Makefile
> > +++ b/tools/testing/selftests/bpf/bpf_testmod/Makefile
> > @@ -10,7 +10,7 @@ endif
> >  MODULES = bpf_testmod.ko
> >
> >  obj-m += bpf_testmod.o
> > -CFLAGS_bpf_testmod.o = -I$(src)
> > +CFLAGS_bpf_testmod.o = -I$(src) -O0
> >
> > The build fails due to asm stuff.
> >
> > Maybe we should make scripts/pahole-flags.sh selective
> > and don't apply skip_encoding_btf_inconsiste to bpf_testmod ?
> >
> > Thoughts?
> 
> It's even worse with clang compiled kernel:

I tested what is now in the master branch with both gcc and clang, on
fedora:37, Alan also tested it, Jiri, it would be great if you could
check if reverting the revert works for you as well.

Thanks,

- Arnaldo

>     WARN: resolve_btfids: unresolved symbol tcp_reno_cong_avoid
>     WARN: resolve_btfids: unresolved symbol dctcp_update_alpha
>     WARN: resolve_btfids: unresolved symbol cubictcp_cong_avoid
>     WARN: resolve_btfids: unresolved symbol bpf_xdp_metadata_rx_timestamp
>     WARN: resolve_btfids: unresolved symbol bpf_xdp_metadata_rx_hash
>     WARN: resolve_btfids: unresolved symbol bpf_task_kptr_get
>     WARN: resolve_btfids: unresolved symbol bpf_task_acquire_not_zero
>     WARN: resolve_btfids: unresolved symbol bpf_rdonly_cast
>     WARN: resolve_btfids: unresolved symbol
> bpf_kfunc_call_test_static_unused_arg
>     WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test_ref
> 
> so I reverted this commit for now.
> Looks like pahole with skip_encoding_btf_inconsistent_proto needs
> to be more accurate.
> It's way too aggressive removing valid functions.
