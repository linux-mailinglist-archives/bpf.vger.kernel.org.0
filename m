Return-Path: <bpf+bounces-13495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F1F7DA213
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 22:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 896FB1C21176
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 20:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5933FE22;
	Fri, 27 Oct 2023 20:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUCJDEoP"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51823C089
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 20:52:47 +0000 (UTC)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC20B1B5
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 13:52:46 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-58441865ffaso1513734eaf.1
        for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 13:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698439966; x=1699044766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lE1uZj4yB64LVf3tuGGiFEv3sigOnkQmS1o9s8kkNJ0=;
        b=dUCJDEoPBVEkgq5MnHDvo0opsVp/yW5nFtfAh22+6vLEFD2QmpuAjqy+OjL/WbR0um
         y7W6MlXauv5w9e+NKGnSvPU5uev1Qb2mP6e+XY9KZ/2Rp7WY8pGGpKGUC3OAfuaxGtQ0
         +Ol7mWbtUmQQnKxdcUYPW0AAYNDkic7/YKs0NdTkVIZr6sycU2zr7gKtlef6/kCscc5S
         Kfikcp14R25Lw2zaiCK/PX75cGN85wltCFCZ2u2l6TO2A04XXIOyWk9p/1WaL46zyfDl
         Kdj9ZXlU5DrIiqko6lLJ5gxV75OafYGE+25lOWY9tJgE3dp2vqcirOKBrA2xa7ZGfLqy
         lg/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698439966; x=1699044766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lE1uZj4yB64LVf3tuGGiFEv3sigOnkQmS1o9s8kkNJ0=;
        b=gJWynKlAYO/lFhkEAc2uyzW0LGpEKcCkhDryBkCsqMyBn7wT3gwQUQ3IeJlTDWDKy7
         /AvdUd/MjjutRwd8QGeXHTRehYBCaDJIHeEeXLFm96fQZDoHs/R5Od5X53XqIO6kAsTA
         esGJbpW9kcJ1mSlLtwGCKYJTHAADsB0wBL+VUE75WB9dYJPw1pCK+mxdK12quMc9sKMH
         HQHc/iQ4SW2DGUTpEuZrPg5zqtWFI9X3Hlr3VwuxgCR9JMCbVaJx8AghN2ZEiews6fc0
         YDdGQyEEQUwh8ibXUqi/tu3UK+H3LjfIsgr0K3V3d2jkskylNkDAOQ0azky4nWTzgPXW
         bDmg==
X-Gm-Message-State: AOJu0YxjrqtX/of30FjYduwWLLrHcUOk1hnVGzVGOJuQmyY0JgtgbvTT
	NlBjknA6dMclOcGmyeaY083M9Fs6ByY=
X-Google-Smtp-Source: AGHT+IGCOVxZoqo37MdtnXYyuR1aN33v3AMGuColmD/vZgIMoZBFAaOw9gROurpf7qi74Zq/2CX4/Q==
X-Received: by 2002:a05:6871:7515:b0:1ea:406:4dff with SMTP id ny21-20020a056871751500b001ea04064dffmr4558922oac.50.1698439965715;
        Fri, 27 Oct 2023 13:52:45 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:41cd:a94b:292d:cd8])
        by smtp.gmail.com with ESMTPSA id c125-20020a0df383000000b005a7d50b7edfsm1048737ywf.142.2023.10.27.13.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 13:52:45 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 09/10] bpf: export btf_ctx_access to modules.
Date: Fri, 27 Oct 2023 13:52:26 -0700
Message-Id: <20231027205227.855463-10-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027205227.855463-1-thinker.li@gmail.com>
References: <20231027205227.855463-1-thinker.li@gmail.com>
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
index 57d2114927e4..38f0611ee2f2 100644
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


