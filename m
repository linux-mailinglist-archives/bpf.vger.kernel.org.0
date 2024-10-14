Return-Path: <bpf+bounces-41864-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EADD99C9C6
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 14:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BFB81C2282C
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 12:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F8619E806;
	Mon, 14 Oct 2024 12:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siteground.com header.i=@siteground.com header.b="Q/h2J8tE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3676619F432
	for <bpf@vger.kernel.org>; Mon, 14 Oct 2024 12:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728907932; cv=none; b=iqEnPO/PkrO3CrcrVk2MV29oF+Isc5N5RXabchh/FQ9zouQi82h2RIYGGMBLbUK5NduvJqx3LGsi1W7GH+S0PJEgtFaDkCIcLZBvb4nhLVOE4PUbKzUkiW4t9DOwTcGAfTrgO5tkQ1i9JJfsXd6jDEWUZSm6VYC+qyPxaShPXU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728907932; c=relaxed/simple;
	bh=TpgRTObCgG+zHx9YOUDCYwVitY5AdiWQ8fahbmaCn+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qnz4wpf5GwvFYIzNh7AT1oS7XIbaKtZOCndIG1Vqod4un/FO0F/2CIxUdG93BTPs6yt2EKyxo6D66CvHWJ+zu3PZ1l4QeQIdaqcnRTT8mYIfeK68u72Iotv3MTbqyQI+sXDIP3Qm2Qvs5JfQrGrK3kjSUYJ5Jj7GAO1w9tF7ELk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=siteground.com; spf=pass smtp.mailfrom=siteground.com; dkim=pass (1024-bit key) header.d=siteground.com header.i=@siteground.com header.b=Q/h2J8tE; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=siteground.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siteground.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c9709c9b0cso1889495a12.1
        for <bpf@vger.kernel.org>; Mon, 14 Oct 2024 05:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=siteground.com; s=google; t=1728907929; x=1729512729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RdzQ/RTUJwamkX2bi729ofbRHjeC+nZDcanO1XCbU1s=;
        b=Q/h2J8tEwATZTSZ0f3tJkyfo7kEouNTCi/mutpVCqy0mlREOwHAv2DBAH2VVRXZT+e
         0pbikAPGgKnHLh/w7cxvonWNlF94+xn4y51puuv5Kx/sFvrKzr/WSv67asys3lf3lt9f
         +jOWwlUU26ENdzYvjx0XZDv4TTeZKhgK8Qw6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728907929; x=1729512729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RdzQ/RTUJwamkX2bi729ofbRHjeC+nZDcanO1XCbU1s=;
        b=o8psY89jbezZ6oixiv2KNYBcVt25fxkjYWJrybV4ddI1pSyRXt3NBlr+5OBkBvaMFt
         6W3qxCmZGD8WqjtXFzhyOSxLgPlOZfMSNUaqUjyfEwo6x54ymoRix3f9JlvZMW7IkmKh
         NTG51Sblk+LWR2QS7qt31qpqW9GNRXXzW7hnu3fAqPNrN0v2X18YIRUbsGiY6G3fXurq
         AdAzBW3yk2hPMF5xD6ZetyQ/25JkoixtAewmk5ZOpkgmUZDf8FLZJqWtXahkQAJ2gi6B
         HvxjdI7k3krGdy6PHg+U+s3O+OcoxQ3EdwWOMpypgUQjQbxSykWz3Lz5BwDr+qVIkPiY
         /88w==
X-Forwarded-Encrypted: i=1; AJvYcCVdHewyNcvK+N2q4C/6n5CvuyITtO7KswkozITQJ/RuJZLW0sxxIQt6R/rt91Q6UnDcvrI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx819L2EFPiyL05+sokB+fk2yppz2PCqDrFzcoJDrD2rLqZG/Zz
	+avEvsit1PhCADfqLYn3x9gQ/QeoQn80SpSpNawz6INFx+b8I5ossmFtPqQOCyw=
X-Google-Smtp-Source: AGHT+IFMH0LSlGfakPLkWnpAgWW48a4jpLgM4HxwGWeT4U/5oeVLF7JDPT/IoiilO6MmTIOi8GQ6tw==
X-Received: by 2002:a17:907:7ba8:b0:a9a:1b32:5aa8 with SMTP id a640c23a62f3a-a9a1b325dc9mr96847266b.4.1728907929430;
        Mon, 14 Oct 2024 05:12:09 -0700 (PDT)
Received: from Dimitar_Kanaliev.sgnet.lan ([82.118.240.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a1ac71a7fsm55293666b.15.2024.10.14.05.12.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Oct 2024 05:12:09 -0700 (PDT)
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
Subject: [PATCH v2 3/3] selftests/bpf: Add test for sign extension in coerce_subreg_to_size_sx()
Date: Mon, 14 Oct 2024 15:11:55 +0300
Message-Id: <20241014121155.92887-4-dimitar.kanaliev@siteground.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20241014121155.92887-1-dimitar.kanaliev@siteground.com>
References: <20241014121155.92887-1-dimitar.kanaliev@siteground.com>
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
index 0cb879c609c5..994bbc346d25 100644
--- a/tools/testing/selftests/bpf/progs/verifier_movsx.c
+++ b/tools/testing/selftests/bpf/progs/verifier_movsx.c
@@ -307,6 +307,26 @@ label_%=:						\
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
 #else
 
 SEC("socket")
-- 
2.43.0


