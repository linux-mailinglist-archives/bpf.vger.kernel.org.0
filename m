Return-Path: <bpf+bounces-26662-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1778A37A4
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 23:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E46CE1F22759
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 21:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971D615532D;
	Fri, 12 Apr 2024 21:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNLIwFqC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E301552E3
	for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 21:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712956105; cv=none; b=dEDtSEppjz8omS5ApJVU4THxYjfDs0u/khLRSa/iGxPbiJWInVQEixT/24Oi7mVMdVBdBxMR0sbwiwzdAJFXi9oHnVThC2SL+SLf15p+dfRO0qwmHPhVyE5CXdCxe6liFxBUNN8VvNMXpSVXbnrgMKSSFvyzeqqGcNOKijvH05U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712956105; c=relaxed/simple;
	bh=FP5sOiCtSPy9Dqg+lcJupXzhrFQfzTjbtbEhG8RfKHs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SNRRbhXmJLcvtQ1TFa8p8uaumSOYA0o4utMtc+gY/c09aeFNz4g6gOR41w+86pqvPZvO+iYXYeKJl/gCrjRe1LIoTEDQbVCGRXzOyTZ4lwOasPaFNbZ/Mak94XEU/Zb6k50dLzrdedJCAF7uInKiyw9IOk0Tqp9D3QT3MTvyb0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNLIwFqC; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-221e1910c3bso708673fac.1
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 14:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712956102; x=1713560902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lpihkz25ih9HzbbtbdX+Qgomtg80aTKQZhPcenojhIQ=;
        b=iNLIwFqC8sIFZwJNEvdZkr7vlC/dxnLqrD3pVzMwg1v6slkTOVaXmk2Q3nyZjG66eg
         4TD7bWM7ZSUN5JsxWFlrQVwyRXfYnClvnHF38Yn5262dlBQB+PHEDGCXp2f1mIXpQaCe
         MBPM31s9w23/5GjpF5cilAsWpY5FZcCqwmzd4oQx0s6A9vBWE/2CYofBRWBIUytucX0/
         92Fwyi5nQ+evvuxDLCg2ITmBHs+n3zkIlXmu5gzYzGLg8kD0EGgYEtj/zfxj643tvJW1
         HmQ9r9uCUw08ELSk6ydn2t0PxDDhHn4LQYIo27QWCJiyn7XsS2ZdS9Iy2z2Eda4+1rp5
         GV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712956102; x=1713560902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lpihkz25ih9HzbbtbdX+Qgomtg80aTKQZhPcenojhIQ=;
        b=b/+BTK9Nz3rdiHU5USv7cFf9FnYu9JAP7u3ONK6kjm6ymDNFMMsI2LkbdOkzoW0bwr
         CI2G7m790uIGruuvihUSWOINNqMksuOAeusJS7+vGQolEgy2BbTvwl+0+cdVM9w0O4LP
         KdZgKDVCnpEPB2l2hNN2SvBvgb4wkGIyeo60xFIvQ+cGELpY2xcByNGE/LHe2UW46lG/
         ZX+FuGVqTG0j7kUU4SSWP2liTL+hAPZc7ZoFZfjC1EWhZ/SvPsty69Gvyi502R4tS5Ib
         82oSXCEPat3UKbINvB8HiQiDkJ/804SyaDeETWzhiGSC+/KLnc3j/p8zoewNBgFeb8QH
         vtQQ==
X-Gm-Message-State: AOJu0YwekZVDYczXqG1AIE24SAti9CTStpienG6/ZOT/gW2dHhKm5ktG
	tm96u6aFGGvdOQ15sKCmOABzT+QeQtJFBZR5ureHUr1//BwlfqRu44D8ag==
X-Google-Smtp-Source: AGHT+IGOdmpgwp+HHb7oyeuZCjl5N/vlMbHTBqGU2fbZIlG1cnFaZfYmHFe1nfzLy/1TtQTdSDtFtg==
X-Received: by 2002:a05:6871:5d2:b0:22e:9c5a:233e with SMTP id v18-20020a05687105d200b0022e9c5a233emr3937086oan.43.1712956102384;
        Fri, 12 Apr 2024 14:08:22 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:a1a1:7d97:cada:fa46])
        by smtp.gmail.com with ESMTPSA id pk22-20020a056871d21600b002334685aedbsm1015117oac.11.2024.04.12.14.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 14:08:21 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 04/11] bpf: initialize/free array of btf_field(s).
Date: Fri, 12 Apr 2024 14:08:07 -0700
Message-Id: <20240412210814.603377-5-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412210814.603377-1-thinker.li@gmail.com>
References: <20240412210814.603377-1-thinker.li@gmail.com>
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
index cab479925dfd..b25dd498b737 100644
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
index 7d392ec83655..cdabb673d358 100644
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


