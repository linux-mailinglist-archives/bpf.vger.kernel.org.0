Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE858314902
	for <lists+bpf@lfdr.de>; Tue,  9 Feb 2021 07:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhBIGk0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 01:40:26 -0500
Received: from smtprelay0146.hostedemail.com ([216.40.44.146]:58882 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230409AbhBIGjw (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 9 Feb 2021 01:39:52 -0500
X-Greylist: delayed 531 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Feb 2021 01:39:52 EST
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave05.hostedemail.com (Postfix) with ESMTP id DBF02183044FA
        for <bpf@vger.kernel.org>; Tue,  9 Feb 2021 06:32:19 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 6A67B1801DFD5;
        Tue,  9 Feb 2021 06:31:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3653:3865:3867:3870:3871:4250:4321:5007:6119:6120:7652:7901:10004:10400:10848:11232:11657:11658:11783:11914:12043:12297:12740:12895:13069:13255:13311:13357:13439:13894:14093:14097:14181:14659:21080:21221:21433:21451:21611:21627:30054:30056:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: cow26_5d01d3b27605
X-Filterd-Recvd-Size: 2068
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Tue,  9 Feb 2021 06:31:20 +0000 (UTC)
Message-ID: <9022d7bcb1743c20dbeedc729c12d93877cb70fe.camel@perches.com>
Subject: Re: [PATCH] checkpatch: do not apply "initialise globals to 0"
 check to BPF progs
From:   Joe Perches <joe@perches.com>
To:     Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org
Cc:     bpf@vger.kernel.org, Andy Whitcroft <apw@canonical.com>
Date:   Mon, 08 Feb 2021 22:31:19 -0800
In-Reply-To: <20210208234002.3294265-1-songliubraving@fb.com>
References: <20210208234002.3294265-1-songliubraving@fb.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2021-02-08 at 15:40 -0800, Song Liu wrote:
> BPF programs explicitly initialise global variables to 0 to make sure
> clang (v10 or older) do not put the variables in the common section.
> Skip "initialise globals to 0" check for BPF programs to elimiate error
> messages like:
> 
>     ERROR: do not initialise globals to 0
>     #19: FILE: samples/bpf/tracex1_kern.c:21:

Another possible option is simply to add --ignore=GLOBAL_INITIALISERS
to the checkpatch command line for these files.

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -4323,7 +4323,11 @@ sub process {
>  		}
>  
> 
>  # check for global initialisers.
> -		if ($line =~ /^\+$Type\s*$Ident(?:\s+$Modifier)*\s*=\s*($zero_initializer)\s*;/) {
> +# Do not apply to BPF programs (tools/testing/selftests/bpf/progs/*.c, samples/bpf/*_kern.c, *.bpf.c).
> +		if ($line =~ /^\+$Type\s*$Ident(?:\s+$Modifier)*\s*=\s*($zero_initializer)\s*;/ &&
> +		    $realfile !~ /^tools\/testing\/selftests\/bpf\/progs\/.*\.c/ &&
> +		    $realfile !~ /^samples\/bpf\/.*_kern.c/ &&
> +		    $realfile !~ /.bpf.c$/) {
>  			if (ERROR("GLOBAL_INITIALISERS",
>  				  "do not initialise globals to $1\n" . $herecurr) &&
>  			    $fix) {


