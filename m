Return-Path: <bpf+bounces-12226-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBBB7C95FD
	for <lists+bpf@lfdr.de>; Sat, 14 Oct 2023 21:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 601851C20A51
	for <lists+bpf@lfdr.de>; Sat, 14 Oct 2023 19:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1532125B4;
	Sat, 14 Oct 2023 19:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1017D15C5;
	Sat, 14 Oct 2023 19:01:18 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6986DCC;
	Sat, 14 Oct 2023 12:01:17 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qrjsZ-0006vL-Io; Sat, 14 Oct 2023 21:00:51 +0200
Date: Sat, 14 Oct 2023 21:00:51 +0200
From: Florian Westphal <fw@strlen.de>
To: Victor Nogueira <victor@mojatatu.com>
Cc: jhs@mojatatu.com, daniel@iogearbox.net, xiyou.wangcong@gmail.com,
	jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, paulb@nvidia.com,
	bpf@vger.kernel.org, mleitner@redhat.com, martin.lau@linux.dev,
	dcaratti@redhat.com, netdev@vger.kernel.org, kernel@mojatatu.com
Subject: Re: [PATCH RFC net-next v2 1/1] net: sched: Disambiguate verdict
 from return code
Message-ID: <20231014190051.GA23755@breakpoint.cc>
References: <20231014180921.833820-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231014180921.833820-1-victor@mojatatu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Victor Nogueira <victor@mojatatu.com> wrote:
> +	FN(TC_ALLOC_SKB_EXT)		\

I think that SKB_DROP_REASON_NOMEM is fine for this, adding
a new drop reason for every type of object alloction failure
doesn't help.

The other ones are things that do point at tc specific config problems
so no objections there.

>  			ext = tc_skb_ext_alloc(skb);
> -			if (WARN_ON_ONCE(!ext))
> +			if (WARN_ON_ONCE(!ext)) {
> +				u32 drop_reason = SKB_TC_ALLOC_SKB_EXT;
> +
> +				tcf_set_drop_reason(res, drop_reason);

Unrelated to your patch, but I think this WARN_ON makes no sense.

There is nothing the user or a developer could do about that GFP_ATOMIC failure.

Also I see this patch gets rid of some, but not all, CONFIG_NET_CLS_ACT ifdefs.
The changelog should mention why.

Otherwise this LGTM.

