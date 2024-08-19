Return-Path: <bpf+bounces-37550-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A41B5957773
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 00:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1BFCB21B1D
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 22:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1961DD3BE;
	Mon, 19 Aug 2024 22:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b="xgtwyG9s"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204091DD3AE
	for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 22:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724106613; cv=none; b=GjhYNFkp7NNT0s0KytUp+I3Hi4BvAPCtS1VOe6W9TCVs4Xjv7hbg5ht5HJAB0iqJcpbE1teQy2ezYWtqCIKjkBNmdr32bRZ3tPa9isCTCMglFXheMmYcP+33pKRI1FVYoknUe/kPJaE4YVKaSash00LV7bEax4CX/zmPGUO3ilY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724106613; c=relaxed/simple;
	bh=WxJvpJWmn+n55gzSFW7Z7omb+ZRGuqCH2HJpCqZQyD0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NDjtwKM+FWRZmXtvCQ7jPMAno98onG9aMDhKCLbhBWUC5k9PmnegCYDFHOM4jeHpSncTb8S06ViNgjtQN96D8YuEEVayrT8unAZmwbw8DHeDRAczGUz9EBqUa9izvQNqUmk2FhudDeXD31mLd/Bl1s/3aoqlr97IBG2MfjQqXc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=obs.cr; spf=none smtp.mailfrom=obs.cr; dkim=pass (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b=xgtwyG9s; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=obs.cr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=obs.cr
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-39d47a9ffb9so7948115ab.1
        for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 15:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20230601.gappssmtp.com; s=20230601; t=1724106611; x=1724711411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zlBO7op9yV0iOsawm3E4xQTL5C6nZ1QNeejEc0p0YVM=;
        b=xgtwyG9sgbBO1Z3L9ngSt0qIr14L3ImzupMMbWAgxvfkem5gK1SRsYFjHU7IDGkCmt
         GmDX16anIBW8IUvAAgSbN2a3tOVOWPMhdimEO8zqbmIol+3PNIX5hzDUspcXXN/XPz5J
         wui11xJx6a5xq1NtcbbiqCDMtOnHiofygLL/OehAo9gcBnS3y/NApoLOYG1mb8FcrrnA
         KZ97RMCnyiwYgsYTsKzCZiszmJghkTtiL6k2LlVMsaiqZUusX4c9rzSOW23TAXIXs5ZJ
         Y0mJnI1tksCOILKFG3GVI0vzSMr4Zh3uKnLeRbOVCOTy1TGm1Ny7NGJKvgJRauAeC/lX
         4bcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724106611; x=1724711411;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zlBO7op9yV0iOsawm3E4xQTL5C6nZ1QNeejEc0p0YVM=;
        b=ZYe4cEVBKgyO6BqcUKXENrrkDC0zr/FxrDllMCT0Xg/kOyXhL2romytGQkcECRxyom
         us0PE2sFP4Drod8Ftmmhh4eW4yHjDxA72J/ManTRRc6W0HtPKCW0Mp3pwfWP4/ujISlq
         yUEYdi3eE8r0KGVm8tzlHLYREcalsLO8Io/xsvZyiDzjfTdK0uoOeUiB8XisMvSHQ2No
         5PwFOvw42mEE3NsDwCUCSLwfB2InR54BHw+jOb3hz3pDbGL3G4+Qs7uQcvlF1vdvJCBs
         Fwsw9qw3P28qIPh0/Io3X/aeRxb5OjcrIed/uJOV8slkEDyH83mKYOWtbTgcphIhUt1X
         xrRA==
X-Gm-Message-State: AOJu0YwF9zC8HR/VhlrnOof5jzCA0aT+hvlz8xn6Ufelc9/pUhX0M0yg
	8AgsbZJxf5SuSE1O6GE2oI3lypXtr/0ha2rLmn8INV0i1hEJmgPsUdsNCJ8qktVoTNOHwlYiAh6
	q
X-Google-Smtp-Source: AGHT+IHmnzdQB1KFZi18yDin1p4609NZfm5womPqkarl0qMMm62alm/L7gBbuedvrFFFA4ECQ5e2eg==
X-Received: by 2002:a05:6e02:1d8e:b0:39d:189a:edf6 with SMTP id e9e14a558f8ab-39d26d64478mr107657435ab.22.1724106610652;
        Mon, 19 Aug 2024 15:30:10 -0700 (PDT)
Received: from ininer.rhod.uc.edu ([129.137.96.15])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39d1ec03069sm37092255ab.32.2024.08.19.15.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 15:30:10 -0700 (PDT)
From: Will Hawkins <hawkinsw@obs.cr>
To: bpf@vger.kernel.org,
	bpf@ietf.org
Cc: Will Hawkins <hawkinsw@obs.cr>
Subject: [PATCH] docs/bpf: Add constant values for linkages
Date: Mon, 19 Aug 2024 18:30:06 -0400
Message-ID: <20240819223008.469271-1-hawkinsw@obs.cr>
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
 Documentation/bpf/btf.rst | 44 +++++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index 257a7e1cdf5d..cce03f1e552a 100644
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
@@ -424,9 +424,9 @@ following data::
         __u32   linkage;
     };
 
-``struct btf_var`` encoding:
-  * ``linkage``: currently only static variable 0, or globally allocated
-                 variable in ELF sections 1
+``btf_var.linkage`` may take the values: BTF_VAR_STATIC (for a static variable),
+or BTF_VAR_GLOBAL_ALLOCATED (for a globally allocated variable stored in ELF sections 1) -
+see :ref:`BTF_Var_Linkage_Constants`.
 
 Not all type of global variables are supported by LLVM at this point.
 The following is currently available:
@@ -549,6 +549,42 @@ The ``btf_enum64`` encoding:
 If the original enum value is signed and the size is less than 8,
 that value will be sign extended into 8 bytes.
 
+2.3 Constant Values
+-------------------
+
+.. _BTF_Function_Linkage_Constants:
+
+2.3.1 Function Linkage Constant Values
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+.. list-table::
+   :widths: 1 1
+   :header-rows: 1
+
+   * - Name
+     - Value
+   * - ``BTF_FUNC_STATIC``
+     - ``0``
+   * - ``BTF_FUNC_GLOBAL``
+     - ``1``
+   * - ``BTF_FUNC_EXTERN``
+     - ``2``
+
+.. _BTF_Var_Linkage_Constants:
+
+2.3.2 Variable Linkage Constant Values
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+.. list-table::
+   :widths: 1 1
+   :header-rows: 1
+
+   * - Name
+     - Value
+   * - ``BTF_VAR_STATIC``
+     - ``0``
+   * - ``BTF_VAR_GLOBAL_ALLOCATED``
+     - ``1``
+
+
 3. BTF Kernel API
 =================
 
-- 
2.45.2


