Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C503CEF53
	for <lists+bpf@lfdr.de>; Tue, 20 Jul 2021 00:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239463AbhGSVui (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Jul 2021 17:50:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:37384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1384235AbhGSU1n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Jul 2021 16:27:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C6ED610C7;
        Mon, 19 Jul 2021 21:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626728887;
        bh=7eFbYtvqKA2FgZBPuzkQnIE3qDGBGh8FT3+MBGuGPNw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tHxp9fRlaYNang1g2AF0Ja0bO8LK1yIrhKZs+U0vPIFUowQdytaImSGQWQWu2FQYZ
         kVaA0DvpQMtFNkBnAD6vDan59o+Pbt/nD5BAUspRJTa4bSeH1v3uJUpPDkm/jAYEPD
         EcibVvjmNd/N9lecPIn0dupvwbqoxd1PutoDwbsQ/dZiFQBlB79haEtbcnyBmD3o1A
         pnrfFg+kHrxDC1Yt0jKE4BmxoN02o3maFkGg0GWj6d9kbg3lUdW4mxlWXiJPiy5w4O
         5CzSuxDymAYHCWFIANlKaprFseXJm35t2vVjhDJbn1LdpbLC3eb+BEQwpeuNNVgjyx
         gMF02Vm0p9dLw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3C446403F2; Mon, 19 Jul 2021 18:08:04 -0300 (-03)
Date:   Mon, 19 Jul 2021 18:08:04 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Luca Boccassi <bluca@debian.org>
Cc:     Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [RFT] Testing 1.22
Message-ID: <YPXptNw0ssvLNWRQ@kernel.org>
References: <YK+41f972j25Z1QQ@kernel.org>
 <20210715213120.GJ24916@kitsune.suse.cz>
 <YPGIxJao9SrsiG9X@kernel.org>
 <d5b963695314f66240b96f5699a78f0d980a0b44.camel@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d5b963695314f66240b96f5699a78f0d980a0b44.camel@debian.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Jul 19, 2021 at 01:10:52PM +0100, Luca Boccassi escreveu:
> On Fri, 2021-07-16 at 10:25 -0300, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Jul 15, 2021 at 11:31:20PM +0200, Michal Suchánek escreveu:
> > > Hello,
> > > 
> > > when building with system libbpf I get:
> > > 
> > > [   40s] make[1]: Nothing to be done for 'preinstall'.
> > > [   40s] make[1]: Leaving directory '/home/abuild/rpmbuild/BUILD/dwarves-1.21+git175.1ef87b2/build'
> > > [   40s] Install the project...
> > > [   40s] /usr/bin/cmake -P cmake_install.cmake
> > > [   40s] -- Install configuration: "RelWithDebInfo"
> > > [   40s] -- Installing: /home/abuild/rpmbuild/BUILDROOT/dwarves-1.21+git175.1ef87b2-15.1.ppc64le/usr/bin/codiff
> > > [   40s] CMake Error at cmake_install.cmake:63 (file):
> > > [   40s]   file RPATH_CHANGE could not write new RPATH:
> > > [   40s] 
> > > [   40s]     
> > > [   40s] 
> > > [   40s]   to the file:
> > > [   40s] 
> > > [   40s]     /home/abuild/rpmbuild/BUILDROOT/dwarves-1.21+git175.1ef87b2-15.1.ppc64le/usr/bin/codiff
> > > [   40s] 
> > > [   40s]   The current RUNPATH is:
> > > [   40s] 
> > > [   40s]     /home/abuild/rpmbuild/BUILD/dwarves-1.21+git175.1ef87b2/build:
> > > [   40s] 
> > > [   40s]   which does not contain:
> > > [   40s] 
> > > [   40s]     /usr/local/lib64:/home/abuild/rpmbuild/BUILD/dwarves-1.21+git175.1ef87b2/build:
> > > [   40s] 
> > > [   40s]   as was expected.
> > > [   40s] 
> > > [   40s] 
> > > [   40s] make: *** [Makefile:74: install] Error 1
> > > [   40s] make: Leaving directory '/home/abuild/rpmbuild/BUILD/dwarves-1.21+git175.1ef87b2/build'
> > > [   40s] error: Bad exit status from /var/tmp/rpm-tmp.OaGNX4 (%install)
> > > 
> > > This is not a problem with embedded libbpf.
> > > 
> > > Using system libbpf seems to be new in 1.22
> > 
> > Lucca, can you take a look at this?
 
> Arnaldo, just to give you a quick summary and close the loop in case
> you haven't followed the (very verbose) thread: the root cause was a
> packaging issue of libbpf in SUSE, which is now solved, and the
> reported build problem is now gone:
> 
> https://build.opensuse.org/package/show/home:michals/dwarves

Thanks a lot for taking care of this, appreciated.

- Arnaldo
