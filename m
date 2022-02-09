Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8761F4AFB7B
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 19:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240673AbiBISr0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Feb 2022 13:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241146AbiBISqd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Feb 2022 13:46:33 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5BAC03BFF6
        for <bpf@vger.kernel.org>; Wed,  9 Feb 2022 10:43:47 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id j14so4737606lja.3
        for <bpf@vger.kernel.org>; Wed, 09 Feb 2022 10:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ixFgM/dV6WHZoJnxQBJHzIb0ge+sZ4sIjS2A0qNB+sI=;
        b=QvIa4tB80ySgiEJK/seLckPEkEK/dRtG68E8pd+WTel95NcOpmyUHHS1wTiLJ643Fa
         i5FX4TO0ijWikDFzniSWy/VO+VdzxVGMYQpUAe2VlGx2ORWPp7L202MMxPTlln8MZpho
         6yvhfaFJbWPovPIkYpNG65Fk013wJ/MXKmfX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ixFgM/dV6WHZoJnxQBJHzIb0ge+sZ4sIjS2A0qNB+sI=;
        b=gVZgRvHfMxT0chbFZCo5H0b7lsCiykvw31DgT0n4uaegl18LmIlmWVhARLWMJ9nX1t
         lTxwHqwSp5e3uyJ5DzrXPfzQGojgsNP4CgrvfpK1Q6+QmsgKVadcdMvqXZrI1sY8a9Hl
         PKNB439o3UO9Kn4AdwTC5xroOjHFxEQnvcXGbyEq+G9gkmeFoffqh/z4wtTXEZDBHlay
         QSJS8h8h6bbBqSFqdGshg0wUebQ1z7TS2yZ3axyUWLTjzPpZltZd53bU1aW0bP1xANZ0
         dce2a0s7jLP8//FcvfiAo6z5flf6R+KjLuYtn7Lo/rYDSBUbQY53XN3pKf9yMgSTyloK
         t0vA==
X-Gm-Message-State: AOAM530oJndVaQk4HNqtogEM3tNQkyt/cY6AjNl0QT92NwMUkdN3/MfT
        FDtHePN+tk+3l0B+1dHSoNw1d6lCxsAzKg==
X-Google-Smtp-Source: ABdhPJzXCtafQU5ZqmX4+EWkBXxr48P1HBlw6bpR50TrhUFSgXjhhQ9lUYB+mGWzD+6QaMOBmwVPcw==
X-Received: by 2002:a05:651c:1509:: with SMTP id e9mr2377671ljf.347.1644432216015;
        Wed, 09 Feb 2022 10:43:36 -0800 (PST)
Received: from cloudflare.com (2a01-110f-4809-d800-0000-0000-0000-0e00.aa.ipv6.supernova.orange.pl. [2a01:110f:4809:d800::e00])
        by smtp.gmail.com with ESMTPSA id u7sm2593879lju.6.2022.02.09.10.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 10:43:35 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        kernel-team@cloudflare.com, Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Cover 4-byte load from remote_port in bpf_sk_lookup
Date:   Wed,  9 Feb 2022 19:43:33 +0100
Message-Id: <20220209184333.654927-3-jakub@cloudflare.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209184333.654927-1-jakub@cloudflare.com>
References: <20220209184333.654927-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Extend the context access tests for sk_lookup prog to cover the surprising
case of a 4-byte load from the remote_port field, where the expected value
is actually shifted by 16 bits.

Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/include/uapi/linux/bpf.h                     | 3 ++-
 tools/testing/selftests/bpf/progs/test_sk_lookup.c | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index a7f0ddedac1f..afe3d0d7f5f2 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6453,7 +6453,8 @@ struct bpf_sk_lookup {
 	__u32 protocol;		/* IP protocol (IPPROTO_TCP, IPPROTO_UDP) */
 	__u32 remote_ip4;	/* Network byte order */
 	__u32 remote_ip6[4];	/* Network byte order */
-	__u32 remote_port;	/* Network byte order */
+	__be16 remote_port;	/* Network byte order */
+	__u16 :16;		/* Zero padding */
 	__u32 local_ip4;	/* Network byte order */
 	__u32 local_ip6[4];	/* Network byte order */
 	__u32 local_port;	/* Host byte order */
diff --git a/tools/testing/selftests/bpf/progs/test_sk_lookup.c b/tools/testing/selftests/bpf/progs/test_sk_lookup.c
index 83b0aaa52ef7..bf5b7caefdd0 100644
--- a/tools/testing/selftests/bpf/progs/test_sk_lookup.c
+++ b/tools/testing/selftests/bpf/progs/test_sk_lookup.c
@@ -392,6 +392,7 @@ int ctx_narrow_access(struct bpf_sk_lookup *ctx)
 {
 	struct bpf_sock *sk;
 	int err, family;
+	__u32 val_u32;
 	bool v4;
 
 	v4 = (ctx->family == AF_INET);
@@ -418,6 +419,11 @@ int ctx_narrow_access(struct bpf_sk_lookup *ctx)
 	if (LSW(ctx->remote_port, 0) != SRC_PORT)
 		return SK_DROP;
 
+	/* Load from remote_port field with zero padding (backward compatibility) */
+	val_u32 = *(__u32 *)&ctx->remote_port;
+	if (val_u32 != bpf_htonl(bpf_ntohs(SRC_PORT) << 16))
+		return SK_DROP;
+
 	/* Narrow loads from local_port field. Expect DST_PORT. */
 	if (LSB(ctx->local_port, 0) != ((DST_PORT >> 0) & 0xff) ||
 	    LSB(ctx->local_port, 1) != ((DST_PORT >> 8) & 0xff) ||
-- 
2.31.1

