Return-Path: <bpf+bounces-3009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B361D738280
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 14:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F7DB2815DF
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 12:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BA3156CB;
	Wed, 21 Jun 2023 12:00:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D88A11CB4
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 12:00:23 +0000 (UTC)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE1F186
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 05:00:21 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1a997531cceso5076751fac.3
        for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 05:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687348820; x=1689940820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZzJ9uUY4qIx0cDyPvSa3sHQzl59CVeF22xWqBhupXic=;
        b=KlFr4j7Iq/5dLmEekp/PCuw/Zt+mNZ1RM1EXRaeIOHnGWR0O2vN/c1CrlwG+fAUV9a
         o9qLkTLL+BkagaPGZ6hQm5WbkLFCQY1Eqy9qcEfT9NYr4CVsUduUTjQhSDkpBe0gNpO7
         lUL10hUh671QVYmTht+J7Jh3GDq1JjXipEyUDEG2fiHzHiG13X7jpb1g3ub6sHgib/B/
         BDo5exbx1EacYhs/dxYybqa6jEtqLRquSV7s2haQbFxFphpUvD5gluquZdFCigslTFIp
         6xPvHAZkZROHhHTvl+DRcgz6d02cMlgF3UW6wDS9GJbZ4vypBRUUf19lQ0XBCRg6rjeS
         +zAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687348820; x=1689940820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZzJ9uUY4qIx0cDyPvSa3sHQzl59CVeF22xWqBhupXic=;
        b=lfHzJ3IgOsxT6B/1uQMmzQXpY/RBqieiCIrozQP+YL3Mqn2pjl+XtXRNbxIDKqQzP0
         hqf6pOVlAsbceO9juR6tk6KRGAjLc6/ku9KjtFPUWjVT9Q0YNPo4HVOHpW3FmfofQDZh
         Po+/bYPDJBLyeuCtkss+h6MU1OmsOdXTANRVnUg64tauTTPUlCXg15IPP2jXk9UUR/wL
         tA0XGV2ZbzVJKhX0LN0LJgkega9eGoYoIjfeQQVLh3mJ7ovmySTOPIkJ1thF/r2qV+PX
         abVu3eWLXWyxB90wh9e1DdV2plhAMV4ObEf5ADoSzp1FkDWyr1royYXietk5ZWcZyxJu
         RQCA==
X-Gm-Message-State: AC+VfDw88MxrDwKbxhjq3J1aAZAcKavNyc2/FaOkyTiAplZQ0bwXXNci
	8bTHMKHXj7G1NxhU8NUSarg=
X-Google-Smtp-Source: ACHHUZ7O7/8jGJzJhAZ48hf4kxler6GDyueMMwLZYXlKlvfreliQCizVI2xN2ehUbkqzsB/np1Kz7Q==
X-Received: by 2002:aca:1219:0:b0:3a0:46fc:a846 with SMTP id 25-20020aca1219000000b003a046fca846mr1863680ois.25.1687348820017;
        Wed, 21 Jun 2023 05:00:20 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:32e:5400:4ff:fe7b:7461])
        by smtp.gmail.com with ESMTPSA id 4-20020a17090a198400b0025643e5da99sm4803323pji.37.2023.06.21.05.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 05:00:19 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kafai@fb.com,
	songliubraving@fb.com,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next] bpf: Fix an error in verifying a field in a union
Date: Wed, 21 Jun 2023 12:00:12 +0000
Message-Id: <20230621120012.3883-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

We are utilizing BPF LSM to monitor BPF operations within our container
environment. When we add support for raw_tracepoint, it hits below
error.

; (const void *)attr->raw_tracepoint.name);
27: (79) r3 = *(u64 *)(r2 +0)
access beyond the end of member map_type (mend:4) in struct (anon) with off 0 size 8

It can be reproduced with below BPF prog.

SEC("lsm/bpf")
int BPF_PROG(bpf_audit, int cmd, union bpf_attr *attr, unsigned int size)
{
	switch (cmd) {
	case BPF_RAW_TRACEPOINT_OPEN:
		bpf_printk("raw_tracepoint is %s", attr->raw_tracepoint.name);
		break;
	default:
		break;
	}
	return 0;
}

The reason is that when accessing a field in a union, such as bpf_attr, if
the field is located within a nested struct that is not the first member of
the union, it can result in incorrect field verification.

  union bpf_attr {
      struct {
          __u32 map_type; <<<< Actually it will find that field.
          __u32 key_size;
          __u32 value_size;
         ...
      };
      ...
      struct {
          __u64 name;    <<<< We want to verify this field.
          __u32 prog_fd;
      } raw_tracepoint;
  };

Considering the potential deep nesting levels, finding a perfect solution
to address this issue has proven challenging. Therefore, I propose a
solution where we simply skip the verification process if the field in
question is located within a union.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/btf.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index bd2cac057928..79ee4506bba4 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6129,7 +6129,7 @@ enum bpf_struct_walk_result {
 static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 			   const struct btf_type *t, int off, int size,
 			   u32 *next_btf_id, enum bpf_type_flag *flag,
-			   const char **field_name)
+			   const char **field_name, bool *in_union)
 {
 	u32 i, moff, mtrue_end, msize = 0, total_nelems = 0;
 	const struct btf_type *mtype, *elem_type = NULL;
@@ -6188,6 +6188,8 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 		return -EACCES;
 	}
 
+	if (BTF_INFO_KIND(t->info) == BTF_KIND_UNION && !in_union)
+		*in_union = true;
 	for_each_member(i, t, member) {
 		/* offset of the field in bytes */
 		moff = __btf_member_bit_offset(t, member) / 8;
@@ -6372,7 +6374,7 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 		 * that also allows using an array of int as a scratch
 		 * space. e.g. skb->cb[].
 		 */
-		if (off + size > mtrue_end) {
+		if (off + size > mtrue_end && !in_union) {
 			bpf_log(log,
 				"access beyond the end of member %s (mend:%u) in struct %s with off %u size %u\n",
 				mname, mtrue_end, tname, off, size);
@@ -6395,6 +6397,7 @@ int btf_struct_access(struct bpf_verifier_log *log,
 	enum bpf_type_flag tmp_flag = 0;
 	const struct btf_type *t;
 	u32 id = reg->btf_id;
+	bool in_union;
 	int err;
 
 	while (type_is_alloc(reg->type)) {
@@ -6421,7 +6424,8 @@ int btf_struct_access(struct bpf_verifier_log *log,
 
 	t = btf_type_by_id(btf, id);
 	do {
-		err = btf_struct_walk(log, btf, t, off, size, &id, &tmp_flag, field_name);
+		err = btf_struct_walk(log, btf, t, off, size, &id, &tmp_flag, field_name,
+				      &in_union);
 
 		switch (err) {
 		case WALK_PTR:
@@ -6481,6 +6485,7 @@ bool btf_struct_ids_match(struct bpf_verifier_log *log,
 {
 	const struct btf_type *type;
 	enum bpf_type_flag flag;
+	bool in_union;
 	int err;
 
 	/* Are we already done? */
@@ -6496,7 +6501,7 @@ bool btf_struct_ids_match(struct bpf_verifier_log *log,
 	type = btf_type_by_id(btf, id);
 	if (!type)
 		return false;
-	err = btf_struct_walk(log, btf, type, off, 1, &id, &flag, NULL);
+	err = btf_struct_walk(log, btf, type, off, 1, &id, &flag, NULL, &in_union);
 	if (err != WALK_STRUCT)
 		return false;
 
-- 
2.39.3


