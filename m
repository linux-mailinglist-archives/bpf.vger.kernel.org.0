Return-Path: <bpf+bounces-13830-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6307DE6E1
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 21:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C03441C20D85
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 20:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0D91B27B;
	Wed,  1 Nov 2023 20:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uago60Ns"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7521E134C5
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 20:45:41 +0000 (UTC)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5530B110
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 13:45:40 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d9ac31cb051so193293276.3
        for <bpf@vger.kernel.org>; Wed, 01 Nov 2023 13:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698871539; x=1699476339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ht17E8obJKFk1mksReHbvYy+OWB/UWZc/J7sjSWQU5o=;
        b=Uago60NsdohQlEWxzOXVahvXSI3x2nj2xnJzFdo9w8POJ6YmXA+zuYzXI6jlCKeLO/
         hBm/D01NvggaviZXM+qs0vLAT68Ldj3M2Kf0LLlyg8ifEY63ja2658M8M2ayKRdk4KFp
         b806h9936uq1H2xRVH9f4ZdmuOHrrkUuFJbof2qxol7hXODud3PDOinJx7I9gWick8bY
         GWeYny6iGOTGwl8+qPM1nmj4I0jlBeFdUHuSd+gu91RllsDIUxM6zdSCaLjFNtnr81IU
         T2qFBSqphifawEcyqesusdunBOo/PJPePhB3kz+MyDEtXHfE7SvecRb02al1GdTu7Pgd
         aiFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698871539; x=1699476339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ht17E8obJKFk1mksReHbvYy+OWB/UWZc/J7sjSWQU5o=;
        b=hGPB5xXBXRK0zuKJRaCxYPSIjY1x8l2ZvmviSApK0XPFa+3vktJAoJoDxgDCI3Uvaj
         iuQPxa7GVns7sJ5eF/2WJsz9TyLxLvBmAHPpBK4q32rTXd0BcWrNM5bv4SMrfzoVzFxu
         3Mosuz//JzlSIGWdiWWB0u2IFBitJcA9kVjIS+uJBwI/kbNuC9VZmBO9A1CtHcjNEHPj
         b2K/Z61+iAPcdoI/zdnr3nfeHVXQ2pFoLd2ZftHYnLp77z7PYYJCab8iorcn0fQOBCVL
         1keQolOzWN8Serfs81hRRPCXryjJwVlYTDO9H+PD0TLpGz5ZhxxEsObtbn0ZUulwuYo8
         ML0A==
X-Gm-Message-State: AOJu0YzqJ1xrd5z8bR901/GznxIor8Cv/5Rga1mC9t6IJhFDLDAuM8cM
	bbHmxL6Ywin/kFVYnwtxuq/vbukt/HY=
X-Google-Smtp-Source: AGHT+IGjRmBiV/AyBH+LJbFkORcHk/FS0X8mBY2xzixV0LKoMFJgQbk5ikaB40/BxOS/xz3SKXaoLg==
X-Received: by 2002:a25:bc90:0:b0:d9b:4a28:f66 with SMTP id e16-20020a25bc90000000b00d9b4a280f66mr14690002ybk.53.1698871539017;
        Wed, 01 Nov 2023 13:45:39 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:eea0:6f66:c57d:6b7c])
        by smtp.gmail.com with ESMTPSA id o83-20020a25d756000000b00da086d6921fsm342386ybg.50.2023.11.01.13.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 13:45:38 -0700 (PDT)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	drosen@google.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v9 11/12] bpf: export btf_ctx_access to modules.
Date: Wed,  1 Nov 2023 13:45:18 -0700
Message-Id: <20231101204519.677870-12-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101204519.677870-1-thinker.li@gmail.com>
References: <20231101204519.677870-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

The module requires the use of btf_ctx_access() to invoke
bpf_tracing_btf_ctx_access() from a module. This function is valuable for
implementing validation functions that ensure proper access to ctx.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/btf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index c8a1bdbe7d9a..e8c19b015d79 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6139,6 +6139,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		__btf_name_by_offset(btf, t->name_off));
 	return true;
 }
+EXPORT_SYMBOL_GPL(btf_ctx_access);
 
 enum bpf_struct_walk_result {
 	/* < 0 error */
-- 
2.34.1


