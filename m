Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D4858705E
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 20:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbiHAS13 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 14:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbiHAS12 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 14:27:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E99CE0CC;
        Mon,  1 Aug 2022 11:27:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C21F8B81624;
        Mon,  1 Aug 2022 18:27:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 381F7C433D6;
        Mon,  1 Aug 2022 18:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659378444;
        bh=lKHW58KgYMzK7Rq1aOCnUEZiymJ5B8BDJi2U/YMRZ9w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=snqKwHPyhEgb0+A3DFTRD9hgrZfYJwK+uF+bGKQb5VjuSDK2EeHjHySrSmq0BT3fT
         y2LIaya90vxIBQjdR4ahNTgy+nfBHWySEXHnfyN5nghQllPdL89HIViABzXZTUowwN
         fU/a8AopJ5rWSL9fHuip+pPvt9nm73fz3byWbRPFoBpgOYtEOwl1Yczfko5f2kH42r
         hXqF8wL2e7tbMBe+bMK9w52pw/LpBBT/8zl55tzRvsPdTTzO+sJ4wGqLL8dv8bFTx6
         euXfzmIdPLAXbFsPV0lbcMuHxbQHlHk1x3ur7LdGB+OaUoSC7ctbuqAb920hTkUuQ8
         MPQV5MdtNehHQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1468440736; Mon,  1 Aug 2022 15:27:22 -0300 (-03)
Date:   Mon, 1 Aug 2022 15:27:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andres Freund <andres@anarazel.de>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Ben Hutchings <benh@debian.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH v3 6/8] tools bpf_jit_disasm: Don't display
 disassembler-four-args feature test
Message-ID: <YugbCvWlwSap23UB@kernel.org>
References: <20220622231624.t63bkmkzphqvh3kx@alap3.anarazel.de>
 <20220801013834.156015-1-andres@anarazel.de>
 <20220801013834.156015-7-andres@anarazel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220801013834.156015-7-andres@anarazel.de>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Sun, Jul 31, 2022 at 06:38:32PM -0700, Andres Freund escreveu:
> The feature check does not seem important enough to display. Suggested by
> Jiri Olsa.
> 
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Sedat Dilek <sedat.dilek@gmail.com>
> Cc: Quentin Monnet <quentin@isovalent.com>
> Link: http://lore.kernel.org/lkml/20220622181918.ykrs5rsnmx3og4sv@alap3.anarazel.de
> Signed-off-by: Andres Freund <andres@anarazel.de>
> ---
>  tools/bpf/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/Makefile b/tools/bpf/Makefile
> index 664601ab1705..243b79f2b451 100644
> --- a/tools/bpf/Makefile
> +++ b/tools/bpf/Makefile
> @@ -35,7 +35,7 @@ endif
>  
>  FEATURE_USER = .bpf
>  FEATURE_TESTS = libbfd disassembler-four-args disassembler-init-styled
> -FEATURE_DISPLAY = libbfd disassembler-four-args
> +FEATURE_DISPLAY = libbfd
>  
>  check_feat := 1
>  NON_CHECK_FEAT_TARGETS := clean bpftool_clean runqslower_clean resolve_btfids_clean
> -- 
> 2.37.0.3.g30cc8d0f14

After this patch:

⬢[acme@toolbox perf]$ git log --oneline -7
cebe4f3a4a0af5bf (HEAD) tools bpf_jit_disasm: Don't display disassembler-four-args feature test
7f62593e5582cb27 tools bpf_jit_disasm: Fix compilation error with new binutils
ee4dc290ee5c09b7 tools perf: Fix compilation error with new binutils
335f8d183a609793 tools include: add dis-asm-compat.h to handle version differences
f2f95e8d0def9c5f tools build: Don't display disassembler-four-args feature test
ede0fece841bb743 tools build: Add feature test for init_disassemble_info API changes
00b32625982e0c79 perf test: Add ARM SPE system wide test
⬢[acme@toolbox perf]$

⬢[acme@toolbox perf]$ make -C tools/bpf/bpftool/ clean
make: Entering directory '/var/home/acme/git/perf/tools/bpf/bpftool'
  CLEAN   libbpf
  CLEAN   libbpf-bootstrap
  CLEAN   feature-detect
  CLEAN   bpftool
  CLEAN   core-gen
make: Leaving directory '/var/home/acme/git/perf/tools/bpf/bpftool'
⬢[acme@toolbox perf]$ make -C tools/bpf/bpftool/
make: Entering directory '/var/home/acme/git/perf/tools/bpf/bpftool'

Auto-detecting system features:
...                        libbfd: [ on  ]
...        disassembler-four-args: [ on  ]
...                          zlib: [ on  ]
...                        libcap: [ on  ]
...               clang-bpf-co-re: [ on  ]
<SNIP>

It is still there, we need the hunk below, that I folded into your patch, to
disable it, please ack :-)

- Arnaldo

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index c6d2c77d02524a37..a92fb4d312ec2363 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -95,7 +95,7 @@ RM ?= rm -f
 FEATURE_USER = .bpftool
 FEATURE_TESTS = libbfd disassembler-four-args zlib libcap \
 	clang-bpf-co-re
-FEATURE_DISPLAY = libbfd disassembler-four-args zlib libcap \
+FEATURE_DISPLAY = libbfd zlib libcap \
 	clang-bpf-co-re
 
 check_feat := 1
