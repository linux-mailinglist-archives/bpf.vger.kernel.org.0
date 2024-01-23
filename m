Return-Path: <bpf+bounces-20119-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 375B6839A7F
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 21:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC50E28A89F
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 20:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756804C81;
	Tue, 23 Jan 2024 20:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o1apjl9m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966E04417
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 20:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706042684; cv=none; b=Up56T4Bd1a07sBhvzeOrVmi51XaWNp8Mf7/pN93MVn/F9b/+77ehjh+wbnIhNtAXF38Rp5KIBn5+kPAn5wxbwNGFU+mcTwSoRondxWyG+Qd9fX8j/RcdekNK7tCDpEhLB5elZb+cXGh8Mo3w1KMH7tlcuMQGZ+XrDeMu8iUZZKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706042684; c=relaxed/simple;
	bh=3jCvRB4HD/I2qU3Zjc5yS28yBs6yYnwm+im0L/hbAtA=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=Tv3Ffd3+vn6gnRhvhQm+UrHCN6qMVBrcbbDMuPWHr0/X+YAHKH6uATS0d1SzD9Qk5mTQEm1OFsZbcwwoU0PvCxQU+mPEM0yz1EPgZJboJI2cg2TvxiZjrDIy9ImvEOTHTnb1lOFSvWM+bon9hYqlkyVxcvkfuddCVgOt64h7Pps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o1apjl9m; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc24eb13fecso5886851276.0
        for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 12:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706042681; x=1706647481; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gY0AJEtwU5pTI4pJWheKjEqkk5Hi/1V7D+eNS/EusLQ=;
        b=o1apjl9mHfWS6GeE0NOEvNp5Scywe71cfAi+6ducGQrN71mEGRRqDk9MnxIDz+Sb2R
         pYrVV3raux06gu3x2MOWSG00DVgDCO9BD6NkZ3dmeDFJ4UUu9r8dn832NluHRoWIi59O
         vjJBB8BOpekTpU8LU39tAhDtojaHpnXa5C4FKuOAO2JNd+UEnDdVBk1Lq9GyPwXzSfQ2
         3WJ+B5W+UkxM46niXyD5SsM+wzf5T6nZLzkvCIwt/lwiO6tyhAXfLSqTCniLofM+wArM
         y8qHLmwhupjRxgtq9w2COW3MtUAFiggvWEoMyYl26GQcHxDxiD/Zgiej2PV1CLJqcLKy
         z/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706042681; x=1706647481;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gY0AJEtwU5pTI4pJWheKjEqkk5Hi/1V7D+eNS/EusLQ=;
        b=T4onx0Zo4taHF+oHQiC2Y3/Lr1FVLCH+eD1o95sk551fYmAAnD7A0DN193x3uNEMZm
         x69UqNwdceZkmvrxFaW6vEG3cNFdBmFX3biP3fOXAOKdJUvqfOkHwWHNl7BnlsCWSNWa
         eqaVx521NEFF0HQSqA+HZG9+hTLJp0hGvca4oGmMb64y7ycVEHlk975IN0+FxuWigsI5
         RfsZ0Q5wsyP7qj+TDojgbWYjFqgMVoX0vjfSnVDJAa8VGmuu7Rnmr54jKhrsy1Dqkslg
         UGmH3c0Jo1RTHIszQGND5zRRYv+W7+XjmTUCGoI8OqV/7EuHhFfkreUW/PE1Y1cUjVwd
         BDAg==
X-Gm-Message-State: AOJu0YwNqQ+f2Lw1FHZ9kEHarHJyOh4oWTy3/wRSVSEhVIrhxAOvH64c
	3Y4/SpekF7PDUd3z/T39zpM5n/Ndf9a2BYwsiB3DnWwcxyYaRA7gUn8clTCDTuTkPcOg8v2evr/
	38/JdiQ==
X-Google-Smtp-Source: AGHT+IEH+jXKjumQFQcElV3EEDQUoZ4RZrdBmfN12M0KGfM+tnT6TDt0bfOTHzC18Ac190xN55NiZcJD2MJU
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b37:2438:2b2f:daae])
 (user=irogers job=sendgmr) by 2002:a25:c3c7:0:b0:dbf:4359:326a with SMTP id
 t190-20020a25c3c7000000b00dbf4359326amr55841ybf.1.1706042681557; Tue, 23 Jan
 2024 12:44:41 -0800 (PST)
Date: Tue, 23 Jan 2024 12:44:37 -0800
Message-Id: <20240123204437.1322700-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Subject: [PATCH v2] libbpf: Add some details for BTF parsing failures
From: Ian Rogers <irogers@google.com>
To: Alan Maguire <alan.maguire@oracle.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

As CONFIG_DEBUG_INFO_BTF is default off the existing "failed to find
valid kernel BTF" message makes diagnosing the kernel build issue some
what cryptic. Add a little more detail with the hope of helping users.

Before:
```
libbpf: failed to find valid kernel BTF
libbpf: Error loading vmlinux BTF: -3
libbpf: failed to load object 'lock_contention_bpf'
libbpf: failed to load BPF skeleton 'lock_contention_bpf': -3
```

After no access /sys/kernel/btf/vmlinux:
```
libbpf: Unable to access canonical vmlinux BTF from /sys/kernel/btf/vmlinux
libbpf: Error loading vmlinux BTF: -3
libbpf: failed to load object 'lock_contention_bpf'
libbpf: failed to load BPF skeleton 'lock_contention_bpf': -3
```

After no BTF /sys/kernel/btf/vmlinux:
```
libbpf: Failed to load vmlinux BTF from /sys/kernel/btf/vmlinux, was CONFIG_DEBUG_INFO_BTF enabled?
libbpf: Error loading vmlinux BTF: -3
libbpf: failed to load object 'lock_contention_bpf'
libbpf: failed to load BPF skeleton 'lock_contention_bpf': -3
```

Closes: https://lore.kernel.org/bpf/CAP-5=fU+DN_+Y=Y4gtELUsJxKNDDCOvJzPHvjUVaUoeFAzNnig@mail.gmail.com/
Signed-off-by: Ian Rogers <irogers@google.com>

---
v2. Try to address review comments from Andrii Nakryiko.
---
 tools/lib/bpf/btf.c | 49 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index ee95fd379d4d..d8a05dda0836 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -4920,16 +4920,25 @@ static int btf_dedup_remap_types(struct btf_dedup *d)
 	return 0;
 }
 
+static struct btf *btf__load_vmlinux_btf_path(const char *path)
+{
+	struct btf *btf;
+	int err;
+
+	btf = btf__parse(path, NULL);
+	err = libbpf_get_error(btf);
+	pr_debug("loading kernel BTF '%s': %d\n", path, err);
+	return err ? NULL : btf;
+}
+
 /*
  * Probe few well-known locations for vmlinux kernel image and try to load BTF
  * data out of it to use for target BTF.
  */
 struct btf *btf__load_vmlinux_btf(void)
 {
+	/* fall back locations, trying to find vmlinux on disk */
 	const char *locations[] = {
-		/* try canonical vmlinux BTF through sysfs first */
-		"/sys/kernel/btf/vmlinux",
-		/* fall back to trying to find vmlinux on disk otherwise */
 		"/boot/vmlinux-%1$s",
 		"/lib/modules/%1$s/vmlinux-%1$s",
 		"/lib/modules/%1$s/build/vmlinux",
@@ -4938,29 +4947,41 @@ struct btf *btf__load_vmlinux_btf(void)
 		"/usr/lib/debug/boot/vmlinux-%1$s.debug",
 		"/usr/lib/debug/lib/modules/%1$s/vmlinux",
 	};
-	char path[PATH_MAX + 1];
+	const char *location;
 	struct utsname buf;
 	struct btf *btf;
-	int i, err;
+	int i;
 
-	uname(&buf);
+	/* try canonical vmlinux BTF through sysfs first */
+	location = "/sys/kernel/btf/vmlinux";
+	if (faccessat(AT_FDCWD, location, R_OK, AT_EACCESS) == 0) {
+		btf = btf__load_vmlinux_btf_path(location);
+		if (btf)
+			return btf;
+
+		pr_warn("Failed to load vmlinux BTF from %s, was CONFIG_DEBUG_INFO_BTF enabled?\n",
+			location);
+	} else
+		pr_warn("Unable to access canonical vmlinux BTF from %s\n", location);
 
+	uname(&buf);
 	for (i = 0; i < ARRAY_SIZE(locations); i++) {
-		snprintf(path, PATH_MAX, locations[i], buf.release);
+		char path[PATH_MAX + 1];
+
+		snprintf(path, sizeof(path), locations[i], buf.release);
 
+		btf = btf__load_vmlinux_btf_path(path);
 		if (faccessat(AT_FDCWD, path, R_OK, AT_EACCESS))
 			continue;
 
-		btf = btf__parse(path, NULL);
-		err = libbpf_get_error(btf);
-		pr_debug("loading kernel BTF '%s': %d\n", path, err);
-		if (err)
-			continue;
+		btf = btf__load_vmlinux_btf_path(location);
+		if (btf)
+			return btf;
 
-		return btf;
+		pr_warn("Failed to load vmlinux BTF from %s, was CONFIG_DEBUG_INFO_BTF enabled?\n",
+			path);
 	}
 
-	pr_warn("failed to find valid kernel BTF\n");
 	return libbpf_err_ptr(-ESRCH);
 }
 
-- 
2.43.0.429.g432eaa2c6b-goog


