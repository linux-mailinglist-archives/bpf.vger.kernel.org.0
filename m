Return-Path: <bpf+bounces-2111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7ADB727CFA
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 12:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D2B42815F8
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 10:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADE01095E;
	Thu,  8 Jun 2023 10:35:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B480C8FD
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 10:35:47 +0000 (UTC)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76912738
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 03:35:45 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-6260e8a1424so3508036d6.2
        for <bpf@vger.kernel.org>; Thu, 08 Jun 2023 03:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686220545; x=1688812545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPqi6o92g3CsXbO/7xcmBvCyD1k9IeMV6B5FbznM9F4=;
        b=cStFsMUA3zKxG+fm2RYeNAzy0zRDGNydPdtJvCN40w/zyx3fpNYgHvn0YV570nHGAO
         g5o0aJoKizDK1dG0nsY/bUgN/gSboGcX2mNgc/ALu48SGh2qtAG5ZMigvxaWF5RSMg3F
         0FYtvG+MUNlaKg3pt9koiiGx7IWjCNwaqNU8DvEQqeFctezlSKzg/8Ur0w2otoomKjIp
         Kdfe/b6MBYnOv5KZYitDMNJczUYlypEQOzPYC5XiGULCBz/ATY60O41tNgXIAkUCyZUi
         EOU1SstIIosj3l9/Gs65xYCbJNFQFDTxZfcCn7J4exZC37daxqN4YSlkDeCVdpbq/0iv
         kP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686220545; x=1688812545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPqi6o92g3CsXbO/7xcmBvCyD1k9IeMV6B5FbznM9F4=;
        b=QITExv5dIkCz6OHUeOB9KOohsSFp9tYlCnVPDOVfihFP/8D5U5Wp3uznfZEYl6ywsc
         IxAXzQQL7QkJjcl8A3l4iUog2zFKFkC6+n7UCJRtSvSF60DhgQAkk6hqexAR3NMx7DXA
         H0TD2zf18g7uVSQkpXM0+bTMzBzCXzE5QHYoyyPkzSfGLyRfrzKez75y57FeyG+PA2g1
         giAIZOKXutknY8NPNcBKAQswkn1ZzhVkMVYLUAzuBI24e14QOeuqwXkyVSoi4gO4BaKU
         mHiQ+im/RTWMf0rOMAzz1GQm/AcYqWtfaDUytgQTQxi9NTJoaJlrCMljVyXQXwvXIaba
         V1IQ==
X-Gm-Message-State: AC+VfDwKlCJYorlvE26qVON33Olee8X2fY4xfAazoFgdfwr79FjHrTKa
	3WGkpbKcR6Drm0fTxgqzn94=
X-Google-Smtp-Source: ACHHUZ5DE1Ya43rpmkskVqAu66jO1hTU9QEP6nHZpbdHVm4/kDLNGxfRJ/kp5i9PIfp0jc7n5Yr+7g==
X-Received: by 2002:a05:6214:2241:b0:629:78ae:80f0 with SMTP id c1-20020a056214224100b0062978ae80f0mr1185588qvc.8.1686220544697;
        Thu, 08 Jun 2023 03:35:44 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:1000:2418:5400:4ff:fe77:b548])
        by smtp.gmail.com with ESMTPSA id p16-20020a0cf550000000b0062839fc6e36sm302714qvm.70.2023.06.08.03.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 03:35:44 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	quentin@isovalent.com
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2 bpf-next 10/11] bpftool: Move get_prog_info() into do_show_link()
Date: Thu,  8 Jun 2023 10:35:22 +0000
Message-Id: <20230608103523.102267-11-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230608103523.102267-1-laoar.shao@gmail.com>
References: <20230608103523.102267-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

As a preparation for a subsequent change, the function get_prog_info() is
moved into do_show_link() with no functional alteration. This adjustment
paves the way for the upcoming modification.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/bpf/bpftool/link.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index c8033c3..a2b75f4 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -195,11 +195,10 @@ static int get_prog_info(int prog_id, struct bpf_prog_info *info)
 	kernel_syms_destroy(&dd);
 }
 
-static int show_link_close_json(int fd, struct bpf_link_info *info)
+static int show_link_close_json(int fd, struct bpf_link_info *info,
+				const struct bpf_prog_info *prog_info)
 {
-	struct bpf_prog_info prog_info;
 	const char *prog_type_str;
-	int err;
 
 	jsonw_start_object(json_wtr);
 
@@ -211,16 +210,12 @@ static int show_link_close_json(int fd, struct bpf_link_info *info)
 				   u64_to_ptr(info->raw_tracepoint.tp_name));
 		break;
 	case BPF_LINK_TYPE_TRACING:
-		err = get_prog_info(info->prog_id, &prog_info);
-		if (err)
-			return err;
-
-		prog_type_str = libbpf_bpf_prog_type_str(prog_info.type);
+		prog_type_str = libbpf_bpf_prog_type_str(prog_info->type);
 		/* libbpf will return NULL for variants unknown to it. */
 		if (prog_type_str)
 			jsonw_string_field(json_wtr, "prog_type", prog_type_str);
 		else
-			jsonw_uint_field(json_wtr, "prog_type", prog_info.type);
+			jsonw_uint_field(json_wtr, "prog_type", prog_info->type);
 
 		show_link_attach_type_json(info->tracing.attach_type,
 					   json_wtr);
@@ -412,11 +407,10 @@ static void show_kprobe_multi_plain(struct bpf_link_info *info)
 	kernel_syms_destroy(&dd);
 }
 
-static int show_link_close_plain(int fd, struct bpf_link_info *info)
+static int show_link_close_plain(int fd, struct bpf_link_info *info,
+				 const struct bpf_prog_info *prog_info)
 {
-	struct bpf_prog_info prog_info;
 	const char *prog_type_str;
-	int err;
 
 	show_link_header_plain(info);
 
@@ -426,16 +420,12 @@ static int show_link_close_plain(int fd, struct bpf_link_info *info)
 		       (const char *)u64_to_ptr(info->raw_tracepoint.tp_name));
 		break;
 	case BPF_LINK_TYPE_TRACING:
-		err = get_prog_info(info->prog_id, &prog_info);
-		if (err)
-			return err;
-
-		prog_type_str = libbpf_bpf_prog_type_str(prog_info.type);
+		prog_type_str = libbpf_bpf_prog_type_str(prog_info->type);
 		/* libbpf will return NULL for variants unknown to it. */
 		if (prog_type_str)
 			printf("\n\tprog_type %s  ", prog_type_str);
 		else
-			printf("\n\tprog_type %u  ", prog_info.type);
+			printf("\n\tprog_type %u  ", prog_info->type);
 
 		show_link_attach_type_plain(info->tracing.attach_type);
 		if (info->tracing.target_obj_id || info->tracing.target_btf_id)
@@ -479,6 +469,7 @@ static int show_link_close_plain(int fd, struct bpf_link_info *info)
 
 static int do_show_link(int fd)
 {
+	struct bpf_prog_info prog_info;
 	struct bpf_link_info info;
 	__u32 len = sizeof(info);
 	__u64 *addrs = NULL;
@@ -486,6 +477,7 @@ static int do_show_link(int fd)
 	int count;
 	int err;
 
+	memset(&prog_info, 0, sizeof(info));
 	memset(&info, 0, sizeof(info));
 again:
 	err = bpf_link_get_info_by_fd(fd, &info, &len);
@@ -495,6 +487,13 @@ static int do_show_link(int fd)
 		close(fd);
 		return err;
 	}
+
+	if (!prog_info.type) {
+		err = get_prog_info(info.prog_id, &prog_info);
+		if (err)
+			return err;
+	}
+
 	if (info.type == BPF_LINK_TYPE_RAW_TRACEPOINT &&
 	    !info.raw_tracepoint.tp_name) {
 		info.raw_tracepoint.tp_name = (unsigned long)&buf;
@@ -523,9 +522,9 @@ static int do_show_link(int fd)
 	}
 
 	if (json_output)
-		show_link_close_json(fd, &info);
+		show_link_close_json(fd, &info, &prog_info);
 	else
-		show_link_close_plain(fd, &info);
+		show_link_close_plain(fd, &info, &prog_info);
 
 	if (addrs)
 		free(addrs);
-- 
1.8.3.1


