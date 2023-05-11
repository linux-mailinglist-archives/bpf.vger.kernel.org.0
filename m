Return-Path: <bpf+bounces-335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A04B6FF424
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 16:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA2E328178B
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 14:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2531D2B5;
	Thu, 11 May 2023 14:26:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E121F922
	for <bpf@vger.kernel.org>; Thu, 11 May 2023 14:26:44 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6897440E3;
	Thu, 11 May 2023 07:26:34 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9659c5b14d8so1430115666b.3;
        Thu, 11 May 2023 07:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1683815193; x=1686407193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VtnLQFC3gXKN18su7z8CdgFlcJ7YFC5IMpgUUhV6x+s=;
        b=odR9I3ZdlQySSrmNFXoB6k5sPZrNpWKh4/Y3cgy7V+hTnDwQ2U7nRTFcMk6eIRXPWH
         zvDAoYwk4T9Jlf9igEiUD77UETuhyS2fUf1IMAptXXC4RXCQxUk8dKu625kbiDy7vzFS
         x2SC3oRk34/JZ/OH/mU7wwmykBJsq7ei2kebFWo6qyZgMVgEkyqeXdttwAT3mbQ1Bkpo
         lATUda+9JDgXZG0+sDbBtsdOtBfilMry3M+V3HTBRiogJ+HGNg5/7T+shxnESaQZECHI
         HFDdZJbg6D2Si66ia4hS+LOe+3FzusmXTEemEyzvefQAbbXXOdyOr2AX4gpJzUgUlpL3
         XETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683815193; x=1686407193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VtnLQFC3gXKN18su7z8CdgFlcJ7YFC5IMpgUUhV6x+s=;
        b=iKxiV1R6b+IH5ZgI8rpPt34PnMBqvr4MKhFwUS16HrXanvwadAu3YZdzGt9pZGhsJd
         65jbMW+xaDf04jrMcmiBdhbQC4oaqvmT7DWIORhGzklarHB3aDmW4B44an/+II2905W3
         XrslIPxVSfwJZ1Dg5HWwHBVcQ3sCSjY09wszHcz13FD2MrBev/P+UMmcsq1soBy2BAko
         y/vbJPWeJTEaYgrXKGqaGKd/PBSUvkszQwXgWHkLQQe9cT3ia8d7xV4uarB/Q+guRwec
         gcjfi1ExcZQrMbrid43PvMirOjBBy7BCgPCZ/trSMqpxCDMViQGgGN+1l6PwwIEjvDaI
         Oykg==
X-Gm-Message-State: AC+VfDwnGPMXzsBp3+Of4Cef9jJ8rGdbHeWrx2x6XBaSF3fLGjthdPbv
	BbACpt5Ngb5n4mqfevOZOELACpolLjiuSg==
X-Google-Smtp-Source: ACHHUZ76zRw/n3CXINb3Kxob9YX9dRNiUQZNHbToS6sPNTsKtr/pbSnRHh2+lOTYP0thZbDfVbgcxw==
X-Received: by 2002:a17:906:4fd1:b0:94f:21f3:b5f8 with SMTP id i17-20020a1709064fd100b0094f21f3b5f8mr19432094ejw.21.1683815192723;
        Thu, 11 May 2023 07:26:32 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-008-180-228.77.8.pool.telefonica.de. [77.8.180.228])
        by smtp.gmail.com with ESMTPSA id hf15-20020a1709072c4f00b0094f58a85bc5sm4056647ejc.180.2023.05.11.07.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 07:26:32 -0700 (PDT)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Cc: Serge Hallyn <serge@hallyn.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v4 3/9] capability: use new capable_any functionality
Date: Thu, 11 May 2023 16:25:26 +0200
Message-Id: <20230511142535.732324-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230511142535.732324-1-cgzones@googlemail.com>
References: <20230511142535.732324-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use the new added capable_any function in appropriate cases, where a
task is required to have any of two capabilities.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v3:
  - rename to capable_any()
  - simplify checkpoint_restore_ns_capable()
---
 include/linux/capability.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index eeb958440656..4db0ffb47271 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -204,18 +204,17 @@ extern bool file_ns_capable(const struct file *file, struct user_namespace *ns,
 extern bool ptracer_capable(struct task_struct *tsk, struct user_namespace *ns);
 static inline bool perfmon_capable(void)
 {
-	return capable(CAP_PERFMON) || capable(CAP_SYS_ADMIN);
+	return capable_any(CAP_PERFMON, CAP_SYS_ADMIN);
 }
 
 static inline bool bpf_capable(void)
 {
-	return capable(CAP_BPF) || capable(CAP_SYS_ADMIN);
+	return capable_any(CAP_BPF, CAP_SYS_ADMIN);
 }
 
 static inline bool checkpoint_restore_ns_capable(struct user_namespace *ns)
 {
-	return ns_capable(ns, CAP_CHECKPOINT_RESTORE) ||
-		ns_capable(ns, CAP_SYS_ADMIN);
+	return ns_capable_any(ns, CAP_CHECKPOINT_RESTORE, CAP_SYS_ADMIN);
 }
 
 /* audit system wants to get cap info from files as well */
-- 
2.40.1


