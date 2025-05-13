Return-Path: <bpf+bounces-58083-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5292CAB4902
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 03:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6277460872
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 01:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E6A1993B9;
	Tue, 13 May 2025 01:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBxYBNvw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58812198E9B
	for <bpf@vger.kernel.org>; Tue, 13 May 2025 01:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747101577; cv=none; b=nSSZPPsMT1pAdVEMYoMjqsoi3HimYucIxX7zRVt9cnhvSuiC/YP/9f6q6kWrfoiQlWmuZ2LFd5O5ExYDaRlLodFSjHMF9ZNz7XROCovw1hzWo6hoaTmkXf0R6T1zopG/gXGHHkgfi4bUqRmksgSFRDUKaXSc7BsBhS2Yy+bijps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747101577; c=relaxed/simple;
	bh=iNyCL/w53y7T44RfQQIdiVZ+BUUBfHa4qhvE+/XBP64=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pcwIpzUBZB0HYEQRsx6b34G8b3JiisO65GP3XO9tCpAdgD4mPP7ENRK/DqIEApMDnuZgt0B7PW2z7psljCWqWY+uE1b1XCVQu/OLWbvwmyUfKJHQw7yIgD+IxZpPiot6gqcMQb+grprUY0AYtqbjBkjKd87egRlb186Xk7hr+lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DBxYBNvw; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a1f8c85562so2404766f8f.1
        for <bpf@vger.kernel.org>; Mon, 12 May 2025 18:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747101573; x=1747706373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rW+qOLgETMD/qqdVxMuUpvTl8/uOvRufUvaI5H9m0mc=;
        b=DBxYBNvwkXdIH4WnjBtTszanY2AOWkDXtowP1/96hryuHwfS7A6dzNf6l1aZG/QFiq
         aSmqtshVyBGpfF/wDNKVEl6K0OZGeAx+fOtjFi8V3lBJSmsd660HlPhZgowfr4TFEgV3
         tt86cUzLJ9LHCFQ01AUUGLYgKikomrK9irs8xKJ4mdwD7a0MpHQr3vjq2Vy1/TWUgr0T
         vWwS3OasMyDuFnZgU5bkwByIMY69uVhvyY4aMDDvYAVZttJlRV0xey9grFovGlf8vKXJ
         VW/lxN/loTodsjP4p/ZJiKZIMD5/Uwxk6y0d2tdo3+Omvvp7wC63Fq8fbU5wAL5iuMxE
         waVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747101573; x=1747706373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rW+qOLgETMD/qqdVxMuUpvTl8/uOvRufUvaI5H9m0mc=;
        b=WSJOP42wIZV0HuywucW7xHrXW+1lGVOBxDciYcWXq/eAXNCmRKYQXBMczX3g3JQlYB
         p1XJ5UKa7os66RTPC7xnsOLrO8WRTsrlHWJHLcGvmZq3D7Hp2PHunZ+OfbewEvUALfsq
         Ee2DjLFX/+FkpO54R3rfHcbCLAZ4PuAuZhqPV9UA7GAIoILOOZ9elGuwDE84jTBvGoz7
         Nu83tfcPiW1Pb3GhMi7WjQEDp1Hehu7RyOj4tjrq7KvnfSscbrr538kJmYJo0oh4Ex10
         2Qs8vEYMPSUwiapMNLNpMZXbRvkAe0LaNRYMwClxtZ08Xvhh2Cf8E42X3B3Ymc45KdfB
         Otyw==
X-Gm-Message-State: AOJu0YzWuDELNixAJpC9Z4qXY0mHPix1XOXh2pGm43sO/SpMTRG36228
	cW7WaikgnUH/BADSbH0UFIE4dnn7qOe+BiF0UL7EocVTJ8LkJi83COm5tg==
X-Gm-Gg: ASbGnctLplxKWwzE6v22y62k6l2H9Mm+twQUrs54zze9r21rQEq4p/GPLdbH5R6FcC1
	F/eAq8jz4SJ83dNmgbBoN77ZwZd1cIYMWl5sTdpKciPfaX9U1SBQtqoIIm5LpvZmI2LBPoAsz2h
	I22nJ8PbdAQg1ykEOCo42dtBggat2sDNsFEDjRdK6j1f1DrOa+ccyu0o+cbp8rd1VpxErlz4lcL
	SAPVXgyh3UtK7r21UDJe1PJUe9GujqAuyZS7Rn3rKKIxC0sI2DTKXShltp95pIz6CMEd4q++CRB
	krEGc2saBCuj4EqW82hay0e2lBzOp/pVgcj5DcJR9nMIqqBrOlEeMLyIpLHDmDvsENEilQex7Pq
	Whg==
X-Google-Smtp-Source: AGHT+IHkiHYVqTo1Lgsh7pVE/CYDSoNqWuLHp5JoJLnUrbnEdRlTn0J3jvV3ew5K+xWQgz9TtB8/aQ==
X-Received: by 2002:a5d:64cd:0:b0:3a0:b5ec:f076 with SMTP id ffacd0b85a97d-3a1f643106amr13304447f8f.18.1747101573035;
        Mon, 12 May 2025 18:59:33 -0700 (PDT)
Received: from localhost.localdomain ([154.183.40.118])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58eb9dfsm14490551f8f.31.2025.05.12.18.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 18:59:31 -0700 (PDT)
From: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	andrii@kernel.org
Cc: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>,
	linux-kernel-mentees@lists.linux.dev,
	shuah@kernel.org,
	tj@kernel.org,
	kernel-team@meta.com,
	memxor@gmail.com
Subject: [PATCH bpf-next] docs: bpf: fix bullet point formatting warning
Date: Tue, 13 May 2025 04:58:59 +0300
Message-ID: <20250513015901.475207-1-khaledelnaggarlinux@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix indentation for a bullet list item in bpf_iterators.rst.
According to reStructuredText rules, bullet list item bodies must be
consistently indented relative to the bullet. The indentation of the
first line after the bullet determines the alignment for the rest of
the item body.

Reported by smatch:
  /linux/Documentation/bpf/bpf_iterators.rst:55: WARNING: Bullet list ends without a blank line; unexpected unindent. [docutils]

Fixes: 7220eabff8cb ("bpf, docs: document open-coded BPF iterators")
Signed-off-by: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>
---
Hello, please let me know if you have any comments, thanks!

---
 Documentation/bpf/bpf_iterators.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/bpf/bpf_iterators.rst b/Documentation/bpf/bpf_iterators.rst
index 8f0a4a91b77a..189e3ec1c6c8 100644
--- a/Documentation/bpf/bpf_iterators.rst
+++ b/Documentation/bpf/bpf_iterators.rst
@@ -52,14 +52,14 @@ a pointer to this `struct bpf_iter_<type>` as the very first argument.

 Additionally:
   - Constructor, i.e., `bpf_iter_<type>_new()`, can have arbitrary extra
-  number of arguments. Return type is not enforced either.
+    number of arguments. Return type is not enforced either.
   - Next method, i.e., `bpf_iter_<type>_next()`, has to return a pointer
-  type and should have exactly one argument: `struct bpf_iter_<type> *`
-  (const/volatile/restrict and typedefs are ignored).
+    type and should have exactly one argument: `struct bpf_iter_<type> *`
+    (const/volatile/restrict and typedefs are ignored).
   - Destructor, i.e., `bpf_iter_<type>_destroy()`, should return void and
-  should have exactly one argument, similar to the next method.
+    should have exactly one argument, similar to the next method.
   - `struct bpf_iter_<type>` size is enforced to be positive and
-  a multiple of 8 bytes (to fit stack slots correctly).
+    a multiple of 8 bytes (to fit stack slots correctly).

 Such strictness and consistency allows to build generic helpers abstracting
 important, but boilerplate, details to be able to use open-coded iterators
--
2.47.2


