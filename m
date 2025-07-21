Return-Path: <bpf+bounces-63913-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F20AB0C49C
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 14:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA7954E5E58
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 12:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655FB2D5C9B;
	Mon, 21 Jul 2025 12:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hin3beYO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338D22D5C95
	for <bpf@vger.kernel.org>; Mon, 21 Jul 2025 12:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753102668; cv=none; b=Ozs9N83UcqYjELz5ce0+1PfQMoim5t1egDNT+p6wXAMVoC1iTTolb7+rx/wKKKTPTczZqRsucQQaK6YRlSOjFqhst39PmSrYr80dsXEJPtcRmXG3newHMtpZCkbPZH6cHIMQ9UNgPkmvd+nWK7zk6fOtBx/91q8Az7Mvjj5jF9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753102668; c=relaxed/simple;
	bh=E+Rx4WJVuXKxukDLY3UQP+h1H+r+yNT3b91Brhk7Wv8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WftlaH2C63+3tAW9jyacbLkoyw3JUBgqRWnq2xyPndX8paUzUoUl1cY0G7b3JZACnMTEv6iNoev0fwRfreuuNy/OjJMxlDVnGfKiStidPzm3Q9CwSnOPXnNz8nsNe9+UEtsEGO4IKzIzbiyBhbptPHznXLji3wfJcpGLvN++CL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hin3beYO; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a548a73ff2so4038507f8f.0
        for <bpf@vger.kernel.org>; Mon, 21 Jul 2025 05:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753102664; x=1753707464; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pjUxXDVtIOhrkwBJ5z8PlYbZP4gwTFlQosjhazh1pNM=;
        b=hin3beYOBS53NWX7tuu+M+4NlHh9Hjv/H9ncU4ydefqwCWSY4t7KlvZ7C5vdaHKY6Y
         AuzIl0sgeklkvE4QsK5ifzBt1h2GyRsO5I5wYuk8YFRvh9ls4NqoFM4By2VsFRMtHRV3
         STIF6VqhsHk6EXtLRpvFa6amiED0zd67TBhzR2atvvN8yDLbaVqJBgn/nZ37XwPW4JOB
         M+CytDHIH2fLbolFfmktAptdBBZEqnglmE3Txb52/XM0last74MTPimDJcoef1GWnHul
         Ms4RKJrd8GDChTfkaXitD5Qu2hNMZT4ktCfb7hkPnXUQGAqIqYCJ6sv2SFCtJ0rOQaWi
         qbgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753102664; x=1753707464;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pjUxXDVtIOhrkwBJ5z8PlYbZP4gwTFlQosjhazh1pNM=;
        b=Or2I1hGfuz/UASikdCOjXcuSyL9lVwt8kPYjvopcm+RIbbZtWLq/qh7ZCDb4PLUmTE
         vvbLBLqm2gInwefTTMLN7VDq6PsIAWzz/TADOk1LCAm2OE8riaIjrqBSkxZksqVCuKKk
         WRO6UUQSwKAtIDXwJfegaVyXz/tIMoQBe3ksYF1raW5Fpypm2FVINTbCvya9LToHB29D
         4urX7ASaYPE9BFE1l6FYmnXWaoyefiyM77+e/ooiZkSgG/k7n3ayiPZyjytI0kZj/nWw
         TBu1yRDAoq+R9tWR2+9lXoYfuBI5/Sk9BF5+IkN2lU1zGDEsv5oudydZUeO410XYASqd
         BRuA==
X-Gm-Message-State: AOJu0Yx/FgbtOT/aLhzUUv35bBTyXpFBAK175AEUe3n79eTiNF4TSYsx
	gD0eoLC4VtuxJ1UyvIdC7htZAITU9a6rBmBsnJ6IAIT+82aqv53mMKoJqoEDhw==
X-Gm-Gg: ASbGncsvQeFDUi+xS59HOtVNve14XG3oZckHuZv3Xffb9nZiXwMdFN86hQ/F1nfT/xj
	4t5BMcnJEOfgvo2YCUUiilNZ/fseMkCNjXnDgMJ092JgbrkfBRdDHGteV9b1c6y5U8R+SgYafgW
	OTcYJ659tEa+kfXhChQUopP1U/2FeArKZYGN5LW2qhR5Mt9BNf21eGWyL9SZjJadaQvxVSBAhxP
	rKyRzcnfbpGuRxkpsK+DUDfhBD8FM/qcUsykr8k2HaipEgu6SWknID3xATUiobW7Gc/KFJreC9p
	Z5CIS+kReBtGod35vMIAdNdhJkQ9Rw+8WuZm3SUTLBeqA7L3M7TPJNbHbe2t0ZjYEGAgm5CgIXm
	omr5RY/WuXh6e/c2pEcyPNfsoctsHqFmyE1v4s5CqhL9KYykk2VxjJkRo9Y7WOvwAT2L76n5tKd
	pB7Ic+X9RZEw==
X-Google-Smtp-Source: AGHT+IFsTt78ygyI4QdxJo99+NYNngUFRncyU75eEJB86U87Qgy2klz1dLi1EsQBvQLqGnSAFPZ8TA==
X-Received: by 2002:a05:6000:24c5:b0:3a5:2ef8:34f9 with SMTP id ffacd0b85a97d-3b60dd73204mr17535127f8f.27.1753102664008;
        Mon, 21 Jul 2025 05:57:44 -0700 (PDT)
Received: from Tunnel (2a01cb089436c00043594f5ece104811.ipv6.abo.wanadoo.fr. [2a01:cb08:9436:c000:4359:4f5e:ce10:4811])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca2bb48sm10398179f8f.24.2025.07.21.05.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 05:57:42 -0700 (PDT)
Date: Mon, 21 Jul 2025 14:57:40 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next 1/2] bpf: Reject narrower access to pointer ctx
 fields
Message-ID: <e900f2e8c188460284127fe1403728c10c1eb8f4.1753099618.git.paul.chaignon@gmail.com>
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

This patch fixes that to return a proper "invalid bpf_context" error on
the load instruction.

The same issue affects the sk field in multiple context structure, as
well as data and data_end in bpf_sock_ops and optval and optval_end in
bpf_sockopt.

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
 kernel/bpf/cgroup.c |  6 +++---
 net/core/filter.c   | 14 +++++++-------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 72c8b50dca0a..3a4ad9f124e1 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -2577,17 +2577,17 @@ static bool cg_sockopt_is_valid_access(int off, int size,
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
diff --git a/net/core/filter.c b/net/core/filter.c
index 7a72f766aacf..458908c5f1f4 100644
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
@@ -9417,7 +9417,7 @@ static bool sk_msg_is_valid_access(int off, int size,
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


