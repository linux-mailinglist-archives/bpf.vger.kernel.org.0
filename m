Return-Path: <bpf+bounces-68319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C02B56A17
	for <lists+bpf@lfdr.de>; Sun, 14 Sep 2025 17:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10DEE3B85EB
	for <lists+bpf@lfdr.de>; Sun, 14 Sep 2025 15:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0B42D6638;
	Sun, 14 Sep 2025 15:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QghdN/1X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB7F2D5C92
	for <bpf@vger.kernel.org>; Sun, 14 Sep 2025 15:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757862794; cv=none; b=j6i1tINhvePvrWuP5pEaca8vYf7KH5m6qYEApO/mtv1tKJHWRoFC4O1flBqkQYzsJFkQ7x9cYNJa1gGvuruZ9ytZRpMsm5VjywxIPXgav53gd0uc6HXeJRIheeWsdDkE7uMhS7BQqDvZ0rhraVe+smH3GuKDB0jo45580ljIDR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757862794; c=relaxed/simple;
	bh=b1ib2SjwS8oVgFpoOGboUA0t6EEKyUFH5xqbYpjz5lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJA94RPe50ZvI8x8PQRlFKXM+71xlISiNYMNroPApOqQHpopqZu2Qc9ComdUR2lEY7vWHtxbTPsmgTfTjRuL2DCuibocqXyFN1+nDHEDpCtbbwQdqMy9Cz6a7MM/uSSqhbfDq8WP7gfpf3zNJYkMhs/LWq6Fyx5bu3djbIQz/wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QghdN/1X; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3c46686d1e6so2365063f8f.3
        for <bpf@vger.kernel.org>; Sun, 14 Sep 2025 08:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757862791; x=1758467591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dU0jcFAsptDqN6gqQjrUv6d0jNG2mr7dfYNmYkKA0nE=;
        b=QghdN/1X06bn81+Yi6OS4JTvDQikf6oloM7/RMJoBC9YfKaTmcW18pEtbr5rV1rnvc
         C52d9gK6ZYFX2DDWpmVKu/2ylzTzkloZDBahHvkBSnjV9LSz1b1jMuYiHt4deE4GmH0q
         GKMOGdVwKwHdU3n2EKr1rrQ7jnfl6RhNyVbziilzzG47Bwgxuj1TANB9BN4TEGG60wrV
         YXkVOCt1smpNXirz1mHT5Oulcz5SIqlkn7qTaL8tNZHZ4L3igL8HmLekY7CiGyhvRc0n
         IRWhOVyKu+d34bnfvWF4dCTHhJ9oA3KZgff3pyYz77PQcxyO27aXVVRrf1zWbVzGNaUv
         aklg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757862791; x=1758467591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dU0jcFAsptDqN6gqQjrUv6d0jNG2mr7dfYNmYkKA0nE=;
        b=Pa0ogTKXTYzUv5RGduRNTNkfjnLKOFH0eTz8YCXbzVSURcGWnLbzqnZB8h4E+Pput0
         XJSUV7IV8AalZOvwgmfh9wc9hyk3cx6yhJx0Qw1jM42+CivikIU9bYbFNmpRbFpYj7wT
         fQVljx2FnnDv9hiPiC5DFFVD8xHJvwrZ9vQpXczHtKaV5POe99+0gLv666e7iRY3gJPw
         4d4jg4rwxB/NFMThvSJi5H0i/nDJQ+6rL6faQmYMd7p2bt+/AJYEE2LOAXDgkxhU4Qh2
         dCwjxDRgw1DAWzonjuqRt2G0sCn3CuLHK1Kqq6JL/RR7KRjbwb3PjBtkWhYl1sMTuZxY
         3evA==
X-Gm-Message-State: AOJu0YzmsO++PkS9WUJG1TdFxgRQqgFSpPYfRnblwDdZLVGw+E4N4uIf
	eRwC4friTMkj+oJFbuxtfw0oUs8Y5WFwamh1iWeehPFK7k/zWXVmDCm1QmRVatec
X-Gm-Gg: ASbGnctK16t6Al14kBc2tRX3eKqsn3ILi4Wmb+Qs202WAcP1yJBB6rpEjqQoxivKUhd
	NIM4ANDkhwR2bhKvS2QX4QY8x5P8OPI7XwncJMNNv5xbEJMJNKMJSb9kgHzjnUwZXOsdykMng9w
	3B1j7ciccSCgLJVvyXbjOOhAfENzeoCcvxOr6QuKTXYIKzwckUgSiogXh+kkO+fDizyIZytrxrD
	FSTTp0GC122nuFxujLgTIfyhFuaT/KQkzaOQn7x6ZPlyt210NOlEtBYwkwkL5RXWx/pZz3TKE/S
	IQpLV+fVj/HfrwJdjWCpvNQ/KJHrT8ijc477RutY4GNQramv3AoLXm0Ow71V4XQRtYwV1PVtSTH
	UYASdBLBpNT64ofr9TDSXPbjwxNPZnrrCt/rxlDkfB65UGTC2wO9a3OU3jRDilMg6gjYPdFI1wn
	0cWmFT5wjSlVZj9BUy6P4=
X-Google-Smtp-Source: AGHT+IG4f7x3zznthZVIKLOECk/oIEVKdQByUrr048MyFSzzCSD0l3ArpWMtcftLn908epjJz5HS7A==
X-Received: by 2002:a05:6000:250f:b0:3e7:4719:a024 with SMTP id ffacd0b85a97d-3e7657c4d2amr7108631f8f.18.1757862790612;
        Sun, 14 Sep 2025 08:13:10 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00829f05581a33a178.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:829f:558:1a33:a178])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e04cf2870sm73904395e9.1.2025.09.14.08.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 08:13:10 -0700 (PDT)
Date: Sun, 14 Sep 2025 17:13:08 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf-next v2 4/4] selftests/bpf: Test direct packet access on
 non-linear skbs
Message-ID: <abe7753cee8976435f0721c85e9b5c9d4761eac3.1757862238.git.paul.chaignon@gmail.com>
References: <cover.1757862238.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1757862238.git.paul.chaignon@gmail.com>

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
index a61897e01a50..595b9cb904ea 100644
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
+access_test_non_linear(test31, "too short", 1, ETH_HLEN);
+access_test_non_linear(test32, "too short", 1, 1);
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


