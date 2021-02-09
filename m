Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146CF315511
	for <lists+bpf@lfdr.de>; Tue,  9 Feb 2021 18:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbhBIR1Z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 12:27:25 -0500
Received: from smtprelay0109.hostedemail.com ([216.40.44.109]:55350 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233196AbhBIR1K (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 9 Feb 2021 12:27:10 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 02FF41821C6A6;
        Tue,  9 Feb 2021 17:24:18 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3653:3865:3867:3868:3870:3871:4250:4321:4362:5007:6119:6120:7652:7774:7901:10004:10400:11026:11232:11657:11658:11783:11914:12043:12297:12438:12740:12895:13161:13225:13229:13255:13439:13894:14093:14096:14097:14181:14659:14721:21080:21433:21451:21611:21627:21990:30012:30041:30054:30056:30064:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:7,LUA_SUMMARY:none
X-HE-Tag: flock94_3b0d3f127609
X-Filterd-Recvd-Size: 3474
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Tue,  9 Feb 2021 17:24:16 +0000 (UTC)
Message-ID: <f20f16691faba583f8d8970e02827c88dd9fb49e.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: do not apply "initialise globals to 0"
 check to BPF progs
From:   Joe Perches <joe@perches.com>
To:     Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org
Cc:     bpf@vger.kernel.org, Andy Whitcroft <apw@canonical.com>
Date:   Tue, 09 Feb 2021 09:24:15 -0800
In-Reply-To: <20210209170013.3475063-1-songliubraving@fb.com>
References: <20210209170013.3475063-1-songliubraving@fb.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2021-02-09 at 09:00 -0800, Song Liu wrote:
> BPF programs explicitly initialise global variables to 0 to make sure
> clang (v10 or older) do not put the variables in the common section.
> Skip "initialise globals to 0" check for BPF programs to elimiate error
> messages like:
> 
>     ERROR: do not initialise globals to 0
>     #19: FILE: samples/bpf/tracex1_kern.c:21:
> 
> Cc: Andy Whitcroft <apw@canonical.com>
> Cc: Joe Perches <joe@perches.com>
> Signed-off-by: Song Liu <songliubraving@fb.com>
> 
> ---
> Changes v1 => v2:
>   1. Add function exclude_global_initialisers() to keep the code clean.

thanks.  trivia and a question:

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -2428,6 +2428,15 @@ sub get_raw_comment {
>  	return $comment;
>  }
> 
> +sub exclude_global_initialisers {
> +	my ($realfile) = @_;
> +
> +	# Do not check for BPF programs (tools/testing/selftests/bpf/progs/*.c, samples/bpf/*_kern.c, *.bpf.c).
> +	return $realfile =~ /^tools\/testing\/selftests\/bpf\/progs\/.*\.c/ ||
> +		$realfile =~ /^samples\/bpf\/.*_kern.c/ ||

The checkpatch convention commonly used for $realfile comparisons
to file patterns with directory paths is m@...@

	return $realfile =~ m@^tools/testing/selftests/bpf/progs/.*\.c@ ||
		$realfile =~ m@^samples/bpf/.*_kern\.c@ ||

> +		$realfile =~ /.bpf.c$/;

And lastly, is this pattern meant to escape the periods?
I presume so, but if not, the leading period isn't useful.

Maybe:
		$realfile =~ m@/bpf/.*\.bpf\.c$@;

$ git ls-files | grep "\.bpf\.c$"
kernel/bpf/preload/iterators/iterators.bpf.c
tools/bpf/bpftool/skeleton/pid_iter.bpf.c
tools/bpf/bpftool/skeleton/profiler.bpf.c
tools/bpf/runqslower/runqslower.bpf.c

vs

$ git ls-files | grep ".bpf.c$"
drivers/net/hyperv/netvsc_bpf.c
drivers/net/netdevsim/bpf.c
kernel/bpf/preload/iterators/iterators.bpf.c
lib/test_bpf.c
net/core/lwt_bpf.c
net/ipv4/tcp_bpf.c
net/ipv4/udp_bpf.c
net/netfilter/xt_bpf.c
net/sched/act_bpf.c
net/sched/cls_bpf.c
samples/bpf/test_lwt_bpf.c
tools/bpf/bpftool/skeleton/pid_iter.bpf.c
tools/bpf/bpftool/skeleton/profiler.bpf.c
tools/bpf/runqslower/runqslower.bpf.c
tools/build/feature/test-bpf.c
tools/build/feature/test-libbpf.c
tools/lib/bpf/bpf.c
tools/lib/bpf/libbpf.c
tools/perf/tests/bpf.c
tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
tools/testing/selftests/bpf/prog_tests/xdp_bpf2bpf.c
tools/testing/selftests/bpf/progs/fexit_bpf2bpf.c
tools/testing/selftests/bpf/progs/test_xdp_bpf2bpf.c
tools/testing/selftests/net/reuseport_bpf.c
tools/testing/selftests/seccomp/seccomp_bpf.c


