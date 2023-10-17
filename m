Return-Path: <bpf+bounces-12451-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B46C87CC8B4
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 18:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B385B1C20A2E
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 16:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F5F9CA7F;
	Tue, 17 Oct 2023 16:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2Cco82A"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7699CA61
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 16:23:22 +0000 (UTC)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B25F2
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 09:23:20 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d9ad67058fcso6133647276.1
        for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 09:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697559799; x=1698164599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=erUOV4dNptkdGGqSELDU+CDiUZ9qDYiO5ZXsDCge60c=;
        b=h2Cco82AO+3MLk3o5tqlLj7AXSndxkLjF1ZLxKwmaE6XmtCFHc2icQUiJxp6+8SJ3M
         1s87fj9vd4iR15zQHcMiyAZz6NWDTWRmuutXKLdQ+UwIGfQSEclImZruk3xvYo5ueIxr
         W+eP0G1ASOjrS/vG+qYOx3yq/UVM5yV+k/idC2thoZantQTqN0K5h+bnTjHFzsAUWFbY
         kVNGfwAA+NQUDlh6prZj5dOxXuhlIItaZAsSYUriBn/wNbXkKzz3Jd36lYzOmixaXPSj
         sQMJok2q/Ep/Wc5bnwRFQilvRrljJQCbHEkNuMLu3ETPZNhaSWQTfqaela70/mOXI+Lh
         DPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697559799; x=1698164599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=erUOV4dNptkdGGqSELDU+CDiUZ9qDYiO5ZXsDCge60c=;
        b=KQMueAR3PDL2oT52ihsBzHiF0aDJBql+6+TKGxmur4Uuf0tdH0iXnQCbJA0gV9lhHB
         XcswM6C7Nt1kc5JPIqUKa0/Q6xHrvrWLyLiv9alHUmfDW56h1Swlm/4InD8mlovoX1Sj
         M86Gzpq8in0iy/rkxDBjM7VlIp3AU9O5hLQNCsxCvWRuO3RYYfY0SRqft0w8Hv9eLhCP
         pc9AdUBF8saDr0Wj/emM5jVC5xgTzZ14vsfFhS9zeBGMa8c02q/dAzNeIbe90JcRdhA8
         /+n/1emiOP1X1yI0TqZKaN4z33anroTZboaOSQ8Gltpk6wN2at1nt2zVx9oyaKL7ltH2
         pd3A==
X-Gm-Message-State: AOJu0YwGMUM8QDIPnns+G6xhvGiLtyiUOM7Fsts/me30Me+9z7+7j+cg
	CwGPIOusqUBZR/VfgzhUR8HQn1WBBSQ=
X-Google-Smtp-Source: AGHT+IERxfJvwbInVrNSQE73LoybDeo/HtE/bVcErQgf4tM0AslP/eRD4rhkMYzi+jJO9O4G1JbKww==
X-Received: by 2002:a25:f02:0:b0:d9a:fd15:82a3 with SMTP id 2-20020a250f02000000b00d9afd1582a3mr2844880ybp.24.1697559799426;
        Tue, 17 Oct 2023 09:23:19 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:ed01:b54a:4364:93cc])
        by smtp.gmail.com with ESMTPSA id r189-20020a2544c6000000b00d814d8dfd69sm623645yba.27.2023.10.17.09.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 09:23:19 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 8/9] bpf: export btf_ctx_access to modules.
Date: Tue, 17 Oct 2023 09:23:05 -0700
Message-Id: <20231017162306.176586-9-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017162306.176586-1-thinker.li@gmail.com>
References: <20231017162306.176586-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kui-Feng Lee <thinker.li@gmail.com>

The module requires the use of btf_ctx_access() to invoke
bpf_tracing_btf_ctx_access() from a module. This function is valuable for
implementing validation functions that ensure proper access to ctx.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/btf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 990973d6057d..dc6d8fe9b63d 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6141,6 +6141,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		__btf_name_by_offset(btf, t->name_off));
 	return true;
 }
+EXPORT_SYMBOL_GPL(btf_ctx_access);
 
 enum bpf_struct_walk_result {
 	/* < 0 error */
-- 
2.34.1


