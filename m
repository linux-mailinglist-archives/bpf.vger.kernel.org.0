Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7882D64A3A7
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 15:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbiLLOpS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 09:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbiLLOpR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 09:45:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B36765C0;
        Mon, 12 Dec 2022 06:45:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13E09B80D86;
        Mon, 12 Dec 2022 14:45:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F53EC433F0;
        Mon, 12 Dec 2022 14:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670856313;
        bh=Ug5zleVyjK5U5aBjLmguiGbM1OJF0MNqWNvW2lrwe8Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jGzPsR/b+I8XH9KBzwEYpFHj100FY7XmWbDSRknmz1lvMfK32MxmJV4vcbcNMLZ0E
         adIeyV5tJgSWWDYIf2KgZ3QPCD22IiMatS4+nnm3Pajb/SdTzP1E93s2Jzma6+ki4b
         JU/1VwpUxGMz4D1skUhVWx2shjd68or3Hv6YtDPNaoQCCuySTgQ5YNn47nMyzqtrH+
         yIQLmYlng6cwBy6aTAZY2W5A1QdwcCwxy9ECJOywWZsuTmkwTzGc0L65TRjQOHRMgX
         VLL1g8xOvRdxSbMIDJVueRv+ufOrFLFknux1YcQQMI8oKui13/ytGuNzfOcwynavZ7
         9NQdiQLnbu1Sg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 29D5340638; Mon, 12 Dec 2022 11:13:41 -0300 (-03)
Date:   Mon, 12 Dec 2022 11:13:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 2/3] perf build: Use libtraceevent from the system
Message-ID: <Y5c3FSm16tIKQfgS@kernel.org>
References: <Y4921D+36UGdhK92@kernel.org>
 <Y494TNa0ZyPH9YSD@kernel.org>
 <Y498YP2N3gvFSr/X@kernel.org>
 <C9F248C8-AF8D-40A1-A1AD-BCC39FBA01C7@linux.vnet.ibm.com>
 <Y5DNBZNC5rBBqlJW@kernel.org>
 <36CD1041-0CAE-41C1-8086-C17854531B3E@linux.vnet.ibm.com>
 <Y5JfgyN59dSeKbUP@kernel.org>
 <Y5Jl8MeW90DXy1wT@kernel.org>
 <CAP-5=fWyb+w2EP4cGBJU3RD6E_OkBZ+3w5+YyhwX7fOA-H0aWQ@mail.gmail.com>
 <CAP-5=fXJpxq-A7VJkZv+Y0fiCuNj9bhTXJx9+FGBQtePJ92z_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXJpxq-A7VJkZv+Y0fiCuNj9bhTXJx9+FGBQtePJ92z_A@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Dec 08, 2022 at 03:05:29PM -0800, Ian Rogers escreveu:
> On Thu, Dec 8, 2022 at 3:00 PM Ian Rogers <irogers@google.com> wrote:
> > On Thu, Dec 8, 2022 at 2:32 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > commit a0ec3ef4590e7e82339b6f318e671a6b69fd94e8
> > > Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > Date:   Thu Dec 8 19:28:58 2022 -0300

> > >     perf tools: Add test to check if libtracevent has TEP_FIELD_IS_RELATIVE

> > Could HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE be a version rather
> > than feature check, something like:

> > #define MAKE_LIBTRACEEVENT_VERSION(maj, mid, min) (maj * 255 *255 +
> > mid * 255 + min)
> > #define HAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
> > (LIBTRACEEVENT_VERSION >= MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)

> > Note, we have LIBTRACEEVENT_VERSION computed in Makefile.config by way
> > of pkg-config.
 
> LIBTRACEEVENT_VERSION had a workaround if pkg-config wasn't present to
> default to 1.1.0 for its use in:
> https://lore.kernel.org/linux-perf-users/20210923001024.550263-4-irogers@google.com/
> We should un-revert that change now the -Itools/lib issue is resolved
> (1.1 traceevent headers compiled against newer system libtraceevent
> library).

Can you please send that un-revert as a proper patch?

Meanwhile, I came up with this quick hack on top of what I had, seems to
be enough, will test it with systems with libtraceevent <= 1.5.0, where
TEP_FIELD_IS_RELATIVE was introduced.

Will do it after removing the tools/build/feature/ TEP_FIELD_IS_RELATIVE
big hammer check.

- Arnaldo

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index e29975664f06bd61..52a4dc029111c1e2 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1197,8 +1197,8 @@ ifneq ($(NO_LIBTRACEEVENT),1)
     LIBTRACEEVENT_VERSION_CPP := $(shell expr $(LIBTRACEEVENT_VERSION_1) \* 255 \* 255 + $(LIBTRACEEVENT_VERSION_2) \* 255 + $(LIBTRACEEVENT_VERSION_3))
     CFLAGS += -DLIBTRACEEVENT_VERSION=$(LIBTRACEEVENT_VERSION_CPP)
     $(call detected,CONFIG_LIBTRACEEVENT)
-    $(call feature_check,libtraceevent-tep_field_is_relative)
-    ifeq ($(feature-libtraceevent-tep_field_is_relative), 1)
+    LIBTRACEEVENT_VERSION_WITH_TEP_FIELD_IS_RELATIVE := $(shell expr 1 \* 255 \* 255 + 5 \* 255 + 0) # 1.5.0
+    ifeq ($(shell test $(LIBTRACEEVENT_VERSION_CPP) -gt $(LIBTRACEEVENT_VERSION_WITH_TEP_FIELD_IS_RELATIVE); echo $$?),0)
       CFLAGS += -DHAVE_LIBTRACEEVENT_TEP_FIELD_IS_RELATIVE
     endif
   else
