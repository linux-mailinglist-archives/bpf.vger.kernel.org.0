Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780745B7ED2
	for <lists+bpf@lfdr.de>; Wed, 14 Sep 2022 04:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiINCNp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Sep 2022 22:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiINCNo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Sep 2022 22:13:44 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F672ED67;
        Tue, 13 Sep 2022 19:13:43 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id f26so7697393qto.11;
        Tue, 13 Sep 2022 19:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=NjC7qTjbSL49olH/EhHnWHUYbQIKbD5r4BivfZRzClo=;
        b=nsNU+A6J8ISWFT6Y3xYsghGEVwfO1NBgO9tMO20LXOwyKg/cBt1SwI8VQkGEKmmsMb
         o2lfrqnGMicPxrXE+wCyyYoBjognt7nA9Uu2PHRnMair1Jky5N0Fc0xbWKS1ilvC5FE5
         ApK/XJz29KKW2L7AikCXjJ03lOCqWkxf0etGT52O+2o1ziupvkuT4n5Kmda1XZBNHqP+
         Aqztm7HBOgfRLpher6Nlk5kVSCqyxdnqIGUGRkSJlNSfhWHo0mUZeMPXHIajP9dmucLc
         hp0FYa+IOTKPSIO5sg9qKbZ+eh/UsstDCij3bJZctVLrek5ysaWGJao3nU42fK7V/zhf
         8Big==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=NjC7qTjbSL49olH/EhHnWHUYbQIKbD5r4BivfZRzClo=;
        b=aZReseAWI/4kgWm/q3SDfZkajqaAbPNri6v4zex8tN3DvP4WuFZvXKlIRiqRsw78tR
         /06OL+cE2cenleTTa3CQxSZBoczHMZ6N2Ar46pfbwQkn1z4J3Ie4F3eZf65jsTsjEhXb
         L978DQ5vZCUvE320Q+SvJsmqa1IB8kuuEhBfoy9slHLZtTdkUro6YFWpYUbn6fqjoW9T
         b8YgLVfVGkWAY4u7lj75j/v4+Y0b4oK7NrPn5alKWhxlWLqsBGDDJBbyvzJuJmOZDiQr
         CBAWTwHasCn1gDrlxY9Pmdmszk7eb25+VdyD/k9EJoYyZid+Y7Xt2Jw1yXrXJHTuHu16
         pP9A==
X-Gm-Message-State: ACgBeo12Rwq4Uub1bZZ+eOd/ocSBSfUDfJnPFyu/p5aKm0r385Rhxgp9
        LZwhLlEsV3hFIv/WfUikGw==
X-Google-Smtp-Source: AA6agR7ocdNJjWVqDEOTF/Jq5gl6wecRZF1ohoTqOhtw48DASb23du8N69z0ahnFoWQO9tuxcZ1mVw==
X-Received: by 2002:ac8:5a4e:0:b0:343:7504:4af4 with SMTP id o14-20020ac85a4e000000b0034375044af4mr30929035qta.419.1663121622275;
        Tue, 13 Sep 2022 19:13:42 -0700 (PDT)
Received: from bytedance.attlocal.net (ec2-52-52-7-82.us-west-1.compute.amazonaws.com. [52.52.7.82])
        by smtp.gmail.com with ESMTPSA id 8-20020a370808000000b006a6ab259261sm837003qki.29.2022.09.13.19.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 19:13:41 -0700 (PDT)
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
Subject: [PATCH bpf-next] bpf/btf: Use btf_type_str() whenever possible
Date:   Tue, 13 Sep 2022 19:13:28 -0700
Message-Id: <20220914021328.17039-1-yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 kernel/bpf/btf.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index cad4657ba2ce..81dc7423d723 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5403,7 +5403,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 			if (!btf_type_is_small_int(t)) {
 				bpf_log(log,
 					"ret type %s not allowed for fmod_ret\n",
-					btf_kind_str[BTF_INFO_KIND(t->info)]);
+					btf_type_str(t));
 				return false;
 			}
 			break;
@@ -5430,7 +5430,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 			"func '%s' arg%d '%s' has type %s. Only pointer access is allowed\n",
 			tname, arg,
 			__btf_name_by_offset(btf, t->name_off),
-			btf_kind_str[BTF_INFO_KIND(t->info)]);
+			btf_type_str(t));
 		return false;
 	}
 
@@ -5514,11 +5514,11 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
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
@@ -5924,7 +5924,7 @@ int btf_distill_func_proto(struct bpf_verifier_log *log,
 	if (ret < 0) {
 		bpf_log(log,
 			"The function %s return type %s is unsupported.\n",
-			tname, btf_kind_str[BTF_INFO_KIND(t->info)]);
+			tname, btf_type_str(t));
 		return -EINVAL;
 	}
 	m->ret_size = ret;
@@ -5940,7 +5940,7 @@ int btf_distill_func_proto(struct bpf_verifier_log *log,
 		if (ret < 0) {
 			bpf_log(log,
 				"The function %s arg%d type %s is unsupported.\n",
-				tname, i, btf_kind_str[BTF_INFO_KIND(t->info)]);
+				tname, i, btf_type_str(t));
 			return -EINVAL;
 		}
 		if (ret == 0) {
@@ -6593,7 +6593,7 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog,
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

