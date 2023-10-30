Return-Path: <bpf+bounces-13630-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 478F97DC07F
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 20:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 766A71C20B9E
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 19:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E651A28E;
	Mon, 30 Oct 2023 19:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgubZNIZ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491621A5AB
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 19:28:29 +0000 (UTC)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2121DD3
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 12:28:28 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5a7d9d357faso46419757b3.0
        for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 12:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698694107; x=1699298907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lE1uZj4yB64LVf3tuGGiFEv3sigOnkQmS1o9s8kkNJ0=;
        b=CgubZNIZZBaEEMwrMlZNrTnDbQqGUFeSy+nt/HSUI9hIdabsZ1sQdG8/J9LHIRHXb+
         XFGjgSN5HozCPWk/EPfMf820uWB02OBhN6TCSSiGYQbkSfrKDo9EPPKBZW8go11myItf
         oOVplQAEcsbciCQ96A9Neb/9kiRIhQ/2SQEv3nkHhRMrQM3Gjusqgc+pHv57oY2iTuyX
         XbWhUO5P6C9ilXzdwknCLUjoQ/x+AmslfMb4InJHaOP6MEeQNvoHvKkHMYeCVjTap05e
         OgCoh14wYAuTZqxXbXNnbfVGVJ83tNrtfgEsbXxRPio2n1e+whSIbBZoLVPqzf0VwUt6
         0lLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698694107; x=1699298907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lE1uZj4yB64LVf3tuGGiFEv3sigOnkQmS1o9s8kkNJ0=;
        b=nwDZqA7hw8WW9V/iT/Qh8KaSxjj3jqJ1Q3svbVKYH5BGLsUS9LWHNPme0smDcquCI1
         8252lDdYi76iAvDicpf8Stgs3+Jzf7wVnClBgue79BdJ4uaddRTb+BvIqxKApQfat86T
         iTA5Y1+Q5nUjbhTC5+keKNuuQA0BJkL2lOo6zf305vjUhidkBrEYjvma5AxzZ3eOFtiP
         8DzHgwN4th1RkjyS/+Py8yu4pWFBIWFJo9Fff1EfUv7KT4Bd9fWc7UDpGYyX2XS8obF1
         J4rHDObSumZdyxNWM8VXFIdClsUpN31oiwZ40MbvyUkm4t/fg/RaFqCu6sDXfpImkBKB
         fTWQ==
X-Gm-Message-State: AOJu0YywDs48phBj9xrzCxxq/1yQLK3itjfIKjvFE3SVRVRDoFMTufYh
	2NE9yGfSO+1etHjom1TsmhJToNrLshA=
X-Google-Smtp-Source: AGHT+IGLwCTPeain7chatOLvUTaiMdaP94ja6SzeD9XkMa5Rv+9p7ylbpDolVPZ+OHWDIMRNC1FIdg==
X-Received: by 2002:a0d:ec4e:0:b0:5a8:28d6:4d08 with SMTP id r14-20020a0dec4e000000b005a828d64d08mr9765777ywn.17.1698694107079;
        Mon, 30 Oct 2023 12:28:27 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:5b04:e8d1:ce5:8164])
        by smtp.gmail.com with ESMTPSA id n12-20020a819c4c000000b005b03d703564sm35821ywa.137.2023.10.30.12.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 12:28:26 -0700 (PDT)
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
Subject: [PATCH bpf-next v8 09/10] bpf: export btf_ctx_access to modules.
Date: Mon, 30 Oct 2023 12:28:09 -0700
Message-Id: <20231030192810.382942-10-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030192810.382942-1-thinker.li@gmail.com>
References: <20231030192810.382942-1-thinker.li@gmail.com>
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


