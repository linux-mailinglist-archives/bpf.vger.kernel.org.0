Return-Path: <bpf+bounces-5917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBF1762F74
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 10:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE7A91C210CE
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 08:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40F5AD2D;
	Wed, 26 Jul 2023 08:17:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53E1A929
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 08:17:26 +0000 (UTC)
X-Greylist: delayed 1198 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 26 Jul 2023 01:17:23 PDT
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7365FDF;
	Wed, 26 Jul 2023 01:17:23 -0700 (PDT)
Received: from [46.222.121.5] (port=4588 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1qOZ7m-005DAa-0j; Wed, 26 Jul 2023 09:40:00 +0200
Date: Wed, 26 Jul 2023 09:39:55 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Florian Westphal <fw@strlen.de>, Matt Zagrabelny <mzagrabe@d.umn.edu>,
	netfilter <netfilter@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: ct state module issue
Message-ID: <ZMDNywzqUqjmdhOO@calendula>
References: <CAOLfK3WzBo=dPJ0WEvpO4wFPnSp1uEkBXRWpxRSz7Guou3z7kw@mail.gmail.com>
 <20230725193346.GA5720@breakpoint.cc>
 <CAADnVQJ+bQ=2XJgY815TfAK-K8BgDAD6n9pLXBHbwBZhsxnUtA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJ+bQ=2XJgY815TfAK-K8BgDAD6n9pLXBHbwBZhsxnUtA@mail.gmail.com>
X-Spam-Score: -1.8 (-)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Alexei,

On Tue, Jul 25, 2023 at 12:57:13PM -0700, Alexei Starovoitov wrote:
> On Tue, Jul 25, 2023 at 12:33 PM Florian Westphal <fw@strlen.de> wrote:
> >
> > Matt Zagrabelny <mzagrabe@d.umn.edu> wrote:
> >
> > [ CCing bpf/btf experts ]
> >
> > > I'm running kernel: 6.1.0-10-amd64
> > > and
> > > nftables v1.0.6 (Lester Gooch #5)
> > >
> > > I have a set of nftables rules that have served me well for Debian 11
> > > - thanks in large part to the netfilter mailing list, so...thank you!
> > > nftables on Debian 11 is: 0.9.8-3.1+deb11u1
> > >
> > > I have recently installed Debian 12 and tried my nftables rules and
> > > have hit a snag with the connection tracking and a verdict map.
> > > nftables on Debian 12 is: 1.0.6-2+deb12u1
> > >
> > > When I run the offending snippet:
> > >
> > > # nft -f /etc/nftables.conf.d/300-common.d/200-connection-tracking.nft
> > > /etc/nftables.conf.d/300-common.d/200-connection-tracking.nft:4:9-16:
> > > Error: Could not process rule: No such file or directory
> > >         ct state vmap {
> >
> > [..]
> >         ^^^^^^^^
> > > When I watch the kernel logs (journalctl), I see:
> > >
> > > Jul 25 13:44:04 localhost kernel: BPF: [99725] STRUCT
> > > Jul 25 13:44:04 localhost kernel: BPF: size=104 vlen=12
> > > Jul 25 13:44:04 localhost kernel: BPF:
> > > Jul 25 13:44:04 localhost kernel: BPF: Invalid name
> > > Jul 25 13:44:04 localhost kernel: BPF:
> > > Jul 25 13:44:04 localhost kernel: failed to validate module
> > > [nf_conntrack] BTF: -22
> > > Jul 25 13:44:04 localhost kernel: missing module BTF, cannot register kfuncs
> >
> > So nf_conntrack.ko fails to load because of a btf issue.
> >
> > My question to bpf folks is:
> >
> > Should we make register_nf_conntrack_bpf() return 'void'?
> >
> > This way normal conntrack would still work.  bpf programs using
> > conntrack kfuncs would fail, but above dmesg splat already gives
> > a clue as to why conntrack kfuncs aren't there.
> >
> > No idea about the actual problem or how to debug that, but bpf
> > people should know.
> 
> The pr_err() was changed to pr_warn() in
> commit 3de4d22cc9ac ("bpf, btf: Warn but return no error for NULL btf
> from __register_btf_kfunc_id_set()").

OK, no ENOENT anymore, hence no bail out.

> Please upgrade the kernel and ignore the warn if you don't need bpf/btf/kfuncs.
> 
> Three links in that commit provide more details.

Jul 25 13:44:04 localhost kernel: BPF: [99725] STRUCT
Jul 25 13:44:04 localhost kernel: BPF: size=104 vlen=12
Jul 25 13:44:04 localhost kernel: BPF:
Jul 25 13:44:04 localhost kernel: BPF: Invalid name
Jul 25 13:44:04 localhost kernel: BPF:

Are these debugging logs above still displayed? Maybe remove them too
or only display them when all required things are in place and users
opt-in to use this new infrastructure?

Thanks.

