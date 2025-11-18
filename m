Return-Path: <bpf+bounces-74971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 602AEC69A96
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 14:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 28E57380D1A
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 13:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F28D3559D2;
	Tue, 18 Nov 2025 13:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xfel.eu header.i=@xfel.eu header.b="SWyCWdM1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-o-3.desy.de (smtp-o-3.desy.de [131.169.56.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E192D77E3
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 13:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763473533; cv=none; b=PklzCi4OjJC55fmfgApKQ4QHhj2aCgebzdonmJH4q7E+TRBaxecxXD65FeydtWqPug1kqw+3Flg6rxkweCw8LlPpXQ0QQs6uTIYBhC563fHkXiHuZ7DRipNINScd5+udwI4m5H3w744njGXXFARdmhEOoG/1tpWY1SXFO3l8MRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763473533; c=relaxed/simple;
	bh=j+QLSnsKZdlI5wr+v7alTIYCVg989+BiBD/HSoCJlWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zuw633el8U/hgQtDPVNEH95r78yUF1o2e+mLBftx1InJIYP5NTs5/ABYQPjw5MvfhpoxSvdH2jLtQrG7FQzKARiJ4p71pF9dXfl51l45pSv2Q6z/4VW8O2/G+bZ/oqRk2bKkuu2iTbLOW3f9F1+SCwzxdOoraCduH6Mr3CzGsv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xfel.eu; spf=none smtp.mailfrom=mail.desy.de; dkim=pass (1024-bit key) header.d=xfel.eu header.i=@xfel.eu header.b=SWyCWdM1; arc=none smtp.client-ip=131.169.56.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xfel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mail.desy.de
Received: from smtp-o-1.desy.de (smtp-o-1.desy.de [131.169.56.154])
	by smtp-o-3.desy.de (Postfix) with ESMTP id 8F64811F99A
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 14:39:59 +0100 (CET)
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [131.169.56.164])
	by smtp-o-1.desy.de (Postfix) with ESMTP id A999711F746
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 14:39:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de A999711F746
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xfel.eu; s=default;
	t=1763473191; bh=RM0NpuBzFi/i0p8+xjhf0RVOsrDHq9jh+PTfyOOksa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SWyCWdM1+PeQPE2CbMeIZuFlFhexHjsOuWSNPRQPzcj4Eo0u1tcmvWqXb3hV7uFXa
	 sB6YQFYf7n9X9UfW9gOh3v+n1buBeYvlLGoiIOgwTetGH2aWGCHYRL5vr5ZKn+aytc
	 Hby4NCufJPPTsEAfN6Vf2/Ko5/ouIMjqQOKbdafo=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [IPv6:2001:638:700:1038::1:81])
	by smtp-buf-1.desy.de (Postfix) with ESMTP id 9B5A620056;
	Tue, 18 Nov 2025 14:39:51 +0100 (CET)
Received: from c1722.mx.srv.dfn.de (c1722.mx.srv.dfn.de [IPv6:2001:638:d:c303:acdc:1979:2:e7])
	by smtp-m-1.desy.de (Postfix) with ESMTP id 8D48640044;
	Tue, 18 Nov 2025 14:39:51 +0100 (CET)
Received: from smtp-intra-2.desy.de (smtp-intra-2.desy.de [IPv6:2001:638:700:1038::1:53])
	by c1722.mx.srv.dfn.de (Postfix) with ESMTP id CB1DE100033;
	Tue, 18 Nov 2025 14:39:50 +0100 (CET)
Received: from exflqr30474.desy.de (exflqr30474.desy.de [192.168.177.248])
	by smtp-intra-2.desy.de (Postfix) with ESMTP id AAAAD2004C;
	Tue, 18 Nov 2025 14:39:50 +0100 (CET)
Received: by exflqr30474.desy.de (Postfix, from userid 31112)
	id A2C93201AE; Tue, 18 Nov 2025 14:39:50 +0100 (CET)
From: Martin Teichmann <martin.teichmann@xfel.eu>
To: bpf@vger.kernel.org
Cc: eddyz87@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	Martin Teichmann <martin.teichmann@xfel.eu>
Subject: [PATCH v5 bpf-next 0/4] bpf: properly verify tail call behavior
Date: Tue, 18 Nov 2025 14:39:40 +0100
Message-ID: <20251118133944.979865-1-martin.teichmann@xfel.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <4952b7bf8a0b50352b31bee7ddf89e7809101af6.camel@gmail.com>
References: <4952b7bf8a0b50352b31bee7ddf89e7809101af6.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi List,

sorry for the late response, somehow the continuous integration was down and I
did not want to submit untested code...

This patch set adresses the fact that tail calls may return from the calling
function, which needs to be reflected in the verifier.

The first patch changes the verifier such that it simulates the actual behavior
of a tail call, the second patch tests the correct behavior.

During the discussion of this patch, Eduard Zingerman found another bug in the
stack liveness calculation, and fixed it. This is the third patch, tested by
the fourth. Both patches are written by Eduard, the only thing I changed was to
assure it properly applies on top of my patches, and a small addition that
Eduard asked for. He asked to add his patches on top of mine, yet all credits
for these patches should go to him, I do not intent to steal code here.

Eduard also asked for a test for the register liveness in
compute_live_registers.c. I thought long about it, but unfortunately found no
way to properly test the new behavior, as I could not come up with an example
where it would be different from the original one.

Cheers

Martin

Martin Teichmann (4):
  bpf: properly verify tail call behavior
  bpf: test the proper verification of tail calls
  bpf: correct stack liveness for tail calls
  bpf: test the correct stack liveness of tail calls

 include/linux/bpf_verifier.h                  |  5 +-
 kernel/bpf/liveness.c                         |  7 ++-
 kernel/bpf/verifier.c                         | 60 +++++++++++++++++--
 .../selftests/bpf/progs/verifier_live_stack.c | 50 ++++++++++++++++
 .../selftests/bpf/progs/verifier_sock.c       | 39 +++++++++++-
 .../bpf/progs/verifier_subprog_precision.c    | 47 +++++++++++++++
 6 files changed, 196 insertions(+), 12 deletions(-)

-- 
2.43.0


