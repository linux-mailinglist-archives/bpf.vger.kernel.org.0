Return-Path: <bpf+bounces-62259-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDB7AF73A5
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 14:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC92E4A0356
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 12:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080B52E7BC0;
	Thu,  3 Jul 2025 12:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jj9E5/Ni"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1D12E54BF;
	Thu,  3 Jul 2025 12:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751545046; cv=none; b=JVECiXkTKq2wXWVbX/BEytSl/oAK3i3no4w1E+KMdJrI3v/dnPLu031WuQ9rd9XoOrhfAL2OxRkuWLbvwGdlJNtwwWfHm/iIelnErhurELCNWaztg19yc8ULCZ/RRzUOmMbT645La7l8Iswuhqt2W/4z/e9tVIjuR7voZzpThYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751545046; c=relaxed/simple;
	bh=5oCXAqnGUnQLOPxG3F1XjOlkZaQdZfxbKDxj9Ga5C+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MGPDOpUd8J/m+lNv08FBlI3fuqkkVYB4h74PckLzhF69hX/onHZrD9UELzAEWlxz0Vh/0T0iSjG3dexmOpDJaOLR1rZZDmx03t2uAyhH3iaEfyPCQGI6AHc/vnaeZjYB4H4SnpdsvudduCwhpAGSyakXigkciwTmOefXgTwOXas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jj9E5/Ni; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-747c2cc3419so7285961b3a.2;
        Thu, 03 Jul 2025 05:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751545044; x=1752149844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=niyqKP09k4jZALhCpCoq03PetO0aqU/sqgXLnPNk78o=;
        b=jj9E5/NiYH4gpalKNX8TLs7pJPK4IE3YB5JTxvmZmzGY5/O0A9ddYjNUbMNcsnBtym
         mXfZYtGLIBjXvmf0pA5JgFZ9pvKBGlYC53eJT13czebw+t7zyKDMuMHWP/nFKbz6EQI8
         FUx3N750MICPMoSLsP0dk91ivme2zIywlQTw5y6+4WQfPwSkoehtRYXRejGFwI7Sitvw
         kf8ry03ra71IcXMRsm6/Cc52mAVrYMtIumeVXW/F5PLkwL4SqCKhO4jmfajjNkDntaAI
         vy9TfDTuOO81ao/cd9Hq+TMnTRKoqPGBOaee07MUj4y3EFwJ5kHO/GOg5YxLhXbVlK4q
         PrHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751545044; x=1752149844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=niyqKP09k4jZALhCpCoq03PetO0aqU/sqgXLnPNk78o=;
        b=U8jndX9RU+WnSjFIyfIkc1omBvRwsuKUWgHt8VT2ToOIlxppu1oj5M0Lp0/m/S54cT
         TFsxuanAhK0WDQyxd7YZVrhjuDqnjnekAf9iNuq5TUFBKqgJbbTr9vmJMPA3D/1u/ZT9
         jZ/q4dgpaKLHhZcTzHBbb8vDqPaMk+MRl9cdwsxXkzqt0r9xthkfBFZL6YlJ0H5xllzP
         LC6EDQiMTzHUWtP7EHSYpebJR4YYgvXRXezoZb3IFIb9UKpVNBf2/RmfuMBHkjUur3mp
         VTPwcvvVR012JhA/vWf2/hE4mU0DqqewJPAmANqu5Kw1YXvFO6nx0ytMGk0kEWWyOJXm
         2sVg==
X-Forwarded-Encrypted: i=1; AJvYcCWyP5d65h9lIXLi9zy+p+3cZ9W1JK8K3D8RU3+6DbA+HlT+pL2oPsJqATm4l+0Ve3WgrIH9d5MquBv94A0=@vger.kernel.org, AJvYcCXCVIkOjcBixyaPDL70+hVjy1FY8+a3za6luh8xQk9aRlgIinFXOrt4kk1vSnvFZx95ivuyLRqJsFTVmMK/gus5OeBe@vger.kernel.org
X-Gm-Message-State: AOJu0YzG27tZchYJm+sMKATOKR6+kvR25WwCoOVDlSo/hFsjPcr3mYez
	hUUAT+hCKbsbrKQHxVqK4OVwjya5PdZ6nnEfhHL4eLu9TSTfn5fWIz735e6wc7AEbztmEA==
X-Gm-Gg: ASbGncuHS0a1oD9yznTC4mMzbpKX8N3onBAIyISoqIrNGkFEw4mglkwYL05QG82JXk3
	s1tjGm+6mZMNw2/8+1qshA9WYNu8BkuZx8VhtpsdqKcOPySyGUAyLkP7vevMPsCbdPrEsrT6dkt
	SHKlIciPhGZlpmc3xskTOPsZKrEfXNsbbLnnDvV/Uvo8O7XqbphYIzxBpjcuyhlLqOKMi4DOmux
	BCVXtqbAekLppUkUFw0U5kPjf7WnXsgIa+jBK677g2N5J2a3QN0qZFkaqneadOUnYrAaBZgBmIv
	4VHIvbbCTNG7mUlaaPNIlqAWdI+WKdJeNZV00KM8zczJxL3+2tD3ovH4wDNWOIFcXAKEmP8dFFl
	kbW8=
X-Google-Smtp-Source: AGHT+IEM7HNVGdaso9YQFp+Gv95PHeQAf0tTWJGRHPZl4vGWMvFxEvK/XZ7mPQp72+Jc1khasprRIQ==
X-Received: by 2002:a05:6a20:6a1f:b0:1f5:8622:5ecb with SMTP id adf61e73a8af0-2240c6a1a38mr5632587637.34.1751545043827;
        Thu, 03 Jul 2025 05:17:23 -0700 (PDT)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af5575895sm18591081b3a.94.2025.07.03.05.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 05:17:23 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 04/18] ftrace: add reset_ftrace_direct_ips
Date: Thu,  3 Jul 2025 20:15:07 +0800
Message-Id: <20250703121521.1874196-5-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, we can change the address of a direct ftrace_ops with
modify_ftrace_direct(). However, we can't change the functions to filter
for a direct ftrace_ops. Therefore, we introduce the function
reset_ftrace_direct_ips() to do such things, and this function will reset
the functions to filter for a direct ftrace_ops.

This function do such thing in following steps:

1. filter out the new functions from ips that don't exist in the
   ops->func_hash->filter_hash and add them to the new hash.
2. add all the functions in the new ftrace_hash to direct_functions by
   ftrace_direct_update().
3. reset the functions to filter of the ftrace_ops to the ips with
   ftrace_set_filter_ips().
4. remove the functions that in the old ftrace_hash, but not in the new
   ftrace_hash from direct_functions.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/linux/ftrace.h |  7 ++++
 kernel/trace/ftrace.c  | 75 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 82 insertions(+)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index b672ca15f265..b7c60f5a4120 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -528,6 +528,8 @@ int modify_ftrace_direct_nolock(struct ftrace_ops *ops, unsigned long addr);
 
 void ftrace_stub_direct_tramp(void);
 
+int reset_ftrace_direct_ips(struct ftrace_ops *ops, unsigned long *ips,
+			    unsigned int cnt);
 #else
 struct ftrace_ops;
 static inline unsigned long ftrace_find_rec_direct(unsigned long ip)
@@ -551,6 +553,11 @@ static inline int modify_ftrace_direct_nolock(struct ftrace_ops *ops, unsigned l
 {
 	return -ENODEV;
 }
+static inline int reset_ftrace_direct_ips(struct ftrace_ops *ops, unsigned long *ips,
+					  unsigned int cnt)
+{
+	return -ENODEV;
+}
 
 /*
  * This must be implemented by the architecture.
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index f5f6d7bc26f0..db3aa61889d3 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6224,6 +6224,81 @@ int modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 	return err;
 }
 EXPORT_SYMBOL_GPL(modify_ftrace_direct);
+
+/* reset the ips for a direct ftrace (add or remove) */
+int reset_ftrace_direct_ips(struct ftrace_ops *ops, unsigned long *ips,
+			    unsigned int cnt)
+{
+	struct ftrace_hash *hash, *free_hash;
+	struct ftrace_func_entry *entry, *del;
+	unsigned long ip;
+	int err, size;
+
+	if (check_direct_multi(ops))
+		return -EINVAL;
+	if (!(ops->flags & FTRACE_OPS_FL_ENABLED))
+		return -EINVAL;
+
+	mutex_lock(&direct_mutex);
+	hash = alloc_ftrace_hash(FTRACE_HASH_DEFAULT_BITS);
+	if (!hash) {
+		err = -ENOMEM;
+		goto out_unlock;
+	}
+
+	/* find out the new functions from ips and add to hash */
+	for (int i = 0; i < cnt; i++) {
+		ip = ftrace_location(ips[i]);
+		if (!ip) {
+			err = -ENOENT;
+			goto out_unlock;
+		}
+		if (__ftrace_lookup_ip(ops->func_hash->filter_hash, ip))
+			continue;
+		err = __ftrace_match_addr(hash, ip, 0);
+		if (err)
+			goto out_unlock;
+	}
+
+	free_hash = direct_functions;
+	/* add the new ips to direct hash. */
+	err = ftrace_direct_update(hash, ops->direct_call);
+	if (err)
+		goto out_unlock;
+
+	if (free_hash && free_hash != EMPTY_HASH)
+		call_rcu_tasks(&free_hash->rcu, register_ftrace_direct_cb);
+
+	free_ftrace_hash(hash);
+	hash = alloc_and_copy_ftrace_hash(FTRACE_HASH_DEFAULT_BITS,
+					  ops->func_hash->filter_hash);
+	if (!hash) {
+		err = -ENOMEM;
+		goto out_unlock;
+	}
+	err = ftrace_set_filter_ips(ops, ips, cnt, 0, 1);
+
+	/* remove the entries that don't exist in our filter_hash anymore
+	 * from the direct_functions.
+	 */
+	size = 1 << hash->size_bits;
+	for (int i = 0; i < size; i++) {
+		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
+			if (__ftrace_lookup_ip(ops->func_hash->filter_hash, entry->ip))
+				continue;
+			del = __ftrace_lookup_ip(direct_functions, entry->ip);
+			if (del && del->direct == ops->direct_call) {
+				remove_hash_entry(direct_functions, del);
+				kfree(del);
+			}
+		}
+	}
+out_unlock:
+	mutex_unlock(&direct_mutex);
+	if (hash)
+		free_ftrace_hash(hash);
+	return err;
+}
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
 
 /**
-- 
2.39.5


