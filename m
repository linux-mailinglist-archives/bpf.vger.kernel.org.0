Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7B7598AE9
	for <lists+bpf@lfdr.de>; Thu, 18 Aug 2022 20:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241682AbiHRSOK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Aug 2022 14:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238585AbiHRSOI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Aug 2022 14:14:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9504F47B94;
        Thu, 18 Aug 2022 11:14:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39A0DB823A9;
        Thu, 18 Aug 2022 18:14:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0A3DC433D6;
        Thu, 18 Aug 2022 18:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660846443;
        bh=0gg07s0kGzT4ViYZPq8WstaAK0/6SvOT3SF9kcQbD+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vAvdRdYBhmyNF9gdV0ZDssdTuErtRHEkX4c5eaK1AdNYS/Vx97v+O9Gzpi9Cf82c+
         lS7oSlebGIclK8IHn+tufEn3Pqql+zXSwK/MgIBZ3lqOrFzsZS6U7ZIfoKGN7PyxCO
         9b3J7HZT1qay7d0PPp2hAJ3TZqjnGaC9KVcX/klxQenzh4D8peQPkgaZZ18IDTXNco
         I03TsZswsGDEDWJQqqvNbnSLg57S/ajKIXwExLKQOVc/8tMjy6l2kXjlbpM546mu8G
         sPXE/nUMTP6VcXVJHX6BgMgkPCgAVmJC35XF43Z5R21g8UMLZFXutbl/gD2LAi9uAb
         sIReUHqJ1oVaA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BC7944035A; Thu, 18 Aug 2022 15:14:00 -0300 (-03)
Date:   Thu, 18 Aug 2022 15:14:00 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH 3/3] tools/build: Display logical OR of a feature flavors
Message-ID: <Yv6BaHgC4E4J0TTT@kernel.org>
References: <20220818120957.319995-1-roberto.sassu@huaweicloud.com>
 <20220818120957.319995-3-roberto.sassu@huaweicloud.com>
 <Yv46EW6KbUe9zjur@kernel.org>
 <71544d2970e246e1f0d5f5ec065ea2437df58cd9.camel@huaweicloud.com>
 <23da162e-1018-9bfa-bc5c-ec09eba9428b@isovalent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23da162e-1018-9bfa-bc5c-ec09eba9428b@isovalent.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Aug 18, 2022 at 05:40:04PM +0100, Quentin Monnet escreveu:
> On 18/08/2022 14:25, Roberto Sassu wrote:
> > On Thu, 2022-08-18 at 10:09 -0300, Arnaldo Carvalho de Melo wrote:
> >> Em Thu, Aug 18, 2022 at 02:09:57PM +0200, 
> >> roberto.sassu@huaweicloud.com escreveu:
> >>> From: Roberto Sassu <roberto.sassu@huawei.com>
> >>>
> >>> Sometimes, features are simply different flavors of another
> >>> feature, to
> >>> properly detect the exact dependencies needed by different Linux
> >>> distributions.
> >>>
> >>> For example, libbfd has three flavors: libbfd if the distro does
> >>> not
> >>> require any additional dependency; libbfd-liberty if it requires
> >>> libiberty;
> >>> libbfd-liberty-z if it requires libiberty and libz.
> >>>
> >>> It might not be clear to the user whether a feature has been
> >>> successfully
> >>> detected or not, given that some of its flavors will be set to OFF,
> >>> others
> >>> to ON.
> >>>
> >>> Instead, display only the feature main flavor if not in verbose
> >>> mode
> >>> (VF != 1), and set it to ON if at least one of its flavors has been
> >>> successfully detected (logical OR), OFF otherwise. Omit the other
> >>> flavors.
> >>>
> >>> Accomplish that by declaring a FEATURE_GROUP_MEMBERS-<feature main
> >>> flavor>
> >>> variable, with the list of the other flavors as variable value. For
> >>> now, do
> >>> it just for libbfd.
> >>>
> >>> In verbose mode, of if no group is defined for a feature, show the
> >>> feature
> >>> detection result as before.
> >>
> >> Looks cool, tested and added this to the commit log message here in
> >> my
> >> local branch, that will go public after further tests for the other
> >> csets in it:
> >>
> >> Committer testing:
> >>
> >> Collecting the output from:
> >>
> >>   $ make -C tools/bpf/bpftool/ clean
> >>   $ make -C tools/bpf/bpftool/ |& grep "Auto-detecting system
> >> features" -A10
> >>
> >>   $ diff -u before after
> >>   --- before    2022-08-18 10:06:40.422086966 -0300
> >>   +++ after     2022-08-18 10:07:59.202138282 -0300
> >>   @@ -1,6 +1,4 @@
> >>    Auto-detecting system features:
> >>    ...                                  libbfd: [ on  ]
> >>   -...                          libbfd-liberty: [ on  ]
> >>   -...                        libbfd-liberty-z: [ on  ]
> >>    ...                                  libcap: [ on  ]
> >>    ...                         clang-bpf-co-re: [ on  ]
> >>   $
> >>
> >> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> >>
> >> Thanks for working on this!
> > 
> > Thanks for testing and for adapting/pushing the other patches!
> > 
> > Roberto
> > 
> 
> Tested locally for bpftool and I also observe "libbfd: [ on  ]" only.
> This looks much better, thank you Roberto for following up on this!

So I'll add your Tested-by: to this one as well, maybe to all the
patches in this series?

- Arnaldo
