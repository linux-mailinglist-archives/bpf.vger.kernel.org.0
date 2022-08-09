Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F6758DB03
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 17:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243173AbiHIPVj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 11:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244866AbiHIPVW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 11:21:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22145DF8;
        Tue,  9 Aug 2022 08:21:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB54EB812A1;
        Tue,  9 Aug 2022 15:21:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47BEBC433D6;
        Tue,  9 Aug 2022 15:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660058478;
        bh=QdIXELd2CkFV47UtpgDg60Cn8MPrEGSNTDM5L4nMVaM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bib2QomNTOnSYhOqg3FOlmGw1OXqMNx1c5eY1Gvi550ot2tfMkDVSIRdRWg98sgf0
         aHq+y2TsJWEcUG5bdPXeOQmPV300/tV9V30a7ZOQhM69TBjWJYijy0YgxalDcvOeH0
         VidjCldHTnS29NrNPnWe1nMAAyxu6Z1y5p9UpUO+IyFyIW2p0wGf2XhZqITcgct9gn
         DTj4HFH6E3wlaWOeWdcry3zuQTJ46iApGKbdTmMSX55iMFOGPb0/PCCD0bWu/MC/6+
         6ON/faUBPr5VMLBSrqZrO1Em/dIW9+gAHSKZhmN/A3Yw8v/4cR7UtaI1InA0ww2Zic
         rIH+c6+o7FJ8w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A5D8E4035A; Tue,  9 Aug 2022 12:21:15 -0300 (-03)
Date:   Tue, 9 Aug 2022 12:21:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        Andres Freund <andres@anarazel.de>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     quentin@isovalent.com, ast@kernel.org, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, peterz@infradead.org,
        mingo@redhat.com, terrelln@fb.com, nathan@kernel.org,
        ndesaulniers@google.com, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH 4/4] build: Switch to new openssl API for test-libcrypto
Message-ID: <YvJ7awkCVBYaZ2dd@kernel.org>
References: <20220719170555.2576993-1-roberto.sassu@huawei.com>
 <20220719170555.2576993-4-roberto.sassu@huawei.com>
 <5f867295-10d2-0085-d1dc-051f56e7136a@iogearbox.net>
 <YvFW/kBL6YA3Tlnc@kernel.org>
 <YvJ6DbzBNsAgNZS4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvJ6DbzBNsAgNZS4@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Aug 09, 2022 at 12:15:25PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Aug 08, 2022 at 03:33:34PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Mon, Aug 08, 2022 at 06:14:48PM +0200, Daniel Borkmann escreveu:
> > > Hi Arnaldo,
> > > 
> > > On 7/19/22 7:05 PM, Roberto Sassu wrote:
> > > > Switch to new EVP API for detecting libcrypto, as Fedora 36 returns an
> > > > error when it encounters the deprecated function MD5_Init() and the others.
> > > > The error would be interpreted as missing libcrypto, while in reality it is
> > > > not.
> > > > 
> > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > 
> > > Given rest of the tooling fixes from Andres Freund went via perf tree and the
> > > below is perf related as well, I presume you'll pick this up, too?
> > 
> > Sure.
> >  
> > >   [0] https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=perf/core
> 
> So I fixed up the first one, minor fuzzes, the second I had to fix
> conflicts with the patchset from Andres, ended up as below, will test
> build it then in my container kit.

So I backtracked, the way it works needs further consideration with
regard to the patchkit from Andres, that is already upstream, so it
would be good for Roberto to take a look at what is in torvalds/master
now and see if we have to removed that styled thing from Andres.

Andres, if you could take a look at Roberto's patchkit as well that
would be great.

- Arnaldo
 
> commit bea955a0256e20cc18e87087e42f2a903b9a8b84
> Author: Roberto Sassu <roberto.sassu@huawei.com>
> Date:   Tue Jul 19 19:05:53 2022 +0200
> 
>     bpftool: Complete libbfd feature detection
>     
>     Commit 6e8ccb4f624a7 ("tools/bpf: properly account for libbfd variations")
>     sets the linking flags depending on which flavor of the libbfd feature was
>     detected.
>     
>     However, the flavors except libbfd cannot be detected, as they are not in
>     the feature list.
>     
>     Complete the list of features to detect by adding libbfd-liberty and
>     libbfd-liberty-z.
>     
>     Committer notes:
>     
>     Adjust conflict with with:
>     
>       1e1613f64cc8a09d ("tools bpftool: Don't display disassembler-four-args feature test")
>       600b7b26c07a070d ("tools bpftool: Fix compilation error with new binutils")
>     
>     Fixes: 6e8ccb4f624a73c5 ("tools/bpf: properly account for libbfd variations")
>     Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>     Cc: Alexei Starovoitov <ast@kernel.org>
>     Cc: Andres Freund <andres@anarazel.de>
>     Cc: Andrii Nakryiko <andrii@kernel.org>
>     Cc: bpf@vger.kernel.org
>     Cc: Daniel Borkmann <daniel@iogearbox.net>
>     Cc: Ingo Molnar <mingo@redhat.com>
>     Cc: John Fastabend <john.fastabend@gmail.com>
>     Cc: KP Singh <kpsingh@kernel.org>
>     Cc: llvm@lists.linux.dev
>     Cc: Martin KaFai Lau <martin.lau@linux.dev>
>     Cc: Nathan Chancellor <nathan@kernel.org>
>     Cc: Nick Desaulniers <ndesaulniers@google.com>
>     Cc: Nick Terrell <terrelln@fb.com>
>     Cc: Peter Zijlstra <peterz@infradead.org>
>     Cc: Quentin Monnet <quentin@isovalent.com>
>     Cc: Song Liu <song@kernel.org>
>     Cc: Stanislav Fomichev <sdf@google.com>
>     Link: https://lore.kernel.org/r/20220719170555.2576993-2-roberto.sassu@huawei.com
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index 04d733e98bffbc08..9cc132277150c534 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -93,9 +93,11 @@ INSTALL ?= install
>  RM ?= rm -f
>  
>  FEATURE_USER = .bpftool
> -FEATURE_TESTS = libbfd disassembler-four-args disassembler-init-styled libcap \
> +FEATURE_TESTS = libbfd libbfd-liberty libbfd-liberty-z
> +	disassembler-four-args disassembler-init-styled libcap \
>  	clang-bpf-co-re
> -FEATURE_DISPLAY = libbfd libcap clang-bpf-co-re
> +FEATURE_DISPLAY = libbfd libbfd-liberty libbfd-liberty-z
> +	libcap clang-bpf-co-re
>  
>  check_feat := 1
>  NON_CHECK_FEAT_TARGETS := clean uninstall doc doc-clean doc-install doc-uninstall

-- 

- Arnaldo
