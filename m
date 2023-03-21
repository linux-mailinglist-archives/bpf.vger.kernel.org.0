Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6D86C37D7
	for <lists+bpf@lfdr.de>; Tue, 21 Mar 2023 18:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjCURKu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Mar 2023 13:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjCURKs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Mar 2023 13:10:48 -0400
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48F02B9D8
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 10:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1679418620; x=1710954620;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x6KhtVNBumbJZMrN22RHbNHtjFsVCljWugFHMMNvNQs=;
  b=NJK3ryB2OdxGDMQGm2c7SjhfI73QN2LCSY7fZj8aH+uoGtqx09cZ2458
   cB9YegpZtFc1f9dVgUi9riQsTNhCTMYOdV71uXvNVCAh/heZRvF0qzIgS
   CCGy/Rx+JO3Rnu/lEsulArSUiRoxKOOaw1AjSoZztw3R2TBonYewbtIEx
   0=;
X-IronPort-AV: E=Sophos;i="5.98,279,1673913600"; 
   d="scan'208";a="311701833"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1box-1dm6-7f722725.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2023 17:09:56 +0000
Received: from EX19MTAUWA002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1box-1dm6-7f722725.us-east-1.amazon.com (Postfix) with ESMTPS id BA1391058B5;
        Tue, 21 Mar 2023 17:09:54 +0000 (UTC)
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.22; Tue, 21 Mar 2023 17:09:42 +0000
Received: from 88665a182662.ant.amazon.com (10.82.216.211) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.24; Tue, 21 Mar 2023 17:09:37 +0000
From:   Kuniyuki Iwashima <kuniyu@amazon.com>
To:     <daniel@iogearbox.net>
CC:     <bpf@vger.kernel.org>, <lefteris.alexakis@kpn.com>, <sh@synk.net>,
        <kuniyu@amazon.com>
Subject: Re: [PATCH bpf] bpf: Adjust insufficient default bpf_jit_limit
Date:   Tue, 21 Mar 2023 10:09:25 -0700
Message-ID: <20230321170925.74358-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230320143725.8394-1-daniel@iogearbox.net>
References: <20230320143725.8394-1-daniel@iogearbox.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.82.216.211]
X-ClientProxiedBy: EX19D039UWB004.ant.amazon.com (10.13.138.57) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From:   Daniel Borkmann <daniel@iogearbox.net>
Date:   Mon, 20 Mar 2023 15:37:25 +0100
> We've seen recent AWS EKS (Kubernetes) user reports like the following:
> 
>   After upgrading EKS nodes from v20230203 to v20230217 on our 1.24 EKS
>   clusters after a few days a number of the nodes have containers stuck
>   in ContainerCreating state or liveness/readiness probes reporting the
>   following error:
> 
>     Readiness probe errored: rpc error: code = Unknown desc = failed to
>     exec in container: failed to start exec "4a11039f730203ffc003b7[...]":
>     OCI runtime exec failed: exec failed: unable to start container process:
>     unable to init seccomp: error loading seccomp filter into kernel:
>     error loading seccomp filter: errno 524: unknown
> 
>   However, we had not been seeing this issue on previous AMIs and it only
>   started to occur on v20230217 (following the upgrade from kernel 5.4 to
>   5.10) with no other changes to the underlying cluster or workloads.
> 
>   We tried the suggestions from that issue (sysctl net.core.bpf_jit_limit=452534528)
>   which helped to immediately allow containers to be created and probes to
>   execute but after approximately a day the issue returned and the value
>   returned by cat /proc/vmallocinfo | grep bpf_jit | awk '{s+=$2} END {print s}'
>   was steadily increasing.
> 
> I tested bpf tree to observe bpf_jit_charge_modmem, bpf_jit_uncharge_modmem
> their sizes passed in as well as bpf_jit_current under tcpdump BPF filter,
> seccomp BPF and native (e)BPF programs, and the behavior all looks sane
> and expected, that is nothing "leaking" from an upstream perspective.
> 
> The bpf_jit_limit knob was originally added in order to avoid a situation
> where unprivileged applications loading BPF programs (e.g. seccomp BPF
> policies) consuming all the module memory space via BPF JIT such that loading
> of kernel modules would be prevented. The default limit was defined back in
> 2018 and while good enough back then, we are generally seeing far more BPF
> consumers today.
> 
> Adjust the limit for the BPF JIT pool from originally 1/4 to now 1/2 of the
> module memory space to better reflect today's needs and avoid more users
> running into potentially hard to debug issues.
> 
> Fixes: fdadd04931c2 ("bpf: fix bpf_jit_limit knob for PAGE_SIZE >= 64K")
> Reported-by: Stephen Haynes <sh@synk.net>
> Reported-by: Lefteris Alexakis <lefteris.alexakis@kpn.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

Hi Daniel,

Thanks for tha patch.

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


> Link: https://github.com/awslabs/amazon-eks-ami/issues/1179
> Link: https://github.com/awslabs/amazon-eks-ami/issues/1219

I'm investigating these issues with EKS folks.  On the issue 1179, the
customer was using our 5.4 kernel, and on 1219, 5.10 kernel.

Then, I found my memleak fix commit a1140cb215fa ("seccomp: Move
copy_seccomp() to no failure path.") was not backported to upstream 5.10
stable trees.  We'll test if the issue can be reproduced with/without
the fix.

Anyway, I'll backport this patch to our all trees.

Thanks,
Kuniyuki


> ---
>  kernel/bpf/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index b297e9f60ca1..e2d256c82072 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -972,7 +972,7 @@ static int __init bpf_jit_charge_init(void)
>  {
>  	/* Only used as heuristic here to derive limit. */
>  	bpf_jit_limit_max = bpf_jit_alloc_exec_limit();
> -	bpf_jit_limit = min_t(u64, round_up(bpf_jit_limit_max >> 2,
> +	bpf_jit_limit = min_t(u64, round_up(bpf_jit_limit_max >> 1,
>  					    PAGE_SIZE), LONG_MAX);
>  	return 0;
>  }
> -- 
> 2.27.0
