Return-Path: <bpf+bounces-26341-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 683B489E703
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 02:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BFC61C2131E
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 00:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8694F10E3;
	Wed, 10 Apr 2024 00:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmRpo+xH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831BA15A4
	for <bpf@vger.kernel.org>; Wed, 10 Apr 2024 00:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712709722; cv=none; b=F+cl7+A0qRiFe02OpTkPivJdR5bMrmbHnVQdYeRdPIQEF/pE3oYobmstvV27noXW8bZ120NkXuTOMRZhLRJ8Z35VPLX1ot70qQIU0ES+x6MIoDUL264lnVgvpZK2wHk5a9If+GZTaS57THfq76fi4FSaKhZwejscbiCyrsqeDzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712709722; c=relaxed/simple;
	bh=PQiaphJS8sGSmmNhxpua2lWHZd+JTm/QCi4UQVFxKFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YN2Z8gVNRWO8jK2pjh9/o4BlARNz1BHjGvdKmA09H1Q8DLZ2VOr17xcDOEjlLXVVT2+XqXd1IavBCm2T9Dhtk5kc95Fl8jZiPyaMjkwaa6c3lY0ajIm8633lwuGYaohWNFZhKER+zbREQBYcG2zTCx7w/zR8yf+QNMU/XyqbAPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmRpo+xH; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6ea29cf24c6so588760a34.3
        for <bpf@vger.kernel.org>; Tue, 09 Apr 2024 17:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712709719; x=1713314519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pe+0CtEDtN75wD1CKRy11z0iaVOyi7eddI7dtEcIGAc=;
        b=MmRpo+xHEMvaPadmsyuYg7KlZG4SBen8so3sx4YoJb31dUNlEAKqMhwGwoo6dH5Zq+
         fUO/N+piC+k0p4sE7WaQEM8tq1oWZOByQB/HLt0t1osyt48oPWiS4tzDo/EZagVy/sza
         kxTaoTHNeMwQN2zOO0eb1xpFnKiwz2tO/FCU+JhQ84ddCgazCh8OfqWA+x7C/Rbf3jPr
         xYC7Ihu3+14y6JEyQWK3CAegT3J4NmZC9ojkuNMGFfhbBJ3lpoYfkKmjjpxdGeOZj2sg
         7H3/MeEvi8VwY/y3zltuOt/GB2BuYXSp7Hn9QEEj+nfJIi35Nsv0BsMGHxuh9Zi/pkst
         n08g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712709719; x=1713314519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pe+0CtEDtN75wD1CKRy11z0iaVOyi7eddI7dtEcIGAc=;
        b=Zg/CvhCXx3T+vDfrS+DeRLebBYOQliAfRy+JBH6BiDKnMDxTWThV2hZeH2qDikPYI5
         kaQqsyrB5kGD6fcgtqRNgs+7HjU1uUIgFNY0/14ow8mUNVXrZObuamuFaF2DsK5HKPuj
         g5uZaHdhU33PFL7ZWclkp1PzX6FXeb058UGpqmAcsZUUHJ0ZuJYSFG86TXblxFayOZlL
         QFgRZ1qJXjGMNfx0Jz9/sx0ijTzSkSfiUL1BFPf01eu53/uhyT8a5t+6SJAPpK1/AuQJ
         rBoKHmwpAC65gHtwhg1PCyJVzMP0IW7+Tt9narxD3mmkrCBJpAcO3TbYFIYnAENc5nxG
         dsSg==
X-Gm-Message-State: AOJu0YzaktW9RI1VJx7Le5ksJg6vI/u9kHyRk174FVs8QaD1z6ruO8k+
	98TY0QO6LHsMfScnCjWw5qYYmTgnE9bvO5O4HkO21zaUjPNKwr8PcM3E3+sa
X-Google-Smtp-Source: AGHT+IF+xTEkLU7qoDvOjQlEitZ6Gqck16Q9egHRXgwUpFfWodXr45ywiM2Vw4VmOCtqYIEPGoYRlQ==
X-Received: by 2002:a05:6808:1da:b0:3c5:da62:f60b with SMTP id x26-20020a05680801da00b003c5da62f60bmr1135793oic.33.1712709719290;
        Tue, 09 Apr 2024 17:41:59 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:d330:d0dc:41bd:be5b])
        by smtp.gmail.com with ESMTPSA id bf10-20020a056808190a00b003c5fbfe3ac3sm505124oib.21.2024.04.09.17.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 17:41:58 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next 05/11] bpf: initialize/free array of btf_field(s).
Date: Tue,  9 Apr 2024 17:41:44 -0700
Message-Id: <20240410004150.2917641-6-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240410004150.2917641-1-thinker.li@gmail.com>
References: <20240410004150.2917641-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initialize and free each element in a btf_field array based on the values
of nelems and size in btf_field. The value of nelems is the length of the
flatten array for nested arrays.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/bpf.h  |  7 +++++++
 kernel/bpf/syscall.c | 39 ++++++++++++++++++++++++---------------
 2 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f397ccdc6d4b..ee53dcd14bd4 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -390,6 +390,9 @@ static inline u32 btf_field_type_align(enum btf_field_type type)
 
 static inline void bpf_obj_init_field(const struct btf_field *field, void *addr)
 {
+	u32 elem_size;
+	int i;
+
 	memset(addr, 0, field->size);
 
 	switch (field->type) {
@@ -400,6 +403,10 @@ static inline void bpf_obj_init_field(const struct btf_field *field, void *addr)
 		RB_CLEAR_NODE((struct rb_node *)addr);
 		break;
 	case BPF_LIST_HEAD:
+		elem_size = field->size / field->nelems;
+		for (i = 0; i < field->nelems; i++, addr += elem_size)
+			INIT_LIST_HEAD((struct list_head *)addr);
+		break;
 	case BPF_LIST_NODE:
 		INIT_LIST_HEAD((struct list_head *)addr);
 		break;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index e44c276e8617..543ff0d944e8 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -672,6 +672,8 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
 		const struct btf_field *field = &fields[i];
 		void *field_ptr = obj + field->offset;
 		void *xchgd_field;
+		u32 elem_size = field->size / field->nelems;
+		int j;
 
 		switch (fields[i].type) {
 		case BPF_SPIN_LOCK:
@@ -680,35 +682,42 @@ void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
 			bpf_timer_cancel_and_free(field_ptr);
 			break;
 		case BPF_KPTR_UNREF:
-			WRITE_ONCE(*(u64 *)field_ptr, 0);
+			for (j = 0; j < field->nelems; j++, field_ptr += elem_size)
+				WRITE_ONCE(*(u64 *)field_ptr, 0);
 			break;
 		case BPF_KPTR_REF:
 		case BPF_KPTR_PERCPU:
-			xchgd_field = (void *)xchg((unsigned long *)field_ptr, 0);
-			if (!xchgd_field)
-				break;
-
-			if (!btf_is_kernel(field->kptr.btf)) {
+			if (!btf_is_kernel(field->kptr.btf))
 				pointee_struct_meta = btf_find_struct_meta(field->kptr.btf,
 									   field->kptr.btf_id);
-				migrate_disable();
-				__bpf_obj_drop_impl(xchgd_field, pointee_struct_meta ?
-								 pointee_struct_meta->record : NULL,
-								 fields[i].type == BPF_KPTR_PERCPU);
-				migrate_enable();
-			} else {
-				field->kptr.dtor(xchgd_field);
+
+			for (j = 0; j < field->nelems; j++, field_ptr += elem_size) {
+				xchgd_field = (void *)xchg((unsigned long *)field_ptr, 0);
+				if (!xchgd_field)
+					continue;
+
+				if (!btf_is_kernel(field->kptr.btf)) {
+					migrate_disable();
+					__bpf_obj_drop_impl(xchgd_field, pointee_struct_meta ?
+							    pointee_struct_meta->record : NULL,
+							    fields[i].type == BPF_KPTR_PERCPU);
+					migrate_enable();
+				} else {
+					field->kptr.dtor(xchgd_field);
+				}
 			}
 			break;
 		case BPF_LIST_HEAD:
 			if (WARN_ON_ONCE(rec->spin_lock_off < 0))
 				continue;
-			bpf_list_head_free(field, field_ptr, obj + rec->spin_lock_off);
+			for (j = 0; j < field->nelems; j++, field_ptr += elem_size)
+				bpf_list_head_free(field, field_ptr, obj + rec->spin_lock_off);
 			break;
 		case BPF_RB_ROOT:
 			if (WARN_ON_ONCE(rec->spin_lock_off < 0))
 				continue;
-			bpf_rb_root_free(field, field_ptr, obj + rec->spin_lock_off);
+			for (j = 0; j < field->nelems; j++, field_ptr += elem_size)
+				bpf_rb_root_free(field, field_ptr, obj + rec->spin_lock_off);
 			break;
 		case BPF_LIST_NODE:
 		case BPF_RB_NODE:
-- 
2.34.1


