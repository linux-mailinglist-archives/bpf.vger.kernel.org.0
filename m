Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0800B6E707B
	for <lists+bpf@lfdr.de>; Wed, 19 Apr 2023 02:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjDSAhF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Apr 2023 20:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbjDSAhE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Apr 2023 20:37:04 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C67186
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 17:37:03 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-552fb3c2bb7so72398667b3.10
        for <bpf@vger.kernel.org>; Tue, 18 Apr 2023 17:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681864622; x=1684456622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=75kYPTEBm33aTsQ2rwLviJq33mg3Cn5TCyJqao4lvnk=;
        b=P9w1MR4m9I4rwYR5iySzRSq0Qm5PPasFjhwfw7yQG/vYUvMxtT7+6iTZGPzKwtgFnH
         tKjtwrUsHrFEd9gU4kGkXz1T7qz52lUZFkAUtBfIAYqAjcbcULqQ/YppEPCz/ruiKGGt
         o55IDpim0+RWXRD5AWkokA/36ZobrvNHnMkmV7AGPYnCPDfQixeZQsZnGxTmvGaG2otT
         Q+P+T9mEX5RIJEen46VITS24RSJnFRUxtSBtFM23ByHQ8zVH6Jj0SzrVWsi4vlLqONr9
         afojDXCUuC9IGG7wYmtFwzFzatg+W9sNFBZLQU7dUG+SfPwddLWtOE5ojv+XR6ew+u4L
         m4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681864622; x=1684456622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=75kYPTEBm33aTsQ2rwLviJq33mg3Cn5TCyJqao4lvnk=;
        b=BTfQwF5I9xQBeaVYChrhrBvPYYeac96QpXJIehw2Gk/bD8ykA5p3MdrSTo+uHwfdbr
         I6Yl9AUMuicvdSTJPj0P/zIaMt7UpTWKw3fsC6bUgYGPcZinDTqPStFvZumx8776S/Rc
         82CToQsj/xwLn2ziuRU4UinURt5ovYS/ODFgqIbbClIsPuKAlYbcGiLkz6vORisml4BJ
         xGCuuWbgPZj/7rKRoX+4zejkl8EW7b4jYbfdLGPYqg8wkczytlNW7uffptC7pJ8ovH/1
         zCFxz8q8323wKqPiNqkvy+d2evFaQCoIEm3vFDY9M3TAELTh9kQYUTplw24MKe9oc3Kv
         Swjg==
X-Gm-Message-State: AAQBX9fO2kERJmYEvdWWsooMEUgJn9PQNIUn6yaOkJiK4orMQVdRItij
        txGMhSbNDJpRHOdSg6zfgNrupYMRe+k=
X-Google-Smtp-Source: AKy350aXT2Gg/hVWzePSaG6/k//MKatzmsdwcRqSqVMXfWY7qwScpqof3O9VCVrK1PpPfV3ekOoPXg==
X-Received: by 2002:a81:66c5:0:b0:54f:315:68fa with SMTP id a188-20020a8166c5000000b0054f031568famr1492523ywc.22.1681864622494;
        Tue, 18 Apr 2023 17:37:02 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:bdd1:744a:3308:f071])
        by smtp.gmail.com with ESMTPSA id p9-20020a81f009000000b00555a8a5da1esm920482ywm.115.2023.04.18.17.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 17:37:02 -0700 (PDT)
From:   Kui-Feng Lee <thinker.li@gmail.com>
X-Google-Original-From: Kui-Feng Lee <kuifeng@meta.com>
To:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        yhs@meta.com, song@kernel.org, kernel-team@meta.com,
        andrii@kernel.org
Cc:     Kui-Feng Lee <kuifeng@meta.com>,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v2] bpftool: Show map IDs along with struct_ops links.
Date:   Tue, 18 Apr 2023 17:36:51 -0700
Message-Id: <20230419003651.988865-1-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
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

A new link type, BPF_LINK_TYPE_STRUCT_OPS, was added to attach
struct_ops to links. (226bc6ae6405) It would be helpful for users to
know which map is associated with the link.

The assumption was that every link is associated with a BPF program, but
this does not hold true for struct_ops. It would be better to display
map_id instead of prog_id for struct_ops links. However, some tools may
rely on the old assumption and need a prog_id.  The discussion on the
mailing list suggests that tools should parse JSON format. We will maintain
the existing JSON format by adding a map_id without removing prog_id. As
for plain text format, we will remove prog_id from the header line and add
a map_id for struct_ops links.

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
Reviewed-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/link.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index f985b79cca27..8eb8520bd7b4 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -195,6 +195,10 @@ static int show_link_close_json(int fd, struct bpf_link_info *info)
 				 info->netns.netns_ino);
 		show_link_attach_type_json(info->netns.attach_type, json_wtr);
 		break;
+	case BPF_LINK_TYPE_STRUCT_OPS:
+		jsonw_uint_field(json_wtr, "map_id",
+				 info->struct_ops.map_id);
+		break;
 	default:
 		break;
 	}
@@ -227,7 +231,10 @@ static void show_link_header_plain(struct bpf_link_info *info)
 	else
 		printf("type %u  ", info->type);
 
-	printf("prog %u  ", info->prog_id);
+	if (info->type == BPF_LINK_TYPE_STRUCT_OPS)
+		printf("map_id %u  ", info->struct_ops.map_id);
+	else
+		printf("prog %u  ", info->prog_id);
 }
 
 static void show_link_attach_type_plain(__u32 attach_type)
-- 
2.34.1

