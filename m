Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11406F0545
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 14:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243639AbjD0MDj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 08:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243508AbjD0MDi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 08:03:38 -0400
Received: from pv50p00im-ztdg10012101.me.com (pv50p00im-ztdg10012101.me.com [17.58.6.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1A0526F
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 05:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuroa.me; s=sig1;
        t=1682597004; bh=S3tlVFENCWANjkyLbRjurNyqZA+oH0TGefJfiZ+gp9w=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=QwnJDrHGfXK1OKhq/sFx5GoNhy3oX3K2XX7aggC4L0Y9ryLTwlqrvkgzDdjRYskvY
         Xt61rjyytcRNpcac2qsxqJ3OW+YJlqYU/bdC/5XHrLC+8uhShiKmfaMtHPEqhi6S+q
         SWSqUcxv+xNHVqxg6i7AK8bURlCZzxcZFJpwbRuDHNHGFyhO30JttouHWPhSMXQenW
         3R2ux+W/V/NmmxPji5yFTwej/FgA49mei33y+rgFiA+KA0GBR0q0kCfcW10ouGhcUM
         +Mp7Fvl+aBewEhxyuYVuwBcIkhl0Kos/h9Kto2v6L3uhhgVIwlJyEIigvh2bv6yYI/
         JG03fbkCLM2qA==
Received: from localhost.localdomain (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-ztdg10012101.me.com (Postfix) with ESMTPSA id 33A2D7400F0;
        Thu, 27 Apr 2023 12:03:19 +0000 (UTC)
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
Subject: [PATCH bpf-next v4] bpftool: Dump map id instead of value for map_of_maps types
Date:   Thu, 27 Apr 2023 20:03:13 +0800
Message-Id: <20230427120313.43574-1-kuro@kuroa.me>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: BCVk9mO-9Hz41oQRbsPhofC-D2tzs2v8
X-Proofpoint-GUID: BCVk9mO-9Hz41oQRbsPhofC-D2tzs2v8
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.572,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2020-02-14=5F11:2020-02-14=5F02,2020-02-14=5F11,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 clxscore=1030 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2304270106
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When using `bpftool map dump` with map_of_maps, it is usually
more convenient to show the inner map id instead of raw value.

We are changing the plain print behavior to show inner_map_id
instead of hex value, this would help with quick look up of
inner map with `bpftool map dump id <inner_map_id>`.
To avoid disrupting scripted behavior, we will add a new
`inner_map_id` field to json output instead of replacing value.

plain print:
```
$ bpftool map dump id 138

Without Patch:
key:
fc 00 00 00 00 00 00 00  00 00 00 00 00 00 00 05
27 16 06 00
value:
8b 00 00 00
Found 1 element

With Patch:
key:
fc 00 00 00 00 00 00 00  00 00 00 00 00 00 00 05
27 16 06 00
inner_map_id:
139
Found 1 element
```

json print:
```
$ bpftool -p map dump id 567

Without Patch:
[{
        "key": ["0xc0","0x00","0x02","0x05","0x27","0x16","0x06","0x00"
        ],
        "value": ["0x38","0x02","0x00","0x00"
        ]
    }
]

With Patch:
[{
        "key": ["0xc0","0x00","0x02","0x05","0x27","0x16","0x06","0x00"
        ],
        "value": ["0x38","0x02","0x00","0x00"
        ],
        "inner_map_id": 568
    }
]
```

Signed-off-by: Xueming Feng <kuro@kuroa.me>
---

Changes in v4:
 - Remove unnecessary parenthesis ('{}').

Changes in v3:
 - In plain print, use printf() directly since inner map id is always a 32bit int.
 - Remove unused print_uint() function.
 - Rename `id` to `inner_map_id` in plain print output for clearness.
 - Add a new `inner_map_id` field to json output.
 - Add example output to commit message.

Changes in v2:
 - Fix commit message grammar.
 - Change `print_uint` to only print to stdout, make `arg` const, 
   and rename `n` to `arg_size`.
 - Make `print_uint` able to take any size of argument up to `unsigned long`, 
   and print it as unsigned decimal.

 tools/bpf/bpftool/map.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index aaeb8939e137..ae9e822aa3fe 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -139,6 +139,9 @@ static void print_entry_json(struct bpf_map_info *info, unsigned char *key,
 		print_hex_data_json(key, info->key_size);
 		jsonw_name(json_wtr, "value");
 		print_hex_data_json(value, info->value_size);
+		if (map_is_map_of_maps(info->type))
+			jsonw_uint_field(json_wtr, "inner_map_id",
+					 *(unsigned int *)value);
 		if (btf) {
 			struct btf_dumper d = {
 				.btf = btf,
@@ -259,8 +262,13 @@ static void print_entry_plain(struct bpf_map_info *info, unsigned char *key,
 		}
 
 		if (info->value_size) {
-			printf("value:%c", break_names ? '\n' : ' ');
-			fprint_hex(stdout, value, info->value_size, " ");
+			if (map_is_map_of_maps(info->type)) {
+				printf("inner_map_id:%c", break_names ? '\n' : ' ');
+				printf("%u ", *(unsigned int *)value);
+			} else {
+				printf("value:%c", break_names ? '\n' : ' ');
+				fprint_hex(stdout, value, info->value_size, " ");
+			}
 		}
 
 		printf("\n");
-- 
2.37.1 (Apple Git-137.1)

