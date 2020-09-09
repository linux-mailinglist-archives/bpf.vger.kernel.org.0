Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282502633F5
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 19:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731237AbgIIRMO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 13:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731221AbgIIRMM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Sep 2020 13:12:12 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F28C061757
        for <bpf@vger.kernel.org>; Wed,  9 Sep 2020 10:12:12 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id w2so3037403wmi.1
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2020 10:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dnZ331gfN/AeE7WivZ3vPwmqFG0W8bqGKgBfqzj0+f0=;
        b=psXWU7wdb09Z/i/Nfal00GgYW+MQc+h5BRgakVyd/6TXD0sTbcS/AYXUxNCMX/+x2b
         zV7Vg3J0divMPOwmj9/8P4fkyu9Eq11+qqJ6vxq2ceDLqkKKrAMD8/eb+0n6Fh3YfB/T
         tXO2VnFkK4KAh4yiNPxBk0mxGJDBrHyoqU+U8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dnZ331gfN/AeE7WivZ3vPwmqFG0W8bqGKgBfqzj0+f0=;
        b=osBm5YvN2hfxe7OC+3rE26/LWkazFz5yoU2Ew2Wt8PVGOvMADCk4t9dxInfaku/rHS
         +m+xqWfjwxvQ/lXudAj5UQqNHNWNJ59MJ/jgRjbea7w2HTu8EKqPbn6MQrVx6yYX27OX
         hbI730LH7ynw1ZXrwvaXXZ3SuCV+eywicnIZ7FAAAl/BTItIOoWSGU70vcsZhth++ddC
         cmirpFXB1filIIiXkADRX6af/DfyGrHlnxRLn4dLAXmhroMcQr7Ne272+shb8lKE7jCd
         GyXR/6BxkM05ylm59nG8/lHXjHoA2ycumHldzNq6kaBZkVTYd2n+QYOSosYYmMZx1jC7
         v6eA==
X-Gm-Message-State: AOAM5316dlLraiB32ZVNlf90Ejl+U9snrwe1B+rr1XuX9hv5BkLMsnXq
        Ok8vaXkElFevCQ1K6K/ovFriOQ==
X-Google-Smtp-Source: ABdhPJzg8eSZKKDXD54EvswQnL0ZKe0cKv2sPGMxX2xYXEFaY4a/xBtVHUV9jE/b7kKW0hE7tbVxLw==
X-Received: by 2002:a7b:cd05:: with SMTP id f5mr4457218wmj.116.1599671530982;
        Wed, 09 Sep 2020 10:12:10 -0700 (PDT)
Received: from antares.lan (1.3.0.0.8.d.4.4.b.b.8.a.1.4.5.e.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:e541:a8bb:44d8:31])
        by smtp.gmail.com with ESMTPSA id g131sm3746743wmf.25.2020.09.09.10.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 10:12:10 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net, kafai@fb.com,
        andriin@fb.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v2 07/11] bpf: make context access check generic
Date:   Wed,  9 Sep 2020 18:11:51 +0100
Message-Id: <20200909171155.256601-8-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200909171155.256601-1-lmb@cloudflare.com>
References: <20200909171155.256601-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Always check context access if the register we're operating on is
PTR_TO_CTX, rather than relying on ARG_PTR_TO_CTX. This allows
simplifying the arg_type checking section of the function.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 kernel/bpf/verifier.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 43df3bae93aa..41643e179e14 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3974,9 +3974,6 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		      arg_type == ARG_PTR_TO_CTX_OR_NULL)) {
 			if (type != expected_type)
 				goto err_type;
-			err = check_ctx_reg(env, reg, regno);
-			if (err < 0)
-				return err;
 		}
 	} else if (arg_type == ARG_PTR_TO_SOCK_COMMON) {
 		expected_type = PTR_TO_SOCK_COMMON;
@@ -4060,6 +4057,10 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 				regno);
 			return -EACCES;
 		}
+	} else if (type == PTR_TO_CTX) {
+		err = check_ctx_reg(env, reg, regno);
+		if (err < 0)
+			return err;
 	}
 
 	if (reg->ref_obj_id) {
-- 
2.25.1

