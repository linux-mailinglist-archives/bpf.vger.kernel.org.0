Return-Path: <bpf+bounces-61469-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B883AE739B
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 02:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEE32164C60
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 00:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDA7748D;
	Wed, 25 Jun 2025 00:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="It7TMbU9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AC6A41
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 00:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750809925; cv=none; b=VTOIrO6l9SpIkFLZGx306FJt+yZR10ue10S3UPq/MqxzS1Yken3xEJ7oiWaKA3IzJzjXXU1o3yWAaC1W0V3npnn+aen2rgCCY0Bn4BInuEh58Uy5o3BMiR4jj2JkOfDTavHz3u16BWO8uGM7nCs/lv2mnnh0DZykoqHnPZbCSJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750809925; c=relaxed/simple;
	bh=bPNOpPvRsodOpfWtkbbkPQL+d86UXPm1GOjjwD3IdN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T5nA0olTLm7mgJN6xaGmFD3ZJngjyfUD8YWPU+bE9bQKYWivNAoAond73hpiq4DqZiWhXJ0b1fx5hL3aXTmC5qSmHlfbw57o4ax9P9DYeuwIYjhy7KWfwRNs6eUYrZDvhiMh90Dc4uiB8u0yJ63tZ77fezg2B5ZeMBZgWjGa1qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=It7TMbU9; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-710fd2d0372so3383627b3.0
        for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 17:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750809923; x=1751414723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ggSd3cw6aLBEsQiWADJzjSlxQu/BpFbdYnIyq3czqZA=;
        b=It7TMbU93i3owJOOJA/brdUEqZbMURw28LE9vxMDJikC8SnQB59wAlfyH91NYeX+wH
         bX1HSZ1vs0+NAXSaqMj/F/nstfaPX07ZTR8cOqG5ehIEd1/Nrb52aUfGyqcf4HTKB5oe
         ng3PjS0aJdFoki4gR2OaI61/AUhsOlzvm7jiAow20nBCEp9npsFOI8ka7rA4qL6ppEyB
         3eE73zzWCdJ/a/jLt0mpAPVsRk2DPVnn2KNJrZhVcrqHBQ2ogm94XyX7gNuvlh8DNXq9
         /3hqwnPuW3ziS1N9ejm/7Iqgxd3SvvTOEvM9hSDfytl2zgXHfszyhmK/6IKi6KF/rnuo
         dw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750809923; x=1751414723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ggSd3cw6aLBEsQiWADJzjSlxQu/BpFbdYnIyq3czqZA=;
        b=OB+XCRlT+rfOGVQxslDz/oqAGN9RyhXmAOCQVMxvNpPD1RpuTPYN3tXVhR3b1MdMqG
         J9z33ejp48grwxwXd1VBP1QLr5eVfDbj1ZnOnuxIcsYGz5yxFph5lN76Wa/wvTy3beqA
         ElJ2KUP82wHbHEfUM9tDY/1aEU9RRX+/n3nBR/skd121lNs00JQcG4O5fwJ6boQ+AAKI
         fo8AEuF8sgBvUwkiijr9HsKgKw/+TYSjpW3sJcqELDuMNQ2GHyTvVWLroB57Yc9JkJPr
         0MhOC4xVik6yMkxbDZQs52C7VxtxejVZpPEyths/iAdzrXTwN6WVrYUvRdub6JONVlvx
         TSMg==
X-Gm-Message-State: AOJu0YzYNkOdLWWjn6zSzepr7n5qCxLj/Wi4rIo6TXzDrbJ4myzuaFYQ
	otOLbmZLcLKy9UuTWm3Ee4rGKen8lOaIRMQl3QWHyWaPVksPY30JP8oQ9I0qS2wh
X-Gm-Gg: ASbGncuRTmx901eGLk5H1phsCB3hPcx3PPcUbRQFtXhOIJL+r85LzSq6A3f5/TKsKFn
	E5dfmNK9oYxJpZcyWFx8HAeKZnvvxJWeQnC4XGO4xIgtuz1o+7OGSfYHEBAXSeBqBi2QO6R3qNd
	XfcX6x85IoLmRljEt9DHj3CmKarJIXp+22Y0FCOZ6E75ITBchbVgQq0zWQjR5yqOf5bzt3cT2tI
	GTaAEVcteQwJvBRYoyIuF9U5fzS/3iItbWi3w82RWrSalFUN/GVmIQiNhfw9VJ1MHiBANU61AYz
	IhPokJUk6lvpimMutwjgJITj22m1/3UDy9clggmtlqLxNZhkfv1LkM+E86ZPA/9V
X-Google-Smtp-Source: AGHT+IGBpKMm91IugfA5EOrwcrlqD7F/QTER644MmAuj/z3qQBbkw3se8exsg3LbDsnerMJS5tcbWQ==
X-Received: by 2002:a05:690c:931c:10b0:713:ffaa:5767 with SMTP id 00721157ae682-713ffaa590amr34973477b3.7.1750809922748;
        Tue, 24 Jun 2025 17:05:22 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:13::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-712c49c1090sm22184417b3.16.2025.06.24.17.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 17:05:22 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com
Subject: [PATCH bpf-next v1 1/3] bpf: add bpf_features enum
Date: Tue, 24 Jun 2025 17:05:18 -0700
Message-ID: <20250625000520.2700423-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250625000520.2700423-1-eddyz87@gmail.com>
References: <20250625000520.2700423-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds a kernel side enum for use in conjucntion with BTF
CO-RE bpf_core_enum_value_exists. The goal of the enum is to assist
with available BPF features detection. Intended usage looks as
follows:

  if (bpf_core_enum_value_exists(enum bpf_features, BPF_FEAT_<f>))
     ... use feature f ...

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 279a64933262..71de4c9487d5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -44,6 +44,10 @@ static const struct bpf_verifier_ops * const bpf_verifier_ops[] = {
 #undef BPF_LINK_TYPE
 };
 
+enum bpf_features {
+	__MAX_BPF_FEAT = 0,
+};
+
 struct bpf_mem_alloc bpf_global_percpu_ma;
 static bool bpf_global_percpu_ma_set;
 
@@ -24388,6 +24392,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	u32 log_true_size;
 	bool is_priv;
 
+	BTF_TYPE_EMIT(enum bpf_features);
+
 	/* no program is valid */
 	if (ARRAY_SIZE(bpf_verifier_ops) == 0)
 		return -EINVAL;
-- 
2.47.1


