Return-Path: <bpf+bounces-70156-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49339BB1DB6
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 23:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A03273AA6CE
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 21:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623D031196C;
	Wed,  1 Oct 2025 21:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqo+nAjG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA7131195B
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 21:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759354320; cv=none; b=ZcWiXgm+FJbqoDwyJzNQS43ZTMdP1Ogcr7hefgyOgSr/CKxdiO2lzh/lhscPXzMLfZhNUcxk4ajJlLE2X5ssRauo50QMOvuLyIHe7716btHOoXwCihxJb52PfoMrpR8dLx/JPcjNMybgMZ9pZO+llTWjQsh0BussDRpRl6bfIwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759354320; c=relaxed/simple;
	bh=pX4gvk0fHoFrTM698SuDdV0Y7AzW6hcMimgjM8jzy+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gvbu4YBRC1K2nv0pqDZxIhAVUt6Li76GgZ4uS9zhPZIpbwgS6BLVpKhIbH4CKA6apOGsbljiFSjeXx7TsQQMdp6txVxOVZAiJCMCrFRzfvJvFBmYoCNy3UCDil5fF+XJsGVF8zOBqVOGvt1alIpMXsBjpOPbTqXnCSDug9Js6C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqo+nAjG; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e4f2696bdso3527985e9.0
        for <bpf@vger.kernel.org>; Wed, 01 Oct 2025 14:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759354318; x=1759959118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kxdA70hpQX3sHJYD/6vYTSLxugREqF1QoyOh8PFGdtQ=;
        b=jqo+nAjGG6jAkpemYv8oWBFvug0T6T4e6cdRZTLZf8RhhagfQ2fy9Wbpl8Vj2ba8tf
         TPe/vFRW0bhR5ni4yNfMq9P2rFz2zJrwZH8bjvYDERscLVLzqZPUOV27ijsrepx/DW08
         tzcK4P/i+R+fCz1xt1+knE7Y5y+mduyQx0aPm5IvBlVz+fUlt2RLQZJzR2aAVsiXwOzX
         jP3p/Ywn2Ib0HJHcPec6EYvrm5b0kB2a2JyjaOHcs0ulDEmICyF6LT9P69tMhRZsZoCC
         lYFjur8CeDXsw3vXy/hmc00XTdnXm8HdzM7IxibI4Khrgsx9BYiXegxk3c64EA07k13g
         q3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759354318; x=1759959118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kxdA70hpQX3sHJYD/6vYTSLxugREqF1QoyOh8PFGdtQ=;
        b=TzZ6irK5XwJoh0uLOA30907HVyr/qm3q+/axga5EhNUr6zKrS0iSusyphTW9+Kisz4
         Rg5TroWCVI6noyTIICnnTntJvDFsdAOT5iugmaZUrPKNI/N3fsdYN2Rnbn06qz3ZDKpj
         7k7nUJ7vqdfM2N6XteuoZfHxMEG3s8d1h/EDjEZ7VD2l3VlWS1dSj+1vFT3Kj1tIf1Ue
         +LGQLMyx4h/cSnnuoMGRuQyQDquiizOHFVen0uni4h+Ynm6VBRyJufbde5YI1x29l36s
         qV06i/zCraMr0K09UmQ+qep4sUU9rpeO1rM+bqNlVCahIlTWEJdijSZYh5u3sNEsAqp3
         DW+A==
X-Gm-Message-State: AOJu0YxrbKYOkFjeBya7Uu5rBl24ie6R2Porgqy/B8O271AQ1vYMgFbD
	hzxK8s20Dsh1Q/kB1bHibulVCjkAbF3X8bx4AvE7cosYCabBAv4BbpnBLY9nxifU
X-Gm-Gg: ASbGnctNubw5n34kUikIDa0dGhZwOvRljRoG0fUrr70QGUCtUHX+TN+kf3Qr8DCgeS+
	O/30OWBCBRWP0wsms+Au79GwMu4b6Dlh7LVTAx/pjJ5cdYJUMK3fi2s2YUdoacTMAzBIa0iGAUr
	3o8nGlBjd4kRdr+f9TmjjHPj7Nj4kdBStXqiOoqiDI6o2MMR4tyJRHegmTVe7xFSB+X1oCQZo40
	C5pOqh6LGYR1bVPtppUxz5AU5N/T6Hr9r3RQHkV2aOzjn6XMfojwhjMVX16e5KiZnz/wvBfHNJH
	QkFZsNOcc9DVWZWu4FE0U0B0x2vPgPrSYozJdT7ivNbqGsIyrWEJ8Yfru+wN82yj07mekoBF1dZ
	J9rbz/a2LWBy3eNsq3hYzFcfcmstrHYj+VjAUD0b0nQ/1+UF9tARVNt1rHeoSIQW7oxyagudm7D
	JGvQrKQUjpaClDpi2qgb7tyN1dSpEbOPciF2zkbw6XWQYa
X-Google-Smtp-Source: AGHT+IF0jM44o3khGywKV3NEpd2+RuZqrxrTDNUcV0O+4DXM5t/qz3wP89vS7bd80HJG74euo8XO2w==
X-Received: by 2002:a05:600c:6692:b0:46e:502c:8d6a with SMTP id 5b1f17b1804b1-46e64641e65mr29806175e9.25.1759354317344;
        Wed, 01 Oct 2025 14:31:57 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e006ac507786c22ef92.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:6ac5:778:6c22:ef92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e693c33adsm7157005e9.18.2025.10.01.14.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 14:31:56 -0700 (PDT)
Date: Wed, 1 Oct 2025 23:31:55 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf-next v4 5/5] selftests/bpf: Test direct packet access on
 non-linear skbs
Message-ID: <d9a9add3facb57640de3a60dae100d404b0ab65e.1759341538.git.paul.chaignon@gmail.com>
References: <cover.1759341538.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759341538.git.paul.chaignon@gmail.com>

This patch adds new selftests in the direct packet access suite, to
cover the non-linear case. The three first tests cover the behavior of
the bounds check with a non-linear skb (first two with min. linear
size, third with long enough linear size). The last test adds a call to
bpf_skb_pull_data() to be able to access the packet.

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


