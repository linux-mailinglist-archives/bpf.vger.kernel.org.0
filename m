Return-Path: <bpf+bounces-15860-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5161C7F90B0
	for <lists+bpf@lfdr.de>; Sun, 26 Nov 2023 02:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 809321C20BAE
	for <lists+bpf@lfdr.de>; Sun, 26 Nov 2023 01:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9652E1111;
	Sun, 26 Nov 2023 01:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHnbyYhY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1C7110
	for <bpf@vger.kernel.org>; Sat, 25 Nov 2023 17:53:09 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-67a0a0586d4so20977396d6.0
        for <bpf@vger.kernel.org>; Sat, 25 Nov 2023 17:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700963588; x=1701568388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vH+kxGWzVJ5XS3gPUl9/RZEYQ8nOSaTpgrOK4d4+Qqg=;
        b=OHnbyYhY/TSxFiePvdHIH/R6iQ18Cp7eJ5AcqLGwhMjfMwZ+i9QsQlPh5BvWwSuHh/
         vABESH+MiWYhYwFnOupi3nIxEbaiuRVfDzEXUMM/D4cISDNkJPPI4ToM1B3D6KsF99mL
         HIuyig9DXe9fUujNKpaDzmWMYaNJdkY9jE+ooeIWrNFBZhbZsBWljOdioEN9dd7qgk56
         FvW184Ps9RhEA5qmeGzL+WFFCNXZwltkQtUc3wY1u/H8FhIvfYkp4kDJOD/VafgYUQmI
         qhbS8uzx67bHh3G3I0GR3vNIxBaQvTdDIgbD9eiRjk04lbfMrhXClfNQ+1Lg97VLcKU/
         3E8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700963588; x=1701568388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vH+kxGWzVJ5XS3gPUl9/RZEYQ8nOSaTpgrOK4d4+Qqg=;
        b=YSXDdmqoNchw8QyGv3myBPn74ZRst63uUb/AaNLdeGaKYgYfQaLFrs+dRcCOV6AL5O
         +9e12IciH76VoWzXfaC7AVEdtj7MqNCpIZaU6zBRvY49+82JurrAK+iR5819zn3C4p9F
         BPLIjiPjmhfFUlNCIh1SiBySDOeeZuoCqhG4Aga9asu1Pv5j5foH46bRdHoO+WnYi+ol
         G+MKehuAN7dzmhtePx8EsnXK08teGUKm0yN6/jwVNJCmdtlmZfB4uhCS++i5po2UYnEs
         wPQVCpLSvEjZzS3NVdwmYajy0rNpVLu0vmxdJKbtdjq+uckoDN5Esfi4e6meeRJd5DzI
         ptzw==
X-Gm-Message-State: AOJu0YxWzxLWpqfED9cTT/4YBtsIopb+pJ/yJ7HoXutLcF2Upk836ppy
	jvSLEix+Q03uj0rDRe9zKAkKbstNKFk=
X-Google-Smtp-Source: AGHT+IGvEUTlWi2wNWVUAaT4/juzb3bIoCrdmIXAyavltzqdM9ghXXjVH2Xh3nNg8kHy4VfIOjJryw==
X-Received: by 2002:a05:6214:a4a:b0:67a:2723:8304 with SMTP id ee10-20020a0562140a4a00b0067a27238304mr4556375qvb.6.1700963587668;
        Sat, 25 Nov 2023 17:53:07 -0800 (PST)
Received: from andrei-framework.. (c-73-133-17-174.hsd1.md.comcast.net. [73.133.17.174])
        by smtp.gmail.com with ESMTPSA id k11-20020a0cb24b000000b0066cfbe4e0f4sm1245501qve.26.2023.11.25.17.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 17:53:07 -0800 (PST)
From: Andrei Matei <andreimatei1@gmail.com>
To: bpf@vger.kernel.org,
	andrii.nakryiko@gmail.com
Cc: sunhao.th@gmail.com,
	eddyz87@gmail.com,
	kernel-team@dataexmachina.dev,
	Andrei Matei <andreimatei1@gmail.com>
Subject: [PATCH bpf v2 0/2] bpf: fix accesses to uninit stack slots
Date: Sat, 25 Nov 2023 20:50:44 -0500
Message-Id: <20231126015045.1092826-1-andreimatei1@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix two related issues issues around verifying stack accesses:
1. accesses to uninitialized stack memory was allowed inconsistently
2. the maximum stack depth needed for a program was not always
maintained correctly

The two issues are fixed together in one commit because the code for one
affects the other.

The second patch is tests only. It was split for review purposes; it can
be squashed when merging if it looks good.

Andrei Matei (2):
  bpf: fix accesses to uninit stack slots
  bpf: new verifier tests for stack access

 include/linux/bpf_verifier.h                  |  4 ++
 kernel/bpf/verifier.c                         | 70 ++++++++-----------
 .../selftests/bpf/progs/test_global_func16.c  |  2 +-
 .../bpf/progs/verifier_basic_stack.c          |  6 +-
 .../selftests/bpf/progs/verifier_int_ptr.c    |  2 +-
 .../selftests/bpf/progs/verifier_raw_stack.c  |  2 +-
 .../selftests/bpf/progs/verifier_var_off.c    |  4 +-
 tools/testing/selftests/bpf/test_verifier.c   | 24 +++++++
 .../selftests/bpf/verifier/atomic_cmpxchg.c   | 11 ---
 tools/testing/selftests/bpf/verifier/calls.c  |  2 +-
 tools/testing/selftests/bpf/verifier/stack.c  | 40 +++++++++++
 11 files changed, 106 insertions(+), 61 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/verifier/stack.c

-- 
2.40.1


