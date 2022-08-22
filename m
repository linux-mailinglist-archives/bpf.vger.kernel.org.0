Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7952D59BDFE
	for <lists+bpf@lfdr.de>; Mon, 22 Aug 2022 12:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbiHVK7C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Aug 2022 06:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiHVK64 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Aug 2022 06:58:56 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D9C31230;
        Mon, 22 Aug 2022 03:58:53 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id o22so13336677edc.10;
        Mon, 22 Aug 2022 03:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=l/LzIhPe9ZTwGL9N0G3IR78vwpYSKjEk5JerrPZ+Ejo=;
        b=Uo63L0oGuXttZhHN4XJDd7Yk9cuKw2mTwcaEljw6hjBYWig7OS9VB7K1mzfL2EFBKr
         XBP2dIWW+q5jeGJWxci/I7uQ1EAi0SaQAPsFm+bcQQvpOY2BWq4qZEA3dzroYr/ttTMG
         FNh3IvETdStsqN1/597U/tw//3tgux3GHuX+jdYjKniZkLV4BwBTgscQb59JsslnD3bR
         hBLgtOlgJBH38JE/rDlFWCUO6BvD+5lpeZmuycDKOvHql6fm5WET93M+rTl5ab3YUKcq
         Wctx2hTikYI/zIwRKOmIZWB+I8PM6A8O3Q1yLpqFlFymyuqBdR7novHoK7RZCsL0icQ7
         mkqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=l/LzIhPe9ZTwGL9N0G3IR78vwpYSKjEk5JerrPZ+Ejo=;
        b=gu9rFgYRSWXGuv1+LSxTfrqugGo8wWc0n1lgKZoBWFMlIVx++aIu960HmUdYPZnK0i
         D2QupnhQ4WaK1tA99AgIrNPOk59OzRrnDYyeAL9Kq+1o5hyuFYqcPwx/fBKkmIJI9tAg
         Qw8B+1VZO/auiv5Rqg0iwY9a6QJ3j5WTe7vCUMaybFeIil9ELNw2amSCBQNtkqSgpPaS
         bnsGXcV3J7oOw9/CsM18/cK7b4I7LPhQ4vzfHhEr8XB0L69lFBStO2OuSLhBhFTjurxX
         Pe/eNd+EdK/0ELcltfF/+NmL93G7yCaoNcNYm98Yv5v7wOslw6dwWr1cfhqUJeW8qfFm
         wbtQ==
X-Gm-Message-State: ACgBeo3VKMkyzrT/RNZa5eirv3punTWKs8gygREA4jPNsveHziVp/qVK
        gfADMBlWajT9PgYha41WnQM=
X-Google-Smtp-Source: AA6agR6cWPvpGJFviWOBgVZVY1+3fDdKs6dGgBZXzzVrjPl3a947xyPgoMPCgjTTt4XboZ2i5XPf5g==
X-Received: by 2002:a05:6402:3805:b0:43e:8335:3a2a with SMTP id es5-20020a056402380500b0043e83353a2amr16055078edb.296.1661165932033;
        Mon, 22 Aug 2022 03:58:52 -0700 (PDT)
Received: from krava ([193.85.244.190])
        by smtp.gmail.com with ESMTPSA id ss2-20020a170907c00200b007309f007d3asm5874225ejc.128.2022.08.22.03.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 03:58:51 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 22 Aug 2022 12:58:49 +0200
To:     roberto.sassu@huaweicloud.com
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, quentin@isovalent.com,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH 3/3] tools/build: Display logical OR of a feature flavors
Message-ID: <YwNhabqHEq3PfNM8@krava>
References: <20220818120957.319995-1-roberto.sassu@huaweicloud.com>
 <20220818120957.319995-3-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818120957.319995-3-roberto.sassu@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 18, 2022 at 02:09:57PM +0200, roberto.sassu@huaweicloud.com wrote:
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
> 
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

nice, I checked and could not find any other 'flavours' instance
like libbfd, but it might happen in future

for the whole patchset:

Tested-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka


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
> 
