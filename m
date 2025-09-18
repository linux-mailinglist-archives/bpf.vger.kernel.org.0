Return-Path: <bpf+bounces-68828-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71708B861F5
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 18:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E26461C87F81
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 16:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF2C2512D8;
	Thu, 18 Sep 2025 16:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKAGjhay"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D160B248F75
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 16:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758214313; cv=none; b=LqvLzmpa2zrUzmQKuBjMRPsRJnP8d6pKZKQ6mCsiC3XueunAy/jyUdCscHd4AyFYd9sSlSKXMtf9lEIe1H9ZkA/dsQyFMwjBYPHtiQ4Y3bztohyckiU116ZUEAkt2DXSV0Aw/nLjg/ZpmdWbPq5Z2FX6XWZtXKfwQNv3gMh50yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758214313; c=relaxed/simple;
	bh=3MkRqVkgxFJAXUWtK+YRyVQGp63grCMlKtEwjeuyBSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJ9YqVJlmJzbPBcpuIbavwbYrjA41f9a/PHb+L3ubw9j9Xz2FSPbXOAW67NYLey3D3W+mJImMpJAmpB9WYM34aJSsXFrJALzD7bdkCtXFlvZclUWEqU3mzm6RKk5xEJE+nDNPckQEnqR/mQGdyw+VvyCymMeKJvBpe88e4aEK6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKAGjhay; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ee13baf2e1so555497f8f.3
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 09:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758214310; x=1758819110; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dWnDm7Q9tdngckSwKSFQQ58hSLZ+NmoMz7+pMI4DPoU=;
        b=cKAGjhayBczzY0I9ScgrIK7JReJUrZn+WD5J71W5kwL8Eai1/vcYAS1cbLSYg9DwZB
         5KK01NEGRjwCL588mmmkHMTaGczojyC1Ufhek6oyMWdOKn8RXNRhy4XeLCAP13mBfLts
         VZXxwZiLQ/GJNHuvNvW+wRfzf2XdoB6qUWmgukysBDm21DjOKofjkQ8kuQ1jpHMGHGAI
         4BX1+Ni2AMOeaLiZEsX9bXGs9culZOOnUwmPDY5TSHaODgrao4S8pzO//LxgNNJha5qn
         vnT/ue6WjtHw8mNAeuUm4zC3txH1Bc4oLYoLpl0aM/ckDWhF7+PFHt1f26uEHv11ocNv
         xNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758214310; x=1758819110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWnDm7Q9tdngckSwKSFQQ58hSLZ+NmoMz7+pMI4DPoU=;
        b=n3PCS+RROokmdKBXfrrqb1tfPrw//2v60MEmsLOVNZ0W2RVth1ZJo6LLA4Ed5Bm/iY
         toaGVGZXIhdB0wS8aGMakLsubkqYTSG6wjyKfVfICi+prWxmc96gQABr8V05qSZr3/SL
         L+Re0VD9n23q1oYLY0l/jNKKlTV9x2xPQ7QFqLTl2NeYbUUKrOWdO0+rRnZBfJmYIMgB
         6ws72wqANiFT8XoByvDFVeeYUEG1r1Yp8k3UCMCLFlearR9OQFmR8erjXX0Qjkj69Vic
         Akhgk0sQdneE636AlZcKRiZ6TNJ88D3QLb0LRQF34YNw24X++CRu4bwCPtszU5fCZP26
         GFhA==
X-Gm-Message-State: AOJu0YwsDawwIURj9HnkoAyv5qrq0RqkQt+fjBXDkONg8QhAjwwrKKvH
	IgAus6ge3MknZsHUSYOfJtrsB+SVQ52pXPBoW4nmdnjmcuCLqnDEpUaN4EAX8fG+
X-Gm-Gg: ASbGncuz1yp5aVAQZqD+1DhXzbf4Lo9eQlQviN31TaDNxnGErngUxCApAlypS6YJimm
	i2vhdNwUUKNLnn+6XlcaFyViAW5Dj2cYutGXOvwUq2YhUvsdC72CW64UPi3PhDfb61yGyB3hKif
	40d/dN8UwiUNQjCzUxAMrS97Q9vDLxhiCvUyjMCDDCaKw3e6MO180sWNtydhBlwGr7h4FFXrGd6
	tDLOXigMO4nxQa1dq2BzZmuto1XUw0M0jSIsY4GJEVkfte7RciGLu6Md8XA4iPJugc5RidvQxMw
	x1iVhm6TjR8y6NdVTBo9vynbLFdWN8TI+Kj58BBiP5YOCaEVP5Cwa9vwGIG6H1jZkP+aOIIL0Uh
	eTMGQ/JfYsBvbY/rTS194vN91oc6qCmkUYSEuylPxHfGg2DfqZdufL5VZXAsMiRnOYZnwMogTKo
	XXaXYpnVTBV+AAEL8qGW6jbEyT7EtdrOtPfjaTwA==
X-Google-Smtp-Source: AGHT+IEIuA4x95qrXLBbBM1CkJqSiwbqnvJKXeZF+J9W9Y9B5R+8uagk9UZMzkL4YLfxvEYczMMQzw==
X-Received: by 2002:a05:6000:400c:b0:3e7:5f26:f1e8 with SMTP id ffacd0b85a97d-3ee7ccf620amr13773f8f.5.1758214310066;
        Thu, 18 Sep 2025 09:51:50 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00c3e9035ed76de3f3.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:c3e9:35e:d76d:e3f3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46706f755b1sm16640055e9.11.2025.09.18.09.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 09:51:49 -0700 (PDT)
Date: Thu, 18 Sep 2025 18:51:48 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf-next v3 5/5] selftests/bpf: Test direct packet access on
 non-linear skbs
Message-ID: <d3ce3c7355f29d723af18f7ba5ceddd3dcb9c51c.1758213407.git.paul.chaignon@gmail.com>
References: <cover.1758213407.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1758213407.git.paul.chaignon@gmail.com>

This patch adds new selftests in the direct packet access suite, to
cover the non-linear case with BPF_F_TEST_SKB_NON_LINEAR. The three
first tests cover the behavior of the bounds check with a non-linear
skb (first two with min. linear size, third with long enough linear
size). The last test adds a call to bpf_skb_pull_data() to be able to
access the packet.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 .../bpf/progs/verifier_direct_packet_access.c | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c b/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
index a61897e01a50..c5745a4ae0fd 100644
--- a/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
+++ b/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
@@ -801,4 +801,57 @@ l0_%=:	/* exit(0) */					\
 	: __clobber_all);
 }
 
+#define access_test_non_linear(name, desc, retval, linear_sz)				\
+	SEC("tc")									\
+	__description("direct packet access: " #name " (non-linear, " desc ")")		\
+	__success __retval(retval)							\
+	__linear_size(linear_sz)							\
+	__naked void access_##name(void)						\
+	{										\
+		asm volatile ("								\
+		r2 = *(u32*)(r1 + %[skb_data]);						\
+		r3 = *(u32*)(r1 + %[skb_data_end]);					\
+		r0 = r2;								\
+		r0 += 22;								\
+		if r0 > r3 goto l0_%=;							\
+		r0 = *(u8*)(r0 - 1);							\
+		exit;									\
+	l0_%=:	r0 = 1;									\
+		exit;									\
+	"	:									\
+		: __imm_const(skb_data, offsetof(struct __sk_buff, data)),		\
+		  __imm_const(skb_data_end, offsetof(struct __sk_buff, data_end))	\
+		: __clobber_all);							\
+	}
+
+access_test_non_linear(test31, "too short eth", 1, ETH_HLEN);
+access_test_non_linear(test32, "too short 1", 1, 1);
+access_test_non_linear(test33, "long enough", 0, 22);
+
+SEC("tc")
+__description("direct packet access: test34 (non-linear, linearized)")
+__success __retval(0)
+__linear_size(ETH_HLEN)
+__naked void access_test34_non_linear_linearized(void)
+{
+	asm volatile ("					\
+	r6 = r1;					\
+	r2 = 22;					\
+	call %[bpf_skb_pull_data];			\
+	r2 = *(u32*)(r6 + %[skb_data]);			\
+	r3 = *(u32*)(r6 + %[skb_data_end]);		\
+	r0 = r2;					\
+	r0 += 22;					\
+	if r0 > r3 goto l0_%=;				\
+	r0 = *(u8*)(r0 - 1);				\
+	exit;						\
+l0_%=:	r0 = 1;						\
+	exit;						\
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


