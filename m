Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A89B9B1676
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2019 00:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfILWvp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Sep 2019 18:51:45 -0400
Received: from smtprelay0065.hostedemail.com ([216.40.44.65]:33884 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726778AbfILWvo (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 12 Sep 2019 18:51:44 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 478BE18224D66;
        Thu, 12 Sep 2019 22:51:43 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2194:2195:2199:2200:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4250:4321:5007:6119:6691:7514:7903:8545:9010:10004:10400:10848:11026:11232:11658:11914:12043:12296:12297:12346:12438:12679:12740:12760:12895:13019:13069:13311:13357:13439:13891:14180:14181:14659:14721:21060:21080:21451:21627:21740:30054:30091,0,RBL:47.151.152.152:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:26,LUA_SUMMARY:none
X-HE-Tag: wash29_66372152c7216
X-Filterd-Recvd-Size: 1955
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Thu, 12 Sep 2019 22:51:42 +0000 (UTC)
Message-ID: <b5cd34b624f07ed136178724f208f027644f36a5.camel@perches.com>
Subject: Re: Strange scripts/get_maintainer.pl output
From:   Joe Perches <joe@perches.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Date:   Thu, 12 Sep 2019 15:51:41 -0700
In-Reply-To: <CANiq72kQUvnVq0U-okpND8L5xueHs4o3-mKMNX8_P0n5uZw+-w@mail.gmail.com>
References: <CANiq72kQUvnVq0U-okpND8L5xueHs4o3-mKMNX8_P0n5uZw+-w@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2019-09-13 at 00:25 +0200, Miguel Ojeda wrote:
> Hi Joe,

Hey Miguel.

> I was preparing the RFC for the clang-format stuff and I ran:
> 
>   scripts/get_maintainer.pl -f .clang-format
> 
> But it seems I (also) got the people from the BPF entry for some
> reason. Maybe the dot messes with some regex? (although other
> dot-files seem to work). I could try to solve it, but my Perl-fu is
> weak and you are the wizard of get_maintainer.pl anyway... :-)

It's not perl, it's the entry for
	K: bpf
in the BPF section.

BPF (Safe dynamic programs and tools)
M:	Alexei Starovoitov <ast@kernel.org>
M:	Daniel Borkmann <daniel@iogearbox.net>
[...]
K:	bpf
N:	bpf

This K: entry matches a _lot_ of files that contain bpf.

For instance, the .clang-format file has:

$ git grep bpf .clang-format
.clang-format:  - 'bpf_for_each_spilled_reg'

If you use --no-keywords, you get:

$ ./scripts/get_maintainer.pl -f --no-keywords .clang-format
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> (maintainer:CLANG-FORMAT FILE)
linux-kernel@vger.kernel.org (open list)



