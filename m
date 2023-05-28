Return-Path: <bpf+bounces-1367-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CA5713A0E
	for <lists+bpf@lfdr.de>; Sun, 28 May 2023 16:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39E0C280E6C
	for <lists+bpf@lfdr.de>; Sun, 28 May 2023 14:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4816A5698;
	Sun, 28 May 2023 14:20:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250F7566E
	for <bpf@vger.kernel.org>; Sun, 28 May 2023 14:20:44 +0000 (UTC)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB660B8
	for <bpf@vger.kernel.org>; Sun, 28 May 2023 07:20:42 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-75b1219506fso151517885a.1
        for <bpf@vger.kernel.org>; Sun, 28 May 2023 07:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685283642; x=1687875642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+1lG7fYk1KAlA2kK4vySeVdKUS0VEfV5ykRXmC3a24=;
        b=HUpk4I9OrwvuC8v9ZP4Rv82epTrtAr30LRiDyxDIRW300E3ox/idingYq/v+vp0Ueo
         2ZCxm+SV2pcstVALLEIqCz9nioW4qrAoCQtzfacdOMO/WpiXH1IALKUjL2FRrehvELIQ
         g9f+70M1g95xGRXTn3RRHgT8sBRx2WHR+CWmqY9e4H432wZXK5mvUBnhIprx6sas4cv4
         txWj7Fxrg5weWk5telO6T/oIsIrsnjna7ZParcYTUiOOLu3Clmn1ExxMWstdnwXB6Nkg
         6xzTSpd0XJwWo7XkDDO0iPS+aTeiuq3pmtn4oUuSUqN1nZL1KD/TNW3CV3eF3O/woGXx
         qHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685283642; x=1687875642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+1lG7fYk1KAlA2kK4vySeVdKUS0VEfV5ykRXmC3a24=;
        b=IA9ILlirqpMK28cG3A7p+2WNgT6Ro9Hivb774FRqBetHPyYgC5qjhKRZXk7kO1o0Gz
         RGdzv3ulxa7fy0Qq++UqUUbo2jdv+Pki9HU24jx4Yighd/wRtc7bvA1ZVueUpk/d13lB
         1dwX+/HyCMfLitlXqrT2xbzo95eliLUUl90rOiPSyl6wGDx6ebziymcVNc6XAOfaWjZe
         rhKNhcp+L1E9RYMo/uMEVmsNXHXOZG4J9GyJ5yq97u1kHxeGtlBUEw+KO0N0fzNLMypZ
         KTmK4+ZndsXHVHZVDM6ENgDAzDyTMHGDOFE3nHKidbsfe4GLlnsffkrdbyoi5W91F540
         EKpQ==
X-Gm-Message-State: AC+VfDwXwDSH9BkMJObZWgdFO95dB+CMcIRTojBFWqnnfjdt1eTaIiOI
	S+cJIyJW84NfBMwQkjPjBOw=
X-Google-Smtp-Source: ACHHUZ6LH3V0exew9UYl+eJEX93578UmtTeeTsy+3Yo732HahjTXiDl7zBelrH8NK197ygj1oKE37g==
X-Received: by 2002:ad4:5be9:0:b0:625:d55:eaab with SMTP id k9-20020ad45be9000000b006250d55eaabmr6991697qvc.9.1685283641695;
        Sun, 28 May 2023 07:20:41 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:5:38f3:5400:4ff:fe74:5668])
        by smtp.gmail.com with ESMTPSA id l11-20020a0cc20b000000b006238dc71f5csm10qvh.144.2023.05.28.07.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 07:20:41 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	quentin@isovalent.com
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 8/8] bpftool: Show probed function in perf_event link info
Date: Sun, 28 May 2023 14:20:27 +0000
Message-Id: <20230528142027.5585-9-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230528142027.5585-1-laoar.shao@gmail.com>
References: <20230528142027.5585-1-laoar.shao@gmail.com>
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

Show the exposed perf_event link info in bpftool. The result as follows,

$ bpftool link show
1: perf_event  prog 5
        func kernel_clone  addr ffffffffb40bc310  offset 0
        bpf_cookie 0
        pids trace(9726)
$ bpftool link show -j
[{"id":1,"type":"perf_event","prog_id":5,"func":"kernel_clone","addr":18446744072435254032,"offset":0,"bpf_cookie":0,"pids":[{"pid":9726,"comm":"trace"}]}]

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/bpf/bpftool/link.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index 76f1bb2..8493a05 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -232,6 +232,12 @@ static int show_link_close_json(int fd, struct bpf_link_info *info)
 			jsonw_lluint(json_wtr, addrs[i]);
 		jsonw_end_array(json_wtr);
 		break;
+	case BPF_LINK_TYPE_PERF_EVENT:
+		jsonw_string_field(json_wtr, "func",
+				   u64_to_ptr(info->perf_event.name));
+		jsonw_uint_field(json_wtr, "addr", info->perf_event.addr);
+		jsonw_uint_field(json_wtr, "offset", info->perf_event.offset);
+		break;
 	default:
 		break;
 	}
@@ -368,7 +374,7 @@ void netfilter_dump_plain(const struct bpf_link_info *info)
 static int show_link_close_plain(int fd, struct bpf_link_info *info)
 {
 	struct bpf_prog_info prog_info;
-	const char *prog_type_str;
+	const char *prog_type_str, *buf;
 	int err;
 
 	show_link_header_plain(info);
@@ -428,6 +434,12 @@ static int show_link_close_plain(int fd, struct bpf_link_info *info)
 			printf(" %0*llx", 16, addrs[i]);
 		}
 		break;
+	case BPF_LINK_TYPE_PERF_EVENT:
+		buf = (const char *)u64_to_ptr(info->perf_event.name);
+		if (buf[0] != '\0' || info->perf_event.addr)
+			printf("\n\tfunc %s  addr %llx  offset %d  ", buf,
+			       info->perf_event.addr, info->perf_event.offset);
+		break;
 	default:
 		break;
 	}
@@ -454,6 +466,7 @@ static int do_show_link(int fd)
 	int count;
 	int err;
 
+	buf[0] = '\0';
 	memset(&info, 0, sizeof(info));
 again:
 	err = bpf_link_get_info_by_fd(fd, &info, &len);
@@ -489,6 +502,12 @@ static int do_show_link(int fd)
 			goto again;
 		}
 	}
+	if (info.type == BPF_LINK_TYPE_PERF_EVENT &&
+	    !info.perf_event.name) {
+		info.perf_event.name = (unsigned long)&buf;
+		info.perf_event.name_len = sizeof(buf);
+		goto again;
+	}
 
 	if (json_output)
 		show_link_close_json(fd, &info);
-- 
1.8.3.1


