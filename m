Return-Path: <bpf+bounces-70508-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A47BC1896
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 15:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32F843E1CCA
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 13:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6802E1C7A;
	Tue,  7 Oct 2025 13:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vn5alUue"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A38C2E1C7B
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 13:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759844337; cv=none; b=U8W8gzpsOnpSB6UYf7C3oPzfaqZNmWhsP7ElSgiNOwyZf7qdij8lCySXNkXCOoDklFdJx1paOt+XE+BQnbo8ipjJVSmcgMzhcJQQmrWASNhBG8LqW1vL6gxo2A5CjLDIdo8rX5pfEy7hN3wvf6ZQ9jgSvJL/jp4FvXGbn2EjhiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759844337; c=relaxed/simple;
	bh=Y5xJ2BGYiTJk4cykiTpnNTkuZyp1XMeGXiMD6v2wvyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1c/65+99woFxqkglCmix9f6h2jy6dInDV0VL3cafpy2AoBRQTPifC+1BQMlvXpYg8bchsl2/TWD6qrNe84FQixHB5lrHmqoeW1OrYXIBiFebmLD56pKl2KVgeM+WagFzKKaaLZ0tF/7M6GYYJOkMi7Yp2H+O9r2SeonI8sG8dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vn5alUue; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3f44000626bso4049207f8f.3
        for <bpf@vger.kernel.org>; Tue, 07 Oct 2025 06:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759844334; x=1760449134; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ptlxw/Z0n6LbZEnsqm0/ddxtG+5o88hogqG6JB7dmqM=;
        b=Vn5alUueZEj5hy1+LWbkPEDUkEGII0f4RVeLj4lMfXaXjV3rcNrZ7H0vbyrBYn7ATX
         f7kEetZGb/aBGILXzdZ80wsK8zgMVXueRBdLI0wQKhd5fqqRchZcTjCMwJ31gaNeemkN
         jbvaKEt0wxGjOpT3I7kpYXPCjoONrGY94YkcYZKNJTmwy2W+nVT4pw/4/PsoLKxxR4Nr
         5FAdOXgjsBS4OlpiUYrzb1Tx2dxsPq/7GpsQoiUn/L5y+O7uJkqDV5ma7hEZqUmH110B
         F2P4VtXC4po7LBe9ob3aS2Z8XTENmULWcU8mAhebJxkTOMUVl1KXRjqH3RW9A0S41A6Z
         Awrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759844334; x=1760449134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ptlxw/Z0n6LbZEnsqm0/ddxtG+5o88hogqG6JB7dmqM=;
        b=w1+Wjj4+7/gUhCDxTs6gcjhLg4kF8pV4Z95bMSmC+/N9LTc7ZxuMsR9EJfyntW6AeN
         ZdFUPgNCoNNPN5iIWHGRi5DJt3gbrTPVgkL64keTe6wioATdggLrlg5iP4FFYD5DHtQZ
         cEjhVnZ8NDmbjS3tyczxdAkpVRTPkBVXTGG33QpNXhws+rBLqhr5MPxe0Nok9sRlm7dZ
         XHOs6mNdxU4M5e44aSy2U9kzxzVaJhH+GrXaH9LpiwHKMMNwhHpTlMDd5+FFsC/jiq0B
         ym5KuoOx+om9+7Am2sL3HFLjRm8+ZoXBRslMLWYYrWrwH2kDTJo083HOShhrM8omDVHr
         3Alg==
X-Gm-Message-State: AOJu0YxJMrfAksA2NgCIpwLzA5XSk6zBtGvPjYGnNzwaikpm2Qzd/U0s
	dY5cly1r5UyRww8CfH0JRcKYi2Pq8HG6/QrDNnSOmB6347VcRrWsQTg49jHdk7ws
X-Gm-Gg: ASbGnctmGdgLP1EmY8x90VMBEfFL4sqj7qHC/hNvxy6y4L85hujI+/UwjHhbgQTZ4d1
	RPFd/RWKGN+CKy3vtTnH0WHr37H4oXuETby1uE4EwJXA8eK93gRD0NjCHYR5ANhVVaOmHYkshBj
	wJrCeKi7u2TO6pCpcvTdiCI1k5iY8wYqzDtVV85RUAYcSORU/JF4tKMy7SbT7zqqLmoxvNINMR0
	8UC1zfJiy9mTI22735mE5qZ9g8KQS8hBaU7HPVUkhpJO2v+/QasSgoV+Qommysew5awPF0YUDrx
	pFwN6jL2DKm2YWxZOmNy2INp3LU/j7aPsux4UQhej2jsriNGtA4U7+abiPw3cTjOLJU1Elgkkxj
	Jso/TgW7fBhcw0FOrPfTv5IWDOsLscV6Iw3mRkuVsttrSY+dXnxjnIBYPJ07dFCLG6NqqU51oqD
	D/Tn3tx32RqxttVdq5XQCIkK3N7F1aZHXDUCsbYZPEdPLvhA==
X-Google-Smtp-Source: AGHT+IF4MnRC5A+So9EYcR2JWX3CfvifCW04bEKoNQuAa5RsgEljRShzZbt63tu6SGjvwUWqIKFA7Q==
X-Received: by 2002:a05:6000:2583:b0:407:23f7:51 with SMTP id ffacd0b85a97d-42567139c92mr9521166f8f.1.1759844333804;
        Tue, 07 Oct 2025 06:38:53 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0079f574fca42e1d7a.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:79f5:74fc:a42e:1d7a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6b40sm25610744f8f.2.2025.10.07.06.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 06:38:53 -0700 (PDT)
Date: Tue, 7 Oct 2025 15:38:51 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf-next v6 5/5] selftests/bpf: Test direct packet access on
 non-linear skbs
Message-ID: <302cd8554710d04986925df1737c787c09b5ff65.1759843268.git.paul.chaignon@gmail.com>
References: <cover.1759843268.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759843268.git.paul.chaignon@gmail.com>

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
index a61897e01a50..16019eb58eb4 100644
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
+__description("direct packet access: test36 (non-linear, linearized)")
+__success __retval(0)
+__linear_size(ETH_HLEN)
+__naked void access_non_linear_linearized(void)
+{
+	asm volatile ("									\
+	r6 = r1;									\
+	r2 = 22;									\
+	call %[bpf_skb_pull_data];							\
+	r2 = *(u32*)(r6 + %[skb_data]);							\
+	r3 = *(u32*)(r6 + %[skb_data_end]);						\
+	r0 = r2;									\
+	r0 += 22;									\
+	if r0 > r3 goto l0_%=;								\
+	r0 = *(u8*)(r0 - 1);								\
+	exit;										\
+l0_%=:	r0 = 1;										\
+	exit;										\
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


