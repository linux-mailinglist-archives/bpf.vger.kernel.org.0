Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60FC6EB3BC
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 23:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjDUVli (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 17:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjDUVli (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 17:41:38 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5EA9E
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 14:41:36 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-b8f51500a82so2903450276.2
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 14:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682113296; x=1684705296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NqPm282SIfG7ccTNSgaHR5L/45apNjvn0C1cvhYPX7A=;
        b=F0P9A7jt1A1NK9TVb0r0UOvbIJh6yfO9WsXAUZCDzQEBbkId/USpMOyGHni9uxRMnu
         fBhdU6/bPjhtMognOL4YwqC1svJoJYr7qsAXRyTHLInsQOSsLC+eSjyGRxMMwriF2a4x
         ciPJQuAwS1vRMsKcytsjMTzQx4uE8aK7p6TGK3HPJnuObFshC9nhvQ/Kx2sjrcDLnVjn
         LTavJqAQQyWjZUtCcJqzkKy19mwXW/52y4L16vtI2ykoW1OIgUw6ZslEqMakSX48WsZD
         XSzVXYXWw15PNlFrCzoZT6lsW2Yo0j2M7/1bbe2fThWXG71cx9UtcNSxQfZveSyX2hUP
         VGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682113296; x=1684705296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NqPm282SIfG7ccTNSgaHR5L/45apNjvn0C1cvhYPX7A=;
        b=jjpcUgHHIZgMbGn+mAi/RnmmHAE/x13DdDxpWEe1/IJLjb2b4mBpIyjwO8b/zQXgHA
         N0y1ScAwImFnHu62/gUe0FWXHt1nWPrTJ8s789hBfzz3wxb2xloRyO0eozqgqljNRumO
         YzOmO0r3QDeclUMRiG7i1loaOx3y7VzrZLInUvWIFikbwjVLp+Hoz0Z1dsBBhYgnuQpc
         uRvqKNR5ca5BFaIjgTCKwORQ3KpL+rN6yLLpds1Fjl8/WJAmbxEg34kMNpG+8va2m0vq
         3vlpvpPGmMt0PO3e1V2hgLvXPlWP4RUkay39U4mU/5KzPcaRsoEb029zqnfJVPH6tDZW
         whBw==
X-Gm-Message-State: AAQBX9f9XSxR64V1lm8oY8rfY4m4dvqSAtYGILhdj6s61vN261ojbWPl
        84bcjzI6JOdZXYs4lrstf714AzprrMo=
X-Google-Smtp-Source: AKy350Z6N6oruS8vtcQV4JAbbmb26eFTFags0C21+y54OfAHx7bMTqAgrdIcIqlRCbsmlRBLtV7wsw==
X-Received: by 2002:a25:4408:0:b0:b92:5d8d:aa64 with SMTP id r8-20020a254408000000b00b925d8daa64mr3331086yba.43.1682113295818;
        Fri, 21 Apr 2023 14:41:35 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:5982:695:6231:be41])
        by smtp.gmail.com with ESMTPSA id 144-20020a250496000000b00b8f09a8f4f5sm1163093ybe.46.2023.04.21.14.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 14:41:35 -0700 (PDT)
From:   Kui-Feng Lee <thinker.li@gmail.com>
X-Google-Original-From: Kui-Feng Lee <kuifeng@meta.com>
To:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        yhs@meta.com, song@kernel.org, kernel-team@meta.com,
        andrii@kernel.org
Cc:     Kui-Feng Lee <kuifeng@meta.com>,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v4] bpftool: Show map IDs along with struct_ops links.
Date:   Fri, 21 Apr 2023 14:41:31 -0700
Message-Id: <20230421214131.352662-1-kuifeng@meta.com>
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
 tools/bpf/bpftool/link.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index d98dbc50cf4c..243b74e18e51 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -212,7 +212,10 @@ static int show_link_close_json(int fd, struct bpf_link_info *info)
 	case BPF_LINK_TYPE_NETFILTER:
 		netfilter_dump_json(info, json_wtr);
 		break;
-
+	case BPF_LINK_TYPE_STRUCT_OPS:
+		jsonw_uint_field(json_wtr, "map_id",
+				 info->struct_ops.map_id);
+		break;
 	default:
 		break;
 	}
@@ -245,7 +248,10 @@ static void show_link_header_plain(struct bpf_link_info *info)
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

