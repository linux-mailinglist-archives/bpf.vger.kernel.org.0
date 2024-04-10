Return-Path: <bpf+bounces-26347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA46689E709
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 02:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FE1B283FA8
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 00:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BACD34C6B;
	Wed, 10 Apr 2024 00:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4+fPJUX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73324A12
	for <bpf@vger.kernel.org>; Wed, 10 Apr 2024 00:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712709728; cv=none; b=BUklloZwOvikHZlymS1+1Plwa6frsGa/5LdLNqkD8yeOFokXi+q/ELXkwY3g3mxGYGRZruiR7hIdYwP6xja9/8KXkF3QfgyL2i3IDYQ7+p2YWo2oVXYmo7Kzma7TQkS8rOXaL1HwhSbgdc6MZrzsCrGR+i6W0rnpKaIrhuvcvJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712709728; c=relaxed/simple;
	bh=WqjYgyHey8ZaGJ0KCr/4HIlllNyG29jbp0/EBTx83R0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SrwbR09vu8uoLy3ge2JSoMqqIWMOL7INlOJycrpdx0T1oUfhVxl+AGN88evspxFpYhIuKE8evR9ZFrpxLcH1TRN1LLKGHIhkb3WOlzbtqDLzVv1azt3lPioKqPuLcyZmnylArZdJQFbz9mVEPgqhGT9LSDXu9X+OwWam5BTe+Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4+fPJUX; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6ea23720da9so750867a34.2
        for <bpf@vger.kernel.org>; Tue, 09 Apr 2024 17:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712709725; x=1713314525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0q/ZdC0G1jUqK369GNantm3vlcpUDTGm2krIxfZLzk=;
        b=J4+fPJUXekrC57c+Ak0El/dcV2jy2OXO9/OidO7AG2vqMI/hX4sbMFr6ghDrVcQoFI
         mJ/RgfWofHkyE2inPwDNq7iw9mY6qnecpRDS83gRJjrGmuQ/HKbzyRhr79QgBBXDYD3J
         KM24VO4eszADjj6fVEbxGmbbwpXsQW/gEtPVJEz7OKHJRRsV4gYmTw2f+eQ/9ufGTuIp
         c5vWDhgbFhDB5Xwn+oDXTM4yD4pyDiaze2NJZuc8etl3MijX1maT+oPPLlqQUwM/AEIe
         RRkhm8ar+ib3MnZJgXzotFPT4TpHi3E55t1ZBxljco3dHM9IkQEzd66iXzDRol4CSW+y
         RBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712709725; x=1713314525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A0q/ZdC0G1jUqK369GNantm3vlcpUDTGm2krIxfZLzk=;
        b=UAMsddGf/xRtqWtq8niNAx9EYi8SW5WjxFzvmZQeUjYXAVkAC4dGCukzZwwPM2LI2g
         nGZ+eou2ritYRg+6LwjBhLLKEmKUIkHKC1ws6GucZcm5kLTSiZKOuvBjpQSElKrboXGt
         gw+ASQmsH6s9i6GBPgDkdLEzMpjCAUAHcA+raUrEKAh5ODpOWamEtJ43oJf6jqSPMP0C
         4DJgmHmf7rUmt3dbLgmVagCDzcPX/+CII2IfXaM5dJnFzUsRIH48EsuhrOQZ/+WPz65F
         Ad2QtOBcnwhRNtJpSGLgL5kioMzxXK0szPzf7FXfn4epxrm3IexphjuT84nfJjK9p3Kn
         VbpQ==
X-Gm-Message-State: AOJu0YzYZkTRTKnskbihoqGPVj74FlcdyuS7m+dMz44Pz1KFJb0IpmuP
	KwEQeg2dRLVXU9/Ttmdc1A5hgF/zv+xFKtNkUxYMKB4iUANWf8tk8es/GbkK
X-Google-Smtp-Source: AGHT+IFYFs/0QuOmeCNIJvy3KxWbeiotDFof06gYvVkTk6NA6k9CpKpEnzF1QyAwULpO7VJKRMomDg==
X-Received: by 2002:a05:6808:4b:b0:3c5:fca4:17a5 with SMTP id v11-20020a056808004b00b003c5fca417a5mr1070729oic.2.1712709725419;
        Tue, 09 Apr 2024 17:42:05 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:d330:d0dc:41bd:be5b])
        by smtp.gmail.com with ESMTPSA id bf10-20020a056808190a00b003c5fbfe3ac3sm505124oib.21.2024.04.09.17.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 17:42:05 -0700 (PDT)
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
Subject: [PATCH bpf-next 11/11] selftests/bpf: Test global bpf_list_head arrays.
Date: Tue,  9 Apr 2024 17:41:50 -0700
Message-Id: <20240410004150.2917641-12-thinker.li@gmail.com>
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

Make sure global arrays of bpf_list_head(s) work correctly.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 .../selftests/bpf/prog_tests/linked_list.c    |  6 +++++
 .../testing/selftests/bpf/progs/linked_list.c | 24 +++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/linked_list.c b/tools/testing/selftests/bpf/prog_tests/linked_list.c
index 2fb89de63bd2..0f0ccee688c5 100644
--- a/tools/testing/selftests/bpf/prog_tests/linked_list.c
+++ b/tools/testing/selftests/bpf/prog_tests/linked_list.c
@@ -183,6 +183,12 @@ static void test_linked_list_success(int mode, bool leave_in_map)
 	if (!leave_in_map)
 		clear_fields(skel->maps.bss_A);
 
+	ret = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.global_list_array_push_pop), &opts);
+	ASSERT_OK(ret, "global_list_array_push_pop");
+	ASSERT_OK(opts.retval, "global_list_array_push_pop retval");
+	if (!leave_in_map)
+		clear_fields(skel->maps.bss_A);
+
 	if (mode == PUSH_POP)
 		goto end;
 
diff --git a/tools/testing/selftests/bpf/progs/linked_list.c b/tools/testing/selftests/bpf/progs/linked_list.c
index 26205ca80679..7c203b5367a7 100644
--- a/tools/testing/selftests/bpf/progs/linked_list.c
+++ b/tools/testing/selftests/bpf/progs/linked_list.c
@@ -11,6 +11,10 @@
 
 #include "linked_list.h"
 
+private(C) struct bpf_spin_lock glock_c;
+private(C) struct bpf_list_head ghead_array[2] __contains(foo, node2);
+private(C) struct bpf_list_head ghead_array_one[1] __contains(foo, node2);
+
 static __always_inline
 int list_push_pop(struct bpf_spin_lock *lock, struct bpf_list_head *head, bool leave_in_map)
 {
@@ -309,6 +313,26 @@ int global_list_push_pop(void *ctx)
 	return test_list_push_pop(&glock, &ghead);
 }
 
+SEC("tc")
+int global_list_array_push_pop(void *ctx)
+{
+	int r;
+
+	r = test_list_push_pop(&glock_c, &ghead_array[0]);
+	if (r)
+		return r;
+
+	r = test_list_push_pop(&glock_c, &ghead_array[1]);
+	if (r)
+		return r;
+
+	/* Arrays with only one element is a special case, being treated
+	 * just like a bpf_list_head variable by the verifier, not an
+	 * array.
+	 */
+	return test_list_push_pop(&glock_c, &ghead_array_one[0]);
+}
+
 SEC("tc")
 int map_list_push_pop_multiple(void *ctx)
 {
-- 
2.34.1


