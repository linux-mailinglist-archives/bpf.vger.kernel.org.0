Return-Path: <bpf+bounces-39581-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 945659749F3
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 07:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B65028804B
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 05:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5117C7346F;
	Wed, 11 Sep 2024 05:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b="tMxauiXb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB172AE69
	for <bpf@vger.kernel.org>; Wed, 11 Sep 2024 05:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726033838; cv=none; b=nwmOxYb5+nv2YSYfX1CS/tkBZVeCQWtKQil0Hi1iYPzV2X7ZZoimXrn6ikszBcLjO4rM47KK3F0bbIOg5as9qcKhmuk6DAOtfDhSEW3lUl+akZiza+UuswSJYNugdIf++LYpqOuzOpLo0bmPDhaKy2qZc9DRKsAbtbx9v2UROvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726033838; c=relaxed/simple;
	bh=E6HcTi3QGCsCQ1lJap1BcOxIy+/sCKLlqk9XIhglA8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BISj+eL+RxlubBmsk6X2ryAtfpE+aGZJZJsv1/sjDvJ6ZaVMPJdUiVQn4+IoZareSUCPvk8kbYaYNGgfxAnLyHQ02Y3bgqLTqWk6Z5YBFfFsnOZHuksJmKkJDJhaB20PykoJ9TWvPfZ1aXBGjrYPzcV/jbFyL3TkYqAQMsSama0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=obs.cr; spf=none smtp.mailfrom=obs.cr; dkim=pass (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b=tMxauiXb; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=obs.cr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=obs.cr
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7a9af813f6cso317253685a.3
        for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 22:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20230601.gappssmtp.com; s=20230601; t=1726033835; x=1726638635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KKMHrpR5X9WXAcYhedLYlZ3oPCaG5UH+cdvsRKtIGFk=;
        b=tMxauiXbuxjYHcpKCwflY6L1PhhX9KXoFdj33lnYBIPrZ5Y9+IK1rhK1nLBXaADSgx
         Pw7onl2NgqiHPCgCvnFlp5u6KznI5YENuy32NBj0KCi4cbvSIOc/DyIZ0QsknlOvj2WX
         cMNfKFhPbp06ZkAu4tiYnoNWevsqGgoa7bawhXv6/0bP2LhYPeOzBAaO9DaGoIh0l5hg
         QJrIBu0J4jQUxKLZJdpgTJOWVrG9N1HyJapBWY6jEneDhw2htcbtYDHuAsbv4/YiB+oA
         cXj3JRY/BIGxXX0iSG5JrOLMy7aWhYfD1a6NL9UK9gPr2m16aI9TeNXPshDRaLxL/JWo
         Ik6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726033835; x=1726638635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KKMHrpR5X9WXAcYhedLYlZ3oPCaG5UH+cdvsRKtIGFk=;
        b=sjXQXXX/FxoxgB3n6BLy32R+EVdDBObUjL0ANmUQdq8uf+xnpQhFlNTb+nzeUa1sQ2
         qb6QpPKpzZgGyqzXahDWztHD/A204KvLtFssGcBZ5gPR5sXcq0O/NdZECZxs3H20MRsZ
         lCcxRtXQ4tVPJxeclblDjRquGWKCAdtp1LmKbjrUcOFfDbhK2oEArK+sIu4q7Ce1apS0
         HUF5APZDQk4Cf72wOusUx+lEufi8K6txDbuCpvHqiBvKq10PqAaFndz07D1J336cRTJH
         5r2voeZHSMFyk61ux7zg5K0ulGDQ9n/L1cUifw3aU8xwFWHB5cYfHuRHgHObrLUrSD25
         TGNA==
X-Gm-Message-State: AOJu0YyfwyQKNt13FgxpN1qwYhw927pAAAVIRtvTZZE8lJ1owLQLtGXJ
	hHrxxn5c1dS5TirO8pFjJ4PeBuCqD1tQM/CH86I2KIgR1PuGxnIgG3p2doBndHgI+j9ZBOxkeUz
	8
X-Google-Smtp-Source: AGHT+IH1+5WzwhvwUxARcN34XPKfWywXQLulDvz6VObaTDekveqtRbPPEVcL0Rs2wBbEp6fEEeMclA==
X-Received: by 2002:a05:620a:1996:b0:7a9:a63a:9f5e with SMTP id af79cd13be357-7a9a63aadbdmr2658262485a.41.1726033835371;
        Tue, 10 Sep 2024 22:50:35 -0700 (PDT)
Received: from ininer.rhod.uc.edu ([129.137.96.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a7a040dbsm378999185a.86.2024.09.10.22.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 22:50:35 -0700 (PDT)
From: Will Hawkins <hawkinsw@obs.cr>
To: bpf@vger.kernel.org,
	bpf@ietf.org
Cc: Will Hawkins <hawkinsw@obs.cr>
Subject: [PATCH v2] docs/bpf: Add constant values for linkages
Date: Wed, 11 Sep 2024 01:50:32 -0400
Message-ID: <20240911055033.2084881-1-hawkinsw@obs.cr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make the values of the symbolic constants that define the valid linkages
for functions and variables explicit.

Signed-off-by: Will Hawkins <hawkinsw@obs.cr>
---
    v1 -> v2:
      - Reformat to match style in BPF ISA document
      - Add information about BTF_VAR_GLOBAL_EXTERN

 Documentation/bpf/btf.rst | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index 257a7e1cdf5d..93060283b6fd 100644
--- a/Documentation/bpf/btf.rst
+++ b/Documentation/bpf/btf.rst
@@ -368,7 +368,7 @@ No additional type data follow ``btf_type``.
   * ``info.kind_flag``: 0
   * ``info.kind``: BTF_KIND_FUNC
   * ``info.vlen``: linkage information (BTF_FUNC_STATIC, BTF_FUNC_GLOBAL
-                   or BTF_FUNC_EXTERN)
+                   or BTF_FUNC_EXTERN - see :ref:`BTF_Function_Linkage_Constants`)
   * ``type``: a BTF_KIND_FUNC_PROTO type
 
 No additional type data follow ``btf_type``.
@@ -424,9 +424,8 @@ following data::
         __u32   linkage;
     };
 
-``struct btf_var`` encoding:
-  * ``linkage``: currently only static variable 0, or globally allocated
-                 variable in ELF sections 1
+``btf_var.linkage`` may take the values: BTF_VAR_STATIC, BTF_VAR_GLOBAL_ALLOCATED or BTF_VAR_GLOBAL_EXTERN -
+see :ref:`BTF_Var_Linkage_Constants`.
 
 Not all type of global variables are supported by LLVM at this point.
 The following is currently available:
@@ -549,6 +548,38 @@ The ``btf_enum64`` encoding:
 If the original enum value is signed and the size is less than 8,
 that value will be sign extended into 8 bytes.
 
+2.3 Constant Values
+-------------------
+
+.. _BTF_Function_Linkage_Constants:
+
+2.3.1 Function Linkage Constant Values
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+.. table:: Function Linkage Values and Meanings
+
+  ===================  =====  ===========
+  kind                 value  description
+  ===================  =====  ===========
+  ``BTF_FUNC_STATIC``  0x0    definition of subprogram not visible outside containing compilation unit
+  ``BTF_FUNC_GLOBAL``  0x1    definition of subprogram visible outside containing compilation unit
+  ``BTF_FUNC_EXTERN``  0x2    declaration of a subprogram whose definition is outside the containing compilation unit
+  ===================  =====  ===========
+
+
+.. _BTF_Var_Linkage_Constants:
+
+2.3.2 Variable Linkage Constant Values
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+.. table:: Variable Linkage Values and Meanings
+
+  ============================  =====  ===========
+  kind                          value  description
+  ============================  =====  ===========
+  ``BTF_VAR_STATIC``            0x0    definition of global variable not visible outside containing compilation unit
+  ``BTF_VAR_GLOBAL_ALLOCATED``  0x1    definition of global variable visible outside containing compilation unit
+  ``BTF_VAR_GLOBAL_EXTERN``     0x2    declaration of global variable whose definition is outside the containing compilation unit
+  ============================  =====  ===========
+
 3. BTF Kernel API
 =================
 
-- 
2.45.2


