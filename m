Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3A6206601
	for <lists+bpf@lfdr.de>; Tue, 23 Jun 2020 23:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393752AbgFWVgO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Jun 2020 17:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389132AbgFWVgM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Jun 2020 17:36:12 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0414C061755
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2020 14:36:12 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a6so115953wrm.4
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2020 14:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q0et8A1jvBs+4gpipR2Yxk3Lns2E2/sXQjUw7PswoOA=;
        b=nBH37Fqimk/4BvTltMrYF76tcLtVwn+B/szjczHcXOGaHlOCWeq6TKpb//WqkHnR7p
         NDt7WuLTD+WHrHyr2cmmG+TK/go0r7bQh1dCTVIXXzA3lZlL1IyUc/9dF2ktMYxJcstq
         dSutNqazaL8zIS3rFapjJXVaSDZ2pk/Ias2OzqmhhSMkuIk+AzdihZ69AlCi2bQhrr1G
         EIaa69qsocbLjyjXB85B1pjWlj6TuS+/DzoTfWgG45sD68iCAOFojh/cl16+OxYDJNMn
         BPBUjdeJ42X5zzFhwkn5rc3iSPaKlXeUMGe98EmlYN5ZItzU8t1nT1Mf3gDCqTGV0U+V
         CE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q0et8A1jvBs+4gpipR2Yxk3Lns2E2/sXQjUw7PswoOA=;
        b=QjwtywM6u5BovGcQEmi1fscxf7a1Ohp2UTQYH1EOwQz80kCCbNEvQ+NF30/c3uqfIx
         ZZ4n9pY2v5RmwyPQIywyS5m8lbFY0EhJngB/7jzLowTQHoDfwK6ykKrPDFJ5l5p0fatH
         Q/oVb+ZZDY3Tl6TDra7bBY9izaQHmRoRzNmdFDQ4LvH/DiTWuV3XQKMFw0o+i8yrC5dR
         jyasuqY8b44wTUHUNS4UhpCBMctRUw1gvIFLi+GniLrDp1dDwYlFOXnGmdlQoWwUfaDB
         zegkd08HUyiwZWiTieCGGy9E4RZYVGxdxZpgu7RimSvo17vZxLuRHxKiTURhQFjAyoe3
         Tf/g==
X-Gm-Message-State: AOAM530yfPDwAByI3ln7LmeE+m001hu2WUP6VEIzaLIqe85GiRhDYeO4
        lDgawADm/sKiDt5PMWdFOA4kPwLxLPZtNw==
X-Google-Smtp-Source: ABdhPJxdq2/Xj1pkXyaS20CuheymStjrbpHd/M5NN2CLPlqx5eCXK1hwbLtayPo7dZ8S5UYZyyMSZg==
X-Received: by 2002:adf:c441:: with SMTP id a1mr27004567wrg.130.1592948171317;
        Tue, 23 Jun 2020 14:36:11 -0700 (PDT)
Received: from localhost.localdomain ([194.53.184.63])
        by smtp.gmail.com with ESMTPSA id v7sm3885686wmj.11.2020.06.23.14.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 14:36:10 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v2] tools: bpftool: fix variable shadowing in emit_obj_refs_json()
Date:   Tue, 23 Jun 2020 22:36:00 +0100
Message-Id: <20200623213600.16643-1-quentin@isovalent.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Building bpftool yields the following complaint:

    pids.c: In function 'emit_obj_refs_json':
    pids.c:175:80: warning: declaration of 'json_wtr' shadows a global declaration [-Wshadow]
      175 | void emit_obj_refs_json(struct obj_refs_table *table, __u32 id, json_writer_t *json_wtr)
          |                                                                 ~~~~~~~~~~~~~~~^~~~~~~~
    In file included from pids.c:11:
    main.h:141:23: note: shadowed declaration is here
      141 | extern json_writer_t *json_wtr;
          |                       ^~~~~~~~

Let's rename the variable.

v2:
- Rename the variable instead of calling the global json_wtr directly.

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
v1 was "tools: bpftool: do not pass json_wtr to emit_obj_refs_json()"
---
 tools/bpf/bpftool/pids.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/tools/bpf/bpftool/pids.c b/tools/bpf/bpftool/pids.c
index 3474a91743ff..2709be4de2b1 100644
--- a/tools/bpf/bpftool/pids.c
+++ b/tools/bpf/bpftool/pids.c
@@ -172,7 +172,8 @@ void delete_obj_refs_table(struct obj_refs_table *table)
 	}
 }
 
-void emit_obj_refs_json(struct obj_refs_table *table, __u32 id, json_writer_t *json_wtr)
+void emit_obj_refs_json(struct obj_refs_table *table, __u32 id,
+			json_writer_t *json_writer)
 {
 	struct obj_refs *refs;
 	struct obj_ref *ref;
@@ -187,16 +188,16 @@ void emit_obj_refs_json(struct obj_refs_table *table, __u32 id, json_writer_t *j
 		if (refs->ref_cnt == 0)
 			break;
 
-		jsonw_name(json_wtr, "pids");
-		jsonw_start_array(json_wtr);
+		jsonw_name(json_writer, "pids");
+		jsonw_start_array(json_writer);
 		for (i = 0; i < refs->ref_cnt; i++) {
 			ref = &refs->refs[i];
-			jsonw_start_object(json_wtr);
-			jsonw_int_field(json_wtr, "pid", ref->pid);
-			jsonw_string_field(json_wtr, "comm", ref->comm);
-			jsonw_end_object(json_wtr);
+			jsonw_start_object(json_writer);
+			jsonw_int_field(json_writer, "pid", ref->pid);
+			jsonw_string_field(json_writer, "comm", ref->comm);
+			jsonw_end_object(json_writer);
 		}
-		jsonw_end_array(json_wtr);
+		jsonw_end_array(json_writer);
 		break;
 	}
 }
-- 
2.20.1

