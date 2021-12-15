Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6C0475B21
	for <lists+bpf@lfdr.de>; Wed, 15 Dec 2021 15:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243570AbhLOO4Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Dec 2021 09:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237581AbhLOO4Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Dec 2021 09:56:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B46C061574;
        Wed, 15 Dec 2021 06:56:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A0E261926;
        Wed, 15 Dec 2021 14:56:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D04C34606;
        Wed, 15 Dec 2021 14:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639580183;
        bh=q+PAwVA3hA+XAhkskemgn4L0uXS+xZdMC81JEaAee+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B/iDNpR6h+hL0e1YRBM881u2j27FMncSdty5BhYRunWFI0uML8+Yr4JjUH75DFFOI
         1r2G1MDosuXV/qyo8ZYJSvMuSEdF0yZHubAYSbXqCeVvgCQuBDUv/6VjiIno3rDdtY
         ODWiEa2O/1N5YOcTGAeldswmqvC5/GKtbhXGn25QKXgHP41Ew27vi12CRW6Xygs+Un
         FCk+n2E0vkPhD1E6WyNGI7PmUlXRd+IJW0qyvSuH4kjIX1N+EnTQFYNtjXfCmlvIFt
         wpV2s+K9uIsg0OtN+hbwl8IghINcrlLJ/+wtmZGh665ibD6eZ5X3YsSqQ27ui/uE0L
         1h19IxIbsZtZw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C81C6405D8; Wed, 15 Dec 2021 11:56:19 -0300 (-03)
Date:   Wed, 15 Dec 2021 11:56:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     dwarves@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Jan Engelhardt <jengelh@inai.de>,
        Domenico Andreoli <domenico.andreoli@linux.com>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Yonghong Song <yhs@fb.com>,
        Douglas RAILLARD <douglas.raillard@arm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Matteo Croce <mcroce@microsoft.com>
Subject: Re: ANNOUNCE: pahole v1.23 (BTF tags and alignment inference)
Message-ID: <YboCE3zig9papNQW@kernel.org>
References: <YSQSZQnnlIWAQ06v@kernel.org>
 <YbC5MC+h+PkDZten@kernel.org>
 <YbkTAPn3EEu6BUYR@archlinux-ax161>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbkTAPn3EEu6BUYR@archlinux-ax161>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Dec 14, 2021 at 02:56:16PM -0700, Nathan Chancellor escreveu:
> Hi Arnaldo,
> 
> On Wed, Dec 08, 2021 at 10:54:56AM -0300, Arnaldo Carvalho de Melo wrote:
> > - Initial support for DW_TAG_skeleton_unit, so far just suggest looking up a
> >   matching .dwo file to be used instead. Automagically doing this is in the
> >   plans for a future release.
> 
> This change [1] appears to break building on older distributions for me,
> which I use in containers for access to older versions of GCC. I see the
> error with Debian Stretch and Ubuntu Xenial, which have an older
> libelf-dev.  Is this expected? I don't mind sticking with 1.22 for
> those, I just want to be sure!

Nope, not expected, I'll reproduce here, fix and push, thanks for the
report.

- Arnaldo
 
> /tmp/dwarves-1.23/dwarf_loader.c: In function 'die__process':
> /tmp/dwarves-1.23/dwarf_loader.c:2529:13: error: 'DW_TAG_skeleton_unit' undeclared (first use in this function)
>   if (tag == DW_TAG_skeleton_unit) {
>              ^
> 
> [1]: https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=0135ccd632796ab3aff65b7c99b374c4682c2bcf
> 
> Cheers,
> Nathan

-- 

- Arnaldo
