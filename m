Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0203EBE8A
	for <lists+bpf@lfdr.de>; Sat, 14 Aug 2021 01:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbhHMXGH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Aug 2021 19:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235428AbhHMXGF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Aug 2021 19:06:05 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7A1C061756
        for <bpf@vger.kernel.org>; Fri, 13 Aug 2021 16:05:38 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id r14-20020a0c8d0e0000b02902e82df307f0so7744543qvb.4
        for <bpf@vger.kernel.org>; Fri, 13 Aug 2021 16:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0xr8nrUTTS+5d46OL567SQwU59+B4NtyiAMj6qZyKDg=;
        b=ZaOHWqRTi3/SjpvxeDmFoegXYtWrKhQjl1B7ZdEh7P42R5k8qboZ7kKjtoEM4zuECQ
         WU1F7llICxKOQM/f/eP2de5svU+pjZWAmm3LofFdACF7oGLp9CbTPSRVAt4Bm5m3wCEA
         ETBBNNxM5KmocCAMMBbYX5OkpGezTPYbU6QZIJyewSYxZk2q2Ppzf9OFso4RGT8vS5vO
         323J2g442DtLQ7lMz0Gva9T1XCkPaYl9TBL0k4NFT1rDONiEEiGXjeHIloOs4i/rdeZk
         LnelfCMYUFhmOQDVJ02MXvHE8tvP/G2+aWt8EA55B+rzBshodyTGKBXF8cw2IQoo3276
         H/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0xr8nrUTTS+5d46OL567SQwU59+B4NtyiAMj6qZyKDg=;
        b=pYdxxszGcerc6WZHDxUI0FRo4AxgS3otxJ/5tSu5hcxBhshN80wLfuZfGCjFTS6i+d
         7SN8YxYoadI1ijdMKowMX+mZ6rqmd11xE1GtlO9FEFB1NUgvjdgX3PBtDB6QxiYIIhnO
         L+4G0ojZF4TGwKvxwXCkCNus4C/lSECS83lE/Mdeezw1KT4eSPEuzicnH3a7HveTs2kL
         rDUENvvQesJdjQNEkq0krRGaRknIF7Gpwn7bpw4+QjVc4CBqx430Qb1jB5s+Mezj2Gtb
         wPwawoEdjRzTokke8ijdg8ypVeI7ZlA1ct2mrAOF2f3PE/TgotD61f1SrmRjt+dmJ0W1
         rL2Q==
X-Gm-Message-State: AOAM530Bt8KewCh1q23AjokdZp8M2YjKABXur7+OD2VOhVaTLMtV9iqA
        Aea9equjf3W4dAvmKa4vM1DpLgU=
X-Google-Smtp-Source: ABdhPJxMM2n8drgip6VNs5+SAbDoXZTQ0PI2bRFJ6gHuUMyRZlVi5D6QEqugvvYh639ySSNFY+LWWIs=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:f73:a375:cbb9:779b])
 (user=sdf job=sendgmr) by 2002:ad4:5aa1:: with SMTP id u1mr5008609qvg.2.1628895937374;
 Fri, 13 Aug 2021 16:05:37 -0700 (PDT)
Date:   Fri, 13 Aug 2021 16:05:30 -0700
In-Reply-To: <20210813230530.333779-1-sdf@google.com>
Message-Id: <20210813230530.333779-3-sdf@google.com>
Mime-Version: 1.0
References: <20210813230530.333779-1-sdf@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: verify bpf_get_netns_cookie in BPF_PROG_TYPE_CGROUP_SOCKOPT
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add extra calls to sockopt_sk.c.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/progs/sockopt_sk.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/sockopt_sk.c b/tools/testing/selftests/bpf/progs/sockopt_sk.c
index 8acdb99b5959..79c8139b63b8 100644
--- a/tools/testing/selftests/bpf/progs/sockopt_sk.c
+++ b/tools/testing/selftests/bpf/progs/sockopt_sk.c
@@ -33,6 +33,14 @@ int _getsockopt(struct bpf_sockopt *ctx)
 	__u8 *optval = ctx->optval;
 	struct sockopt_sk *storage;
 
+	/* Make sure bpf_get_netns_cookie is callable.
+	 */
+	if (bpf_get_netns_cookie(NULL) == 0)
+		return 0;
+
+	if (bpf_get_netns_cookie(ctx) == 0)
+		return 0;
+
 	if (ctx->level == SOL_IP && ctx->optname == IP_TOS) {
 		/* Not interested in SOL_IP:IP_TOS;
 		 * let next BPF program in the cgroup chain or kernel
@@ -123,6 +131,14 @@ int _setsockopt(struct bpf_sockopt *ctx)
 	__u8 *optval = ctx->optval;
 	struct sockopt_sk *storage;
 
+	/* Make sure bpf_get_netns_cookie is callable.
+	 */
+	if (bpf_get_netns_cookie(NULL) == 0)
+		return 0;
+
+	if (bpf_get_netns_cookie(ctx) == 0)
+		return 0;
+
 	if (ctx->level == SOL_IP && ctx->optname == IP_TOS) {
 		/* Not interested in SOL_IP:IP_TOS;
 		 * let next BPF program in the cgroup chain or kernel
-- 
2.33.0.rc1.237.g0d66db33f3-goog

