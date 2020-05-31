Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 236001E9654
	for <lists+bpf@lfdr.de>; Sun, 31 May 2020 10:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgEaI3X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 31 May 2020 04:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727890AbgEaI3G (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 31 May 2020 04:29:06 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54048C03E96B
        for <bpf@vger.kernel.org>; Sun, 31 May 2020 01:29:04 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id gl26so6249984ejb.11
        for <bpf@vger.kernel.org>; Sun, 31 May 2020 01:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5IQjsvRHHSKlUbL/g6OiBtDTmWqGV/fVFGeB8D88fHc=;
        b=ZK/O2CYJBORQxCyReYSmErjz92XC5oJ2LAeN9QIGTGleKpNCZauhcD3PRu4Ed12/At
         QSvFCiWb74racNzhfFqQSrnnD7EIlsAYIzjm1Me0Ela24RmTn9Y12ddBrH+5ljf82OH6
         O3TSRgWLTNFrSiRSsGBj7sMFpAgjubEVqoVAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5IQjsvRHHSKlUbL/g6OiBtDTmWqGV/fVFGeB8D88fHc=;
        b=TALom/HyBvTsaO04bQ6nXSlEo6jc8AHUp2uZGW1ALF1iIpQ/Lx3zD5ujmDvDpSySRs
         /xqgrZSrra8JoWjxIp8vkJtBvNBbFHJGFcc0Mgj6mYjaZuVA9RTpbc2jUVIl4snMoPLi
         q5wf5OWL9lcD7425TJZT8mcD/++9qTFxg6vyMB4vTASrZl45yJDRFIlCQfSzIHiJZnLl
         n23K6hVPYLNQ1bEWKnNztTKlrJM01lDcQRYu+TkN7oYMEaWkZpJ3o86tljLcVJX1gqLP
         TMk119tM8I2Oo4CV10ypLBBCRUgY9FLEO4k1TFT0fKjmdzQnDC37qcTPWu7GZvThyKlE
         OkSg==
X-Gm-Message-State: AOAM531GOjroLLMNofOty9GU2gYhhncd19+0lXWjOlwJws4tlz7wChcM
        AF92szD9krstxUqz7OdGm5yiyA1Sb1o=
X-Google-Smtp-Source: ABdhPJy4IX7BZDG8OwmUPaBYTu5C2BWioHOk3rnmGlLoG1h+CREHuSD3IAyDJNzgQ3pUo13v1FQqkg==
X-Received: by 2002:a17:906:86c5:: with SMTP id j5mr14347483ejy.88.1590913742761;
        Sun, 31 May 2020 01:29:02 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id f11sm12602957edl.52.2020.05.31.01.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2020 01:29:02 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH bpf-next v2 07/12] bpftool: Extract helpers for showing link attach type
Date:   Sun, 31 May 2020 10:28:41 +0200
Message-Id: <20200531082846.2117903-8-jakub@cloudflare.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200531082846.2117903-1-jakub@cloudflare.com>
References: <20200531082846.2117903-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Code for printing link attach_type is duplicated in a couple of places, and
likely will be duplicated for future link types as well. Create helpers to
prevent duplication.

Suggested-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/bpf/bpftool/link.c | 44 ++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index 670a561dc31b..1ff416eff3d7 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -62,6 +62,15 @@ show_link_header_json(struct bpf_link_info *info, json_writer_t *wtr)
 	jsonw_uint_field(json_wtr, "prog_id", info->prog_id);
 }
 
+static void show_link_attach_type_json(__u32 attach_type, json_writer_t *wtr)
+{
+	if (attach_type < ARRAY_SIZE(attach_type_name))
+		jsonw_string_field(wtr, "attach_type",
+				   attach_type_name[attach_type]);
+	else
+		jsonw_uint_field(wtr, "attach_type", attach_type);
+}
+
 static int get_prog_info(int prog_id, struct bpf_prog_info *info)
 {
 	__u32 len = sizeof(*info);
@@ -105,22 +114,13 @@ static int show_link_close_json(int fd, struct bpf_link_info *info)
 			jsonw_uint_field(json_wtr, "prog_type",
 					 prog_info.type);
 
-		if (info->tracing.attach_type < ARRAY_SIZE(attach_type_name))
-			jsonw_string_field(json_wtr, "attach_type",
-			       attach_type_name[info->tracing.attach_type]);
-		else
-			jsonw_uint_field(json_wtr, "attach_type",
-					 info->tracing.attach_type);
+		show_link_attach_type_json(info->tracing.attach_type,
+					   json_wtr);
 		break;
 	case BPF_LINK_TYPE_CGROUP:
 		jsonw_lluint_field(json_wtr, "cgroup_id",
 				   info->cgroup.cgroup_id);
-		if (info->cgroup.attach_type < ARRAY_SIZE(attach_type_name))
-			jsonw_string_field(json_wtr, "attach_type",
-			       attach_type_name[info->cgroup.attach_type]);
-		else
-			jsonw_uint_field(json_wtr, "attach_type",
-					 info->cgroup.attach_type);
+		show_link_attach_type_json(info->cgroup.attach_type, json_wtr);
 		break;
 	default:
 		break;
@@ -153,6 +153,14 @@ static void show_link_header_plain(struct bpf_link_info *info)
 	printf("prog %u  ", info->prog_id);
 }
 
+static void show_link_attach_type_plain(__u32 attach_type)
+{
+	if (attach_type < ARRAY_SIZE(attach_type_name))
+		printf("attach_type %s  ", attach_type_name[attach_type]);
+	else
+		printf("attach_type %u  ", attach_type);
+}
+
 static int show_link_close_plain(int fd, struct bpf_link_info *info)
 {
 	struct bpf_prog_info prog_info;
@@ -176,19 +184,11 @@ static int show_link_close_plain(int fd, struct bpf_link_info *info)
 		else
 			printf("\n\tprog_type %u  ", prog_info.type);
 
-		if (info->tracing.attach_type < ARRAY_SIZE(attach_type_name))
-			printf("attach_type %s  ",
-			       attach_type_name[info->tracing.attach_type]);
-		else
-			printf("attach_type %u  ", info->tracing.attach_type);
+		show_link_attach_type_plain(info->tracing.attach_type);
 		break;
 	case BPF_LINK_TYPE_CGROUP:
 		printf("\n\tcgroup_id %zu  ", (size_t)info->cgroup.cgroup_id);
-		if (info->cgroup.attach_type < ARRAY_SIZE(attach_type_name))
-			printf("attach_type %s  ",
-			       attach_type_name[info->cgroup.attach_type]);
-		else
-			printf("attach_type %u  ", info->cgroup.attach_type);
+		show_link_attach_type_plain(info->cgroup.attach_type);
 		break;
 	default:
 		break;
-- 
2.25.4

