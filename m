Return-Path: <bpf+bounces-4421-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF22D74AE8A
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 12:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82A9D2816EC
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 10:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01710BE67;
	Fri,  7 Jul 2023 10:09:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C428920E0;
	Fri,  7 Jul 2023 10:09:43 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D220A90;
	Fri,  7 Jul 2023 03:09:41 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qHiP2-00033x-Dk; Fri, 07 Jul 2023 12:09:28 +0200
Date: Fri, 7 Jul 2023 12:09:28 +0200
From: Florian Westphal <fw@strlen.de>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: pabeni@redhat.com, edumazet@google.com, kuba@kernel.org, fw@strlen.de,
	davem@davemloft.net, pablo@netfilter.org, kadlec@netfilter.org,
	dsahern@kernel.org, daniel@iogearbox.net,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 3/6] netfilter: bpf: Prevent defrag module
 unload while link active
Message-ID: <20230707100928.GA11622@breakpoint.cc>
References: <cover.1688685338.git.dxu@dxuuu.xyz>
 <81ede90e3f1468763ea5b0b6ec2971b7b1b870c1.1688685338.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81ede90e3f1468763ea5b0b6ec2971b7b1b870c1.1688685338.git.dxu@dxuuu.xyz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Daniel Xu <dxu@dxuuu.xyz> wrote:
> +		/* Prevent defrag module from going away while in use */
> +		if (!try_module_get(v4_hook->owner)) {
> +			err = -ENOENT;
> +			goto out_v4;
> +		}
> +
>  		err = v4_hook->enable(link->net);
>  out_v4:
>  		rcu_read_unlock();
> @@ -79,6 +86,12 @@ static int bpf_nf_enable_defrag(struct bpf_nf_link *link)
>  			}
>  		}
>  
> +		/* Prevent defrag module from going away while in use */
> +		if (!try_module_get(v6_hook->owner)) {
> +			err = -ENOENT;
> +			goto out_v6;
> +		}
> +
>  		err = v6_hook->enable(link->net);
>  out_v6:
>  		rcu_read_unlock();

This needs module_put() calls in case ->enable() returns an error, no?

Other than this this series LGTM, thanks!

