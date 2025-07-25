Return-Path: <bpf+bounces-64417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE4AB12638
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 23:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD23E546EEB
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 21:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9DE2609FD;
	Fri, 25 Jul 2025 21:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XP0CYcbd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF4625DB0F
	for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 21:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753479863; cv=none; b=aAQwe+1X37sdzqVGW0sVeBYIx7qmDuFoVDJl+rPYyBHEPQpQNOKwzC1MdVGYsj9kJcTjqkNGbUvcSeEe9emVgidmjzAG7sqCE08FbQGcDDLbhfFlKSej2sx3/b2S0bwrMp3OdHnfBpHQL7gcR4F+P8MeK8ISsUDF8OPPcmyvnwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753479863; c=relaxed/simple;
	bh=Iq1cnbTmEgni4YxG9ywBHoblhfyo+0pPO0BkBz61KdU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ga+e5twP13dh+mwYk/5CdsN2KvtWW7IzQJ+t1/BRL2Zv6g7TJA2LhuifOXgOEsuCLmWUL2OT6Be4yldz2CsGjXN/VEj+f3G8Qkn75fmJyArkl5R4YGozeLQS9NUQ3uKPECncNEW1Ufra41CjQ3pYWij930w9kXyhl5kbOAGddZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XP0CYcbd; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2354ba59eb6so39934295ad.1
        for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 14:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753479862; x=1754084662; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JB3KE76w5fALvodnJVMWZoQmA6fWA680+neCuoDNhMQ=;
        b=XP0CYcbdivf+2cL8ff+GlnRSfkxB5uTSZkJ+/EF+iduBs9DvFMmqK0j/+FqmVKHSR9
         lUewCSjVZ8yFErvSxFr3UKOeW1fEl2wKiTofKv4PTXknW/3q8gKWfPpkQI+L0PA3fOjE
         xD/9w3TZ90eLlSNgM+ggJgaTCRJGlWFEFVvpxNZLgUYXl2ff93zPclvRQaBiL7HJC4+M
         V8d+PSKTbjWXYY5KggiJ+SNfKFjUUB7DMXidcEwID01U80ZTBDtSCG8Iamazi/mAP/+Y
         Go3fzGjwxNwuoRpsmr13khj7kpuVGG+QSbvMT5QU7dxQ2X6zIVSDZB9eYyIQDJqUzauC
         VQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753479862; x=1754084662;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JB3KE76w5fALvodnJVMWZoQmA6fWA680+neCuoDNhMQ=;
        b=bXTNGIkVs97/XnzAhQzkFDPUI/bT288RpwH/JwHp1LdmJ7aLuoSc+tzsvh/q0TiEVD
         nfVTk8sWNhS6uBkidxajmB63TWeFQZWRUjVHN4PSwKlL1qQKyVHprgUMihODgo03kk3W
         j2MBmG0MdME+o9NnO7IFEZu0ObP7AdCuzG+Lhr7AfHlEB90jWOsf+XPYwQWarc6nP0cb
         ZNcZ47HaHea5Y5BQdr55w6NyK40bbUjVDmuoLHdnr6b2CKbxCOvjIrtQTN19P1BoUd1Z
         pzuhaRXPOTcf22qrF+CN7Rsoo4kcc/Lij+jrzOcaP9rAtEWbHNbcO6nCjH8i7+uLm6GV
         SUmg==
X-Gm-Message-State: AOJu0YxflL9fSM59hDul5THTODMY+DdZ3jQSBhkYoK55J9AJ7DPx87uN
	4vNw8WSQ3op9NCnTqPU0JaErEprfxycqo9uyqL+0k/M9vfqBz3v0ByzdHpusPU+eNENCHMvS+cc
	oAB428jonpuFhnGrVbugz67GeKCWweSO5fa+V/bTx8gncnKFXZfdvN0HMck07JR6WMufmQeijm0
	bGWlvr8YJ3UzRQ6nGvl4VBIO8zE3hwpOykDW/OY1+nQIAoWU4mEKgwk80gRJ6noIbi
X-Google-Smtp-Source: AGHT+IH1ZJHPyFWJEdvWuwgbW1dYgGrOlGx8FCPu/AvhGsRm/WBEUq4PZp8pRuQZXST0DqCbfK7QypThYkUVSL1Bzmk=
X-Received: from plbkk3.prod.google.com ([2002:a17:903:703:b0:23f:bf61:8e96])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:fa4:b0:234:df51:d16c with SMTP id d9443c01a7336-23fb30e8d49mr68338175ad.45.1753479861796;
 Fri, 25 Jul 2025 14:44:21 -0700 (PDT)
Date: Fri, 25 Jul 2025 21:44:05 +0000
In-Reply-To: <20250725214401.1475224-6-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250725214401.1475224-6-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1561; i=samitolvanen@google.com;
 h=from:subject; bh=Iq1cnbTmEgni4YxG9ywBHoblhfyo+0pPO0BkBz61KdU=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDBnNvxZfydzy1CX3xZLb0m2B61RMppTsa7uoWnvwlrFc8
 IQyS87UjlIWBjEuBlkxRZaWr6u37v7ulPrqc5EEzBxWJpAhDFycAjARZ22G/x7cWg/DfK5eCLlm
 Mm966O9tv/WWy3ac/CRy5Wi58pyyQ70Mf6XXVCt66S3kT14eb+q9obL6xlWlkGVuXqcb0u9F7BK 7xgYA
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250725214401.1475224-9-samitolvanen@google.com>
Subject: [PATCH bpf-next v2 3/4] selftests/bpf: Use the correct destructor
 kfunc type
From: Sami Tolvanen <samitolvanen@google.com>
To: bpf@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

With CONFIG_CFI_CLANG enabled, the kernel strictly enforces that
indirect function calls use a function pointer type that matches the
target function. As bpf_testmod_ctx_release() signature differs from
the btf_dtor_kfunc_t pointer type used for the destructor calls in
bpf_obj_free_fields(), add a stub function with the correct type to
fix the type mismatch.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 tools/testing/selftests/bpf/test_kmods/bpf_testmod.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index e9e918cdf31f..b086244f259a 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -249,6 +249,13 @@ __bpf_kfunc void bpf_testmod_ctx_release(struct bpf_testmod_ctx *ctx)
 		call_rcu(&ctx->rcu, testmod_free_cb);
 }
 
+__used __retain void __bpf_testmod_ctx_release(void *ctx)
+{
+	bpf_testmod_ctx_release(ctx);
+}
+
+CFI_NOSEAL(__bpf_testmod_ctx_release);
+
 static struct bpf_testmod_ops3 *st_ops3;
 
 static int bpf_testmod_test_3(void)
@@ -631,7 +638,7 @@ BTF_KFUNCS_END(bpf_testmod_common_kfunc_ids)
 
 BTF_ID_LIST(bpf_testmod_dtor_ids)
 BTF_ID(struct, bpf_testmod_ctx)
-BTF_ID(func, bpf_testmod_ctx_release)
+BTF_ID(func, __bpf_testmod_ctx_release)
 
 static const struct btf_kfunc_id_set bpf_testmod_common_kfunc_set = {
 	.owner = THIS_MODULE,
-- 
2.50.1.470.g6ba607880d-goog


