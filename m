Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A5058941C
	for <lists+bpf@lfdr.de>; Wed,  3 Aug 2022 23:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237044AbiHCVmS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 3 Aug 2022 17:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233950AbiHCVmS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Aug 2022 17:42:18 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592204D823
        for <bpf@vger.kernel.org>; Wed,  3 Aug 2022 14:42:17 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 273F7YKT001252
        for <bpf@vger.kernel.org>; Wed, 3 Aug 2022 14:42:16 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3hqbqx7pty-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 03 Aug 2022 14:42:16 -0700
Received: from twshared22246.03.prn5.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 3 Aug 2022 14:42:14 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id DE67B1D2FFE58; Wed,  3 Aug 2022 14:42:02 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next] libbpf: reject legacy 'maps' ELF section
Date:   Wed, 3 Aug 2022 14:42:02 -0700
Message-ID: <20220803214202.23750-1-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: fajYMYxtIG--aORfPoL5RaTdHj0y-NIT
X-Proofpoint-GUID: fajYMYxtIG--aORfPoL5RaTdHj0y-NIT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-03_06,2022-08-02_01,2022-06-22_01
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add explicit error message if BPF object file is still using legacy BPF
map definitions in SEC("maps"). Before this change, if BPF object file
is still using legacy map definition user will see a bit confusing:

libbpf: elf: skipping unrecognized data section(4) maps
libbpf: prog 'handler': bad map relo against 'server_map' in section 'maps'

Now libbpf will be explicit about rejecting "maps" ELF section:

libbpf: elf: legacy map definitions in 'maps' section are not supported by libbpf v1.0+

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 50d41815f431..d9a3f4383a7a 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -591,7 +591,6 @@ struct elf_state {
 	size_t strtabidx;
 	struct elf_sec_desc *secs;
 	int sec_cnt;
-	int maps_shndx;
 	int btf_maps_shndx;
 	__u32 btf_maps_sec_btf_id;
 	int text_shndx;
@@ -1272,7 +1271,6 @@ static struct bpf_object *bpf_object__new(const char *path,
 	 */
 	obj->efile.obj_buf = obj_buf;
 	obj->efile.obj_buf_sz = obj_buf_sz;
-	obj->efile.maps_shndx = -1;
 	obj->efile.btf_maps_shndx = -1;
 	obj->efile.st_ops_shndx = -1;
 	obj->kconfig_map_idx = -1;
@@ -3359,7 +3357,8 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
 			if (err)
 				return err;
 		} else if (strcmp(name, "maps") == 0) {
-			obj->efile.maps_shndx = idx;
+			pr_warn("elf: legacy map definitions in 'maps' section are not supported by libbpf v1.0+\n");
+			return -ENOTSUP;
 		} else if (strcmp(name, MAPS_ELF_SEC) == 0) {
 			obj->efile.btf_maps_shndx = idx;
 		} else if (strcmp(name, BTF_ELF_SEC) == 0) {
@@ -3891,8 +3890,7 @@ static bool bpf_object__shndx_is_data(const struct bpf_object *obj,
 static bool bpf_object__shndx_is_maps(const struct bpf_object *obj,
 				      int shndx)
 {
-	return shndx == obj->efile.maps_shndx ||
-	       shndx == obj->efile.btf_maps_shndx;
+	return shndx == obj->efile.btf_maps_shndx;
 }
 
 static enum libbpf_map_type
-- 
2.30.2

