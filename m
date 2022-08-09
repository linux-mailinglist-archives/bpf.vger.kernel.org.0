Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D407A58DFF4
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 21:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345981AbiHITN7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 15:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345769AbiHITNc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 15:13:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284A22AE32;
        Tue,  9 Aug 2022 12:04:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B43F9612F0;
        Tue,  9 Aug 2022 19:04:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D851AC433D6;
        Tue,  9 Aug 2022 19:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660071890;
        bh=RB8OyKIO/zahJ9Uiq9plVG31G01V975xaNF+9AbDVIs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oFmiMkyM3i6Ne3bvqoOsnIybe8Ey7mGTCGphB9qdja5pnbIJn87u8X/rQkW8YYFZI
         So4RZpHYH9ibY4cdM0KHD17ruP5wCdKZov8nUCmoLTX6KLb5/VLbJU239jy6ueWlQe
         2WUH6WpNtqwNuhT1TpxXhtFCsfJKMo57L49LW0s0mtAQNqOsOgDhDqkPABzz9Ish10
         g02uBhjp+OUIGo6c4iiE69DRmeVjeMW2qYDgeUPNJUH/Xfar8/N5J2wy99QS2MiOHZ
         nVStcfPPAOhgyMewVkOU2++N0HPEDtL+47us8W1vrLE0RJs2xj4FZPmQCHwLAaACt0
         xaBrPpga577VA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 39E7D4035A; Tue,  9 Aug 2022 16:04:46 -0300 (-03)
Date:   Tue, 9 Aug 2022 16:04:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andres Freund <andres@anarazel.de>
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        Daniel Borkmann <daniel@iogearbox.net>, quentin@isovalent.com,
        ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, peterz@infradead.org, mingo@redhat.com,
        terrelln@fb.com, nathan@kernel.org, ndesaulniers@google.com,
        bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH 4/4] build: Switch to new openssl API for test-libcrypto
Message-ID: <YvKvzkuUG78q/mkA@kernel.org>
References: <20220719170555.2576993-1-roberto.sassu@huawei.com>
 <20220719170555.2576993-4-roberto.sassu@huawei.com>
 <5f867295-10d2-0085-d1dc-051f56e7136a@iogearbox.net>
 <YvFW/kBL6YA3Tlnc@kernel.org>
 <YvJ6DbzBNsAgNZS4@kernel.org>
 <YvJ7awkCVBYaZ2dd@kernel.org>
 <20220809170034.hx7fyiosm3tfekwf@awork3.anarazel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809170034.hx7fyiosm3tfekwf@awork3.anarazel.de>
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

Em Tue, Aug 09, 2022 at 10:00:34AM -0700, Andres Freund escreveu:
> Hi,
> 
> On 2022-08-09 12:21:15 -0300, Arnaldo Carvalho de Melo wrote:
> > So I backtracked, the way it works needs further consideration with
> > regard to the patchkit from Andres, that is already upstream, so it
> > would be good for Roberto to take a look at what is in torvalds/master
> > now and see if we have to removed that styled thing from Andres.
> 
> Why would it have to be removed - seems to be fairly independent, leaving the
> line conflicts aside? Or do you just mean folding it into one-big-test? If so,
> that'd make sense, although I'm not sure how ready the infrastructure

So below is the 3rd patch in Roberto's patchkit adapted, I removed the
FEATURE_CHECK_LDFLAGS-disassembler-init-styled setting as we now
automatically try with multiple sets of libraries, as with
disassembler-four-args.

- Arnaldo

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 23648ea54e8d3d2c..0661a1cf98556ed3 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -297,9 +297,6 @@ FEATURE_CHECK_LDFLAGS-libpython := $(PYTHON_EMBED_LDOPTS)
 
 FEATURE_CHECK_LDFLAGS-libaio = -lrt
 
-FEATURE_CHECK_LDFLAGS-disassembler-four-args = -lbfd -lopcodes -ldl
-FEATURE_CHECK_LDFLAGS-disassembler-init-styled = -lbfd -lopcodes -ldl
-
 CORE_CFLAGS += -fno-omit-frame-pointer
 CORE_CFLAGS += -ggdb3
 CORE_CFLAGS += -funwind-tables
@@ -329,8 +326,8 @@ ifneq ($(TCMALLOC),)
 endif
 
 ifeq ($(FEATURES_DUMP),)
-# We will display at the end of this Makefile.config, using $(call feature_display_entries)
-# As we may retry some feature detection here, see the disassembler-four-args case, for instance
+# We will display at the end of this Makefile.config, using $(call feature_display_entries),
+# as we may retry some feature detection here.
   FEATURE_DISPLAY_DEFERRED := 1
 include $(srctree)/tools/build/Makefile.feature
 else
@@ -924,13 +921,9 @@ ifndef NO_LIBBFD
 
     ifeq ($(feature-libbfd-liberty), 1)
       EXTLIBS += -lbfd -lopcodes -liberty
-      FEATURE_CHECK_LDFLAGS-disassembler-four-args += -liberty -ldl
-      FEATURE_CHECK_LDFLAGS-disassembler-init-styled += -liberty -ldl
     else
       ifeq ($(feature-libbfd-liberty-z), 1)
         EXTLIBS += -lbfd -lopcodes -liberty -lz
-        FEATURE_CHECK_LDFLAGS-disassembler-four-args += -liberty -lz -ldl
-        FEATURE_CHECK_LDFLAGS-disassembler-init-styled += -liberty -lz -ldl
       endif
     endif
     $(call feature_check,disassembler-four-args)
@@ -1356,7 +1349,7 @@ endif
 
 # re-generate FEATURE-DUMP as we may have called feature_check, found out
 # extra libraries to add to LDFLAGS of some other test and then redo those
-# tests, see the block about libbfd, disassembler-four-args, for instance.
+# tests.
 $(shell rm -f $(FEATURE_DUMP_FILENAME))
 $(foreach feat,$(FEATURE_TESTS),$(shell echo "$(call feature_assign,$(feat))" >> $(FEATURE_DUMP_FILENAME)))
 
 
> 
> FWIW, if I would have to maintain these, I'd probably change FEATURE_TESTS,
> FEATURE_DISPLAY into one-item-per-line to make conflicts less common and
> easier to resolve.
> 
> 
> > Andres, if you could take a look at Roberto's patchkit as well that
> > would be great.
> 
> I briefly scanned it, and the only real comment I have mirror's Quentin's,
> namely that it'd be nice to avoid displaying more tests that don't tell the
> user much.
> 
> Greetings,
> 
> Andres Freund

-- 

- Arnaldo
