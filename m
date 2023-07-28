Return-Path: <bpf+bounces-6182-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 267737668AC
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 11:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5813C1C217F9
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 09:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9009210952;
	Fri, 28 Jul 2023 09:18:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2EAD305;
	Fri, 28 Jul 2023 09:18:28 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC4C59EE;
	Fri, 28 Jul 2023 02:18:02 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qPJal-0001Mm-8P; Fri, 28 Jul 2023 11:16:59 +0200
Date: Fri, 28 Jul 2023 11:16:59 +0200
From: Florian Westphal <fw@strlen.de>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: kadlec@netfilter.org, edumazet@google.com, fw@strlen.de,
	kuba@kernel.org, pabeni@redhat.com, pablo@netfilter.org,
	dsahern@kernel.org, davem@davemloft.net,
	alexei.starovoitov@gmail.com, daniel@iogearbox.net,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v6 1/5] netfilter: defrag: Add glue hooks for
 enabling/disabling defrag
Message-ID: <20230728091659.GA15474@breakpoint.cc>
References: <cover.1689970773.git.dxu@dxuuu.xyz>
 <f6a8824052441b72afe5285acedbd634bd3384c1.1689970773.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6a8824052441b72afe5285acedbd634bd3384c1.1689970773.git.dxu@dxuuu.xyz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Daniel Xu <dxu@dxuuu.xyz> wrote:
> We want to be able to enable/disable IP packet defrag from core
> bpf/netfilter code. In other words, execute code from core that could
> possibly be built as a module.
> 
> To help avoid symbol resolution errors, use glue hooks that the modules
> will register callbacks with during module init.

Reviewed-by: Florian Westphal <fw@strlen.de>

