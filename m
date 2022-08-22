Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D86959BE5C
	for <lists+bpf@lfdr.de>; Mon, 22 Aug 2022 13:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbiHVLVc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Aug 2022 07:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbiHVLVb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Aug 2022 07:21:31 -0400
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CAC32DAD;
        Mon, 22 Aug 2022 04:21:28 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4MB8wT0pPJz9v7Gg;
        Mon, 22 Aug 2022 19:17:45 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwD3xhKcZgNjHm8_AA--.30234S2;
        Mon, 22 Aug 2022 12:21:08 +0100 (CET)
Message-ID: <64352c51c5dcbab389201a16733f3157a1ea591e.camel@huaweicloud.com>
Subject: Re: [PATCH 3/3] tools/build: Display logical OR of a feature flavors
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, quentin@isovalent.com,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Mon, 22 Aug 2022 13:24:28 +0200
In-Reply-To: <YwNhabqHEq3PfNM8@krava>
References: <20220818120957.319995-1-roberto.sassu@huaweicloud.com>
         <20220818120957.319995-3-roberto.sassu@huaweicloud.com>
         <YwNhabqHEq3PfNM8@krava>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwD3xhKcZgNjHm8_AA--.30234S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZF1rGFyUXF47uF1kZrW7CFg_yoW5AFy8pa
        yrAa45CF4Dtr4xCa1xtr45uF45Kr4xJay7Jr9Ika47AF18GrnFkw10kFZ5urZ2v3yYqw17
        WF13JF45Cr1qy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1F6r1fM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAMBF1jj4IucQAAsl
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2022-08-22 at 12:58 +0200, Jiri Olsa wrote:
> On Thu, Aug 18, 2022 at 02:09:57PM +0200, 

[...]

> 
> > In verbose mode, of if no group is defined for a feature, show the
> > feature
> > detection result as before.

Thanks Jiri.

'or' instead of 'of', if the patch can be edited.

Roberto

> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > ---
> >  tools/build/Makefile.feature | 27 +++++++++++++++++++++++++--
> >  1 file changed, 25 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/build/Makefile.feature
> > b/tools/build/Makefile.feature
> > index 6c809941ff01..57619f240b56 100644
> > --- a/tools/build/Makefile.feature
> > +++ b/tools/build/Makefile.feature
> > @@ -137,6 +137,12 @@ FEATURE_DISPLAY ?=              \
> >           libaio			\
> >           libzstd
> >  
> > +#
> > +# Declare group members of a feature to display the logical OR of
> > the detection
> > +# result instead of each member result.
> > +#
> > +FEATURE_GROUP_MEMBERS-libbfd = libbfd-liberty libbfd-liberty-z
> 
> nice, I checked and could not find any other 'flavours' instance
> like libbfd, but it might happen in future
> 
> for the whole patchset:
> 
> Tested-by: Jiri Olsa <jolsa@kernel.org>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> 
> thanks,
> jirka
> 
> 
> > +
> >  # Set FEATURE_CHECK_(C|LD)FLAGS-all for all FEATURE_TESTS
> > features.
> >  # If in the future we need per-feature checks/flags for features
> > not
> >  # mentioned in this list we need to refactor this ;-).
> > @@ -179,8 +185,17 @@ endif
> >  #
> >  feature_print_status = $(eval $(feature_print_status_code))
> >  
> > +feature_group = $(eval $(feature_gen_group)) $(GROUP)
> > +
> > +define feature_gen_group
> > +  GROUP := $(1)
> > +  ifneq ($(feature_verbose),1)
> > +    GROUP += $(FEATURE_GROUP_MEMBERS-$(1))
> > +  endif
> > +endef
> > +
> >  define feature_print_status_code
> > -  ifeq ($(feature-$(1)), 1)
> > +  ifneq (,$(filter 1,$(foreach feat,$(call
> > feature_group,$(feat)),$(feature-$(feat)))))
> >      MSG = $(shell printf '...%40s: [ \033[32mon\033[m  ]' $(1))
> >    else
> >      MSG = $(shell printf '...%40s: [ \033[31mOFF\033[m ]' $(1))
> > @@ -244,12 +259,20 @@ ifeq ($(VF),1)
> >    feature_verbose := 1
> >  endif
> >  
> > +ifneq ($(feature_verbose),1)
> > +  #
> > +  # Determine the features to omit from the displayed message, as
> > only the
> > +  # logical OR of the detection result will be shown.
> > +  #
> > +  FEATURE_OMIT := $(foreach
> > feat,$(FEATURE_DISPLAY),$(FEATURE_GROUP_MEMBERS-$(feat)))
> > +endif
> > +
> >  feature_display_entries = $(eval $(feature_display_entries_code))
> >  define feature_display_entries_code
> >    ifeq ($(feature_display),1)
> >      $$(info )
> >      $$(info Auto-detecting system features:)
> > -    $(foreach feat,$(FEATURE_DISPLAY),$(call
> > feature_print_status,$(feat),) $$(info $(MSG)))
> > +    $(foreach feat,$(filter-out
> > $(FEATURE_OMIT),$(FEATURE_DISPLAY)),$(call
> > feature_print_status,$(feat),) $$(info $(MSG)))
> >    endif
> >  
> >    ifeq ($(feature_verbose),1)
> > -- 
> > 2.25.1
> > 

