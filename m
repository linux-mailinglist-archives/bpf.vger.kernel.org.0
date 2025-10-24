Return-Path: <bpf+bounces-71989-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB15C04716
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 08:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC4C84F46CB
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 06:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5520258ED6;
	Fri, 24 Oct 2025 06:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNaH2Myk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0044A32
	for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 06:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761286084; cv=none; b=K63cAxVv2kboxgEylrkhM5R9EV96ddJESyl4O5/tTbSebspzfa/xsWR4Rz/8ROm9nxn3kSoS2OJZjUYLgXKPvFsuCgqb3gOI6ks32CyIiqGfaipJMXjxHOkDjDo0+slSPrCeOtIiQUtqtb/4Qhu/n29raAVSGGGJr0HR7W81zt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761286084; c=relaxed/simple;
	bh=etiiWQcSY+zWyfyvDJEnJIqalx73o0ier60DTEh3nzg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V8t8CkAIQJrRxo3MiIzlT9nE/P8WtPBgfTkD0d2hPeEoQFHaBZ+Jqlr1aAa4qUcwPiO5Np+gqCzSG4N1Uy9Noa2vt5EO69ps5FM5eK8dUtjrsXdE4C1aXl4EywAr9pPrVGSLDKiHCsSYdhBv8fpoLJc0hqHwGlF7D4X723pGgNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNaH2Myk; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-269af38418aso20899705ad.1
        for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 23:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761286081; x=1761890881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vk5tKMojX80fyzbsDK9Px3vsmzEypSeIpUP4WMWG8aQ=;
        b=DNaH2MykdOVfApIxzwdFsAUpRIROy2UgxCTX8giw6QFFJHMWF+DsJl2ZbpfT+mAAKN
         rnrAV4KCg25B2U9LdqSAvMlz+JF9TU/mnyK2QsTn8AiMF9p8VoOZDy2SNqNGaDvvKgYp
         i7xU4kAUT2nTWLE0fbk3za6t/tX133dj/rajOK4Vs1L0OYlCmntcgCqjxBBFBoiF3LI1
         dHgNwR6JgXxHSTBCtpP5iu3dEy8bzhKUw7cWgnu3srFTkx0kaQoMh+KwpqYXHw+B997h
         MF9yobOI49xQWrJ62a0GevjF1kgK+iu2+pjp5S+upwQA7nUbEJ483WTmYUpqHgjSq5A8
         y0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761286081; x=1761890881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vk5tKMojX80fyzbsDK9Px3vsmzEypSeIpUP4WMWG8aQ=;
        b=fOZYeCK7H+S6LCQ1TtoppkpUdEfVHZZuBRkQwyT+0FNNC6Sc40mjXV7nG3k/Km+tqT
         TDGZQTzwe4GJFdUNotrJozYVAuxDW33StXj9UIL8Sp7ZxQ57qfDFepo05sSUP+mGWG3j
         yZO+hbOlmNcHZBFuuWU8WO7NqK77/ATBgvngb2sDdLi0ueZHwjPEPRzt6gGLALiqDHFe
         JWd5+ZoCoTReWPNyrI0oyuzlHz7+J7gY+Wk6iUSYDbV9+7fOjP8bH4WUfb37cgTre6Sl
         4DSYf+7goTaLHYnGn77CW7nmROdrKVmH7EgdVzHQhvLR3r6fbOQ4TVLtu+WAOItxnIm4
         +tJw==
X-Forwarded-Encrypted: i=1; AJvYcCVoeaanx/ICIRgox5K4ByuR1ZqzeCWNpxbCeo/i+2d8eHUg0nKsMWo4bV+BJlr7RDvtS5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2SyQFgkU+8TnnSrR1EGjebXA6HCwo+DmaeqsFMPOnem/rpFmZ
	ZKPqv+EOMnMI6aPA3ydCesv8GKYg3JKPRagYxf/2eaaT8Ydqhm0FTNmg
X-Gm-Gg: ASbGncvHuiMrVRQR6aglRN7n9PKI8sPlETwfFCEezS9rMZi1dYgEyoa3KK0I6igOagY
	1m0myJHnmwymJuU56UKA0izV6xPlHU7qg1Vfku1+7VfD+qSKcWUiTgpz0Xe+vyti+LYprNY7S6h
	8D8JsDIVdnohUrveCsvMGLQ5smhUpzh10mg0HuilUAYOaTnaAXvM83SjKPWCwqyVSAYUKhMCpzQ
	O8i/Cbb2DguthZzzTWZ+qEjrTrC6T6cWzCJfzaei/lsV6xBcJDU818ANzyYNGQwUkOVFRvqlyGT
	ScRFJI0nELn2AvWmg/4IAfsL72yKvTTzszO74V88tysAacqnIuugHJomX6ZwmfJwgBoTyu2wOCn
	xr9omgROJjbOOUUkfciD6zy4cKw9FmMaVg4WoP3w4QGSu6jBsS4iB6QpgYO5GDT2G26dOIEcvac
	dXQH57tnDCR8/qMj8u4A==
X-Google-Smtp-Source: AGHT+IElmlafeEeVB2WMsQSk+MOjUdVM74P9RdyjOAxP+L5479WaOzgegwsZ3NGbdtJsAl1i/ejKrw==
X-Received: by 2002:a17:902:f610:b0:272:2bf1:6a21 with SMTP id d9443c01a7336-290c9ca72aamr370603485ad.14.1761286080969;
        Thu, 23 Oct 2025 23:08:00 -0700 (PDT)
Received: from E07P150077.ecarx.com.cn ([103.52.189.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e25bad1sm43308915ad.105.2025.10.23.23.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 23:08:00 -0700 (PDT)
From: Jianyun Gao <jianyungao89@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Jianyun Gao <jianyungao89@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools))
Subject: [PATCH] libbpf: optimize the redundant code in the bpf_object__init_user_btf_maps() function.
Date: Fri, 24 Oct 2025 14:07:20 +0800
Message-Id: <20251024060720.634826-1-jianyungao89@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the elf_sec_data() function, the input parameter 'scn' will be
evaluated. If it is NULL, then it will directly return NULL. Therefore,
the return value of the elf_sec_data() function already takes into
account the case where the input parameter scn is NULL. Therefore,
subsequently, the code only needs to check whether the return value of
the elf_sec_data() function is NULL.

Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
---
 tools/lib/bpf/libbpf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b90574f39d1c..9e66104a61eb 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2988,15 +2988,15 @@ static int bpf_object__init_user_btf_maps(struct bpf_object *obj, bool strict,
 	int nr_types, i, vlen, err;
 	const struct btf_type *t;
 	const char *name;
-	Elf_Data *data;
+	Elf_Data *scn_data;
 	Elf_Scn *scn;
 
 	if (obj->efile.btf_maps_shndx < 0)
 		return 0;
 
 	scn = elf_sec_by_idx(obj, obj->efile.btf_maps_shndx);
-	data = elf_sec_data(obj, scn);
-	if (!scn || !data) {
+	scn_data = elf_sec_data(obj, scn);
+	if (!scn_data) {
 		pr_warn("elf: failed to get %s map definitions for %s\n",
 			MAPS_ELF_SEC, obj->path);
 		return -EINVAL;
-- 
2.34.1


