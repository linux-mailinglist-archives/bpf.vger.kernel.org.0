Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A1E2891B1
	for <lists+bpf@lfdr.de>; Fri,  9 Oct 2020 21:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388640AbgJIT0X convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 9 Oct 2020 15:26:23 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58402 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731624AbgJIT0W (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 9 Oct 2020 15:26:22 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 099JPRO8024216
        for <bpf@vger.kernel.org>; Fri, 9 Oct 2020 12:26:20 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 3429gwdf0e-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2020 12:26:20 -0700
Received: from intmgw003.03.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 9 Oct 2020 12:26:19 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id 0783F2EC7D45; Fri,  9 Oct 2020 12:26:18 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <dwarves@vger.kernel.org>, <acme@kernel.org>
CC:     <bpf@vger.kernel.org>, <kernel-team@fb.com>, <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH dwarves] btf_loader: handle union forward declaration properly
Date:   Fri, 9 Oct 2020 12:26:07 -0700
Message-ID: <20201009192607.699835-1-andrii@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-FB-Internal: Safe
Content-Type: text/plain
Content-Transfer-Encoding: 8BIT
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-09_12:2020-10-09,2020-10-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 malwarescore=0 impostorscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010090140
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Differentiate between struct and union forwards. For BTF_KIND_FWD this is
determined by kflag. So teach btf_loader to use that bit to decide whether
forward is for union or struct.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
N.B. This patch is based on top of tmp.libbtf_encoder branch.

Also seems like non-forward declared union has a slightly different
representation from struct (class). Not sure why it is so, but this change
doesn't seem to break anything.
---

 btf_loader.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/btf_loader.c b/btf_loader.c
index 9b5da3a4997a..0cb23967fec3 100644
--- a/btf_loader.c
+++ b/btf_loader.c
@@ -134,12 +134,13 @@ static struct type *type__new(uint16_t tag, strings_t name, size_t size)
 	return type;
 }
 
-static struct class *class__new(strings_t name, size_t size)
+static struct class *class__new(strings_t name, size_t size, bool is_union)
 {
 	struct class *class = tag__alloc(sizeof(*class));
+	uint32_t tag = is_union ? DW_TAG_union_type : DW_TAG_structure_type;
 
 	if (class != NULL) {
-		type__init(&class->type, DW_TAG_structure_type, name, size);
+		type__init(&class->type, tag, name, size);
 		INIT_LIST_HEAD(&class->vtable);
 	}
 
@@ -228,7 +229,7 @@ static int create_members(struct btf_elf *btfe, const struct btf_type *tp,
 
 static int create_new_class(struct btf_elf *btfe, const struct btf_type *tp, uint32_t id)
 {
-	struct class *class = class__new(tp->name_off, tp->size);
+	struct class *class = class__new(tp->name_off, tp->size, false);
 	int member_size = create_members(btfe, tp, &class->type);
 
 	if (member_size < 0)
@@ -313,7 +314,7 @@ static int create_new_subroutine_type(struct btf_elf *btfe, const struct btf_typ
 
 static int create_new_forward_decl(struct btf_elf *btfe, const struct btf_type *tp, uint32_t id)
 {
-	struct class *fwd = class__new(tp->name_off, 0);
+	struct class *fwd = class__new(tp->name_off, 0, btf_kind(tp));
 
 	if (fwd == NULL)
 		return -ENOMEM;
-- 
2.24.1

