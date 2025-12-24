Return-Path: <bpf+bounces-77417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C176ACDC57F
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 14:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F3AF305B912
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 13:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7723491F1;
	Wed, 24 Dec 2025 13:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLba7lP5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AB0345CBF
	for <bpf@vger.kernel.org>; Wed, 24 Dec 2025 13:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766581808; cv=none; b=QNIYyxAbG/+HBpB2/HooN0/pX60+6KgfTtOCKykkHiua0v2bR5FjhIRe5yNeXVOGysGOwzSEU4eLcLNaC2igTHSMm5vWcnSFOWb4BDE8WLalDYkzH6PLKgYKhh9pbho6aUGsTxmo9oNTLqy0RM2k+EMG1+B0bokGQgMNEkZr8u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766581808; c=relaxed/simple;
	bh=ARq0/QucFj/sxPqr+22ybRos7rUcjBBi5nq/Y4PoAvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bCHxzagBIzcduND1BUKhu2VdQ583mT55nd/YuZANIs5COLB3Kds8Hl6EspYP0Nn1gI0lYhLs6X2alNPX0jPBh2Mzy2s23orAjuYxhS0T3wUbv+nKj5M/ckuJMu5q+Qe94D0zZfoDDq/znIQe9K3IY3FUZWDZtE3Qhto5wT0P9wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CLba7lP5; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-7f0db5700b2so5301684b3a.0
        for <bpf@vger.kernel.org>; Wed, 24 Dec 2025 05:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766581806; x=1767186606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ki8yj47Ksf2sOkp6JBKCA9cB1ptX2Wx6sb0cvY7RlMA=;
        b=CLba7lP5VtaP3jg1Zy6VGKj+qXkZLv2HZF6wTH5Gx89eYoaKF0H8yXxGIRJt0mpXh9
         3nKjeer/OTbF5GqczyIJxslYO4lRGRJ6ditMguttBKCAazkSOwixtLf4hxTpBWm0ilqK
         xmT0YfaxIe0xWDz40sftNxLYOxVhbqxazqKzt8U0eM++PbjEmMmAFStasJaUrYFMtDA8
         tkc+UVy5dpf5zkv6qc8FiVlf+9bgophfRUZ1pI5H1UJBRrwFUrhL2I3wTK9b7bajPqpV
         OK1TkjHR0SeVsceQ9Q+APS2z5QVlVl+6cYZZaQMT1N+UvjwxkzD2ABmINL9jM29yL+Xr
         rq0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766581806; x=1767186606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ki8yj47Ksf2sOkp6JBKCA9cB1ptX2Wx6sb0cvY7RlMA=;
        b=jUmhaSWCGBk4N1Glt/gCbfdLKFai9jN/Pm8Kw30s7MBzewxb6pE4RVsbGWK5IEKBkl
         BUmkVE8Wc8SAUq7m8UDNP0D7SZkYwLbi3HbrDnunpKjUFWsKax7JOoi8LuUlyHSbN4fL
         zCoGBqnmO8aPZLSQbF3oaPlhw4jHAXWpxfiINcYwbzTy2OhZnOQYIF3CJtSD8KeDi4rY
         aX5OsfwC9TWXH6kWofkXiIDQK4FsNIYrwfx0BCao7bPzb6EStCktR7UCBERSH+izGLtQ
         Pgv7wyIfUjDsl0zVZcH/dauWWJKbMQ9nKp47FmesJkQgNE2EiSriGI9qtxE6T85+Aogm
         +ZnQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1eEAWiyxJEaHDQSqicXFbXQOcOchlODdRkjNtfQ/LDmFp/t1XC32/MGnHfBIH05dJDiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtIZMc2/ylzPzjvxOnTlq8tc45nGDdUpHGy9wsrFr/FZjkF+kU
	+wyHUxPl4cq0+Fv1SHrWKSWH07r8r2iNpAdT8bUJyiCXtLW/FPPSfv5z
X-Gm-Gg: AY/fxX4XtjpQ4MTEO4m+V0ktbq1ss2b/yF/RkPIOfOsvj06PoUCHktHtu4TR3CyxOm9
	PLUTfs2pBQ8tFCOhpdgsMIhuEAOMUZeXtQ5qRxKvVojxbD2FdTeRMN6TNFb2pqZ/0FwGhM47ydI
	0uUqCnwVOabcpgm8wB0WPYMOAYVLW4SeSDZ6eWcUtIt8qlMTkEIfKKc4IwkjRJNq8MZ0e5SKqdW
	Ztc0vZaQ2MPzU+f4RN0lfSxIDvEcvgdMvoPL7dLtvI6pjipNccrlWoYk1FAX+punOVOPWooRac+
	YH4jBLEXmsM4BgGCLIBJPi2Wfp1Tgu+1zLhFxtGxqK0CxLFLt5hZQeh8A69xKl8toVjqC60MNIA
	L7lmviTMghUBh/TiJ3Jazs8E0LVjt4R0azuzbBG+yr+uN/G67J8fuHZaLkMh/1H2hCXCaxtvE4Q
	5MKyf5PuM/XfTF4SQc+w==
X-Google-Smtp-Source: AGHT+IEsQ3y6BfEUuR6gPcWe8dQ3+JU2VN7JGTtTSLSdiP5hgCSTgDCloIJCRNjxPEDqHrTRUmPDCA==
X-Received: by 2002:a05:6a00:2c85:b0:7ac:3529:afbb with SMTP id d2e1a72fcca58-7ff648e9b90mr15231794b3a.20.1766581806344;
        Wed, 24 Dec 2025 05:10:06 -0800 (PST)
Received: from 7950hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7dfac28fsm16841173b3a.32.2025.12.24.05.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 05:10:05 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	jiang.biao@linux.dev,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v5 10/10] selftests/bpf: test fsession mixed with fentry and fexit
Date: Wed, 24 Dec 2025 21:07:35 +0800
Message-ID: <20251224130735.201422-11-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224130735.201422-1-dongml2@chinatelecom.cn>
References: <20251224130735.201422-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test the fsession when it is used together with fentry, fexit.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 .../testing/selftests/bpf/progs/fsession_test.c  | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/fsession_test.c b/tools/testing/selftests/bpf/progs/fsession_test.c
index 5630cf3bbd8b..acf76e20284b 100644
--- a/tools/testing/selftests/bpf/progs/fsession_test.c
+++ b/tools/testing/selftests/bpf/progs/fsession_test.c
@@ -180,3 +180,19 @@ int BPF_PROG(test11, int a, int ret)
 	*cookie = 0;
 	return 0;
 }
+
+__u64 test12_result = 0;
+SEC("fexit/bpf_fentry_test1")
+int BPF_PROG(test12, int a, int ret)
+{
+	test12_result = a == 1 && ret == 2;
+	return 0;
+}
+
+__u64 test13_result = 0;
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(test13, int a)
+{
+	test13_result = a == 1;
+	return 0;
+}
-- 
2.52.0


