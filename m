Return-Path: <bpf+bounces-168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BCA6F8D9A
	for <lists+bpf@lfdr.de>; Sat,  6 May 2023 03:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 360141C21AC9
	for <lists+bpf@lfdr.de>; Sat,  6 May 2023 01:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740DF15C0;
	Sat,  6 May 2023 01:31:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9D915B2
	for <bpf@vger.kernel.org>; Sat,  6 May 2023 01:31:52 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A2F49E7
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 18:31:50 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-55d9a998c5aso20543537b3.0
        for <bpf@vger.kernel.org>; Fri, 05 May 2023 18:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683336709; x=1685928709;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QbTxYJIrfalCYzXyCjhhSUmz67kNheh66aN+akhEHWk=;
        b=WWOk88G3muNiSEyLCZtTBwJIQa2OocJuIlljADwsm82KPk2youo8Bi6hAN/nXReTz0
         7r1uI7jxcjSqbZ92pFC1GjUhvhjNVjuK8o7y0Z//QAswGFhvfniUWRhLj4P18q9LvU8V
         XyQOfhD7n7W/99oHPcNTQokqvOCzPLrYlR7puhjDO/d1m6Mk6UKEtSpSmNeHA/O3TCd2
         oKUZs5gi7Nzjto/r3S5LSTSvgNBNHBCd2hRT0VWn12Qcjs8M0lHnqbGFxux3WL3ApZCM
         1KStVH5+p8h02nzto4SrF74lR+4I0PyarTp6k5Ri8qKg9/8/1guA+bDNz4G0PytGNsQK
         SlLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683336709; x=1685928709;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QbTxYJIrfalCYzXyCjhhSUmz67kNheh66aN+akhEHWk=;
        b=XACTsUcalGOqLUSPS3gQTAicqauje5GILSNkr5JQ0OhvbwmIwdZ9asRKE13Nbry313
         3Xw6xSuAxhUFO11OKhRJ+9jKB8pPNv6ouzIp3w07EpjKH24JANLsBLNtEetcpKzAvr7d
         kOc2HWcdozviYldLz4H/BfUThAC/ej1G7iOYWEakH+O/FHUFlpNAnB8SmnYwSEOnwgDu
         KlPyvGxClv3UQgVJkFDoe0ox7hrA1Jf1apNfIj/6j2YgKzt1JrZcq5fxk7yjTLUwYi51
         SWDUE1o3lTBSdgWC5y7SadOWI2nW6koIbywUkdBdD5UIP7+stbeP7Y6N3EcJCxpV+txC
         gy9g==
X-Gm-Message-State: AC+VfDwPT3QANA3loD59wmHZXAz/C3WBe3JpdNQ8czk20yuwusU4/y8l
	Ztzs2lu0b2StsBHRdsVG8t1q5yoScHJmrRySIiALcf8gz7OMCDKZU7wrVlUt/EoIYjpjEZqF4MC
	K2oT/yAXCEIsecM48+iHAia1NI0YpnU3coiBrZU1ShismeL4B/fSBcvY/Mw==
X-Google-Smtp-Source: ACHHUZ6+bMT2qUE8qYexYzBwG/ZiwbW6htxo82gL8HL5nwFwc0TUdqnY1SZ54LMlE1W2qQdKF+FLUEIx5KU=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:6826:a1a:a426:bb4a])
 (user=drosen job=sendgmr) by 2002:a81:4045:0:b0:55a:613d:429f with SMTP id
 m5-20020a814045000000b0055a613d429fmr1922195ywn.2.1683336709283; Fri, 05 May
 2023 18:31:49 -0700 (PDT)
Date: Fri,  5 May 2023 18:31:32 -0700
In-Reply-To: <20230506013134.2492210-1-drosen@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230506013134.2492210-1-drosen@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230506013134.2492210-4-drosen@google.com>
Subject: [PATCH bpf-next v3 3/5] selftests/bpf: Check overflow in optional buffer
From: Daniel Rosenberg <drosen@google.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Joanne Koong <joannelkoong@gmail.com>, Mykola Lysenko <mykolal@fb.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This ensures we still reject invalid memory accesses in buffers that are
marked optional.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 .../testing/selftests/bpf/progs/dynptr_fail.c | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index efe4ce72d00e..c2f0e18af951 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -1665,3 +1665,23 @@ int clone_xdp_packet_data(struct xdp_md *xdp)
 
 	return 0;
 }
+
+/* Buffers that are provided must be sufficiently long */
+SEC("?cgroup_skb/egress")
+__failure __msg("memory, len pair leads to invalid memory access")
+int test_dynptr_skb_small_buff(struct __sk_buff *skb)
+{
+	struct bpf_dynptr ptr;
+	char buffer[8] = {};
+	__u64 *data;
+
+	if (bpf_dynptr_from_skb(skb, 0, &ptr)) {
+		err = 1;
+		return 1;
+	}
+
+	/* This may return NULL. SKB may require a buffer */
+	data = bpf_dynptr_slice(&ptr, 0, buffer, 9);
+
+	return !!data;
+}
-- 
2.40.1.521.gf1e218fcd8-goog


