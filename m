Return-Path: <bpf+bounces-62201-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A08EAF6585
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 00:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C2EE1C45FA5
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 22:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA3C275103;
	Wed,  2 Jul 2025 22:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2iglX8I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E1B24BD03
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 22:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751496141; cv=none; b=tJjLaRcsYQ4czHrMf5wgGr/R5qzHzJtk2Kcj8CKadv/yoHs7GE3DbVEVDjUfoz6GE7GBrbCupfoa4LvFPpXv9Ku+zb1fwYJyLJcOJiNHUW5MiOh4bTzVNV+TrYNLu+wtTKHpvMQDlG46cYVVvIQxtd/QXmvqIIuLz5UaNvM3i9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751496141; c=relaxed/simple;
	bh=21v6hgPX3CLOb/LmbfwTDDoDNiaPN4pWj56V7gP91LQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rv6racGR9tCOxoIrPeR0SHBqdsuZN4f1VWb4jKxGi+JFH9+uNkjWnhUnWm4U0feYhP9dLpzM6mT9xQavhBxJLLtwGFcef/GkeD9MlJXKxXP2UNaGJn9xfih+rnCdzmuSc2UApf1McBWhnUf+wGdFLmGBNI0BoaPUPMN6VbDu0Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2iglX8I; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e7387d4a336so6664624276.2
        for <bpf@vger.kernel.org>; Wed, 02 Jul 2025 15:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751496138; x=1752100938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OtwOq7y6McTn9Gl7xaPihbt7NnFbsIqxGC2mVuLtEj8=;
        b=a2iglX8IAwBfsAHkIuNHp9CE9dZwOI4vseyHFHj2t+pJ4+BEb5LdrWfDjE93qnVsCg
         mwhTVSVSKkxajd+jTsNYdup1Yq99XCFhGABovxwxwc7rTXDCqLcfScUKw4vCtxLdx8Ks
         3PjH7Vz6erLgMXN/9a0+YgpwdyBhqdhfXGT8XH+0ipRMVNwpnqKquC2LY7J/8rKSfs7n
         l69Sbb3ltUarkh0ddw4BrFRhqY+cd4f8jzXlwylCwwLrHk4owq8MWM2L4DeRr3jfRLxb
         ebHEwLIPEFq+p3yGDs4LpvH9zxeBveICcjj8JIDtFHVbUbczkXrz64o84A9Ekkx0/TJP
         +Nfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751496138; x=1752100938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OtwOq7y6McTn9Gl7xaPihbt7NnFbsIqxGC2mVuLtEj8=;
        b=Ur7/x9esd9Yb2siSw+dQnQu6510PD1WaSuq2RcgRfXH5h0WCoCtY4UHVhLL2tHcG86
         gwTutknF/5l0rO/+jNf92PU/sB8/3nxitpRVDdWtdOsCWePuFm8R4vxuDnGmTlqT8UGb
         S1fjdJWsteQxIDM71svXitrTuEgqttUQKCotGV3i80qR8rfR1V23DaYqK2NrxzMS81/Y
         s+5tNRt0CNo5MOxfhe6ASG1ZUClRu7y5LCrO5bSVDfoJBiT+CN7SRDg/vgatcjs7AjdO
         ktX82GcXvAdTNCDOfqsXagS7pdcxH3mM+vBOgjStWXb8OcBTpYqhkpVis27/SIVzhK5V
         WVjw==
X-Gm-Message-State: AOJu0YwfBm3X4zNUwOldDYfzPK8DvhlNJLemZjEJVuXHeyNpEnX5HRZ/
	SribOyeVYU/47hOBwlFIrnDHrK2u2PWV9FUZ2UOBpC1Hp8OjSmh7GcgV0QLbd8eZ
X-Gm-Gg: ASbGnctYj6l6Vv7WJPBFqS503yw0Yjw3oeylV7YdhFeXRQztf7HJwpvv15k7R7eiWNS
	D1wepvc8WsH7hKQhE7YE/gg2QD+p5xv804CAO9kYEkdUKQUCwvGb6fuLeIqhA4TkUugvRMLZJ+C
	xj8scCgsiR0hhiBPXkCAIgoDAmoGkmlN9llfMjisPRn6BNFaoT5rGGpmI1Nam4PQ9+o80shwiHu
	R42iWA3lPHiHuFJgn8ui7d1yjwCjWbCIcmD1CQukJEKQc1yY55fvDk1J6c/2SE0JHhuCb4edRb5
	3LsrGImzLK3NkNZ4fbYiFbrQXpYuueKO3M3gmrVpNCn1AN0PsfgDgJoah/HdySu4
X-Google-Smtp-Source: AGHT+IFlHIvUR9sNyFs0rVWyFFBpUl9TKN0mGib01/bBwdLrnMa/ercONfzra/MhTT80ueBbuXj6hw==
X-Received: by 2002:a05:690c:6809:b0:70c:a854:8384 with SMTP id 00721157ae682-71658fe391dmr24595627b3.11.1751496138324;
        Wed, 02 Jul 2025 15:42:18 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5d::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71515cb4db4sm26702457b3.93.2025.07.02.15.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 15:42:17 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v1 3/8] selftests/bpf: ptr_to_btf_id struct walk ending with primitive pointer
Date: Wed,  2 Jul 2025 15:42:04 -0700
Message-ID: <20250702224209.3300396-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250702224209.3300396-1-eddyz87@gmail.com>
References: <20250702224209.3300396-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Validate that reading a PTR_TO_BTF_ID field produces a value of type
PTR_TO_MEM|MEM_RDONLY|PTR_UNTRUSTED, if field is a pointer to a
primitive type.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../bpf/progs/mem_rdonly_untrusted.c          | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c b/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
index 8185130ede95..4f94c971ae86 100644
--- a/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
+++ b/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
@@ -5,6 +5,37 @@
 #include "bpf_misc.h"
 #include "../test_kmods/bpf_testmod_kfunc.h"
 
+SEC("tp_btf/sys_enter")
+__success
+__log_level(2)
+__msg("r8 = *(u64 *)(r7 +0)          ; R7_w=ptr_nameidata(off={{[0-9]+}}) R8_w=rdonly_untrusted_mem(sz=0)")
+__msg("r9 = *(u8 *)(r8 +0)           ; R8_w=rdonly_untrusted_mem(sz=0) R9_w=scalar")
+int btf_id_to_ptr_mem(void *ctx)
+{
+	struct task_struct *task;
+	struct nameidata *idata;
+	u64 ret, off;
+
+	task = bpf_get_current_task_btf();
+	idata = task->nameidata;
+	off = bpf_core_field_offset(struct nameidata, pathname);
+	/*
+	 * asm block to have reliable match target for __msg, equivalent of:
+	 *   ret = task->nameidata->pathname[0];
+	 */
+	asm volatile (
+	"r7 = %[idata];"
+	"r7 += %[off];"
+	"r8 = *(u64 *)(r7 + 0);"
+	"r9 = *(u8 *)(r8 + 0);"
+	"%[ret] = r9;"
+	: [ret]"=r"(ret)
+	: [idata]"r"(idata),
+	  [off]"r"(off)
+	: "r7", "r8", "r9");
+	return ret;
+}
+
 SEC("socket")
 __success
 __retval(0)
-- 
2.47.1


