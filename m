Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8646EC879
	for <lists+bpf@lfdr.de>; Mon, 24 Apr 2023 11:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjDXJKY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Apr 2023 05:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjDXJKX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 05:10:23 -0400
Received: from pv50p00im-ztbu10011701.me.com (pv50p00im-ztbu10011701.me.com [17.58.6.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1D610CC
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 02:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuroa.me; s=sig1;
        t=1682327416; bh=M/sdqbR+vlmXk2rHdpf5e5t4auOLHGIgUY1Nd7rPR/A=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=GpFjU0d1PJNfUU4+ujnHyR3HsqaCpMRTKiq0QD3GuY6FR2DQhl11WHsqjxdrQoqP/
         q/Ev8MionYo7BiMO94+lHGT9I2dujNYkY8jkgWIgWt2s2t2HupHAdDsEwwLKYGI7vw
         FdZTuO2pPIYIwKDwpo/XN/ODTgMa0eYj6EO7SfKFVN2QiNC2fg649Noe18lpVZD8lV
         kTMQTyy7VMg8jXlaxwsCh//kyPWOzPa1K8Wjcof1UWNLIucXPRFzUXTVnZz++nMnbY
         bFSsrojI2QOaYOoaefJIzqwiETL9BEwaFXtgECYWcPbkQMugDvFrQeWzSByGVfKBTM
         LWGnt6tEyGD6w==
Received: from localhost.localdomain (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-ztbu10011701.me.com (Postfix) with ESMTPSA id 256FE7403B6;
        Mon, 24 Apr 2023 09:10:11 +0000 (UTC)
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
Subject: [PATCH bpf-next v2] bpftool: Dump map id instead of value for map_of_maps types
Date:   Mon, 24 Apr 2023 17:09:35 +0800
Message-Id: <20230424090935.52707-1-kuro@kuroa.me>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: zOockGF0ejbAe429Ws_nol25-ZSefIZ8
X-Proofpoint-GUID: zOockGF0ejbAe429Ws_nol25-ZSefIZ8
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.883,17.11.64.514.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F08:2022-06-21=5F01,2022-06-21=5F08,2022-02-23?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1030 adultscore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2304240081
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When using `bpftool map dump` in plain format, it is usually
more convenient to show the inner map id instead of raw value.
Changing this behavior would help with quick debugging with
`bpftool`, without disrupting scripted behavior. Since user
could dump the inner map with id, and need to convert value.

Signed-off-by: Xueming Feng <kuro@kuroa.me>
---
Changes in v2:
  - Fix commit message grammar.
	- Change `print_uint` to only print to stdout, make `arg` const, and rename 
	  `n` to `arg_size`.
  - Make `print_uint` able to take any size of argument up to `unsigned long`, 
		and print it as unsigned decimal.

Thanks for the review and suggestions! I have changed my patch accordingly.
There is a possibility that `arg_size` is larger than `unsigned long`,
but previous review suggested that it should be up to the caller function to 
set `arg_size` correctly. So I didn't add check for that, should I?

 tools/bpf/bpftool/main.c | 15 +++++++++++++++
 tools/bpf/bpftool/main.h |  1 +
 tools/bpf/bpftool/map.c  |  9 +++++++--
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index 08d0ac543c67..810c0dc10ecb 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -251,6 +251,21 @@ int detect_common_prefix(const char *arg, ...)
 	return 0;
 }
 
+void print_uint(const void *arg, unsigned int arg_size)
+{
+	const unsigned char *data = arg;
+	unsigned long val = 0ul;
+
+	#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+		memcpy(&val, data, arg_size);
+	#else
+		memcpy((unsigned char *)&val + sizeof(val) - arg_size,
+		       data, arg_size);
+	#endif
+
+	fprintf(stdout, "%lu", val);
+}
+
 void fprint_hex(FILE *f, void *arg, unsigned int n, const char *sep)
 {
 	unsigned char *data = arg;
diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 0ef373cef4c7..0de671423431 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -90,6 +90,7 @@ void __printf(1, 2) p_info(const char *fmt, ...);
 
 bool is_prefix(const char *pfx, const char *str);
 int detect_common_prefix(const char *arg, ...);
+void print_uint(const void *arg, unsigned int arg_size);
 void fprint_hex(FILE *f, void *arg, unsigned int n, const char *sep);
 void usage(void) __noreturn;
 
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index aaeb8939e137..f5be4c0564cf 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -259,8 +259,13 @@ static void print_entry_plain(struct bpf_map_info *info, unsigned char *key,
 		}
 
 		if (info->value_size) {
-			printf("value:%c", break_names ? '\n' : ' ');
-			fprint_hex(stdout, value, info->value_size, " ");
+			if (map_is_map_of_maps(info->type)) {
+				printf("id:%c", break_names ? '\n' : ' ');
+				print_uint(value, info->value_size);
+			} else {
+				printf("value:%c", break_names ? '\n' : ' ');
+				fprint_hex(stdout, value, info->value_size, " ");
+			}
 		}
 
 		printf("\n");
-- 
2.37.1 (Apple Git-137.1)

