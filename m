Return-Path: <bpf+bounces-59104-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19252AC6068
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 05:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A069E1BC3675
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 03:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5DE21B9FC;
	Wed, 28 May 2025 03:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9KEJM8I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF0F21B9C0;
	Wed, 28 May 2025 03:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748404211; cv=none; b=pUkNFUScg5M0CipdY9ffGA5+imvhXdQ8f7kqMfqNvLaNxovzWHbAtHy3yPsaN2ha5o+R7ucuvH6SS6ltI1XfDAYpUalqs0jUICgBJc9xNY4tmIhfiChfstYOghPRi9FtFMJBkpUPAxX3/FHbf8p2En5EKOZjjFppwOcsJuHVfdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748404211; c=relaxed/simple;
	bh=tT3QgbeZaVPngHmlrmhR/+LqwS5dNFFCHOpwwRuz1fQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A+/CkIc6k9qbxoJIJD+8Am5WnJNki8LsuBq3YxY1nbQVjMy6IoYPbafastaHbO/zvP4hEnjFrJAMqklvBY1iBw16x8gOgmu5aFaqkt3S5y3KlpB0UNDDDcuiQ6XWXNtlYcomGI2knQLSiBSUP/lz8Tyx89+cEIMaZwOTPbwqNWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9KEJM8I; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-22e331215dbso3210885ad.1;
        Tue, 27 May 2025 20:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748404209; x=1749009009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YAYS5lKsbl835bzscg3XIO5IGldYqod4Ozc4rgXcA6c=;
        b=A9KEJM8IoE8GMGlHQQEdsKDuWz9vNnO+EU1prXPMRFM61HGv+WLpMEmo7aSYPr63hh
         8ivNsf7uhKcfWP6NghqhqbmSBS5qTDkWTUTWvZuUveJuZZaAq7ue0XyLvY0W03cBE9Al
         XrmtHP1wgBXxYOehBvjXowGUUE7o0wP0qSCwTKMaLHKvJ7+FJmnqaWTzp7U4854CLnew
         +RmGzwNJuHlkQlWxGXdmJ2TY9ZtbYADjZEhWHuT5ZGbf6fLwYY8mlSLfSQatOvrAsiek
         mHq4K0oBGXmvSc3+IOgUQH+Ghnvd8UlEg9Yp3Kv8gNTLTWnAw6MsQv0I+gAX1b4z81mY
         UoNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748404209; x=1749009009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YAYS5lKsbl835bzscg3XIO5IGldYqod4Ozc4rgXcA6c=;
        b=cRblM+pghtVgTGY5/GRGP+o2+8j7wOG+zO8FdYn+aIMoy8stlQJ+vsm9+eKWPv3QRt
         XDMfHT1xvlA1OUcBL+mnKDmTW503SgWvCSIZvaA2VWIOQHaN/Yr1ZccJmg+4+BczLJL3
         xwxHV9gPZ6P0EwcmqrnT8BAlwZfsNubEt6Y5qupPv9IOzuaUjKqsLrvSq8ftuYj1hJdl
         rAV0U09oU5tWD3TOX5nuJ4cfEI0DOZ3TskJ0ohtg2yRwvtoy4LJprG7D0H8rVSzescLr
         kVVuy0EgY+mTLh/WIpYcgVmEB++BW9ft8dII7mZlw4K4W1o79zoz3ibcMKMn5YR7isWS
         UC+g==
X-Forwarded-Encrypted: i=1; AJvYcCV+IhhRXLZHHiOM9vSm9e2Tbg22CKovbdoMrK1TzlJKWLi8zCV5wISHMqNgckS8fpFA20T7jn+RZpHRy2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrJlKKYEuiyk3rpWyZSKHHQF51qtalTPY5s84Qe85G4l1WIPzt
	vdcTT4is0C4enpHpL+zb6akPqIYQHANwjU1Kky9JCUS21BpPmDlIhTYi
X-Gm-Gg: ASbGncs3psRRGSU1V7Z93EHbvOHEHNZjzh22BM/6DWcwlF9kbFte+FmjV3u+DOMuinj
	PSDXhrQpg45dj9R2boc2g45Zh3E3xbqgqu7Crirtze7PHrqXizmtew/pZTd0URdCdnUDyljQRsC
	QhemzKker6UypV3qfXfLcQ1hfUJb3aK6qomDJh9CGeckgkIroQ5jAoXDrYjaWtzUCpPBA3suw9W
	xd5VKUFr4qbvyVWF4qyARXxQEmOGWVn1sjpvu/F0NDYItGOxgf9F7dMLX+zP8AOk5Ll3L0OwvRX
	B67GlM3HrU7UkeaxgaqjS7u4KuYlP6cQawxnnIxND3M8LHQ6KShud3GS2Z2tOURYxq0w
X-Google-Smtp-Source: AGHT+IEBQQaFiaEybooAwzIyji1mQLsF6d+czJF3HzEWnNxRCVv+hTVem/J4PfY5SyVXBw/Pyk0YBQ==
X-Received: by 2002:a17:903:32c5:b0:231:ad5a:fe9c with SMTP id d9443c01a7336-234b74b7d7emr41679175ad.15.1748404208894;
        Tue, 27 May 2025 20:50:08 -0700 (PDT)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d35ac417sm2074505ad.169.2025.05.27.20.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 20:50:08 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 15/25] ftrace: factor out __unregister_ftrace_direct
Date: Wed, 28 May 2025 11:47:02 +0800
Message-Id: <20250528034712.138701-16-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250528034712.138701-1-dongml2@chinatelecom.cn>
References: <20250528034712.138701-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor out __unregister_ftrace_direct, which doesn't hold the direct_mutex
lock.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 kernel/trace/ftrace.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 0befb4c93e89..5b6b74ea4c20 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -113,6 +113,8 @@ bool ftrace_pids_enabled(struct ftrace_ops *ops)
 }
 
 static void ftrace_update_trampoline(struct ftrace_ops *ops);
+static int __unregister_ftrace_direct(struct ftrace_ops *ops, unsigned long addr,
+				      bool free_filters);
 
 /*
  * ftrace_disabled is set when an anomaly is discovered.
@@ -6046,8 +6048,8 @@ EXPORT_SYMBOL_GPL(register_ftrace_direct);
  *  0 on success
  *  -EINVAL - The @ops object was not properly registered.
  */
-int unregister_ftrace_direct(struct ftrace_ops *ops, unsigned long addr,
-			     bool free_filters)
+static int __unregister_ftrace_direct(struct ftrace_ops *ops, unsigned long addr,
+				      bool free_filters)
 {
 	struct ftrace_hash *hash = ops->func_hash->filter_hash;
 	int err;
@@ -6057,10 +6059,8 @@ int unregister_ftrace_direct(struct ftrace_ops *ops, unsigned long addr,
 	if (!(ops->flags & FTRACE_OPS_FL_ENABLED))
 		return -EINVAL;
 
-	mutex_lock(&direct_mutex);
 	err = unregister_ftrace_function(ops);
 	remove_direct_functions_hash(hash, addr);
-	mutex_unlock(&direct_mutex);
 
 	/* cleanup for possible another register call */
 	ops->func = NULL;
@@ -6070,6 +6070,18 @@ int unregister_ftrace_direct(struct ftrace_ops *ops, unsigned long addr,
 		ftrace_free_filter(ops);
 	return err;
 }
+
+int unregister_ftrace_direct(struct ftrace_ops *ops, unsigned long addr,
+			     bool free_filters)
+{
+	int err;
+
+	mutex_lock(&direct_mutex);
+	err = __unregister_ftrace_direct(ops, addr, free_filters);
+	mutex_unlock(&direct_mutex);
+
+	return err;
+}
 EXPORT_SYMBOL_GPL(unregister_ftrace_direct);
 
 static int
-- 
2.39.5


