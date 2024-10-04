Return-Path: <bpf+bounces-40910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C56E98FC26
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 04:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F36E1C22EA3
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 02:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31191757D;
	Fri,  4 Oct 2024 02:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gDIte+0R"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D061CF83;
	Fri,  4 Oct 2024 02:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728007394; cv=none; b=fdRcw3tRPaozYbBqdGmHwf+7W47RHGHhe9Cisz7PO8d3kCJFomUjXc5qYCA9EUkvzumbe3ClNKcBlgeQK8rDucMy20O3RXdk1hXVeLsB38wBB71f05h9WSUUvlGO8ZFfbC4cQT9DhKLsTpBJerKYSPt/bEKJ8cUtFFIiA/aIX9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728007394; c=relaxed/simple;
	bh=xBy5xxPttXpoKmeS5htAuuM3CAVAm9iT5jJyKNF+eIw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZrKMzX3BlD8faOljrwB5r5CMpT+2Wj7J7KM5j4qWi9nwqA3OGiFOEF+wwWwAXm5Q92z988bLY1kKZXC57ubEWwmbF+4ZGbgyqZ4Cq7pJrW+1caSyY623HhqTYF+oxlIc4q2vehZiHn1qdyeSDj2Ao3gJtlPQRzeMXlrFO2sdoGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=gDIte+0R; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728007393; x=1759543393;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OrYxuOVIwtDd8EHnuqgfiuqojqhzTcf+aidN+5Z+j9o=;
  b=gDIte+0R7+7PPEAF684Lh8lNr1G1vb2jFD9bMRmVZVmJXNp89WKyxQQH
   PSccgd14TZK1SlAHw/h84R9zzDh9GkeDeCDdWFtlEyMOHFkvnXbqOns1Q
   h/wyUCgKHNoEbuy2w96oz/7o5wW282fN23K0Rge+YjEcNj9C0NbI926m0
   g=;
X-IronPort-AV: E=Sophos;i="6.11,176,1725321600"; 
   d="scan'208";a="372738814"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 02:03:07 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:11290]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.107:2525] with esmtp (Farcaster)
 id c43e4caf-259b-484f-a33b-b822dee6cf3c; Fri, 4 Oct 2024 02:03:06 +0000 (UTC)
X-Farcaster-Flow-ID: c43e4caf-259b-484f-a33b-b822dee6cf3c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 4 Oct 2024 02:03:05 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 4 Oct 2024 02:03:03 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <martin.lau@linux.dev>
CC: <bpf@vger.kernel.org>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>
Subject: Re: [Question]: A non NULL req->sk in tcp_rtx_synack. Not a fastopen connection.
Date: Thu, 3 Oct 2024 19:02:55 -0700
Message-ID: <20241004020255.36532-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <eb6684d0-ffd9-4bdc-9196-33f690c25824@linux.dev>
References: <eb6684d0-ffd9-4bdc-9196-33f690c25824@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA003.ant.amazon.com (10.13.139.31) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Martin KaFai Lau <martin.lau@linux.dev>
Date: Thu, 3 Oct 2024 18:14:09 -0700
> Hi,
> 
> We are seeing a use-after-free from a bpf prog attached to 
> trace_tcp_retransmit_synack. The program passes the req->sk to the 
> bpf_sk_storage_get_tracing kernel helper which does check for null before using it.
> 
> fastopen is not used.
> 
> We got a kfence report on use-after-free (pasted at the end). It is running with 
> an older 6.4 kernel and we hardly hit this in production.
> 
>  From the upstream code, del_timer_sync() should have been done by 
> inet_csk_reqsk_queue_drop() before "req->sk = child;" is assigned in 
> inet_csk_reqsk_queue_add(). My understanding is the req->rsk_timer should have 
> been stopped before the "req->sk = child;" assignment.

There seems to be a small race window in reqsk_queue_unlink().

expire_timers() first calls detach_timer(, true), which marks the timer
as not pending, and then calls reqsk_timer_handler().

If reqsk_queue_unlink() calls timer_pending() just before expire_timers()
calls reqsk_timer_handler(), reqsk_queue_unlink() could miss
del_timer_sync() ?

---8<---
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 2c5632d4fddb..4ba47ee6c9da 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1045,7 +1045,7 @@ static bool reqsk_queue_unlink(struct request_sock *req)
 		found = __sk_nulls_del_node_init_rcu(sk);
 		spin_unlock(lock);
 	}
-	if (timer_pending(&req->rsk_timer) && del_timer_sync(&req->rsk_timer))
+	if (del_timer_sync(&req->rsk_timer))
 		reqsk_put(req);
 	return found;
 }
---8<---


> 
> or there are cases that req->sk is not NULL in the reqsk_timer_handler()?
> 
> BUG: KFENCE: use-after-free read in bpf_sk_storage_get_tracing+0x2e/0x1b0
> 
> Use-after-free read at 0x00000000a891fb3a (in kfence-#1):
> bpf_sk_storage_get_tracing+0x2e/0x1b0
> bpf_prog_5ea3e95db6da0438_tcp_retransmit_synack+0x1d20/0x1dda
> bpf_trace_run2+0x4c/0xc0
> tcp_rtx_synack+0xf9/0x100
> reqsk_timer_handler+0xda/0x3d0
> run_timer_softirq+0x292/0x8a0
> irq_exit_rcu+0xf5/0x320
> sysvec_apic_timer_interrupt+0x6d/0x80
> asm_sysvec_apic_timer_interrupt+0x16/0x20
> intel_idle_irq+0x5a/0xa0
> cpuidle_enter_state+0x94/0x273
> cpu_startup_entry+0x15e/0x260
> start_secondary+0x8a/0x90
> secondary_startup_64_no_verify+0xfa/0xfb
> 
> kfence-#1: 0x00000000a72cc7b6-0x00000000d97616d9, size=2376, cache=TCPv6
> 
> allocated by task 0 on cpu 9 at 260507.901592s:
> sk_prot_alloc+0x35/0x140
> sk_clone_lock+0x1f/0x3f0
> inet_csk_clone_lock+0x15/0x160
> tcp_create_openreq_child+0x1f/0x410
> tcp_v6_syn_recv_sock+0x1da/0x700
> tcp_check_req+0x1fb/0x510
> tcp_v6_rcv+0x98b/0x1420
> ipv6_list_rcv+0x2258/0x26e0
> napi_complete_done+0x5b1/0x2990
> mlx5e_napi_poll+0x2ae/0x8d0
> net_rx_action+0x13e/0x590
> irq_exit_rcu+0xf5/0x320
> common_interrupt+0x80/0x90
> asm_common_interrupt+0x22/0x40
> cpuidle_enter_state+0xfb/0x273
> cpu_startup_entry+0x15e/0x260
> start_secondary+0x8a/0x90
> secondary_startup_64_no_verify+0xfa/0xfb
> 
> freed by task 0 on cpu 9 at 260507.927527s:
> rcu_core_si+0x4ff/0xf10
> irq_exit_rcu+0xf5/0x320
> sysvec_apic_timer_interrupt+0x6d/0x80
> asm_sysvec_apic_timer_interrupt+0x16/0x20
> cpuidle_enter_state+0xfb/0x273
> cpu_startup_entry+0x15e/0x260
> start_secondary+0x8a/0x90
> secondary_startup_64_no_verify+0xfa/0xfb
> 
> Thanks,
> Martin

