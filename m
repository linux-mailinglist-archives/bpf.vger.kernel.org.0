Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780BC66CEE2
	for <lists+bpf@lfdr.de>; Mon, 16 Jan 2023 19:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjAPSd4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Jan 2023 13:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234641AbjAPSdR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Jan 2023 13:33:17 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F233931E17;
        Mon, 16 Jan 2023 10:20:08 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id v6so41741248edd.6;
        Mon, 16 Jan 2023 10:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BdBAjgdg/xHT5B5cpQt7sUtItA5iOS/s8nXBTNe5UZQ=;
        b=b+VmNu9XjbFakpC33oMtPVNggfFXgV6YIECD3BDTjW2uIt5WiSwXNeDMjfhkLRI+3Y
         06CktPwsYaLsYprdtzpWGjpxrZSkG5qOuB5lIzzyzzlOHXfJXqorosRkXAN/7v8x/Zkg
         8sQa5brsQenAFPFrrCua/0UESTyhiwSLBn8lxmuXJ2MXbsudNWagW6gCad9Vx1Xa8OZL
         N5ukqdqqt+KunvRAfe6yG8XPvtXLEU2cX2gf9MTuyDPvdnBbW3DH5U+mHalEnZDEPMsC
         NYcaFptAmszBRKjtyI9AVEZdmvGUCY5i8HDRu69eGrvbhHyQExTnHKXNaOVbGQCbv5VX
         BsSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BdBAjgdg/xHT5B5cpQt7sUtItA5iOS/s8nXBTNe5UZQ=;
        b=bF+Akw0QBh9poY+Qm+v6T9bDj3WKnCix3dkYKWV14gogCORqFfdaMrGXMMMEAKHkWZ
         iLsXFRTe8+uD6LA+btEWfesJUflk9EwmsvEnPXEJs2atF/0qoDVqkik5R4dotQQAVQxl
         3CNVojOb1BN6GtproCRTxjZwg4R7w2Be9C1V6rHpQqHTjByEgOtC6VS/amvpTlOCy/gz
         vuAne4n70vkh/FDQKY01uYuWHaACngDQBu7mTjOx/diVO3qWSaDmqwWyEZ2J7Tt6qbMq
         1tNYVof7/Do4Oz6ClgcfFLy1hmJNYNcNmmv5/BYbAyWREjQdq0qTDUr6Xo/jRuvIyHcK
         ZG8Q==
X-Gm-Message-State: AFqh2kpcnbA068G2ZwDnep7ULL01AsgJOOEvhkSOtKQVAOwJvsfb8l75
        cklWOD5MWGlc9M0jjuoNohM=
X-Google-Smtp-Source: AMrXdXsmGzJlgtzYud9AgOqbiS7VNvunh8+imn763uAldOvwEV5HJLfMzoZG/tT/bEQ98LGWNkIvgA==
X-Received: by 2002:a05:6402:5412:b0:49d:f4de:1988 with SMTP id ev18-20020a056402541200b0049df4de1988mr149745edb.42.1673893207449;
        Mon, 16 Jan 2023 10:20:07 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id bm15-20020a0564020b0f00b00499e797f613sm6357252edb.59.2023.01.16.10.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 10:20:06 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 16 Jan 2023 19:20:04 +0100
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Connor OBrien <connoro@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] tools/resolve_btfids: Install subcmd headers
Message-ID: <Y8WVVLEIkXgYvePd@krava>
References: <20230112004024.1934601-1-irogers@google.com>
 <Y8Uzet0cNtDo8kHe@krava>
 <CAP-5=fXjjnivhuVSRj7yjaea+6E-YfVKP+Tz2BsTNSqUBDvm4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXjjnivhuVSRj7yjaea+6E-YfVKP+Tz2BsTNSqUBDvm4g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 16, 2023 at 09:20:39AM -0800, Ian Rogers wrote:
> On Mon, Jan 16, 2023 at 3:22 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Wed, Jan 11, 2023 at 04:40:24PM -0800, Ian Rogers wrote:
> > > Previously tools/lib/subcmd was added to the include path, switch to
> > > installing the headers and then including from that directory. This
> > > avoids dependencies on headers internal to tools/lib/subcmd. Add the
> > > missing subcmd directory to the affected #include.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/bpf/resolve_btfids/Makefile | 19 ++++++++++++++-----
> > >  tools/bpf/resolve_btfids/main.c   |  2 +-
> > >  2 files changed, 15 insertions(+), 6 deletions(-)
> >
> > this depends on changes that went to Arnaldo's tree right?
> > I can't apply this on bpf-next/master
> 
> Hmm.. sorry for that. I did the work on the master branch of
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> 
> > >
> > > diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
> > > index 19a3112e271a..de7d29cf43d6 100644
> > > --- a/tools/bpf/resolve_btfids/Makefile
> > > +++ b/tools/bpf/resolve_btfids/Makefile
> > > @@ -35,21 +35,29 @@ SUBCMD_SRC := $(srctree)/tools/lib/subcmd/
> > >  BPFOBJ     := $(OUTPUT)/libbpf/libbpf.a
> > >  LIBBPF_OUT := $(abspath $(dir $(BPFOBJ)))/
> > >  SUBCMDOBJ  := $(OUTPUT)/libsubcmd/libsubcmd.a
> > > +SUBCMD_OUT := $(abspath $(dir $(SUBCMDOBJ)))/
> > >
> > >  LIBBPF_DESTDIR := $(LIBBPF_OUT)
> > >  LIBBPF_INCLUDE := $(LIBBPF_DESTDIR)include
> > >
> > > +SUBCMD_DESTDIR := $(SUBCMD_OUT)
> > > +SUBCMD_INCLUDE := $(SUBCMD_DESTDIR)include
> > > +
> > >  BINARY     := $(OUTPUT)/resolve_btfids
> > >  BINARY_IN  := $(BINARY)-in.o
> > >
> > >  all: $(BINARY)
> > >
> > > +prepare: $(SUBCMDOBJ)
> >
> > do we need special target for that? we already have BPFOBJ dependency
> > placed in the BINARY_IN as prereq
> 
> BPFOBJ is $(OUTPUT)/libbpf/libbpf.a which is needed at link time. The
> prepare step is one we have elsewhere and it creates things like the
> header files necessary to compile the C code, so we need it earlier is
> the answer.
> 
> > why not place both as BINARY_IN prereq, or is there some other reason
> > for new 'prepare' target?
> 
> I was trying to follow the convention elsewhere in the tree of having
> a prepare target that does things like get the necessary header files
> ready. Having prepare is useful because if an additional dependency is
> added, then it just needs to be added to prepare. It could be tedious
> to list all the dependencies for every C file, although Makefile.build

ok, could we maybe add the BPFOBJ in prepare target as well?

> handles most of that. It isn't clear to me why $(BPFOBJ) is a
> dependency of $(BINARY_IN) as it is already a dependency of $(BINARY).

I think that if you specify OUTPUT then we need the libbpf headers
to be created before we go to compile resolve_btfids objects

thanks,
jirka
