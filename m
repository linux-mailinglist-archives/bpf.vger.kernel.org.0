Return-Path: <bpf+bounces-59483-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39ECAACBF54
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 06:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6F2C16C40E
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 04:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771CD1F4CB3;
	Tue,  3 Jun 2025 04:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wkj9PHgZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6736C1F3D54
	for <bpf@vger.kernel.org>; Tue,  3 Jun 2025 04:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748926109; cv=none; b=TakjDQAylv70AmsryqVQwM0QiNs7SWIkiLSrJ4/IPeR/jnCEQ7MbooVrRyR9kutbEPIzbHYgspq/K2wkwObPmHH1fH0bhemTN1uvoPtGnT6qt4HX+u9krZISueVPyggiqDrMiWe2qKrohyc5TDzBFzz7SOt/W+sXWysvyw6h7U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748926109; c=relaxed/simple;
	bh=BPfcwo6iM0YLjsbV/CSz7wlSKTfOmMZdS9BbV7QcgMs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F/OJPnKZIK/GLALw/PwCNUDPO6zo7J1Lt0gSMxZLfPqfoJvvWfR4vERg9+wi+VAWaoMRVFhlVfNwoWfLLUbFVK7hJH1qfIGXCfOsbxQpj+8YBAbAuoRX/nxuBCN4wCu6TVNVFBJOSqyPn5Dq/kEURwEDN4jNolTeUboiDslazvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wkj9PHgZ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--blakejones.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3122368d82bso7508820a91.0
        for <bpf@vger.kernel.org>; Mon, 02 Jun 2025 21:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748926107; x=1749530907; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tLw45I9yrMKnI+FxaPXVhq/2W0gzoUGdgmBYoc41yS8=;
        b=wkj9PHgZWfeNpn9Bz1kPrSEBGUppDD/ISjfbkIpbn3N7KC81T8sYaODsZNjoVz7yBc
         afz/7bWLyljMqPcMkCAXEoVPJEeNUrfTMVMeuISKsn/6KsjTcKWMWdo1xEGUrhhL6oHE
         xZ3QDvF6opJ17BtimD8MxyPDMAeXjOnrBrxJ/GJ7+UwPhLVun25sSQWy6rbAcCVIBgQ/
         HqcSd7RMgUjuYzVj0d25Aw7UHyLw0LUxRVaDJX7mqfI1A2c66ugI5ZYqG05zfMQzoZnl
         OGDd5BCPmNq1RVFphroKBBb+fWw08Bs1+dEJMYZBUywRw3faRJ5cLaS47VspkJCyu7FI
         UFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748926107; x=1749530907;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tLw45I9yrMKnI+FxaPXVhq/2W0gzoUGdgmBYoc41yS8=;
        b=SwjtuNCsbvvfsSVqSj+iyWSsfMf6I7DbmnP0tvcDcZ/6IE6bzm4s2fmv8N01xA802Q
         HiAF/QNg1LrpPZE4wEh2t0WXxEQMEiIOxVAv93m5lZa8NSdzedlD0VsHiuMf4qs88S/Z
         F7RULBZybw6fWcXXWHZ7eK3CmRhThbq9Q6IXHY7nIxIaRIpNFWuQxz+Yb3XHZ41pT9GD
         1wvAIQf9uxSOXKcfs4dK+gHbknbWKx74IWXJSx65Dl3aW07Hx8vWosWQ7npU0WoelUXN
         KVd4wybrKkUOwFVkYI2pv5vUez+A/6vxeRUSJRCFXUArtpCSmkakOZhyUli8ugcU1Dwz
         pFRA==
X-Forwarded-Encrypted: i=1; AJvYcCUVVkODYCYJkPaps6VwUCjKSgDRRV2Xvdx45bpZ+NwFtLM2SBG3M5YwItBr0CfSluRfDOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRb3P7nhFaIUvnrgOZsRpqK0NFYRa85qf6ZnKUBLLlbmdw8JYm
	KPC3NBPiTNEL/gjbjRcxBJseCTMGRVFZ322GT060z06HZAPbBMSZYardF/Q5S6mKcUTCbN4mT5f
	WQiHh+54k6uluY0xrPQu5SA==
X-Google-Smtp-Source: AGHT+IFnfGAUx2D0cf7iKTQVmpBlHYmaqb7e7oimRJuGD2RACVW8VRe6L81j78ZHzX+NQycr9MMOUvMu8P4vJOQI
X-Received: from pjbss4.prod.google.com ([2002:a17:90b:2ec4:b0:311:2058:21e7])
 (user=blakejones job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1a8d:b0:311:f05b:869a with SMTP id 98e67ed59e1d1-312503580eemr20217276a91.8.1748926106683;
 Mon, 02 Jun 2025 21:48:26 -0700 (PDT)
Date: Mon,  2 Jun 2025 21:48:13 -0700
In-Reply-To: <20250603044813.88265-1-blakejones@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250603044813.88265-1-blakejones@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250603044813.88265-2-blakejones@google.com>
Subject: [PATCH v2 2/2] Tests for the ".emit_strings" functionality in the BTF dumper.
From: Blake Jones <blakejones@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Blake Jones <blakejones@google.com>
Content-Type: text/plain; charset="UTF-8"

When this mode is turned on, "emit_zeroes" and "compact" have no effect,
and embedded NUL characters always terminate printing of an array.

Signed-off-by: Blake Jones <blakejones@google.com>
---
 .../selftests/bpf/prog_tests/btf_dump.c       | 106 ++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
index c0a776feec23..2fde118d04c8 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@ -879,6 +879,110 @@ static void test_btf_dump_var_data(struct btf *btf, struct btf_dump *d,
 			  "static int bpf_cgrp_storage_busy = (int)2", 2);
 }
 
+struct btf_dump_string_ctx {
+	struct btf *btf;
+	struct btf_dump *d;
+	char *str;
+	struct btf_dump_type_data_opts *opts;
+	int array_id;
+};
+
+static int btf_dump_one_string(struct btf_dump_string_ctx *ctx,
+			       char *ptr, size_t ptr_sz,
+			       const char *expected_val)
+{
+	size_t type_sz;
+	int ret;
+
+	ctx->str[0] = '\0';
+	type_sz = btf__resolve_size(ctx->btf, ctx->array_id);
+	ret = btf_dump__dump_type_data(ctx->d, ctx->array_id, ptr, ptr_sz, ctx->opts);
+	if (type_sz <= ptr_sz) {
+		if (!ASSERT_EQ(ret, type_sz, "failed/unexpected type_sz"))
+			return -EINVAL;
+	} else {
+		if (!ASSERT_EQ(ret, -E2BIG, "failed to return -E2BIG"))
+			return -EINVAL;
+	}
+	if (!ASSERT_STREQ(ctx->str, expected_val, "ensure expected/actual match"))
+		return -EFAULT;
+	return 0;
+}
+
+static void btf_dump_strings(struct btf_dump_string_ctx *ctx)
+{
+	struct btf_dump_type_data_opts *opts = ctx->opts;
+
+	opts->emit_strings = true;
+
+	opts->compact = true;
+	opts->emit_zeroes = false;
+
+	opts->skip_names = false;
+	btf_dump_one_string(ctx, "foo", 4, "(char[4])\"foo\"");
+
+	opts->skip_names = true;
+	btf_dump_one_string(ctx, "foo", 4, "\"foo\"");
+
+	/* This should have no effect. */
+	opts->emit_zeroes = false;
+	btf_dump_one_string(ctx, "foo", 4, "\"foo\"");
+
+	/* This should have no effect. */
+	opts->compact = false;
+	btf_dump_one_string(ctx, "foo", 4, "\"foo\"");
+
+	/* Non-printable characters come out as hex. */
+	btf_dump_one_string(ctx, "fo\xff", 4, "\"fo\\xff\"");
+	btf_dump_one_string(ctx, "fo\x7", 4, "\"fo\\x07\"");
+
+	/* Should get printed properly even though there's no NUL. */
+	char food[4] = { 'f', 'o', 'o', 'd' };
+
+	btf_dump_one_string(ctx, food, 4, "\"food\"");
+
+	/* The embedded NUL should terminate the string. */
+	char embed[4] = { 'f', 'o', '\0', 'd' };
+
+	btf_dump_one_string(ctx, embed, 4, "\"fo\"");
+}
+
+static void test_btf_dump_string_data(void)
+{
+	struct test_ctx t = {};
+	char str[STRSIZE];
+	struct btf_dump *d;
+	DECLARE_LIBBPF_OPTS(btf_dump_type_data_opts, opts);
+	struct btf_dump_string_ctx ctx;
+	int char_id, int_id, array_id;
+
+	if (test_ctx__init(&t))
+		return;
+
+	d = btf_dump__new(t.btf, btf_dump_snprintf, str, NULL);
+	if (!ASSERT_OK_PTR(d, "could not create BTF dump"))
+		return;
+
+	/* Generate BTF for a four-element char array. */
+	char_id = btf__add_int(t.btf, "char", 1, BTF_INT_CHAR);
+	ASSERT_EQ(char_id, 1, "char_id");
+	int_id = btf__add_int(t.btf, "int", 4, BTF_INT_SIGNED);
+	ASSERT_EQ(int_id, 2, "int_id");
+	array_id = btf__add_array(t.btf, int_id, char_id, 4);
+	ASSERT_EQ(array_id, 3, "array_id");
+
+	ctx.btf = t.btf;
+	ctx.d = d;
+	ctx.str = str;
+	ctx.opts = &opts;
+	ctx.array_id = array_id;
+
+	btf_dump_strings(&ctx);
+
+	btf_dump__free(d);
+	test_ctx__free(&t);
+}
+
 static void test_btf_datasec(struct btf *btf, struct btf_dump *d, char *str,
 			     const char *name, const char *expected_val,
 			     void *data, size_t data_sz)
@@ -970,6 +1074,8 @@ void test_btf_dump() {
 		test_btf_dump_struct_data(btf, d, str);
 	if (test__start_subtest("btf_dump: var_data"))
 		test_btf_dump_var_data(btf, d, str);
+	if (test__start_subtest("btf_dump: string_data"))
+		test_btf_dump_string_data();
 	btf_dump__free(d);
 	btf__free(btf);
 
-- 
2.49.0.1204.g71687c7c1d-goog


