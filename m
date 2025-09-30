Return-Path: <bpf+bounces-70043-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30667BACEA7
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 14:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02E251895BF0
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 12:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95633002DE;
	Tue, 30 Sep 2025 12:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYSczRul"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F974301714
	for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 12:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759236355; cv=none; b=aT+VeA7Y7Qyc5y4+NSEWekJB18P+M3C4/kyyzGLga5wrQyjGzqFS8TP/6YpGX278kyULVq0HcrAqePG6H5NV4YhJ/UFJlp+kGygaYGrW+6+Z6KJ7r8+w3pniziAUD0arB1zLsT7AjF32sI/GJ5XxRKwJjuEmSCxrsDBo4M+1HVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759236355; c=relaxed/simple;
	bh=h/H3jKCaUNS0v4/PB8F3Btz1k6QZB6pf+HwNnJ0mcIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j0UTpCgB3kz1ctZOo6EFoFll4riqDqju8Q5VODQaiPUQR1w+kHrFstaLHXNgv31PwIS7l9AEvmTDeE2UGJeSnLRYywkA7LbIrSlzuJF+1F6u2FbHBgTPm0nPIr6LG4N6grUluDm2feky2eH1b2XoIuMMfbphZxw0hUXuXfK/ytU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYSczRul; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3f2ae6fadb4so1010772f8f.1
        for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 05:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759236350; x=1759841150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywknrftBjNyhxtILJZTbzsp0u8rThEFASWWoC6kgwfg=;
        b=CYSczRul+TRzxeWzKLH1AYld8OiYC4H6cR60E9f7vutpbnHCpU+PYxdgjH906UBovW
         bggMmvW+iuvsKvX94n8JODIgtJGMeOhNcpfLZqSuv+Sf0YIm4KgHoJYhxNZJGZ+qRHAD
         OUpz471mCR1owUnGzhwU650ITVX6nygucpw7iEw3mcaiOzgsA1uLl9TuHKwdJL6AC1N2
         8MA0Xq2lEuRCPH7vFLNOlux03+g8q7VShZ0+E5pBLl1sCKgePpTyCPGSEOwT1fbORTbO
         PJweCgQNYaJtpNI5H728PuHi9I+MGw/vAZWyKzUCSsIV2fGsUBJz40HkhX2BX6nHkDsi
         VDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759236350; x=1759841150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ywknrftBjNyhxtILJZTbzsp0u8rThEFASWWoC6kgwfg=;
        b=BPZYvGqtr4emZQc93x7TWYNixamq7iaoDA/Y1y5iqwUQO/y2EPGd5Qg9QNWy4bTofc
         LF6sy+8Z0WKqUzozdKRxMLdWgiaJx3KrBvej7TRbORaCYHM3bN3yFgqMZfI7phTUdciE
         UY0l7yJagBfwBG6kwJCOVJI2t/sdTWbstb/AnZ91uCcT5SC+ZSU3xsA2lcH9r0yuFtub
         KIWXlCVsNx0tLsxl3a+Ugk5SuhELXjixqFM5O63oY/ef43L3aVSp4MrQRTesHsm0mJW4
         PXw93FGQInBLxguIgaVMB5+YO7bQ2HenUjQmK1YTye7aJDONJxgRHtFve7YAUAl+n2Cj
         s51A==
X-Gm-Message-State: AOJu0YzVBULX+/j6FBAge+puqDCmxq+c0DyP+WxQnEAxDKnu6unsnk/a
	o8gv7O/ILxdFBVGEdm8ubB1246nI6YElqaLL89iiSMNHKhU3IkFlvUchSQG0Mg==
X-Gm-Gg: ASbGncvzk82PdwpnRRTa5iHHexP+1l0AHTtwedPSXbYgUL8pK5thZMvvrDcXePlsspD
	t673+xJH2gahcmcDc1XtNr5rk79xquOaU+BBNSpaJbTaYAUAPARhRjEDCtutnNbo+8ANIz43I+m
	eX6OLvEWO+ev5JZaar9gBeMgsUgPnhxSQqWYcfuOk0DVLbw4mdSrNnYQIxhzJy+5zNvaN1dBQVq
	VbzAqsCeZq3UKcJx945IimfqFy6wyicYYe9n1MNyu3T0JEsKtkMSXfTE1SmChLAb18TipUJ9U45
	u4lsDB+A+n47FLHbaSrVddwNpVMcj8j0SGNAcVz8MmdMfJhfUTRpRbofkTVV2zlavLb6q9IPBE5
	mVzsTQXD+ULUTfulCpgSOB57ir05CZUYQFU0Z5aF5dFTcLN7/7xCOko41vzgZuV7HBA==
X-Google-Smtp-Source: AGHT+IFgLpT8E0tx7X4foeXlO+lWOxcFwrNqptenkzeK5NnkY8HPL1AKfXez/NZk5erQ+aK5+aokpA==
X-Received: by 2002:a5d:64c9:0:b0:405:3028:1be2 with SMTP id ffacd0b85a97d-40e4354d949mr19019938f8f.11.1759236350133;
        Tue, 30 Sep 2025 05:45:50 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc8aa0078sm22392586f8f.59.2025.09.30.05.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 05:45:49 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v5 bpf-next 14/15] bpftool: Recognize insn_array map type
Date: Tue, 30 Sep 2025 12:51:10 +0000
Message-Id: <20250930125111.1269861-15-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250930125111.1269861-1-a.s.protopopov@gmail.com>
References: <20250930125111.1269861-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Teach bpftool to recognize instruction array map type.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
Acked-by: Quentin Monnet <qmo@kernel.org>
---
 tools/bpf/bpftool/Documentation/bpftool-map.rst | 3 ++-
 tools/bpf/bpftool/map.c                         | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
index 252e4c538edb..1af3305ea2b2 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
@@ -55,7 +55,8 @@ MAP COMMANDS
 |     | **devmap** | **devmap_hash** | **sockmap** | **cpumap** | **xskmap** | **sockhash**
 |     | **cgroup_storage** | **reuseport_sockarray** | **percpu_cgroup_storage**
 |     | **queue** | **stack** | **sk_storage** | **struct_ops** | **ringbuf** | **inode_storage**
-|     | **task_storage** | **bloom_filter** | **user_ringbuf** | **cgrp_storage** | **arena** }
+|     | **task_storage** | **bloom_filter** | **user_ringbuf** | **cgrp_storage** | **arena**
+|     | **insn_array** }
 
 DESCRIPTION
 ===========
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index c9de44a45778..7ebf7dbcfba4 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -1477,7 +1477,8 @@ static int do_help(int argc, char **argv)
 		"                 devmap | devmap_hash | sockmap | cpumap | xskmap | sockhash |\n"
 		"                 cgroup_storage | reuseport_sockarray | percpu_cgroup_storage |\n"
 		"                 queue | stack | sk_storage | struct_ops | ringbuf | inode_storage |\n"
-		"                 task_storage | bloom_filter | user_ringbuf | cgrp_storage | arena }\n"
+		"                 task_storage | bloom_filter | user_ringbuf | cgrp_storage | arena |\n"
+		"                 insn_array }\n"
 		"       " HELP_SPEC_OPTIONS " |\n"
 		"                    {-f|--bpffs} | {-n|--nomount} }\n"
 		"",
-- 
2.34.1


