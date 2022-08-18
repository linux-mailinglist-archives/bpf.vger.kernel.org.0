Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899DA5983C8
	for <lists+bpf@lfdr.de>; Thu, 18 Aug 2022 15:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244482AbiHRNJo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Aug 2022 09:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244117AbiHRNJn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Aug 2022 09:09:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1092A721B;
        Thu, 18 Aug 2022 06:09:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AAA56160E;
        Thu, 18 Aug 2022 13:09:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD017C433D6;
        Thu, 18 Aug 2022 13:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660828180;
        bh=9x4BUNySY3ragNluRSR1VyPAkopHYd2HMy0eUJpv0rQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pKxJRXrbe/9gXJGrG8NAv0TqHP0ITm0G53/79YOA4oQmd3vgRnkJY6kTIzIS2Xg1J
         H/ElEQDn7Jr58iBwGSLP88/xx2UZFrATcwJx9TP3qY001R+/jIYfEN34NNwXWeKeRl
         FSyz4Yj1Y8NGWMzUW71wboQM5ef8f59shrdHewzs7uP7lbkzbA1ChWcBxzH4XUFuV3
         tHfojUQEHY2CBu2dkTExUeH70NdVCIzVKWezLqvtgj95mMIsstLIvqOwwHoidyr2yx
         HFvuilctAiy33MAeZf7XYxGdcZUjSIQSm3ubwnd8y/VGjqzNL9K00jcKBIGDiK2/Ko
         Uy3SjHRvDvdgQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2EAB84035A; Thu, 18 Aug 2022 10:09:37 -0300 (-03)
Date:   Thu, 18 Aug 2022 10:09:37 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     roberto.sassu@huaweicloud.com
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, quentin@isovalent.com,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH 3/3] tools/build: Display logical OR of a feature flavors
Message-ID: <Yv46EW6KbUe9zjur@kernel.org>
References: <20220818120957.319995-1-roberto.sassu@huaweicloud.com>
 <20220818120957.319995-3-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818120957.319995-3-roberto.sassu@huaweicloud.com>
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

Em Thu, Aug 18, 2022 at 02:09:57PM +0200, roberto.sassu@huaweicloud.com escreveu:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Sometimes, features are simply different flavors of another feature, to
> properly detect the exact dependencies needed by different Linux
> distributions.
> 
> For example, libbfd has three flavors: libbfd if the distro does not
> require any additional dependency; libbfd-liberty if it requires libiberty;
> libbfd-liberty-z if it requires libiberty and libz.
> 
> It might not be clear to the user whether a feature has been successfully
> detected or not, given that some of its flavors will be set to OFF, others
> to ON.
> 
> Instead, display only the feature main flavor if not in verbose mode
> (VF != 1), and set it to ON if at least one of its flavors has been
> successfully detected (logical OR), OFF otherwise. Omit the other flavors.
> 
> Accomplish that by declaring a FEATURE_GROUP_MEMBERS-<feature main flavor>
> variable, with the list of the other flavors as variable value. For now, do
> it just for libbfd.
> 
> In verbose mode, of if no group is defined for a feature, show the feature
> detection result as before.

Looks cool, tested and added this to the commit log message here in my
local branch, that will go public after further tests for the other
csets in it:

Committer testing:

Collecting the output from:

  $ make -C tools/bpf/bpftool/ clean
  $ make -C tools/bpf/bpftool/ |& grep "Auto-detecting system features" -A10

  $ diff -u before after
  --- before    2022-08-18 10:06:40.422086966 -0300
  +++ after     2022-08-18 10:07:59.202138282 -0300
  @@ -1,6 +1,4 @@
   Auto-detecting system features:
   ...                                  libbfd: [ on  ]
  -...                          libbfd-liberty: [ on  ]
  -...                        libbfd-liberty-z: [ on  ]
   ...                                  libcap: [ on  ]
   ...                         clang-bpf-co-re: [ on  ]
  $

Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Thanks for working on this!

- Arnaldo
 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  tools/build/Makefile.feature | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index 6c809941ff01..57619f240b56 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -137,6 +137,12 @@ FEATURE_DISPLAY ?=              \
>           libaio			\
>           libzstd
>  
> +#
> +# Declare group members of a feature to display the logical OR of the detection
> +# result instead of each member result.
> +#
> +FEATURE_GROUP_MEMBERS-libbfd = libbfd-liberty libbfd-liberty-z
> +
>  # Set FEATURE_CHECK_(C|LD)FLAGS-all for all FEATURE_TESTS features.
>  # If in the future we need per-feature checks/flags for features not
>  # mentioned in this list we need to refactor this ;-).
> @@ -179,8 +185,17 @@ endif
>  #
>  feature_print_status = $(eval $(feature_print_status_code))
>  
> +feature_group = $(eval $(feature_gen_group)) $(GROUP)
> +
> +define feature_gen_group
> +  GROUP := $(1)
> +  ifneq ($(feature_verbose),1)
> +    GROUP += $(FEATURE_GROUP_MEMBERS-$(1))
> +  endif
> +endef
> +
>  define feature_print_status_code
> -  ifeq ($(feature-$(1)), 1)
> +  ifneq (,$(filter 1,$(foreach feat,$(call feature_group,$(feat)),$(feature-$(feat)))))
>      MSG = $(shell printf '...%40s: [ \033[32mon\033[m  ]' $(1))
>    else
>      MSG = $(shell printf '...%40s: [ \033[31mOFF\033[m ]' $(1))
> @@ -244,12 +259,20 @@ ifeq ($(VF),1)
>    feature_verbose := 1
>  endif
>  
> +ifneq ($(feature_verbose),1)
> +  #
> +  # Determine the features to omit from the displayed message, as only the
> +  # logical OR of the detection result will be shown.
> +  #
> +  FEATURE_OMIT := $(foreach feat,$(FEATURE_DISPLAY),$(FEATURE_GROUP_MEMBERS-$(feat)))
> +endif
> +
>  feature_display_entries = $(eval $(feature_display_entries_code))
>  define feature_display_entries_code
>    ifeq ($(feature_display),1)
>      $$(info )
>      $$(info Auto-detecting system features:)
> -    $(foreach feat,$(FEATURE_DISPLAY),$(call feature_print_status,$(feat),) $$(info $(MSG)))
> +    $(foreach feat,$(filter-out $(FEATURE_OMIT),$(FEATURE_DISPLAY)),$(call feature_print_status,$(feat),) $$(info $(MSG)))
>    endif
>  
>    ifeq ($(feature_verbose),1)
> -- 
> 2.25.1

-- 

- Arnaldo
