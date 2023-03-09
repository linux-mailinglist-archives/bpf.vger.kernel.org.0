Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAD46B1DBE
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 09:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjCIIVS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Mar 2023 03:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjCIIUj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Mar 2023 03:20:39 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA42DE1D1
        for <bpf@vger.kernel.org>; Thu,  9 Mar 2023 00:16:55 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id h11so1004419wrm.5
        for <bpf@vger.kernel.org>; Thu, 09 Mar 2023 00:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678349814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m8wnah3tqTNqE9aY6keCD8XrogXEIwfFsInR1NH87YU=;
        b=L8+UC9J+I1VU2OSLt3C6m580IpFeOqaJ7jmfwxCXKL34sBJMHMz2OtRtn2LiCrIBGl
         FIETE+LNGw7MwKbn3gEvXC2OtCj4IBzJ91T/KH73jajOb99YGaNCtclM/qWg2rAcTkPP
         D4UQS9VoOX7JsqlBJedPowN45NO5TuQXxlaa55HoHeOWFG5FMTzOzt2PRSQfL4GmhvPO
         nTgtYjnJ8T4EPe2Bpfk+j5em8HnfLFwpzMVghbpZv6ktAI0G68IL5pF0/E6Tm9L4jIiU
         pHsFKep29ZUes0FtFnXIWSGW+mmDHKpEZPZiJ+j85qyWCdwELrvE1GShESHbKsnBRXcQ
         YFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678349814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8wnah3tqTNqE9aY6keCD8XrogXEIwfFsInR1NH87YU=;
        b=GfTk6XK84CEXTMaIeGhs9d8nVA9lzdDiIscxLeMH2GEXoPACfHyU754A+iPiy6TUQB
         DWNewfo6dcBwZzj91w5XMj2hTyBV8h+B48m9kyce2QEdIHtR4PhiLIEglQyrB4jsfmGn
         LItTlq7kz2bxCGMCgYDzuAj8LsQs1cPVLWsqwCwWgt3kHzoaQtcT+fU+30pdc4qLa/Oj
         Pcv9wadTCt20zkd/Se69f2QWbmOdgsQcVNHsymqTQe7Yc55M6mCAj3CEG04hWyfsfxGx
         GMFQZq/yJNMs1HdhnlZpXsTjlqiN/xgGM/jm5Kn1hUsiHkn3skkBz4Q65cFIEIWhoeFW
         /PnA==
X-Gm-Message-State: AO0yUKVMjrav/kIk8UW8nh1hILoVE8hYP/J/mUUdM57muU3gLyWt4R6K
        WCUl84zfvItzHCC7/bCuPBI=
X-Google-Smtp-Source: AK7set85lbJATXokfH0bOU62KHiDhn5SbCfD/3ARspp4WW3B7WGuhQQbnZRb8uf4J+rZiZX5U7OR8g==
X-Received: by 2002:a5d:6a8b:0:b0:2c3:f0a6:43ee with SMTP id s11-20020a5d6a8b000000b002c3f0a643eemr16979722wru.20.1678349813751;
        Thu, 09 Mar 2023 00:16:53 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id e15-20020a5d594f000000b002c56046a3b5sm17189221wri.53.2023.03.09.00.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 00:16:53 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 9 Mar 2023 09:16:50 +0100
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
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
Message-ID: <ZAmV8luLw+umNGqd@krava>
References: <1675949331-27935-1-git-send-email-alan.maguire@oracle.com>
 <CAADnVQ+hfQ9LEmEFXneB7hm17NvRniXSShrHLaM-1BrguLjLQw@mail.gmail.com>
 <CAADnVQJe6dRnhbSk92g5Np0tXyMxWLD+8LqUxYfYPr7dWkxzSw@mail.gmail.com>
 <ZAk8L17/EfR8siaz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAk8L17/EfR8siaz@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 08, 2023 at 10:53:51PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Feb 13, 2023 at 10:09:21PM -0800, Alexei Starovoitov escreveu:
> > On Mon, Feb 13, 2023 at 7:12 PM Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > > On Thu, Feb 9, 2023 at 5:29 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> > > > +++ b/scripts/pahole-flags.sh
> > > > @@ -23,5 +23,8 @@ if [ "${pahole_ver}" -ge "124" ]; then
> > > >         # see PAHOLE_HAS_LANG_EXCLUDE
> > > >         extra_paholeopt="${extra_paholeopt} --lang_exclude=rust"
> > > >  fi
> > > > +if [ "${pahole_ver}" -ge "125" ]; then
> > > > +       extra_paholeopt="${extra_paholeopt} --skip_encoding_btf_inconsistent_proto --btf_gen_optimized"
> > > > +fi
> > >
> > > We landed this too soon.
> > > #229     tracing_struct:FAIL
> > > is failing now.
> > > since bpf_testmod.ko is missing a bunch of functions though they're global.
> > >
> > > I've tried a bunch of different flags and attributes, but none of them
> > > helped.
> > > The only thing that works is:
> > > diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > > b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > > index 46500636d8cd..5fd0f75d5d20 100644
> > > --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > > +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > > @@ -28,6 +28,7 @@ struct bpf_testmod_struct_arg_2 {
> > >         long b;
> > >  };
> > >
> > > +__attribute__((optimize("-O0")))
> > >  noinline int
> > >  bpf_testmod_test_struct_arg_1(struct bpf_testmod_struct_arg_2 a, int
> > > b, int c) {
> > >
> > > We cannot do:
> > > --- a/tools/testing/selftests/bpf/bpf_testmod/Makefile
> > > +++ b/tools/testing/selftests/bpf/bpf_testmod/Makefile
> > > @@ -10,7 +10,7 @@ endif
> > >  MODULES = bpf_testmod.ko
> > >
> > >  obj-m += bpf_testmod.o
> > > -CFLAGS_bpf_testmod.o = -I$(src)
> > > +CFLAGS_bpf_testmod.o = -I$(src) -O0
> > >
> > > The build fails due to asm stuff.
> > >
> > > Maybe we should make scripts/pahole-flags.sh selective
> > > and don't apply skip_encoding_btf_inconsiste to bpf_testmod ?
> > >
> > > Thoughts?
> > 
> > It's even worse with clang compiled kernel:
> 
> I tested what is now in the master branch with both gcc and clang, on
> fedora:37, Alan also tested it, Jiri, it would be great if you could
> check if reverting the revert works for you as well.

ok, will check your master branch

jirka

> 
> Thanks,
> 
> - Arnaldo
> 
> >     WARN: resolve_btfids: unresolved symbol tcp_reno_cong_avoid
> >     WARN: resolve_btfids: unresolved symbol dctcp_update_alpha
> >     WARN: resolve_btfids: unresolved symbol cubictcp_cong_avoid
> >     WARN: resolve_btfids: unresolved symbol bpf_xdp_metadata_rx_timestamp
> >     WARN: resolve_btfids: unresolved symbol bpf_xdp_metadata_rx_hash
> >     WARN: resolve_btfids: unresolved symbol bpf_task_kptr_get
> >     WARN: resolve_btfids: unresolved symbol bpf_task_acquire_not_zero
> >     WARN: resolve_btfids: unresolved symbol bpf_rdonly_cast
> >     WARN: resolve_btfids: unresolved symbol
> > bpf_kfunc_call_test_static_unused_arg
> >     WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test_ref
> > 
> > so I reverted this commit for now.
> > Looks like pahole with skip_encoding_btf_inconsistent_proto needs
> > to be more accurate.
> > It's way too aggressive removing valid functions.
