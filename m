Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698D068F3C7
	for <lists+bpf@lfdr.de>; Wed,  8 Feb 2023 17:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjBHQug (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 11:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjBHQuf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 11:50:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C81046D73
        for <bpf@vger.kernel.org>; Wed,  8 Feb 2023 08:50:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43635B81C76
        for <bpf@vger.kernel.org>; Wed,  8 Feb 2023 16:50:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8286CC4339B;
        Wed,  8 Feb 2023 16:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675875030;
        bh=ZUuLxzxCcMHGicdfj5nU+byxfMtoDCyLdEBAXt/JV7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MEgAmyCPJgUNkPX6Cp7FHkFwLryX91j1Q1f5cWJYnP6+waK6FiXqdQEfz7f2YfdWb
         KuplvASMx9UyD2et3nNIuYrhvu5lQpHt8EXScgs6b4Ay+ThnoJPLk7tYxcyZiRUbn6
         bMHAtmPULJg6jGD39XidLge1qbtK9D4llDLLSDAcVXJsneAtHFLOPHMVioC5/UkGLO
         K3HHN323Ik3Qs7+IP0rb/4NsQ8OX7l0rb1De5HggTm+ERrr73KFD63d6iq08bo9fFY
         5uXKEmfplrVeTJ3FedCPdGttU1o6C4EczRV8wo/VtxLA1aHEVMm9JaDBNODWD/wOxZ
         YRbK/ehPTQ/DA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E0008405BE; Wed,  8 Feb 2023 13:50:27 -0300 (-03)
Date:   Wed, 8 Feb 2023 13:50:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        eddyz87@gmail.com, haoluo@google.com, jolsa@kernel.org,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        sinquersw@gmail.com, martin.lau@kernel.org, songliubraving@fb.com,
        sdf@google.com, timo@incline.eu, yhs@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCH v3 dwarves 0/8] dwarves: support encoding of
 optimized-out parameters, removal of inconsistent static functions
Message-ID: <Y+PS01eC1i75nBM0@kernel.org>
References: <1675790102-23037-1-git-send-email-alan.maguire@oracle.com>
 <Y+PL18hvJ7WwncGR@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y+PL18hvJ7WwncGR@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Feb 08, 2023 at 01:20:39PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Feb 07, 2023 at 05:14:54PM +0000, Alan Maguire escreveu:
> > At optimization level -O2 or higher in gcc, static functions may be
> > optimized such that they have suffixes like .isra.0, .constprop.0 etc.
> > These represent 
> >     
> > - constant propagation (.constprop.0);
> > - interprocedural scalar replacement of aggregates, removal of
> >   unused parameters and replacement of parameters passed by
> >   reference by parameters passed by value (.isra.0)
> 
> Initial test, without using the new options:
> 
> [acme@pumpkin ~]$ pfunct /sys/kernel/btf/vmlinux  | sort | uniq -c | sort -n | tail
>       3 start_show
>       3 timeout_show
>       3 uuid_show
>       4 m_next
>       4 parse_options
>       4 sk_diag_fill
>       4 state_show
>       4 state_store
>       5 status_show
>       6 type_show
> [acme@pumpkin ~]$
> 
> Now I'll use --skip_encoding_btf_inconsistent_proto and --btf_gen_optimized

With:

⬢[acme@toolbox linux]$ git diff
diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
index 1f1f1d397c399afe..9dd185fb1ff1fc3b 100755
--- a/scripts/pahole-flags.sh
+++ b/scripts/pahole-flags.sh
@@ -21,7 +21,7 @@ if [ "${pahole_ver}" -ge "122" ]; then
 fi
 if [ "${pahole_ver}" -ge "124" ]; then
        # see PAHOLE_HAS_LANG_EXCLUDE
-       extra_paholeopt="${extra_paholeopt} --lang_exclude=rust"
+       extra_paholeopt="${extra_paholeopt} --lang_exclude=rust --btf_gen_optimized --skip_encoding_btf_inconsistent_proto"
 fi

 echo ${extra_paholeopt}
⬢[acme@toolbox linux]$

I get:

[acme@pumpkin ~]$ pfunct /sys/kernel/btf/vmlinux  | sort | uniq -c | sort -n | tail
      1 zswap_writeback_entry
      1 zswap_zpool_param_set
      1 zs_zpool_create
      1 zs_zpool_destroy
      1 zs_zpool_free
      1 zs_zpool_malloc
      1 zs_zpool_map
      1 zs_zpool_shrink
      1 zs_zpool_total_size
      1 zs_zpool_unmap
[acme@pumpkin ~]$

No functions with more than one entry:

[acme@pumpkin ~]$ pfunct /sys/kernel/btf/vmlinux  | sort | uniq -c | sort -n | grep -v ' 1 '
[acme@pumpkin ~]$ pfunct /sys/kernel/btf/vmlinux  | sort | uniq -c | sort -n | grep ' 1 ' | wc -l
54558
[acme@pumpkin ~]$ pfunct /sys/kernel/btf/vmlinux  | wc -l
54558
[acme@pumpkin ~]$

So I'll bump the release as we did in the past when testing features
that we need to test against a release on the pahole-flags.sh script so
that we can do further tests.

- Arnaldo
 
> - Arnaldo
>    
> > See [1] for details. 
> >     
> > Currently BTF encoding does not handle such optimized functions
> > that get renamed with a "." suffix such as ".isra.0", ".constprop.0".
> > This is safer because such suffixes can often indicate parameters have
> > been optimized out.  This series addresses this by matching a
> > function to a suffixed version ("foo" matching "foo.isra.0") while
> > ensuring that the function signature does not contain optimized-out
> > parameters.  Note that if the function is found ("foo") it will
> > be preferred, only falling back to "foo.isra.0" if lookup of the
> > function fails.  Addition to BTF is skipped if the function has
> > optimized-out parameters, since the expected function signature
> > will not match. BTF encoding does not include the "."-suffix to
> > be consistent with DWARF. In addition, the kernel currently does
> > not allow a "." suffix in a BTF function name.
> > 
> > A problem with this approach however is that BTF carries out the
> > encoding process in parallel across multiple CUs, and sometimes
> > a function has optimized-out parameters in one CU but not others;
> > we see this for NF_HOOK.constprop.0 for example.  So in order to
> > determine if the function has optimized-out parameters in any
> > CU, its addition is not carried out until we have processed all
> > CUs and are about to merge BTF.  At this point we know if any
> > such optimizations have occurred.  Patches 1-5 handle the
> > optimized-out parameter identification and matching "."-suffixed
> > functions with the original function to facilitate BTF
> > encoding.  This feature can be enabled via the
> > "--btf_gen_optimized" option.
> > 
> > Patch 6 addresses a related problem - it is entirely possible
> > for a static function of the same name to exist in different
> > CUs with different function signatures.  Because BTF does not
> > currently encode any information that would help disambiguate
> > which BTF function specification matches which static function
> > (in the case of multiple different function signatures), it is
> > best to eliminate such functions from BTF for now.  The same
> > mechanism that is used to compare static "."-suffixed functions
> > is re-used for the static function comparison.  A superficial
> > comparison of number of parameters/parameter names is done to
> > see if such representations are consistent, and if inconsistent
> > prototypes are observed, the function is flagged for exclusion
> > from BTF.
> > 
> > When these methods are combined - the additive encoding of
> > "."-suffixed functions and the subtractive elimination of
> > functions with inconsistent parameters - we see an overall
> > drop in the number of functions in vmlinux BTF, from
> > 51529 to 50246.  Skipping inconsistent functions is enabled
> > via "--skip_encoding_btf_inconsistent_proto".
> > 
> > Changes since v2 [2]
> > - Arnaldo incorporated some of the suggestions in the v2 thread;
> >   these patches are based on those; the relevant changes are
> >   noted as committer changes.
> > - Patch 1 is unchanged from v2, but the rest of the patches
> >   have been updated:
> > - Patch 2 separates out the changes to the struct btf_encoder
> >   that better support later addition of functions.
> > - Patch 3 then is changed insofar as these changes are no
> >   longer needed for the function addition refactoring.
> > - Patch 4 has a small change; we need to verify that an
> >   encoder has actually been added to the encoders list
> >   prior to removal
> > - Patch 5 changed significantly; when attempting to measure
> >   performance the relatively good numbers attained when using
> >   delayed function addition were not reproducible.
> >   Further analysis revealed that the large number of lookups
> >   caused by the presence of the separate function tree was
> >   a major cause of performance degradation in the multi
> >   threaded case.  So instead of maintaining a separate tree,
> >   we use the ELF function list which we already need to look
> >   up to match ELF -> DWARF function descriptions to store
> >   the function representation.  This has 2 benefits; firstly
> >   as mentioned, we already look up the ELF function so no
> >   additional lookup is required to save the function.
> >   Secondly, the ELF representation is identical for each
> >   encoder, so we can index the same function across multiple
> >   encoder function arrays - this greatly speeds up the
> >   processing of comparing function representations across
> >   encoders.  There is still a performance cost in this
> >   approach however; more details are provided in patch 6.
> >   An option specific to adding functions with "." suffixes
> >   is added "--btf_gen_optimized"
> > - Patch 6 builds on patch 5 in applying the save/merge/add
> >   approach for all functions using the same mechanisms.
> >   In addition the "--skip_encoding_btf_inconsistent_proto"
> >   option is introduced.
> > - Patches 7/8 document the new options in the pahole manual
> >   page.
> >   
> > Changes since v1 [3]
> > 
> > - Eduard noted that a DW_AT_const_value attribute can signal
> >   an optimized-out parameter, and that the lack of a location
> >   attribute signals optimization; ensure we handle those cases
> >   also (Eduard, patch 1).
> > - Jiri noted we can have inconsistencies between a static
> >   and non-static function; apply the comparison process to
> >   all functions (Jiri, patch 5)
> > - segmentation fault was observed when handling functions with
> >   > 10 parameters; needed parameter comparison loop to exit
> >   at BTF_ENCODER_MAX_PARAMETERS (patch 5)
> > - Kui-Feng Lee pointed out that having a global shared function
> >   tree would lead to a lot of contention; here a per-encoder 
> >   tree is used, and once the threads are collected the trees
> >   are merged. Performance numbers are provided in patch 5 
> >   (Kui-Feng Lee, patches 4/5)
> > 
> > [1] https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html
> > [2] https://lore.kernel.org/bpf/1675088985-20300-1-git-send-email-alan.maguire@oracle.com/
> > [3] https://lore.kernel.org/bpf/1674567931-26458-1-git-send-email-alan.maguire@oracle.com/
> > 
> > Alan Maguire (8):
> >   dwarf_loader: Help spotting functions with optimized-out parameters
> >   btf_encoder: store type_id_off, unspecified type in encoder
> >   btf_encoder: Refactor function addition into dedicated
> >     btf_encoder__add_func
> >   btf_encoder: Rework btf_encoders__*() API to allow traversal of
> >     encoders
> >   btf_encoder: Represent "."-suffixed functions (".isra.0") in BTF
> >   btf_encoder: support delaying function addition to check for function
> >     prototype inconsistencies
> >   dwarves: document --btf_gen_optimized option
> >   dwarves: document --skip_encoding_btf_inconsistent_proto option
> > 
> >  btf_encoder.c      | 360 +++++++++++++++++++++++++++++++++++++--------
> >  btf_encoder.h      |   6 -
> >  dwarf_loader.c     | 130 +++++++++++++++-
> >  dwarves.h          |  11 +-
> >  man-pages/pahole.1 |  10 ++
> >  pahole.c           |  30 +++-
> >  6 files changed, 468 insertions(+), 79 deletions(-)
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
