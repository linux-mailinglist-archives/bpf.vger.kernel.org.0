Return-Path: <bpf+bounces-27625-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BDF8AFEB4
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 04:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F8B21C227BB
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 02:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B783144D16;
	Wed, 24 Apr 2024 02:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mal+LliR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59769144304;
	Wed, 24 Apr 2024 02:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713926815; cv=none; b=Wz6OOi3cOq4EllxC3h8+Cw1z91eLabdY8ICZmQJwBvItRqPmJeU//pzso4QUiqfMtlE0xQqST2rf3gCf+DfdXQlXvII+bRCaf7CxU1TNCyyxcENZ+RBhTf9wRGabbpiFzwKMW5Ih2zBUf5rv7/YeX2FB+0ITHlpVZMW5jDPsUSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713926815; c=relaxed/simple;
	bh=WY61HVXMURNBYLhzrLzOFaXGtfOAIKgfGdHLeoKZ0ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rqxsl8cYuuOgT/lYwcFxWn3kLPP+IEO0BNy13FkjasvnioQ8VuOVdKXPLgOdOCkY0YJr7oYZzcxAY6J8CKFiBqGntQD4WRR4W3Sc8Cx+YgjM7ll7GroeUxgG7+vfsxmEi0Vs9H4Pskc/dKW01jW5NYjQh21ZFiUGejJrquYXqJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mal+LliR; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e8f68f8e0dso31418805ad.3;
        Tue, 23 Apr 2024 19:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713926813; x=1714531613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ovALNIraa1yswgozSIZAuHax4rLf2fy+nreEUNXYnE=;
        b=Mal+LliRj02EG7Pg92P2wsaU2s7RZ5yM9u3/CWyXUoHorTMAsGytIvKgvorAbNGc6z
         oLxUf9Obb6w71aDBvI46v/09HMHfRKL08N/FwDRRXUspqZshgUMKPJ+ZInDGvDDxDDSx
         UY2Vyfsb997ynEZYkXrH3NDiqjBeRf1fB4gC79z4IvZuivFenYXW4oRY8pez1170M2rh
         XO5Y9VTyjK713jid5vKD0kpCuWYFIFDbvXVDQCODjkjeiNGRilwgaFIuMQ5qxeoc59Lf
         CZGhORRXkENc165YehvZEGh6HVMOxjzbxpyjvZ02yCnjwQij7dPnWEE+RlaVQDempYmr
         Fh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713926813; x=1714531613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ovALNIraa1yswgozSIZAuHax4rLf2fy+nreEUNXYnE=;
        b=I0qpHmCIc5zfals8fCK40tzruauTCUnqjf2jRdDEGpCsP01iO+Fk5H4eWaBS50nVU8
         IOo572VNNwdn8RwOwOZLiHa1iRaRVgqpkC+qCNse50O/QcUi0uEft+mmdyPRZNNtTLtt
         9Gjv9xWNKFJ+GNdr2ZmF7iyWK15oFOqvmqrNyM7w6wtfDujKWDMxOEmWuGT37wTCCUQ1
         R71mB2QjZOjIK7GNV8uzASAhX9lkwlK8PjHdFkoGj1WsQgIHvgGsvfcHIA8PjpyCc+7d
         BvU/lfj6AI/Vb90Q8nwHWCNvlOseDCXtbWeDMmc5Tsgkeg701VqkB0xLQapxkeiJFbPN
         dh2g==
X-Forwarded-Encrypted: i=1; AJvYcCXHUBvZQZ4McP6A2uAAp3HIsZ1sydHQxs7WkuNkqQI/33NYhc30cNbZA4Y/Xj6d6t/IyynSZTsU0wSUYRKfVH8zWNUp0oeRzRDgz4jFbV1PRA2pxjcOinZJtbqjKj6LoXNK3Oj+TAlmBQEKuRUzoNeyvGGMy6hGtiEiy7hbpqC3ze9C0A==
X-Gm-Message-State: AOJu0Yz+tBmlbDbRonfShTx8pCbS+tBK6rCER3g5aY+v1NfVuW0o5Q52
	70akK9TAAsw7EGikMpVgqDRvwJxJLkfBL3ULr9438eLntk950g2D
X-Google-Smtp-Source: AGHT+IEo8XD7BWj1Z9qoTB1jHp9HGR8lvbdf5Znkuj22vJMEQNkAXOO85UQ328kis9neTsmjuW/ceA==
X-Received: by 2002:a17:903:2288:b0:1e4:49:de46 with SMTP id b8-20020a170903228800b001e40049de46mr1602492plh.47.1713926813535;
        Tue, 23 Apr 2024 19:46:53 -0700 (PDT)
Received: from localhost.localdomain ([120.229.49.143])
        by smtp.gmail.com with ESMTPSA id t6-20020a170902e84600b001e604438791sm10739243plg.156.2024.04.23.19.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 19:46:53 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	zegao2021@gmail.com,
	leo.yan@linux.dev,
	ravi.bangoria@amd.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v2 4/4] perf record off-cpu: delete bound-to-fail test
Date: Wed, 24 Apr 2024 10:48:05 +0800
Message-ID: <20240424024805.144759-5-howardchu95@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424024805.144759-1-howardchu95@gmail.com>
References: <20240424024805.144759-1-howardchu95@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since `--off-cpu` now uses the same ring buffer as hardware samples,
but `perf record --off-cpu -e dummy sleep 1`does not enable evlist,
off-cpu samples cannot be read.`test_offcpu_basic` fails and is no
longer necessary.

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/tests/shell/record_offcpu.sh | 29 -------------------------
 1 file changed, 29 deletions(-)

diff --git a/tools/perf/tests/shell/record_offcpu.sh b/tools/perf/tests/shell/record_offcpu.sh
index 67c925f3a15a..c446c0cdee4f 100755
--- a/tools/perf/tests/shell/record_offcpu.sh
+++ b/tools/perf/tests/shell/record_offcpu.sh
@@ -36,30 +36,6 @@ test_offcpu_priv() {
   fi
 }
 
-test_offcpu_basic() {
-  echo "Basic off-cpu test"
-
-  if ! perf record --off-cpu -e dummy -o ${perfdata} sleep 1 2> /dev/null
-  then
-    echo "Basic off-cpu test [Failed record]"
-    err=1
-    return
-  fi
-  if ! perf evlist -i ${perfdata} | grep -q "offcpu-time"
-  then
-    echo "Basic off-cpu test [Failed no event]"
-    err=1
-    return
-  fi
-  if ! perf report -i ${perfdata} -q --percent-limit=90 | grep -E -q sleep
-  then
-    echo "Basic off-cpu test [Failed missing output]"
-    err=1
-    return
-  fi
-  echo "Basic off-cpu test [Success]"
-}
-
 test_offcpu_child() {
   echo "Child task off-cpu test"
 
@@ -88,13 +64,8 @@ test_offcpu_child() {
   echo "Child task off-cpu test [Success]"
 }
 
-
 test_offcpu_priv
 
-if [ $err = 0 ]; then
-  test_offcpu_basic
-fi
-
 if [ $err = 0 ]; then
   test_offcpu_child
 fi
-- 
2.44.0


