Return-Path: <bpf+bounces-68645-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C17B7F7AE
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 15:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C962481BDD
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 08:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93E630596F;
	Wed, 17 Sep 2025 08:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DmlSVwnw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F153064BE
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 08:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758096659; cv=none; b=gkaMCzkw1iMNMasUBj+XbVOfg3QozTaSLsdjDqPeTPDLKLjDEe64yXLzP5Q1BxSYP/NmV6nAsIjGwabdAHbUzbfHZcPlljjQljSaQpDei87NWu86Ct8r8HGgMPP8pc68/ds5sUYsbQMrA9yi/nZSjW/wYYkGJj2Tm+VJaJSDCDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758096659; c=relaxed/simple;
	bh=eEMXpE7qA9WxqZwH2TsDvzro+iyXtCNSM8UY3hnY+n4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uu7X3Pit7f9Dupi4XRPi30CxCEpirl3TsZlkE50W3KTxW/BK76rA3qvNubSYxpPFzi8WMab/OgHwriV8tK1fXqD9iq5YKwCPI/LqDgO30VezlKo5NRh9t7P51k29T5V0vUwQiUkmasDHcOqOp4rgdKkzvj6ixAccB0xjIfnn8+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DmlSVwnw; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45f2c5ef00fso29360425e9.1
        for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 01:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758096656; x=1758701456; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=esyEIszBwn/STiJY0eFuV+WgreeLeMDcX3X81k0AaV8=;
        b=DmlSVwnwJZZptxEsnrYAos7YNlwT+qSvN8zxN4oFSxWSjuXAbjW5nGAfLxHPP1mVo9
         GV4HGK6tBQc3Y7H6YsBbyHpvqoyrQCy2IW8k0oe5hEDO+SQBNWlfw3uifkQinLi8Prxb
         xiNzVWHggJ+rLtRv8C8tJsnKnD7DW3eRL0Rm0BjB7nylAZGQhfZbBwkINb1HxND3rAwK
         hZojUSAH3JmYwm1L7J/NIeooGB8B/52HTYErQIoZRdAg1vqhsZSkTvn+JABmIrqLX0D+
         U8iEuoUXQFyMWRNG2Jv8bNlG68TCyrPjV1tsZzWp57RdK7McrKjolsPaG2rLheh2td2d
         qHzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758096656; x=1758701456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=esyEIszBwn/STiJY0eFuV+WgreeLeMDcX3X81k0AaV8=;
        b=cr/00gI7YgCkEb430NQ2tc9TIWWSBcN2I68vhFR0ETnOMJhp7UVdJO5V3RAiyTTHHC
         Vas8igtIeA4iz80ViyaysVhJnVVn7rF5+0lgAfZiFTXwep1M+yNrfLLFpg+Jya+tLTjk
         m5Q9LmGWfQ7PKdJ/ErS/3HCPFr2CbPq0zSBsX2Lcdxx7rWGYB0zJMsrqAGKIwOTc7hFS
         Z50liRCzQP6hrWs3CcKa1rH7oCxgXO/F82hDiRCrsRlarTas+aJJ/EOIFebKahsxXAyP
         B+KPfefY3P7kmmT3uond9yM/FFcLNLQOkKFJ7THZhIQIVqenCDH2VghrpiwvWycguzrW
         CzTA==
X-Gm-Message-State: AOJu0YyDLkLBJodesbN/bsZNTF44biaMrJVj/plENCjfhOBjx9izZiwO
	ODpSG0/jQYKD88qeQt/teQAO+eaALiUZ7tO8OpxIXk/RduvkZ1f3BLUFcsfiOMJB
X-Gm-Gg: ASbGncvwbMl9ZbsfjbZm+6mW8muIbSVW+McdFGKRZxbc+V5JVOrC+tj7/6sDpek2OwB
	w8VChdKjk2DZVxspNvGUigTzG8Fxuv4rWoKQudEjX5KFSq0EZ0Jban0aqlxlwBY0T0DapuEXPOA
	VsDDUtDQlbHnPtijILsUnbbAZJVAEyEC0KiGGMPyrj6bcJ2DQRya3Q4CYX9gEVTtITJRSS82Wvk
	b6pYmxkNaLOVMozPJFYo7fYAwxxQlz/r6WTMxjL4rGoBtOnpSrZsysDAgg8h4kOCY4FfW8/Pa82
	CzpU95E4csg+kuD1e7uzShcZO/9BI12hM0MjcOHS3qYUdbc5A8gL4fJwm5Nki/yiRXMqFS4ruJk
	+e+ym1nlrWIEdfPK/WdFeqmeaqZ4Vm3wFKauDRaF7mmRyNiDpJD7CCbpeOFJXRu70E2+iqanKPK
	MPizkedjo2dZ7Pf45Zs9zV7ntyznKcNj8=
X-Google-Smtp-Source: AGHT+IHJhnlztqkPeuYH2R1zT53S+4h7Xg7ApONzZOY6C7+WIR5KCPKwwTLkR1LJ8dtDhsoNo/t+Nw==
X-Received: by 2002:a05:600c:3b09:b0:45f:2d2a:e323 with SMTP id 5b1f17b1804b1-461fc6674f9mr11568105e9.0.1758096655507;
        Wed, 17 Sep 2025 01:10:55 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00f6fdfecb9884ca93.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:f6fd:fecb:9884:ca93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ea6805001dsm12744444f8f.6.2025.09.17.01.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 01:10:54 -0700 (PDT)
Date: Wed, 17 Sep 2025 10:10:53 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 3/3] selftest/bpf: Test accesses to ctx padding
Message-ID: <3dc5f025e350aeb2bb1c257b87c577518e574aeb.1758094761.git.paul.chaignon@gmail.com>
References: <cover.1758094761.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1758094761.git.paul.chaignon@gmail.com>

This patch adds tests covering the various paddings in ctx structures.
In case of sk_lookup BPF programs, the behavior is a bit different
because accesses to the padding are explicitly allowed. Other cases
result in a clear reject from the verifier.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 .../selftests/bpf/progs/verifier_ctx.c        | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_ctx.c b/tools/testing/selftests/bpf/progs/verifier_ctx.c
index b927906aa305..5ebf7d9bcc55 100644
--- a/tools/testing/selftests/bpf/progs/verifier_ctx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_ctx.c
@@ -262,4 +262,34 @@ narrow_load("sockops", bpf_sock_ops, skb_hwtstamp);
 unaligned_access("flow_dissector", __sk_buff, data);
 unaligned_access("netfilter", bpf_nf_ctx, skb);
 
+#define padding_access(type, ctx, prev_field, sz)			\
+	SEC(type)							\
+	__description("access on " #ctx " padding after " #prev_field)	\
+	__naked void padding_ctx_access_##ctx(void)			\
+	{								\
+		asm volatile ("						\
+		r1 = *(u%[size] *)(r1 + %[off]);			\
+		r0 = 0;							\
+		exit;"							\
+		:							\
+		: __imm_const(size, sz * 8),				\
+		  __imm_const(off, offsetofend(struct ctx, prev_field))	\
+		: __clobber_all);					\
+	}
+
+__failure __msg("invalid bpf_context access")
+padding_access("cgroup/bind4", bpf_sock_addr, msg_src_ip6[3], 4);
+
+__success
+padding_access("sk_lookup", bpf_sk_lookup, remote_port, 2);
+
+__failure __msg("invalid bpf_context access")
+padding_access("tc", __sk_buff, tstamp_type, 2);
+
+__failure __msg("invalid bpf_context access")
+padding_access("cgroup/post_bind4", bpf_sock, dst_port, 2);
+
+__failure __msg("invalid bpf_context access")
+padding_access("sk_reuseport", sk_reuseport_md, hash, 4);
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


