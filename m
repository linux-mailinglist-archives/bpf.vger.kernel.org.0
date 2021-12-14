Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66270474D65
	for <lists+bpf@lfdr.de>; Tue, 14 Dec 2021 22:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235666AbhLNV4Z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Dec 2021 16:56:25 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34232 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234861AbhLNV4Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Dec 2021 16:56:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3988FB81D49;
        Tue, 14 Dec 2021 21:56:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926BFC34600;
        Tue, 14 Dec 2021 21:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639518981;
        bh=MzBJWW9p6mkqRrejapuPq5D9phAL3P9paARsZzc8en0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V9hPiNKzH3rQ0n3lqhI+Iy6b6MAmyYBW3/x42pDKmwQhi2xOJPhI4PuqLPyHDT9HP
         K+mIhhu0yjiQOfurpq4z3drzmNL/9IfxKvXZ/b8EVKrTWToTQaxLdww5kHA90cbWl6
         e1C+Y+UJZD7S851Wf1YzKOB89L9HDegC+GqZdTd1uEgROZYZadg2WGCCB/0qtrvBfF
         nnGy5MZqTEn757tdixtOxZmoJKQvbM3C+Ct2pxHox7dLRhEX3mqd38W2FhI44BnGvM
         NDQcC1jJv5ewUI588pY4YgcpzH5LqYNYfbAFl0QGI2Z3C6eQCtQiHrUnxP2KUKkkY1
         LMHDCgBplGJKg==
Date:   Tue, 14 Dec 2021 14:56:16 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
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
Message-ID: <YbkTAPn3EEu6BUYR@archlinux-ax161>
References: <YSQSZQnnlIWAQ06v@kernel.org>
 <YbC5MC+h+PkDZten@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbC5MC+h+PkDZten@kernel.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Arnaldo,

On Wed, Dec 08, 2021 at 10:54:56AM -0300, Arnaldo Carvalho de Melo wrote:
> - Initial support for DW_TAG_skeleton_unit, so far just suggest looking up a
>   matching .dwo file to be used instead. Automagically doing this is in the
>   plans for a future release.

This change [1] appears to break building on older distributions for me,
which I use in containers for access to older versions of GCC. I see the
error with Debian Stretch and Ubuntu Xenial, which have an older
libelf-dev.  Is this expected? I don't mind sticking with 1.22 for
those, I just want to be sure!

/tmp/dwarves-1.23/dwarf_loader.c: In function 'die__process':
/tmp/dwarves-1.23/dwarf_loader.c:2529:13: error: 'DW_TAG_skeleton_unit' undeclared (first use in this function)
  if (tag == DW_TAG_skeleton_unit) {
             ^

[1]: https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=0135ccd632796ab3aff65b7c99b374c4682c2bcf

Cheers,
Nathan
