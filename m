Return-Path: <bpf+bounces-48092-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C245A03EF1
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 13:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C67DE3A1595
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 12:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57241EB9E8;
	Tue,  7 Jan 2025 12:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAEXGE0L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE5D1EF080;
	Tue,  7 Jan 2025 12:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736252200; cv=none; b=AdMseDs/kzW9TR30ni6gC0Y+uDnEW/tyP2NnJh2cFE4qo9zHBwZWv58iLOnoDMUZKcMNIwJ4Zs1mCLvhbRqzSuasJYykMYiiso7WRw39vl3V9z4nJ+iwmGlpEMiZDowsml2Sky6+hwShzv7vcIdWn/YCM5UUPoInLIqN5h88Mvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736252200; c=relaxed/simple;
	bh=QixZzGDTLfx9ml72UvoLU0BKmAyEobQBCGi582kxI30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jy09OBYhWDl1O1vWJAVy1eUelWQSQlSngA2SujthQFuv4NpIfgxBYajebzQs468I3zeD4mAVcstQk+BKX4f9W0FYbaVtziugwANK/sbP6ZI+IfGKHdEBC8vWUVJ2E57/HBPqtVFyQou3qMAx+trhWai5pd6zGzORh9OMb10hgBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PAEXGE0L; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3c6b0be237cso118226435ab.2;
        Tue, 07 Jan 2025 04:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736252194; x=1736856994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzIJME8RLUAnwvXSqDJckfgZjEuohf3fdOUuNjSDyBk=;
        b=PAEXGE0LvcfBKfG+PIBl6CioK+v+hZhe5EAlXdkvGulRsZS3mBS8gTRNnn6gYMgiDV
         NwycoGEeXGntdEzmMlvStGVef4RIb/y0KZzFtI1hFvB42andzp43RVevrs/XYvUR2ox5
         jloCj4LL2S0txsGupfosjaCw/TP1XP9Lg3zLoA11VyXdStU5W6uiEv5BFb6ciIOQCY1h
         gxhH+dR/FgdGfUOEAMtPvuKubD2KUqrjbGbY0cm4TWue5v85nMQTrWBbBJxPDmjD8TmU
         keUwVYQ8nL46YyufR43i8uafzUWp+A5gRgl0vVAKNHmWxy0qa3dDVTZ9QqOrNwU0lWIM
         2WAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736252194; x=1736856994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wzIJME8RLUAnwvXSqDJckfgZjEuohf3fdOUuNjSDyBk=;
        b=gzK/c1uFOaga1PwTnDRXdewWnI1+npFSXw36ig6OyiTZvbd6CdcIeabx6g1Kcls7kP
         Jdc2u/nqnQUKmCjOhy6fEX+/6e1je4X1qjFsPIf0WQp85ysrvz6etWDqHW1wkmVxaOzH
         +th/6ZlDWmorbXN+nwcorqHlIhkgskCD410cdah+DFSjnP3xDVX9T3eEfG8MXtmTBRH7
         POX2w1+UpB8ilhUVfER6b5xMk+u/qkTrujbjdnPv9cFWtu+nBmvESIu3U+TRPmifpVrC
         0glzA53c/GxavUt0AU7SzTOCLjVp15mDrOMTIT2qMk06rcp+xefTHvjy+i+9aLHLteRd
         9SPA==
X-Forwarded-Encrypted: i=1; AJvYcCUtKBbUUex9WgSo0CICDacSQOcZweaswDsDiinbwAPdKnguQckYzSLcj1mzoz7mu33JlEky2hImW9vSUw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdOeUTkbLkqBndkfJbuweF95tmBYyuXGPfeBlBViYVrH0voftC
	AHZRddJAkvInbfsCtlS1YfT96MIpBu/Fr0pxCRNmBVWzXb2jIeHTOdnKGQwTCqI=
X-Gm-Gg: ASbGncuf3XunpMBPK7z2xT02142vsOaqrdGszNlUbchnnN4uMbkj1IShviPn5xPlj4K
	CBw54Oj8GV4tAzDZQs8pezXvczvkG2loKuO7dAUFWPM1XCU/BjtXloUtMrywV7GCyzKl7RMSEMf
	Y2ye5jHSPIp+B8VXwN6ZrpuB2YG51wsMNEOacOKsJD7WRePX695cvs4Rvh4gO7Drt3yi6ugs9uw
	GtTZlj9mIH6EjwxV1P0zKtHEJyNj1bh5e8bZH/Qr51RuP+7ZgDpk17MLWFUoglW6R3R
X-Google-Smtp-Source: AGHT+IGd07cvqYw8IK2i5W4gQPn3YsvELvPQQoh3dJtZGTdHmPILf3nE0s5d6hpdPfTwEvp1E126sQ==
X-Received: by 2002:a05:6a00:6387:b0:72b:5a7a:e5a6 with SMTP id d2e1a72fcca58-72b5a7ae7edmr25402038b3a.26.1736251715917;
        Tue, 07 Jan 2025 04:08:35 -0800 (PST)
Received: from fedora.redhat.com ([2001:250:3c1e:503:ffff:ffff:ffea:4903])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-72aad835b8dsm34245118b3a.63.2025.01.07.04.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 04:08:35 -0800 (PST)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	Ming Lei <tom.leiming@gmail.com>
Subject: [RFC PATCH 13/22] selftests: ublk: add tests for covering io split
Date: Tue,  7 Jan 2025 20:04:04 +0800
Message-ID: <20250107120417.1237392-14-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250107120417.1237392-1-tom.leiming@gmail.com>
References: <20250107120417.1237392-1-tom.leiming@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One io command can be queued in split way, add test case for covering
this way:

- split the io command into two sub-io if the io size is bigger than 512

- the 1st sub-io size is 512byte, and the 2nd sub-io is the remained
  bytes

Complete the whole io command until the two sub-io are queued.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 tools/testing/selftests/ublk/Makefile         |  1 +
 .../testing/selftests/ublk/progs/ublk_null.c  | 46 +++++++++++++++++++
 tools/testing/selftests/ublk/test_null_03.sh  | 21 +++++++++
 3 files changed, 68 insertions(+)
 create mode 100755 tools/testing/selftests/ublk/test_null_03.sh

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index a95f317211e7..5a940bae9cbb 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -21,6 +21,7 @@ endif
 
 TEST_PROGS := test_null_01.sh
 TEST_PROGS += test_null_02.sh
+TEST_PROGS += test_null_03.sh
 
 # Order correspond to 'make run_tests' order
 TEST_GEN_PROGS_EXTENDED = ublk_bpf
diff --git a/tools/testing/selftests/ublk/progs/ublk_null.c b/tools/testing/selftests/ublk/progs/ublk_null.c
index 3225b52dcd24..523bf8ff3ef8 100644
--- a/tools/testing/selftests/ublk/progs/ublk_null.c
+++ b/tools/testing/selftests/ublk/progs/ublk_null.c
@@ -11,6 +11,40 @@
 
 /* libbpf v1.4.5 is required for struct_ops to work */
 
+static inline ublk_bpf_return_t __ublk_null_handle_io_split(const struct ublk_bpf_io *io, unsigned int _off)
+{
+	unsigned long off = -1, sects = -1;
+	const struct ublksrv_io_desc *iod;
+	int res;
+
+	iod = ublk_bpf_get_iod(io);
+	if (iod) {
+		res = iod->nr_sectors << 9;
+		off = iod->start_sector;
+		sects = iod->nr_sectors;
+	} else
+		res = -EINVAL;
+
+	BPF_DBG("ublk dev %u qid %u: handle io tag %u %lx-%d res %d",
+			ublk_bpf_get_dev_id(io),
+			ublk_bpf_get_queue_id(io),
+			ublk_bpf_get_io_tag(io),
+			off, sects, res);
+	if (res < 0) {
+		ublk_bpf_complete_io(io, res);
+		return ublk_bpf_return_val(UBLK_BPF_IO_QUEUED, 0);
+	}
+
+	/* split this io to one 512bytes sub-io and the remainder */
+	if (_off < 512 && res > 512)
+		return ublk_bpf_return_val(UBLK_BPF_IO_CONTINUE, 512);
+
+	/* complete the whole io command after the 2nd sub-io is queued */
+	ublk_bpf_complete_io(io, res);
+	return ublk_bpf_return_val(UBLK_BPF_IO_QUEUED, 0);
+}
+
+
 static inline ublk_bpf_return_t __ublk_null_handle_io(const struct ublk_bpf_io *io, unsigned int _off)
 {
 	unsigned long off = -1, sects = -1;
@@ -60,4 +94,16 @@ struct ublk_bpf_ops null_ublk_bpf_ops = {
 	.detach_dev = (void *)ublk_null_detach_dev,
 };
 
+SEC("struct_ops/ublk_bpf_queue_io_cmd")
+ublk_bpf_return_t BPF_PROG(ublk_null_handle_io_split, struct ublk_bpf_io *io, unsigned int off)
+{
+	return __ublk_null_handle_io_split(io, off);
+}
+
+SEC(".struct_ops.link")
+struct ublk_bpf_ops null_ublk_bpf_ops_split = {
+	.id = 1,
+	.queue_io_cmd = (void *)ublk_null_handle_io_split,
+};
+
 char LICENSE[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/ublk/test_null_03.sh b/tools/testing/selftests/ublk/test_null_03.sh
new file mode 100755
index 000000000000..c0b3a4d941c9
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_null_03.sh
@@ -0,0 +1,21 @@
+#!/bin/bash
+
+. test_common.sh
+
+TID="null_03"
+ERR_CODE=0
+
+# prepare and register & pin bpf prog
+_prep_bpf_test "null" ublk_null.bpf.o
+
+# add two ublk null disks with the pinned bpf prog
+_add_ublk_dev -t null -n 0 --bpf_prog 1 --quiet
+
+# run fio over the ublk disk
+fio --name=job1 --filename=/dev/ublkb0 --ioengine=libaio --rw=readwrite --iodepth=32 --size=256M > /dev/null 2>&1
+ERR_CODE=$?
+
+# clean and unregister & unpin the bpf prog
+_cleanup_bpf_test "null"
+
+_show_result $TID $ERR_CODE
-- 
2.47.0


