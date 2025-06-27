Return-Path: <bpf+bounces-61765-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06759AEBE9F
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 19:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7E5F64815A
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 17:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919DA2EACF4;
	Fri, 27 Jun 2025 17:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BN0Pte/1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFE02E9ED4
	for <bpf@vger.kernel.org>; Fri, 27 Jun 2025 17:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751046794; cv=none; b=FWr5le+gpRwukMf99fEUUHsnsq8fNam6we5wKmBVWjWjFFcTOAEzzkjor02Of4ZRDNO9sHrCVBL00Uvq21kA5LbbzX5YmDt3xGLBiJQsqMeG9cFDIhBTyX4ewVxc92T7A9CQ9c2tnlyTutHlTldN9jAb5r8moeVr6RJksf+rJAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751046794; c=relaxed/simple;
	bh=pOFItNjSVAIJ/QbSw6nZbIvrMYZhRLcR/JhB3rxk69A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OtQmfgnJ4bZtFIbB2IdqG6DgY03weMwQb6XrNE6vE3M8eLLQwjfelXIsx6ncwYZzJN4jAKQNp4uoY03GKVOWK4mRi2mCIXL9A+XU0rQbfY5V/Ce8V9V1y1FA8Pl11b4vWkh6duCs6qEMZ5rHVJib6iK9K8RHAt96/lhDtkzPj1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BN0Pte/1; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-713fba639f3so25508857b3.1
        for <bpf@vger.kernel.org>; Fri, 27 Jun 2025 10:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751046791; x=1751651591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5XUINdEkDy+eJn1FMCOjQweN+7EXFZ6ew6xO7zooVA0=;
        b=BN0Pte/19JSTqGh6VTKyWuTNfCZu8v8vj68WF6qQ5KtpqW9lDjrkKqgC3p7fJ8ZwBQ
         /cikyq3zxc7Gx73EpMoY2HLL+zzpFvrypy4xVduvZLnuDb9LicPiYGleSbvxBb5QpdHS
         LIXHo0z7/NnFw2CjZcmb9bsDkIObcaw2poXQO7zA2dnbBIPiTCduifgkXGuB3vp2Fbv2
         wVS+TbMCXFxYcaQawP8dk5dArDMUdmzH507jcUyAx7vqYtM/m/vpdLxcCXZxE5EL0sPs
         He0/WRWvXQIOuNgbOolLniCYBcLjPe0CIrLZ/pCHlynTqMsXZw5g05mAywvwL00Uf+6r
         2P8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751046791; x=1751651591;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5XUINdEkDy+eJn1FMCOjQweN+7EXFZ6ew6xO7zooVA0=;
        b=WwVL/DgDnRQ6vW5tKHpVK75ik9ip8KbTxlGJM75TtYktNVkIrZx2li+ubsQJLWRXmv
         f+50lqp4xSOw0Z+7d3UzBCNE4E/rYN1ApsM6swknD0g7TKKrBkg3vusVNFXWtaSSq63C
         6tPHEBTFfzT/lVVJnVMeigP4KDT4+dUcquchXQlMvngFr1b7S9yEPDxe1gbmrk0Jw609
         /AMmWd9bdi5Hrh0lXvbaPNdFaZmhEewBkcAfTxisi58EZZxFrMoP7z4gM8PFrL1GM/BA
         RrULyGblyzqp8xHUUAwW/cGEnB0PPpydA3JKulYNbQzNnRXlj9NbjnkruwxaxEh6nng6
         I31Q==
X-Gm-Message-State: AOJu0YxaS/GFQiiBgqA1K5SxR4HgzwoB1JAvNCjT9bcvAxDNT4SGIDv0
	ykkdUYETLti9AhcWlZUqN6je+4GOW3N948aPb3qD1S9dTz/A7Ha8SMuLWca/5BFk
X-Gm-Gg: ASbGncs21hJGoycdtFu0yW+PSxXouoyzqaTU2cfhC4F3ghJ9E+ul+fKcfyNtVhat9Ac
	e3qtypliHnIYLlYnyU81nyU90zWfUcZEtgDWTrAct+a+dnPw72xcuZh1LZtAoSne4bItNKk0fl2
	4odlvr83Dm7vbTsUj+rDH1mVVkZz27l9Tmr96MmmJhilBeOIoqe32+trlVrNak92f3UGVCPftKk
	8H8unYeUJarEOl+toXrf/nR+Lh3+9MioY4oze+At+ZitchJfFq/l4HY0myP5KUCEXyWKDTL3utu
	sXJebCVcBDXH5XjZzJde66sAcS2DZmGJaUpGvQGyj/hRA7zz5LXJjN42V5oDDg+Z
X-Google-Smtp-Source: AGHT+IF4PduDBefW+GuE964Ok38ujKJ+tTv6weo22DzkBzrElxP3AZB76LxdzDU6tnPKrL3u5CJikQ==
X-Received: by 2002:a05:690c:4985:b0:70e:143:b822 with SMTP id 00721157ae682-71517150eb9mr64755707b3.7.1751046791401;
        Fri, 27 Jun 2025 10:53:11 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:74::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71515bf0aa6sm5203347b3.8.2025.06.27.10.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 10:53:10 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	Jake Hillion <jakehillion@meta.com>
Subject: [PATCH bpf-next v1] bpf: guard BTF_ID_FLAGS(bpf_cgroup_read_xattr) with CONFIG_BPF_LSM
Date: Fri, 27 Jun 2025 10:53:09 -0700
Message-ID: <20250627175309.2710973-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Function bpf_cgroup_read_xattr is defined in fs/bpf_fs_kfuncs.c,
which is compiled only when CONFIG_BPF_LSM is set. Add CONFIG_BPF_LSM
check to bpf_cgroup_read_xattr spec in common_btf_ids in
kernel/bpf/helpers.c to avoid build failures for configs w/o
CONFIG_BPF_LSM.

Build failure example:

    BTF     .tmp_vmlinux1.btf.o
  btf_encoder__tag_kfunc: failed to find kfunc 'bpf_cgroup_read_xattr' in BTF
  ...
  WARN: resolve_btfids: unresolved symbol bpf_cgroup_read_xattr
  make[2]: *** [scripts/Makefile.vmlinux:91: vmlinux.unstripped] Error 255

Fixes: 535b070f4a80 ("bpf: Introduce bpf_cgroup_read_xattr to read xattr of cgroup's node")
Reported-by: Jake Hillion <jakehillion@meta.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b4117681137e..f48fa3fe8dec 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3779,7 +3779,7 @@ BTF_ID_FLAGS(func, bpf_strspn);
 BTF_ID_FLAGS(func, bpf_strcspn);
 BTF_ID_FLAGS(func, bpf_strstr);
 BTF_ID_FLAGS(func, bpf_strnstr);
-#ifdef CONFIG_CGROUPS
+#if defined(CONFIG_BPF_LSM) && defined(CONFIG_CGROUPS)
 BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
 #endif
 BTF_KFUNCS_END(common_btf_ids)
-- 
2.47.1


