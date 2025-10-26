Return-Path: <bpf+bounces-72246-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49908C0A99F
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 15:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E55F18A1BBB
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 14:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A77263F36;
	Sun, 26 Oct 2025 14:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="SCi3Z3Uc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41882EBBAD
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 14:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761488341; cv=none; b=rMc7hMhbfaEviW0CA/MEh22yMb+dEUeVDrqWb9cccWCuC/i4V7USmM7IJLZmvTkeHPUOtbXoYG4g5vD/P9sVqjuoIoczf1aSPNMKWba1CSUuWJJupGrpZQ2KdVttC2gaDqvBa16M46NtLKEZXmDkFNOHxORbFcPkWKfInWoeSek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761488341; c=relaxed/simple;
	bh=rZB0D5lU4hPSx7eOKffaSxhoQpW9i+v4/2uc4+gKerM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RfAy85xb+4C/eKbomDYYGviy8byoeOBzoFHqkhtktnaaG0kGbxHhU4hjxs2W9vKcn+alj++tduBohLrqNZgLMrxkwkarp03d2zpc69IauEvy4sFW399v75RaCKgX30yGNSJs7pFPWyZjzUW64sVxmca/BOrGp/Y4EwXQKeSjvDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=SCi3Z3Uc; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b6d83bf1077so327914066b.3
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 07:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1761488338; x=1762093138; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oTW2Nhp6r5vZi19YO345NcsgOGp3VdDovRh/l2yqd2A=;
        b=SCi3Z3UchV8slNkpQqmcU8HL0Uysw4Vh4Ucyk44uGDXQOsy4si65KODh8FktMDH6Rx
         iFqERCMZsilRRN77dvVp9NqLX43fymq53AZafj7cAh62KfP51HRHcYIMHbc54TPTaetX
         +HtDfTEF9uBJWl7upu0J81WjgwyoWCPaJCeSymcav5HiWwpNmGqdGYhD99P0Qigby3bC
         /DaujVoxbkgiqvbTIE9COQuu7R+v9KVtktaPOE/eEbGQTHmYe2wwkmaNmzD2MPJOjWLO
         hNXqU05u84Adwqpdnollc6J4fxQVLrU+FjZlqTaS9q+Bh48xhmpDDCS21aeVn8BZLt+C
         ZvHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761488338; x=1762093138;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oTW2Nhp6r5vZi19YO345NcsgOGp3VdDovRh/l2yqd2A=;
        b=mh0PE6triAuE2PmNLxClfiCFNFB8lwLUtXYYrPs1FS1J2YGwDtoTZgWys/DwEL/Rec
         LXI6EtC++/iGvqopxPQSlcFH13+e2cyW3EFbL3rMqqNEdMdoPRHloFUtdC+RYs0Li1eo
         gm2rxwpbhtmjkq8m8Xd/D+vnkkPcKboPbkXp8Zpi/jbJan8vqS2c9Rw80brmiefF7T6L
         /bG83oEA7/ZHZihQY0vJPM273ncC6J3RIVf4fG9M0RASfyR4gR05CPMOd5Xs4Qy3smRp
         xdzDN1tajMDq5y10vJCpSVLzvZgbpUni2Tsl8S2+NxkD8MUTFI2wJUtkOCavOlxO+VsI
         X6Tg==
X-Gm-Message-State: AOJu0YxRC1jVDO1XAiLGNgtv8hmWMvJAFz7eZ6PyKZtKWfQ/EgO+w9UV
	bZSRZAgoOTV9BTg3HPyNophUUw9Pw+itLdNyiMVnOhyOclIXdIzLl34kzv7gbJ8JtLI=
X-Gm-Gg: ASbGncuPB+pLWUvdWuUTtT0ew7t38YzMe9GOSPn2EDTSIiHmfDDy67rDCzUR6GZdfDy
	SJ4bwkFVUokJQ4l0upnpP+JQq8xsFBNMjGwdGXvVuPScE+7hCQ53wwZ3xazGSzfw5cjWesIRZR6
	bmTj6w2VEAzZOsUPixtFl2NV3S1ol4zcvFXVUZteDYRmtrUxVIzJ6kVHwMwhg2fbZLhSM/vYUKl
	Uk19oyuK1D/mFwlRwGe6CKpAzlH/v7czZFcpxDzGm1MLEyNoq/vu6mX8zZZ7+YPowZLtn+NOJft
	ujlSHBZm4RuuTwS+pY41RQDfv7DdJU0CPWWKdj1a/u3RZNXO8exqS4gkQHeA31YqxrLrNujfEUL
	AUi0mWAU6jyRiKDLPWeu0/+kdhSaoK4Zi7Gn1kNJ0Q5UJ4DVkydY87LDk+z0rFdCdDGlPn8LsJg
	EeqyxOslyF1d6yhf31/5yATbkFBxAtr1aHj3jEQSBqikc4ssQ6QP5SAFPk
X-Google-Smtp-Source: AGHT+IEEbFr0V/GE6v2r0lg3Q9QrsOpLTkFBWMuQRCwpPocKiOv3FzGIIkvZXbu1DlMUSzaVY3ME+Q==
X-Received: by 2002:a17:907:a03:b0:b54:25dc:a644 with SMTP id a640c23a62f3a-b647453ff17mr3849029766b.60.1761488338045;
        Sun, 26 Oct 2025 07:18:58 -0700 (PDT)
Received: from cloudflare.com (79.184.211.13.ipv4.supernova.orange.pl. [79.184.211.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853edc87sm475912466b.46.2025.10.26.07.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 07:18:57 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sun, 26 Oct 2025 15:18:35 +0100
Subject: [PATCH bpf-next v3 15/16] selftests/bpf: Cover skb metadata access
 after change_head/tail helper
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251026-skb-meta-rx-path-v3-15-37cceebb95d3@cloudflare.com>
References: <20251026-skb-meta-rx-path-v3-0-37cceebb95d3@cloudflare.com>
In-Reply-To: <20251026-skb-meta-rx-path-v3-0-37cceebb95d3@cloudflare.com>
To: bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

Add a test to verify that skb metadata remains accessible after calling
bpf_skb_change_head() and bpf_skb_change_tail(), which modify packet
headroom/tailroom and can trigger head reallocation.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          |  5 ++++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 34 ++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index a3b82cf2f9e9..65735a134abb 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -497,6 +497,11 @@ void test_xdp_context_tuntap(void)
 			    skel->progs.helper_skb_adjust_room,
 			    NULL, /* tc prio 2 */
 			    &skel->bss->test_pass);
+	if (test__start_subtest("helper_skb_change_head_tail"))
+		test_tuntap(skel->progs.ing_xdp,
+			    skel->progs.helper_skb_change_head_tail,
+			    NULL, /* tc prio 2 */
+			    &skel->bss->test_pass);
 
 	test_xdp_meta__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_meta.c b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
index 29fe4aa9ec76..2fd95b80c3ef 100644
--- a/tools/testing/selftests/bpf/progs/test_xdp_meta.c
+++ b/tools/testing/selftests/bpf/progs/test_xdp_meta.c
@@ -611,4 +611,38 @@ int helper_skb_adjust_room(struct __sk_buff *ctx)
 	return TC_ACT_SHOT;
 }
 
+SEC("tc")
+int helper_skb_change_head_tail(struct __sk_buff *ctx)
+{
+	int err;
+
+	/* Reserve 1 extra in the front for packet data */
+	err = bpf_skb_change_head(ctx, 1, 0);
+	if (err)
+		goto out;
+
+	if (!check_skb_metadata(ctx))
+		goto out;
+
+	/* Reserve 256 extra bytes in the front to trigger head reallocation */
+	err = bpf_skb_change_head(ctx, 256, 0);
+	if (err)
+		goto out;
+
+	if (!check_skb_metadata(ctx))
+		goto out;
+
+	/* Reserve 4k extra bytes in the back to trigger head reallocation */
+	err = bpf_skb_change_tail(ctx, ctx->len + 4096, 0);
+	if (err)
+		goto out;
+
+	if (!check_skb_metadata(ctx))
+		goto out;
+
+	test_pass = true;
+out:
+	return TC_ACT_SHOT;
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.43.0


