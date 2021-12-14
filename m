Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D72A74745ED
	for <lists+bpf@lfdr.de>; Tue, 14 Dec 2021 16:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbhLNPFT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Dec 2021 10:05:19 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34056 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235158AbhLNPEj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Dec 2021 10:04:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F03BBB81A2C
        for <bpf@vger.kernel.org>; Tue, 14 Dec 2021 15:04:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D9AC34605;
        Tue, 14 Dec 2021 15:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639494276;
        bh=iOIIophFVBhcCpEybghHVTQliNaI7UP22pNLK9osVZ4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Yf8sRWaFWWK/hNaiGMw++smsi723ww0eGluNhTjM8tMNNCkP0Uv5nXBBavIT9nzx1
         4xQz6Pf1Postn0jPNDfeC1uYSzoggaPXx92YUW5rJ8MINl9PnGNkd/Wvt5NG6WFBkN
         V+C4jovRY1+NNCw5U5yguMGfB+0jY3FyvSbb5URIuMJeIPAHatDc1uCd2UsBXZaePe
         iHGW97BJjldxCrGYFBQtm2Om7FHUPe0RhQ7IqwVOu3guYE2+2ElaTzbFU7Ia4+17Se
         aQDpHgJzx2BbfvoAI+dETJif7tzwa3XArwla5O1BHVRwt6FEI0gcLogH7Kx0jjBVWY
         KAGc+/fwx80fw==
Date:   Tue, 14 Dec 2021 07:04:35 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 3/5] bpf: create a header for struct bpf_link
Message-ID: <20211214070435.7f07e2ac@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <CAADnVQ+6Qmm9b3Jf_BHCn_PFxs00NK71K235zQYc=_PufkOPAQ@mail.gmail.com>
References: <20211213234223.356977-1-kuba@kernel.org>
        <20211213234223.356977-4-kuba@kernel.org>
        <CAADnVQ+6Qmm9b3Jf_BHCn_PFxs00NK71K235zQYc=_PufkOPAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 13 Dec 2021 21:15:06 -0800 Alexei Starovoitov wrote:
> On Mon, Dec 13, 2021 at 3:42 PM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > struct bpf_link needs to be embedded by cgroups.
> > Put it in its own header.
> >
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > ---
> >  include/linux/bpf-link.h | 23 +++++++++++++++++++++++
> >  include/linux/bpf.h      | 10 +---------
> >  2 files changed, 24 insertions(+), 9 deletions(-)
> >  create mode 100644 include/linux/bpf-link.h
> >
> > diff --git a/include/linux/bpf-link.h b/include/linux/bpf-link.h
> > new file mode 100644
> > index 000000000000..d20f049af51a
> > --- /dev/null
> > +++ b/include/linux/bpf-link.h
> > @@ -0,0 +1,23 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/* Copyright (c) 2011-2014 PLUMgrid, http://plumgrid.com
> > + */
> > +#ifndef _LINUX_BPF_MIN_H
> > +#define _LINUX_BPF_MIN_H 1  
> 
> MIN_H ?

Used to stand for "minimal", forgot to rename after I changed course.

> My understanding that patch 4 is the key.
> I think the bpf-link.h bpf-cgroup-types.h and bpf-cgroup-storage.h
> are too specific. We don't do a header file per type.
> Maybe combine them all into one bpf-cgroup-types.h ?
> That will still achieve the separation of cgroup from linux/bpf.h
