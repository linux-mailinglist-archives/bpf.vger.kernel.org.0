Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6008315E19
	for <lists+bpf@lfdr.de>; Wed, 10 Feb 2021 05:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhBJENX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 23:13:23 -0500
Received: from smtprelay0123.hostedemail.com ([216.40.44.123]:33622 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229979AbhBJENR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 9 Feb 2021 23:13:17 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 6351E18538497;
        Wed, 10 Feb 2021 04:12:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2110:2393:2553:2559:2562:2689:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4250:4321:5007:6119:6120:7652:7901:7903:10004:10400:10848:11232:11658:11914:12297:12740:12760:12895:13069:13161:13229:13255:13311:13357:13439:14096:14097:14181:14659:14721:21080:21611:21627:21740:30041:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: fruit02_2e00bfb2760d
X-Filterd-Recvd-Size: 1988
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Wed, 10 Feb 2021 04:12:29 +0000 (UTC)
Message-ID: <2c5ba548a8148afa2aa03cc2d9a2d71ca85f74e7.camel@perches.com>
Subject: Re: [PATCH v4] checkpatch: do not apply "initialise globals to 0"
 check to BPF progs
From:   Joe Perches <joe@perches.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Andy Whitcroft <apw@canonical.com>
Date:   Tue, 09 Feb 2021 20:12:28 -0800
In-Reply-To: <F5609C13-E5D7-47C2-94C2-F4C2443352C4@fb.com>
References: <20210209211954.490077-1-songliubraving@fb.com>
         <2b4805f6ca2b44f4195b6fdba4f82d5e90ab1989.camel@perches.com>
         <F5609C13-E5D7-47C2-94C2-F4C2443352C4@fb.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2021-02-10 at 04:07 +0000, Song Liu wrote:
> > On Feb 9, 2021, at 6:10 PM, Joe Perches <joe@perches.com> wrote:
> > On Tue, 2021-02-09 at 13:19 -0800, Song Liu wrote:
> > > BPF programs explicitly initialise global variables to 0 to make sure
> > > clang (v10 or older) do not put the variables in the common section.
> > 
> > Acked-by: Joe Perches <joe@perches.com>
> > 
> > So the patch is OK now, but I have a question about the concept:
> > 
> > Do you mean that these initialized to 0 global variables
> > should go into bss or another section?
> 
> We want these variables to go to bss. 

OK, then the patch is fine.

> > Perhaps it'd be useful to somehow mark variables into specific
> > sections rather than bss when initialized to 0 and data when not
> > initialized to 0.
> 
> Currently, libbpf expects zero initialized global data in bss. This 
> convention works well so far. Is there any reason that we specify 
> section for global data? 

There's no need I know of.

cheers, Joe

