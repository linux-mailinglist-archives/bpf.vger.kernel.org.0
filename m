Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A55843158EE
	for <lists+bpf@lfdr.de>; Tue,  9 Feb 2021 22:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbhBIVqj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 16:46:39 -0500
Received: from smtprelay0161.hostedemail.com ([216.40.44.161]:40710 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234337AbhBIVNo (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 9 Feb 2021 16:13:44 -0500
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave08.hostedemail.com (Postfix) with ESMTP id 306B8182D512B;
        Tue,  9 Feb 2021 19:02:15 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id D26D7182CCCB9;
        Tue,  9 Feb 2021 18:59:32 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 90,9,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2691:2828:3138:3139:3140:3141:3142:3353:3622:3653:3865:3867:3868:3870:3871:3872:3873:4250:4321:5007:6119:6120:6248:7652:7901:7903:7904:10004:10400:10848:11026:11232:11658:11783:11914:12043:12297:12438:12740:12895:13069:13255:13311:13357:13439:13894:14093:14097:14181:14659:14721:14777:21080:21433:21451:21611:21627:21740:21741:21990:30012:30054:30056:30064:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: road65_270c81827609
X-Filterd-Recvd-Size: 2565
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Tue,  9 Feb 2021 18:59:31 +0000 (UTC)
Message-ID: <2b41e46fcf909bd67a578524107214fe4b1eeede.camel@perches.com>
Subject: Re: [PATCH v3] checkpatch: do not apply "initialise globals to 0"
 check to BPF progs
From:   Joe Perches <joe@perches.com>
To:     Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org
Cc:     bpf@vger.kernel.org, Andy Whitcroft <apw@canonical.com>
Date:   Tue, 09 Feb 2021 10:59:30 -0800
In-Reply-To: <20210209183343.3929160-1-songliubraving@fb.com>
References: <20210209183343.3929160-1-songliubraving@fb.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2021-02-09 at 10:33 -0800, Song Liu wrote:
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
> Changes v2 => v3:
>   1. Fix regex.

Unfortunately, this has broken regexes...

> Changes v1 => v2:
>   1. Add function exclude_global_initialisers() to keep the code clean.
> ---
>  scripts/checkpatch.pl | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
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
> +	return $realfile =~ m@/^tools\/testing\/selftests\/bpf\/progs\/.*\.c@ ||

You don't need to escape the / when using m@@, and this doesn't work
given the leading / after @, and it should use a trailing $

	return $realfile =~ m@^tools/testing/selftests/bpf/progs/.*\.c$@ ||

> +		$realfile =~ m@^samples\/bpf\/.*_kern.c@ ||

This is still missing an escape on the . before c@, and there's no
trailing $ between c and @

		$realfile =~ m@^samples/bpf/.*_kern\.c$@ ||

> +		$realfile =~ m@/bpf/.*\.bpf\.c$@;

I believe I showed the correct regexes in my earlier reply.


