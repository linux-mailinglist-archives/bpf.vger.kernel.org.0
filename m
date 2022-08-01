Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516705871CD
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 21:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235185AbiHATxq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 15:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234514AbiHATxj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 15:53:39 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F1D62E1;
        Mon,  1 Aug 2022 12:53:38 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id m4so480166ejr.3;
        Mon, 01 Aug 2022 12:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=KaTiX46BfLE12fhVgvPIixWb+ByqaTNtLnUIiRpJ4Zw=;
        b=FfjO+oJuktYQF9bGnTgM86VKFS3QavixeEpHkRMyhKM1xgc9rm5nr8FyG7jhNLUlXj
         W11415JbeywsHo4HKNnBSXwQ4h+DsTyhmuzPst/YIKnKHDXDF6S4mjCXOytlvHDFEbJ2
         EG1ByChlKqvBWJlQK+HE1SyFFauJfqfDV3iUhnahi7RJbuisS/mVU332g2mdYcraHZ8C
         /ADDIQ7ApPWRG46NUger6AlDEUg3tBo8DSaBq4E8vPyqqTX6UXYv+Lz6/n1HMxmkd7dR
         HivAjNHDkjfkpqdf6WC6hf4MZL31LqZhqHxbCx/S2L36Xo3bf7dYhRMI5OBdOP2ovGv+
         UOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=KaTiX46BfLE12fhVgvPIixWb+ByqaTNtLnUIiRpJ4Zw=;
        b=egaASx5Isa25YTLH2LJgA9E/zzrVICYQhoea6ROQoYgr1zl9NtJxJdBanP9VBE8QJ7
         Tv4HPoNtkT2sG48h75I9H+8E49niy9aLejO9avJ7fK1INsBmdbdUejC0dzRf5sd+5LWs
         KHfI3HLN/GwgqGycr7FVFDeJYKiwNrWKHabX9X39dTWhAvCI84xgUNy8SjKYhz5MSLB+
         JJ+/KWRFk3CePhx1PWO9FQDLwn8/lKpTe1v82kO+5Q1F6+/A234LXJNf0R91iIpWbxuy
         0np00ZLgaHs0Xm0DbU8EMKMqIevVwA/YiGCn5sZuhvdyrlYLqW1hQdpgp/LtpdqIzgae
         EH+Q==
X-Gm-Message-State: AJIora9lpaAygWmuSzf0gE7TXSbbdf5sc3nOZmYIkYFSEs2uiD82+Wn/
        YD4Ko7S4uFMb47kM/TZIDUs=
X-Google-Smtp-Source: AGRyM1s775GHjwiLz8RqVuiodHvdjfu5yWdWA3P+HR5c477vNhFTeo9NFHwv4nD56wIioygy8NTu2A==
X-Received: by 2002:a17:907:2807:b0:72b:4530:29d5 with SMTP id eb7-20020a170907280700b0072b453029d5mr14292755ejc.69.1659383616519;
        Mon, 01 Aug 2022 12:53:36 -0700 (PDT)
Received: from krava ([83.240.62.89])
        by smtp.gmail.com with ESMTPSA id o21-20020a170906775500b0072f9dc2c246sm5469763ejn.133.2022.08.01.12.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 12:53:36 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 1 Aug 2022 21:53:34 +0200
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Andres Freund <andres@anarazel.de>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Ben Hutchings <benh@debian.org>
Subject: Re: [PATCH v3 0/8] tools: fix compilation failure caused by
 init_disassemble_info API changes
Message-ID: <YugvPgKszlWXN8RO@krava>
References: <20220622231624.t63bkmkzphqvh3kx@alap3.anarazel.de>
 <20220801013834.156015-1-andres@anarazel.de>
 <YufK0qnvVWCAFGEH@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YufK0qnvVWCAFGEH@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 01, 2022 at 09:45:06AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Sun, Jul 31, 2022 at 06:38:26PM -0700, Andres Freund escreveu:
> > binutils changed the signature of init_disassemble_info(), which now causes
> > compilation failures for tools/{perf,bpf} on e.g. debian unstable. Relevant
> > binutils commit:
> > https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=60a3da00bd5407f07
> > 
> > I first fixed this without introducing the compat header, as suggested by
> > Quentin, but I thought the amount of repeated boilerplate was a bit too
> > much. So instead I introduced a compat header to wrap the API changes. Even
> > tools/bpf/bpftool/jit_disasm.c, which needs its own callbacks for json, imo
> > looks nicer this way.
> > 
> > I'm not regular contributor, so it very well might be my procedures are a
> > bit off...
> > 
> > I am not sure I added the right [number of] people to CC?
> 
> I think its ok
>  
> > WRT the feature test: Not sure what the point of the -DPACKAGE='"perf"' is,
> 
> I think its related to libbfd, and it comes from a long time ago, trying
> to find the cset adding that...
> 
> > nor why tools/perf/Makefile.config sets some LDFLAGS/CFLAGS that are also
> > in feature/Makefile and why -ldl isn't needed in the other places. But...
> > 
> > V2:
> > - split patches further, so that tools/bpf and tools/perf part are entirely
> >   separate
> 
> Cool, thanks, I'll process the first 4 patches, then at some point the
> bpftool bits can be merged, alternatively I can process those as well if
> the bpftool maintainers are ok with it.
> 
> I'll just wait a bit to see if Jiri and others have something to say.

looks good

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> 
> - Arnaldo
> 
> > - included a bit more information about tests I did in commit messages
> > - add a maybe_unused to fprintf_json_styled's style argument
> > 
> > V3:
> > - don't include dis-asm-compat.h when building without libbfd
> >   (Ben Hutchings)
> > - don't include compiler.h in dis-asm-compat.h, use (void) casts instead,
> >   to avoid compiler.h include due to potential licensing conflict
> > - dual-license dis-asm-compat.h, for better compatibility with the rest of
> >   bpftool's code (suggested by Quentin Monnet)
> > - don't display feature-disassembler-init-styled test
> >   (suggested by Jiri Olsa)
> > - don't display feature-disassembler-four-args test, I split this for the
> >   different subsystems, but maybe that's overkill? (suggested by Jiri Olsa)
> > 
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Sedat Dilek <sedat.dilek@gmail.com>
> > Cc: Quentin Monnet <quentin@isovalent.com>
> > CC: Ben Hutchings <benh@debian.org>
> > Cc: bpf@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Link: https://lore.kernel.org/lkml/20220622181918.ykrs5rsnmx3og4sv@alap3.anarazel.de
> > Link: https://lore.kernel.org/lkml/CA+icZUVpr8ZeOKCj4zMMqbFT013KJz2T1csvXg+VSkdvJH1Ubw@mail.gmail.com
> > 
> > Andres Freund (8):
> >   tools build: Add feature test for init_disassemble_info API changes
> >   tools build: Don't display disassembler-four-args feature test
> >   tools include: add dis-asm-compat.h to handle version differences
> >   tools perf: Fix compilation error with new binutils
> >   tools bpf_jit_disasm: Fix compilation error with new binutils
> >   tools bpf_jit_disasm: Don't display disassembler-four-args feature
> >     test
> >   tools bpftool: Fix compilation error with new binutils
> >   tools bpftool: Don't display disassembler-four-args feature test
> > 
> >  tools/bpf/Makefile                            |  7 ++-
> >  tools/bpf/bpf_jit_disasm.c                    |  5 +-
> >  tools/bpf/bpftool/Makefile                    |  8 ++-
> >  tools/bpf/bpftool/jit_disasm.c                | 42 +++++++++++---
> >  tools/build/Makefile.feature                  |  4 +-
> >  tools/build/feature/Makefile                  |  4 ++
> >  tools/build/feature/test-all.c                |  4 ++
> >  .../feature/test-disassembler-init-styled.c   | 13 +++++
> >  tools/include/tools/dis-asm-compat.h          | 55 +++++++++++++++++++
> >  tools/perf/Makefile.config                    |  8 +++
> >  tools/perf/util/annotate.c                    |  7 ++-
> >  11 files changed, 138 insertions(+), 19 deletions(-)
> >  create mode 100644 tools/build/feature/test-disassembler-init-styled.c
> >  create mode 100644 tools/include/tools/dis-asm-compat.h
> > 
> > -- 
> > 2.37.0.3.g30cc8d0f14
> 
> -- 
> 
> - Arnaldo
