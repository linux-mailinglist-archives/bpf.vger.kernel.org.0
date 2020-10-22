Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591A9296585
	for <lists+bpf@lfdr.de>; Thu, 22 Oct 2020 21:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370385AbgJVTwE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 22 Oct 2020 15:52:04 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54396 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2509834AbgJVTwE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 22 Oct 2020 15:52:04 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09MJnZNF016638
        for <bpf@vger.kernel.org>; Thu, 22 Oct 2020 12:52:03 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34aspdf8b4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 22 Oct 2020 12:52:03 -0700
Received: from intmgw003.08.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 22 Oct 2020 12:52:02 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id C0D152EC835C; Thu, 22 Oct 2020 12:51:50 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <dwarves@vger.kernel.org>, <acme@kernel.org>
CC:     <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v2 dwarves] btf_loader: handle union forward declaration properly
Date:   Thu, 22 Oct 2020 12:51:48 -0700
Message-ID: <20201022195148.3425366-1-andrii@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-22_15:2020-10-20,2020-10-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1034
 lowpriorityscore=0 bulkscore=0 spamscore=0 mlxscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010220128
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Differentiate between struct and union forwards in BTF. BTF type representing
forward declaration (BTF_KIND_FWD) encodes whether the forward declaration is
for struct or union type by using kflag. So use that kflag to create a proper
internal representation of forward declaration.

Tested with btfdiff on vmlinux:

$ PAHOLE=build/pahole ./btfdiff ~/linux-build/default/vmlinux | wc -l
0

Also tested manually:

$ cat test.c
struct struct_fwd;

union union_fwd;

struct s {
        struct struct_fwd *f1;
        union union_fwd *f2;
};

int func(struct s *s) {
        return !!s->f1 + !!s->f2;
}
$ clang -g -target bpf -c test.c -o test.o
$ bpftool btf dump file test.o | grep fwd_kind
[6] FWD 'struct_fwd' fwd_kind=struct
[8] FWD 'union_fwd' fwd_kind=union
$ build/pahole -F btf test.o
struct s {
        struct struct_fwd *        f1;                   /*     0     8 */
        union union_fwd *          f2;                   /*     8     8 */

        /* size: 16, cachelines: 1, members: 2 */
        /* last cacheline: 16 bytes */
};

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 btf_loader.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/btf_loader.c b/btf_loader.c
index 9b5da3a4997a..6ea207ea65b4 100644
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
+	struct class *fwd = class__new(tp->name_off, 0, btf_kflag(tp));
 
 	if (fwd == NULL)
 		return -ENOMEM;
-- 
2.24.1

