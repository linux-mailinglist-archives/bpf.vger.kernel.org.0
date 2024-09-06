Return-Path: <bpf+bounces-39090-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 748A396E741
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 03:23:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99639B23374
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 01:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C341C69A;
	Fri,  6 Sep 2024 01:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="NY/MB15f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eajTJiFo"
X-Original-To: bpf@vger.kernel.org
Received: from flow3-smtp.messagingengine.com (flow3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DF91B95B;
	Fri,  6 Sep 2024 01:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725585794; cv=none; b=O6hEtQxKBEGePHOKjvPzn7ShdLO0/lF5I9DogVGGWBKpdP0g02D2LtU0spc8RpFXH2BdQIrRFL9hMAkCE7YLwoAu/i8obDfZU1MiN223uouBGHKgNxqsttyd+EyFMX+oIztD5mpa8fgrdYMR6b+HPxxboB5uGw1F34bxMUeZ248=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725585794; c=relaxed/simple;
	bh=QbZc9W2BU8o3+sGJ99yc/zeztjJZO1Lcl9k0rwEQxYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qg5LeT8BlwmPq2buWkWwjgvuALs4Ax1T52XkVuDTCGYSneFZw6xz6YApTD7prKqAf0TBLZ1RKjrhOU3IxhMBgnzAQ1LwUALraarzIejdiQyI9qEosuNnnPSe4QxYeneQvecv35A5hsSNJrX2tIJ9w8M77jsR6ggNOb4lvR8Nigs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=NY/MB15f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eajTJiFo; arc=none smtp.client-ip=103.168.172.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 35D8F2001CE;
	Thu,  5 Sep 2024 21:23:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 05 Sep 2024 21:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1725585791; x=1725592991; bh=qLRePdg55QxpUUiQevrCY
	7uWZdbnM0AomvqP1esiNFo=; b=NY/MB15f3ZlBBLbm0ijQoZCLeNMSjmHzsDLiw
	EjFi22gwRd6y8gYb0jTcRDWsY8YIku+O9BJ9ytpox7AryUlG1BTiDg04k+Z7dtQs
	dYtcOknlFAnXqAbswFtzmC7M5UYbCUfJPMJQArBMkjXQCQdvbCLL03mpTbXfZD0i
	TKPecY76s8k6MJS4ylEZZgLbIy/uVpdxFHxDmZTCS/SrDOl8NC304vAG3jyTEsNn
	dsmuJNbf+4CKN8eZzcLz6l/LjoQMJBdsb0MZ4TX7ZDrkJPVMFabppe+upMLRXsfC
	6Ikan/J7Id7Cf860EUHgWRY05xfWzKU8/g++zKiQLb6j3+1Wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725585791; x=1725592991; bh=qLRePdg55QxpUUiQevrCY7uWZdbn
	M0AomvqP1esiNFo=; b=eajTJiFog1oA4cYSW6bW8kTtS49zpKdYUiLAl3QuK9a9
	WEWyqQFiFQB6W1a0Hn0Qknb7viYdH8khOoGC1rQB0f1iS9daGRnCVWjR9kS/7a5/
	gr/FkW2kBPCCtAIkOZ7/Z0pbdykRt7cQUnUn/0AjktiEEjZ6+D7cOVlkd3DN6TDo
	RYqBLHJwkV3xQYGq1nfEuKvDm1iI3uIgwvzPPC0VvuqkDrAdZ3aak2B6M+gDVPXH
	VIuihyKdeOtH+k+B/1GbIQCMzii0lOGZNjFKhJFmFk9YqgsTFzVscwyeuGNicgEV
	fgnb0fJJ3DnGlce5a8It1Bzclb36pmhOKrsCy2GFYQ==
X-ME-Sender: <xms:flnaZmDt5HvfToOFGAb4fvxOBgII_amNNfXVp3vzWPU2kO1tV1NxbQ>
    <xme:flnaZghuM8qpi4kjVsbinJ6kVELCMVwVPYwqxUCjDlhvqJ4tDPsGa5LNogv-ngg58
    dFRXbWNyp7uFbU9yA>
X-ME-Received: <xmr:flnaZplhgaOTJEoSKjh-NSZuFHqt26-UOZmoh9YCv39Bu-jZZIwpdOMN_CZgcpNcs2wduDRR8_zGkoN_CV0mxpgTS8Ukif9EREIU1Kg3me4LglxC8sSv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeitddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlje
    dtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghn
    ihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepvd
    eggfetgfelhefhueefkeduvdfguedvhfegleejudduffffgfetueduieeikeejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguh
    huuhdrgiihiidpnhgspghrtghpthhtohepvddupdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghsth
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgrfihksehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivg
    hlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohepjhhohhhnrdhfrghsthgrsggv
    nhgusehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrihhisehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehmrghrthhinhdrlhgruheslhhinhhugidruggvvhdprhgtphht
    thhopegvugguhiiikeejsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:flnaZkxwtcfBV27c7v7f6-nouL5VS9ohO1G3hCbkG7DNNlGh3fi0bA>
    <xmx:flnaZrTceLUgzxCaqL1nCqBzfyJQx4v3FV3FdzV5CpG2KL4hFcUoBg>
    <xmx:flnaZvZMlulQ2lRY-FSMO7or_3ngQ0pH7ME8nGIerOPW25aWxVg9dA>
    <xmx:flnaZkRaiTduVav-bDAWcXs8qSTTyM24btkQThcNFxwZcw5fk_j1qw>
    <xmx:f1naZsKz7NjJIvngK3i-0z7Dw54eUGdRBNCYX2NhZqGCwhG3kQhHIjbq>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Sep 2024 21:23:08 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: davem@davemloft.net,
	ast@kernel.org,
	hawk@kernel.org,
	kuba@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org
Cc: martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lorenzo@kernel.org,
	aleksander.lobakin@intel.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next] bpf: cpumap: Move xdp:xdp_cpumap_kthread tracepoint before rcv
Date: Thu,  5 Sep 2024 19:22:44 -0600
Message-ID: <47615d5b5e302e4bd30220473779e98b492d47cd.1725585718.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cpumap takes RX processing out of softirq and onto a separate kthread.
Since the kthread needs to be scheduled in order to run (versus softirq
which does not), we can theoretically experience extra latency if the
system is under load and the scheduler is being unfair to us.

Moving the tracepoint to before passing the skb list up the stack allows
users to more accurately measure enqueue/dequeue latency introduced by
cpumap via xdp:xdp_cpumap_enqueue and xdp:xdp_cpumap_kthread tracepoints.

f9419f7bd7a5 ("bpf: cpumap add tracepoints") which added the tracepoints
states that the intent behind them was for general observability and for
a feedback loop to see if the queues are being overwhelmed. This change
does not mess with either of those use cases but rather adds a third
one.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 kernel/bpf/cpumap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index fbdf5a1aabfe..a2f46785ac3b 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -354,12 +354,14 @@ static int cpu_map_kthread_run(void *data)
 
 			list_add_tail(&skb->list, &list);
 		}
-		netif_receive_skb_list(&list);
 
-		/* Feedback loop via tracepoint */
+		/* Feedback loop via tracepoint.
+		 * NB: keep before recv to allow measuring enqueue/dequeue latency.
+		 */
 		trace_xdp_cpumap_kthread(rcpu->map_id, n, kmem_alloc_drops,
 					 sched, &stats);
 
+		netif_receive_skb_list(&list);
 		local_bh_enable(); /* resched point, may call do_softirq() */
 	}
 	__set_current_state(TASK_RUNNING);
-- 
2.46.0


