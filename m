Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F00445969
	for <lists+bpf@lfdr.de>; Thu,  4 Nov 2021 19:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234092AbhKDSOX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Nov 2021 14:14:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:55988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231971AbhKDSOX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Nov 2021 14:14:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 065F56120D;
        Thu,  4 Nov 2021 18:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636049505;
        bh=UvToKl26gPPfVl3jvr/V/GxzhNVjJVQZXBTGi0GHlRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fIM7S5ZiCQq/i8nkammap4QpV5g2mjE1hHtqqNxH2LZ4lC7Cia3JEbE1rjnU83eco
         2j/nCccaNCwV+JIPBw1r91/uqqOIZJWxHye4RoaspiWsgUMBb9y0ao1WVbE39ksHCk
         JsxMqptOpfM1boB0vqkiIl3rjLyF0MtuV+VXfU8UWexjfVNbOrdJk49aQdLJvCHBWZ
         sJ6dQamoWbZD9Jvlg0jkvG4rnYBi1NH4QH62hAMVewMBeMLcAKvKw6dWc/WxK3jsJW
         mDqG5UsHLOE8g28IVEqFVcoH3P/DzMDr1Wuk4gy0qjKwegi8/pQuP0/FAOELNkB8NX
         aCPgNevvAH1EQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7815A410A1; Thu,  4 Nov 2021 15:11:42 -0300 (-03)
Date:   Thu, 4 Nov 2021 15:11:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Song Liu <songliubraving@fb.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: perf build broken looking for bpf/{libbpf,bpf}.h after merge
 with upstream
Message-ID: <YYQiXnUxlOoWMdwZ@kernel.org>
References: <YYQadWbtdZ9Ff9N4@kernel.org>
 <YYQdKijyt20cBQik@kernel.org>
 <CAEf4BzYtq5Fru0_=Stih+Tjya3i29xG+RSF=4oOT7GbUwVRQaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYtq5Fru0_=Stih+Tjya3i29xG+RSF=4oOT7GbUwVRQaQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Nov 04, 2021 at 10:56:26AM -0700, Andrii Nakryiko escreveu:
> On Thu, Nov 4, 2021 at 10:49 AM Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:

> > Em Thu, Nov 04, 2021 at 02:37:57PM -0300, Arnaldo Carvalho de Melo escreveu:
> > >
> > > Hi Song,
> > >
> > >       I just did a merge with upstream and I'm getting this:
> > >
> > >   LINK    /tmp/build/perf/plugins/plugin_scsi.so
> > >   INSTALL trace_plugins
> >
> > To clarify, the command line to build perf that results in this problem
> > is:
> >
> >   make -k BUILD_BPF_SKEL=1 CORESIGHT=1 PYTHON=python3 O=/tmp/build/perf -C tools/perf install-bin
> 
> Oh, I dropped CORESIGN and left BUILD_BPF_SKEL=1 and yeah, I see the
> build failure. I do think now that it's related to the recent Makefile
> revamp effort. Quentin, PTAL.
> 
> On the side note, why BUILD_BPF_SKEL=1 is not a default, we might have
> caught this sooner. Is there any reason not to flip the default?

I asked Song in the past about this, and asked again on another reply to
this thread, I think it should be the default.

Song, Namhyung? You're the skel guys (so far) :-)

- Arnaldo
