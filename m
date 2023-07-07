Return-Path: <bpf+bounces-4494-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBDB74B7CD
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 22:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A8261C210AF
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 20:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9DE17AA1;
	Fri,  7 Jul 2023 20:20:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BD317AA0;
	Fri,  7 Jul 2023 20:20:59 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8883E26A5;
	Fri,  7 Jul 2023 13:20:29 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qHrw9-00066o-F8; Fri, 07 Jul 2023 22:20:17 +0200
Date: Fri, 7 Jul 2023 22:20:17 +0200
From: Florian Westphal <fw@strlen.de>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: pablo@netfilter.org, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, kadlec@netfilter.org, pabeni@redhat.com,
	dsahern@kernel.org, fw@strlen.de, daniel@iogearbox.net,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 3/6] netfilter: bpf: Prevent defrag module
 unload while link active
Message-ID: <20230707202017.GD11622@breakpoint.cc>
References: <cover.1688748455.git.dxu@dxuuu.xyz>
 <7549d65daa702ba89aa3e43d5a1bbd562d569a99.1688748455.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7549d65daa702ba89aa3e43d5a1bbd562d569a99.1688748455.git.dxu@dxuuu.xyz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Daniel Xu <dxu@dxuuu.xyz> wrote:
> While in practice we could handle the module being unloaded while a
> netfilter link (that requested defrag) was active, it's a better user
> experience to prevent the defrag module from going away. It would
> violate user expectations if fragmented packets started showing up if
> some other part of the system tried to unload defrag module.

Reviewed-by: Florian Westphal <fw@strlen.de>

