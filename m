Return-Path: <bpf+bounces-21491-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FC584DC72
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 10:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D113C1F2239B
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 09:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929B66BB2A;
	Thu,  8 Feb 2024 09:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsVvG76H"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8CE6BB25
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 09:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707383403; cv=none; b=lk4rDNJ33Q7v7Oiv98vXWzrtqVZZvUOjFbIG/ZPfIky4qQeUZxfP2NI0TsIsS0mDsz++wk3XnjSqgk1DvezSIDOVUsuTsD88PC+ra1/KUhTvre8x03FlUwXDVGu2VvlaUjH1Io+0uPkiwXR86WQKkFIiq854WG2ZQbFY719qci8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707383403; c=relaxed/simple;
	bh=7YAviJtne8Q1HbC8GlxM7WH84w5CNQljmhiywgGWsvI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=obmKwQxcf1X2gGwZGDmshG6K06GfIoTLV5lmZOr6j2hhUWMkZsHW+sgaobI7NyJCs7qAiJizHwli79dylAJMQA0COuo+ckL9KRhryAW0A0UZbKd5AwEiUOsRXfqljyalDft3xOPUg2ZLfClgOrE1OYhVOZSesaBxCQ/U/XgqRV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EsVvG76H; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d8ef977f1eso12761665ad.0
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 01:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707383401; x=1707988201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vxqu4vefOu8/xhw0fEkde3w8WIGJp/rlWw1+Z3g4yo=;
        b=EsVvG76Hy4gjbo/ucNEdHzhFGJruwueHSYI+5aCyH8E6YmVrX6Fjksq7j7kODUUB49
         PT+08jyU2D5iyr5Gf22YZvivKwWQOPA6eMFtc1aQPCU2UfMPhZlLuymYmryxPffnXJGM
         9E2ySdzbOHELuXEgwrCU7jvuoXBmeyjgZSU01YsomPaTxxLP6fJ5TsCEu9we0eOyc/dU
         aO25qDXlls4D7garLgnYqaXHJpildFFFYT3NXIPfjx+Z3C3kmnZMvGpz14iwVPa07QMF
         5KATivTc6MAzbqhLxvvqBB2lzzVPXn6EedYDcAcUXRsgSD5Mcb0EbO9GXHjiXRK3zA1i
         IkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707383401; x=1707988201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6vxqu4vefOu8/xhw0fEkde3w8WIGJp/rlWw1+Z3g4yo=;
        b=fVl6FDUuCpCZzVv3CJDyHRDLVe3hUWSTbVshuvHPTX9oF2fSv4W+SKj1idcSI8vrAc
         gn/HjkFmVzptmdCErMesPn01p1D5/VzF7rOqTwcOtMv8ljGcXM0Q6BRPOvNKsm+CDEpW
         nMVgY3ka2ID1ylw4SVhXv31T+l3gW89kWXtbFhBa0owk2Mxa5fHzF+ScOTLC9rklEada
         IuMstq8Dgmg/pynLKmDbtNv7A4vJucAvuVZTs41tJh+NfK5qJ+6VrZnn8eDJGvM0/DsJ
         IdYlb5bOE4Uh6HD7hJSwJTgOMo6lN/Q61KY3e8aC1UC066kz9KRSWfiRUhfw8yTuwLdw
         9vFQ==
X-Gm-Message-State: AOJu0YyoYWZ9NxiZsxQfi9AtTiatiOB8LuEopw1Adh8pahCufDNG5off
	Dvst0RDq6UKIKJ1EAj1uSDngwLf2L0fdFIa3ezmN0W1Dd0yVR0Fw
X-Google-Smtp-Source: AGHT+IEBATmBuDtAuOjeLyNCcfuk5Db6S2fWzuR05WgWsZm7kJVpwzP67J+am5K+Eke1/Un0h5iiJA==
X-Received: by 2002:a17:90b:80e:b0:296:3a5:6fb8 with SMTP id bk14-20020a17090b080e00b0029603a56fb8mr5191505pjb.25.1707383400802;
        Thu, 08 Feb 2024 01:10:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUGcECXuq4V49UanEMwJrBXkcMDoGbiF2w4X35SDmpjzwL2Aom52416v4Fa3QAQ8UI858rRAdMPEiTySiiMf1pcivVpx99WfNGoKmNR9efVV1xw2Lp2ftmfnmLEYqG7E4s1OHxU9CPv12vLGYCuZoPr55DKXAsWMCVWTKUVZIsxskwL0Pgxzq8Dwn7P2+u8A1PCwKKWeJOu7yrCOMrb1pxcimvK4OvphE/eL0f8ThPJn6VqKpgIpkirhCHOoQHdlt6aQe4Yk8QzRJBsScphOJG6JTB3ATOWKtZas6pifRfdjFSZyWoOnKJresWlxaKjY5wxwmUCGYmLviGt5fkykYmjXKF+n7HfC8rGFUA27r8T6idiNi1kbbPIxcIJ+PmezW4Q0Kw=
Received: from localhost.localdomain ([39.144.103.18])
        by smtp.gmail.com with ESMTPSA id gg18-20020a17090b0a1200b0029685873233sm952361pjb.45.2024.02.08.01.09.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Feb 2024 01:10:00 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next 3/3] libbpf: Check the return value of bpf_iter_<type>_new()
Date: Thu,  8 Feb 2024 17:09:06 +0800
Message-Id: <20240208090906.56337-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240208090906.56337-1-laoar.shao@gmail.com>
References: <20240208090906.56337-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On success, bpf_iter_<type>_new() return 0. On failure, it returns ERR.
We'd better check the return value of it.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 tools/lib/bpf/bpf_helpers.h | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 79eaa581be98..2cd2428e3bc6 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -133,6 +133,15 @@
 # define __bpf_unreachable()	__builtin_trap()
 #endif
 
+#ifndef __must_check
+#define __must_check __attribute__((warn_unused_result))
+#endif
+
+static inline void * __must_check ERR_PTR(long error)
+{
+	return (void *) error;
+}
+
 /*
  * Helper function to perform a tail call with a constant/immediate map slot.
  */
@@ -340,14 +349,13 @@ extern void bpf_iter_num_destroy(struct bpf_iter_num *it) __weak __ksym;
 	/* initialize and define destructor */							\
 	struct bpf_iter_##type ___it __attribute__((aligned(8), /* enforce, just in case */,	\
 						    cleanup(bpf_iter_##type##_destroy))),	\
-	/* ___p pointer is just to call bpf_iter_##type##_new() *once* to init ___it */		\
 			       *___p __attribute__((unused)) = (				\
-					bpf_iter_##type##_new(&___it, ##args),			\
 	/* this is a workaround for Clang bug: it currently doesn't emit BTF */			\
 	/* for bpf_iter_##type##_destroy() when used from cleanup() attribute */		\
-					(void)bpf_iter_##type##_destroy, (void *)0);		\
+					(void)bpf_iter_##type##_destroy,			\
+					ERR_PTR(bpf_iter_##type##_new(&___it, ##args)));	\
 	/* iteration and termination check */							\
-	(((cur) = bpf_iter_##type##_next(&___it)));						\
+	((!___p) && ((cur) = bpf_iter_##type##_next(&___it)));					\
 )
 #endif /* bpf_for_each */
 
-- 
2.39.1


