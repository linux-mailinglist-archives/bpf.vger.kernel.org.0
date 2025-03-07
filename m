Return-Path: <bpf+bounces-53531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD5DA55F46
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 05:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 267F93B312F
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 04:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DA519006F;
	Fri,  7 Mar 2025 04:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="z3P/HdZz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B636DDBE
	for <bpf@vger.kernel.org>; Fri,  7 Mar 2025 04:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741321064; cv=none; b=hhL9vt4IrbGg0l2+fTJp7S7qps6ylnJTeZd7eDlGEASR72LhubjxBPrMlqeoe9mxeSqh0NLHZc/fWtt9yaZXelBzkZn836+kVT/FAh+gIUtlCsRXcLoNx/RZnlJrnQ+xBcjltnCg/nkLaIIsVS7d3lZbmymGECSWkg+klS/tkcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741321064; c=relaxed/simple;
	bh=xdShkOOpdsdvUAtqJhj5uhUYPOZA9n3z3vvUfu/DIx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N9KIccVuLHbKy1SZzMkT5qNIEFYmhN45amT1L79EapH4boB7jv6/86C3P877GziwrEuFp6ZltF7GuNyGLjsrmjw5K4taCsga7JzPxkbXINAIY19EEDx3uIegcxRw2SxeFXvXIzXHS49p0jV9LTJ2qiBGgYZdgeJEjP6y5drkZ5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=z3P/HdZz; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c08fc20194so255622285a.2
        for <bpf@vger.kernel.org>; Thu, 06 Mar 2025 20:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1741321061; x=1741925861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EVndE003Dh8Wm43eXqoX7dRdAT2oUBEfiwAkBEcsAD0=;
        b=z3P/HdZz8XXV5wx5QQTsJi93Pysr9Pay18IgeC4r6cL3kc+7b19tpWulFx0mwrq/qM
         bbTsX4TsoM/r8zxDsio6xEsPZwkUtpx2cSB3SNsH+LGfLWjKeaYKg3gQm9+LUCpa4qR9
         6DSw0wRYDP7oYAH1UGnwGTuPe3XiTbl7wA/Ks6E3eq/3+J1WEwVVaZq2UZgEmk2N7KMM
         tl64/jLRDI72a5YazOEnYC1+YDHJoqcSZ7RLgK8jvmcKlM3yKzcNVosLvkR4WPmSkspa
         XL9BbHbMjR9EuW6NjgSaFYA4T4o3sTzy1/v9UmWXRtfo9Vb1mZlGZK8QWLBWvLIfdL3r
         w0AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741321061; x=1741925861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EVndE003Dh8Wm43eXqoX7dRdAT2oUBEfiwAkBEcsAD0=;
        b=hP/fko3b+a+rsgmhD7nsXLp3FAgprIMnnDMzFAj0QXA+hxgCOXxVK3nEZ1DVw4b6rD
         NddeEAA+FLOWI48adN6E6rkHgtp6OlmLwTaGTzoRO1YKjjd79Dg65IX9C/Nd5L7mhNmF
         cNjLrjYG4qoQ0TQ03dxz4lUKHwFmssRJMMeU6EnkXyRhaod4a2Eq35H3zqhb/564Ngz/
         butW6IIK48KjbdoMy0mVJ81a/ON1q3fkqYFWMAh8m99Gk+uc+7eCD5gYh+aRPzIjQ3OT
         QKr1w0EW5nszfKGodExAqL7n2zv9lWkWQETWQfZKNGqrqPFJDNlrl1VtrItbCLf4+CHS
         5wPg==
X-Gm-Message-State: AOJu0YyYCu7tevns4RJ1rYnGkYbBdAzIIn/4KA/ioQ6i8aJYgx9Qjnmz
	WGwkqW2SLAr86RV1trWDKMKYiXHo2IzXDB5JwjMlCe7pVDr5IopaVCIjQ/j+hJOOdAcCkBsbXon
	JFqa8OA==
X-Gm-Gg: ASbGncvZ+cj7snK3e3/xCk51pES4QCM3jLdwlAObMJivE69gNEpOgFIJvjV1klSxruN
	sKufaaEGZ/MVHhYQN87KB9hsbVVoSK/vgAHVvFcz+6g4lyqpKa296kAcncEro+wTrm1203ukWzV
	PP5KqtGH8PrlUr6ZIxzhzzCvCIiPFEKZ1BMnlCvrGFKkbu4FKFv6CprOsTtTdcWzWcZp2EyGcPX
	vknbKGQuU2MREnHHWPuyd/Wh4cJIb+77iKwNPL3vSkqICFTsiPOB/R4a7IKE74r/CXH716VSOK+
	yTPnP+S+5VMVu5vf73FxciPyDDvkpqErw2HanMpyng==
X-Google-Smtp-Source: AGHT+IFjZWnyW7So2LiLqTKwvlGIT+9W8FH3of2Lw3Wv8LWbl40K8+w8/nDwhLwELPauqlt/O1REww==
X-Received: by 2002:a05:620a:63c1:b0:7c3:d215:e9bf with SMTP id af79cd13be357-7c4e61eba75mr383034685a.54.1741321061197;
        Thu, 06 Mar 2025 20:17:41 -0800 (PST)
Received: from boreas.. ([140.174.215.88])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e534ba85sm186108085a.28.2025.03.06.20.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 20:17:40 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	tj@kernel.org,
	memxor@gmail.com,
	houtao@huaweicloud.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH v5 0/4] bpf: introduce helper for populating bpf_cpumask
Date: Thu,  6 Mar 2025 23:17:34 -0500
Message-ID: <20250307041738.6665-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some BPF programs like scx schedulers have their own internal CPU mask types, 
mask types, which they must transform into struct bpf_cpumask instances
before passing them to scheduling-related kfuncs. There is currently no
way to efficiently populate the bitfield of a bpf_cpumask from BPF memory, 
and programs must use multiple bpf_cpumask_[set, clear] calls to do so. 
Introduce a kfunc helper to populate the bitfield of a bpf_cpumask from valid 
BPF memory with a single call.

Changelog :
-----------
v4->v5
v4: https://lore.kernel.org/bpf/20250305211235.368399-1-emil@etsalapatis.com/

Addressed feedback by Hou Tao:
	* Readded the tests in tools/selftests/bpf/prog_tests/cpumask.c,
	turns out the selftest entries were not duplicates.
	* Removed stray whitespace in selftest.
	* Add patch the missing selftest to prog_tests/cpumask.c
	* Explicitly annotate all cpumask selftests with __success

The last patch could very well be its own cleanup patch, but I rolled it into 
this series because it came up in the discussion. If the last patch in the
series has any issues I'd be fine with applying the first 3 patches and dealing 
with it separately.

v3->v4
v3: https://lore.kernel.org/bpf/20250305161327.203396-1-emil@etsalapatis.com/

	* Removed new tests from tools/selftests/bpf/prog_tests/cpumask.c because
they were being run twice.

Addressed feedback by Alexei Starovoitov:
	* Added missing return value in function kdoc
	* Added an additional patch fixing some missing kdoc fields in
	kernel/bpf/cpumask.c

Addressed feedback by Tejun Heo:
	* Renamed the kfunc to bpf_cpumask_populate to avoid confusion
	w/ bitmap_fill()

v2->v3
v2: https://lore.kernel.org/bpf/20250305021020.1004858-1-emil@etsalapatis.com/

Addressed feedback by Alexei Starovoitov:
	* Added back patch descriptions dropped from v1->v2
	* Elide the alignment check for archs with efficient
	  unaligned accesses

v1->v2
v1: https://lore.kernel.org/bpf/20250228003321.1409285-1-emil@etsalapatis.com/

Addressed feedback by Hou Tao:
	* Add check that the input buffer is aligned to sizeof(long)
	* Adjust input buffer size check to use bitmap_size()
	* Add selftest for checking the bit pattern of the bpf_cpumask
	* Moved all selftests into existing files

Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>

Emil Tsalapatis (4):
  bpf: add kfunc for populating cpumask bits
  selftests: bpf: add bpf_cpumask_fill selftests
  bpf: fix missing kdoc string fields in cpumask.c
  selftests: bpf: add missing cpumask test to runner and annotate
    existing tests

 kernel/bpf/cpumask.c                          |  53 +++++++
 .../selftests/bpf/prog_tests/cpumask.c        |   4 +
 .../selftests/bpf/progs/cpumask_common.h      |   1 +
 .../selftests/bpf/progs/cpumask_failure.c     |  38 +++++
 .../selftests/bpf/progs/cpumask_success.c     | 131 ++++++++++++++++++
 5 files changed, 227 insertions(+)

-- 
2.47.1


