Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 063C91F1EF5
	for <lists+bpf@lfdr.de>; Mon,  8 Jun 2020 20:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgFHS1z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Jun 2020 14:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgFHS1x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Jun 2020 14:27:53 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07807C08C5C2
        for <bpf@vger.kernel.org>; Mon,  8 Jun 2020 11:27:53 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id r17so4727008ybj.22
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2020 11:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fWMhfsU1kpXcRspHEW05AJsH85CBbMas3Sflgg/1rK4=;
        b=WNyNUHdUBzmrvLqCnPSfeWSMk3wOZ7w46VOXGlCosdgePbx29dykt18yWhUOUlsCe7
         6c01ZnNu036dS6UrGDTVMC40XnxX/+TpHdYWkWjlvmvcMsA68QkRmTfNQps5G7GjsCTW
         Lyn/t/HVje04wIRZeDoIbpPAbLzJf3XKWXxX9nePYZ8wCp/obTcT6YGIUXhWxGtfwOmD
         XfJzpl6DFq5SHPj3elyeoj6OlBCzNhRdrFbyOI3lwJIxlrjjqGpWEYCB4dsIEalutl0o
         miS3t+wYkKQMgDmlPazsYswLgLpiczof6W0gTRrPX5iBMu9pPwwRPTMEw3st5hsLVJy6
         BhXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fWMhfsU1kpXcRspHEW05AJsH85CBbMas3Sflgg/1rK4=;
        b=cR7gdxXO1CkFX0zVOr2jvRtYJP6YkhmlAG6ubjChhO41gYEQSvsBTs3iUXDcly8H+f
         d/1ouMlon9RnmPH2o2qaQl/tSf2Qxl3IocHAa3NFMRVk3NhrU5lRCSto6spB1ud1/yHa
         TvHCVjd9nAHvhRgPZn/JtPojZFJoQYjRuquzrIbA/DNFuoZq3OBY5KIKTU/nxgHTuJMY
         95Bzzh66dnHXk++cLkIO4D3b5kEovK/pvLBCRlGODl+lnFFlxRmx6iuXY81p4X30s2R1
         0lbk3F0IqqLmNHgFjvNanWC0wfshr5+bTgF9Z6DaQQa1lQl3+YFus44LhyQZISQTvW+I
         T9nQ==
X-Gm-Message-State: AOAM530RLgZyQTZy+neBWQNBGHTSzoSAjkWtc3L3wmBjr6nYjUFGOo/N
        WfMIO15/7JJ38sRHb5PFMys+PI4=
X-Google-Smtp-Source: ABdhPJyWpX7e0/irpxfjOj7CUst/B5B69J1pIOPZaSBL8PK0U2fa/cRLDLWGlVQ9RpAtmVTuAvP3TdY=
X-Received: by 2002:a25:eb05:: with SMTP id d5mr132497ybs.12.1591640872209;
 Mon, 08 Jun 2020 11:27:52 -0700 (PDT)
Date:   Mon,  8 Jun 2020 11:27:48 -0700
In-Reply-To: <20200608182748.6998-1-sdf@google.com>
Message-Id: <20200608182748.6998-2-sdf@google.com>
Mime-Version: 1.0
References: <20200608182748.6998-1-sdf@google.com>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH bpf v3 2/2] selftests/bpf: make sure optvals > PAGE_SIZE are bypassed
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We are relying on the fact, that we can pass > sizeof(int) optvals
to the SOL_IP+IP_FREEBIND option (the kernel will take first 4 bytes).
In the BPF program, we return EPERM if optval is greater than optval_end
(implemented via PTR_TO_PACKET/PTR_TO_PACKET_END) and rely on the verifier
to enforce the fact that this data can not be touched.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 .../selftests/bpf/prog_tests/sockopt_sk.c     | 26 +++++++++++++++++++
 .../testing/selftests/bpf/progs/sockopt_sk.c  | 20 ++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
index 2061a6beac0f..eae1c8a1fee0 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
@@ -13,6 +13,7 @@ static int getsetsockopt(void)
 		char cc[16]; /* TCP_CA_NAME_MAX */
 	} buf = {};
 	socklen_t optlen;
+	char *big_buf;
 
 	fd = socket(AF_INET, SOCK_STREAM, 0);
 	if (fd < 0) {
@@ -78,6 +79,31 @@ static int getsetsockopt(void)
 		goto err;
 	}
 
+	/* IP_FREEBIND - BPF can't access optval when optlen > PAGE_SIZE */
+
+	optlen = getpagesize() * 2;
+	big_buf = calloc(1, optlen);
+	if (!big_buf) {
+		log_err("Couldn't allocate two pages");
+		goto err;
+	}
+
+	err = setsockopt(fd, SOL_IP, IP_FREEBIND, big_buf, optlen);
+	if (err != 0) {
+		log_err("Failed to call setsockopt, ret=%d", err);
+		free(big_buf);
+		goto err;
+	}
+
+	err = getsockopt(fd, SOL_IP, IP_FREEBIND, big_buf, &optlen);
+	if (err != 0) {
+		log_err("Failed to call getsockopt, ret=%d", err);
+		free(big_buf);
+		goto err;
+	}
+
+	free(big_buf);
+
 	/* SO_SNDBUF is overwritten */
 
 	buf.u32 = 0x01010101;
diff --git a/tools/testing/selftests/bpf/progs/sockopt_sk.c b/tools/testing/selftests/bpf/progs/sockopt_sk.c
index d5a5eeb5fb52..933a2ef9c930 100644
--- a/tools/testing/selftests/bpf/progs/sockopt_sk.c
+++ b/tools/testing/selftests/bpf/progs/sockopt_sk.c
@@ -51,6 +51,16 @@ int _getsockopt(struct bpf_sockopt *ctx)
 		return 1;
 	}
 
+	if (ctx->level == SOL_IP && ctx->optname == IP_FREEBIND) {
+		if (optval > optval_end) {
+			/* For optval > PAGE_SIZE, the actual data
+			 * is not provided.
+			 */
+			return 0; /* EPERM, unexpected data size */
+		}
+		return 1;
+	}
+
 	if (ctx->level != SOL_CUSTOM)
 		return 0; /* EPERM, deny everything except custom level */
 
@@ -112,6 +122,16 @@ int _setsockopt(struct bpf_sockopt *ctx)
 		return 1;
 	}
 
+	if (ctx->level == SOL_IP && ctx->optname == IP_FREEBIND) {
+		if (optval > optval_end) {
+			/* For optval > PAGE_SIZE, the actual data
+			 * is not provided.
+			 */
+			return 0; /* EPERM, unexpected data size */
+		}
+		return 1;
+	}
+
 	if (ctx->level != SOL_CUSTOM)
 		return 0; /* EPERM, deny everything except custom level */
 
-- 
2.27.0.278.ge193c7cf3a9-goog

