Return-Path: <bpf+bounces-4492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8283674B7A7
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 22:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DA7F2818C0
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 20:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080A31772E;
	Fri,  7 Jul 2023 20:12:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED2A23C7;
	Fri,  7 Jul 2023 20:12:04 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D75FE;
	Fri,  7 Jul 2023 13:11:54 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qHrnp-00062T-8e; Fri, 07 Jul 2023 22:11:41 +0200
Date: Fri, 7 Jul 2023 22:11:41 +0200
From: Florian Westphal <fw@strlen.de>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: pablo@netfilter.org, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, kadlec@netfilter.org, pabeni@redhat.com,
	dsahern@kernel.org, fw@strlen.de, daniel@iogearbox.net,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/6] netfilter: defrag: Add glue hooks for
 enabling/disabling defrag
Message-ID: <20230707201141.GB11622@breakpoint.cc>
References: <cover.1688748455.git.dxu@dxuuu.xyz>
 <8a20b0a3fff75bce1bed207631fe4f56abc3e99d.1688748455.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a20b0a3fff75bce1bed207631fe4f56abc3e99d.1688748455.git.dxu@dxuuu.xyz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham
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

