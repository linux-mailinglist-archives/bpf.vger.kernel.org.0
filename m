Return-Path: <bpf+bounces-44302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BD19C113F
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 22:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C66C01F24E64
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 21:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84B721892F;
	Thu,  7 Nov 2024 21:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=epfl.ch header.i=@epfl.ch header.b="ws37LnI8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp5.epfl.ch (smtp5.epfl.ch [128.178.224.8])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF702185A8
	for <bpf@vger.kernel.org>; Thu,  7 Nov 2024 21:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.178.224.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731016079; cv=none; b=r6//R1kD2VJlUwv4d41/3bEV6wg6c2qmRoGdKm0+HEBOnzHYICNUNsvAuNeua6RUAvpWc3tA2yZvl+Oz6ZOZGeLo/Ch0H0XNgvnkdHRUCmJZjLs+Rk6y6py/d2BAwclJhINCmbUF5S2CvsAziXjz6VXCT4h8tjHit67XmyWvFDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731016079; c=relaxed/simple;
	bh=jdPj7QSU++jGS5CNJZcnDyWKnxQWmvx2ow4QQemaTfk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EPV2EAiB5vbReH1c6kEXsKw0NqnvZ3KlIrZNIpsy9tomuZJmXOzehLedaO55iuaR3cPooFnMYceBFTwHL16qEuqgIZrWr2/NBpqiCvQ6O6x4zYsyEby9itK8g4NfzbhlSsg42uRnCZFVBJv1rGTeARiZQzjd5egqk8wxL2BhWu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epfl.ch; spf=pass smtp.mailfrom=epfl.ch; dkim=pass (1024-bit key) header.d=epfl.ch header.i=@epfl.ch header.b=ws37LnI8; arc=none smtp.client-ip=128.178.224.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epfl.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epfl.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epfl.ch;
      s=epfl; t=1731016069;
      h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Content-Type;
      bh=jdPj7QSU++jGS5CNJZcnDyWKnxQWmvx2ow4QQemaTfk=;
      b=ws37LnI8rKHwXrQrvWzkngCsOUrvhy68KOl+XqUCXwkpwHowCuSMfxoreLDaO2Tu/
        Vapr7b3BMJ0mChQFNYY2zzGTbqTsVGRYF8kEwz4G7G2aRtituezVtruj5m9vLrQeR
        w1yjAkX7XBMKZUs33/3FIREmRhvic4I5U4+ejVclE=
Received: (qmail 5136 invoked by uid 107); 7 Nov 2024 21:47:49 -0000
Received: from ax-snat-224-178.epfl.ch (HELO ewa07.intranet.epfl.ch) (192.168.224.178) (TLS, ECDHE-RSA-AES256-GCM-SHA384 (P-256 curve) cipher)
  by mail.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPS; Thu, 07 Nov 2024 22:47:49 +0100
X-EPFL-Auth: D2/sjICR6gH59LaPuXEZhDyzqpPWxeecltJSmjS3jlOLqMXQHsg=
Received: from rs3labsrv2.iccluster.epfl.ch (10.90.46.62) by
 ewa07.intranet.epfl.ch (128.178.224.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 7 Nov 2024 22:47:49 +0100
From: Tao Lyu <tao.lyu@epfl.ch>
To: <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<song@kernel.org>, <yonghong.song@linux.dev>, <haoluo@google.com>,
	<martin.lau@linux.dev>
CC: <bpf@vger.kernel.org>, Tao Lyu <tao.lyu@epfl.ch>
Subject: [PATCH 1/2] bpf: Check if iter args are stack pointers
Date: Thu, 7 Nov 2024 22:47:35 +0100
Message-ID: <20241107214736.347630-2-tao.lyu@epfl.ch>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241107214736.347630-1-tao.lyu@epfl.ch>
References: <20241107214736.347630-1-tao.lyu@epfl.ch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ewa04.intranet.epfl.ch (128.178.224.170) To
 ewa07.intranet.epfl.ch (128.178.224.178)

The verifier misses the type checking on iter arguments,
so any pointer types (e.g., map value pointers) can be passed
as iter arguments.

We fix this issue by adding a type check to ensure the passed
iter arguments are in the type of PTR_TO_STACK.

Fixes: 06accc8779c1 ("bpf: add support for open-coded iterator loops")
Signed-off-by: Tao Lyu <tao.lyu@epfl.ch>
---
 kernel/bpf/verifier.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 797cf3ed32e0..98afdcecefbc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12234,6 +12234,11 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 					return -EINVAL;
 				}
 			}
+			/* Ensure the iter arg is a stack pointer */
+			if (reg->type != PTR_TO_STACK) {
+				verbose(env, "arg#%d expected pointer to the iterator\n", i);
+				return -EINVAL;
+			}
 			ret = process_iter_arg(env, regno, insn_idx, meta);
 			if (ret < 0)
 				return ret;
-- 
2.34.1


