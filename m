Return-Path: <bpf+bounces-73678-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE01C3724F
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 18:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5096218880E1
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 17:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA0B338920;
	Wed,  5 Nov 2025 17:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xfel.eu header.i=@xfel.eu header.b="bQWKZwRg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-o-1.desy.de (smtp-o-1.desy.de [131.169.56.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A1F18C332
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 17:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762364469; cv=none; b=dQaaJKzlLZhC+uIZtnEMAEK4uRxqRC6SF+E4vqfSMoMus374azTJzehKfXBjxocpxr8/4t5kWsKI0PERpKmuM+DTu8AIu5qmK3zOGJ7m++VoPRb2wx+jYQqKlZYHMXNFBtc3uYWKWeKKBip9yhdfyIqfyjEfo+vGWUc94QoPIwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762364469; c=relaxed/simple;
	bh=q47SKR5V34peNe0rpbOwlnwbM22Dgyg1GXN2S/mflQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z4WMHGo7JpaVeiCfvOhIzcfohskSvR/o7rD3a7D3APH6/7OT8fn33KlPU6QTK9+Ztud483AO+S2f7OD5vJ9EX0bywnY42w6vt8VsfHxNahbBQizH6nrJq+LdVxSPbaoJMtXZOt2bT0v563EN9fzXF+RPEZC+Q04c+kIbNn2MIpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xfel.eu; spf=none smtp.mailfrom=mail.desy.de; dkim=pass (1024-bit key) header.d=xfel.eu header.i=@xfel.eu header.b=bQWKZwRg; arc=none smtp.client-ip=131.169.56.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xfel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mail.desy.de
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [131.169.56.164])
	by smtp-o-1.desy.de (Postfix) with ESMTP id 3902811F749
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 18:40:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de 3902811F749
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xfel.eu; s=default;
	t=1762364456; bh=CwTnSz1oq2ql2CFt9KOUtsasxMVd6zYRKi7ae5j4FAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bQWKZwRguHY8DUiBG12I32/txdM0OpPxHs2gVWGiHRepbwLCNWrlvPa6cUI8oDPZb
	 0pcI50nBegMfdhfjNqFXSpIifk9o90wKf2U2+MNSIKandc/8K91KSRtqrzI16c2urq
	 4uc/9eyuVA0qubl2q40aBsRtvzpF3MG2rsshFCaE=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [IPv6:2001:638:700:1038::1:82])
	by smtp-buf-1.desy.de (Postfix) with ESMTP id 2C0EB20056;
	Wed,  5 Nov 2025 18:40:56 +0100 (CET)
Received: from a1722.mx.srv.dfn.de (a1722.mx.srv.dfn.de [IPv6:2001:638:d:c301:acdc:1979:2:e7])
	by smtp-m-2.desy.de (Postfix) with ESMTP id 2066016003F;
	Wed,  5 Nov 2025 18:40:56 +0100 (CET)
Received: from smtp-intra-1.desy.de (smtp-intra-1.desy.de [IPv6:2001:638:700:1038::1:52])
	by a1722.mx.srv.dfn.de (Postfix) with ESMTP id 615F6320093;
	Wed,  5 Nov 2025 18:40:55 +0100 (CET)
Received: from exflqr30474.desy.de (exflqr30474.desy.de [192.168.177.248])
	by smtp-intra-1.desy.de (Postfix) with ESMTP id 463EE80046;
	Wed,  5 Nov 2025 18:40:52 +0100 (CET)
Received: by exflqr30474.desy.de (Postfix, from userid 31112)
	id 3EBBE201A9; Wed,  5 Nov 2025 18:40:52 +0100 (CET)
From: Martin Teichmann <martin.teichmann@xfel.eu>
To: bpf@vger.kernel.org
Cc: eddyz87@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	Martin Teichmann <martin.teichmann@xfel.eu>
Subject: [PATCH v3 bpf-next 0/2] bpf: properly verify tail call behavior
Date: Wed,  5 Nov 2025 18:40:29 +0100
Message-ID: <20251105174031.2801707-1-martin.teichmann@xfel.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ec29fa64723036f672afd18686454d02857ea4e9.camel@gmail.com>
References: <ec29fa64723036f672afd18686454d02857ea4e9.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I added the changes you proposed.

regarding bpf_insn_successors(), nothing needs to be done, call
already have the next instruction as successor by default, and this
is all we need. The fact that a tail call can also be an exit in
disguise is handled by calling bpf_update_live_stack().

In total, this patch now fixed three bugs: a regression wheras
programs that modify packet data after a tail call are unnecessarily
rejected, proper treatment of precision propagation and live stack
tracking.

Martin Teichmann (2):
  bpf: properly verify tail call behavior
  bpf: test the proper verification of tail calls

 kernel/bpf/verifier.c                         | 26 ++++++++--
 .../selftests/bpf/progs/verifier_live_stack.c | 46 ++++++++++++++++++
 .../selftests/bpf/progs/verifier_sock.c       | 39 ++++++++++++++-
 .../bpf/progs/verifier_subprog_precision.c    | 47 +++++++++++++++++++
 4 files changed, 153 insertions(+), 5 deletions(-)

-- 
2.43.0


