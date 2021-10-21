Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C2D43586C
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 03:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhJUBq5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 20 Oct 2021 21:46:57 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:15680 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230286AbhJUBq4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 20 Oct 2021 21:46:56 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19KNAfVw016382
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 18:44:41 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3btct0yyqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 18:44:41 -0700
Received: from intmgw002.46.prn1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 20 Oct 2021 18:44:41 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id C94706E3E1DD; Wed, 20 Oct 2021 18:44:33 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Stanislav Fomichev <sdf@google.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH v2 bpf-next 09/10] libbpf: simplify look up by name of internal maps
Date:   Wed, 20 Oct 2021 18:44:03 -0700
Message-ID: <20211021014404.2635234-10-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211021014404.2635234-1-andrii@kernel.org>
References: <20211021014404.2635234-1-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-FB-Internal: Safe
X-FB-Source: Intern
X-Proofpoint-GUID: k4cAgkWH6mJnwNjFHlts76DfHBCNvT83
X-Proofpoint-ORIG-GUID: k4cAgkWH6mJnwNjFHlts76DfHBCNvT83
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-20_06,2021-10-20_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 mlxscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110210008
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Map name that's assigned to internal maps (.rodata, .data, .bss, etc)
consist of a small prefix of bpf_object's name and ELF section name as
a suffix. This makes it hard for users to "guess" the name to use for
looking up by name with bpf_object__find_map_by_name() API.

One proposal was to drop object name prefix from the map name and just
use ".rodata", ".data", etc, names. One downside called out was that
when multiple BPF applications are active on the host, it will be hard
to distinguish between multiple instances of .rodata and know which BPF
object (app) they belong to. Having few first characters, while quite
limiting, still can give a bit of a clue, in general.

Note, though, that btf_value_type_id for such global data maps (ARRAY)
points to DATASEC type, which encodes full ELF name, so tools like
bpftool can take advantage of this fact to "recover" full original name
of the map. This is also the reason why for custom .data.* and .rodata.*
maps libbpf uses only their ELF names and doesn't prepend object name at
all.

Another downside of such approach is that it is not backwards compatible
and, among direct use of bpf_object__find_map_by_name() API, will break
any BPF skeleton generated using bpftool that was compiled with older
libbpf version.

Instead of causing all this pain, libbpf will still generate map name
using a combination of object name and ELF section name, but it will
allow looking such maps up by their natural names, which correspond to
their respective ELF section names. This means non-truncated ELF section
names longer than 15 characters are going to be expected and supported.

With such set up, we get the best of both worlds: leave small bits of
a clue about BPF application that instantiated such maps, as well as
making it easy for user apps to lookup such maps at runtime. In this
sense it closes corresponding libbpf 1.0 issue ([0]).

BPF skeletons will continue using full names for lookups.

  [0] Closes: https://github.com/libbpf/libbpf/issues/275

Cc: Toke Høiland-Jørgensen <toke@redhat.com>
Cc: Stanislav Fomichev <sdf@google.com>
Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 031f4611e0ff..db6e48014839 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9043,6 +9043,16 @@ bpf_object__find_map_by_name(const struct bpf_object *obj, const char *name)
 	struct bpf_map *pos;
 
 	bpf_object__for_each_map(pos, obj) {
+		/* if it's a special internal map name (which always starts
+		 * with dot) then check if that special name matches the
+		 * real map name (ELF section name)
+		 */
+		if (name[0] == '.') {
+			if (pos->real_name && strcmp(pos->real_name, name) == 0)
+				return pos;
+			continue;
+		}
+		/* otherwise map name has to be an exact match */
 		if (map_uses_real_name(pos)) {
 			if (strcmp(pos->real_name, name) == 0)
 				return pos;
-- 
2.30.2

