Return-Path: <bpf+bounces-3882-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 475C4745FB8
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 17:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 039FD280E20
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 15:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C9C100B5;
	Mon,  3 Jul 2023 15:23:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A36F9FC;
	Mon,  3 Jul 2023 15:23:23 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BF7E62;
	Mon,  3 Jul 2023 08:23:14 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qGLOC-0000cR-Qj; Mon, 03 Jul 2023 17:22:56 +0200
Date: Mon, 3 Jul 2023 17:22:56 +0200
From: Florian Westphal <fw@strlen.de>
To: Florent Revest <revest@chromium.org>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, pablo@netfilter.org, kadlec@netfilter.org,
	fw@strlen.de, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, kpsingh@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH nf v2] netfilter: conntrack: Avoid nf_ct_helper_hash uses
 after free
Message-ID: <20230703152256.GC7043@breakpoint.cc>
References: <20230703145216.1096265-1-revest@chromium.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703145216.1096265-1-revest@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Florent Revest <revest@chromium.org> wrote:
> If nf_conntrack_init_start() fails (for example due to a
> register_nf_conntrack_bpf() failure), the nf_conntrack_helper_fini()
> clean-up path frees the nf_ct_helper_hash map.
> 
> When built with NF_CONNTRACK=y, further netfilter modules (e.g:
> netfilter_conntrack_ftp) can still be loaded and call
> nf_conntrack_helpers_register(), independently of whether nf_conntrack
> initialized correctly. This accesses the nf_ct_helper_hash dangling
> pointer and causes a uaf, possibly leading to random memory corruption.
> 
> This patch guards nf_conntrack_helper_register() from accessing a freed
> or uninitialized nf_ct_helper_hash pointer and fixes possible
> uses-after-free when loading a conntrack module.

Reviewed-by: Florian Westphal <fw@strlen.de>

