Return-Path: <bpf+bounces-39453-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A736D973A29
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 16:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA0251C21537
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 14:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5C6199920;
	Tue, 10 Sep 2024 14:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRY11dDC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5411991A0;
	Tue, 10 Sep 2024 14:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725979285; cv=none; b=Mnu7DFqOB1Zm6R784jK9QlMcxil+ASgxXrp1eDgkhD7Qo5O74qEcth1pUMOk16FCsz9bFyI7ARfhDUrVLwiwJKt/3jJ/5BakZeqSzmZIkTjjBvNVa2bkqjArEshM+O9MrufQjmLFLvi0YXqcfIm5QvT1PW6hvbexkLkJGodGyU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725979285; c=relaxed/simple;
	bh=2imfAZ0QXn5XVKjATXkFWcOVKNkAng8p1ZNwuhhJ5RQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U93qMk2XMRSc+kI6Q4vazrwN4n8IslVGgCNw0LE4M5HPrufqD9c3rfwRV/7jfLw13TBmyawjQKvjGpQYwSbiz13UPC11VBsbn1zsZ3AhRRpGymPoGJabILhcpKSpDes3ekTpPIPih0O+AiQHAxcp1A82Oi1HsFcCVfWlH8WbNlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRY11dDC; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-717934728adso4073206b3a.2;
        Tue, 10 Sep 2024 07:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725979283; x=1726584083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0P+s93nCaJEgoUjxEO3WaqLlG5SGgxS9Bl7qShFJrxc=;
        b=hRY11dDCZytttS1PmHFH+n8Yf6P/Nq9TAXjwB+tqytOfIFvoGh0Gd4nDrffyUoNKRV
         T187o6kUX7Tv5hepKL6hht0oN0HSaTAPLCSYSJJzpoqMkv0bpOf9cSlXhhphDHbenXPQ
         jiSWKiTKoAvMOx/CJOC1oF3+Tduuqh9RsFi3dLoc27T7neaOZSu/Hyi6AhLKkFxLEpy9
         ZYKgnNLfPQqeDlWox4AZTY5dJYPWvt3Zh/u43mMlK325Qy0CkSjp93BvU1fmLCqGQCsN
         9QoCOk/WHFlnDxRBOKDfyB7q2a7wISBZbqEtQHFGUCGLJgztH/PsfDEGrj2ICuEmkNU7
         tM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725979283; x=1726584083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0P+s93nCaJEgoUjxEO3WaqLlG5SGgxS9Bl7qShFJrxc=;
        b=iQ+Q/cKW+NUbxkgb3kqlpNYSvbQjOLJ/AxRmPXtKqXa/fiNtc6+3XwgW5mP1vhAOrl
         94tGitNB/IRr5cQB+toe/cxJbtFBVvBnJHCG1Lv1YkL1qIP+xNfgUPc/lYYuZmug5wZ/
         ML4L2KIBRfon78lks5UbVt466LaHLRN4RGMkMdnI/Cb1WvqWjrtWyJO7uYNcC/92iSJW
         7yWB53G4YZjXk4/G7fpOPoiJqfjw4aFaNUqezydBTv3gOdSHPfNvVQ9WpUhbTnKb3n/o
         T+lAIjjBtQg5pHAQIsYLIeBGM1dPmFPsDhoAh2bpzOkHGSsTeDeLc+XPHoXxIO1eTgzD
         nC0A==
X-Forwarded-Encrypted: i=1; AJvYcCU5DrruMJi4ZeNjcP65KeXPaw85sGXlbQH1LOC9pu/wfIcPir3BrKXKAfXcsopHErN38O+Pj8m1ToTJJR3c@vger.kernel.org, AJvYcCVC3BkHwhdyo+Ym0Lnk5scSLwYDVVGLTVRb7XI7HYsHQCoe0ZHJNmMUdYq+ZKXB0I/e3Qs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJdvzjITw4QIKJ55VG5wXJmQGCw5KnZZ/8e6n14Xhv0b4T8Mhj
	geSaeXSdFi+xLpVJuDLyF2nixuER7jAVDQGquT9NBK09/RYUyyWF
X-Google-Smtp-Source: AGHT+IGz14YyT8T0TWHsj6wiz9mNiGZ3jnjO6YQU3sMSB41tAV5tMRU3SV/SAfqFfhX8RQNuwNCTFg==
X-Received: by 2002:a05:6a00:1893:b0:718:e062:bd7e with SMTP id d2e1a72fcca58-718e404b746mr16792040b3a.24.1725979283082;
        Tue, 10 Sep 2024 07:41:23 -0700 (PDT)
Received: from localhost ([116.198.225.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-719090c9b15sm1435842b3a.202.2024.09.10.07.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 07:41:22 -0700 (PDT)
From: Tao Chen <chen.dylane@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Hou Tao <houtao1@huawei.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: Tao Chen <chen.dylane@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinke Han <jinkehan@didiglobal.com>
Subject: [v3 PATCH bpf-next 2/2] bpf/selftests: Check errno when percpu map value size exceeds
Date: Tue, 10 Sep 2024 22:41:11 +0800
Message-Id: <20240910144111.1464912-3-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240910144111.1464912-1-chen.dylane@gmail.com>
References: <20240910144111.1464912-1-chen.dylane@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test case checks the errno message when percpu map value size
exceeds PCPU_MIN_UNIT_SIZE.

root@debian:~# ./test_maps
...
test_map_percpu_stats_hash_of_maps:PASS
test_map_percpu_stats_map_value_size:PASS
test_sk_storage_map:PASS

Signed-off-by: Tao Chen <chen.dylane@gmail.com>
Signed-off-by: Jinke Han <jinkehan@didiglobal.com>
---
 .../selftests/bpf/map_tests/map_percpu_stats.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/bpf/map_tests/map_percpu_stats.c b/tools/testing/selftests/bpf/map_tests/map_percpu_stats.c
index 2ea36408816b..1c7c04288eff 100644
--- a/tools/testing/selftests/bpf/map_tests/map_percpu_stats.c
+++ b/tools/testing/selftests/bpf/map_tests/map_percpu_stats.c
@@ -17,6 +17,7 @@
 #define MAX_ENTRIES_HASH_OF_MAPS	64
 #define N_THREADS			8
 #define MAX_MAP_KEY_SIZE		4
+#define PCPU_MIN_UNIT_SIZE		32768
 
 static void map_info(int map_fd, struct bpf_map_info *info)
 {
@@ -456,6 +457,22 @@ static void map_percpu_stats_hash_of_maps(void)
 	printf("test_%s:PASS\n", __func__);
 }
 
+static void map_percpu_stats_map_value_size(void)
+{
+	int fd;
+	int value_sz = PCPU_MIN_UNIT_SIZE + 1;
+	struct bpf_map_create_opts opts = { .sz = sizeof(opts) };
+	enum bpf_map_type map_types[] = { BPF_MAP_TYPE_PERCPU_ARRAY,
+					  BPF_MAP_TYPE_PERCPU_HASH,
+					  BPF_MAP_TYPE_LRU_PERCPU_HASH };
+	for (int i = 0; i < ARRAY_SIZE(map_types); i++) {
+		fd = bpf_map_create(map_types[i], NULL, sizeof(__u32), value_sz, 1, &opts);
+		CHECK(fd < 0 && errno != E2BIG, "percpu map value size",
+			"error: %s\n", strerror(errno));
+	}
+	printf("test_%s:PASS\n", __func__);
+}
+
 void test_map_percpu_stats(void)
 {
 	map_percpu_stats_hash();
@@ -467,4 +484,5 @@ void test_map_percpu_stats(void)
 	map_percpu_stats_percpu_lru_hash();
 	map_percpu_stats_percpu_lru_hash_no_common();
 	map_percpu_stats_hash_of_maps();
+	map_percpu_stats_map_value_size();
 }
-- 
2.43.0


