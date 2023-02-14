Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69D669691D
	for <lists+bpf@lfdr.de>; Tue, 14 Feb 2023 17:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjBNQST (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 11:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjBNQSS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 11:18:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030C5212BB
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 08:18:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D11061787
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 16:17:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42BA1C4339B;
        Tue, 14 Feb 2023 16:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676391478;
        bh=IDyaCFdXUgNyjib3ei7T0kXZdZDmnYwJHZO+itZBSms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MXMWbrW3snA0P/o79E0MBkmNmYsmVPcqdYFqXpTCbVThLhlnBs4CDoCsTpsrlR+hK
         2KCiNj1RHnnQC11pgDgFIXhqMyeHiSIcGZ8HuqDLIP3IRxQLHIaAAylmPLVwZbWFm+
         b0jowyHJ86cDo+IqgkpkuBij3mzyIALwMmVVckCHpDXG4sbAikg8cVZp1Aocy0JuBB
         WNsZsBwe7fhV28hDqrHaNiMTbJK0VDTNcgeZSCW5b/sPD6V2LjeUj4nOH9Fr1EJ6Zc
         M9Jq3H1Y70mWR1T6fHnRZLj2N3Ah4kafcrofSkD4A9opp9GnnI/s+KYkTbAkM3ZJGF
         whOM7e7hjo5PA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1984E40025; Tue, 14 Feb 2023 13:17:56 -0300 (-03)
Date:   Tue, 14 Feb 2023 13:17:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next] bpf: add
 --skip_encoding_btf_inconsistent_proto, --btf_gen_optimized to pahole flags
 for v1.25
Message-ID: <Y+u0NMmLGG3zJJUx@kernel.org>
References: <1675949331-27935-1-git-send-email-alan.maguire@oracle.com>
 <CAADnVQ+hfQ9LEmEFXneB7hm17NvRniXSShrHLaM-1BrguLjLQw@mail.gmail.com>
 <Y+t+P2OOpEZ7UemB@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+t+P2OOpEZ7UemB@krava>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Feb 14, 2023 at 01:27:43PM +0100, Jiri Olsa escreveu:
> On Mon, Feb 13, 2023 at 07:12:33PM -0800, Alexei Starovoitov wrote:
> > On Thu, Feb 9, 2023 at 5:29 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> > >
> > > v1.25 of pahole supports filtering out functions with multiple
> > > inconsistent function prototypes or optimized-out parameters
> > > from the BTF representation.  These present problems because
> > > there is no additional info in BTF saying which inconsistent
> > > prototype matches which function instance to help guide
> > > attachment, and functions with optimized-out parameters can
> > > lead to incorrect assumptions about register contents.
> > >
> > > So for now, filter out such functions while adding BTF
> > > representations for functions that have "."-suffixes
> > > (foo.isra.0) but not optimized-out parameters.
> > >
> > > This patch assumes changes in [1] land and pahole is bumped
> > > to v1.25.
> > >
> > > [1] https://lore.kernel.org/bpf/1675790102-23037-1-git-send-email-alan.maguire@oracle.com/
> > >
> > > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > > Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > >
> > > ---
> > >  scripts/pahole-flags.sh | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
> > > index 1f1f1d3..728d551 100755
> > > --- a/scripts/pahole-flags.sh
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
> 
> hum, didn't see this one failing.. I'll try that again

/me too, redoing tests her, with gcc and clang, running selftests on a
system booted with a kernel built with pahole 1.25, etc.

- Arnaldo
 
> jirka
> 
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

-- 

- Arnaldo
