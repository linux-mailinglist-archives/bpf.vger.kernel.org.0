Return-Path: <bpf+bounces-41568-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 810E79987AA
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 15:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03C861F24A47
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 13:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBB51CB521;
	Thu, 10 Oct 2024 13:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q5Lf+YcL"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039341C9DCD
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 13:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728566884; cv=none; b=cXDMUG13r9pSCl9AjOB24bKFOZMHz6mhoevsopBLQpwD7QzqZBSy5mFta0waa1M+Dcsx9f2pMrShI0x3W2Pl7ls6zrL0UpAqdy3kPfBA4euOMw8wsxymEpy9LQpYmjiAT7IPzqAc8745t5EnjrkB1J100h+ACoRCSA9GglFbTCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728566884; c=relaxed/simple;
	bh=4YDcFKqcFOptWI4+Ky226m4++Sy0wlebeGJk5kGSTGU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NTNquCARJx1dF5JMTVRwVgbGg1PRyR7KJlqcUa3kzaJEm4DdgSY4lZ95vXNM+kG9EUhzXDxdkSxDoNqvFFrlK/WoxzJV1IrD/yUdc8kbruhhIZD03lE4IGzT2xd8id2d/SdG6XZw7Jeqw7fagiQXw+Bl08wXB7eXOsba5m50azc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q5Lf+YcL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728566881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dcVLw7oVeKeWONINqyVyub+tBa9Z5YErFbIgINy4EE8=;
	b=Q5Lf+YcLtHt1J4wsbsWBWE3yg1lESD4FfKLdvwFmUNRz/6/Bk9j7S++YkWJqcrcSj2peod
	CknKOVtKjlMiph4AsT6ctt5Ez3Bjg2x2U+rbUCVrZgP/RSdUzJXn/+3aXaXZGMDy3UP2ts
	+bfoUYxn2rI7E+P7MPYuIa8vovaQ5jg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-o9A5pK8rOEel96CeKKbsJw-1; Thu, 10 Oct 2024 09:28:00 -0400
X-MC-Unique: o9A5pK8rOEel96CeKKbsJw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42cceb06940so6022255e9.0
        for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 06:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728566879; x=1729171679;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dcVLw7oVeKeWONINqyVyub+tBa9Z5YErFbIgINy4EE8=;
        b=e8Vzatx4uQG2T0zBgRmlZ/J/DOArBL7DW+cRjMAmc6F4FhWAUw8ZrffNjqI8fkfnEs
         K50gw8CNyd1NGvDKLp83hFZnykArMsCZKHjL4iLP1FwMoqqfl19ajk46KawUAAGYkNd9
         t18a1AOKJVA6WOdeEyz60Zpnyxwo4fQLsVvLsnkHv2OVuwT5VLnnSjizjyKhvcQyfiRw
         Rwp7JL9Gpc26TkvpSjhZzHFz7XID7IWadtSpr65fTejaYtmjS5OzviSJI5+6XCAHSwKs
         PfyKWxGud/eNEKDaXWTZo6KYC8PBncI8Bd5+sJ0c9yGpaX/Xqf0Hl4Sw7xakmW1AbAbN
         9Blw==
X-Forwarded-Encrypted: i=1; AJvYcCWzAD8onEc3LzuGQkxtBypo99klunX8yBIzeQw5KYca25otzuG1aHVgbdTJuGUuvHfAU+s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn4DhKNMxPlMiOl7d4fxVIJibImdKipOqhNg0BJ2xagr2Pn8vm
	2J8xlUxgGaqajPBSiz+gVFqV8cNIUzKkSu4dWl5VF/OjLF66E4Syzz17etuk2P1+LWKIP2logOm
	qnL2VHgR0iEoA3wB/EZnb0g99AxZQ1iI5z+8+QMQKGEamJaG2Eg==
X-Received: by 2002:adf:fb87:0:b0:37c:d11f:c591 with SMTP id ffacd0b85a97d-37d3a9d90d5mr4093124f8f.17.1728566879330;
        Thu, 10 Oct 2024 06:27:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGguFz9WsMX+fsRXMX7/QsYuTAHffxv9qqM5rJFM3KQdJMFygKoVRN1jcOUpNhsN+omtwApyQ==
X-Received: by 2002:adf:fb87:0:b0:37c:d11f:c591 with SMTP id ffacd0b85a97d-37d3a9d90d5mr4093093f8f.17.1728566878888;
        Thu, 10 Oct 2024 06:27:58 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6ce6a7sm1560119f8f.46.2024.10.10.06.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 06:27:58 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 419EB15F3EA3; Thu, 10 Oct 2024 15:27:57 +0200 (CEST)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Thu, 10 Oct 2024 15:27:08 +0200
Subject: [PATCH bpf v2 2/3] selftests/bpf: Provide a generic
 [un]load_module helper
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241010-fix-kfunc-btf-caching-for-modules-v2-2-745af6c1af98@redhat.com>
References: <20241010-fix-kfunc-btf-caching-for-modules-v2-0-745af6c1af98@redhat.com>
In-Reply-To: <20241010-fix-kfunc-btf-caching-for-modules-v2-0-745af6c1af98@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Simon Sundberg <simon.sundberg@kau.se>, bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
X-Mailer: b4 0.14.2

From: Simon Sundberg <simon.sundberg@kau.se>

Generalize the previous [un]load_bpf_testmod() helpers (in
testing_helpers.c) to the more generic [un]load_module(), which can
load an arbitrary kernel module by name. This allows future selftests
to more easily load custom kernel modules other than bpf_testmod.ko.
Refactor [un]load_bpf_testmod() to wrap this new helper.

Signed-off-by: Simon Sundberg <simon.sundberg@kau.se>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/testing/selftests/bpf/testing_helpers.c | 34 +++++++++++++++++----------
 tools/testing/selftests/bpf/testing_helpers.h |  2 ++
 2 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
index d3c3c3a24150f99abd13ecb7d7b11d8f7351560d..5e9f16683be5460b1a295fb9754df761cbd090ea 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -367,7 +367,7 @@ int delete_module(const char *name, int flags)
 	return syscall(__NR_delete_module, name, flags);
 }
 
-int unload_bpf_testmod(bool verbose)
+int unload_module(const char *name, bool verbose)
 {
 	int ret, cnt = 0;
 
@@ -375,11 +375,11 @@ int unload_bpf_testmod(bool verbose)
 		fprintf(stdout, "Failed to trigger kernel-side RCU sync!\n");
 
 	for (;;) {
-		ret = delete_module("bpf_testmod", 0);
+		ret = delete_module(name, 0);
 		if (!ret || errno != EAGAIN)
 			break;
 		if (++cnt > 10000) {
-			fprintf(stdout, "Unload of bpf_testmod timed out\n");
+			fprintf(stdout, "Unload of %s timed out\n", name);
 			break;
 		}
 		usleep(100);
@@ -388,41 +388,51 @@ int unload_bpf_testmod(bool verbose)
 	if (ret) {
 		if (errno == ENOENT) {
 			if (verbose)
-				fprintf(stdout, "bpf_testmod.ko is already unloaded.\n");
+				fprintf(stdout, "%s.ko is already unloaded.\n", name);
 			return -1;
 		}
-		fprintf(stdout, "Failed to unload bpf_testmod.ko from kernel: %d\n", -errno);
+		fprintf(stdout, "Failed to unload %s.ko from kernel: %d\n", name, -errno);
 		return -1;
 	}
 	if (verbose)
-		fprintf(stdout, "Successfully unloaded bpf_testmod.ko.\n");
+		fprintf(stdout, "Successfully unloaded %s.ko.\n", name);
 	return 0;
 }
 
-int load_bpf_testmod(bool verbose)
+int load_module(const char *path, bool verbose)
 {
 	int fd;
 
 	if (verbose)
-		fprintf(stdout, "Loading bpf_testmod.ko...\n");
+		fprintf(stdout, "Loading %s...\n", path);
 
-	fd = open("bpf_testmod.ko", O_RDONLY);
+	fd = open(path, O_RDONLY);
 	if (fd < 0) {
-		fprintf(stdout, "Can't find bpf_testmod.ko kernel module: %d\n", -errno);
+		fprintf(stdout, "Can't find %s kernel module: %d\n", path, -errno);
 		return -ENOENT;
 	}
 	if (finit_module(fd, "", 0)) {
-		fprintf(stdout, "Failed to load bpf_testmod.ko into the kernel: %d\n", -errno);
+		fprintf(stdout, "Failed to load %s into the kernel: %d\n", path, -errno);
 		close(fd);
 		return -EINVAL;
 	}
 	close(fd);
 
 	if (verbose)
-		fprintf(stdout, "Successfully loaded bpf_testmod.ko.\n");
+		fprintf(stdout, "Successfully loaded %s.\n", path);
 	return 0;
 }
 
+int unload_bpf_testmod(bool verbose)
+{
+	return unload_module("bpf_testmod", verbose);
+}
+
+int load_bpf_testmod(bool verbose)
+{
+	return load_module("bpf_testmod.ko", verbose);
+}
+
 /*
  * Trigger synchronize_rcu() in kernel.
  */
diff --git a/tools/testing/selftests/bpf/testing_helpers.h b/tools/testing/selftests/bpf/testing_helpers.h
index d55f6ab124338ccab33bc120ca7e3baa18264aea..46d7f7089f636b0d2476859fd0fa5e1c4b305419 100644
--- a/tools/testing/selftests/bpf/testing_helpers.h
+++ b/tools/testing/selftests/bpf/testing_helpers.h
@@ -38,6 +38,8 @@ int unload_bpf_testmod(bool verbose);
 int kern_sync_rcu(void);
 int finit_module(int fd, const char *param_values, int flags);
 int delete_module(const char *name, int flags);
+int load_module(const char *path, bool verbose);
+int unload_module(const char *name, bool verbose);
 
 static inline __u64 get_time_ns(void)
 {

-- 
2.47.0


