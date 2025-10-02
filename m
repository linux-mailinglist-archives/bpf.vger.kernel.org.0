Return-Path: <bpf+bounces-70193-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 584F0BB38D2
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 12:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D37C7175AD9
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 10:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B39D307AD6;
	Thu,  2 Oct 2025 10:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQhRDvIe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7EF2D73A2
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 10:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759399684; cv=none; b=ThqQgzhE2rDC/gZ5G+0howx5aTfizq6GsmqwkfUhEyFIWruW/qZlTrqpmc4RPlewXfywSHDVbc1PWeWDBN8HvlM1YpPfJTJiBC5izdgK7y3+2jvEvzFIGrLDWCapG5HGKm+kJSOCvHixmjldPIwwWB6MsfBaTEuQqwNfquTHTGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759399684; c=relaxed/simple;
	bh=pX4gvk0fHoFrTM698SuDdV0Y7AzW6hcMimgjM8jzy+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CsSz3LFN933dujjPojWR2F/EqHNWCOVRTIbTOFGo2jCRMSXGfeAopUZOKyjecNg167aGnovB5fGpr99pqjH5S0O+ErgcqE9sF/BVRkNlrDEE35luWnxFrkZxFsYAoDmQ92kSW/fdzUelVXGwX+OdRQDniPhZNqFvhXUYIF/06OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQhRDvIe; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e34052bb7so8261175e9.2
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 03:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759399681; x=1760004481; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kxdA70hpQX3sHJYD/6vYTSLxugREqF1QoyOh8PFGdtQ=;
        b=SQhRDvIey3WyhtLDUkD1oyATUePisskhT5DElTqIecnLtEjhElMeT3/iAh94/qB9CA
         4Nb9Fu1Z5NMmQCFKB52lp5/U6dpZ2q6ud/6sPer7pjU5+hWFnr+XslnuU2OxnE85yRjM
         91HClugHsKewOyFBp3UD5g/Nz2+oye/TBdjbNwUDLMqz1zyd2iezrypPNRt/TJ+mYD5w
         rTPIFqg8DrEOMZ2poyCfW+otMfpfHqKVj6A6EBsHCc5HfGDbmOVs40mRjwH6Bdh6ncKm
         Up2qjmbrEoxWh6mQZG1yBhC94jMJBfIogfXJZCuemKxtNq8ZO4MMtG+GpAdWEwNoFwXB
         oREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759399681; x=1760004481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kxdA70hpQX3sHJYD/6vYTSLxugREqF1QoyOh8PFGdtQ=;
        b=Ko2LRxdksEJLhy+ZCym/5MWPDwhOopuVLQqq/Depsphh9R8IU64W+Picks8h7fPTC6
         4iu5GYz5IUp4RCguHX106SF5dwP1HJNF9IxQdTOdcRj31vGbQwvmrYLUQXvwWekRItg2
         +vbQ9KsV7ot1nzWOzDluv/s3cCFx3WskOi25vRmm4CkERF3yFAfsY5KVfijeCfFf8hUO
         tlEr4TSZ5Rb5qzPI5ROE1dgKIMQIW+3SslF9EQqNuOQ9AzEd8P09BEfjcN0n1rKlz/zg
         ohMAPflSbHxrMjgEJF5ZplHbeHVlEF2ZDlU7aS4FsXs3YtH1y+ACo3R41TvYpNuJxEdJ
         C3wA==
X-Gm-Message-State: AOJu0YyF5zrJYgoKgjgbn32ucqEEg0Xngl7Z6a4dtNQPfNkEn0F5+iB3
	/I9S7LZzZVmdc8eFkN/aDnZ3EfIzpjGfwlrVSWp7U8LepOy+0Q58iflAjZAsL/t7
X-Gm-Gg: ASbGncttCesONlLOu6kiOirpoorjylFh635ZXPH+J9QqFHfjFFYHxQR9G7eE8vwguXV
	rygKUhDMdvg1tAOt6JUPZAGWh5czioUsh3TmKEaDKQDo0lqlt/oZk4ZOeGI2shDxUy/Bqn2KLxY
	5Aje5lxG9DHKLJmtu70w0CRFOPdk72JsxDiuDTprGP+pyb1xVLbmMo8YBvlmZHpzzyrfrSc6qeL
	xBk8ExcDXxvs6gqVYyu7N0c21qG9LrCzipiXGSi2nvCwUKtPf7zSC/8mk5IiJMIosI8rbYnhVWd
	H1Ns+oRVt9nCwQr07+7OCcbWe1+oFYnmY1m+fWEJr2wmPtF+BX/N6FbPVRJxKCS6hY/S8K6FNvh
	+LaY9TEJa0QVO8NjPX0KDmUOzXcVrYoOe1QHlKkwPDOvd4tSZXnlI6KulPERn0jDuiK7pJl9rL/
	pKlBazlEtnQYOKaFKkIG3Z/7IGupUfMxL+uZCK/W3Vu2c=
X-Google-Smtp-Source: AGHT+IGpE9bx4P0Jxn9G+dLH17Yq2UMw7GWnWcBn3qojZU4hcHq6Bslf/D+dxjGmpJ5/ngAcwk2s5w==
X-Received: by 2002:a05:600c:4511:b0:46e:394b:49b7 with SMTP id 5b1f17b1804b1-46e612e5d92mr53829235e9.37.1759399681237;
        Thu, 02 Oct 2025 03:08:01 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e000a5ae04ae4e6e63e.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:a5a:e04a:e4e6:e63e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a8542sm2968492f8f.9.2025.10.02.03.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 03:08:00 -0700 (PDT)
Date: Thu, 2 Oct 2025 12:07:59 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf-next v5 5/5] selftests/bpf: Test direct packet access on
 non-linear skbs
Message-ID: <8a10e6310cab4a3ce90c804aba085aefc489c649.1759397354.git.paul.chaignon@gmail.com>
References: <cover.1759397353.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759397353.git.paul.chaignon@gmail.com>

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


