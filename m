Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8701619274B
	for <lists+bpf@lfdr.de>; Wed, 25 Mar 2020 12:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgCYLg6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Mar 2020 07:36:58 -0400
Received: from sym2.noone.org ([178.63.92.236]:48974 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbgCYLg6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Mar 2020 07:36:58 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 48nR0l53JjzvjdR; Wed, 25 Mar 2020 12:36:55 +0100 (CET)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org
Subject: [PATCH] libbpf: remove unused parameter `def` to get_map_field_int
Date:   Wed, 25 Mar 2020 12:36:55 +0100
Message-Id: <20200325113655.19341-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Has been unused since commit ef99b02b23ef ("libbpf: capture value in BTF
type info for BTF-defined map defs").

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 tools/lib/bpf/libbpf.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 085e41f9b68e..e9479ad9dd51 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1845,7 +1845,6 @@ resolve_func_ptr(const struct btf *btf, __u32 id, __u32 *res_id)
  * type definition, while using only sizeof(void *) space in ELF data section.
  */
 static bool get_map_field_int(const char *map_name, const struct btf *btf,
-			      const struct btf_type *def,
 			      const struct btf_member *m, __u32 *res)
 {
 	const struct btf_type *t = skip_mods_and_typedefs(btf, m->type, NULL);
@@ -1972,19 +1971,19 @@ static int bpf_object__init_user_btf_map(struct bpf_object *obj,
 			return -EINVAL;
 		}
 		if (strcmp(name, "type") == 0) {
-			if (!get_map_field_int(map_name, obj->btf, def, m,
+			if (!get_map_field_int(map_name, obj->btf, m,
 					       &map->def.type))
 				return -EINVAL;
 			pr_debug("map '%s': found type = %u.\n",
 				 map_name, map->def.type);
 		} else if (strcmp(name, "max_entries") == 0) {
-			if (!get_map_field_int(map_name, obj->btf, def, m,
+			if (!get_map_field_int(map_name, obj->btf, m,
 					       &map->def.max_entries))
 				return -EINVAL;
 			pr_debug("map '%s': found max_entries = %u.\n",
 				 map_name, map->def.max_entries);
 		} else if (strcmp(name, "map_flags") == 0) {
-			if (!get_map_field_int(map_name, obj->btf, def, m,
+			if (!get_map_field_int(map_name, obj->btf, m,
 					       &map->def.map_flags))
 				return -EINVAL;
 			pr_debug("map '%s': found map_flags = %u.\n",
@@ -1992,8 +1991,7 @@ static int bpf_object__init_user_btf_map(struct bpf_object *obj,
 		} else if (strcmp(name, "key_size") == 0) {
 			__u32 sz;
 
-			if (!get_map_field_int(map_name, obj->btf, def, m,
-					       &sz))
+			if (!get_map_field_int(map_name, obj->btf, m, &sz))
 				return -EINVAL;
 			pr_debug("map '%s': found key_size = %u.\n",
 				 map_name, sz);
@@ -2035,8 +2033,7 @@ static int bpf_object__init_user_btf_map(struct bpf_object *obj,
 		} else if (strcmp(name, "value_size") == 0) {
 			__u32 sz;
 
-			if (!get_map_field_int(map_name, obj->btf, def, m,
-					       &sz))
+			if (!get_map_field_int(map_name, obj->btf, m, &sz))
 				return -EINVAL;
 			pr_debug("map '%s': found value_size = %u.\n",
 				 map_name, sz);
@@ -2079,8 +2076,7 @@ static int bpf_object__init_user_btf_map(struct bpf_object *obj,
 			__u32 val;
 			int err;
 
-			if (!get_map_field_int(map_name, obj->btf, def, m,
-					       &val))
+			if (!get_map_field_int(map_name, obj->btf, m, &val))
 				return -EINVAL;
 			pr_debug("map '%s': found pinning = %u.\n",
 				 map_name, val);
-- 
2.26.0

