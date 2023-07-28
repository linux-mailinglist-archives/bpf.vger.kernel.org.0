Return-Path: <bpf+bounces-6184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B866E766960
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 11:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BBD7282663
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 09:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B34511181;
	Fri, 28 Jul 2023 09:52:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF5710950;
	Fri, 28 Jul 2023 09:52:54 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA6411D;
	Fri, 28 Jul 2023 02:52:53 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qPK9K-0001Yf-9S; Fri, 28 Jul 2023 11:52:42 +0200
Date: Fri, 28 Jul 2023 11:52:42 +0200
From: Florian Westphal <fw@strlen.de>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: daniel@iogearbox.net, kadlec@netfilter.org, edumazet@google.com,
	ast@kernel.org, fw@strlen.de, kuba@kernel.org, pabeni@redhat.com,
	pablo@netfilter.org, andrii@kernel.org, davem@davemloft.net,
	alexei.starovoitov@gmail.com, martin.lau@linux.dev, song@kernel.org,
	yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
	sdf@google.com, haoluo@google.com, jolsa@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, dsahern@kernel.org
Subject: Re: [PATCH bpf-next v6 2/5] netfilter: bpf: Support
 BPF_F_NETFILTER_IP_DEFRAG in netfilter link
Message-ID: <20230728095242.GB15474@breakpoint.cc>
References: <cover.1689970773.git.dxu@dxuuu.xyz>
 <5cff26f97e55161b7d56b09ddcf5f8888a5add1d.1689970773.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cff26f97e55161b7d56b09ddcf5f8888a5add1d.1689970773.git.dxu@dxuuu.xyz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Daniel Xu <dxu@dxuuu.xyz> wrote:
> This commit adds support for enabling IP defrag using pre-existing
> netfilter defrag support. Basically all the flag does is bump a refcnt
> while the link the active. Checks are also added to ensure the prog
> requesting defrag support is run _after_ netfilter defrag hooks.
> 
> We also take care to avoid any issues w.r.t. module unloading -- while
> defrag is active on a link, the module is prevented from unloading.

Reviewed-by: Florian Westphal <fw@strlen.de>

