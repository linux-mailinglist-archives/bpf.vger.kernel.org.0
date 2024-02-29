Return-Path: <bpf+bounces-23044-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0772886C9B1
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 14:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BB661F2317A
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 13:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95517E0F0;
	Thu, 29 Feb 2024 13:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gchAhDRk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052F81EB46
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 13:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709211957; cv=none; b=d79kMoGBhXzilY56hp45sQullV+CSUeiUWdPvrcLKh+LIbLOMN57phuea2F9fi0dwUkc6cpF7MzT6cP80hi9oFo6Y2g1h5kP/DGOr/J8iRQRDJh944fezBVinurBF2GiBNNBKiMHNDfha9ornKEVLnspAsjZxoDf06zOqCR5LVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709211957; c=relaxed/simple;
	bh=fFZBUsJ4ezC95xbs7ni4i/rYQHJ+//11XY6cRM0nrVE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K72gtQNz9QZr61Dj9TNABRDw8ReCPiZCLRBhq2XowTHKxDDijqm33Ji2K0iIMya3QPqly7EDNJMmzUwbCUPGFOpdWtFmbmfcCKSOCtfIyugHcCC49bzU77VHildS/yEo5nqVQzPArz7rnqYWmIcy0r58Qhcmn82ZP3wdO5dViME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gchAhDRk; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e57a3bf411so504727b3a.0
        for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 05:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709211953; x=1709816753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YzwE5PV94wDBZ7bdOG09GWIwichIrw1tKaOVF1hrkjk=;
        b=gchAhDRkC/q270y5T5uszam8K9PZ3BijkcKnrywbBhVxTdH4kBEiOjEVQ7LudFjM6I
         w/4tuKpNat53fNhJgMNVwDWi1VR04KWb3AK/vhLcj8mI6Md71++iW5m26QfGzlgk3kny
         9KzEGCIjrWbaohG+EChm7A8HjfW5A5PUvrqiQD3z73oFRpn1xB6ds1AbNrMQy6TRt4nt
         6oX1sUrUjIGDNQANa1iJwvDIZgj+GtOnKwhXk8tIEcjXzHbjlTtyw3dcWYQ5cTWvO2Rf
         j5tz+KX6nEBM/rxGmnpM41dAFRbYVgWAp9sYua+C2YATNcJ9g58mj+mVWmL8tSNIViqX
         LLJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709211953; x=1709816753;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YzwE5PV94wDBZ7bdOG09GWIwichIrw1tKaOVF1hrkjk=;
        b=nPT7A1pBUnU2Td8EFvD3WSHQgY2GkQtV6KpW3OxmzF/jegz6ybtYaH5zgJsWUsTZ7a
         3moSa748xktJ6g6SlwewqN69BMnsFpJ2vv2tLngQNwxwzxrfCRM0AJDWJ75bJ8LkdSG1
         QqbgyvjMCCVPm7h6Fi9kJhvaUSC7HkddQ8cN9wL9Pd/5c25iKyy6pSdOuPbutSCnAEiH
         4kmv8X+UETiS0mO/PrrW4QppFwLHwOkptY5Q3TKfGAUfmjBXHHYEYwrSstwpSrrZMJKq
         ihIu2CkJbZpXx2xiOjWViOSmfKZ6WBLu1hRKTrOoszpYffc1V3xGEzgYTXLdSld11zrK
         K2GQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLpAyRJMiSDpALYs5j2tP5Y6/n8YTJncdCZIzjWZF9Hbcwq1jiG2HWRn1IGYS+rbKQEsC785JcCB3/VEaHstIOdS/k
X-Gm-Message-State: AOJu0Yxftw5+R2xw7sEKpNwA6w7vrWUDtZfHAVxqSrq3AhiBAU3URege
	IEBittpIc8jbjavJBVLoHxC7xqIRjc3Li+TG1KfuFIvZ+MdLSGFW
X-Google-Smtp-Source: AGHT+IHTCWv7230jgWrMBIX9AO/fe21xffz/dvO5eZZjpPksct9BeB8kyWoOV7FdTb9vGLXL4TKTZA==
X-Received: by 2002:a62:ab1a:0:b0:6e5:605c:2efe with SMTP id p26-20020a62ab1a000000b006e5605c2efemr2054433pff.17.1709211952642;
        Thu, 29 Feb 2024 05:05:52 -0800 (PST)
Received: from valdaarhun.. ([223.233.80.13])
        by smtp.gmail.com with ESMTPSA id jw40-20020a056a0092a800b006e563efb454sm1201969pfb.135.2024.02.29.05.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 05:05:52 -0800 (PST)
From: Sahil Siddiq <icegambit91@gmail.com>
To: quentin@isovalent.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	Sahil Siddiq <icegambit91@gmail.com>
Subject: [PATCH bpf-next] bpftool: Mount bpffs on provided dir instead of parent dir
Date: Thu, 29 Feb 2024 18:35:42 +0530
Message-ID: <20240229130543.17491-1-icegambit91@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When pinning programs/objects under PATH (eg: during "bpftool prog
loadall") the bpffs is mounted on the parent dir of PATH in the
following situations:
- the given dir exists but it is not bpffs.
- the given dir doesn't exist and the parent dir is not bpffs.

Mounting on the parent dir can also have the unintentional side-
effect of hiding other files located under the parent dir.

If the given dir exists but is not bpffs, then the bpffs should
be mounted on the given dir and not its parent dir.

Similarly, if the given dir doesn't exist and its parent dir is not
bpffs, then the given dir should be created and the bpffs should be
mounted on this new dir.

Link: https://lore.kernel.org/bpf/2da44d24-74ae-a564-1764-afccf395eeec@isovalent.com/T/#t

Closes: https://github.com/libbpf/bpftool/issues/100

Signed-off-by: Sahil Siddiq <icegambit91@gmail.com>
---
 tools/bpf/bpftool/common.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index cc6e6aae2447..6b2c3e82c19e 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -254,6 +254,17 @@ int mount_bpffs_for_pin(const char *name, bool is_dir)
 	if (is_dir && is_bpffs(name))
 		return err;
 
+	if (is_dir && access(name, F_OK) != -1) {
+		err = mnt_fs(name, "bpf", err_str, ERR_MAX_LEN);
+		if (err) {
+			err_str[ERR_MAX_LEN - 1] = '\0';
+			p_err("can't mount BPF file system to pin the object (%s): %s",
+				name, err_str);
+		}
+
+		return err;
+	}
+
 	file = malloc(strlen(name) + 1);
 	if (!file) {
 		p_err("mem alloc failed");
@@ -273,7 +284,17 @@ int mount_bpffs_for_pin(const char *name, bool is_dir)
 		goto out_free;
 	}
 
-	err = mnt_fs(dir, "bpf", err_str, ERR_MAX_LEN);
+	if (is_dir) {
+		err = mkdir(name, 0700);
+		if (err) {
+			err_str[ERR_MAX_LEN - 1] = '\0';
+			p_err("failed to mkdir (%s): %s",
+				name, err_str);
+			goto out_free;
+		}
+	}
+
+	err = mnt_fs(is_dir ? name : dir, "bpf", err_str, ERR_MAX_LEN);
 	if (err) {
 		err_str[ERR_MAX_LEN - 1] = '\0';
 		p_err("can't mount BPF file system to pin the object (%s): %s",
-- 
2.44.0


