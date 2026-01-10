Return-Path: <bpf+bounces-78456-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E167D0D32E
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 09:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2B8F43014755
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 08:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0762E2DEA61;
	Sat, 10 Jan 2026 08:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1aUYk9bM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD6C4A02
	for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 08:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768033571; cv=none; b=QjEsRyleFoi5TGGQIbkfyC49khCLzqdFrXhUi8eJh16gMlcRpZkHjP0KAE85dlphy0fdDb8rZ3V+vTHZn2OnrOS4b7dqzlTYqzKrep72M+RsjarZGkrU7qoBSeAGb4QWxut9qa0m0xk8ZtbdzSCydaH2xyZQdFEfjqs9uDAANLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768033571; c=relaxed/simple;
	bh=fU9tXtVUuvz++hhVpv6nOf14ncQA9HihGffXc9Blti4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K9JlxyzN7bVMs/69AyY4sIDkP+NsM+IWRi3ViQD98fBvFdGIe9S4C1HsderbCDNDCljsxHyp4nl0LqmoSvOwDc+t+fdmEpPlOGKA9ocLCHgWDgDGcGChVmL7b8QisquuL7JBCGk6plqQLHzS4o43Pup5gAFOCSrTflS8Pw54x58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1aUYk9bM; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2b0751d8de7so6545039eec.1
        for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 00:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768033560; x=1768638360; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PZhkoiS2Eo/kq3Cli8CQX1phFsPCl4naA/gjIFzyLV8=;
        b=1aUYk9bMCBtiYbJSy8auWrAI2DyPvbN+xBIkVdWjy+Ppe3JPx1TqgTU1UL0Zz0t2W1
         xXyRSkgXR1uprPKNStP19RBOLEKEolshdB0V3J7HrNPS6gWzXDT03JDuhzBeoWWkW9Qo
         Z9u4XB+b2ZMB+afa0CymDJpgDPjnPVoDZ/ZHM9Az7TAZVFDCLEbw4oF5gM4P2GlrlYwf
         K6yLJRRq2oRqB2T1+6vzG92FaBJ2nxPWY8qG0wUhAZOtvUGleoSo5s5GpA/ILwLWXtaF
         7LZ9TJJrLloXwGIIuy1eDeVflrM/l5VtgoZ8qUVwy4meTDHJ/TqUMm2A1f2JD87xf/fy
         iiWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768033560; x=1768638360;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PZhkoiS2Eo/kq3Cli8CQX1phFsPCl4naA/gjIFzyLV8=;
        b=eBPAtC/T22KKiw3ZA00LiLzIG6scJ2MBkWgf14BdpGyB5TNZhIhc8WipgLX5hTYMwQ
         QfZdJZU4PuWQqMxvHIyfcdViEjOKc2ZigEHTJ8TJi+3AZjYAS/s2uNmaNv3ATcM55N14
         41ggWsrIAEqPXpTbr/YrD6OBNTV1ln6CNbVaytKZFWGvaKSPNiFlpS/f9UGPuE7JfUlH
         OsrFFxnkKH0HCOvzBw3TDt5SH4msR67Q+GzLIDHbH2xqaSRCZkTa9nxhVLnYvkVussEK
         UXG6wsIy4bVX0/hX5ngDWy5S3DiD6MMmyYef026c6qEGkPi2iF9vRddA5+53+BEILG3p
         kZ8g==
X-Gm-Message-State: AOJu0Yx4kUEOvhvlCjMA2MO0ey2azl7lakDqbg8OqX/Yxmb9MLe61gyw
	g2JMPq/ClSRihSeAWZAkrBt2vi8zbKEsuLRDQo4Fdu0LcvRqzEpu7cKxfM0J9yUM0tr4zTS7hu1
	96kLxYb/qHepO3CILIR67Zls21ibYHPIRO/gKJvAd1Lp0d/WYzRi/IfyC3aAeai4YEG5Y0g3NQE
	tTO9s0ucCKuSFnyiO0W68+/Nso7TBV/Atti+MYjAttXnEYKP7rRWjCO3pZGD+7YYyG
X-Google-Smtp-Source: AGHT+IG9YKCSq7wS7f0FWH0qnCPG7v4Hjw/ILCg0+RfetXQsjFo9F+6oxi8SmQfwivw3ZF8EVRkWhSbDDRqzXAdk+xg=
X-Received: from dycog7.prod.google.com ([2002:a05:7301:9a87:b0:2ae:3278:d74f])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:e9d9:20b0:2b0:582e:fe51 with SMTP id 5a478bee46e88-2b17d2a841dmr7814723eec.20.1768033560093;
 Sat, 10 Jan 2026 00:26:00 -0800 (PST)
Date: Sat, 10 Jan 2026 08:25:52 +0000
In-Reply-To: <20260110082548.113748-6-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260110082548.113748-6-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1607; i=samitolvanen@google.com;
 h=from:subject; bh=fU9tXtVUuvz++hhVpv6nOf14ncQA9HihGffXc9Blti4=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDJlJvHwP4ydbut2RMjnQ9ODCnS2OKqy+lja+XC473u2V/
 rt9QYdSRykLgxgXg6yYIkvL19Vbd393Sn31uUgCZg4rE8gQBi5OAZiIziVGho2HN68R23FxSueL
 Hab7bx5u1xBQ2VO556dvY/lcnR5Z72SG/xn92xL+WF+wn8H//Vi40D6OmGk7HFhWpV5am8jbL5f yiQMA
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260110082548.113748-9-samitolvanen@google.com>
Subject: [PATCH bpf-next v5 3/4] selftests/bpf: Use the correct destructor
 kfunc type
From: Sami Tolvanen <samitolvanen@google.com>
To: bpf@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Viktor Malik <vmalik@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

With CONFIG_CFI enabled, the kernel strictly enforces that indirect
function calls use a function pointer type that matches the target
function. As bpf_testmod_ctx_release() signature differs from the
btf_dtor_kfunc_t pointer type used for the destructor calls in
bpf_obj_free_fields(), add a stub function with the correct type to
fix the type mismatch.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/test_kmods/bpf_testmod.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 1c41d03bd5a1..bc07ce9d5477 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -285,6 +285,12 @@ __bpf_kfunc void bpf_testmod_ctx_release(struct bpf_testmod_ctx *ctx)
 		call_rcu(&ctx->rcu, testmod_free_cb);
 }
 
+__bpf_kfunc void bpf_testmod_ctx_release_dtor(void *ctx)
+{
+	bpf_testmod_ctx_release(ctx);
+}
+CFI_NOSEAL(bpf_testmod_ctx_release_dtor);
+
 static struct bpf_testmod_ops3 *st_ops3;
 
 static int bpf_testmod_test_3(void)
@@ -707,7 +713,7 @@ BTF_KFUNCS_END(bpf_testmod_common_kfunc_ids)
 
 BTF_ID_LIST(bpf_testmod_dtor_ids)
 BTF_ID(struct, bpf_testmod_ctx)
-BTF_ID(func, bpf_testmod_ctx_release)
+BTF_ID(func, bpf_testmod_ctx_release_dtor)
 
 static const struct btf_kfunc_id_set bpf_testmod_common_kfunc_set = {
 	.owner = THIS_MODULE,
-- 
2.52.0.457.g6b5491de43-goog


