Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCA4697073
	for <lists+bpf@lfdr.de>; Tue, 14 Feb 2023 23:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjBNWMo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 17:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjBNWMn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 17:12:43 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF7B126C4
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 14:12:38 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a3so9611889ejb.3
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 14:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d8KyNZFLQrt4eaQzgJzTwqdtQmFmIEQstURbrl/F1mg=;
        b=ii4PqiXiPhpkyELfUV7HMXmJzyyLcpziLBS8QNPzoW9rci70EMMRvATWY74t7lVqxd
         zmYgf5UwzReH/V9Czh7SVgqTUJ95k3q3+s2WrCPJJuO7FxjPHvvcFw4iHjHPx8FzpqVV
         ybYn3uYAunQHc05/MZ3oH48O2aFbYVFRB1jYumLPSDgoXjK5/NUGzOljmf6tJkX8jUCM
         p/52CSAlz5U2ihB0eXoPxcO9QGfZMGegGfR01om59GXcUbxp97sF6PvBwBJrFZmiJhjs
         hxau+3h9I1FO1SCkJia2h1z7Il0xdaMrGASB0jTbwm7YtPfWROTVzn1evTu+syqfwUFU
         anXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d8KyNZFLQrt4eaQzgJzTwqdtQmFmIEQstURbrl/F1mg=;
        b=ozUTBaIW73CcSQyXQTxIOrIAr9WbygmdFuEl8nwqSTgrl2u84D7qOQl+ArFU/+rkZo
         72klDsPMVNP5K55yWuqRU3UeK3C5ZWoF2rALLsbcOYPz0g/+nyaigAZ2WpDxYZGQfwZk
         yDu8HLCxTZGhCM+LVYlJDRpxbUIK2bSRg2B+HXSNFI+SLTXZlt2YJebUJkE6l1mt37v/
         MIrknsjceE1+N8e6U2jbepPiH+TwdGO20dJqsVGOvjsu24BM0dLUgBjfGvEO1fGuHyV5
         ociwfFdnponoDCTXTVMeTbYGfJmtiHa0uiDyk//tm/BOz6/nBRJvs/HAX6I46QOHKYb7
         HJiQ==
X-Gm-Message-State: AO0yUKXY8RxDVUOagikjjFG3vYGISB2aBFGROB0GIeAWINESWsyB8k4p
        DM/rkC8qeKFvLyqKvSu/n0Jk3Gk6ZmjVaee1k2g=
X-Google-Smtp-Source: AK7set/V4PajvNYOnJ4pTwg5qLpW9E1wvDEz/fWhH1AEgTjLgdvsaS4W8UNOCX9/wbg5k97BvEiF/A==
X-Received: by 2002:a17:906:4e84:b0:889:58bd:86f1 with SMTP id v4-20020a1709064e8400b0088958bd86f1mr43200eju.14.1676412756790;
        Tue, 14 Feb 2023 14:12:36 -0800 (PST)
Received: from krava (212-147-51-13.fix.access.vtx.ch. [212.147.51.13])
        by smtp.gmail.com with ESMTPSA id x16-20020a170906711000b008512e1379dbsm8913756ejj.171.2023.02.14.14.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 14:12:36 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 14 Feb 2023 23:12:34 +0100
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
Message-ID: <Y+wHUlZpB4IeNyfp@krava>
References: <1675949331-27935-1-git-send-email-alan.maguire@oracle.com>
 <CAADnVQ+hfQ9LEmEFXneB7hm17NvRniXSShrHLaM-1BrguLjLQw@mail.gmail.com>
 <Y+t+P2OOpEZ7UemB@krava>
 <Y+u0NMmLGG3zJJUx@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+u0NMmLGG3zJJUx@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 14, 2023 at 01:17:56PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Feb 14, 2023 at 01:27:43PM +0100, Jiri Olsa escreveu:
> > On Mon, Feb 13, 2023 at 07:12:33PM -0800, Alexei Starovoitov wrote:
> > > On Thu, Feb 9, 2023 at 5:29 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> > > >
> > > > v1.25 of pahole supports filtering out functions with multiple
> > > > inconsistent function prototypes or optimized-out parameters
> > > > from the BTF representation.  These present problems because
> > > > there is no additional info in BTF saying which inconsistent
> > > > prototype matches which function instance to help guide
> > > > attachment, and functions with optimized-out parameters can
> > > > lead to incorrect assumptions about register contents.
> > > >
> > > > So for now, filter out such functions while adding BTF
> > > > representations for functions that have "."-suffixes
> > > > (foo.isra.0) but not optimized-out parameters.
> > > >
> > > > This patch assumes changes in [1] land and pahole is bumped
> > > > to v1.25.
> > > >
> > > > [1] https://lore.kernel.org/bpf/1675790102-23037-1-git-send-email-alan.maguire@oracle.com/
> > > >
> > > > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > > > Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > >
> > > > ---
> > > >  scripts/pahole-flags.sh | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
> > > > index 1f1f1d3..728d551 100755
> > > > --- a/scripts/pahole-flags.sh
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
> > 
> > hum, didn't see this one failing.. I'll try that again
> 
> /me too, redoing tests her, with gcc and clang, running selftests on a
> system booted with a kernel built with pahole 1.25, etc.

ok, can't see that with gcc, but reproduced with clang 16

resolve_btfids complains because those functions are not in btf

  BTFIDS  vmlinux
WARN: resolve_btfids: unresolved symbol tcp_reno_cong_avoid
WARN: resolve_btfids: unresolved symbol should_failslab
WARN: resolve_btfids: unresolved symbol should_fail_alloc_page
WARN: resolve_btfids: unresolved symbol cubictcp_cong_avoid
WARN: resolve_btfids: unresolved symbol bpf_xdp_metadata_rx_timestamp
WARN: resolve_btfids: unresolved symbol bpf_xdp_metadata_rx_hash
WARN: resolve_btfids: unresolved symbol bpf_task_kptr_get
WARN: resolve_btfids: unresolved symbol bpf_task_acquire_not_zero
WARN: resolve_btfids: unresolved symbol bpf_rdonly_cast
WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test_static_unused_arg
WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test_ref
WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test_pass_ctx
WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test_pass2
WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test_pass1
WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test_mem_len_pass1
WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test_mem_len_fail2
WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test_mem_len_fail1
WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test_kptr_get
WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test_fail3
WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test_fail2
WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test_fail1
WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test_acquire
WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test2
WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test1
WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_memb_release
WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_memb1_release
WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_int_mem_release
  NM      System.map

jirka
