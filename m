Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC65469BA72
	for <lists+bpf@lfdr.de>; Sat, 18 Feb 2023 15:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjBROiD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 18 Feb 2023 09:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBROiC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 18 Feb 2023 09:38:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B5813D7F
        for <bpf@vger.kernel.org>; Sat, 18 Feb 2023 06:38:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B8C260BA0
        for <bpf@vger.kernel.org>; Sat, 18 Feb 2023 14:38:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42AC3C433EF;
        Sat, 18 Feb 2023 14:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676731080;
        bh=frj/8mFetQb3wvKg17YYvz6OABajCqoXz5DjnU/QZfc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jhbS+mNCRfM3npwH0TCBNYELTYVJwlQKfIzpry51o/eKZosT/tIPUPoeSpRxVxMfU
         2rdY99LNvNjmZl9S4kCl6k3+qvLrqgba0TeciMze85au7RKJdTJZkkFToZVoDGHo6A
         3bHTHuCVPUv7os+a2ZyDUKiY1J7I9khtvMKfg/npVfV2I5IbmLf9dNI8s/a55Jv1Q6
         b3IPdqSXohhpKgVBVrFUX66uGJCfCaqij1fSI5K/2L0HFU4EbvUP9sUb4wpbwzzYhA
         XwCTbGBzxOH8wTbAuKxaxmztE8iHM6dhOheQdFNb7ZKDTBY3MYujk18tuc5NzIWSIf
         vZtt9blJ+2Lrw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8A24340025; Sat, 18 Feb 2023 11:37:57 -0300 (-03)
Date:   Sat, 18 Feb 2023 11:37:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     olsajiri@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, yhs@fb.com, eddyz87@gmail.com,
        sinquersw@gmail.com, timo@incline.eu, songliubraving@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org, sdf@google.com,
        haoluo@google.com, martin.lau@kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC dwarves 0/4] dwarves: change BTF encoding skip logic for
 functions
Message-ID: <Y/DixRUF9SG+ORw5@kernel.org>
References: <1676675433-10583-1-git-send-email-alan.maguire@oracle.com>
 <Y/Dc4hX5utdyZ+mN@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/Dc4hX5utdyZ+mN@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Sat, Feb 18, 2023 at 11:12:50AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Feb 17, 2023 at 11:10:29PM +0000, Alan Maguire escreveu:
> > It has been observed [1] that the recent dwarves changes
> > that skip BTF encoding for functions that have optimized-out
> > parameters are too aggressive, leading to missing kfuncs
> > which generate warnings and a BPF selftest failure.
> > 
> > Here a different approach is used; we observe that
> > just because a function does not _use_ a parameter,
> > it does not mean it was not passed to it.  What we
> > are really keen to detect are cases where the calling
> > conventions are violated such that a function will
> > not have parameter values in the expected registers.
> > In such cases, tracing and kfunc behaviour will be
> > unstable.  We are not worried about parameters being
> > optimized out, provided that optimization does not
> > lead to other parameters being passed via
> > unexpected registers.
> > 
> > So this series attempts to detect such cases by
> > examining register (DW_OP_regX) values for
> > parameters where available; if these match
> > expectations, the function is deemed safe to add to
> > BTF, even if parameters are optimized out.
> > 
> > Using this approach, the only functions that
> > BTF generation is suppressed for are
> > 
> > 1. those with parameters that violate calling
> >    conventions where present; and
> > 2. those which have multiple inconsistent prototypes.
> 
> This sounds sensible at first sight, I've applied the patches so that it
> can go thru further testing on the libbpf CI, for now its just on the
> 'next' branch, the testing I did so far:
> 
> make allmodconfig + enablig BTF on bpf-next reverting that revert so
> that we use the new options,
> 
> Now I'm building and booting a kernel with a fedora-ish config without
> using the new options and then with them (reverting the revert) to
> compare the tools/testing/selftests/bpf/ ./test-progs output
> before/after.

-Summary: 274/1609 PASSED, 24 SKIPPED, 17 FAILED
+Summary: 276/1612 PASSED, 24 SKIPPED, 15 FAILED

Well, we're passing _more_ tests :-)

And no messages about that kernel module, etc. Will redo with clang as
time permits.

- Arnaldo
 
> Its an extended holiday down here, so I'll be spotty but want to get
> this moving forward,
> 
> Thanks!
> 
> - Arnaldo
>  
> > With these changes, running pahole on a gcc-built
> > vmlinux skips
> > 
> > - 1164 functions due to multiple inconsistent function
> >   prototypes.  Most of these are "."-suffixed optimized
> >   fuctions.
> > - 331 functions due to unexpected register usage
> > 
> > For a clang-built kernel, the numbers are
> > 
> > - 539 functions with inconsistent prototypes are skipped
> > - 209 functions with unexpected register usage are skipped
> > 
> > One complication is that functions that are passed
> > structs (or typedef structs) can use multiple registers
> > to pass those structures.  Examples include
> > bpf_lsm_socket_getpeersec_stream() (passing a typedef
> > struct sockptr_t) and the bpf_testmod_test_struct_arg_1
> > function in bpf_testmod.  Because multiple registers
> > are used to represent the structure, this throws
> > off expectations for any subsequent parameter->register
> > mappings.  To handle this, simply exempt functions
> > that have struct (or typedef struct) parameters from
> > our register checks.
> > 
> > Note to test this series on bpf-next, the following
> > commit should be reverted (reverting the revert
> > so that the flags are added to BTF encoding when
> > using pahole v1.25):
> > 
> > commit 1f5dfcc78ab4 ("Revert "bpf: Add --skip_encoding_btf_inconsistent_proto, --btf_gen_optimized to pahole flags for v1.25"")
> > 
> > With these changes we also see tracing_struct now pass:
> > 
> > $ sudo ./test_progs -t tracing_struct
> > #233     tracing_struct:OK
> > Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> > 
> > Further testing is needed - along with support for additional
> > parameter index -> DWARF reg for more platforms.
> > 
> > Future work could also add annotations for optimized-out
> > parameters via BTF tags to help guide tracing.
> > 
> > [1] https://lore.kernel.org/bpf/CAADnVQ+hfQ9LEmEFXneB7hm17NvRniXSShrHLaM-1BrguLjLQw@mail.gmail.com/
> > 
> > Alan Maguire (4):
> >   dwarf_loader: mark functions that do not use expected registers for
> >     params
> >   btf_encoder: exclude functions with unexpected param register use not
> >     optimizations
> >   pahole: update descriptions for btf_gen_optimized,
> >     skip_encoding_btf_inconsistent_proto
> >   pahole: update man page for options also
> > 
> >  btf_encoder.c      |  24 +++++++---
> >  dwarf_loader.c     | 109 ++++++++++++++++++++++++++++++++++++++++++---
> >  dwarves.h          |   5 +++
> >  man-pages/pahole.1 |   4 +-
> >  pahole.c           |   4 +-
> >  5 files changed, 129 insertions(+), 17 deletions(-)
> > 
> > -- 
> > 2.31.1
> > 
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
