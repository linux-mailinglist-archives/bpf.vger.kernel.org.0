Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A65586B54
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 14:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbiHAMvH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 08:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235213AbiHAMup (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 08:50:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12716265;
        Mon,  1 Aug 2022 05:45:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B19F611BE;
        Mon,  1 Aug 2022 12:45:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873D6C433D6;
        Mon,  1 Aug 2022 12:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659357908;
        bh=Mc2vruz/cB/8iqIyaO03cgBU0b00xV7wxmZfNOX+iv4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S3hrNrAU1uLgrrCjxzSQg6di2sKbtff1vZU/5Nq/T2s5rV5tkRSoE8XqM2hfXc8jd
         X1A/3bEQcyVI2jFsPXvy6GlNX3L3NDuHfQ6dlH5N/DiMnMtkVy5dMBofEVP7HshBHD
         HvCKfePFn2SydbRr8+hYqrqJ+Elv/2A+f/ShYczqSaoIYe7+nKA+iEeYpRwwfnf87w
         jiU7rRj93FEP2q8Ju+kahrCgi2RKiqlTD2j2nVRD5eriHVOL3Dh2KDEe6cCFA0Ftbn
         8OhI6r2DQGQ3k7xh3jP21KO5oSh/vcEEnZajvntdpuCfhv1eWo0rZCJZESYaHGZwd1
         9kSduAAnJryng==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1CCD240736; Mon,  1 Aug 2022 09:45:06 -0300 (-03)
Date:   Mon, 1 Aug 2022 09:45:06 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andres Freund <andres@anarazel.de>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Ben Hutchings <benh@debian.org>
Subject: Re: [PATCH v3 0/8] tools: fix compilation failure caused by
 init_disassemble_info API changes
Message-ID: <YufK0qnvVWCAFGEH@kernel.org>
References: <20220622231624.t63bkmkzphqvh3kx@alap3.anarazel.de>
 <20220801013834.156015-1-andres@anarazel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801013834.156015-1-andres@anarazel.de>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Sun, Jul 31, 2022 at 06:38:26PM -0700, Andres Freund escreveu:
> binutils changed the signature of init_disassemble_info(), which now causes
> compilation failures for tools/{perf,bpf} on e.g. debian unstable. Relevant
> binutils commit:
> https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=60a3da00bd5407f07
> 
> I first fixed this without introducing the compat header, as suggested by
> Quentin, but I thought the amount of repeated boilerplate was a bit too
> much. So instead I introduced a compat header to wrap the API changes. Even
> tools/bpf/bpftool/jit_disasm.c, which needs its own callbacks for json, imo
> looks nicer this way.
> 
> I'm not regular contributor, so it very well might be my procedures are a
> bit off...
> 
> I am not sure I added the right [number of] people to CC?

I think its ok
 
> WRT the feature test: Not sure what the point of the -DPACKAGE='"perf"' is,

I think its related to libbfd, and it comes from a long time ago, trying
to find the cset adding that...

> nor why tools/perf/Makefile.config sets some LDFLAGS/CFLAGS that are also
> in feature/Makefile and why -ldl isn't needed in the other places. But...
> 
> V2:
> - split patches further, so that tools/bpf and tools/perf part are entirely
>   separate

Cool, thanks, I'll process the first 4 patches, then at some point the
bpftool bits can be merged, alternatively I can process those as well if
the bpftool maintainers are ok with it.

I'll just wait a bit to see if Jiri and others have something to say.

- Arnaldo

> - included a bit more information about tests I did in commit messages
> - add a maybe_unused to fprintf_json_styled's style argument
> 
> V3:
> - don't include dis-asm-compat.h when building without libbfd
>   (Ben Hutchings)
> - don't include compiler.h in dis-asm-compat.h, use (void) casts instead,
>   to avoid compiler.h include due to potential licensing conflict
> - dual-license dis-asm-compat.h, for better compatibility with the rest of
>   bpftool's code (suggested by Quentin Monnet)
> - don't display feature-disassembler-init-styled test
>   (suggested by Jiri Olsa)
> - don't display feature-disassembler-four-args test, I split this for the
>   different subsystems, but maybe that's overkill? (suggested by Jiri Olsa)
> 
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Sedat Dilek <sedat.dilek@gmail.com>
> Cc: Quentin Monnet <quentin@isovalent.com>
> CC: Ben Hutchings <benh@debian.org>
> Cc: bpf@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Link: https://lore.kernel.org/lkml/20220622181918.ykrs5rsnmx3og4sv@alap3.anarazel.de
> Link: https://lore.kernel.org/lkml/CA+icZUVpr8ZeOKCj4zMMqbFT013KJz2T1csvXg+VSkdvJH1Ubw@mail.gmail.com
> 
> Andres Freund (8):
>   tools build: Add feature test for init_disassemble_info API changes
>   tools build: Don't display disassembler-four-args feature test
>   tools include: add dis-asm-compat.h to handle version differences
>   tools perf: Fix compilation error with new binutils
>   tools bpf_jit_disasm: Fix compilation error with new binutils
>   tools bpf_jit_disasm: Don't display disassembler-four-args feature
>     test
>   tools bpftool: Fix compilation error with new binutils
>   tools bpftool: Don't display disassembler-four-args feature test
> 
>  tools/bpf/Makefile                            |  7 ++-
>  tools/bpf/bpf_jit_disasm.c                    |  5 +-
>  tools/bpf/bpftool/Makefile                    |  8 ++-
>  tools/bpf/bpftool/jit_disasm.c                | 42 +++++++++++---
>  tools/build/Makefile.feature                  |  4 +-
>  tools/build/feature/Makefile                  |  4 ++
>  tools/build/feature/test-all.c                |  4 ++
>  .../feature/test-disassembler-init-styled.c   | 13 +++++
>  tools/include/tools/dis-asm-compat.h          | 55 +++++++++++++++++++
>  tools/perf/Makefile.config                    |  8 +++
>  tools/perf/util/annotate.c                    |  7 ++-
>  11 files changed, 138 insertions(+), 19 deletions(-)
>  create mode 100644 tools/build/feature/test-disassembler-init-styled.c
>  create mode 100644 tools/include/tools/dis-asm-compat.h
> 
> -- 
> 2.37.0.3.g30cc8d0f14

-- 

- Arnaldo
