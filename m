Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35933CC47B
	for <lists+bpf@lfdr.de>; Sat, 17 Jul 2021 18:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbhGQQjZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 17 Jul 2021 12:39:25 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:52616 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhGQQjZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 17 Jul 2021 12:39:25 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 807951FF2B;
        Sat, 17 Jul 2021 16:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626539787; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=17Co4vPLX3kzsJLWFYnIoxlVA1exz3hBu51/vrqX5Fo=;
        b=eb+YPp/TyqlbO9t7PDDeaUR/Ag0Tr97s963ILIPUjEJfv1NgISyP2gMM1REaoZN5yrhplS
        K73rQywTr2Km3XFMjthsisFuFBXou6kfhvbPeLAvpk0dN8Jz3byDHKLRnr7dZ9McfyZj43
        gbOsgV3vdNUM8v8CaroOOhnTUfQ6yhY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626539787;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=17Co4vPLX3kzsJLWFYnIoxlVA1exz3hBu51/vrqX5Fo=;
        b=hudaWlsOaCFukh05k1qBEVk5GfXlAonaHt8CQgSnB9nWzY24paGdfTnRQNeUgM2QJGH1Ii
        lL8LgJQhojMCurBg==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6185AA3BB0;
        Sat, 17 Jul 2021 16:36:27 +0000 (UTC)
Date:   Sat, 17 Jul 2021 18:36:26 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Luca Boccassi <bluca@debian.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [RFT] Testing 1.22
Message-ID: <20210717163626.GN24916@kitsune.suse.cz>
References: <YK+41f972j25Z1QQ@kernel.org>
 <20210715213120.GJ24916@kitsune.suse.cz>
 <YPGIxJao9SrsiG9X@kernel.org>
 <484bd96c1ae52516d54a5a45f2be108ee838f77a.camel@debian.org>
 <22b863ce92fb0f90006eee9a2a1bf82a7352cf1b.camel@debian.org>
 <20210716201248.GL24916@kitsune.suse.cz>
 <f699a04791efbb6936ef19a8dbfc99f6e77e7136.camel@debian.org>
 <20210717151003.GM24916@kitsune.suse.cz>
 <b07015ebd7bbadb06a95a5105d9f6b4ed5817b2f.camel@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b07015ebd7bbadb06a95a5105d9f6b4ed5817b2f.camel@debian.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jul 17, 2021 at 04:14:54PM +0100, Luca Boccassi wrote:
> On Sat, 2021-07-17 at 17:10 +0200, Michal Suchánek wrote:
> > Hello,
...
> > 
> > So this libbpf comes from the kernel, and there is a separate github
> > repository for libbpf.
> > 
> > Should the kernel ship its own copy of the library?
> > 
> > Seeing that the one in the kernel is 0.3.0 and the required one for
> > dwarves is 0.4.0 maybe the one in the kernel needs updating if it needs
> > to be shipped there?
> > 
> > I wil file a bug to build the libbpf from the git repo instead of the
> > kernel to make the openSUSE libbpf less baroque.
> 
> They provide the same ABI, so there should be only one in the same
> distro, the kernel package shouldn't ship its own copy if there's a
> standalone package built from the standalone sources.
> If you are asking why the sources are still present in the upstream
> kernel, I don't know - maybe historical reasons, since that's where it
> came from? But AFAIK the majority of distros don't use that anymore.

FWIW the libbpf from github does not work for me with LTO (GCC 11).

Also there is a problem that LIBDIR is /usr/lib64 on arm64 ppc64(le) and
s390x but the library gets installed into /usr/lib by default. For some
reason x86_64 is the only 64bit arch that works out of the box.

Thanks

Michal
