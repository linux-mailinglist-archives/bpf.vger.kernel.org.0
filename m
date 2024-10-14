Return-Path: <bpf+bounces-41855-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A988899C7CC
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 12:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F0FC281DC6
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 10:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233201A4F2A;
	Mon, 14 Oct 2024 10:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siteground.com header.i=@siteground.com header.b="GuhigUyp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B7B19F421
	for <bpf@vger.kernel.org>; Mon, 14 Oct 2024 10:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903369; cv=none; b=KH276i4C6usH+guJupjWzfLr2t/gvD9aep3Er22lXwAyMsVKjAHC0dbF9j2IDMBqKRARye4i87Iz+tjJSG8VFsRa2kjJQ1u5iyMYoKsOjR3Ify//sVTBC6KaFXu+o6A/wiOLMhGAU/EwwnwP1N5qUGoSJtBIIVkJLDsHvyfj1n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903369; c=relaxed/simple;
	bh=h231vU2qaRTflxnYe/7yTVGhzXmAnqYnLWuVre2AGsk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WQ1Yl9Qkbs6vL45xaTdq3Dt6qrZPk/cJOJUD9afd6kI3Vl91jDFWauklS9MvNyvox9+SK8Gjwi4O0f3tA+GMLFTMEIkeDDFme6LWK8mSAdjph+/xoDOdYb9jtACU6NTbPvmQNsQhbfw1G/R47S3cSo1Ej1aRFjBuNb7lOHgzyII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=siteground.com; spf=pass smtp.mailfrom=siteground.com; dkim=pass (1024-bit key) header.d=siteground.com header.i=@siteground.com header.b=GuhigUyp; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=siteground.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siteground.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a99ebb390a5so312566966b.1
        for <bpf@vger.kernel.org>; Mon, 14 Oct 2024 03:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=siteground.com; s=google; t=1728903366; x=1729508166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03WgxT/9z6+jdMXK8yb43ceEYV6UMIJmFsUhqeDnZ/Q=;
        b=GuhigUypzfeZ8oNbb7alCh6OEEkEHOlOyo/CIYRjSkQUcMA9yqXcVTUEScJcDD9Odi
         MXb1n1+FBJdiuXKix2xlerNMBaxJS3aUED9l7RZ/oZqz3/bUgH1uk65PAvFU7zo2+Ux3
         HkVgQGyGQklTUCATRVNnhkxS9ZrDKdDLd3/7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728903366; x=1729508166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=03WgxT/9z6+jdMXK8yb43ceEYV6UMIJmFsUhqeDnZ/Q=;
        b=ZwHvxTpAxmgKFsJr+3RW2ZxSVRRjojQQff2X3mBXm1GM4jxOoJbNWdUmoyilC4rJVz
         GzicvGfvcwAMHgvqmNnduEaQ4Mfo6/hSFrbTW0BfgrlxTVzGl66KlK8SnQC+/aluwEj5
         B/iT4wRa0E02T6i+prBT9Yk5QBRFnuLWyF99nqpqYdJkADFwbBZny9DJ5Vqnke4WzxGj
         D7yqTP5GD8t93Uufrb0VGQrzUFR0kJ3xHMoEteJ1seOojYfJZOOUY57KOmaX/03KUNNp
         UHNfH8cRQPOsvEHSKvQ1Ur+GG8VR8jaGUWAizkAvk2UmjncfS1cV3Xpvbmk3XY3JqjBr
         Q/bQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuTyzsAFF+bQLCZrGncZjcnqDJ+InQAqqjmKba0smBWTnMGHiYvSxa8L4Ri1Egq+6XSkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2LOEc658keE3exftfjl9sOIxr30bUsERcKF9V78m6hTIgW2hG
	0A33PWuMKD3YeXz/a8hwP9A5xHoHDuwuemShL9EkUavDgNfRxMvivnIJ0ZLmrGE=
X-Google-Smtp-Source: AGHT+IFzwUYwxbGyE8JafAQVzjK8ebLG9egOa2Z9u1AHC6pwkUjLa92rmRhMkkrbaYynBbqU1niaDw==
X-Received: by 2002:a17:907:6eab:b0:a9a:1575:23e3 with SMTP id a640c23a62f3a-a9a157525e0mr155020666b.19.1728903366203;
        Mon, 14 Oct 2024 03:56:06 -0700 (PDT)
Received: from Dimitar_Kanaliev.sgnet.lan ([82.118.240.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a0c95c80asm159996866b.144.2024.10.14.03.56.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Oct 2024 03:56:05 -0700 (PDT)
From: Dimitar Kanaliev <dimitar.kanaliev@siteground.com>
To: Yonghong Song <yonghong.song@linux.dev>,
	bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Dimitar Kanaliev <dimitar.kanaliev@siteground.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH 3/3] selftests/bpf: Add test for sign extension in coerce_subreg_to_size_sx()
Date: Mon, 14 Oct 2024 13:55:41 +0300
Message-Id: <20241014105541.91184-4-dimitar.kanaliev@siteground.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20241014105541.91184-1-dimitar.kanaliev@siteground.com>
References: <20241014105541.91184-1-dimitar.kanaliev@siteground.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test for unsigned ranges after signed extension instruction. This
case isn't currently covered by existing tests in verifier_movsx.c.

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Signed-off-by: Dimitar Kanaliev <dimitar.kanaliev@siteground.com>
---
 .../selftests/bpf/progs/verifier_movsx.c      | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_movsx.c b/tools/testing/selftests/bpf/progs/verifier_movsx.c
index 8e37d44d87e5..2124d24e8bf9 100644
--- a/tools/testing/selftests/bpf/progs/verifier_movsx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_movsx.c
@@ -309,6 +309,26 @@ label_%=:						\
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("MOV32SX, S8, unsigned range_check")
+__success __retval(0)
+__naked void mov32sx_s8_range_check(void)
+{
+	asm volatile ("                                 \
+	call %[bpf_get_prandom_u32];                    \
+	w0 &= 0x1;                                      \
+	w0 += 0xfe;                                     \
+	w0 = (s8)w0;                                    \
+	if w0 < 0xfffffffe goto label_%=;               \
+	r0 = 0;                                         \
+	exit;                                           \
+label_%=: 	                                        \
+	exit;                                           \
+	"      :
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 SEC("socket")
 __description("cpuv4 is not supported by compiler or jit, use a dummy test")
 __success
-- 
2.43.0


