Return-Path: <bpf+bounces-64874-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89452B17FA3
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 11:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A0AF7AAD92
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 09:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7E6230278;
	Fri,  1 Aug 2025 09:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1rMQ+MH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E97F21CFF6;
	Fri,  1 Aug 2025 09:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754041789; cv=none; b=cS8kuSZrkCIQ/RLk65JVlWX49bamfm1FRGcpqw2ZWd3yl/IfhMoaUJOKC3vvbq31t2phwEubM4oG6RleUhmL+5W+oidvht9wJn1XwmnIeGRUqxypkD612s9wrqGFKKFOjiQ9a6KVKmwVvn0cm+3uu7u7v1CcCL4pG4JRI3Czfr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754041789; c=relaxed/simple;
	bh=c/tG3bP1ARseY+CvWaETujBFzqKimimtj1odzFpCk40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnE8tQOa3V94W+yUmuup1gDo6MYOwpWTe4XWyks//BrEXwM5MqXnMwGtTm9efLYqZ+8fX78fo23uFDUFTf1yjUVCpvm1R1x2DDL0oG/sxItHg6NLr1j8qI65MGnEhr3skSyLm2++jEGC3AJTtwxmWql2LK3Re+m8krPmjYgUSWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B1rMQ+MH; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b7823559a5so1093905f8f.0;
        Fri, 01 Aug 2025 02:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754041787; x=1754646587; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pBYUYFf8RokWYQAqgv0u10DCwfMf7bpXeUdEu1cvJx4=;
        b=B1rMQ+MHQd/Zye5Xlu4iaV6wAotdBBvAobiP7doWeJ1Icz4Oqo4H96BE4YhUjpMjtF
         aUk14QcC8StHYmK9Xio4rLlY41x98tzOHV+wWYvhK3IFmhB0+FKPgwL3sAz+iRJdAzpn
         GjRXktT/gKFdiD7nzG8I09EfuC5rL55qokeNChHTTA5TfOpNb008hMRKQ50JZlb4EJeT
         LUSH85dVyaFln3hHXPBL1nfeiVy1pl4RMkfIBP/PvSzB24Kgrgq+WGFEGzO0mOQGXb3U
         UXSGyxtdzNLSLythMn9VCmt/Fco9MOggJO+aQ6G20Md313hyyBriv3IOGbfCoynCOkbQ
         gdAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754041787; x=1754646587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBYUYFf8RokWYQAqgv0u10DCwfMf7bpXeUdEu1cvJx4=;
        b=OLsYOCzcA/7MLcIwhYffrXBEUBJvZOQhkVgrkqw7SovhSr/ajam4nn8DxxRtx85vht
         lJ1uA95tvBskYbqFxfd4rweSYg1hZ7/KOc1P50v9hjlojyGLOYKDRfdXSAG+eAiqAKMt
         vvk956fIsYqSH2PK5vXYcegEYGoqafpwWdq2oEgCCMkeNY4mHuhBA8AF2l3ElXQIfG/P
         2IPj9B2cPLnO/5ZfdibL8x9O9yF1kIfQ/JOOBtyZOhT5OjsCVNOj/WB6kEiPxpUs7Ox8
         0JjTjAGV8jbehxqWK14o03qjkbvCzta8P9M89DdoucdPSbYACTaWhbAPmW+KtmCJkxWe
         dzeg==
X-Forwarded-Encrypted: i=1; AJvYcCXFwGjfFGoZrDKdeFejIyoV4U526NNDV93JxsyY6/nDfq2wiPZ7pKpfbtGsLyLV7Bjt4B1oxQKsSMGnajq07mg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSErM0Odu8nAEh3pqHI6eex0WTREJHX93j05YY2OCZg4GNYm2N
	VT3X62iJ7Y0nKD4uTdngvNgzfDub7E0j+v4q+OO77rSpgjiCqc3v1C+kwbun4mC4
X-Gm-Gg: ASbGncuPjKIe6VqPSTcZE6RShMYRXKdR6HI4SDGWHA5u8P9dcbGzdpIhhWF56gDxz3b
	wH66RfYIO26lDxcYhISJwS//riIw8QvcGd4zg03VvmOYhxA9roEtRgvHv5ZW1wDMjOdpfgFkoN9
	1gVFuSTRj6wLDeogDezoLEC/pyWuzHOy8vq6J+1ZnAiyLO/i+lKrE5zZHfUurj/Q6tvnNWtW6us
	q6yq/yEKQaqdPV9QdIWQIJZW4VGdSQF5szF9vYY0jrtyxTObLPJEIYaGaomdIYwXnXsNGkytWGG
	z040Z4jYD89l9yO2U/FRj9GbG+X803vwAzfjWDhAmYSSsJueuYL3nxKtYna3s0CQyhVkzGkBEvw
	Hg2hdrpsfo4b2eMfGToNVrS4hav4wo5Lm1EAFvLR3eA43Pnw1SAiqkkk8QObmitiN4Zp314AEkv
	fyYtplFR7GmUWqdAjPcNU=
X-Google-Smtp-Source: AGHT+IEBMkWhBClv/g4OsRfmcfct2j5hDjcYSxf7rwvS6/c9CFMCPAB06NUvYaaTa8yqdoqONWbbKQ==
X-Received: by 2002:a05:6000:2508:b0:3b7:75dd:f373 with SMTP id ffacd0b85a97d-3b794fe4d89mr9070037f8f.5.1754041786579;
        Fri, 01 Aug 2025 02:49:46 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e000cb332f63428a027.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:cb3:32f6:3428:a027])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589ee62336sm58611215e9.29.2025.08.01.02.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 02:49:46 -0700 (PDT)
Date: Fri, 1 Aug 2025 11:49:44 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	netfilter-devel@vger.kernel.org,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Petar Penkov <ppenkov@google.com>, Florian Westphal <fw@strlen.de>
Subject: [PATCH bpf 4/4] selftests/bpf: Test for unaligned flow_dissector ctx
 access
Message-ID: <bf014046ddcf41677fb8b98d150c14027e9fddba.1754039605.git.paul.chaignon@gmail.com>
References: <cc1b036be484c99be45eddf48bd78cc6f72839b1.1754039605.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc1b036be484c99be45eddf48bd78cc6f72839b1.1754039605.git.paul.chaignon@gmail.com>

This patch adds tests for two context fields where unaligned accesses
were not properly rejected.

Note the new macro is similar to the existing narrow_load macro, but we
need a different description and access offset. Combining the two
macros into one is probably doable but I don't think it would help
readability.

vmlinux.h is included in place of bpf.h so we have the definition of
struct bpf_nf_ctx.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 .../selftests/bpf/progs/verifier_ctx.c        | 23 ++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_ctx.c b/tools/testing/selftests/bpf/progs/verifier_ctx.c
index 0450840c92d9..424463094760 100644
--- a/tools/testing/selftests/bpf/progs/verifier_ctx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_ctx.c
@@ -1,10 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Converted from tools/testing/selftests/bpf/verifier/ctx.c */
 
-#include <linux/bpf.h>
+#include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
 
+#define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
+
 SEC("tc")
 __description("context stores via BPF_ATOMIC")
 __failure __msg("BPF_ATOMIC stores into R1 ctx is not allowed")
@@ -243,4 +245,23 @@ narrow_load("sockops", bpf_sock_ops, skb_data);
 narrow_load("sockops", bpf_sock_ops, skb_data_end);
 narrow_load("sockops", bpf_sock_ops, skb_hwtstamp);
 
+#define unaligned_access(type, ctx, field)					\
+	SEC(type)								\
+	__description("unaligned access on field " #field " of " #ctx)		\
+	__failure __msg("invalid bpf_context access")				\
+	__naked void unaligned_ctx_access_##ctx##field(void)			\
+	{									\
+		asm volatile ("							\
+		r1 = *(u%[size] *)(r1 + %[off]);				\
+		r0 = 0;								\
+		exit;"								\
+		:								\
+		: __imm_const(size, sizeof_field(struct ctx, field) * 8),	\
+		  __imm_const(off, offsetof(struct ctx, field) + 1)		\
+		: __clobber_all);						\
+	}
+
+unaligned_access("flow_dissector", __sk_buff, data);
+unaligned_access("netfilter", bpf_nf_ctx, skb);
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


