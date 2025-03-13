Return-Path: <bpf+bounces-53982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E98DCA5FF7E
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 19:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D12F63AA469
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 18:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A287E1EBFE4;
	Thu, 13 Mar 2025 18:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Eady/t0U";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wQeEiPqA"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A083018952C;
	Thu, 13 Mar 2025 18:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741891157; cv=none; b=M05jltUyycQwwHLcUbrktEiLk5fmsevCscaZykwdqtJ4Wc2fSsqD9uSGnIt93RRRNOnN1lzDvakBONvkSvBkeiuGDi04tqhGEcrGptej4PjRd0PZZsAHQ1H88pRM7gUy7gDWkrFbcLHoqfb+i7HN7cNPA+gbSBs70mHQRENfL4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741891157; c=relaxed/simple;
	bh=vT7fEt4DTg/BcGO6eidXlfE7hOX3H3MwLUghGMoyLBk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UUEnrYdZQaeGPP9qfE0gOHL0i4M04wCusV50iST4erP5VwDSBu50HI6TG7pPFJv3r9a7CBU/0o15WxkC1i+CodxNrlIK7Kn8tdqQKuYq0wYxESanioJmEAOeGGCG+WCetIoFN5EWvgQIFAWfGRXZENvQMrAN8qcAn35/72Mo7ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Eady/t0U; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wQeEiPqA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 13 Mar 2025 19:39:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741891153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=uOO4FSJBCvfZv7qYVAR8q4W2YmT/UHDlu5Twuo7/U5U=;
	b=Eady/t0U/HGdfvWWZFXBzwyxFCPBbl3uUxqiK+cfoHf4PTxyVcLI6rb+gysMI1RIUqnjbC
	r4PiPdSwTBfAQRPuvqsOEGdoE/6ExTrAsa/hOf+om/KD8Of4skP9DzdPxV/Psgv1SjK5R4
	JM5+dQyRT51Bh8kjL2MIYvsEqT12x5odg/9Qf6PhESuX2zvfs/LiJe99HNxVuXGAd1jB2u
	L6oE3L0wB2B/rC0PWR6z7ADHlohWOIs1+V+KLshHCca1RzJhvO4Sj3i8j8xNHtO2CZFA6w
	fT8TU+Vtk9vkBlHxTO1L23RNVrgtS68jZNQoJmOEhjXWvEdesVdUYtToSBEQug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741891153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=uOO4FSJBCvfZv7qYVAR8q4W2YmT/UHDlu5Twuo7/U5U=;
	b=wQeEiPqA1og6JG33+LAvv42oQlaX5OSeDaMckRyOdVP2dENm1eMQnzIiK4+E80FAuclzBV
	0GuZTv3ZKuDiu3Aw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: Ricardo =?utf-8?Q?Ca=C3=B1uelo?= Navarro <rcn@igalia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC] Use after free in BPF/ XDP during XDP_REDIRECT
Message-ID: <20250313183911.SPAmGLyw@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

Ricardo reported a KASAN related use after free
	https://lore.kernel.org/all/20250226-20250204-kasan-slab-use-after-free-read-in-dev_map_enqueue__submit-v3-0-360efec441ba@igalia.com/

in v6.6 stable and suggest a backport of commits
	401cb7dae8130 ("net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.")
	fecef4cd42c68 ("tun: Assign missing bpf_net_context.")
	9da49aa80d686 ("tun: Add missing bpf_net_ctx_clear() in do_xdp_generic()")

as a fix. In the meantime I have the syz reproducer+config and was able
to investigate.
It looks as if the syzbot starts a BPF program via xdp_test_run_batch()
which assigns ri->tgt_value via dev_hash_map_redirect() and the return code
isn't XDP_REDIRECT it looks like nonsense. So the print in
bpf_warn_invalid_xdp_action() appears once. Everything goes as planned.
Then the TUN driver runs another BPF program which returns XDP_REDIRECT
without setting ri->tgt_value. This appears to be a trick because it
invoked bpf_trace_printk() which printed four characters. Anyway, this
is enough to get xdp_do_redirect() going.

The commits in questions do fix it because the bpf_redirect_info becomes
not only per-task but gets invalidated after the XDP context is left.

Now that I understand it I would suggest something smaller instead as a
stable fix, (instead the proposed patches). Any objections to the
following:

diff --git a/net/core/filter.c b/net/core/filter.c
index be313928d272..1d906b7a541d 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -9000,8 +9000,12 @@ static bool xdp_is_valid_access(int off, int size,
 
 void bpf_warn_invalid_xdp_action(struct net_device *dev, struct bpf_prog *prog, u32 act)
 {
+	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
 	const u32 act_max = XDP_REDIRECT;
 
+	ri->map_id = INT_MAX;
+	ri->map_type = BPF_MAP_TYPE_UNSPEC;
+
 	pr_warn_once("%s XDP return value %u on prog %s (id %d) dev %s, expect packet loss!\n",
 		     act > act_max ? "Illegal" : "Driver unsupported",
 		     act, prog->aux->name, prog->aux->id, dev ? dev->name : "N/A");



Sebastian

