Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978945AA14E
	for <lists+bpf@lfdr.de>; Thu,  1 Sep 2022 23:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235124AbiIAVB6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Sep 2022 17:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbiIAVBk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Sep 2022 17:01:40 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E5F9E13F
        for <bpf@vger.kernel.org>; Thu,  1 Sep 2022 14:00:36 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id C590B240028
        for <bpf@vger.kernel.org>; Thu,  1 Sep 2022 23:00:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1662066002; bh=8JZz5ZVWJPPazqyJFTydDjt5sGz36I4xqw2sgzrPWJQ=;
        h=Date:From:To:Cc:Subject:From;
        b=SLTAvmBrAaTWWp1uURUoQCKhoHpIItUwKOHQqBqEsjIW9VT3IkldCAv9ZtP/kP3aH
         ScDMnCCzJDxQKgONe41BiTPaFghJrAiXn39g+rxC/Q/tLxlgHLcvhG18jwQVh1RJ6A
         CVa/4ZF7u7KR8f9AeBXfgUszMqOlgkOQ81ZOmEMo5RIG9Y0eN0KE7tWMomdDTeo16L
         w7F1GNIoFnCk9CRfDB9VoFFcKEtKdgEyjJocpTbrSFXKrHvkTJ3suncKRm7RfMtekl
         H/FlWVaQTzMHZ3aEDNb2rzy/b1nGG37ybByKlyG/+iJlOlhtuBpzguufKPEQXSowTu
         e3ShKGwQ9yvLA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4MJYMh3SSrz6tpG;
        Thu,  1 Sep 2022 23:00:00 +0200 (CEST)
Date:   Thu,  1 Sep 2022 20:59:56 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        kafai@fb.com, kernel-team@fb.com
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Store BPF object files with
 .bpf.o extension
Message-ID: <20220901205956.2lntc4v72wwsftrf@muellerd-fedora-PC2BDTX9>
References: <20220830175550.3838206-1-deso@posteo.net>
 <767e3600-c709-071e-c3f9-3ccf0bdcd478@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <767e3600-c709-071e-c3f9-3ccf0bdcd478@iogearbox.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 31, 2022 at 11:39:05PM +0200, Daniel Borkmann wrote:
> On 8/30/22 7:55 PM, Daniel Müller wrote:
> [...]
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> > index eecad9..787631 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> [...]
> > -LINKED_BPF_SRCS := $(patsubst %.o,%.c,$(foreach skel,$(LINKED_SKELS),$($(skel)-deps)))
> > +LINKED_BPF_SRCS := $(patsubst %.bpf.o,%.c,$(foreach skel,$(LINKED_SKELS),$($(skel)-deps)))
> >   # Set up extra TRUNNER_XXX "temporary" variables in the environment (relies on
> >   # $eval()) and pass control to DEFINE_TEST_RUNNER_RULES.
> > @@ -386,7 +386,7 @@ TRUNNER_EXTRA_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.o,		\
> >   TRUNNER_EXTRA_HDRS := $$(filter %.h,$(TRUNNER_EXTRA_SOURCES))
> >   TRUNNER_TESTS_HDR := $(TRUNNER_TESTS_DIR)/tests.h
> >   TRUNNER_BPF_SRCS := $$(notdir $$(wildcard $(TRUNNER_BPF_PROGS_DIR)/*.c))
> > -TRUNNER_BPF_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.o, $$(TRUNNER_BPF_SRCS))
> > +TRUNNER_BPF_OBJS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.bpf.o, $$(TRUNNER_BPF_SRCS))
> >   TRUNNER_BPF_SKELS := $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.skel.h,	\
> >   				 $$(filter-out $(SKEL_BLACKLIST) $(LINKED_BPF_SRCS),\
> >   					       $$(TRUNNER_BPF_SRCS)))
> > @@ -416,7 +416,7 @@ endif
> >   # input/output directory combination
> >   ifeq ($($(TRUNNER_BPF_PROGS_DIR)$(if $2,-)$2-bpfobjs),)
> >   $(TRUNNER_BPF_PROGS_DIR)$(if $2,-)$2-bpfobjs := y
> > -$(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.o:				\
> > +$(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.bpf.o:				\
> >   		     $(TRUNNER_BPF_PROGS_DIR)/%.c			\
> >   		     $(TRUNNER_BPF_PROGS_DIR)/*.h			\
> >   		     $$(INCLUDE_DIR)/vmlinux.h				\
> > @@ -426,22 +426,22 @@ $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.o:				\
> >   	$$(call $(TRUNNER_BPF_BUILD_RULE),$$<,$$@,			\
> >   					  $(TRUNNER_BPF_CFLAGS))
> > -$(TRUNNER_BPF_SKELS): %.skel.h: %.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
> > +$(TRUNNER_BPF_SKELS): %.skel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
> >   	$$(call msg,GEN-SKEL,$(TRUNNER_BINARY),$$@)
> >   	$(Q)$$(BPFTOOL) gen object $$(<:.o=.linked1.o) $$<
> >   	$(Q)$$(BPFTOOL) gen object $$(<:.o=.linked2.o) $$(<:.o=.linked1.o)
> >   	$(Q)$$(BPFTOOL) gen object $$(<:.o=.linked3.o) $$(<:.o=.linked2.o)
> >   	$(Q)diff $$(<:.o=.linked2.o) $$(<:.o=.linked3.o)
> > -	$(Q)$$(BPFTOOL) gen skeleton $$(<:.o=.linked3.o) name $$(notdir $$(<:.o=)) > $$@
> > -	$(Q)$$(BPFTOOL) gen subskeleton $$(<:.o=.linked3.o) name $$(notdir $$(<:.o=)) > $$(@:.skel.h=.subskel.h)
> > +	$(Q)$$(BPFTOOL) gen skeleton $$(<:.o=.linked3.o) name $$(notdir $$(<:.bpf.o=)) > $$@
> > +	$(Q)$$(BPFTOOL) gen subskeleton $$(<:.o=.linked3.o) name $$(notdir $$(<:.bpf.o=)) > $$(@:.skel.h=.subskel.h)
> > -$(TRUNNER_BPF_LSKELS): %.lskel.h: %.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
> > +$(TRUNNER_BPF_LSKELS): %.lskel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
> >   	$$(call msg,GEN-SKEL,$(TRUNNER_BINARY),$$@)
> >   	$(Q)$$(BPFTOOL) gen object $$(<:.o=.llinked1.o) $$<
> >   	$(Q)$$(BPFTOOL) gen object $$(<:.o=.llinked2.o) $$(<:.o=.llinked1.o)
> >   	$(Q)$$(BPFTOOL) gen object $$(<:.o=.llinked3.o) $$(<:.o=.llinked2.o)
> >   	$(Q)diff $$(<:.o=.llinked2.o) $$(<:.o=.llinked3.o)
> > -	$(Q)$$(BPFTOOL) gen skeleton -L $$(<:.o=.llinked3.o) name $$(notdir $$(<:.o=_lskel)) > $$@
> > +	$(Q)$$(BPFTOOL) gen skeleton -L $$(<:.o=.llinked3.o) name $$(notdir $$(<:.bpf.o=_lskel)) > $$@
> >   $(TRUNNER_BPF_SKELS_LINKED): $(TRUNNER_BPF_OBJS) $(BPFTOOL) | $(TRUNNER_OUTPUT)
> >   	$$(call msg,LINK-BPF,$(TRUNNER_BINARY),$$(@:.skel.h=.o))
> 
> Should this one also be converted to .bpf.o ?

Thanks for your review. I believe it should. Good catch. Will send an updated
version.

[...]

Thanks,
Daniel
