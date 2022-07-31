Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B8058618B
	for <lists+bpf@lfdr.de>; Sun, 31 Jul 2022 23:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237982AbiGaVOk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 31 Jul 2022 17:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbiGaVOk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 31 Jul 2022 17:14:40 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2721223B
        for <bpf@vger.kernel.org>; Sun, 31 Jul 2022 14:14:39 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id fy29so17052845ejc.12
        for <bpf@vger.kernel.org>; Sun, 31 Jul 2022 14:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=3//CunvtFkZt4XvlNgLtMfUiOtkab4hADb/1RUx2yjE=;
        b=mCHkNVWdswM+Nna/doxGRedFDg9aVsF21Vr4C8OQggmXw8yJ/XN2Y4W64C05Z5OZ+m
         hXt34WtEOhPJBNO+vg5ufC3iCCh3F+TZBszJDMEGmuxETLZF9F29eRyPF6jfR+21tzhV
         gzbuh0kXgQUOmx6u6Mq6SAKDRb2tnA+jdSTMomRvCELFSGnpT+9t7+frFSF7G/z5OfRG
         Eob+pD+tBdgrsyzMrzHOYwvgDjMT7sPbfeeAfGj/0tIIfMmUPIlihoTPFHJkzXpBv+BT
         Ru62xcdRMYeyXrVgNyCwSQwgprm5zk0DhOgrbOD3Q9eceFUb3Rxo46vlTX9mrD+g55ev
         6K5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=3//CunvtFkZt4XvlNgLtMfUiOtkab4hADb/1RUx2yjE=;
        b=dONi0cX0XV2Sr9c3Ca4I4lIKELbVTI1mcKS6MBApdPZTKdeG322A9I5w8Tl5N+z8i0
         Da3K9AJg9bE+V8oZd3RfFbK/Czb5P7o0Tm/yPM0GGF6y316xvgdiQbmacVNHtFskkNG6
         on/ULtt+dH5a+qfEgPOpWayKNAGq5TZrXbk5qy9Njq6D+D2se9oPPrDX7U1uOVem2XIA
         ZH33R7TojbDu9s93da2oYaFSl20Jwi1F/g4PQK1+CSaO5yXFLJevYpa0SMps+ennz/MW
         EoIF0gPcfGtapsVDNUyPdOgZEtHmM44l7sXFUxTqH6+oi6o+v+yyLPpM7drYgi5iv6pE
         CSuQ==
X-Gm-Message-State: ACgBeo0qBUIykacFZvCQ+gEJCp/GkNeaetbOC+kmtNy5BvEIFJNF/paL
        aw8lhAsaNJFhiPvewKjd8uM=
X-Google-Smtp-Source: AA6agR4az1eFvdfc8+/beKghFWR76ZdB+EHXZxhwkbp4bIcsRK/Fi0THTFuuI+yhKD0IdMjO59th9w==
X-Received: by 2002:a17:906:98c8:b0:730:7ada:87a7 with SMTP id zd8-20020a17090698c800b007307ada87a7mr2368268ejb.748.1659302077683;
        Sun, 31 Jul 2022 14:14:37 -0700 (PDT)
Received: from krava ([83.240.61.175])
        by smtp.gmail.com with ESMTPSA id es21-20020a056402381500b0043d27693d31sm4138754edb.31.2022.07.31.14.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 14:14:37 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Sun, 31 Jul 2022 23:14:34 +0200
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH bpf-next 4/5] selftests/bpf: Disable kprobe attach test
 with offset for CONFIG_X86_KERNEL_IBT
Message-ID: <YubwuidpHmjYt1Cg@krava>
References: <20220724212146.383680-1-jolsa@kernel.org>
 <20220724212146.383680-5-jolsa@kernel.org>
 <CAEf4BzYnG3SLXs1+ebK+x7fM1ZaoPZ8=qH4mqUGhb6Ojf8x3Jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYnG3SLXs1+ebK+x7fM1ZaoPZ8=qH4mqUGhb6Ojf8x3Jg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 29, 2022 at 03:15:55PM -0700, Andrii Nakryiko wrote:
> On Sun, Jul 24, 2022 at 2:22 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Attach like 'kprobe/bpf_fentry_test6+0x5' will fail to attach
> > when CONFIG_X86_KERNEL_IBT option is enabled because of the
> > endbr instruction at the function entry.
> >
> > We would need to do manual attach with offset calculation based
> > on the CONFIG_X86_KERNEL_IBT option, which does not seem worth
> > the effort to me.
> >
> > Disabling these test when CONFIG_X86_KERNEL_IBT is enabled.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  .../bpf/prog_tests/get_func_ip_test.c         | 25 +++++++++++++++----
> >  1 file changed, 20 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
> > index 938dbd4d7c2f..cb0b78fb29df 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
> > @@ -2,6 +2,24 @@
> >  #include <test_progs.h>
> >  #include "get_func_ip_test.skel.h"
> >
> > +/* assume IBT is enabled when kernel configs are not available */
> > +#ifdef HAVE_GENHDR
> > +# include "autoconf.h"
> > +#else
> > +#  define CONFIG_X86_KERNEL_IBT 1
> > +#endif
> 
> this autoconf.h business is something I'd rather avoid, it would be
> great to be able to use libbpf's __kconfig support to detect
> CONFIG_X86_KERNEL_IBT instead? One way would be to mark test6/test7 as
> non-auto-loadable (SEC("?...")). Load only test1-tes5, run tests, in

aah so that's what the '?' prefix is for :))

> one of BPF programs propagate __kconfig CONFIG_X86_KERNEL_IBT to
> user-space through a global variable. Attach skeleton, trigger
> everything, remember whether IBT is enabled or not.
> 
> If it is defined, load skeleton again, but now enable test6 and test7
> and manually attach them through bpf_program__attach_kprobe()
> specifying offset as +5 or +9, depending on IBT. It's certainly a bit
> more code, but we'll actually test IBT stuff properly.
> 
> WDYT?

right, seems doable.. also I wonder how hard would it be to have some
generic support for that, maybe there are other users..  I'll check

thanks,
jirka
