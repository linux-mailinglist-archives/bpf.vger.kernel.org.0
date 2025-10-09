Return-Path: <bpf+bounces-70660-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCEDBC969D
	for <lists+bpf@lfdr.de>; Thu, 09 Oct 2025 16:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61B283B69E2
	for <lists+bpf@lfdr.de>; Thu,  9 Oct 2025 14:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB462EA474;
	Thu,  9 Oct 2025 14:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5uBDoOy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6872EA164
	for <bpf@vger.kernel.org>; Thu,  9 Oct 2025 14:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760018585; cv=none; b=ZW0I70hzHVcTtsmOJgiwTzMXe5SHpshFGFWJ0qKQB/9frPWzz5dH1NnGujuNc45qIc/vikOfxqNgYTDH2j/nGgX0bdsBWJEdBDCiEBWdij5d5RyotwcYQn32UzR5e+dUV/s/vk+YiI3ytfrMn8LtZyfTNK9wJU6FQNRACqJyjf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760018585; c=relaxed/simple;
	bh=qF+q351/t/xrZduAHpMQsZMKAFdKzG2Q3E8DIUWyUxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MavkL8vPaY0gS4klBEGZZfqLZSHYQfkHF6UpUAxiz6RyfBRE1uDGIZIScLC/ol8rT54B6JEZHCpkKmM/EVO/8uijd5n7aCyELwow0HeROWmzYNCP6GEkfV/4WjmgW5uQMisGzP7naucYBFP7L4rPyXDuNmGZuSSrcgSjOl3ng+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5uBDoOy; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e37d6c21eso6433945e9.0
        for <bpf@vger.kernel.org>; Thu, 09 Oct 2025 07:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760018582; x=1760623382; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4SGP5+JpnsHXkwuHaDpAZFmdqDhOWMSL3V0B4ToFXNo=;
        b=d5uBDoOyttzouxDyhkCXzdQ0VEwAqnwqGE8VdRfIiui7VYb30E81bhaUewmghta9CD
         o4j4CLFllnx2CLe4Q2VDmQvZgxQpBCOo3ThRAsjVJ4c+YiwXjYVEh/G+6TD0xFR9W+/F
         1qzYwTfiE5Ze24pVU82BnKujA7HeoBRkhnGZ7RWrHT4ohZ/66XY6g2wUxnHDgB7td5GZ
         gKDP4Tns2r+FZNWVfh56SX80wYOpO9TXnL9Y0lOyCdTYB65jAEQmy3iH78bXnYP57JZy
         OUNE5Y8do7LMPaSDvK0XBTiNegeMbc1UuncD/tLKdEdoBsI8YQ9rnmhrC5jVADkunF5Q
         C8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760018582; x=1760623382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4SGP5+JpnsHXkwuHaDpAZFmdqDhOWMSL3V0B4ToFXNo=;
        b=LCPcrv1Bn4QZ0lzs6BO/N/7TcRIoDYdmF5knbJW74SbKaVwk6pkeuySrj2ZoopGyq0
         4adDgybdaSkFyfctomjj+xDHSOw6QjPT/RTymIqAgSnaLpiXpn+7v+uPpr+0eG60tNll
         0/ZyOfqVZ1EIC9iX6HIarzwps9Sqwy0zHYbcKnXZUnsTTR7W/j1uykE7q8Z5qRySVRcn
         KH4nVvTKb6yAAz9ydXRUdKAfatR+kQVXsChxcIgo52+xQfGYGv2DRoB2CkCOLVtHSGn5
         63IiBEh89kzG0GI3Svg1DrIVrXvBIkemKHMCXljX7gDWTY9aAx3PHXYIzNWQhRC4EYqF
         D2WA==
X-Gm-Message-State: AOJu0YzEUIEfpEbyUbFxbeqiJk8hcu5maCM6ZilBeIcMWB/wO6wyjL6S
	YvHt8Fz58mBvUKSZBKcSe1VFbfdfsQ29Kp9FYg2B1GbBytfdd9qXeINOO/s52g==
X-Gm-Gg: ASbGnctQ29B42vZarDauw3V13RFFlVhy8CFW+WFa3UxXfky0Q1YULzYz85aGQ6l2bXw
	QSq6V8VXv+sQUJ2rSOn/DEGw6Ym5mzQ5xPPY5jqFsNkuUdtQ3MIi/BB/hlvtt38UrN5ud2c72Ho
	GR9XNvd92d8A5BBFyLmDrl4rqnwfVo3a1AOkwyO43/vb7u0OZVMkUSmom0KfWOEtJaic/griuZ+
	di+SagrjMNTGS5IDWhVR2yN++xr+85ykzUpKe5uN6GZcyUrXvId5fnCfQgxuARKuoJfNzHAgZ89
	9ON94w81yO/9GNWM8/CgmlqadUwprYc+qZK6gP7amLDBYEvogf/L8GWZHrstHTnPUCiDPtgACp6
	M1VndLAcUJrM5QXwEEgEjXPbuiX9dkKez8//kGssZdtKRN53z3u0WlZSNECBLqWfKv22byPJ/dM
	JY40FjcRn3/gdWKmsQ+m1djtcEw3EeyFDDHGsyuske0oH5ZW6bJWa7zVjj
X-Google-Smtp-Source: AGHT+IH1Fx+PUjXMorKsFafHIvGZmQ7PBIKQqTjaIWPI2JAMatIqZaWKVR8guqbHEYCJvyAOJjLQ1g==
X-Received: by 2002:a05:600c:c4a8:b0:46e:4921:9443 with SMTP id 5b1f17b1804b1-46fa9b1b277mr51107045e9.37.1760018581952;
        Thu, 09 Oct 2025 07:03:01 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00b81184fd69385167.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:b811:84fd:6938:5167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f0846sm35676206f8f.45.2025.10.09.07.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 07:03:01 -0700 (PDT)
Date: Thu, 9 Oct 2025 16:02:58 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf-next v7 5/5] selftests/bpf: Test direct packet access on
 non-linear skbs
Message-ID: <f7dff83678b7c979a8a967dd30cb7db569320e50.1760015985.git.paul.chaignon@gmail.com>
References: <cover.1760015985.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1760015985.git.paul.chaignon@gmail.com>

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


