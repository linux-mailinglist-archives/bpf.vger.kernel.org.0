Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2146B20F4
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 11:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjCIKLe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Mar 2023 05:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjCIKLd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Mar 2023 05:11:33 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207A4E4DB2
        for <bpf@vger.kernel.org>; Thu,  9 Mar 2023 02:11:32 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id l7-20020a05600c4f0700b003e79fa98ce1so862412wmq.2
        for <bpf@vger.kernel.org>; Thu, 09 Mar 2023 02:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678356690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N4qOX+eC97lNXPDm5GA2vOsyzO7w87ckiH0SOb+Hos8=;
        b=bYa5JZBMKqIcR5gXfdkhvDXCHGTxBqa1nnqpn60FXEX2ctLPcyia1aHzRPw7qjoCUN
         WQ8E+KUK2RqsGicYhm675GQwc/APpllDClQyu3TTooKeSB/c6N39tArSRJKg3+KHBl3V
         b3kDIYSvrUhtJnDP3VIVlwkkVcEdLPFmd188e4Pbzfvk+1TlCTnB0VDOJ/mKON3/oj+W
         xrw8mfsLPtOtvfJ8YE+0Tq9kpWOcMR7r68KMaZw0nKpHelRF5LdyFP7FSVjn9lEtm7nj
         Qd6o9WspJQR9Lhl7h2R+taGAVicymyvX17SWbfs1EwFTjnQL5RbpLvc+vm/e96SYZ2Ci
         zXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678356690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4qOX+eC97lNXPDm5GA2vOsyzO7w87ckiH0SOb+Hos8=;
        b=txHI13zYD5aqeetEK5aqzWl29y7oWoqO+Qw4Andh27PtS4/Cmpn70YsKRKgxDuO6HL
         2RjeX4XogtWg9iCr1UVF4gjYGSewiTe8p/LFn27fXFu87lHdWQbvsDFjnmI93htqY01l
         iVbSblkqRWFOklveOLWA40LHHz7HSh58XdutnxtVAX0OhTApuwJFktzYkwsYi3VHeykh
         d78R31xZu1xUZ9A9xLP5HGlN+8jv6Jh/c482gmQgGf2BA5/V7655G7O1dfVqrZJCfjBh
         csRoFA/rIMkZMJb1bb4cSC9jeW+g7b6RFeqzY4pfTXmlz+fpyfyRg6BJp6D6hAwOrNfz
         FQZg==
X-Gm-Message-State: AO0yUKUs1P2GRugy+f3bAs+9uuDQdd9w7pGEPvZFfiqBX4lUBx4q58p+
        6P/GrNlRr7K8meb19JQF1PQ8HWdnSvBVlg==
X-Google-Smtp-Source: AK7set+QrrTUknfJz+41MHX+ArcjQL4bSGIue0gM/nde/P1yD1UFaHZ94Sdvsx3mowBvjP4ty/EJYA==
X-Received: by 2002:a05:600c:1906:b0:3eb:3c76:c23c with SMTP id j6-20020a05600c190600b003eb3c76c23cmr19298927wmq.3.1678356690460;
        Thu, 09 Mar 2023 02:11:30 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id he11-20020a05600c540b00b003df5be8987esm2146316wmb.20.2023.03.09.02.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 02:11:30 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 9 Mar 2023 11:11:27 +0100
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
Message-ID: <ZAmwzzrBfmp2GQzr@krava>
References: <1675949331-27935-1-git-send-email-alan.maguire@oracle.com>
 <CAADnVQ+hfQ9LEmEFXneB7hm17NvRniXSShrHLaM-1BrguLjLQw@mail.gmail.com>
 <CAADnVQJe6dRnhbSk92g5Np0tXyMxWLD+8LqUxYfYPr7dWkxzSw@mail.gmail.com>
 <ZAk8L17/EfR8siaz@kernel.org>
 <ZAmV8luLw+umNGqd@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAmV8luLw+umNGqd@krava>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 09, 2023 at 09:16:53AM +0100, Jiri Olsa wrote:
> On Wed, Mar 08, 2023 at 10:53:51PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Feb 13, 2023 at 10:09:21PM -0800, Alexei Starovoitov escreveu:
> > > On Mon, Feb 13, 2023 at 7:12 PM Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > > > On Thu, Feb 9, 2023 at 5:29 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> > > > > +++ b/scripts/pahole-flags.sh
> > > > > @@ -23,5 +23,8 @@ if [ "${pahole_ver}" -ge "124" ]; then
> > > > >         # see PAHOLE_HAS_LANG_EXCLUDE
> > > > >         extra_paholeopt="${extra_paholeopt} --lang_exclude=rust"
> > > > >  fi
> > > > > +if [ "${pahole_ver}" -ge "125" ]; then
> > > > > +       extra_paholeopt="${extra_paholeopt} --skip_encoding_btf_inconsistent_proto --btf_gen_optimized"
> > > > > +fi
> > > >
> > > > We landed this too soon.
> > > > #229     tracing_struct:FAIL
> > > > is failing now.
> > > > since bpf_testmod.ko is missing a bunch of functions though they're global.
> > > >
> > > > I've tried a bunch of different flags and attributes, but none of them
> > > > helped.
> > > > The only thing that works is:
> > > > diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > > > b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > > > index 46500636d8cd..5fd0f75d5d20 100644
> > > > --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > > > +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > > > @@ -28,6 +28,7 @@ struct bpf_testmod_struct_arg_2 {
> > > >         long b;
> > > >  };
> > > >
> > > > +__attribute__((optimize("-O0")))
> > > >  noinline int
> > > >  bpf_testmod_test_struct_arg_1(struct bpf_testmod_struct_arg_2 a, int
> > > > b, int c) {
> > > >
> > > > We cannot do:
> > > > --- a/tools/testing/selftests/bpf/bpf_testmod/Makefile
> > > > +++ b/tools/testing/selftests/bpf/bpf_testmod/Makefile
> > > > @@ -10,7 +10,7 @@ endif
> > > >  MODULES = bpf_testmod.ko
> > > >
> > > >  obj-m += bpf_testmod.o
> > > > -CFLAGS_bpf_testmod.o = -I$(src)
> > > > +CFLAGS_bpf_testmod.o = -I$(src) -O0
> > > >
> > > > The build fails due to asm stuff.
> > > >
> > > > Maybe we should make scripts/pahole-flags.sh selective
> > > > and don't apply skip_encoding_btf_inconsiste to bpf_testmod ?
> > > >
> > > > Thoughts?
> > > 
> > > It's even worse with clang compiled kernel:
> > 
> > I tested what is now in the master branch with both gcc and clang, on
> > fedora:37, Alan also tested it, Jiri, it would be great if you could
> > check if reverting the revert works for you as well.
> 
> ok, will check your master branch

looks good.. got no duplicates and passing bpf tests for both
gcc and clang setups

jirka
