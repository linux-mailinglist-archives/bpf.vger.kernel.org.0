Return-Path: <bpf+bounces-72277-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8103C0B377
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 21:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE9DF3A7FC1
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 20:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D5B2DF128;
	Sun, 26 Oct 2025 20:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVXOSYso"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3F62222C8
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 20:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761511150; cv=none; b=cI7AiWvZzBSlW9v8h0RR6JBf7VA6ERpfjjeddX9jTtYtb6or60eUpqhsPybl3z5cNjQF2Npj2wfhXVKafMMBGPe/va5PVGC8KHp21L2rYCeVg2/Ad1prZL+DipDwlkLKIGl/R2vDRUpf6yxGfi4OoktLYWijAuhRFKlMecI2d5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761511150; c=relaxed/simple;
	bh=S7wR7aZg7Tjl3o7Oqf0exsC+eBwpfOYtGuNSbYyxGDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f4GcNjGTjuUKMUE67b9V/nOBdYada/nIDFMUDw05fV8TwVAqyx5+iSemjZH+vgcSMWtDgbx7ipb8Tm/guUlw1Wlcyhw1ySke2THMlGBiIl0mBNiZdrg/2X2cnWtc96ExFd1KjqTl1S/K3XY/S8wnBdvWWwW4uq7UVrKUfgOgWQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVXOSYso; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3f2cf786abeso2258664f8f.3
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 13:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761511144; x=1762115944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=879X/wWgmNgdWJ+TiOg8p7qqMzA9yE+P722ipbE+i44=;
        b=gVXOSYsoBVyJhnsgZ7TdGkCyG0PuzP7ShJzjlWJfIE82Bay1sJABFKc3pNKEwteSPz
         09RpNpFRm/tRPD7WFvHgcYnmzXcFnMmea5bpGVT2SZoSOpLCFatpDtTx58KvRrXoZOX+
         51BzMqqsktzE+T1FcikQVAJHLLkQxP2Hk6Wcixt8Jk3psMr5hzkAf/9q0HXhfCaeEAau
         dM3sj+U4JRaUH9WBuwBjeJZEpbiiMH+F2IIosyUofljrjkK91919/00uoB87wGvAyCAZ
         E5xdaoBCuvV5rl4Esnr0vS1T3IJwfx0MG1FsM47ConCwvddORB4E7tYmW4qrg+idODuw
         pIRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761511144; x=1762115944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=879X/wWgmNgdWJ+TiOg8p7qqMzA9yE+P722ipbE+i44=;
        b=BOKMSfvgvE2P+RDCiAzVDUSD2Od0qihT6KdfMk0pUGs+U7aMpeOy4xgpwMM9uYUby4
         KmB8Rhj7sK5gucXPCM6/t+3TrK5u4xkGEA+xocMpexQRJzj/xKOcwXweFZ+7jRbbaBw+
         yS8YGeSLh0D/KpKolZhs7jfuqRnOv2mw0t6OKGCi2G3W96eNuCuj4RwfETny+bqWiqe3
         kaSl3ubYdvAF0VtbigbQm9KmLFJkcp58wh1yWBMgvHWFxUKgrVYZWU/9ujQGuUcIKeNm
         9seAZqVEgWRxLZWrtNYfQATB/Lq+5RMaPwdXaDkaf0/Q81beDD5PRA57wE6U6C6icI+K
         ZKeA==
X-Gm-Message-State: AOJu0YxGvYPAn4kdrn6QYTJJTH/lPINspi0G9gqvElSwvs32UF7CblhA
	Z/lC+uZER37B0ljmH1Kn96Tuz4XIJnrmM5M1F60S1azDyMVOu89py3hvPXsT5Q==
X-Gm-Gg: ASbGncsH4aeZrfLzu2xK7j26U82adsuTR5j5Blp3DGVwj3iDmB/X2wTLW2KVBKDTjsj
	LhPB1AYnPIeiqhg6mK/oary2LoWyXnl9GE2swW0dxXZiE/fZcB+kSovxpzjYrrpJ7wCfIo86xao
	A+Zt/4VSAfdLKIG9o0+FLWgUJ9ImhnjKcZ9DErsAqvyVCp+eCgyXpFeQtERORUphvTHG2+iPgdx
	DCBhcXYSImc/VRu1r1dUzIsdbQUVWcZ9n7GJcHmarnzO5YEFbg2n00qR0sV4UouIAnCZl6JwDMG
	5XlvtFr8VKH5GDcwMkYmGWSG9DjQSdpW+vUrcqN+p1b2Nl2ghcznOEzB45QaIn878RD/BNEA0Bs
	coA2Lm7J6z4wx9TPuyQEUCffiXF2grP0rObQziaxhw0N/zgDJ4QGF6IXXk6I=
X-Google-Smtp-Source: AGHT+IGbvccZ3n727iXkYIiBtEZGUn5aBicvgG37P7mbB/Xh8F74Bb+G+8o2oeTwtAMHS2OSBOQNdQ==
X-Received: by 2002:a05:6000:22c6:b0:427:15:ff3b with SMTP id ffacd0b85a97d-42704d145d4mr26697485f8f.13.1761511144071;
        Sun, 26 Oct 2025 13:39:04 -0700 (PDT)
Received: from localhost ([2620:10d:c092:400::5:4ccd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d9e80sm10139379f8f.28.2025.10.26.13.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 13:39:03 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v5 01/10] selftests/bpf: remove unnecessary kfunc prototypes
Date: Sun, 26 Oct 2025 20:38:44 +0000
Message-ID: <20251026203853.135105-2-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251026203853.135105-1-mykyta.yatsenko5@gmail.com>
References: <20251026203853.135105-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Remove unnecessary kfunc prototypes from test programs, these are
provided by vmlinux.h

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/ip_check_defrag.c        | 5 -----
 tools/testing/selftests/bpf/progs/verifier_netfilter_ctx.c | 5 -----
 2 files changed, 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/ip_check_defrag.c b/tools/testing/selftests/bpf/progs/ip_check_defrag.c
index 645b2c9f7867..0e87ad1ebcfa 100644
--- a/tools/testing/selftests/bpf/progs/ip_check_defrag.c
+++ b/tools/testing/selftests/bpf/progs/ip_check_defrag.c
@@ -12,11 +12,6 @@
 #define IP_OFFSET		0x1FFF
 #define NEXTHDR_FRAGMENT	44
 
-extern int bpf_dynptr_from_skb(struct __sk_buff *skb, __u64 flags,
-			      struct bpf_dynptr *ptr__uninit) __ksym;
-extern void *bpf_dynptr_slice(const struct bpf_dynptr *ptr, uint32_t offset,
-			      void *buffer, uint32_t buffer__sz) __ksym;
-
 volatile int shootdowns = 0;
 
 static bool is_frag_v4(struct iphdr *iph)
diff --git a/tools/testing/selftests/bpf/progs/verifier_netfilter_ctx.c b/tools/testing/selftests/bpf/progs/verifier_netfilter_ctx.c
index ab9f9f2620ed..e2cbc5bda65e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_netfilter_ctx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_netfilter_ctx.c
@@ -79,11 +79,6 @@ int with_invalid_ctx_access_test5(struct bpf_nf_ctx *ctx)
 	return NF_ACCEPT;
 }
 
-extern int bpf_dynptr_from_skb(struct __sk_buff *skb, __u64 flags,
-                               struct bpf_dynptr *ptr__uninit) __ksym;
-extern void *bpf_dynptr_slice(const struct bpf_dynptr *ptr, uint32_t offset,
-                                   void *buffer, uint32_t buffer__sz) __ksym;
-
 SEC("netfilter")
 __description("netfilter test prog with skb and state read access")
 __success __failure_unpriv
-- 
2.51.0


