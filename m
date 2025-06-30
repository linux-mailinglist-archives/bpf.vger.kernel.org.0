Return-Path: <bpf+bounces-61829-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7638EAEDF45
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 15:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9543E3A61EB
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 13:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE35428B3F6;
	Mon, 30 Jun 2025 13:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USchn+mb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C6D286D70
	for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 13:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751290552; cv=none; b=ePAm3p/Zrm+fQdilQmYoqT0WmzXvyVFUGVe3keINhIhM8Edu2lLkP1DzFHqC8NN16Z6FqPxd5bvvpBZfHKmZ/VRFnWbWzT5rn7JilPqRVWHpJwvZCEZoi+36dBUeQ6HdHLcZvbuNGUgcBqaqtx9COWjcvfxuGKUM4tf2VHF0R5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751290552; c=relaxed/simple;
	bh=SlTFOYLn4pEkWyycT0UZ54Pe5TYXxaFCNzMsB8XtArc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mkpzcZ1/DT8kLZxBoYxdXtqxMTbQo8D4lMDa1r2v45tKZvMJ/UMquPa/zLon/S1444LIyldA/5+ktKZRkFIo7RFp274GYchOajAny3z5EdWGoECRtqtAKnmD4ZJsJCE8esemyVTyu8KI+F0XBqujNdW4q0avcjvc8Za2JIB8ZC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USchn+mb; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-60c51860bf5so7638529a12.1
        for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 06:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751290549; x=1751895349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3egW9juECtitYreSCpqCOyjSfS22kJeo55s3QS6PbCc=;
        b=USchn+mbnRKwEusSFvKy7BnwKvn6wj/Lzo2rqadm4HCLYjFjEUG/y8cj+N/f8FCIsF
         Na6jlTQgfg+E/bysxnpUHaLl4i5gQjWBD12rtAD0r4L3glzmPyOmIBJDqcRoSgw3mhJW
         qHKEt56lcumsYU8D+oUBhslYduYle6oz7o3bsvKuhkFpYPIG76uy8W3pNKp2GnBMjuBs
         Sq7m0KEv2CMxCm5LievdITpSsRH71/trnM7vRQ8/Iee5oYVnKAwqAIFtkeNDUiNjDmvi
         9EvLPWJUZexBm+wdmpmTw+8U98tewqxbSi0h/xn7Y3MayV7uDuKq+EYS+TvmPe+q8g+k
         vfEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751290549; x=1751895349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3egW9juECtitYreSCpqCOyjSfS22kJeo55s3QS6PbCc=;
        b=KD4D/qiHuR9TJeD3Jw+h7N4xaqeUtecntA3+bn3BiECgOIBzi4WijK+avq0gYSdwHR
         vtrOrGyhlf8I0fFKUOr05DafVfWX2Qyu5W0JCrRmEcGaIL+ReCDvzyXQhuM/A52fs6Zz
         Wz28iqlSTtDGpubsvEV+0mHjuzJZTLd7qynzt7pN3L4sEtfdiZxrtN79p49qcGcWSKpc
         NRf6dM9PA4AReAPTGPi3kz57FRMsMQ7MJ7xNPb/vT0GyAAkBYjByYWxXaZsTc+qcmYUc
         BJDX3WYV6AmKi0qI1mDZaMK2yLHZeTRhrzKl/ejl7HVnmVla7C9edxPvs3y8IDCkUome
         E+Jw==
X-Gm-Message-State: AOJu0YxB9U22XpXMO8Xqx/9uEh1JmANA9VOVWnl+UKdBUD2eM9x1n6Au
	Gi7IQjtn7hu5dyqzTnWx4uO90ffjr1AY4sZne51XadP89L9Cf9uFVuvHCg5dc/JA
X-Gm-Gg: ASbGncug7GfAqCmOXqEn6HcvJkVuShZZvkJon1qn5/3rsmeOsZnVzBu/aEHvR5VrZNL
	RJBzy8V6OTn29n1oE0GTh+Ip4q+Kj8G6xph8fAtn6IIUUXtohAKxxIw0y0cjpYlF40h3G55jM5I
	FODxjEoU5Wx+ZKQY8Y43fuGRQgACoYwbypqocZTMooOcWcbOJQjLQ1swyK0yTDiy4o1qxSctKY6
	P7o8lurzQzRhoGxj13oB/p815EJTNVxYVDfMlFrCPvF6ceLXQE4y61Yd6O3rWz4NNXJy2SiE2QF
	4XMQBPT+S2pX353yxsvFo7pavmyv+k7T6FqI4nFONa18ukBtMgnL
X-Google-Smtp-Source: AGHT+IFIy5CjRtrORa+zxh6rMTeNGmmw1mRXzzoO9H4vMxb0Pb1YebKlqJGDm4wpFa3yjwoyuTC87w==
X-Received: by 2002:a17:907:74c:b0:ae0:d7b3:848a with SMTP id a640c23a62f3a-ae34fd336ebmr1252421166b.2.1751290548759;
        Mon, 30 Jun 2025 06:35:48 -0700 (PDT)
Received: from localhost ([2620:10d:c092:500::5:a4b7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353ca1cc9sm663907666b.168.2025.06.30.06.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 06:35:48 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next] selftests/bpf: enable dynptr/test_probe_read_user_str_dynptr
Date: Mon, 30 Jun 2025 14:35:14 +0100
Message-ID: <20250630133515.1108325-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Enable previously disabled dynptr/test_probe_read_user_str_dynptr test,
after the fix it depended on was merged into bpf-next.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/DENYLIST | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/DENYLIST b/tools/testing/selftests/bpf/DENYLIST
index 1789a61d0a9b..f748f2c33b22 100644
--- a/tools/testing/selftests/bpf/DENYLIST
+++ b/tools/testing/selftests/bpf/DENYLIST
@@ -1,6 +1,5 @@
 # TEMPORARY
 # Alphabetical order
-dynptr/test_probe_read_user_str_dynptr # disabled until https://patchwork.kernel.org/project/linux-mm/patch/20250422131449.57177-1-mykyta.yatsenko5@gmail.com/ makes it into the bpf-next
 get_stack_raw_tp    # spams with kernel warnings until next bpf -> bpf-next merge
 stacktrace_build_id
 stacktrace_build_id_nmi
-- 
2.50.0


