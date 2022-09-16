Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DECFE5BB380
	for <lists+bpf@lfdr.de>; Fri, 16 Sep 2022 22:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiIPU2P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Sep 2022 16:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbiIPU2O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Sep 2022 16:28:14 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5BBA9C06;
        Fri, 16 Sep 2022 13:28:13 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 78so21330581pgb.13;
        Fri, 16 Sep 2022 13:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=CjL7owck1dNbP/thPcZ5UQpXADCiYYzVUdGfT1CXMn8=;
        b=TIxLJgD58yFPG1Vw5L8sUGiVdd+z5VsjexqSt2OTRNGD3zaVwGo6HMwzkt4pPhm2+w
         y+MPvW28JqWpVbvTAeB7FWQ8v2Lz0ROqVLNagiEeRAsA51W6dA7vfL+sKcVhUZ7vdnkj
         +/x/AxtU331P2T7tWUWKTU8rPeA44CwaCmnWkjRE0j5RgJT1WCHrcPLxQJQSHSjdMjja
         HYFAxFIe0XTO1UJl9vJL1bCFzNUldQWv8iYq7RLEnfZC0g2gH6r1b0n3VaigzjtKfNGP
         uZFNXp1drl6N/Z3nGkpJJKPU5WgVyWiLxJo7UG/xcvr6tjORYac13c/mODR53E1m7sFe
         XaxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=CjL7owck1dNbP/thPcZ5UQpXADCiYYzVUdGfT1CXMn8=;
        b=0Mud6s/E1DRXcVHDgaMIwW10DYr9/liz9fjE4Vu653TAkv+bcAYN+u5cA2/CXIaNr6
         NRgVJU80KoZIHh/QEAN5bwlpZlnF172x/kr9qACs7mucKYyX82CCC4waZx7du8wsIj2p
         30GDjkrE5xkP37Yzrei+W3w2oorQuZYV2KaRDyiI2K+w1jMsWytxHtuuhPzB733k9Z0f
         BvcQGE8DEA4obgEXqu7Tm+ETxi6p4rQgyXU6Hy4WOZPVRvwDuBSALRH0ERXBInnhN6Dv
         m+fDmHOoc229zN4cJxnLoS9b5jUaWaJERgidfNnCwmPxnzaN5snyjGwg474MxQtwV+8A
         4J1g==
X-Gm-Message-State: ACrzQf0bJKh11XdfZ0sB068ot+L8mUu8aIQSxxM04MBHF+NCCCVuPfWk
        rAnP9JCD7UVMeY4ri5nVqg==
X-Google-Smtp-Source: AMsMyM5EmEl4XSD4uMcxPYJ3HZXqfiW5qWLAWr8vWOWVvsIXwDsTDwGvSC7hPtr7l9OK+fokmrti0Q==
X-Received: by 2002:a05:6a00:d60:b0:53e:576e:bd8c with SMTP id n32-20020a056a000d6000b0053e576ebd8cmr6672425pfv.4.1663360092955;
        Fri, 16 Sep 2022 13:28:12 -0700 (PDT)
Received: from bytedance.bytedance.net ([12.125.146.54])
        by smtp.gmail.com with ESMTPSA id w1-20020a1709026f0100b00178650510f9sm5054515plk.160.2022.09.16.13.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 13:28:12 -0700 (PDT)
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     Peilin Ye <peilin.ye@bytedance.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peilin Ye <yepeilin.cs@gmail.com>
Subject: [PATCH bpf-next v2] bpf/btf: Use btf_type_str() whenever possible
Date:   Fri, 16 Sep 2022 13:28:00 -0700
Message-Id: <20220916202800.31421-1-yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220914021328.17039-1-yepeilin.cs@gmail.com>
References: <20220914021328.17039-1-yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Peilin Ye <peilin.ye@bytedance.com>

We have btf_type_str().  Use it whenever possible in btf.c, instead of
"btf_kind_str[BTF_INFO_KIND(t->info)]".

Signed-off-by: Peilin Ye <peilin.ye@bytedance.com>
---
change since v1:
  - rebase on bpf-next (Martin KaFai Lau)
  - also use btf_type_str() in __btf_verifier_log_type()

 kernel/bpf/btf.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 98be25d13325..b3940c605aac 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -1397,7 +1397,6 @@ __printf(4, 5) static void __btf_verifier_log_type(struct btf_verifier_env *env,
 						   const char *fmt, ...)
 {
 	struct bpf_verifier_log *log = &env->log;
-	u8 kind = BTF_INFO_KIND(t->info);
 	struct btf *btf = env->btf;
 	va_list args;
 
@@ -1413,7 +1412,7 @@ __printf(4, 5) static void __btf_verifier_log_type(struct btf_verifier_env *env,
 
 	__btf_verifier_log(log, "[%u] %s %s%s",
 			   env->log_type_id,
-			   btf_kind_str[kind],
+			   btf_type_str(t),
 			   __btf_name_by_offset(btf, t->name_off),
 			   log_details ? " " : "");
 
@@ -5427,7 +5426,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 			if (!btf_type_is_small_int(t)) {
 				bpf_log(log,
 					"ret type %s not allowed for fmod_ret\n",
-					btf_kind_str[BTF_INFO_KIND(t->info)]);
+					btf_type_str(t));
 				return false;
 			}
 			break;
@@ -5454,7 +5453,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 			"func '%s' arg%d '%s' has type %s. Only pointer access is allowed\n",
 			tname, arg,
 			__btf_name_by_offset(btf, t->name_off),
-			btf_kind_str[BTF_INFO_KIND(t->info)]);
+			btf_type_str(t));
 		return false;
 	}
 
@@ -5538,11 +5537,11 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 	if (!btf_type_is_struct(t)) {
 		bpf_log(log,
 			"func '%s' arg%d type %s is not a struct\n",
-			tname, arg, btf_kind_str[BTF_INFO_KIND(t->info)]);
+			tname, arg, btf_type_str(t));
 		return false;
 	}
 	bpf_log(log, "func '%s' arg%d has btf_id %d type %s '%s'\n",
-		tname, arg, info->btf_id, btf_kind_str[BTF_INFO_KIND(t->info)],
+		tname, arg, info->btf_id, btf_type_str(t),
 		__btf_name_by_offset(btf, t->name_off));
 	return true;
 }
@@ -5950,7 +5949,7 @@ int btf_distill_func_proto(struct bpf_verifier_log *log,
 	if (ret < 0 || __btf_type_is_struct(t)) {
 		bpf_log(log,
 			"The function %s return type %s is unsupported.\n",
-			tname, btf_kind_str[BTF_INFO_KIND(t->info)]);
+			tname, btf_type_str(t));
 		return -EINVAL;
 	}
 	m->ret_size = ret;
@@ -5968,7 +5967,7 @@ int btf_distill_func_proto(struct bpf_verifier_log *log,
 		if (ret < 0 || ret > 16) {
 			bpf_log(log,
 				"The function %s arg%d type %s is unsupported.\n",
-				tname, i, btf_kind_str[BTF_INFO_KIND(t->info)]);
+				tname, i, btf_type_str(t));
 			return -EINVAL;
 		}
 		if (ret == 0) {
@@ -6727,7 +6726,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog,
 			continue;
 		}
 		bpf_log(log, "Arg#%d type %s in %s() is not supported yet.\n",
-			i, btf_kind_str[BTF_INFO_KIND(t->info)], tname);
+			i, btf_type_str(t), tname);
 		return -EINVAL;
 	}
 	return 0;
-- 
2.20.1

