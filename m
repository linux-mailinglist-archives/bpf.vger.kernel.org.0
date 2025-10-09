Return-Path: <bpf+bounces-70696-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCFDBCAC50
	for <lists+bpf@lfdr.de>; Thu, 09 Oct 2025 22:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBA73480C5A
	for <lists+bpf@lfdr.de>; Thu,  9 Oct 2025 20:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAC1264FB5;
	Thu,  9 Oct 2025 20:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SroCfluA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCC9266EFC
	for <bpf@vger.kernel.org>; Thu,  9 Oct 2025 20:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760040744; cv=none; b=SxdcWvMtYNaqeqQQvQhRULFqact3++Pg5QYnYU9L8aCajqLPHzrffObaIx8FD1bt0tVWwNKueu4irK1LX5fLKV0aHbRcjulUSau+WzhvLS09u0K+tMTSoDBpuKz44DlOGe7XhNU3oeX5uy/4Xw1uUw6yPmijjowE8rpYMchpnoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760040744; c=relaxed/simple;
	bh=qF+q351/t/xrZduAHpMQsZMKAFdKzG2Q3E8DIUWyUxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lk2E3rVF5n03emL4jAx9n467ML3mKZWt19oMnxIIfhvkkYTmOF6g0QXsfKIIdzLpcoiEGyFV7ckp4F5spYcLB4U/LP8bt2f+Aa0qXauq09gF59wMuSQPD0DQgU9hbmHONWoSyex6wAIEKyzNaP8B5E34svWjBsSmXe6O0FC+VoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SroCfluA; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4256866958bso802580f8f.1
        for <bpf@vger.kernel.org>; Thu, 09 Oct 2025 13:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760040740; x=1760645540; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4SGP5+JpnsHXkwuHaDpAZFmdqDhOWMSL3V0B4ToFXNo=;
        b=SroCfluA8dqaDQrR4KdUF22ZqFTWo3UJnKk8sA+ohBQB/KEbJN+3vlL/bhm19QcSe0
         JDYdYdqz9ywRmF9lWQ/D8n7a/zwI3ZYDNDMH8XwjlM23eduUJD8YAxH9vo/i3LG/lmKr
         lWh304T14NzYw2OKsNKEekIJ9espW+yzrcVZyUJZEpYTkR1HA3wEGphrMy485T8yJ72G
         FwIx0cVZj0j4n7g3Xq6kbjjPekVLMD3JxgWIJrSXdj6qoYI/tRu5BRwYr8qLRzeyxqcm
         +PY8pRls+Pb4QqmmNJEalpa1lVXv3AI+g2Hga3lk/PvQ+my7zc6JboESAcrtj1/MZ8Km
         mfRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760040740; x=1760645540;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4SGP5+JpnsHXkwuHaDpAZFmdqDhOWMSL3V0B4ToFXNo=;
        b=QDBAwxB2SD6eeKHla1g0pLIy85bf2gDwIRK4fhMwKWendyrryVm2ME7vTMa6Wg5/kZ
         Bm6p+FfQr4yF0jZtK6oUsCp1IAMzcdjx2FqJM9IhsVI8ISwg7QllvbJ4NLQIMAFmv473
         MClUPtwwElUNEYCuLailo8JHt3LvFBdoOFdWJNR25CrBKFWb53225Ks6+Drwp8oBIDx3
         MbEVKaCzwJS2jbRelnl/SeuryuhTEnELAuaUZCpCBW52NWZYhahkq1eW4xextcPc6ULk
         OMJvoEMjCZvpht4yAHpqTS3C8zJeUmyFVDkW35JuYN3bppdcdox3nU27UeyDecCN6sLI
         5uHw==
X-Gm-Message-State: AOJu0Yz5BvasGdmLfqPuH2j3DgGqv2+PRP4bLPVFbKwrJVH+rEJ0k1SG
	BMdD/+Ev304xBvCCXkPxE7dfumTDvnNIu9gw/wPkq5gf/BV4hvq6hcm4ooRJOQ==
X-Gm-Gg: ASbGncuG6K8J0JBR/91XGRbn0wRDEjwjFmwmq2hWgFNx1qylff9Lq0oy8zlaSn/TDx+
	amndEIojdyM9iGMmy28QiEION9ka2hHT+n4J1Gg30cALvAtJS3NPdr6rQXW0xTTrJdRYw6Tn8u2
	0LUlDNzk8viCbAepFnN9ZATnH3LI4kAYMB0d3GIoiux4HZwTKnNIMx7n/4UfavjEGODSRpv12/x
	bvMltiWDkbwELDu6Hz6ddLapT/QvlyRacyCjw0EPOOkdR+ROqVqAtrEKIp5t/NDlw5tz7YeOQ3p
	K/zM42R7UKOzEWukaZx9b19hX+3FkZ3iOTBzRBBD1D/axYVHACqWyh1b6kutAPN0fr5NIGdtUng
	QjwrrNK1WMhMl5cWHUH101bsxoDCG3tPE9abp3uSzLeu+Uv+klptrHKwOa/FcH/UcyumqCrNirC
	Jfsryi7yLM6nA0y2RvuJuWIPfcdOzyRxV3zB7zbso0FV/GyX24tcvzCTve
X-Google-Smtp-Source: AGHT+IEpYNmYBa43fs8cRRwVQcsTcH7quIkXlO+65tqGhtClfx57jxJXihZFl7o4zQgIZVfKXcs7ng==
X-Received: by 2002:a5d:5f93:0:b0:3e7:4893:f9be with SMTP id ffacd0b85a97d-42666abb485mr5273588f8f.12.1760040740374;
        Thu, 09 Oct 2025 13:12:20 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00b81184fd69385167.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:b811:84fd:6938:5167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb497af18sm10819435e9.3.2025.10.09.13.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 13:12:19 -0700 (PDT)
Date: Thu, 9 Oct 2025 22:12:18 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf-next v8 5/5] selftests/bpf: Test direct packet access on
 non-linear skbs
Message-ID: <ceedbfd719e58f0d49dcceb8592f5e6bd38ce5fe.1760037899.git.paul.chaignon@gmail.com>
References: <cover.1760037899.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1760037899.git.paul.chaignon@gmail.com>

This patch adds new selftests in the direct packet access suite, to
cover the non-linear case. The first six tests cover the behavior of
the bounds check with a non-linear skb. The last test adds a call to
bpf_skb_pull_data() to be able to access the packet.

Note that the size of the linear area includes the L2 header, but for
some program types like cgroup_skb, ctx->data points to the L3 header.
Therefore, a linear area of 22 bytes will have only 8 bytes accessible
to the BPF program (22 - ETH_HLEN). For that reason, the cgroup_skb test
cases access the packet at an offset of 8 bytes.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 .../bpf/progs/verifier_direct_packet_access.c | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c b/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
index a61897e01a50..911caa8fd1b7 100644
--- a/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
+++ b/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
@@ -801,4 +801,62 @@ l0_%=:	/* exit(0) */					\
 	: __clobber_all);
 }
 
+#define access_test_non_linear(name, type, desc, retval, linear_sz, off)			\
+	SEC(type)										\
+	__description("direct packet access: " #name " (non-linear, " type ", " desc ")")	\
+	__success __retval(retval)								\
+	__linear_size(linear_sz)								\
+	__naked void access_non_linear_##name(void)						\
+	{											\
+		asm volatile ("									\
+		r2 = *(u32*)(r1 + %[skb_data]);							\
+		r3 = *(u32*)(r1 + %[skb_data_end]);						\
+		r0 = r2;									\
+		r0 += %[offset];								\
+		if r0 > r3 goto l0_%=;								\
+		r0 = *(u8*)(r0 - 1);								\
+		r0 = 0;										\
+		exit;										\
+	l0_%=:	r0 = 1;										\
+		exit;										\
+	"	:										\
+		: __imm_const(skb_data, offsetof(struct __sk_buff, data)),			\
+		  __imm_const(skb_data_end, offsetof(struct __sk_buff, data_end)),		\
+		  __imm_const(offset, off)							\
+		: __clobber_all);								\
+	}
+
+access_test_non_linear(test31, "tc", "too short eth", 1, ETH_HLEN, 22);
+access_test_non_linear(test32, "tc", "too short 1", 1, 1, 22);
+access_test_non_linear(test33, "tc", "long enough", 0, 22, 22);
+access_test_non_linear(test34, "cgroup_skb/ingress", "too short eth", 1, ETH_HLEN, 8);
+access_test_non_linear(test35, "cgroup_skb/ingress", "too short 1", 1, 1, 8);
+access_test_non_linear(test36, "cgroup_skb/ingress", "long enough", 0, 22, 8);
+
+SEC("tc")
+__description("direct packet access: test37 (non-linear, linearized)")
+__success __retval(0)
+__linear_size(ETH_HLEN)
+__naked void access_non_linear_linearized(void)
+{
+	asm volatile ("				\
+	r6 = r1;				\
+	r2 = 22;				\
+	call %[bpf_skb_pull_data];		\
+	r2 = *(u32*)(r6 + %[skb_data]);		\
+	r3 = *(u32*)(r6 + %[skb_data_end]);	\
+	r0 = r2;				\
+	r0 += 22;				\
+	if r0 > r3 goto l0_%=;			\
+	r0 = *(u8*)(r0 - 1);			\
+	exit;					\
+l0_%=:	r0 = 1;					\
+	exit;					\
+"	:
+	: __imm(bpf_skb_pull_data),
+	  __imm_const(skb_data, offsetof(struct __sk_buff, data)),
+	  __imm_const(skb_data_end, offsetof(struct __sk_buff, data_end))
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


