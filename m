Return-Path: <bpf+bounces-75325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DB4C7F5C5
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 09:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9ADC63487DC
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 08:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0ABA2EC0A2;
	Mon, 24 Nov 2025 08:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcbWx2aP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E37C2EBBBC
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 08:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763971758; cv=none; b=MJmneN6wSCKsoR8WBpSAQUW9EaAcpQe2w3PkQP+bExyRpEUF7WK+lHj8S9+rSFNqxc/iJTZ/9Ypf5RizNjq5ovAXsTARF++JPJB0Ep/3yAz7iC9VBSZp4L5Df9PaSEAeZdktlrk6ZCi26IJw4QLC6/OQT9s9wWtfdjkCxuZDOjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763971758; c=relaxed/simple;
	bh=zlvW/jN0idui1pFEaPCILXLEB6Pz7MYxpVsI6cS6zyI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HrO5S3tsXFWkTl3msBgCheWcMA4tDvtK0jKyJdfUOTvvbJEx0hSFlDDP7h+IjHoPfAYfGBjirZcdsPXYfuaPWTsVlZt6e1uNEW5PcCOmnrRWdZuKGYekcJKPwAbvXncKVleA5vhxN0+dbuE2/9H5kNYERN2vBWcNbRReowYayOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WcbWx2aP; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2953e415b27so48592815ad.2
        for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 00:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763971756; x=1764576556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IekuUIo821t9wwHs/lSRsb8eGj/j82qutdOJ8AF9uIQ=;
        b=WcbWx2aPqWyghoIoEL3YGn0+N0MkjycZbPH0B9X6+YLy5ZRmtPdSghoGEGMAnFaSaN
         l4Huty4mDHZIlkKmT4rkrpKyU0mT8Jt9qdoJshw9wOuN0JBq4u7fDWU1FyMPJzaqPcTl
         +b9oix0uOvUrXaQJl7rSOzVLvwsq34dCD78btZZxk6TjUACqBg1ulvP9rP5XfaOT1ffF
         Dz9gncNwTwEd3/ryopi+ZDmSIo+QMosTbEZ0n97kzoWvCGeiv6d2AvOqLznri0N47F3I
         YgOGGccbjrTQlASCNy1ErZXJDosMG5iKjBX1fc2cqXfTLFymV0vVCugi/F9jLirnBA9Q
         10Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763971756; x=1764576556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IekuUIo821t9wwHs/lSRsb8eGj/j82qutdOJ8AF9uIQ=;
        b=psnRCxtnqP6YFu8CRdgowogLPEVGwOq6CTFjtO3Aa773QySNdDnL4FxFbkOij3n9nf
         QdhojNrYD4HiVuoVq3HkSmkFr9fZvvvapgNr91BYvMja5wK6CwpEZe11GFlxYlD/YO3i
         0WKRaz0o7YmHucfQKrO11q1847IRPtis32nPDqgJNzcG4wig6fcIj5fS/42OhR5nPBGh
         IQNtOguUuRya6D66iIY9ec5DbGNfpyZWLngt8bZ0BrvhG+134JYom3iQhpeDstCZkZZI
         zfFE0Vk1uaSaW6CpWyldm1tUyezaTk/2SWHf0q8fB9RRVh+RQcVisnJEcFB6kdx0NYen
         yASQ==
X-Gm-Message-State: AOJu0Yz9CRqQd2AScomLj8DnsoyxETiy2je+bJFlD9DJHBUcewFlNuae
	hiB/YHWIuWEfe5ISVSoQVKPMWpeL3J0c8JMdq3JUznZikQx3s/SzRV8o
X-Gm-Gg: ASbGnctZAOgPeUQL9y1u7LRLXftX0+0xAtMhtFmRFf60n2k6jqAfu9gqheBHu2Neh0w
	7Up3aez4LlCL7hXRrkMT2atCOfjYztDVYhVolvwQqiegxvdB6pzWtz3Ttb9TuWnnytjlj1Q0qQh
	xdycEUQrLgvpfPb7sAHnNf6hctCTVkvGssUt4vxOcRYyF8Pb9zq68IRzX63skfA5Z5JQTdTaxpJ
	rYXnZzqukegGzMJkUfQb4OzAarvjSE7caRzO4wdRYkjzrWoxFJ0vHnEXvBShjSyv2jMxcYhEqAO
	22NMNWABmkYRR47h2V9575deRrb6ubUGmk3fHQKmDuHJ0pEzQVABJtm674Ywdde1U4q6XC11Af0
	xvV22Iona5tXvqWz4MT/rMfSL4QQexVRH2vHeJOtzVwHIEly5uQ3KWY1tO48ZILusrrmCDUg6BH
	TC+yZ75gpi5P9/Gd63lm35GPHDjR+y+nLnN/45kP9adJceSPAaFtE+S9ATsLc847o//dXE+6eH
X-Google-Smtp-Source: AGHT+IHfln41jit+BGWi7eDfn0SqiKQon4rcNv96vXLGd9L0YhJIDpWhyj95ZxZ7enF1SbdriLcfig==
X-Received: by 2002:a17:903:3c43:b0:298:1156:acd5 with SMTP id d9443c01a7336-29b6bf1a67fmr121100965ad.39.1763971756226;
        Mon, 24 Nov 2025 00:09:16 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd75b61c29dsm12343837a12.0.2025.11.24.00.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 00:09:15 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 1/3] xsk: add atomic cached_prod for copy mode
Date: Mon, 24 Nov 2025 16:08:56 +0800
Message-Id: <20251124080858.89593-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251124080858.89593-1-kerneljasonxing@gmail.com>
References: <20251124080858.89593-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Add a union member for completion queue only in copy mode for now. The
purpose is to replace the cq_cached_prod_lock with atomic operation
to improve performance. Note that completion queue in zerocopy mode
doesn't need to be converted because the whole process is lockless.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk_queue.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index 1eb8d9f8b104..44cc01555c0b 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -40,7 +40,11 @@ struct xdp_umem_ring {
 struct xsk_queue {
 	u32 ring_mask;
 	u32 nentries;
-	u32 cached_prod;
+	union {
+		u32 cached_prod;
+		/* Used for cq in copy mode only */
+		atomic_t cached_prod_atomic;
+	};
 	u32 cached_cons;
 	struct xdp_ring *ring;
 	u64 invalid_descs;
-- 
2.41.3


