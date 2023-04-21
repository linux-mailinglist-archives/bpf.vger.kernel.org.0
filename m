Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06CDE6EB172
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 20:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjDUSRf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 14:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjDUSRe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 14:17:34 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7598E5C
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 11:17:33 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-555d2810415so29524517b3.0
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 11:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682101052; x=1684693052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lsSH4C9w/51OpVNR1rR3fzMgMFtMXzuPBxmoVBsnsZA=;
        b=RcUbsi62+1ao9z47rfF7FoYkdmxKMFYojkP4V9jr2N/xs5pJDL0cIDBlouapacu8XE
         +eUQfwB2UuR+tqPnQuTRydHTSnxKehZeWDn2/4mm+V/o23Qz00cbeHMuQzm+VhW2twXG
         qAnyM7JleojaHuaaEfB9WegTil10c+tyWYlMdlSSfJqpJkYyeDc7OwJW6w7gqwl4eMWT
         CL1gDQIZhFjjoJiD5LLbFFtAtOpI5Vc6//fJiSb3kgiNd1ldlO/ChNDRy2N1tys1zWU1
         mxI/SFX+JBnAzCBPA+03ASgfaUzbzomB2/FYYQfbh5VUcvhLx8mscUQAdIkuOViYdQDZ
         3oGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682101052; x=1684693052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lsSH4C9w/51OpVNR1rR3fzMgMFtMXzuPBxmoVBsnsZA=;
        b=as1Ngmzyu5SRcXeED3wzxygRFGPCiR0l87HsDD1dF8/aIbMFSEiiJEccEEu5T5sdPc
         VcQT/e5tq0VrWmzt5dTxo7y0tOsKJdobndnP1O18/nAAlVa6FxgLMO2O2/+eSAbUe3td
         5aHerHQ8PFDDqTgeVGco27OV22MhyGeKZZD5U3D8g10LaD1ovIcSr/upjSzNxFrBLGt/
         xNEXKZJ2NG42kCmLOGdbBdcdMunKd8vth2c4Pa5YPVb0wBCb1LfFo3+sapFZ8TcPPEU4
         S4SXUKrOfXW1nxbTqixmRhR2ogMZenabKHKzRyaQP8IXQjVp4A0JKQlTFzMsCwCHHH26
         a0kg==
X-Gm-Message-State: AAQBX9d4NCrh17zvAb4EeQEoWU8978pyBmEqciAGA3MjNynmizTKT+hV
        T7t7sFUwaTsS0Szmj1ckzwAza++/K64=
X-Google-Smtp-Source: AKy350YmEJ5hEYNlBBtsm7yBdnnxcj7Z04YY+TiOuJ3xn3DX0zlr0lj4Ax5bph5BlJwUP1hoHfKFrA==
X-Received: by 2002:a0d:e606:0:b0:54f:b89e:1010 with SMTP id p6-20020a0de606000000b0054fb89e1010mr2491951ywe.23.1682101052579;
        Fri, 21 Apr 2023 11:17:32 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:724e:a12f:f4b3:597b])
        by smtp.gmail.com with ESMTPSA id u11-20020a81a50b000000b0054f3e4bf623sm1076636ywg.132.2023.04.21.11.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 11:17:32 -0700 (PDT)
From:   Kui-Feng Lee <thinker.li@gmail.com>
X-Google-Original-From: Kui-Feng Lee <kuifeng@meta.com>
To:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        yhs@meta.com, song@kernel.org, kernel-team@meta.com,
        andrii@kernel.org
Cc:     Kui-Feng Lee <kuifeng@meta.com>,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v3] bpftool: Show map IDs along with struct_ops links.
Date:   Fri, 21 Apr 2023 11:17:20 -0700
Message-Id: <20230421181720.182365-1-kuifeng@meta.com>
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
index f985b79cca27..c79f2e8927d6 100644
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
+		printf("map %u  ", info->struct_ops.map_id);
+	else
+		printf("prog %u  ", info->prog_id);
 }
 
 static void show_link_attach_type_plain(__u32 attach_type)
-- 
2.34.1

