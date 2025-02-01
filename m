Return-Path: <bpf+bounces-50260-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACBDA246D7
	for <lists+bpf@lfdr.de>; Sat,  1 Feb 2025 03:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9984F7A3210
	for <lists+bpf@lfdr.de>; Sat,  1 Feb 2025 02:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9C02AE6C;
	Sat,  1 Feb 2025 02:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="FYSZOnNi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF514A3E;
	Sat,  1 Feb 2025 02:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738377282; cv=none; b=ReK2wnA0Vc2Hb9QemjKjCf21G8hhMNlOXr14gFdQOP70hDVrgXBJJge8LCBTCoOGfeiRo8Q5YqIysr4nrQaNbeGlv6cTs+qcZCQXVUrspalqZPdiCCkInPHj5mHWtNYKtr7CH1sZ+2unZRowzrAUXy5kjWf4iEVnbEaqAZmSkeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738377282; c=relaxed/simple;
	bh=ReEN1IxxxtTuoEuz4BJIkm4/6c+phY6V3RgjHBYL6xw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fB09JEmn3IG/vQUQnU5D9DpYkoHq1SXzqtutNKH9llSN3h3Yg5dCyt9WfPFafyQ4c+MI+7FPRBl1hDohmcwnWPaXziQULBDn5edpC0q/cHlj9wvIc9W2UH4lH+IJOo1tq4o1TOLZS34kHZ+p5MNzA6hi7Yo2gXVIL8OfiLjdTLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=FYSZOnNi; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738377280; x=1769913280;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SWcIPcGAxd8b2O6+QcrEVcXi3wMDlMx/wdi9TkC4WQc=;
  b=FYSZOnNimTB2xLyf4bTl/LhhHmkYwkWXP/8Oit/Uqw9qpcKusTEXBQp2
   TDDVBiPIeNlF5PdlfhmclXJ+PwwI6pM8TjeIZD7SXzWHUurPQBwLfVGib
   vk28TEvP/6MWUU+HqucHy4eiY28KvQYpcn6Nctzy9VXk2UM+TslRmdDt1
   A=;
X-IronPort-AV: E=Sophos;i="6.13,250,1732579200"; 
   d="scan'208";a="168702343"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2025 02:34:38 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:53463]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.117:2525] with esmtp (Farcaster)
 id 6ec6fbf9-f59b-4ee8-a177-2b399b77dcb9; Sat, 1 Feb 2025 02:34:38 +0000 (UTC)
X-Farcaster-Flow-ID: 6ec6fbf9-f59b-4ee8-a177-2b399b77dcb9
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sat, 1 Feb 2025 02:34:37 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.33) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sat, 1 Feb 2025 02:34:34 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <martin.lau@linux.dev>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<daniel@iogearbox.net>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<memxor@gmail.com>, <netdev@vger.kernel.org>, <yan@cloudflare.com>
Subject: Re: [PATCH v1 bpf] net: Annotate rx_sk with __nullable for trace_kfree_skb.
Date: Fri, 31 Jan 2025 18:34:26 -0800
Message-ID: <20250201023426.58977-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <feb7ac0f-54e7-4e45-b79e-0fc8a4509437@linux.dev>
References: <feb7ac0f-54e7-4e45-b79e-0fc8a4509437@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA002.ant.amazon.com (10.13.139.53) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Martin KaFai Lau <martin.lau@linux.dev>
Date: Fri, 31 Jan 2025 18:19:22 -0800
> On 1/31/25 4:14 PM, Kuniyuki Iwashima wrote:
> > Yan Zhai reported a BPF prog could trigger a null-ptr-deref [0]
> > in trace_kfree_skb if the prog does not check if rx_sk is NULL.
> > 
> > Commit c53795d48ee8 ("net: add rx_sk to trace_kfree_skb") added
> > rx_sk to trace_kfree_skb, but rx_sk is optional and could be NULL.
> > 
> > Let's add __nullable suffix to rx_sk to let the BPF verifier
> > validate such a prog and prevent the issue.
> > 
> > Now we fail to load such a prog:
> > 
> >    libbpf: prog 'drop': -- BEGIN PROG LOAD LOG --
> >    0: R1=ctx() R10=fp0
> >    ; int BPF_PROG(drop, struct sk_buff *skb, void *location, @ kfree_skb_sk_null.bpf.c:21
> >    0: (79) r3 = *(u64 *)(r1 +24)
> >    func 'kfree_skb' arg3 has btf_id 5253 type STRUCT 'sock'
> >    1: R1=ctx() R3_w=trusted_ptr_or_null_sock(id=1)
> >    ; bpf_printk("sk: %d, %d\n", sk, sk->__sk_common.skc_family); @ kfree_skb_sk_null.bpf.c:24
> >    1: (69) r4 = *(u16 *)(r3 +16)
> >    R3 invalid mem access 'trusted_ptr_or_null_'
> >    processed 2 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
> >    -- END PROG LOAD LOG --
> > 
> > Note this fix requires commit 8aeaed21befc ("bpf: Support
> > __nullable argument suffix for tp_btf").
> 
> I believe the current way is to add kfree_skb to the raw_tp_null_args[],
> https://lore.kernel.org/all/20241213221929.3495062-3-memxor@gmail.com/

Oh, this is nice, thanks Martin!

I was wondering if other explicit NULL-able args should be renamed,
but looks like this series fixed all.

Will post this as v2.

---8<---
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 9de6acddd479..c3223e0db2f5 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6507,6 +6507,8 @@ static const struct bpf_raw_tp_null_args raw_tp_null_args[] = {
 	/* rxrpc */
 	{ "rxrpc_recvdata", 0x1 },
 	{ "rxrpc_resend", 0x10 },
+	/* skb */
+	{"kfree_skb", 0x1000},
 	/* sunrpc */
 	{ "xs_stream_read_data", 0x1 },
 	/* ... from xprt_cong_event event class */
---8<---

Thanks!

