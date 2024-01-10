Return-Path: <bpf+bounces-19330-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F51829FE8
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 18:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFACF1F2977B
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 17:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B0B4D129;
	Wed, 10 Jan 2024 17:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bYj7fO68"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329E54D126
	for <bpf@vger.kernel.org>; Wed, 10 Jan 2024 17:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1704909313; x=1736445313;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7Fc0yQLk9+MDeJqrzwQxtj4P6bRuNcYUojuAhcavhD8=;
  b=bYj7fO68mmRocyA3EKXiXQwTmzlSD6XoemIc3V6Z9vVgMrguYor7WLdU
   VkQdDteye/08DlMUIQBP8THPUrU2Qa7MAYq5SvZCoNLnf6WOEWZuH/RvA
   myr52NQzB8Sz9hBS/Vt4EPW0yIC65ULjuUXf7A/MAOYCVcNvCgIkMFMTf
   A=;
X-IronPort-AV: E=Sophos;i="6.04,184,1695686400"; 
   d="scan'208";a="605714952"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-af372327.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 17:55:10 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2a-m6i4x-af372327.us-west-2.amazon.com (Postfix) with ESMTPS id 50BF760B99;
	Wed, 10 Jan 2024 17:55:09 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:62380]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.86:2525] with esmtp (Farcaster)
 id d0c3cc0f-07ba-498e-b6dd-bafb1cefedba; Wed, 10 Jan 2024 17:55:09 +0000 (UTC)
X-Farcaster-Flow-ID: d0c3cc0f-07ba-498e-b6dd-bafb1cefedba
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 10 Jan 2024 17:55:07 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.21) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 10 Jan 2024 17:55:04 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <yonghong.song@linux.dev>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <kafai@fb.com>, <kernel-team@fb.com>,
	<kuniyu@amazon.com>, <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Track aligned st store as imprecise spilled registers
Date: Wed, 10 Jan 2024 09:54:53 -0800
Message-ID: <20240110175453.36889-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240110051348.2737007-1-yonghong.song@linux.dev>
References: <20240110051348.2737007-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA002.ant.amazon.com (10.13.139.11) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Yonghong Song <yonghong.song@linux.dev>
Date: Tue,  9 Jan 2024 21:13:48 -0800
> With patch set [1], precision backtracing supports register spill/fill
> to/from the stack. The patch [2] allows initial imprecise register spill
> with content 0. This is a common case for cpuv3 and lower for
> initializing the stack variables with pattern
>   r1 = 0
>   *(u64 *)(r10 - 8) = r1
> and the [2] has demonstrated good verification improvement.
> 
> For cpuv4, the initialization could be
>   *(u64 *)(r10 - 8) = 0
> The current verifier marks the r10-8 contents with STACK_ZERO.
> Similar to [2], let us permit the above insn to behave like
> imprecise register spill which can reduce number of verified states.
> The change is in function check_stack_write_fixed_off().
> 
> Before this patch, spilled zero will be marked as STACK_ZERO
> which can provide precise values. In check_stack_write_var_off(),
> STACK_ZERO will be maintained if writing a const zero
> so later it can provide precise values if needed.
> 
> The above handling of '*(u64 *)(r10 - 8) = 0' as a spill
> will have issues in check_stack_write_var_off() as the spill
> will be converted to STACK_MISC and the precise value 0
> is lost. To fix this issue, if the spill slots with const
> zero and the BPF_ST write also with const zero, the spill slots
> are preserved, which can later provide precise values
> if needed. Without the change in check_stack_write_var_off(),
> the test_verifier subtest 'BPF_ST_MEM stack imm zero, variable offset'
> will fail.
> 
> I checked cpuv3 and cpuv4 with and without this patch with veristat.
> There is no state change for cpuv3 since '*(u64 *)(r10 - 8) = 0'
> is only generated with cpuv4.
> 
> For cpuv4:
> $ ../veristat -C old.cpuv4.csv new.cpuv4.csv -e file,prog,insns,states -f 'insns_diff!=0'
> File                                        Program              Insns (A)  Insns (B)  Insns    (DIFF)  States (A)  States (B)  States (DIFF)
> ------------------------------------------  -------------------  ---------  ---------  ---------------  ----------  ----------  -------------
> local_storage_bench.bpf.linked3.o           get_local                  228        168    -60 (-26.32%)          17          14   -3 (-17.65%)
> pyperf600_bpf_loop.bpf.linked3.o            on_event                  6066       4889  -1177 (-19.40%)         403         321  -82 (-20.35%)
> test_cls_redirect.bpf.linked3.o             cls_redirect             35483      35387     -96 (-0.27%)        2179        2177    -2 (-0.09%)
> test_l4lb_noinline.bpf.linked3.o            balancer_ingress          4494       4522     +28 (+0.62%)         217         219    +2 (+0.92%)
> test_l4lb_noinline_dynptr.bpf.linked3.o     balancer_ingress          1432       1455     +23 (+1.61%)          92          94    +2 (+2.17%)
> test_xdp_noinline.bpf.linked3.o             balancer_ingress_v6       3462       3458      -4 (-0.12%)         216         216    +0 (+0.00%)
> verifier_iterating_callbacks.bpf.linked3.o  widening                    52         41    -11 (-21.15%)           4           3   -1 (-25.00%)
> xdp_synproxy_kern.bpf.linked3.o             syncookie_tc             12412      11719    -693 (-5.58%)         345         330   -15 (-4.35%)
> xdp_synproxy_kern.bpf.linked3.o             syncookie_xdp            12478      11794    -684 (-5.48%)         346         331   -15 (-4.34%)
> 
> test_l4lb_noinline and test_l4lb_noinline_dynptr has minor regression, but
> pyperf600_bpf_loop and local_storage_bench gets pretty good improvement.
> 
>   [1] https://lore.kernel.org/all/20231205184248.1502704-1-andrii@kernel.org/
>   [2] https://lore.kernel.org/all/20231205184248.1502704-9-andrii@kernel.org/
> 
> Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
> Cc: Martin KaFai Lau <kafai@fb.com>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

Tested-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Thanks!

