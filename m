Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2D1125D742
	for <lists+bpf@lfdr.de>; Fri,  4 Sep 2020 13:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730014AbgIDL3a (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Sep 2020 07:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730044AbgIDL0C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Sep 2020 07:26:02 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA33C0619C7
        for <bpf@vger.kernel.org>; Fri,  4 Sep 2020 04:24:24 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id c18so6345954wrm.9
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2020 04:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UlbYcEjSkKSPkXTMNH7qDHYVFjzIZuiUHBvMI19uz40=;
        b=TsHonHfIIUWg4ZnsLK/guRIHs/stKJa/IrJaigwRs4I8Rt7sMV5fA7dfRX64Bo6n1o
         3iWYyZA4fsxtM+U3f3ZB0zZpSmDE6hFEVDEZ05URZrFn1XYZ3BmmqVNd31nVzl7wjbU2
         8y/cO69T6GbAko0X0J2qyzeJJO2U0BGEpelh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UlbYcEjSkKSPkXTMNH7qDHYVFjzIZuiUHBvMI19uz40=;
        b=uSIJeGW0LgYHOcBG25vYwNMRkqTbL9eH/3HmhQ0KGHqzTSxdNJToayXlH4BJ4ozyYf
         9fpBmcwHJyWV3ItTLWyOlZ2JXAOIJtqPeqe5yA5IhMEt9ViAoDRftM0Lb/RmB5LwyLgd
         K2ZV1HrVJmmTxdJ+JuikgChVJqnZFICS+FIN7UBcuJa0dGEu2gSa9pGUf3n8DUVWMXKt
         YNgdReRWBofzAdmUME/nheczTVpwt2IeFgAg37B6NcNVbr/8+cZwc/FlzCobqDWZAvJb
         j5UopAvQK2FPp540SttwWLrkAocQTpGCXaJaIgYQM7PxDmxg5nPKUbT2KYfKePnevqF1
         VKUg==
X-Gm-Message-State: AOAM530WIpbx0RD9poGD8yhfmWQqjRWhLuErV2bDpYWCFcMSpe71xZLW
        u9s+hWhm3+9pE99IMfsokA3lSQ==
X-Google-Smtp-Source: ABdhPJytAzXJV7Z9lXp5Nu8vhdF/3ToSkvO98Kb+GYlZgkkDmeay/vejOCxAxh4GreyaacwVVZvMmQ==
X-Received: by 2002:adf:ba83:: with SMTP id p3mr7405832wrg.246.1599218663454;
        Fri, 04 Sep 2020 04:24:23 -0700 (PDT)
Received: from antares.lan (111.253.187.81.in-addr.arpa. [81.187.253.111])
        by smtp.gmail.com with ESMTPSA id v2sm9104408wrm.16.2020.09.04.04.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 04:24:22 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net, kafai@fb.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next 09/11] bpf: check ARG_PTR_TO_SPINLOCK register type in check_func_arg
Date:   Fri,  4 Sep 2020 12:23:59 +0100
Message-Id: <20200904112401.667645-10-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200904112401.667645-1-lmb@cloudflare.com>
References: <20200904112401.667645-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Move the check for PTR_TO_MAP_VALUE to check_func_arg, where all other
checking is done as well. Move the invocation of process_spin_lock away
from the register type checking, to allow a future refactoring.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 kernel/bpf/verifier.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 734ae5af9db9..8d060da0b068 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3781,10 +3781,6 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
 	struct bpf_map *map = reg->map_ptr;
 	u64 val = reg->var_off.value;
 
-	if (reg->type != PTR_TO_MAP_VALUE) {
-		verbose(env, "R%d is not a pointer to map_value\n", regno);
-		return -EINVAL;
-	}
 	if (!is_const) {
 		verbose(env,
 			"R%d doesn't have constant offset. bpf_spin_lock has to be at the constant offset\n",
@@ -4000,16 +3996,9 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		if (type != expected_type)
 			goto err_type;
 	} else if (arg_type == ARG_PTR_TO_SPIN_LOCK) {
-		if (meta->func_id == BPF_FUNC_spin_lock) {
-			if (process_spin_lock(env, regno, true))
-				return -EACCES;
-		} else if (meta->func_id == BPF_FUNC_spin_unlock) {
-			if (process_spin_lock(env, regno, false))
-				return -EACCES;
-		} else {
-			verbose(env, "verifier internal error\n");
-			return -EFAULT;
-		}
+		expected_type = PTR_TO_MAP_VALUE;
+		if (type != expected_type)
+			goto err_type;
 	} else if (arg_type_is_mem_ptr(arg_type)) {
 		expected_type = PTR_TO_STACK;
 		/* One exception here. In case function allows for NULL to be
@@ -4119,6 +4108,17 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		err = check_helper_mem_access(env, regno,
 					      meta->map_ptr->value_size, false,
 					      meta);
+	} else if (arg_type == ARG_PTR_TO_SPIN_LOCK) {
+		if (meta->func_id == BPF_FUNC_spin_lock) {
+			if (process_spin_lock(env, regno, true))
+				return -EACCES;
+		} else if (meta->func_id == BPF_FUNC_spin_unlock) {
+			if (process_spin_lock(env, regno, false))
+				return -EACCES;
+		} else {
+			verbose(env, "verifier internal error\n");
+			return -EFAULT;
+		}
 	} else if (arg_type_is_mem_ptr(arg_type)) {
 		/* The access to this pointer is only checked when we hit the
 		 * next is_mem_size argument below.
-- 
2.25.1

