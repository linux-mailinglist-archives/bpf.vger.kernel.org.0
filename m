Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99456EA840
	for <lists+bpf@lfdr.de>; Fri, 21 Apr 2023 12:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjDUKW6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Apr 2023 06:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjDUKW5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Apr 2023 06:22:57 -0400
X-Greylist: delayed 588 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 21 Apr 2023 03:22:15 PDT
Received: from pv50p00im-ztdg10011301.me.com (pv50p00im-ztdg10011301.me.com [17.58.6.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0836C16B
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 03:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuroa.me; s=sig1;
        t=1682071923; bh=9LouxiBlmrmKuY4D4L114DxgCvo/TJdTAEmNocqna70=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=I7oHR8CUHrXpp00K5C88NdBdNLJvY/3rRPV2L72jQGXvRDpfRnOiaS45iy3QGPHzH
         xQXs68VeBtcIgg6C57mS/JbpMmOTIW924gBAwRruZZckAzGMxYNxC5YXU5uHwGhidj
         H4z+5bMizkzElg4vMfNRRVFMsSvpuK5hUNEf48DQkj7Waq5KLl5Mv6z/9iQ6/QL+To
         6aeWIum9Z8yHnr6rblJcVt/8Znt64xPK0uN32J1YAfSRqHo+CppuNUROvFD+VSAca8
         rTTsS/OvrnroQklZPb+xp98mM6utnWRlJmjDC9Np1FLBYNh6iDtBmmag3wSy5Wlqzg
         iUikfYHNQRzQA==
Received: from localhost.localdomain (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-ztdg10011301.me.com (Postfix) with ESMTPSA id 71B741801D9;
        Fri, 21 Apr 2023 10:11:59 +0000 (UTC)
From:   Xueming Feng <kuro@kuroa.me>
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xueming Feng <kuro@kuroa.me>
Subject: [PATCH] Dump map id instead of value for map_of_maps types
Date:   Fri, 21 Apr 2023 18:11:54 +0800
Message-Id: <20230421101154.23690-1-kuro@kuroa.me>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: wVywTRvN0KikguucsLYVn11XDAQRkNGT
X-Proofpoint-ORIG-GUID: wVywTRvN0KikguucsLYVn11XDAQRkNGT
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.572,17.11.64.514.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F01:2022-06-21=5F01,2020-02-14=5F11,2022-02-23?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=862
 adultscore=0 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 clxscore=1030 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2304210088
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When using `bpftool map dump` in plain format, it is usually
more convenient to show the inner map id instead of raw value.
Changing this behavior would help with quick debugging with
`bpftool`, without disruption scripted behavior. Since user
could dump the inner map with id, but need to convert value.

Signed-off-by: Xueming Feng <kuro@kuroa.me>
---
 tools/bpf/bpftool/main.c | 16 ++++++++++++++++
 tools/bpf/bpftool/main.h |  1 +
 tools/bpf/bpftool/map.c  |  9 +++++++--
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index 08d0ac543c67..d297200c91f7 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -251,6 +251,22 @@ int detect_common_prefix(const char *arg, ...)
 	return 0;
 }
 
+void fprint_uint(FILE *f, void *arg, unsigned int n)
+{
+	unsigned char *data = arg;
+	unsigned int data_uint = 0;
+
+	for (unsigned int i = 0; i < n && i < 4; i++) {
+	#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+		data_uint |= data[i] << (i * 8);
+	#else
+		data_uint |= data[i] << ((n - i - 1) * 8);
+	#endif
+	}
+
+	fprintf(f, "%d", data_uint);
+}
+
 void fprint_hex(FILE *f, void *arg, unsigned int n, const char *sep)
 {
 	unsigned char *data = arg;
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 0ef373cef4c7..7488ef38e7a9 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -90,6 +90,7 @@ void __printf(1, 2) p_info(const char *fmt, ...);
 
 bool is_prefix(const char *pfx, const char *str);
 int detect_common_prefix(const char *arg, ...);
+void fprint_uint(FILE *f, void *arg, unsigned int n);
 void fprint_hex(FILE *f, void *arg, unsigned int n, const char *sep);
 void usage(void) __noreturn;
 
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index aaeb8939e137..638bd8de8135 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -259,8 +259,13 @@ static void print_entry_plain(struct bpf_map_info *info, unsigned char *key,
 		}
 
 		if (info->value_size) {
-			printf("value:%c", break_names ? '\n' : ' ');
-			fprint_hex(stdout, value, info->value_size, " ");
+			if (map_is_map_of_maps(info->type)) {
+				printf("id:%c", break_names ? '\n' : ' ');
+				fprint_uint(stdout, value, info->value_size);
+			} else {
+				printf("value:%c", break_names ? '\n' : ' ');
+				fprint_hex(stdout, value, info->value_size, " ");
+			}
 		}
 
 		printf("\n");
-- 
2.37.1 (Apple Git-137.1)

