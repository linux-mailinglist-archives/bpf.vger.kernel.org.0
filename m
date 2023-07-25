Return-Path: <bpf+bounces-5862-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F7C76224D
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 21:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74E7C1C20F83
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 19:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244BF263DD;
	Tue, 25 Jul 2023 19:33:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D601D2FD
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 19:33:49 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E14D1FE5;
	Tue, 25 Jul 2023 12:33:48 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qONn0-0002sE-Jf; Tue, 25 Jul 2023 21:33:46 +0200
Date: Tue, 25 Jul 2023 21:33:46 +0200
From: Florian Westphal <fw@strlen.de>
To: Matt Zagrabelny <mzagrabe@d.umn.edu>
Cc: netfilter <netfilter@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: ct state module issue
Message-ID: <20230725193346.GA5720@breakpoint.cc>
References: <CAOLfK3WzBo=dPJ0WEvpO4wFPnSp1uEkBXRWpxRSz7Guou3z7kw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLfK3WzBo=dPJ0WEvpO4wFPnSp1uEkBXRWpxRSz7Guou3z7kw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Matt Zagrabelny <mzagrabe@d.umn.edu> wrote:

[ CCing bpf/btf experts ]

> I'm running kernel: 6.1.0-10-amd64
> and
> nftables v1.0.6 (Lester Gooch #5)
> 
> I have a set of nftables rules that have served me well for Debian 11
> - thanks in large part to the netfilter mailing list, so...thank you!
> nftables on Debian 11 is: 0.9.8-3.1+deb11u1
> 
> I have recently installed Debian 12 and tried my nftables rules and
> have hit a snag with the connection tracking and a verdict map.
> nftables on Debian 12 is: 1.0.6-2+deb12u1
> 
> When I run the offending snippet:
> 
> # nft -f /etc/nftables.conf.d/300-common.d/200-connection-tracking.nft
> /etc/nftables.conf.d/300-common.d/200-connection-tracking.nft:4:9-16:
> Error: Could not process rule: No such file or directory
>         ct state vmap {

[..]
  	^^^^^^^^
> When I watch the kernel logs (journalctl), I see:
> 
> Jul 25 13:44:04 localhost kernel: BPF: [99725] STRUCT
> Jul 25 13:44:04 localhost kernel: BPF: size=104 vlen=12
> Jul 25 13:44:04 localhost kernel: BPF:
> Jul 25 13:44:04 localhost kernel: BPF: Invalid name
> Jul 25 13:44:04 localhost kernel: BPF:
> Jul 25 13:44:04 localhost kernel: failed to validate module
> [nf_conntrack] BTF: -22
> Jul 25 13:44:04 localhost kernel: missing module BTF, cannot register kfuncs

So nf_conntrack.ko fails to load because of a btf issue.

My question to bpf folks is:

Should we make register_nf_conntrack_bpf() return 'void'?

This way normal conntrack would still work.  bpf programs using
conntrack kfuncs would fail, but above dmesg splat already gives
a clue as to why conntrack kfuncs aren't there.

No idea about the actual problem or how to debug that, but bpf
people should know.

