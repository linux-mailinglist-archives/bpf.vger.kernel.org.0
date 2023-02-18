Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3C369BA5C
	for <lists+bpf@lfdr.de>; Sat, 18 Feb 2023 15:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjBRONA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 18 Feb 2023 09:13:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjBROM7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 18 Feb 2023 09:12:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD497EEB
        for <bpf@vger.kernel.org>; Sat, 18 Feb 2023 06:12:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7770C60B95
        for <bpf@vger.kernel.org>; Sat, 18 Feb 2023 14:12:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1CE6C433EF;
        Sat, 18 Feb 2023 14:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676729572;
        bh=nkXuxvEQgHW8BVDu0oJUZZe3vO3ms4YAGjZxHTeTxtI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pv/3/DtxzPfafzVWjYzeBiEmGd36XrBpOqi58EDuvluX3kAwsu0TjeWkLcNtpIP0v
         JPLrkk516g47o9a7W9RQX7jiIlPl+XPCGCzutbNmwJ1P2PCNmmrSXXvy6dDoDKL/4o
         xf14trV972Ne4ZovO8f4yTIfJafazSAPRUOiSWBx0ddGr83cyHgmLiC3c7mjOinlNZ
         UugJGezxgR8jhryK4J99xp2f0ris/xXQX1zl6mPJiY19nB7fMPHn4CP6WHh09m8mqO
         UkCEeenMdHhW/n2mbdZDvQFyz2Q3HpqwPoq0iTaqQ+iRfsKmxKVqQf6cLtP2Wz3CDm
         o0eIvz+ohobYw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6804340025; Sat, 18 Feb 2023 11:12:50 -0300 (-03)
Date:   Sat, 18 Feb 2023 11:12:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     olsajiri@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, yhs@fb.com, eddyz87@gmail.com,
        sinquersw@gmail.com, timo@incline.eu, songliubraving@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org, sdf@google.com,
        haoluo@google.com, martin.lau@kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC dwarves 0/4] dwarves: change BTF encoding skip logic for
 functions
Message-ID: <Y/Dc4hX5utdyZ+mN@kernel.org>
References: <1676675433-10583-1-git-send-email-alan.maguire@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1676675433-10583-1-git-send-email-alan.maguire@oracle.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Feb 17, 2023 at 11:10:29PM +0000, Alan Maguire escreveu:
> It has been observed [1] that the recent dwarves changes
> that skip BTF encoding for functions that have optimized-out
> parameters are too aggressive, leading to missing kfuncs
> which generate warnings and a BPF selftest failure.
> 
> Here a different approach is used; we observe that
> just because a function does not _use_ a parameter,
> it does not mean it was not passed to it.  What we
> are really keen to detect are cases where the calling
> conventions are violated such that a function will
> not have parameter values in the expected registers.
> In such cases, tracing and kfunc behaviour will be
> unstable.  We are not worried about parameters being
> optimized out, provided that optimization does not
> lead to other parameters being passed via
> unexpected registers.
> 
> So this series attempts to detect such cases by
> examining register (DW_OP_regX) values for
> parameters where available; if these match
> expectations, the function is deemed safe to add to
> BTF, even if parameters are optimized out.
> 
> Using this approach, the only functions that
> BTF generation is suppressed for are
> 
> 1. those with parameters that violate calling
>    conventions where present; and
> 2. those which have multiple inconsistent prototypes.

This sounds sensible at first sight, I've applied the patches so that it
can go thru further testing on the libbpf CI, for now its just on the
'next' branch, the testing I did so far:

make allmodconfig + enablig BTF on bpf-next reverting that revert so
that we use the new options,

Now I'm building and booting a kernel with a fedora-ish config without
using the new options and then with them (reverting the revert) to
compare the tools/testing/selftests/bpf/ ./test-progs output
before/after.

Its an extended holiday down here, so I'll be spotty but want to get
this moving forward,

Thanks!

- Arnaldo
 
> With these changes, running pahole on a gcc-built
> vmlinux skips
> 
> - 1164 functions due to multiple inconsistent function
>   prototypes.  Most of these are "."-suffixed optimized
>   fuctions.
> - 331 functions due to unexpected register usage
> 
> For a clang-built kernel, the numbers are
> 
> - 539 functions with inconsistent prototypes are skipped
> - 209 functions with unexpected register usage are skipped
> 
> One complication is that functions that are passed
> structs (or typedef structs) can use multiple registers
> to pass those structures.  Examples include
> bpf_lsm_socket_getpeersec_stream() (passing a typedef
> struct sockptr_t) and the bpf_testmod_test_struct_arg_1
> function in bpf_testmod.  Because multiple registers
> are used to represent the structure, this throws
> off expectations for any subsequent parameter->register
> mappings.  To handle this, simply exempt functions
> that have struct (or typedef struct) parameters from
> our register checks.
> 
> Note to test this series on bpf-next, the following
> commit should be reverted (reverting the revert
> so that the flags are added to BTF encoding when
> using pahole v1.25):
> 
> commit 1f5dfcc78ab4 ("Revert "bpf: Add --skip_encoding_btf_inconsistent_proto, --btf_gen_optimized to pahole flags for v1.25"")
> 
> With these changes we also see tracing_struct now pass:
> 
> $ sudo ./test_progs -t tracing_struct
> #233     tracing_struct:OK
> Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> 
> Further testing is needed - along with support for additional
> parameter index -> DWARF reg for more platforms.
> 
> Future work could also add annotations for optimized-out
> parameters via BTF tags to help guide tracing.
> 
> [1] https://lore.kernel.org/bpf/CAADnVQ+hfQ9LEmEFXneB7hm17NvRniXSShrHLaM-1BrguLjLQw@mail.gmail.com/
> 
> Alan Maguire (4):
>   dwarf_loader: mark functions that do not use expected registers for
>     params
>   btf_encoder: exclude functions with unexpected param register use not
>     optimizations
>   pahole: update descriptions for btf_gen_optimized,
>     skip_encoding_btf_inconsistent_proto
>   pahole: update man page for options also
> 
>  btf_encoder.c      |  24 +++++++---
>  dwarf_loader.c     | 109 ++++++++++++++++++++++++++++++++++++++++++---
>  dwarves.h          |   5 +++
>  man-pages/pahole.1 |   4 +-
>  pahole.c           |   4 +-
>  5 files changed, 129 insertions(+), 17 deletions(-)
> 
> -- 
> 2.31.1
> 

-- 

- Arnaldo
