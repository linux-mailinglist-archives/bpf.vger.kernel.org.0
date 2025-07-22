Return-Path: <bpf+bounces-64057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 413D2B0DEEF
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 16:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39B2B567A55
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 14:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27402EA49E;
	Tue, 22 Jul 2025 14:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkFutKOm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC522EA721
	for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 14:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753194823; cv=none; b=Hyajl02jm9u3+QVRPABwS1OjbivAI31txkH/VcI6DMe0cgHNMQvkprlDZqOLTlyJiw2p/XJPqNbsuMUUqr2FEDtuLClRwtP9OxqhKOnaW2J0S43z4BTBg5FrejLwEBvE+ibRCMq4XvFJzd6A7Y6v/L5AZWSUQ6mRTRiBjyGkZzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753194823; c=relaxed/simple;
	bh=mlvhWboelmjCNYOmmqeSaRWqJhavuLO10ndYklLX4OE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyYwqm+zcb87SUTbkjS2K3ukoF9xoylefFEBDNS+SalJRQLwCZVrsKAzU48D7Sl/z3bVexcib2XtKKSnKyHru0jXRuRE6k8Tx7CrhTEZVkCYendqi+NRZUZk/4DVS/tVbUSMd5Q9yTqr/PGJLHQqMfB8zDqkIa2FndpBqcmCTf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkFutKOm; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b45edf2303so5041280f8f.2
        for <bpf@vger.kernel.org>; Tue, 22 Jul 2025 07:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753194820; x=1753799620; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mf4cjr5TyJ5s1IFgYkEURJqY1QARTIRWQrtMZD0dH5Y=;
        b=dkFutKOmMfX6BMqow0KeIE24bGklBv9jEc8lky46dcgFDjwW/h9zJiGgITjdG9+yLa
         81+NMDnhQlsiEMaJttBVM229vZSR+jNhOJDjcEkaOMOCNYse6rFv4vm16Yje7CnApoSc
         wcEKnH/ZYiZugnA0liCX6cyC6fZAN/SL+NH/vAkqkfuHyWM/bhjw26pKQAZ4i5khSBck
         81npqjQZvS4XrivDvHSfoTuQny9i2xKjiDIclYdtrpjQd6lM65nzpBsyJHtzjvziUr9p
         QyMdLaW9mLhpRQfcnVf2dzIcm4RYdBM1Ucz6W5V5Yw6CpuVLe9z41FcmecXh9oQ4X2sa
         Kx5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753194820; x=1753799620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mf4cjr5TyJ5s1IFgYkEURJqY1QARTIRWQrtMZD0dH5Y=;
        b=K+RyMV7UB3el/kwMhjWyywVMcc9mVoHlVuQMcYR0DB7Trxx3FM1a9qRif2A9zhGbkH
         QJHZnmdXFNVqwEGkM02cik/YqGYAp5m3MLJQLgHytrPd8iBOl+gXxsXNMumSgIkG0J6Z
         6Rr8jy2C5Ii3/1N8sGFR9LYZtPeVh3K6dCrs+7ry4W3YUK5vN6osJWlR6ELfLq6ltp33
         YR+DgNCmIjWNJMvnjIIXLaz38SuwZevrp00vkL8HCjL3mUciMXRaJBoY39VNnspyibAr
         uA9mBfZcuysQC2a+bG3Z4EsKWGbqjQmlj/5HKGr4PW+dZL+bMWyTsg13U3iVtBN5uEHy
         GzwA==
X-Gm-Message-State: AOJu0Yze+9lHNzUv45SdgTESQ4j45hzBjYNKU0l5DX2GdvmhWU8LKqt9
	8PpI9q7BxHOUDmwH49le6hAiReqWxsoxM3QAMb1/RY4Nr5gnDuR7NjTtQ8lSjf6D
X-Gm-Gg: ASbGnct6+XXgfKSGMmzdL+k3cfdBNVb7ZvdykWaohnI7pD0toawBNH5eV8TGUz6dMd+
	88O5nkkXd53VKsrv99yYUDOdODZG0c21pD9KiSnBJ+1KvyqPZ6UqoUZfn5exAGWhRYlwdSu4fjl
	OYjqpkDFsSeZmnbYyDji6JYzkmXhyFLCUVY6IR20PZCN/CKuABHASEt58lOUlSC8Rm/2FEakrV3
	pX7+1W7waoUAZQAI9ey5aIZuxOJ4W/96JqgvenIoRwOHmEwM7RPZLREaG66uHxhmYNqwHG5Z5wX
	MIJS8IYmlnXLzgvlht8chIMx6e/H49w/PC3chnFv19ZEtxYEhx81nJLwpS1r1MY/J3eimF7OjhK
	gIGT8H9dI6L85XlcTstE38T0CzIrmbZtC5sPtPLiOXsdLvffnpntTCxLfI4st1zy8HkRT1m0Vii
	o82EWF4PIHiR+J1rsOGL8D
X-Google-Smtp-Source: AGHT+IGjozIukWnH6jzBRfofl9fOGPy2e7B09LQdipEm3N4BZuZckHgbak+qNscsGLA730XgA8LvrQ==
X-Received: by 2002:a5d:64c5:0:b0:3b7:61e5:a8a5 with SMTP id ffacd0b85a97d-3b761e5a9b5mr4719128f8f.47.1753194819923;
        Tue, 22 Jul 2025 07:33:39 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e007ae7318c9eecf7c3.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:7ae7:318c:9eec:f7c3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca25643sm13269064f8f.16.2025.07.22.07.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 07:33:39 -0700 (PDT)
Date: Tue, 22 Jul 2025 16:33:37 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Test invalid narrower ctx load
Message-ID: <44cd83ea9c6868079943f0a436c6efa850528cc1.1753194596.git.paul.chaignon@gmail.com>
References: <3b8dcee67ff4296903351a974ddd9c4dca768b64.1753194596.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b8dcee67ff4296903351a974ddd9c4dca768b64.1753194596.git.paul.chaignon@gmail.com>

This patch adds selftests to cover invalid narrower loads on the
context. These used to cause kernel warnings before the previous patch.
To trigger the warning, the load had to be aligned, to read an affected
context field (ex., skb->sk), and not starting at the beginning of the
field.

The nine new cases all fail without the previous patch.

Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
Changes in v2:
  - Cover all affected fields, via a macro, as suggested by Eduard.

 .../selftests/bpf/progs/verifier_ctx.c        | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_ctx.c b/tools/testing/selftests/bpf/progs/verifier_ctx.c
index a83809a1dbbf..0450840c92d9 100644
--- a/tools/testing/selftests/bpf/progs/verifier_ctx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_ctx.c
@@ -218,4 +218,29 @@ __naked void null_check_8_null_bind(void)
 	: __clobber_all);
 }
 
+#define narrow_load(type, ctx, field)					\
+	SEC(type)							\
+	__description("narrow load on field " #field " of " #ctx)	\
+	__failure __msg("invalid bpf_context access")			\
+	__naked void invalid_narrow_load##ctx##field(void)		\
+	{								\
+		asm volatile ("						\
+		r1 = *(u32 *)(r1 + %[off]);				\
+		r0 = 0;							\
+		exit;"							\
+		:							\
+		: __imm_const(off, offsetof(struct ctx, field) + 4)	\
+		: __clobber_all);					\
+	}
+
+narrow_load("cgroup/getsockopt", bpf_sockopt, sk);
+narrow_load("cgroup/getsockopt", bpf_sockopt, optval);
+narrow_load("cgroup/getsockopt", bpf_sockopt, optval_end);
+narrow_load("tc", __sk_buff, sk);
+narrow_load("cgroup/bind4", bpf_sock_addr, sk);
+narrow_load("sockops", bpf_sock_ops, sk);
+narrow_load("sockops", bpf_sock_ops, skb_data);
+narrow_load("sockops", bpf_sock_ops, skb_data_end);
+narrow_load("sockops", bpf_sock_ops, skb_hwtstamp);
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


