Return-Path: <bpf+bounces-22485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB1285F185
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 07:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98B93B23BA1
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 06:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1587EE573;
	Thu, 22 Feb 2024 06:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9JTgTxK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B391A3F
	for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 06:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708583614; cv=none; b=g4YzEjwvYZEAos+/S3dwbyxhr7yF1BS/73r/POKlWALnu5lLDK3YAFtWbecoEgS0cuqqgYrLUEeb0nOO9nFjcyecs2GzlWXoDKGOJu10BRXPCc+ukpuPpat10sF+scKeWNhevu0uRAvq8WDnOjEB/Lt5uPLDMA0xeEV3qiEiqbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708583614; c=relaxed/simple;
	bh=vVk+s9gEFq1IwxaNcly27FQTylt6TowOk+zTiViWasE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AfD3+uIEMT9oi4zJ+0UQibg035ZokZOi/eivIrPtMEJ0I0VYDGDRJqEK11FQ70GnKBC06kuWnLB6UEbnlO4r9NZNEkYxsM0w8dWrCMxGLFW6S4/uYsmQEt4pVKuuLClJaDwyvub8wICUbyuCRHWa4vmFEw+jmvxmUkIORK9HaQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9JTgTxK; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5cfd95130c6so4400182a12.1
        for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 22:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708583612; x=1709188412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZqLaKdUT3HdPF6OhE8gzonfu2Bf0jcsouVlq+wMe4c=;
        b=d9JTgTxKnrx3LCpxenIk/wPNpynYCaLNZ6Yy6sF076klKKZRhz2DWg38I8k2L92VHj
         n7xBixdAC3P26PV2k/snVuCMmh6Nn0O3o4sGG6iNABpwWo5kiFD/FlrElq8rLFNMLK86
         47fXVUK5xC5BMu1Q9rQGvP17SdS39kI8SkU5N8bN1Vsc9zmrvUjElkMK2AZMI8WfbOw4
         TCtfcSlkLdTKhGXyuhV/XDt20F7R2inD+7736i7TJra+i0uonodqJ6C2qOZw+pOoQF0y
         Xdt4zw2RN6Yer9FDg+vohoJPb2wHzR+L90+xEzllMqB/nsiPe8eH8LYPd8rU53fTB3fT
         3QAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708583612; x=1709188412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ZqLaKdUT3HdPF6OhE8gzonfu2Bf0jcsouVlq+wMe4c=;
        b=I6u206UQF6oDYGuUf+Bdofj+6K1uKZj+6NxstqDxrAsg/64G/4/43sxpKGhH9zRv/p
         cv4S8OJ9YXPhFmAfhVam3cWg8pfjTumFcJDskXRAGskw+wgJNebzx+27dfZumCU8CZDO
         xJ53SXBE61hWyxTOF2R8s3dRMT9OFL3+tU+NSYTN3Awtj2hhq+zAjKettPvoBzFdvZYe
         JLbvDtFkVUd7knNOzmatxd3h81E1oKuR2EqbSsGhBxXNLK2gP/hBSKPJvakg7q77WY3t
         qdVJYdbOxiJjWn1pat8yNY+gE1SJCmN02dZBOz2e8+9zJLuTpfpJJ1zn85xkYLj9oiRs
         O7jQ==
X-Gm-Message-State: AOJu0YxDw/Y8rGqblAmA4Y7mFU5hrtnX2X51Vc+ge1j9DCBTRxVn01cq
	xSZ/oO0++7xW9U1sRXiTMh2oYOxIWfZtfV6xGsRjrjcoc77D971sX58j4cD+
X-Google-Smtp-Source: AGHT+IH7MlLfxJ+NTIcZiB8FctzbIqByL/0tV3hOeXQD2xTfwfEpNhjxraYYj8CwFSJvlbwU2ep0rQ==
X-Received: by 2002:a17:90b:1d05:b0:299:5bef:7aee with SMTP id on5-20020a17090b1d0500b002995bef7aeemr11108023pjb.31.1708583611859;
        Wed, 21 Feb 2024 22:33:31 -0800 (PST)
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:400::4:b11c])
        by smtp.gmail.com with ESMTPSA id u17-20020a17090adb5100b0029a04d96d02sm2795570pjx.11.2024.02.21.22.33.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Feb 2024 22:33:31 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	kernel-team@fb.com
Subject: [PATCH bpf-next 2/2] selftests/bpf: Test bpf_can_loop
Date: Wed, 21 Feb 2024 22:33:24 -0800
Message-Id: <20240222063324.46468-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240222063324.46468-1-alexei.starovoitov@gmail.com>
References: <20240222063324.46468-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Add a sanity test for bpf_can_loop().

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/bpf_helpers.h                        |  1 +
 .../bpf/progs/verifier_iterating_callbacks.c       | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 79eaa581be98..70270f07074e 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -307,6 +307,7 @@ struct bpf_iter_num;
 extern int bpf_iter_num_new(struct bpf_iter_num *it, int start, int end) __weak __ksym;
 extern int *bpf_iter_num_next(struct bpf_iter_num *it) __weak __ksym;
 extern void bpf_iter_num_destroy(struct bpf_iter_num *it) __weak __ksym;
+extern long bpf_can_loop(void *ignored) __weak __ksym;
 
 #ifndef bpf_for_each
 /* bpf_for_each(iter_type, cur_elem, args...) provides generic construct for
diff --git a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
index 5905e036e0ea..7c2025e58554 100644
--- a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
+++ b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
@@ -239,4 +239,18 @@ int bpf_loop_iter_limit_nested(void *unused)
 	return 1000 * a + b + c;
 }
 
+SEC("socket")
+__success __retval(0xa93addc0)
+int can_loop(const void *ctx)
+{
+	int sum = 0;
+	volatile int i;
+
+	for (i = 0; i < 2000000 && bpf_can_loop(0); i++)
+		sum += i;
+
+	return sum;
+}
+
+
 char _license[] SEC("license") = "GPL";
-- 
2.34.1


