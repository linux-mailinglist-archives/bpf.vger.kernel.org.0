Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED3A696375
	for <lists+bpf@lfdr.de>; Tue, 14 Feb 2023 13:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbjBNM1s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 07:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBNM1r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 07:27:47 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B292D25299
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 04:27:46 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id bt8so11275677edb.12
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 04:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J4ZNKltMdpSqWgUMIZrGzJIK18WKAwffyLCcN+l9nlo=;
        b=DGpOFC9iWm3If3HDDKZ3fy8TbFQ3UTv65vseHqnuyiCI26gYgdLkp7FzipVrQRh+9h
         Dn3s0PvjXb67zEDB6rco18vgnM6vlozjv+iBrDxhr2B7mD2b997cCcIlTsfg0ZiLTDrf
         33f+vM27jxrPDYLDDkoO4ebYGvseIHHX/NzCQZjjDRbfHQ+TqFdmI3pYb3Xh3CVj+ehL
         dKu7Vs2tHFwjFRB0k/3LmOnN+tg0p4parmubtVMgSBzaGGDD7iMKrWY7ljIZ4wX6ZmH7
         rr1kYfdaqDyxVyazpmDGJkvrYxpvFbU3GtWjTLfZ90J3ZGghUFBOK26pWYGal47PwQ3i
         jO7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J4ZNKltMdpSqWgUMIZrGzJIK18WKAwffyLCcN+l9nlo=;
        b=aDrALJw27HU0FNVXWVHa6MX9la5W8YQw+lDtLnQ7MGt7dTAD2Hj7zgF5JOL8U1Tzr9
         mHk4uMful9qxnlDGfOCC52j/J7gI31IQk45vms0+KCgl0ZM9wxg+bKZOnFlKssh1A5dh
         rtcb5xXkmaoEz0ogci169E/0TvE+gw5imqqPmhZqNXmn2YppCvEDCbyzuTkJH0HjL9Zy
         wRBWVkwyru4gOmSAoalorrlldFb5gqH9LtU0BtChTCsFMPyvhCxY2Wtyy8uUWqlAOrJC
         KkW/QjD08kWcvn5stEVlGxo+BWChH0bsQNW/c1hxRDO/zdBF4/nE0EWuErNPjZIUGPZk
         aJ0A==
X-Gm-Message-State: AO0yUKVeKzAMYC3oKF2/fxC15c2bCKqwunDR18mPAEpJj8HSDcxb+lQt
        93gFxfmqfLTlXXSr2GLT1JI=
X-Google-Smtp-Source: AK7set8NhoTInE4/ZUrEVf7JoF5+5HRuSnyynTawFDX/1ktHv6yEw87E1K3ryz/iYyHcrGTJ/KWpng==
X-Received: by 2002:a50:ccc2:0:b0:49d:9ff4:d82b with SMTP id b2-20020a50ccc2000000b0049d9ff4d82bmr2222715edj.15.1676377665164;
        Tue, 14 Feb 2023 04:27:45 -0800 (PST)
Received: from krava ([81.6.34.132])
        by smtp.gmail.com with ESMTPSA id g22-20020a17090670d600b008b0ff9c1ea8sm3829849ejk.56.2023.02.14.04.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 04:27:44 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 14 Feb 2023 13:27:43 +0100
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
        Hao Luo <haoluo@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next] bpf: add
 --skip_encoding_btf_inconsistent_proto, --btf_gen_optimized to pahole flags
 for v1.25
Message-ID: <Y+t+P2OOpEZ7UemB@krava>
References: <1675949331-27935-1-git-send-email-alan.maguire@oracle.com>
 <CAADnVQ+hfQ9LEmEFXneB7hm17NvRniXSShrHLaM-1BrguLjLQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQ+hfQ9LEmEFXneB7hm17NvRniXSShrHLaM-1BrguLjLQw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 13, 2023 at 07:12:33PM -0800, Alexei Starovoitov wrote:
> On Thu, Feb 9, 2023 at 5:29 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> >
> > v1.25 of pahole supports filtering out functions with multiple
> > inconsistent function prototypes or optimized-out parameters
> > from the BTF representation.  These present problems because
> > there is no additional info in BTF saying which inconsistent
> > prototype matches which function instance to help guide
> > attachment, and functions with optimized-out parameters can
> > lead to incorrect assumptions about register contents.
> >
> > So for now, filter out such functions while adding BTF
> > representations for functions that have "."-suffixes
> > (foo.isra.0) but not optimized-out parameters.
> >
> > This patch assumes changes in [1] land and pahole is bumped
> > to v1.25.
> >
> > [1] https://lore.kernel.org/bpf/1675790102-23037-1-git-send-email-alan.maguire@oracle.com/
> >
> > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> >
> > ---
> >  scripts/pahole-flags.sh | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
> > index 1f1f1d3..728d551 100755
> > --- a/scripts/pahole-flags.sh
> > +++ b/scripts/pahole-flags.sh
> > @@ -23,5 +23,8 @@ if [ "${pahole_ver}" -ge "124" ]; then
> >         # see PAHOLE_HAS_LANG_EXCLUDE
> >         extra_paholeopt="${extra_paholeopt} --lang_exclude=rust"
> >  fi
> > +if [ "${pahole_ver}" -ge "125" ]; then
> > +       extra_paholeopt="${extra_paholeopt} --skip_encoding_btf_inconsistent_proto --btf_gen_optimized"
> > +fi
> 
> We landed this too soon.
> #229     tracing_struct:FAIL
> is failing now.
> since bpf_testmod.ko is missing a bunch of functions though they're global.
> 

hum, didn't see this one failing.. I'll try that again

jirka

> I've tried a bunch of different flags and attributes, but none of them
> helped.
> The only thing that works is:
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> index 46500636d8cd..5fd0f75d5d20 100644
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> @@ -28,6 +28,7 @@ struct bpf_testmod_struct_arg_2 {
>         long b;
>  };
> 
> +__attribute__((optimize("-O0")))
>  noinline int
>  bpf_testmod_test_struct_arg_1(struct bpf_testmod_struct_arg_2 a, int
> b, int c) {
> 
> We cannot do:
> --- a/tools/testing/selftests/bpf/bpf_testmod/Makefile
> +++ b/tools/testing/selftests/bpf/bpf_testmod/Makefile
> @@ -10,7 +10,7 @@ endif
>  MODULES = bpf_testmod.ko
> 
>  obj-m += bpf_testmod.o
> -CFLAGS_bpf_testmod.o = -I$(src)
> +CFLAGS_bpf_testmod.o = -I$(src) -O0
> 
> The build fails due to asm stuff.
> 
> Maybe we should make scripts/pahole-flags.sh selective
> and don't apply skip_encoding_btf_inconsiste to bpf_testmod ?
> 
> Thoughts?
