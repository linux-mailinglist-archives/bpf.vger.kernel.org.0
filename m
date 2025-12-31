Return-Path: <bpf+bounces-77593-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACBFCEC463
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 17:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D3953010CF0
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 16:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A19E1E5718;
	Wed, 31 Dec 2025 16:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BE2w9Vf7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D861DE4DC
	for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 16:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767198821; cv=none; b=bAuShDuVHoP2W3/aOfi9SlJDxu8epCJtiNLwCY4PshDWwUzTNq0Y93ylnc4FmQalqVexEW1TWL/Du6qzEFjRqQ0pgCefvN9I5hvKkEp0wUTUUAHjYyAphbQf4M7cS4GPjqEV8rKe9ARoZ60K27rmfseehyWMkwBLhqhxzaGR0Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767198821; c=relaxed/simple;
	bh=t4gH6VSbsbdWc3FVp/AYmzn7hb7h8FBQpPCuW2GbQns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bS+vdMcFfqztUfRYdhX756V4pEZ8cTLhdVDjfMccdPY1KAKodhjCN06q8gbpVgse69H8SMLk4QcDfbDvO866Qvpm5O8ii9QuXQ2zcxU8S8qU1wbMY/Iw6Bu0mdwtG2t0UJ8lVxzSJfHL3ILu/xTg+sJoAmNy8RC3xxSHO+f3Qy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BE2w9Vf7; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-640c9c85255so10799071d50.3
        for <bpf@vger.kernel.org>; Wed, 31 Dec 2025 08:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767198819; x=1767803619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N9ZNbTHH4rDaHvaEMmKW8P12epxmzHNhIPv75+aFusc=;
        b=BE2w9Vf7dMsfD5t07alzPdg1Lp51s6lCyxCUlPNzpnYlFWX3vVgrAEKX8VFNgcG+3q
         t48OuNh6jgfSLN3TDMZz3+t6FZLK3auDnEZVw+KUhi44BD5Te+XwgICtK/xiIgotcsR7
         t1HcshT498YvtJApBQlslac6HbxUTyGvQKOSymW0Umix/uKVUIrlCbDRRFqxKVcqDqrr
         Y0Y+JCNZDzJzUB6WO2zfhP6EqQG6m/kuiCSmCqXIoR5DEkqTXsJnNNkclq7Ps6Z/3pWZ
         LwI97WRM9zN2p7uT390ebMle1rIPhSz1wGjkRjwnV1ylYtl9sV3S7BPEpy/qA3JLWXCp
         8EZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767198819; x=1767803619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9ZNbTHH4rDaHvaEMmKW8P12epxmzHNhIPv75+aFusc=;
        b=KdNDBq3dlgjUvL2DG+GTr52WEKnW2HA9PkSkinaF30KFR8pyU3YE6NhK5Rz/KD/G7W
         jonqvQEe8qnKiZR8VxlR3XfFRnh1oEPKAZTS5MWmFeyrXW74h1HRjdMT9b9+WNTO2pht
         MPROkNrbcU5HfrSgGaQ/deCnpkENd9yl1HpLli3qZ7b3bYZcUVaCDILQ24Gw1bl42kKr
         o6tFiZV3hFJx1irQDMdBxjxgDxoK7dhYvUespHTRdcTEbELOSFfXCjSAxz0bk+/iiHD8
         RLSAlGiCbIQTD0QlvBPp3A0qXFY3YkpfjU/TGg1TrGqXpmuT4Jt/zxGwFXiqLiteVQP6
         01tw==
X-Gm-Message-State: AOJu0Yx/I8gvJn40o0p1zOzmD7A0i8KxKQHRev8FMczPTuns1uGQ7EZ4
	cOSA/Mpl2cGpdUu1rzo4laiFDOrouSs+OazlGklvDkgf7s+qpD00Wgp8Iv4k4dS+pi4FZg==
X-Gm-Gg: AY/fxX4ezPnK2qjEek/TSHSvIGal2kCt0w8oyblxfSqS/12Pj+p7KAU2WOHa8+0mXz9
	L59O3gMrJoPzGQ+aMkxUknbtumqnjTw91fjJRcMPOLCLu5Yq+W56NCSumcrnRyNl57ErUxJh1W3
	1ZIG5UfpVrvcIDUxveK+BsLJ81M+eOBbh5+mNdAAYTLMqi8KqGb+iOLEem1/fnyy9e4JBiPQXY9
	ac1xF5MKKfd3jrG/nU6BadIn+eypbULyXIM3y9c4qKl7LIIN9f4TYUblzJkIDQBCVqSTKBdt/b9
	kG1N0t8cEG3X57Jln63P3U+v42y0YD5NIsaKUN3xL84DtkYQtR/o7OowQKM51a1KAoh5xdDtKp9
	MTApDWvPzmUDWNcFC7dfxkSp/YZBg5S+q6FYn6G43HPRy23WabkXMsCBZKQGYL6+3fKYzrbw9Tt
	Nh0bvYX7fn3vauQ8thW3IlclsIsBBwfdngaDN38px4AsuIUl+eJlZQzh8FpPqLyMjVTViiKri4J
	JVuLRyrmA==
X-Google-Smtp-Source: AGHT+IEWiiGqb6bpOshQTnqcLIrSI0i16NGhrJ55zo9tEIE0D+eihRlh9M/PzntJY3zn+QzRkWspaw==
X-Received: by 2002:a53:e224:0:b0:644:795a:391 with SMTP id 956f58d0204a3-6466a8a5f6fmr21564409d50.60.1767198819177;
        Wed, 31 Dec 2025 08:33:39 -0800 (PST)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb43bb8d9sm138800267b3.20.2025.12.31.08.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 08:33:38 -0800 (PST)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH] bpf: selftests: fix missing declaration for bpf_copy_from_user_task_str
Date: Thu,  1 Jan 2026 00:33:29 +0800
Message-ID: <20251231163329.4831-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clang BPF compilation fails in bpf_iter_tasks.c due to an implicit
declaration of bpf_copy_from_user_task_str(), which is a BPF kfunc
exported by the kernel.

Add an explicit prototype in the test program to make the kfunc visible
to the BPF compiler and fix the build error.

No functional change intended.

Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 tools/testing/selftests/bpf/progs/bpf_iter_tasks.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_tasks.c b/tools/testing/selftests/bpf/progs/bpf_iter_tasks.c
index 966ee5a7b066..f5f396b5aa27 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_tasks.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_tasks.c
@@ -4,6 +4,11 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
+extern int bpf_copy_from_user_task_str(void *dst, u32 dst__sz,
+				       const void *unsafe_ptr,
+				       struct task_struct *task,
+				       u64 flags);
+
 char _license[] SEC("license") = "GPL";
 
 uint32_t tid = 0;
-- 
2.43.0


