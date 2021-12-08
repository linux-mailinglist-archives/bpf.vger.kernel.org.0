Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1183246DB33
	for <lists+bpf@lfdr.de>; Wed,  8 Dec 2021 19:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239018AbhLHSjO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Dec 2021 13:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239011AbhLHSjN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Dec 2021 13:39:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387FEC061746;
        Wed,  8 Dec 2021 10:35:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 005BEB8225D;
        Wed,  8 Dec 2021 18:35:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8508CC00446;
        Wed,  8 Dec 2021 18:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638988538;
        bh=f0Wxhz3A50mdmo1JOAqxqkjeSrTNeYV6wNaASAItEPY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q3CNwXp7saaX0WEGY7R10UvsofC0mcSv/rjCjYowmMKJhOEMX5tzTKNDNO3TFFdAu
         863vwoRg0y8yjqsk4j2XIiRcTfkUNUogrDQsiEFNTT5slYbR+QVKfhYm2YtN0FPrIL
         n5eqizc1dxojF2UxioaOrOyvo3Onh3juy+/JzayYxPasUPTSJhkq9whbZZbeyHvX0J
         ipy0Ej/skV186nd80Ecv4c1z723MtdGMtmmaf608Qsmu1D+hUP80RF2y98VTd2HDoL
         qWZBvD/Um4AagnOkbfkIzsS2ENsiNkg6ccnRC02Sp03ikSeXrIMx51eWmAJt2NVHIw
         xHxZ8gJugV4Hw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 07DB0406C1; Wed,  8 Dec 2021 15:35:35 -0300 (-03)
Date:   Wed, 8 Dec 2021 15:35:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     dwarves@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Domenico Andreoli <domenico.andreoli@linux.com>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Yonghong Song <yhs@fb.com>,
        Douglas RAILLARD <douglas.raillard@arm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Matteo Croce <mcroce@microsoft.com>
Subject: Re: ANNOUNCE: pahole v1.23 (BTF tags and alignment inference)
Message-ID: <YbD696GWcp+KeMyg@kernel.org>
References: <YSQSZQnnlIWAQ06v@kernel.org>
 <YbC5MC+h+PkDZten@kernel.org>
 <1587op7-6246-638r-5815-2ops848q5r4@vanv.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587op7-6246-638r-5815-2ops848q5r4@vanv.qr>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Dec 08, 2021 at 03:26:31PM +0100, Jan Engelhardt escreveu:
> 
> On Wednesday 2021-12-08 14:54, Arnaldo Carvalho de Melo wrote:
> > 
> >	The v1.23 release of pahole and its friends is out, this time
> >the main new features are the ability to encode BTF tags, to carry
> 
> [    7s] /home/abuild/rpmbuild/BUILD/dwarves-1.23/btf_encoder.c:145:10: error: 'BTF_KIND_DECL_TAG' undeclared here (not in a function); did you mean 'BTF_KIND_FLOAT'?
> 
> libbpf-0.5.0 is present, since CMakeLists.txt checked for >= 0.4.0.

My fault, knowing the flux that libbpf is in getting to 1.0 I should
have retested with the perf tools container based tests.

Can you think about some fix for that? Lemme see if BTF_KIND_DECL_TAG is
a define or an enum...
 
> The 1.23 tag is missing from git.

pushed out, thanks for pointing it out.

> Is git://git.kernel.org/pub/scm/devel/pahole/pahole out of date? (Last commit
> from October 2021)

-- 

- Arnaldo
