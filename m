Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033A46F0022
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 06:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242745AbjD0EUJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 00:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239605AbjD0EUF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 00:20:05 -0400
Received: from pv50p00im-hyfv10021501.me.com (pv50p00im-hyfv10021501.me.com [17.58.6.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4B62D73
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 21:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuroa.me; s=sig1;
        t=1682569202; bh=NjHmeX5/5YWb0KrtA8dXibV4xoGQyqlvMwQ9oeLChCY=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=VU18TfG5f9ZdE26XAq2zd6ihTzH+IswvT0GYWeL6BPiqSUlFRflzbuqhlzT/adX4G
         B51mAeNYOkZ1UwMNTtudbVGtBgHoTSy9sfd36RucKTqYkRJ0+nl9Jr0tY4dtIV131T
         TsVAA13YW8G4xdU39lvFITWGysWmRUyTgLkH18Al5mUnXgX6gshXbvHSNQ+lpb6l0h
         O1VeC12ekhawLzztiZ8QR2v6g3aCq0/z8gU9/MQisJVuUUKXDaD/UsbqSYQ4V/N3DC
         uPM4njGYPJWjDcmfZwQ9fitbMNgrtnaGhDLy0wI6OaUzv+XlvvknTFRl/De39hwp9r
         Q8d8XxKZMRi+A==
Received: from localhost.localdomain (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-hyfv10021501.me.com (Postfix) with ESMTPSA id 95FB32C0283;
        Thu, 27 Apr 2023 04:19:57 +0000 (UTC)
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
Subject: [PATCH bpf-next v3] bpftool: Dump map id instead of value for map_of_maps types
Date:   Thu, 27 Apr 2023 12:19:49 +0800
Message-Id: <20230427041949.93752-1-kuro@kuroa.me>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: eUiaztbSIHcM1W_QfcSb9ixks5qo62A-
X-Proofpoint-ORIG-GUID: eUiaztbSIHcM1W_QfcSb9ixks5qo62A-
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.572,17.11.64.514.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F01:2022-06-21=5F01,2020-02-14=5F11,2022-02-23?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 clxscore=1030 mlxlogscore=999 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2304270037
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
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

Sorry for taking this long, my compiling machine is acting weird. And thanks for
the reviews and suggestions!

 tools/bpf/bpftool/map.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index aaeb8939e137..afcd8455db74 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -139,6 +139,10 @@ static void print_entry_json(struct bpf_map_info *info, unsigned char *key,
 		print_hex_data_json(key, info->key_size);
 		jsonw_name(json_wtr, "value");
 		print_hex_data_json(value, info->value_size);
+		if (map_is_map_of_maps(info->type)) {
+			jsonw_uint_field(json_wtr, "inner_map_id",
+					 *(unsigned int *)value);
+		}
 		if (btf) {
 			struct btf_dumper d = {
 				.btf = btf,
@@ -259,8 +263,13 @@ static void print_entry_plain(struct bpf_map_info *info, unsigned char *key,
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

