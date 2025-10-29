Return-Path: <bpf+bounces-72715-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B52C19EBD
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 12:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CBA23353459
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 11:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939E6304BA4;
	Wed, 29 Oct 2025 11:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xfel.eu header.i=@xfel.eu header.b="m0ATAf8j"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-o-3.desy.de (smtp-o-3.desy.de [131.169.56.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C13D3043D1
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 11:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.169.56.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761735919; cv=none; b=T+NbStHEfQpByv5oIMNmDvE1j9bDO7aBKrzcf9neBQhucq3OvP52G8E6PN7TnP21VGo7+xjJRdDyMJ6xbf1kK4hKSlk8FW0t5O6cAdyoP/Pi4ud6KII7jo9NK/aE61a294CG8xlE2CTe/I9kpoGjpEpa2MeU1av2hob49c8amEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761735919; c=relaxed/simple;
	bh=scrAsedfldbtbvngWG7eLW3tez8DvjEgxcTgYu6CUvM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sF6TUSYYoLa0C7Qeh2tZ+dJakfSdPWwzALeD89p6TjeaT63W57jlcv48HzxQ8tr0JEsOzWnI5mmi+qBtSQLEVCLPXfz2SZrE5Q6xnlBv/SPzggah4WxKflxOBj4tdkkLxlMX+X47Z86rVvAMXpMLO1hFhvQc8CC8hfHwi7ejyik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xfel.eu; spf=none smtp.mailfrom=mail.desy.de; dkim=pass (1024-bit key) header.d=xfel.eu header.i=@xfel.eu header.b=m0ATAf8j; arc=none smtp.client-ip=131.169.56.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xfel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mail.desy.de
Received: from smtp-o-1.desy.de (smtp-o-1.desy.de [IPv6:2001:638:700:1038::1:9a])
	by smtp-o-3.desy.de (Postfix) with ESMTP id 8967811F9B2
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 11:58:41 +0100 (CET)
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [131.169.56.165])
	by smtp-o-1.desy.de (Postfix) with ESMTP id 671AD11F744
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 11:58:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de 671AD11F744
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xfel.eu; s=default;
	t=1761735514; bh=nfOOg1aN0IYomXTTBFZk6Oon5l+4HXRhJ2jZ4k1AHTA=;
	h=From:To:Cc:Subject:Date:From;
	b=m0ATAf8je5uWbSB8ZMcpMkTFm+CsPY4HbASkIAXDD6X2v+JzuqBEedy0uvm5ihmju
	 7AAnNXq404/RBsicCdYILNSMlMZXrylinU8AXqwli749WLmR58SQoPbGMkILW8LOOG
	 gyh7oQE4vb7+Dw8R8KXuGr+i9pLGkb7/ctNVriok=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [131.169.56.130])
	by smtp-buf-2.desy.de (Postfix) with ESMTP id 5E480120043
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 11:58:34 +0100 (CET)
Received: from a1722.mx.srv.dfn.de (a1722.mx.srv.dfn.de [IPv6:2001:638:d:c301:acdc:1979:2:e7])
	by smtp-m-2.desy.de (Postfix) with ESMTP id 54A6616003F;
	Wed, 29 Oct 2025 11:58:34 +0100 (CET)
Received: from smtp-intra-2.desy.de (smtp-intra-2.desy.de [131.169.56.83])
	by a1722.mx.srv.dfn.de (Postfix) with ESMTP id BEAEE3200A8;
	Wed, 29 Oct 2025 11:58:32 +0100 (CET)
Received: from exflqr30474.desy.de (exflqr30474.desy.de [192.168.177.248])
	by smtp-intra-2.desy.de (Postfix) with ESMTP id 92FC72004C;
	Wed, 29 Oct 2025 11:58:32 +0100 (CET)
Received: by exflqr30474.desy.de (Postfix, from userid 31112)
	id 8891C201A7; Wed, 29 Oct 2025 11:58:32 +0100 (CET)
From: Martin Teichmann <martin.teichmann@xfel.eu>
To: bpf@vger.kernel.org
Cc: Martin Teichmann <martin.teichmann@xfel.eu>
Subject: [PATCH bpf] bpf: tail calls do not modify packet data
Date: Wed, 29 Oct 2025 11:58:28 +0100
Message-ID: <20251029105828.1488347-1-martin.teichmann@xfel.eu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bpf verifier checks whether packet data is modified within a helper
function, and if so invalidates the pointer to that data. Currently the
verifier always invalidates if the helper function called is a tail
call, as it cannot tell whether the called function does or does not
modify the packet data.

However, in this case, the fact that the packet might be modified is
irrelevant in the code following the helper call, as the tail call only
returns if there is nothing to execute, otherwise the calling
(sub)program will return directly after the tail call finished.

So it is this (sub)program for which the pointer to packet data needs to
be invalidated.

Fortunately, there are already two distinct points in the code for
invalidating packet pointers directly after a helper call, and for
entire (sub)programs. This commit assures that the pointer is only
invalidated in the relevant case.

Note that this is a regression bug: taking care of tail calls only
became necessary when subprograms were introduced, before commit
1a4607ffba35 using a packet pointer after a tail call was working fine,
as it should.

Fixes: 1a4607ffba35 ("bpf: consider that tail calls invalidate packet pointers")
Signed-off-by: Martin Teichmann <martin.teichmann@xfel.eu>
---
 kernel/bpf/verifier.c                          |  3 ++-
 net/core/filter.c                              |  2 --
 .../selftests/bpf/progs/verifier_sock.c        | 18 ++++++++++++++++--
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6d175849e57a..4bc36a1efe93 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17879,7 +17879,8 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 			 */
 			if (ret == 0 && fp->might_sleep)
 				mark_subprog_might_sleep(env, t);
-			if (bpf_helper_changes_pkt_data(insn->imm))
+			if (bpf_helper_changes_pkt_data(insn->imm)
+					|| insn->imm == BPF_FUNC_tail_call)
 				mark_subprog_changes_pkt_data(env, t);
 		} else if (insn->src_reg == BPF_PSEUDO_KFUNC_CALL) {
 			struct bpf_kfunc_call_arg_meta meta;
diff --git a/net/core/filter.c b/net/core/filter.c
index 9d67a34a6650..71a1cfed49f1 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8038,8 +8038,6 @@ bool bpf_helper_changes_pkt_data(enum bpf_func_id func_id)
 	case BPF_FUNC_xdp_adjust_head:
 	case BPF_FUNC_xdp_adjust_meta:
 	case BPF_FUNC_xdp_adjust_tail:
-	/* tail-called program could call any of the above */
-	case BPF_FUNC_tail_call:
 		return true;
 	default:
 		return false;
diff --git a/tools/testing/selftests/bpf/progs/verifier_sock.c b/tools/testing/selftests/bpf/progs/verifier_sock.c
index 2b4610b53382..3e22b4f8aec4 100644
--- a/tools/testing/selftests/bpf/progs/verifier_sock.c
+++ b/tools/testing/selftests/bpf/progs/verifier_sock.c
@@ -1117,10 +1117,10 @@ int tail_call(struct __sk_buff *sk)
 	return 0;
 }
 
-/* Tail calls invalidate packet pointers. */
+/* Tail calls in sub-programs invalidate packet pointers. */
 SEC("tc")
 __failure __msg("invalid mem access")
-int invalidate_pkt_pointers_by_tail_call(struct __sk_buff *sk)
+int invalidate_pkt_pointers_by_indirect_tail_call(struct __sk_buff *sk)
 {
 	int *p = (void *)(long)sk->data;
 
@@ -1131,4 +1131,18 @@ int invalidate_pkt_pointers_by_tail_call(struct __sk_buff *sk)
 	return TCX_PASS;
 }
 
+/* Direct tail calls do not invalidate packet pointers. */
+SEC("tc")
+__success
+int invalidate_pkt_pointers_by_tail_call(struct __sk_buff *sk)
+{
+	int *p = (void *)(long)sk->data;
+
+	if ((void *)(p + 1) > (void *)(long)sk->data_end)
+		return TCX_DROP;
+	bpf_tail_call_static(sk, &jmp_table, 0);
+	*p = 42; /* this is NOT unsafe: tail calls don't return */
+	return TCX_PASS;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


