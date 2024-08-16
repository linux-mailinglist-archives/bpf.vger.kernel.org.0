Return-Path: <bpf+bounces-37392-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B84D95513E
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 21:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EC831C21F29
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 19:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87C31C3F30;
	Fri, 16 Aug 2024 19:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mC77JxIQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40F31C2301
	for <bpf@vger.kernel.org>; Fri, 16 Aug 2024 19:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723835542; cv=none; b=prAPjYWswbHh1Lk3119R472qkJP+C1C2ArPAurqqz5Rlzm7JJRRXnU7vNORbd93GzbKrcqoB50bf6d7s0RL8DANjnJcjWCTF0gSKHIIa3bIkEUapfkpnwU+5i/jRcUAUbugebevXdgFJcXnbz6v+p5sCzVRr7FHGAT+yBVj9tDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723835542; c=relaxed/simple;
	bh=LFmhqp7CM4KZmy4pBG8PtYOoX+RcQCP0uI3faYP4vs8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XXxHDm7Au4aJvkQP+QjIc2Q8/FGmBZ/4BSWfCWdRyuPvsBOOjk0EiIK20Aobot5Hz4ZQwwEW6nySW1bNm9JOvSAbzhH4kMWA4ls8mCd/Dlu3iC+uz4QXxiwsw5WXUvRilSd9MScVaxlM5eohPWPqZrU/+xlGLcnpzP9mYD6ImD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mC77JxIQ; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-690b6cbce11so22597967b3.2
        for <bpf@vger.kernel.org>; Fri, 16 Aug 2024 12:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723835540; x=1724440340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jgepIhK5T8DMdWFDinGBiig4lDcTk0a45QhOnxHlkE=;
        b=mC77JxIQG8owl2izBXlsq7nEC3cNnJVG6MrcQD13r+J97h+j4ZNed58VzTgu0w0sLa
         Kqf3/mBY/Z9WosjuVSeDOAGQ87DZUSpCQZTipZHwB3vm+MX18a8xkMt8Evj44k5EUt7X
         skdUcqPzN+itIVZ8wqhw5k5V16DGVEbpQ3aq7t9FFQ11PtOsJoT9Kkia3ZXS99J9CB5U
         2ry9IhPvnx0Mrf45WMZjyE7/fECNfSuHdC+kUAWz8h+mZADA2dSQZ78bNiRVzA7cIr+R
         ehAZ5a8CCXBz2TJ6NpNIwUKPBTgxXqJd4AocyVERYyJcyNzhvCWH2ZoGpHcJiiNEO/pz
         /Y6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723835540; x=1724440340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0jgepIhK5T8DMdWFDinGBiig4lDcTk0a45QhOnxHlkE=;
        b=CGyFf4IQtUMrZh0GBvC641Bhp6CIiPRlLz0WfF4bduSWu/QvKqDYAJHP7EKvCmgcou
         hzZ5PisUKgqUL7a2idFTRMIYKYwclGpr3PguJdxlqayxpZm3C18QkvfME3fqIL5Q7fjV
         ruGUHz9EglWp76GBuD5S8lmPTu7+inp9/ruz4t+PjW3vNEiXgP08I3zkNZ7IXTvya1MA
         tNZnJzywHbz4IgKzrUYs5f1KNxUe+hIs8NcIIYBnbvlRXRhP3JDqwD9SUpOk9ES5Ly7l
         NMJsnGm7zTmmWqlP1W3OSY9nNqKt0qids/AYlxD7OHCZSwwVCs2JkGJBPTI8snRCJR/1
         mq5A==
X-Gm-Message-State: AOJu0YwrDXOLmvKB4ysj6IVC32F6avtf0uSdYR/WvtdTAem3pNSavRj+
	VsC5gVQ2A0hyVPU92T2IfH+/UYEC42wxzNfcY5LU3keZ57uCktQZGmbixJG2
X-Google-Smtp-Source: AGHT+IHtIqBNhhNwagwYfVVCktw9YS3NkW9kWbfh/umLl+MSUR3PYWK/w7x3Qoj70Jeai3ORR/watg==
X-Received: by 2002:a05:690c:5811:b0:6ad:219a:b687 with SMTP id 00721157ae682-6b1bcf8ec90mr33110177b3.39.1723835539718;
        Fri, 16 Aug 2024 12:12:19 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:ca12:c8db:5571:aa13])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6af9cd7a50dsm7233327b3.94.2024.08.16.12.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 12:12:19 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [RFC bpf-next v4 2/6] bpf: Parse and support "uptr" tag.
Date: Fri, 16 Aug 2024 12:12:09 -0700
Message-Id: <20240816191213.35573-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816191213.35573-1-thinker.li@gmail.com>
References: <20240816191213.35573-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parse "uptr" tag from BTF, map it to BPF_UPTR, and support it in related
functions. "uptr" tag is used to annotate a field in a struct type is a
uptr, which is used to share a block memory between user programs and BPF
programs.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/btf.c     | 5 +++++
 kernel/bpf/syscall.c | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index ab3c9f592c9f..f61bad288385 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3356,6 +3356,8 @@ static int btf_find_kptr(const struct btf *btf, const struct btf_type *t,
 		type = BPF_KPTR_REF;
 	else if (!strcmp("percpu_kptr", __btf_name_by_offset(btf, t->name_off)))
 		type = BPF_KPTR_PERCPU;
+	else if (!strcmp("uptr", __btf_name_by_offset(btf, t->name_off)))
+		type = BPF_UPTR;
 	else
 		return -EINVAL;
 
@@ -3533,6 +3535,7 @@ static int btf_repeat_fields(struct btf_field_info *info,
 		case BPF_KPTR_UNREF:
 		case BPF_KPTR_REF:
 		case BPF_KPTR_PERCPU:
+		case BPF_UPTR:
 		case BPF_LIST_HEAD:
 		case BPF_RB_ROOT:
 			break;
@@ -3659,6 +3662,7 @@ static int btf_find_field_one(const struct btf *btf,
 	case BPF_KPTR_UNREF:
 	case BPF_KPTR_REF:
 	case BPF_KPTR_PERCPU:
+	case BPF_UPTR:
 		ret = btf_find_kptr(btf, var_type, off, sz,
 				    info_cnt ? &info[0] : &tmp);
 		if (ret < 0)
@@ -3983,6 +3987,7 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 		case BPF_KPTR_UNREF:
 		case BPF_KPTR_REF:
 		case BPF_KPTR_PERCPU:
+		case BPF_UPTR:
 			ret = btf_parse_kptr(btf, &rec->fields[i], &info_arr[i]);
 			if (ret < 0)
 				goto end;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 65dcd92d0b2c..fed4a2145f81 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -548,6 +548,7 @@ void btf_record_free(struct btf_record *rec)
 		case BPF_KPTR_UNREF:
 		case BPF_KPTR_REF:
 		case BPF_KPTR_PERCPU:
+		case BPF_UPTR:
 			if (rec->fields[i].kptr.module)
 				module_put(rec->fields[i].kptr.module);
 			btf_put(rec->fields[i].kptr.btf);
@@ -596,6 +597,7 @@ struct btf_record *btf_record_dup(const struct btf_record *rec)
 		case BPF_KPTR_UNREF:
 		case BPF_KPTR_REF:
 		case BPF_KPTR_PERCPU:
+		case BPF_UPTR:
 			btf_get(fields[i].kptr.btf);
 			if (fields[i].kptr.module && !try_module_get(fields[i].kptr.module)) {
 				ret = -ENXIO;
-- 
2.34.1


