Return-Path: <bpf+bounces-75631-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 719C6C8CC0F
	for <lists+bpf@lfdr.de>; Thu, 27 Nov 2025 04:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1DFDD34B9AB
	for <lists+bpf@lfdr.de>; Thu, 27 Nov 2025 03:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE48E299949;
	Thu, 27 Nov 2025 03:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlIo8GQ9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0979B23536B
	for <bpf@vger.kernel.org>; Thu, 27 Nov 2025 03:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764214358; cv=none; b=mG3mLDocnDVZaSFsgY61oTXcl85c74LDqk/PX8KoM6yGbnZpBsZ3YMX5N2XLi22b09LkGyulmfFwjYAT9dkl98wgZvv6H7UPVG3GP1vp7tAwoHF+PQzKFWMiibKR36H8JuFG6v3u3a9BiwBjnD2Pz15txyDeM9grhldVIc1wTis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764214358; c=relaxed/simple;
	bh=RQCpusYkNqhCf/oYYjKg0UCyKstePjWLCBpBHzMw+HE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iRdfWmNifPpFkzEOBg5H3C1/weIqE8VL1U3zHDul55v/rb2ZrTrWoMCInJJ1+ca2fEQU5EEhioY/zhVnNFaZJnTs+Rl7bCQDW6Peta+O+KmrH/V0biYjmf+FGAmmN6zqH5M1cn2v2x6/+0XAg2PqF7B8PJIYgOqKrpnU5gegwyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LlIo8GQ9; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-297ec50477aso1815435ad.1
        for <bpf@vger.kernel.org>; Wed, 26 Nov 2025 19:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764214356; x=1764819156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VJ1M2Xvyt40lCnxw+Gw/ePOJPKhvduaiNO9FIO7qjnU=;
        b=LlIo8GQ9uSpY9NADk+QQzCwoZaYP4NSDSKnPuWLT64jl6DEmdM4YF8+Th05fLk25M8
         YpUchykrGAUNuaUoIIV6qKZJT3YBI93UQ3jXoDNcFTWsLjU3TT6vVNXZfEpm4tKqmmwH
         TAPUtdJ9oPeZEmnPZxtCaUvnu5lf0vDD61bW4umE0iT7KbAmMbZb805lzNla1Zq4jATE
         wxYO4WC4H4WnxjVwXfqtjMWmpUXvf3oh6IBeWBB2VjoEtG++YtVVAyGTw92d19gzLAct
         Dg1rGZpoDTfjZq8CiS18sksGAeDDHnWZHP0K39iN9NH0YeJ8BoAVW7Yq+NPrlO6xDxiv
         6myQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764214356; x=1764819156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJ1M2Xvyt40lCnxw+Gw/ePOJPKhvduaiNO9FIO7qjnU=;
        b=AvTyfuFfHUsTWdDGPJFEpEDVSD6rRBZFB4+VGEgJKEUaqjIUq/Bcr2ZqrXBSHK6Ek+
         MHBsTInq09K3LtYo5KNOKTzbhhfJ5SSJyRmEDTHqmwvjlFtJXKvkKHD9aM/Q7rGn3yu+
         k64YQuO0nY9fWMB9kDVJ7ftXBa2FmKzd+myPmEI7dkkGmrkiCJ+/BNVmlaM4cSI7FRJ/
         3fodpm6J1zhWeoasIk8SQ4NuYYv3D6heUf5eaeC0qrsPuSuqvqTAojpSN0nzsubo2OIf
         XVYs/nkpo/vxads30j/Zg5FMwqI6h/jqYNIZK0Db32UAIUpKp70rznnl+5LKkaMEHwXW
         wtOw==
X-Forwarded-Encrypted: i=1; AJvYcCXzkXUFfrHInHUiVS2kcY4G4/rFYzLhiDoDQme1yBBxP6Wk2PwosXw65YXR3OlCXPsosBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYkvUjQoqfS043uoX+7xt0hrJl8sVuhIHAOS355KrYYjNah32g
	FagJ2HLDeDK5rNAquD/4zDuX0HtZe1EKzqcpzM0aOFFwgVAWCgE8lQU=
X-Gm-Gg: ASbGncttIk/QtAasPOi7Smxzu7H/+jAyAvgIxose0kOn2C9ebgcg052RHRqnt91IfdT
	8wJ7O9GCsQTaljTBM2G5CAU8QEnUZwHe4X3iCLeDwPOcuXuFSOxEdshvDeFGn1ptpiOGZMq52Zz
	WylpzdOwnaEmagTjlD74hKll+Rtl7NvJlqk5QUxknjJz6Y2qC3XHgEHnQGLNY/V7e7NOOTF4h3A
	kVcGOnIUDO+N6LgmpHLfN9I1ahefY6+BGhJxzMnTw4WMr3cPg/PCiM4L9PxcVNED1asgki+fTyj
	IGu08pv72hQa+xT5oe4nG/h493w0AL5PZEFR9IWaNwgsktVtGaA4geuS4rPHIMevafjRyHItbRA
	qV4js/sLHLMWKuY5bBy/MGQePkO1Ciue1kyU6V87uRcHxYuEGd6B6O+yENTQFH/sQAs/MzGsTlA
	SzNV/ILRvaK/UdeeCr+lzAM1WCMfKG0EtjfDDdRb1/louJdyk=
X-Google-Smtp-Source: AGHT+IG3jNbvnvpK7iPmyHhKwaYo2yFYrQWYJT24DmT6DQObpycLY0SOpYePrSAPkXpirXgXx1ENyg==
X-Received: by 2002:a17:903:2f45:b0:296:5ebe:8fa with SMTP id d9443c01a7336-29b5e3b8731mr255928125ad.23.1764214356167;
        Wed, 26 Nov 2025 19:32:36 -0800 (PST)
Received: from samee-VMware-Virtual-Platform.. ([2402:e280:3d9e:537:5870:9b57:1a0b:b0e5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb276a7sm644295ad.48.2025.11.26.19.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 19:32:35 -0800 (PST)
From: Sameeksha Sankpal <sameekshasankpal@gmail.com>
To: kees@kernel.org
Cc: luto@amacapital.net,
	wad@chromium.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Sameeksha Sankpal <sameekshasankpal@gmail.com>
Subject: [PATCH] [PATCH v4] selftests/seccomp: Fix indentation and rebase error logging patch
Date: Thu, 27 Nov 2025 09:01:54 +0530
Message-ID: <20251127033154.12290-1-sameekshasankpal@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v4:
 - Resending v3 after reviewer feedback (Shuah Khan).
 - No code changes.
 - Fixes email formatting and broken threading in earlier versions.

v3:
 - Rebased against upstream seccomp tree.
 - Fixed indentation to use tabs instead of spaces.
 - Used scripts/checkpatch.pl to fix warnings.
 - Removed blank line before Signed-off-by.

v2:
 - Used TH_LOG instead of printf for error logging.
 - Moved variable declaration to the top of the function.
 - Applied review suggestions from Kees Cook.

v1:
 - Initial patch to improve error logging in get_proc_stat().

Suggested-by: Kees Cook <kees@kernel.org>
Signed-off-by: Sameeksha Sankpal <sameekshasankpal@gmail.com>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 61acbd45ffaa..dbd7e705a2af 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -4508,9 +4508,14 @@ static char get_proc_stat(struct __test_metadata *_metadata, pid_t pid)
 	char proc_path[100] = {0};
 	char status;
 	char *line;
+	int rc;
 
 	snprintf(proc_path, sizeof(proc_path), "/proc/%d/stat", pid);
 	ASSERT_EQ(get_nth(_metadata, proc_path, 3, &line), 1);
+	rc = get_nth(_metadata, proc_path, 3, &line);
+	ASSERT_EQ(rc, 1) {
+		TH_LOG("user_notification_fifo: failed to read stat for PID %d (rc=%d)", pid, rc);
+	}
 
 	status = *line;
 	free(line);
-- 
2.43.0


