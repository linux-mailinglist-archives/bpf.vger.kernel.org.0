Return-Path: <bpf+bounces-73804-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CDDC3A6A1
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 11:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A262502A30
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 10:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162782EC097;
	Thu,  6 Nov 2025 10:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xfel.eu header.i=@xfel.eu header.b="GLIEQ+92"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-o-2.desy.de (smtp-o-2.desy.de [131.169.56.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16A62E8B9E
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 10:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762426379; cv=none; b=s7DpRHfsoCGoD8A5r2lQdf8/h9ovZlH8xLpD4uyuQZ2gRPLr9gIO0JVB17I2AAmeFviw5f7CtQITOpwjtjfPtN50kYZkc/77QPmPj5h5wHmejSJvisbdHEJUzedNsgHE3xUlsTx+VteBKoaEEqf6KKNHdIkqkhfkiUVWXq/h4ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762426379; c=relaxed/simple;
	bh=krjPMp6VLnU+XGkPJYRFUAiTybmVRHjYjJLja3NFC0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QBVZ+bqg4FG7eqVhvD43/rAVeFPtOzWRYgD61frBObQ5BQ/OsqxVawW9RBFc8gHpJOhAZUw/AI/Tw6nTlHw9o1dymg+V0iWO/UcoZxLX4IQGrgJ3zD3dWg3gWP2jcyYutmNwby9dNPGqwMbP44kQ012xyhP8IcWKp9iVyYrmD8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xfel.eu; spf=none smtp.mailfrom=mail.desy.de; dkim=pass (1024-bit key) header.d=xfel.eu header.i=@xfel.eu header.b=GLIEQ+92; arc=none smtp.client-ip=131.169.56.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xfel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mail.desy.de
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [IPv6:2001:638:700:1038::1:a5])
	by smtp-o-2.desy.de (Postfix) with ESMTP id 2ED3A13F651
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 11:52:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de 2ED3A13F651
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xfel.eu; s=default;
	t=1762426370; bh=ivaaaFyW+NoKDBx9zX/V26ZrYJrZzrQMy/o9ru4RVO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GLIEQ+92asn3dg2SMTn3xaOuggrgqyjZ/50qiU+WzpwLFIRMoss2FGrgZsDijKy6e
	 LpS56K3zEPAdm8VMG4E6pAFwc40xBOFiIHkGiKuoXZTw1FRv1lafu0b9pH4xNxLMI5
	 sdm2h7WUwFU2m/RXnu9E4pbVUqE9HGcV6R4smD6g=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [IPv6:2001:638:700:1038::1:82])
	by smtp-buf-2.desy.de (Postfix) with ESMTP id 22E4C120043;
	Thu,  6 Nov 2025 11:52:50 +0100 (CET)
Received: from a1722.mx.srv.dfn.de (a1722.mx.srv.dfn.de [194.95.233.47])
	by smtp-m-2.desy.de (Postfix) with ESMTP id 1710716003F;
	Thu,  6 Nov 2025 11:52:50 +0100 (CET)
Received: from smtp-intra-2.desy.de (smtp-intra-2.desy.de [131.169.56.83])
	by a1722.mx.srv.dfn.de (Postfix) with ESMTP id A05A03200A2;
	Thu,  6 Nov 2025 11:52:47 +0100 (CET)
Received: from exflqr30474.desy.de (exflqr30474.desy.de [192.168.177.248])
	by smtp-intra-2.desy.de (Postfix) with ESMTP id 833912004C;
	Thu,  6 Nov 2025 11:52:47 +0100 (CET)
Received: by exflqr30474.desy.de (Postfix, from userid 31112)
	id 7D0D4201A9; Thu,  6 Nov 2025 11:52:47 +0100 (CET)
From: Martin Teichmann <martin.teichmann@xfel.eu>
To: bpf@vger.kernel.org
Cc: eddyz87@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	Martin Teichmann <martin.teichmann@xfel.eu>
Subject: [PATCH v4 bpf-next 0/2] bpf: properly verify tail call behavior
Date: Thu,  6 Nov 2025 11:52:36 +0100
Message-ID: <20251106105238.2926962-1-martin.teichmann@xfel.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <c571ab7af853a3f775be3a518f99ec809f49797f.camel@gmail.com>
References: <c571ab7af853a3f775be3a518f99ec809f49797f.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Eduard,

you are right, backtrack_insn() did not properly deal with tail calls.
I fixed that, and added your test, which now passes properly.

What my code does is to effectively treat (following your example):

foo(int *a):
  tail call;
  *a = 0;
  return;

as

foo(int *a);
  if (prog_map_has_entry) {
      tail call;
      return;
   }
   *a = 0;
   return;

In bpf_insn_successors(), a BPF_EXIT is declared as can_jump=false and
can_fallthrough=false. This is how the return after tail call should be
treated. Let's go through the three lines: the if statement has two
successors, the jump and the fallthrough. The fallthrough is the tail call,
which has the return as its only successor, which in turn has no successor
as BPF_EXIT has no successor. So we are left with the jump successor of
the if statement, which is nothing else than the fallthrough of the entire
three lines. So if we go back to the original code, we have an effective
can_jump=false, can_fallthrough=true. This is the default for BPF_CALL in
bpf_insn_successors(), so no code change is needed.

Martin Teichmann (2):
  bpf: properly verify tail call behavior
  bpf: test the proper verification of tail calls

 kernel/bpf/verifier.c                         | 31 +++++++++-
 .../selftests/bpf/progs/verifier_live_stack.c | 60 +++++++++++++++++++
 .../selftests/bpf/progs/verifier_sock.c       | 39 +++++++++++-
 .../bpf/progs/verifier_subprog_precision.c    | 47 +++++++++++++++
 4 files changed, 172 insertions(+), 5 deletions(-)

-- 
2.43.0


