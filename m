Return-Path: <bpf+bounces-35604-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C4993BB2D
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 05:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08482285AD6
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 03:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6F117565;
	Thu, 25 Jul 2024 03:22:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9800414A84;
	Thu, 25 Jul 2024 03:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721877741; cv=none; b=bJ6KmesbTCfy+nq8QegeZoxPzf0R6h6NPxCzh4+pmb59PAd9ErTUCZdeXMdtsKa3UFXuS/OebFAK2pXCWGuQxPIcissOjapoyz26K0J6QYO4M5jShidwXhfzRBKYyyTZ7uOmtR3wNYItvvf2s1gb+dVk5Z8coo8CMMzva0CTRok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721877741; c=relaxed/simple;
	bh=FufYzk/kh5jvAWxnZ+ZomZYTNa8qa1JUc+Myw1osqyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UW+Od/NFc+adTzTKNnm/P5qzWiWSq1ZVNK5ZDZ0/WkDy4dFHqKmn8MuGPNn8As5L5Y8/R9j8KyflZ0RJBlVIrM7vA0hYjRowgaAie7NO0Z9In8ECdFkNQgMX5I5XvvVdo7tbFGp1U1Y8UQ28C3h7s/A+Kd3vUjM2yVxBF18R2YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-807007b8dd1so18408539f.2;
        Wed, 24 Jul 2024 20:22:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721877738; x=1722482538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9UNZQIakbqcX1AcTbuUziW8quMf/irCIuvBquh9X+9Q=;
        b=HCwNCcZZWxMCchy4GS4kf92Qn4C4y21wwZYAzohLt+XAsy8MAnVANN5EJKCPqqNGNr
         tu+Wl9c7yptAIwPfdCCsvXzCpbKU0AUxvR9lQn1l8EyGLJ8GPusdicl2GkyU9Zbg+OlJ
         WmUF3XKwpLE4Fo5l+sg0W+UETDcL6EgZ7YUhZX2ZNsIXHtlNFY8EPfnMzMcH7EkW0qXR
         e6q/7sUVMoXSEefII2y9TL5331w0U+GxE+Jtvi17bBgPkNeriRfjrShOBLED7hkjw/JY
         NraTnHljii9i/IjEABhWD+rAgArRpiz3c3UryrSTs46LnxjvDu1MRYEVRmsh/otHKhN5
         /FlA==
X-Forwarded-Encrypted: i=1; AJvYcCU5JCpiZtsbvvVM0WqW+F1nLKv56uCkkaY3JU0GJd5GEe4QOHcsYjwKFHRCOcpqXC5VKzuYodniSjhMU7hh/kWfVEq0XLkNiEDYBYFJ
X-Gm-Message-State: AOJu0YxSJB+DTeV5mE/0T3m0dxX4P0hLaaauP9ALXeNQ7oFDBGYdE9qQ
	xfENLs3sgx0g7VFa+UPx0FkYnO9lQ/zPrQxtt8GjwXaY69dB/mepV/Wnzzd4
X-Google-Smtp-Source: AGHT+IEZSo6IiOfEFmDGUaMKgic38X+teHZqMjp0KriEv60vzWDzDvixKog8qj4QX8TlmzkgEndvHw==
X-Received: by 2002:a05:6e02:20c2:b0:383:290e:6937 with SMTP id e9e14a558f8ab-39a23fa340fmr7634635ab.11.1721877738009;
        Wed, 24 Jul 2024 20:22:18 -0700 (PDT)
Received: from localhost (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39a22e97b10sm2681885ab.27.2024.07.24.20.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 20:22:17 -0700 (PDT)
From: David Vernet <void@manifault.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next] selftests/bpf: Load struct_ops map in global_maps_resize test
Date: Wed, 24 Jul 2024 22:22:14 -0500
Message-ID: <20240725032214.50676-1-void@manifault.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In prog_tests/test_global_maps_resize.c, we test various use cases for
resizing global maps. Commit 7244100e0389 ("libbpf: Don't take direct
pointers into BTF data from st_ops") updated libbpf to not store pointers
to volatile BTF data, which for some users, was causing a UAF when resizing
a datasec array.

Let's ensure we have coverage for resizing datasec arrays with struct_ops
progs by also including a struct_ops map and struct_ops prog in the
test_global_map_resize skeleton. The map is automatically loaded, so we
don't need to do anything other than add it to the BPF prog being tested
to get the coverage.

Signed-off-by: David Vernet <void@manifault.com>
---
 .../selftests/bpf/progs/test_global_map_resize.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/test_global_map_resize.c b/tools/testing/selftests/bpf/progs/test_global_map_resize.c
index 1fbb73d3e5d5..714b29c7f8b2 100644
--- a/tools/testing/selftests/bpf/progs/test_global_map_resize.c
+++ b/tools/testing/selftests/bpf/progs/test_global_map_resize.c
@@ -3,6 +3,7 @@
 
 #include "vmlinux.h"
 #include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
 
 char _license[] SEC("license") = "GPL";
 
@@ -60,3 +61,18 @@ int data_array_sum(void *ctx)
 
 	return 0;
 }
+
+SEC("struct_ops/test_1")
+int BPF_PROG(test_1)
+{
+	return 0;
+}
+
+struct bpf_testmod_ops {
+	int (*test_1)(void);
+};
+
+SEC(".struct_ops.link")
+struct bpf_testmod_ops st_ops_resize = {
+	.test_1 = (void *)test_1
+};
-- 
2.45.2


