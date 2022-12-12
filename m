Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B5464A3A5
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 15:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbiLLOpQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 09:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbiLLOpQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 09:45:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4666424;
        Mon, 12 Dec 2022 06:45:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A05C16106F;
        Mon, 12 Dec 2022 14:45:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F50EC433EF;
        Mon, 12 Dec 2022 14:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670856314;
        bh=EvEZt8wVyoka0T/oimTSBNVo3axkDhbQxVc0X3rYsJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W/Q2oUGaROnOpni/I0RkyJAOhFyqcVUG+jQrSD0pua65VfaYxN1cxW13gI/ZE2Df0
         hqJ+FTsrX4nTLPIraWjI8+ciLB3AnnDvRb9iki+Nl0DfdbndrnoEx2eIVTyHX4cMav
         CtbI6e3teGULTdJMi6ohbudqgmmP8QXvEfQs/3UdGwygzi/YE0bIRJ+EqQBTSfL4CK
         /u/8NXmV1dLNnCvZbHdIVXLPD/dl8UXX+6xRJtGuIjCa5gSq7mV+fpqapvi0NOAFVM
         /kD37Xp8kFvJJL/BStqs79U5RA0Yl4WaQqlcTCIgl5d9rBEDPtIunCNXpunke8ugNu
         Ew6QZqBO4xFIQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 31EF140483; Mon, 12 Dec 2022 10:51:06 -0300 (-03)
Date:   Mon, 12 Dec 2022 10:51:06 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     Ian Rogers <irogers@google.com>,
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
Message-ID: <Y5cxyk3OdgFXlyhS@kernel.org>
References: <Y491d1wEW4TfUi5f@kernel.org>
 <Y4921D+36UGdhK92@kernel.org>
 <Y494TNa0ZyPH9YSD@kernel.org>
 <Y498YP2N3gvFSr/X@kernel.org>
 <C9F248C8-AF8D-40A1-A1AD-BCC39FBA01C7@linux.vnet.ibm.com>
 <Y5DNBZNC5rBBqlJW@kernel.org>
 <36CD1041-0CAE-41C1-8086-C17854531B3E@linux.vnet.ibm.com>
 <Y5JfgyN59dSeKbUP@kernel.org>
 <Y5Jl8MeW90DXy1wT@kernel.org>
 <8F6F0C27-53F3-4837-A19C-845768253249@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8F6F0C27-53F3-4837-A19C-845768253249@linux.vnet.ibm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Fri, Dec 09, 2022 at 12:04:18PM +0530, Athira Rajeev escreveu:
> 
> 
> > On 09-Dec-2022, at 4:02 AM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > 
> > Em Thu, Dec 08, 2022 at 07:04:52PM -0300, Arnaldo Carvalho de Melo escreveu:
> >> Em Thu, Dec 08, 2022 at 12:21:20PM +0530, Athira Rajeev escreveu:
> >>>> On 07-Dec-2022, at 10:57 PM, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >>>> Can you try again? tmp.perf/core? That "tmp." part means its a force
> >>>> pushed branch, so I just force pushed with some arch specific fixes, now
> >>>> I'm down to (removing the successful builds and unrelated failures, now
> >>>> related to libbpf's F_DUPFD_CLOEXEC kaboom):
> >> 
> >>> Ok Arnaldo, Sure, I will check with updated branch
> >> 
> >>>>  5     7.38 fedora:34                     : FAIL gcc version 11.3.1 20220421 (Red Hat 11.3.1-2) (GCC)
> >>>>   /git/perf-6.1.0-rc6/tools/perf/util/evsel.c: In function ‘evsel__rawptr’:
> >>>>   /git/perf-6.1.0-rc6/tools/perf/util/evsel.c:2787:36: error: ‘TEP_FIELD_IS_RELATIVE’ undeclared (first use in this function); did you mean ‘TEP_FIELD_IS_FLAG’?
> >>>>    2787 |                 if (field->flags & TEP_FIELD_IS_RELATIVE)
> >>>>         |                                    ^~~~~~~~~~~~~~~~~~~~~
> >>>>         |                                    TEP_FIELD_IS_FLAG
> >> 
> >>> I observed same issue as updated here: 
> >>> https://lore.kernel.org/lkml/10476A85-3F75-4C91-AB5B-E5B136F31297@linux.vnet.ibm.com/
> >> 
> >>> Looks like TEP_FIELD_IS_RELATIVE is not defined in header file of the system installed version.
> >>> whereas it is there in header file in tools/lib/traceevent
> >> 
> >>> # grep TEP_FIELD_IS_RELATIVE /usr/include/traceevent/event-parse.h
> >>> # grep TEP_FIELD_IS_RELATIVE ../lib/traceevent/event-parse.h
> >>> 	TEP_FIELD_IS_RELATIVE	= 256,
> >> 
> >> Right, I had noticed that as well, so as a prep patch I'm adding the
> >> patch below, before Ian's. Please check and provide an
> >> Acked-by/Tested-by/Reviewed-by if possible.
> > 
> > I ended up with the one below, _after_ Ian's patch as I had some trouble grafting
> > it before and had already tested it this way multiple times, I'm pushing
> > this to tmp/perf.core.
> > 
> > - Arnaldo
> 
> 
> Hi Arnaldo, Ian
> 
> Thanks for the fixes.
> 
> Since we changed “CONFIG_TRACEEVENT” to “CONFIG_LIBTRACEEVENT”, 
> below change is also needed in “arch/powerpc/util/Build”
> 
> diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/powerpc/util/Build
> index 71e57f28abda..9889245c555c 100644
> --- a/tools/perf/arch/powerpc/util/Build
> +++ b/tools/perf/arch/powerpc/util/Build
> @@ -1,5 +1,5 @@
>  perf-y += header.o
> -perf-$(CONFIG_TRACEEVENT) += kvm-stat.o
> +perf-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
>  perf-y += perf_regs.o
>  perf-y += mem-events.o
>  perf-y += sym-handling.o
> 
> With this change, I could successfully compile in these environment:
> - Without libtraceevent-devel installed
> - With libtraceevent-devel installed
> - With “make NO_LIBTRACEEVENT=1”
> 
> With above change,
> Acked-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

I did that and the same thing for other architectures, thanks for
testing!

I'll now give a try at implementing it without
tools/build/feature/test-libtraceevent-tep_field_is_relative.c, using
just the version of libtraceevent, as Ian suggested.

It would be great if you could test it again then,

Thanks,

- Arnaldo


diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
index 88553c578ed7a1c4..78ef7115be3d91a7 100644
--- a/tools/perf/arch/arm64/util/Build
+++ b/tools/perf/arch/arm64/util/Build
@@ -3,7 +3,7 @@ perf-y += machine.o
 perf-y += perf_regs.o
 perf-y += tsc.o
 perf-y += pmu.o
-perf-$(CONFIG_TRACEEVENT) += kvm-stat.o
+perf-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
 perf-$(CONFIG_DWARF)     += dwarf-regs.o
 perf-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
 perf-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/powerpc/util/Build
index 71e57f28abdac7e9..9889245c555c4cfb 100644
--- a/tools/perf/arch/powerpc/util/Build
+++ b/tools/perf/arch/powerpc/util/Build
@@ -1,5 +1,5 @@
 perf-y += header.o
-perf-$(CONFIG_TRACEEVENT) += kvm-stat.o
+perf-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
 perf-y += perf_regs.o
 perf-y += mem-events.o
 perf-y += sym-handling.o
diff --git a/tools/perf/arch/s390/util/Build b/tools/perf/arch/s390/util/Build
index aa8a5f05c9cb4706..db68840869979f2c 100644
--- a/tools/perf/arch/s390/util/Build
+++ b/tools/perf/arch/s390/util/Build
@@ -1,5 +1,5 @@
 perf-y += header.o
-perf-$(CONFIG_TRACEEVENT) += kvm-stat.o
+perf-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
 perf-y += perf_regs.o
 
 perf-$(CONFIG_DWARF) += dwarf-regs.o
