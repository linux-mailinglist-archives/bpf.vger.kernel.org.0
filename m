Return-Path: <bpf+bounces-32021-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A65969061AD
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 04:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD4DE1C21156
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 02:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E33141A84;
	Thu, 13 Jun 2024 02:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="milEuncN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3C533062
	for <bpf@vger.kernel.org>; Thu, 13 Jun 2024 02:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718245192; cv=none; b=ual6L0Juq2b8E7T0zJkO343HFjhxckRpDWXKjZ8GmDd3e0/CwHpjPTcqyGPuzKWPNKDxtoj9BeR2w9bZf5qduMdG+h24I7iZy+J41GOIwOSsXFuktR5c4JTgKjHzW9q6l6VNa8lu5JtOwlL9jRRhAO5b1lenarc4uC8NevVkxfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718245192; c=relaxed/simple;
	bh=qrVcHf53l2iZ9VhFAfVOsdRxfalC8OgJwGYGJEjeCfU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BV5oku5h1i5SWnPLxeQ3TU6nDpYUCFPeLoCYtgyDfbCiZ80liGsXwbXfCVTaXvDxmbyE8WkVxjkKx3jC55Awr/dRteg9mGIo2FapLH+frQrEGUEyDZ24wz61w/cLfJqCorNI7w/ZkALkFxiwmbncQrKtcSbXf7EzqmDogb7Z/0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=milEuncN; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2547e1c7bbeso246163fac.2
        for <bpf@vger.kernel.org>; Wed, 12 Jun 2024 19:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718245190; x=1718849990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=riFpXjYnkjoIQtps6Z1+ssWopYy9q8anc4dJYu3r+qM=;
        b=milEuncN05ZPEJhE6g+Tm5VvoL+cD1RidDNtLrzgM28qbuEWnkQfDwNKgqU03KJU2K
         k/BOmxkqxxkQxWE4Owf+rOyU/CV7zrf0VESDLCDjZvbC87Pz0NEuBOW+/PzbYI4DD5Zg
         frdpg1fk2K7Z0j7DETsK2oAEB5fDGzpdsXTpz5sWMkWxipMq6HxvNuksNFZiCxcfovvE
         RVKTJULgnp3BRqHMR1vCN/fpk4AfW/xlpoSyJj5U8n8xdi7i2z3JAm+g8QBtLqwdOYTZ
         0Cae1as7VEuPIyar9NubRy1A2DWpoXHTPRi7Kj0H7Q0R36s8Hn9Nn2gKwDmOwvoEScu9
         UVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718245190; x=1718849990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=riFpXjYnkjoIQtps6Z1+ssWopYy9q8anc4dJYu3r+qM=;
        b=YbZsRRx5WoxGGpbQZ+4qzPNEzl1HeFvIGMTTrqlDRYIIY/QGSCGiKZbKEol0ZG7WG/
         TyEjaHg235xzmnfevV1UmPI/r4OZ3VyTMpJd6BhG2IXxP+aKIbwQzALJdigXXlckDFqi
         Iu0/7Ah3taNi3/H0GU1apdFQDd638nimHzbk4hfWON5kpje6mPv5QmPpzftPLxujV8c3
         ElClySHM/BVYTW9sGispNekpAlYbu+zBiB1bizcmeJHRV61wHMHeHGY0blIwAHOUuQ/m
         ygwlWrzWPFzMIEMv2bcT5fYtjg0zmlxuCXql0tXpGuyasL6MN/PBmqhiLdsZ7kULMs50
         PcKA==
X-Gm-Message-State: AOJu0Yz0gR4tCXPMWedn/w0PLVPuhiRVh2GDL/x2k/aOqZRJRUVxCpdI
	2xCoedokbOU4iYOYl5bJlxBXYNdmdhP5WzUA3120C2qAeyfwf7rL
X-Google-Smtp-Source: AGHT+IGTmNHH2LMdpbjt1ukuMMZorDXWREgMRs5VSRmxcWAsjJjbfvbkXGyv/1+5WV13NgslrKFF7A==
X-Received: by 2002:a05:6870:1816:b0:254:948e:bf08 with SMTP id 586e51a60fabf-25514c70250mr4082722fac.31.1718245190322;
        Wed, 12 Jun 2024 19:19:50 -0700 (PDT)
Received: from FLYINGPENG-MB1.tencent.com ([103.7.29.30])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fedf2a74dcsm168230a12.46.2024.06.12.19.19.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 12 Jun 2024 19:19:49 -0700 (PDT)
From: flyingpenghao@gmail.com
X-Google-Original-From: flyingpeng@tencent.com
To: ast@kernel.org
Cc: bpf@vger.kernel.org,
	Peng Hao <flyingpeng@tencent.com>
Subject: [PATCH]  bpf: increase frame warning limit in verifier when using KASAN or KCSAN
Date: Thu, 13 Jun 2024 10:19:42 +0800
Message-Id: <20240613021942.46743-1-flyingpeng@tencent.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peng Hao <flyingpeng@tencent.com>

When building kernel with clang, which will typically
have sanitizers enabled, there is a warning about a large stack frame.

kernel/bpf/verifier.c:21163:5: error: stack frame size (2392) exceeds
limit (2048) in 'bpf_check' [-Werror,-Wframe-larger-than]
int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
__u32 uattr_size)
    ^
632/2392 (26.42%) spills, 1760/2392 (73.58%) variables
so increase the limit for configurations that have KASAN or KCSAN enabled for not
breaking the majority of builds.

Signed-off-by: Peng Hao <flyingpeng@tencent.com>
---
 kernel/bpf/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index e497011261b8..07ed1e81aa62 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -6,6 +6,12 @@ cflags-nogcse-$(CONFIG_X86)$(CONFIG_CC_IS_GCC) := -fno-gcse
 endif
 CFLAGS_core.o += -Wno-override-init $(cflags-nogcse-yy)
 
+ifneq ($(CONFIG_FRAME_WARN),0)
+ifeq ($(filter y,$(CONFIG_KASAN)$(CONFIG_KCSAN)),y)
+CFLAGS_verifier.o = -Wframe-larger-than=2392
+endif
+endif
+
 obj-$(CONFIG_BPF_SYSCALL) += syscall.o verifier.o inode.o helpers.o tnum.o log.o token.o
 obj-$(CONFIG_BPF_SYSCALL) += bpf_iter.o map_iter.o task_iter.o prog_iter.o link_iter.o
 obj-$(CONFIG_BPF_SYSCALL) += hashtab.o arraymap.o percpu_freelist.o bpf_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
-- 
2.27.0


