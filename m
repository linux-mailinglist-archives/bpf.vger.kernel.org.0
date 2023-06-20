Return-Path: <bpf+bounces-2879-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 662927363A8
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 08:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 981B91C20A2A
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 06:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDF8256E;
	Tue, 20 Jun 2023 06:36:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053531FA2;
	Tue, 20 Jun 2023 06:36:02 +0000 (UTC)
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2586E6E;
	Mon, 19 Jun 2023 23:36:00 -0700 (PDT)
Date: Tue, 20 Jun 2023 08:35:55 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florent Revest <revest@chromium.org>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, kadlec@netfilter.org, fw@strlen.de,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, lirongqing@baidu.com, wangli39@baidu.com,
	zhangyu31@baidu.com, daniel@iogearbox.net, ast@kernel.org,
	kpsingh@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: conntrack: Avoid nf_ct_helper_hash uses
 after free
Message-ID: <ZJFIy+oJS+vTGJer@calendula>
References: <20230615152918.3484699-1-revest@chromium.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230615152918.3484699-1-revest@chromium.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 15, 2023 at 05:29:18PM +0200, Florent Revest wrote:
> If register_nf_conntrack_bpf() fails (for example, if the .BTF section
> contains an invalid entry), nf_conntrack_init_start() calls
> nf_conntrack_helper_fini() as part of its cleanup path and
> nf_ct_helper_hash gets freed.
> 
> Further netfilter modules like netfilter_conntrack_ftp don't check
> whether nf_conntrack initialized correctly and call
> nf_conntrack_helpers_register() which accesses the freed
> nf_ct_helper_hash and causes a uaf.
> 
> This patch guards nf_conntrack_helper_register() from accessing
> freed/uninitialized nf_ct_helper_hash maps and fixes a boot-time
> use-after-free.

How could this possibly happen?

nf_conntrack_ftp depends on nf_conntrack.

If nf_conntrack fails to load, how can nf_conntrack_ftp be loaded?

> Cc: stable@vger.kernel.org
> Fixes: 12f7a505331e ("netfilter: add user-space connection tracking helper infrastructure")
> Signed-off-by: Florent Revest <revest@chromium.org>
> ---
>  net/netfilter/nf_conntrack_helper.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/net/netfilter/nf_conntrack_helper.c b/net/netfilter/nf_conntrack_helper.c
> index 0c4db2f2ac43..f22691f83853 100644
> --- a/net/netfilter/nf_conntrack_helper.c
> +++ b/net/netfilter/nf_conntrack_helper.c
> @@ -360,6 +360,9 @@ int nf_conntrack_helper_register(struct nf_conntrack_helper *me)
>  	BUG_ON(me->expect_class_max >= NF_CT_MAX_EXPECT_CLASSES);
>  	BUG_ON(strlen(me->name) > NF_CT_HELPER_NAME_LEN - 1);
>  
> +	if (!nf_ct_helper_hash)
> +		return -ENOENT;
> +
>  	if (me->expect_policy->max_expected > NF_CT_EXPECT_MAX_CNT)
>  		return -EINVAL;
>  
> @@ -515,4 +518,5 @@ int nf_conntrack_helper_init(void)
>  void nf_conntrack_helper_fini(void)
>  {
>  	kvfree(nf_ct_helper_hash);
> +	nf_ct_helper_hash = NULL;
>  }
> -- 
> 2.41.0.162.gfafddb0af9-goog
> 

