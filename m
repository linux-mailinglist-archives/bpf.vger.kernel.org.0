Return-Path: <bpf+bounces-40335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A98986C5E
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 08:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7037281494
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 06:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263C418786D;
	Thu, 26 Sep 2024 06:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eJKhygvI"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C484176AA3
	for <bpf@vger.kernel.org>; Thu, 26 Sep 2024 06:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727331526; cv=none; b=dSh4816eq6QccPsy5NespWp4wH/MZxSG+AlpGK4jElgad74ETlPXqt8vJeh/6UqhkMKujpuNlfMv6MnjHwLSvesFsFbdVQ4IR9yKbpiH0PmSA5Mles13GCy6mii1o3p1GFPWM7zAe6ay0Aqc1Nsen0hfucGJpGqVEQ3sOcM8ir4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727331526; c=relaxed/simple;
	bh=AtILwdso8NzOLxtEFs34RJP8DsC7sUWq5Kp+xEIxX+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p2bOlYf/rc5sV52TTDZhXvgncfe6xtdY2tLSmXmZNmuZvbEGCag5uA9fXdsJfrlFOTGIekWN87otp1x8amYx4tUq7q6SCGUD3t0/yAwmZXNHQWGa4wO3hHFPhmJ2Po8egP9Cxl1ncOOfDiBhzNkz42S01IW62WvLsF4IQj7f1jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eJKhygvI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727331524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=egHzXd90JXX2Z14ZT3IazKwsXKSJa5C8GINnQaoOXYs=;
	b=eJKhygvIGA70sUTz0SccrOQqimmd5UjsJ/pDW81jXjnr4YlKoZAKRF1RFgsIWxLOZzlrr3
	lXil2gBqEVneK5GatQOGgFnRdPcREvQov1yybUPjT27vtZPq4Z9pmKhwBAhdroYkOZqq9X
	dCkE6qbwUhm1XtrZz1oI5JUJbaj+tB8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-0p4mgQESMcyKDjkO-Xwwiw-1; Thu,
 26 Sep 2024 02:18:39 -0400
X-MC-Unique: 0p4mgQESMcyKDjkO-Xwwiw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C7251955F2B;
	Thu, 26 Sep 2024 06:18:37 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.45.224.3])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AF4441956048;
	Thu, 26 Sep 2024 06:18:32 +0000 (UTC)
From: Viktor Malik <vmalik@redhat.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next 1/2] bpf: Add kfuncs for read-only string operations
Date: Thu, 26 Sep 2024 08:18:21 +0200
Message-ID: <bc06e1f4bef09ba3d431d7a7236303746a7adb57.1727329823.git.vmalik@redhat.com>
In-Reply-To: <cover.1727329823.git.vmalik@redhat.com>
References: <cover.1727329823.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Kernel contains highly optimised implementation of traditional string
operations. Expose them as kfuncs to allow BPF programs leverage the
kernel implementation instead of needing to reimplement the operations.

For now, add kfuncs for all string operations which do not copy memory
around: strcmp, strchr, strrchr, strnchr, strstr, strnstr, strlen,
strnlen, strpbrk, strspn, strcspn. Do not add strncmp as it is already
exposed as a helper.

Signed-off-by: Viktor Malik <vmalik@redhat.com>
---
 kernel/bpf/helpers.c | 66 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 1a43d06eab28..daa19760d8c8 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3004,6 +3004,61 @@ __bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__sz, const void __user
 	return ret + 1;
 }
 
+__bpf_kfunc int bpf_strcmp(const char *cs, const char *ct)
+{
+	return strcmp(cs, ct);
+}
+
+__bpf_kfunc char *bpf_strchr(const char *s, int c)
+{
+	return strchr(s, c);
+}
+
+__bpf_kfunc char *bpf_strrchr(const char *s, int c)
+{
+	return strrchr(s, c);
+}
+
+__bpf_kfunc char *bpf_strnchr(const char *s, size_t count, int c)
+{
+	return strnchr(s, count, c);
+}
+
+__bpf_kfunc char *bpf_strstr(const char *s1, const char *s2)
+{
+	return strstr(s1, s2);
+}
+
+__bpf_kfunc char *bpf_strnstr(const char *s1, const char *s2, size_t len)
+{
+	return strnstr(s1, s2, len);
+}
+
+__bpf_kfunc size_t bpf_strlen(const char *s)
+{
+	return strlen(s);
+}
+
+__bpf_kfunc size_t bpf_strnlen(const char *s, size_t count)
+{
+	return strnlen(s, count);
+}
+
+__bpf_kfunc char *bpf_strpbrk(const char *cs, const char *ct)
+{
+	return strpbrk(cs, ct);
+}
+
+__bpf_kfunc size_t bpf_strspn(const char *s, const char *accept)
+{
+	return strspn(s, accept);
+}
+
+__bpf_kfunc size_t bpf_strcspn(const char *s, const char *reject)
+{
+	return strcspn(s, reject);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(generic_btf_ids)
@@ -3090,6 +3145,17 @@ BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
 BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_strcmp)
+BTF_ID_FLAGS(func, bpf_strchr)
+BTF_ID_FLAGS(func, bpf_strrchr)
+BTF_ID_FLAGS(func, bpf_strnchr)
+BTF_ID_FLAGS(func, bpf_strstr)
+BTF_ID_FLAGS(func, bpf_strnstr)
+BTF_ID_FLAGS(func, bpf_strlen)
+BTF_ID_FLAGS(func, bpf_strnlen)
+BTF_ID_FLAGS(func, bpf_strpbrk)
+BTF_ID_FLAGS(func, bpf_strspn)
+BTF_ID_FLAGS(func, bpf_strcspn)
 BTF_KFUNCS_END(common_btf_ids)
 
 static const struct btf_kfunc_id_set common_kfunc_set = {
-- 
2.46.0


