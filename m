Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60CB5EF9B5
	for <lists+bpf@lfdr.de>; Thu, 29 Sep 2022 18:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235811AbiI2QGK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Sep 2022 12:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234951AbiI2QGK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Sep 2022 12:06:10 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD0551CFB8E
        for <bpf@vger.kernel.org>; Thu, 29 Sep 2022 09:06:08 -0700 (PDT)
Received: from localhost.localdomain (unknown [177.33.235.223])
        by linux.microsoft.com (Postfix) with ESMTPSA id 328B520E0A2C;
        Thu, 29 Sep 2022 09:06:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 328B520E0A2C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1664467568;
        bh=SkKUwGAVoLYtJnaX1SZrjNfnhW8uFrDHIDrwn9hbAiE=;
        h=From:To:Cc:Subject:Date:From;
        b=D+oV0tUgTWAUcBddzeWEUStkUmdACbyzdabuEDGWwSmT9dHgl71pAbf43u+GsWTCg
         2fL6qfezSORhrspXmdhRO9FUQtAlGxzWPXP3UIlqN8/NhQ0m5tVoCdtV+2JRWYpIxJ
         lIbtXHExMFhWM6bqlpGjEukBgyhaMMv3pO85eF+g=
From:   Anne Macedo <annemacedo@linux.microsoft.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Isabella Basso <isabbasso@riseup.net>,
        Paul Moore <paul@paul-moore.com>,
        Anne Macedo <annemacedo@linux.microsoft.com>
Subject: [PATCH] libbpf: add validation to BTF's variable type ID
Date:   Thu, 29 Sep 2022 13:05:58 -0300
Message-Id: <20220929160558.5034-1-annemacedo@linux.microsoft.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

If BTF is corrupted, a SEGV may occur due to a null pointer dereference on
bpf_object__init_user_btf_map.

This patch adds a validation that checks whether the DATASEC's variable
type ID is null. If so, it raises a warning.

Reported by oss-fuzz project [1].

A similar patch for the same issue exists on [2]. However, the code is
unreachable when using oss-fuzz data.

[1] https://github.com/libbpf/libbpf/issues/484
[2] https://patchwork.kernel.org/project/netdevbpf/patch/20211103173213.1376990-3-andrii@kernel.org/

Reviewed-by: Isabella Basso <isabbasso@riseup.net>
Signed-off-by: Anne Macedo <annemacedo@linux.microsoft.com>
---
 tools/lib/bpf/libbpf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 184ce1684dcd..0c88612ab7c4 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2464,6 +2464,10 @@ static int bpf_object__init_user_btf_map(struct bpf_object *obj,
 
 	vi = btf_var_secinfos(sec) + var_idx;
 	var = btf__type_by_id(obj->btf, vi->type);
+	if (!var || !btf_is_var(var)) {
+		pr_warn("map #%d: non-VAR type seen", var_idx);
+		return -EINVAL;
+	}
 	var_extra = btf_var(var);
 	map_name = btf__name_by_offset(obj->btf, var->name_off);
 
-- 
2.30.2

