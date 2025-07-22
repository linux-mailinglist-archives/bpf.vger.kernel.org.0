Return-Path: <bpf+bounces-64056-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E077EB0DEE2
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 16:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3AAB170FA0
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 14:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DC12EA485;
	Tue, 22 Jul 2025 14:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljyH2TxO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAA11A256E
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 14:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753194759; cv=none; b=EVn5Zq2bZK9uiRNd4ICgG1wylLsL1xqdBcnzx3bcf/luMh8T+fuBA0x5M42XAhfDxfQEWhevc3lKuGUhPbbrTZKFukHImviN1BbpNvb2UZvAERTHpvdrbalm1UEujgmikE0JgcmuoPQM1hkxCvi+0gAfYneLBWcc1DAcGhiXm1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753194759; c=relaxed/simple;
	bh=3I0AvfmqIB2FHcYzR2ibE3MCW8tfiRZF8g7MmiXIR3E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hSEf4JP6vAHcg+bMyCjVxkkEJlSyjByowVH1ck7Otlk/eHEmRoOzizUtRBmkz4OqSQdVKQmhPvSC58tiR5TNVhMrTrSOHVI1W2Nf5yLi0KtktObA8HKmB/+d/oUhqq7z2MNQXjGTZG5GeB0d7Lkk9OCOLwg82Fc6SqmeXNX7aLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljyH2TxO; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a4e742dc97so3470421f8f.0
        for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 07:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753194756; x=1753799556; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RB+WMhv7Tc/EV+L81fBmWvd9+aDA+e+URkAK9q58LN8=;
        b=ljyH2TxORZq28uslgye2TEbk/N5RDi6WHo1IrfYK8sNca724UXkrNUcVUzl7sqfyFq
         vlrhTmR65Z6ssak4ABSjL94VgoLdRqbBvnDMPVRYHNH/+JmRCZxO3uXZ+hqVgp1zxPRz
         AQNi1YxTfVotRwI0nW++cHgaLr+Kj0x62ui1kMAXRgoCVh3GoEX6qxD0S594Y9yk2NGq
         W2mIDjZj1gaMDNEBMH2GaTcCZR2YrWIqgAQXqoBED/I0npreH4MjLdxKrDG9bQvzcFoZ
         96dsPlPuo2Gngn95xsJAP6wCuHXeWCkHoaWlFejOWhRL5WvlxtUH/4cTEvi/mTBu4kex
         Xy6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753194756; x=1753799556;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RB+WMhv7Tc/EV+L81fBmWvd9+aDA+e+URkAK9q58LN8=;
        b=OmLr6vmbQwt9pgQnM6rdJQRFque5q+aVTgtGs4dX2RAeuHA1jBWTG2yjtPTbpcQaoF
         GfdUT+hTiEeW6r9Xjl7ufxRcXJnckrqFWBDt5pl3qbl3VyGR7H9mLc4qBNSM67EM7fiA
         QZi1ZvogZIUVmyfg9SCkUlmpkcqvn4skp+jfWUf3yQHy9KBcaVQkHqBSLEH/2fil8aw6
         PUelZJbcvBBuMTEoNvH3a3KOxelgZD3D0NvOKmvRenmQHyN46NkqYKENgzOgb7UR0A8V
         VWgBvjgn5r03c4xEHOLmhU0IERI3aU3v8Ui++agNSr4Cm4y73JnLxjo1SChyBxre9skT
         8FIg==
X-Gm-Message-State: AOJu0Ywn57OnLAmyfmthGmnaC5gvk32eE3AdrwoFvgP0O1pHFn/jZw0n
	9XR6zd3McKAaZ3/Gk/o+ocZcEwQElHZ9uA4iD+ygKUtTXrcPLoDualnB4PKG+e65
X-Gm-Gg: ASbGncs788LD4YktEpD4D26i7LTPzpJYtoUKGvBkjr2p/smgVnd29UAhcZXrQFKC3U2
	PXnMHchtfbSvbcvuH/WW40/lGR/fCrc5ytKY2fF39XUkt92Pm+3cpg0o5pmMOZnsdWx8rHIWI17
	k5gXKN3LV4PU20/pA4wAbyJX+4WlBg9TRkNBVma0cSoTH1GDdl5eXeGkEDl0ewAqaIbKg8GvfRJ
	2E6M7oR7uOMAtNPV0Y6Cd+cgV4ReNe+LVcdzfkjgSzWVZ2neKgAcj3ZjbkM1cmavSj+lMnhi8Gz
	f1u0MDZV2j2pbEcelBP/S/cjFvdmW7Is+MRaA5c/OC23NoiFzmLCcj9fLFc2C+duMElEy+6KbO4
	5DYp0Vzd41pc2l8eSwMf7xOs4s1RVog9ows8Mshk3xVEm0DwUhrKt9X8gpVJeN6lOUBdCTNhZCi
	DdmcstIUW1j3WNfYVJeogG
X-Google-Smtp-Source: AGHT+IGvc3pTe2BbxUToLI3kHNk174b8SchWpfSfdUtxeuTeHVDomnMfDjtDg1dwIkQHRKyJabb28Q==
X-Received: by 2002:a5d:5f88:0:b0:3a4:dfbe:2b14 with SMTP id ffacd0b85a97d-3b7634b2956mr3475062f8f.16.1753194754931;
        Tue, 22 Jul 2025 07:32:34 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e007ae7318c9eecf7c3.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:7ae7:318c:9eec:f7c3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca486edsm13829177f8f.56.2025.07.22.07.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 07:32:33 -0700 (PDT)
Date: Tue, 22 Jul 2025 16:32:32 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH bpf-next v2 1/2] bpf: Reject narrower access to pointer ctx
 fields
Message-ID: <3b8dcee67ff4296903351a974ddd9c4dca768b64.1753194596.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following BPF program, simplified from a syzkaller repro, causes a
kernel warning:

    r0 = *(u8 *)(r1 + 169);
    exit;

With pointer field sk being at offset 168 in __sk_buff. This access is
detected as a narrower read in bpf_skb_is_valid_access because it
doesn't match offsetof(struct __sk_buff, sk). It is therefore allowed
and later proceeds to bpf_convert_ctx_access. At that point,
target_size is null and the verifier errors with a kernel warning and:

    verifier bug: error during ctx access conversion(1)

This patch fixes that to return a proper "invalid bpf_context access
off=X size=Y" error on the load instruction.

The same issue affects multiple other fields in context structures that
allow narrow access. Some other non-affected fields (for sk_msg,
sk_lookup, and sockopt) were also changed to use bpf_ctx_range_ptr for
consistency.

Note this syzkaller crash was reported in [1], which used to be about a
different bug, fixed in commit fce7bd8e385a ("bpf/verifier: Handle
BPF_LOAD_ACQ instructions in insn_def_regno()"). Because syzbot somehow
confused the two bugs, the new crash and repro didn't get reported to
the mailing list.

Link: https://syzkaller.appspot.com/bug?extid=0ef84a7bdf5301d4cbec [1]
Fixes: f96da09473b52 ("bpf: simplify narrower ctx access")
Fixes: 0df1a55afa832 ("bpf: Warn on internal verifier errors")
Reported-by: syzbot+0ef84a7bdf5301d4cbec@syzkaller.appspotmail.com
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
Changes in v2:
  - Use bpf_ctx_range{,_ptr} for a few other fields, for consistency,
    as suggested by Eduard and John.
  - Fix accesses to skb_hwtstamp, reported by Eduard.

 kernel/bpf/cgroup.c |  8 ++++----
 net/core/filter.c   | 20 ++++++++++----------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 2e1c0eab20c0..180b630279b9 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -2577,22 +2577,22 @@ static bool cg_sockopt_is_valid_access(int off, int size,
 	}
 
 	switch (off) {
-	case offsetof(struct bpf_sockopt, sk):
+	case bpf_ctx_range_ptr(struct bpf_sockopt, sk):
 		if (size != sizeof(__u64))
 			return false;
 		info->reg_type = PTR_TO_SOCKET;
 		break;
-	case offsetof(struct bpf_sockopt, optval):
+	case bpf_ctx_range_ptr(struct bpf_sockopt, optval):
 		if (size != sizeof(__u64))
 			return false;
 		info->reg_type = PTR_TO_PACKET;
 		break;
-	case offsetof(struct bpf_sockopt, optval_end):
+	case bpf_ctx_range_ptr(struct bpf_sockopt, optval_end):
 		if (size != sizeof(__u64))
 			return false;
 		info->reg_type = PTR_TO_PACKET_END;
 		break;
-	case offsetof(struct bpf_sockopt, retval):
+	case bpf_ctx_range(struct bpf_sockopt, retval):
 		if (size != size_default)
 			return false;
 		return prog->expected_attach_type == BPF_CGROUP_GETSOCKOPT;
diff --git a/net/core/filter.c b/net/core/filter.c
index 7a72f766aacf..47073a0180a4 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8690,7 +8690,7 @@ static bool bpf_skb_is_valid_access(int off, int size, enum bpf_access_type type
 		if (size != sizeof(__u64))
 			return false;
 		break;
-	case offsetof(struct __sk_buff, sk):
+	case bpf_ctx_range_ptr(struct __sk_buff, sk):
 		if (type == BPF_WRITE || size != sizeof(__u64))
 			return false;
 		info->reg_type = PTR_TO_SOCK_COMMON_OR_NULL;
@@ -9268,7 +9268,7 @@ static bool sock_addr_is_valid_access(int off, int size,
 				return false;
 		}
 		break;
-	case offsetof(struct bpf_sock_addr, sk):
+	case bpf_ctx_range_ptr(struct bpf_sock_addr, sk):
 		if (type != BPF_READ)
 			return false;
 		if (size != sizeof(__u64))
@@ -9318,17 +9318,17 @@ static bool sock_ops_is_valid_access(int off, int size,
 			if (size != sizeof(__u64))
 				return false;
 			break;
-		case offsetof(struct bpf_sock_ops, sk):
+		case bpf_ctx_range_ptr(struct bpf_sock_ops, sk):
 			if (size != sizeof(__u64))
 				return false;
 			info->reg_type = PTR_TO_SOCKET_OR_NULL;
 			break;
-		case offsetof(struct bpf_sock_ops, skb_data):
+		case bpf_ctx_range_ptr(struct bpf_sock_ops, skb_data):
 			if (size != sizeof(__u64))
 				return false;
 			info->reg_type = PTR_TO_PACKET;
 			break;
-		case offsetof(struct bpf_sock_ops, skb_data_end):
+		case bpf_ctx_range_ptr(struct bpf_sock_ops, skb_data_end):
 			if (size != sizeof(__u64))
 				return false;
 			info->reg_type = PTR_TO_PACKET_END;
@@ -9337,7 +9337,7 @@ static bool sock_ops_is_valid_access(int off, int size,
 			bpf_ctx_record_field_size(info, size_default);
 			return bpf_ctx_narrow_access_ok(off, size,
 							size_default);
-		case offsetof(struct bpf_sock_ops, skb_hwtstamp):
+		case bpf_ctx_range(struct bpf_sock_ops, skb_hwtstamp):
 			if (size != sizeof(__u64))
 				return false;
 			break;
@@ -9407,17 +9407,17 @@ static bool sk_msg_is_valid_access(int off, int size,
 		return false;
 
 	switch (off) {
-	case offsetof(struct sk_msg_md, data):
+	case bpf_ctx_range_ptr(struct sk_msg_md, data):
 		info->reg_type = PTR_TO_PACKET;
 		if (size != sizeof(__u64))
 			return false;
 		break;
-	case offsetof(struct sk_msg_md, data_end):
+	case bpf_ctx_range_ptr(struct sk_msg_md, data_end):
 		info->reg_type = PTR_TO_PACKET_END;
 		if (size != sizeof(__u64))
 			return false;
 		break;
-	case offsetof(struct sk_msg_md, sk):
+	case bpf_ctx_range_ptr(struct sk_msg_md, sk):
 		if (size != sizeof(__u64))
 			return false;
 		info->reg_type = PTR_TO_SOCKET;
@@ -11623,7 +11623,7 @@ static bool sk_lookup_is_valid_access(int off, int size,
 		return false;
 
 	switch (off) {
-	case offsetof(struct bpf_sk_lookup, sk):
+	case bpf_ctx_range_ptr(struct bpf_sk_lookup, sk):
 		info->reg_type = PTR_TO_SOCKET_OR_NULL;
 		return size == sizeof(__u64);
 
-- 
2.43.0


