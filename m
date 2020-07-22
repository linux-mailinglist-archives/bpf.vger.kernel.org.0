Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4162292DC
	for <lists+bpf@lfdr.de>; Wed, 22 Jul 2020 10:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgGVIBs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jul 2020 04:01:48 -0400
Received: from verein.lst.de ([213.95.11.211]:55344 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbgGVIBr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jul 2020 04:01:47 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 92E6A6736F; Wed, 22 Jul 2020 10:01:42 +0200 (CEST)
Date:   Wed, 22 Jul 2020 10:01:42 +0200
From:   'Christoph Hellwig' <hch@lst.de>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     'Christoph Hellwig' <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Eric Dumazet <edumazet@google.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>,
        "coreteam@netfilter.org" <coreteam@netfilter.org>,
        "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
        "linux-hams@vger.kernel.org" <linux-hams@vger.kernel.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "bridge@lists.linux-foundation.org" 
        <bridge@lists.linux-foundation.org>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "dccp@vger.kernel.org" <dccp@vger.kernel.org>,
        "linux-decnet-user@lists.sourceforge.net" 
        <linux-decnet-user@lists.sourceforge.net>,
        "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "mptcp@lists.01.org" <mptcp@lists.01.org>,
        "lvs-devel@vger.kernel.org" <lvs-devel@vger.kernel.org>,
        "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        "linux-afs@lists.infradead.org" <linux-afs@lists.infradead.org>,
        "tipc-discussion@lists.sourceforge.net" 
        <tipc-discussion@lists.sourceforge.net>,
        "linux-x25@vger.kernel.org" <linux-x25@vger.kernel.org>
Subject: Re: [PATCH 12/24] bpfilter: switch bpfilter_ip_set_sockopt to
 sockptr_t
Message-ID: <20200722080142.GA26841@lst.de>
References: <20200720124737.118617-1-hch@lst.de> <20200720124737.118617-13-hch@lst.de> <f9493b4c514441b4b51bc7e4e75e8c40@AcuMS.aculab.com> <20200722080023.GC26554@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722080023.GC26554@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 22, 2020 at 10:00:23AM +0200, 'Christoph Hellwig' wrote:
> On Tue, Jul 21, 2020 at 08:36:57AM +0000, David Laight wrote:
> > From: Christoph Hellwig
> > > Sent: 20 July 2020 13:47
> > > 
> > > This is mostly to prepare for cleaning up the callers, as bpfilter by
> > > design can't handle kernel pointers.
> >                       ^^^ user ??
> 
> No, it can't handle user pointers. 

Err, I mean it can only handle user pointers.
