Return-Path: <bpf+bounces-8845-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C2B78B28A
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 16:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73250280D1A
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 14:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD4A12B7F;
	Mon, 28 Aug 2023 14:04:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E57D11C9D
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 14:04:43 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D12E106
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 07:04:40 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bdca7cc28dso25570445ad.1
        for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 07:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693231479; x=1693836279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wNLY2ksX3Gu1E4SdAcj8fjoQjwPOn1Ni18OG53r4QzM=;
        b=FV9gYqzeJgIZtbJeNsbQWqhRUviFi0uRwd7CiC6kuihUudj7wfxLbWM7q3tuiouTpB
         2TphT1BCOPuXvCfv1l8zePwgcvbgLzatLngdYG6ivPEUlXu55WULZZAGvk/qBjxlgknI
         a5iU2/0CfhNW9YI64fUru9EKljNhgzu46xRZV6+IwtHn83UdNjO/Tg0Zv2eP6cT1pO+D
         GeBm2nSH48BF7DFWvfI23ycWvA8n2mzNq4JyiWxVCWUfXmu4P7AlMnFVtOHT9NZngvgJ
         jaOc0O7DyHaGkzDJpPwD8Tm5J37jAdLRUtxcjOK81/XewYMjFMGp4//epIHMSEkL+diq
         liAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693231479; x=1693836279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wNLY2ksX3Gu1E4SdAcj8fjoQjwPOn1Ni18OG53r4QzM=;
        b=Qx4obIrTYaYMVJ/+RsthHyUTIv7elvSL6j4ifIOL1EKaA0Wi7mE3yvmn8GgdwGqr5c
         dsFBY3o8edgyJLsMvrQyRXu8Mzk/swQ6IZ4pFbgSCsSslUQ6YwvchLXRSnGS7oUlGfzS
         mRZxsoDanex9exjZs8HQCFeIp+FVwoX0bIWt+5GEtQl1WnGerkuBpI304Mjg1mNuk9Jw
         LE4HJ+FwnTBqEZ5+tqdKIaycin07qc+r1L7sEIcp6yyoH3iQou83/5aFxaUnp7F9R97I
         2Xaz4CZe8wu6yMBWAxqc5iLfDvgFOspoMSmkpI7r+44OPOh0hbf7kEuKniRL42iNn7o8
         oeJA==
X-Gm-Message-State: AOJu0Yw+1+lJ3dFWW10P2+xVerydwJhT5KxCCIPpF0BxkTFozQna4ofD
	lilAtrhTKHZw53CydzNWsP0oVWPmoDiW98Ly
X-Google-Smtp-Source: AGHT+IFOKcutAmr03luSKTc5pHTvu5inZziuGaFP+Xc107XbRZ7L8yOUrL4LR+9dYK4dsu3pKgA1zA==
X-Received: by 2002:a17:902:e803:b0:1c0:77b8:bb10 with SMTP id u3-20020a170902e80300b001c077b8bb10mr25702103plg.10.1693231479381;
        Mon, 28 Aug 2023 07:04:39 -0700 (PDT)
Received: from chenhengqi-x1.. ([120.229.73.2])
        by smtp.gmail.com with ESMTPSA id e2-20020a170902b78200b001bdbe6c86a9sm7348629pls.225.2023.08.28.07.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 07:04:38 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: bpf@vger.kernel.org
Cc: quentin@isovalent.com,
	hengqi.chen@gmail.com
Subject: [PATCH bpf-next] bpftool: Support dumping BTF object by name
Date: Mon, 28 Aug 2023 22:04:25 +0800
Message-Id: <20230828140425.466174-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Like maps and progs, add support to dump BTF
objects by name ([0]).

  [0] Closes: https://github.com/libbpf/bpftool/issues/56

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 tools/bpf/bpftool/btf.c | 92 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 91 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 91fcb75babe3..cb8d78ff4081 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -547,6 +547,83 @@ static bool btf_is_kernel_module(__u32 btf_id)
 	return btf_info.kernel_btf && strncmp(btf_name, "vmlinux", sizeof(btf_name)) != 0;
 }

+static int btf_id_by_name(char *name, __u32 *btf_id)
+{
+	bool found = false;
+	__u32 id = 0;
+	int fd, err;
+
+	while (true) {
+		struct bpf_btf_info info = {};
+		__u32 len = sizeof(info);
+		char btf_name[64];
+
+		err = bpf_btf_get_next_id(id, &id);
+		if (err) {
+			if (errno == ENOENT) {
+				if (found)
+					err = 0;
+				else
+					p_err("no BTF object match name %s", name);
+				break;
+			}
+
+			p_err("can't get next BTF object: %s%s",
+			      strerror(errno),
+			      errno == EINVAL ? " -- kernel too old?" : "");
+			return -1;
+		}
+
+		fd = bpf_btf_get_fd_by_id(id);
+		if (fd < 0) {
+			p_err("can't get BTF by id (%u): %s",
+			      id, strerror(errno));
+			return -1;
+		}
+
+		err = bpf_btf_get_info_by_fd(fd, &info, &len);
+		if (err) {
+			p_err("can't get BTF info (%u): %s",
+			      id, strerror(errno));
+			goto err_close_fd;
+		}
+
+		if (info.name_len) {
+			memset(&info, 0, sizeof(info));
+			info.name_len = sizeof(btf_name);
+			info.name = ptr_to_u64(btf_name);
+			len = sizeof(info);
+
+			err = bpf_btf_get_info_by_fd(fd, &info, &len);
+			if (err) {
+				p_err("can't get BTF info (%u): %s",
+				      id, strerror(errno));
+				goto err_close_fd;
+			}
+		}
+
+		close(fd);
+
+		if (strncmp(name, u64_to_ptr(info.name), BPF_OBJ_NAME_LEN))
+			continue;
+
+		if (found) {
+			p_err("multiple BTF object match name %s", name);
+			return -1;
+		}
+
+		*btf_id = id;
+		found = true;
+	}
+
+	return err;
+
+err_close_fd:
+	close(fd);
+	return err;
+}
+
+
 static int do_dump(int argc, char **argv)
 {
 	struct btf *btf = NULL, *base = NULL;
@@ -637,6 +714,19 @@ static int do_dump(int argc, char **argv)
 			      *argv, strerror(errno));
 			goto done;
 		}
+		NEXT_ARG();
+	} else if (is_prefix(src, "name")) {
+		char *name = *argv;
+
+		if (strlen(name) > BPF_OBJ_NAME_LEN - 1) {
+			p_err("can't parse name");
+			return -1;
+		}
+
+		err = btf_id_by_name(name, &btf_id);
+		if (err)
+			return -1;
+
 		NEXT_ARG();
 	} else {
 		err = -1;
@@ -1062,7 +1152,7 @@ static int do_help(int argc, char **argv)
 		"       %1$s %2$s dump BTF_SRC [format FORMAT]\n"
 		"       %1$s %2$s help\n"
 		"\n"
-		"       BTF_SRC := { id BTF_ID | prog PROG | map MAP [{key | value | kv | all}] | file FILE }\n"
+		"       BTF_SRC := { id BTF_ID | name NAME | prog PROG | map MAP [{key | value | kv | all}] | file FILE }\n"
 		"       FORMAT  := { raw | c }\n"
 		"       " HELP_SPEC_MAP "\n"
 		"       " HELP_SPEC_PROGRAM "\n"
--
2.34.1

