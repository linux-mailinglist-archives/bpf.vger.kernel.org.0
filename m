Return-Path: <bpf+bounces-8735-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 572187893EF
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 07:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F30F72819DC
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 05:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8681C819;
	Sat, 26 Aug 2023 05:33:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0D362E
	for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 05:33:20 +0000 (UTC)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0AE268F
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 22:33:19 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-64f37b2dfa6so12268806d6.1
        for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 22:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1693027998; x=1693632798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aBvX3jM1LpE0z2FXJDrZB4Q0zxyGLGKJVvTBcTTxD/c=;
        b=IgrSEW5RjO1zCulE14HFormjPD6gBWlmwEIW/dXid/UkRq1qcD05l8qIzEjlTZZSQH
         nB40SF0ea2vHemdqvpzb+DOd1SlIpnFrqUmQpgXpVuGIrVNPv8QbgU6BHXMbufKz44zN
         eUyEZ848mfhztQdfxY3WgYaPCq6KJREIBQOc+PWo4LZoJ8nU86Nw5JTQ1clZJwYSQxcX
         6HzedyNmsOqpmGQQkoSYzPM33VMsR3kNbEQtDSGvpg0REYpXlk7nD0nnA+CAfGPDuBc2
         Hs0+PWEB0OJHAenVvqm6p2muBMqR6UmsocAegPuk8aLJo75rgAsS+3SBk9F1g9MDo9kZ
         l5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693027998; x=1693632798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aBvX3jM1LpE0z2FXJDrZB4Q0zxyGLGKJVvTBcTTxD/c=;
        b=dumQhWop7sWyYarWWdLkpwBj36nVsx1xFoBC2EU8GSFb4+GSyiTGsk8xfjPzwtmP6e
         /jzhpj/0iCi+x8ar31ezGZk/fue4DVpADi9VrM4S1LinmuL2dGchWOPxCL7koNhqbfF9
         LrzFxM1H7wst+DlWllt6o7Yw1ZBWhhx6rOKZBpg9w+qXmxVOLDT/oxlWvcY5YYd9/S53
         2kjlButfIRbj5FD2nnay/HwY5LMfSzYSeonOxMiBp9gQnCzw/K5p/pm93TbYBqG7Qo5B
         bzZ8sOEuszE22hqc+RQiNiPbwzcwrYQvPwxYsxFgOTwZVyWhk1WDj4yFngzUeMXJZPNx
         Pw6w==
X-Gm-Message-State: AOJu0YyblBI/tIxZDiRHdKF7hNQQ1rEuODEd81s8fSGBJXlivKa/4hrR
	XvGaq4v3phParDNP6iIP9U/X955rZ/l8ck/9JIc=
X-Google-Smtp-Source: AGHT+IHs/AjVRWPSAemAeYdpRvSBGayaFsGzxnb3sD3GrlYAfhTt3diiyzdnJ4Ed4CoWpm0sji9UVw==
X-Received: by 2002:ad4:4eaa:0:b0:63d:753:fc4 with SMTP id ed10-20020ad44eaa000000b0063d07530fc4mr31134524qvb.4.1693027998327;
        Fri, 25 Aug 2023 22:33:18 -0700 (PDT)
Received: from borderland.rhod.uc.edu ([129.137.96.2])
        by smtp.gmail.com with ESMTPSA id d14-20020a0cf0ce000000b006472e0dfe80sm1024785qvl.66.2023.08.25.22.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 22:33:17 -0700 (PDT)
From: Will Hawkins <hawkinsw@obs.cr>
To: bpf@vger.kernel.org,
	bpf@ietf.org
Cc: Will Hawkins <hawkinsw@obs.cr>
Subject: [PATCH] bpf, docs: Correct source of offset for program-local call
Date: Sat, 26 Aug 2023 01:32:54 -0400
Message-ID: <20230826053258.1860167-1-hawkinsw@obs.cr>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The offset to use when calculating the target of a program-local call is
in the instruction's imm field, not its offset field.

Signed-off-by: Will Hawkins <hawkinsw@obs.cr>
---
 Documentation/bpf/standardization/instruction-set.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index 4f73e9dc8d9e..c5b0b2011f16 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -373,7 +373,7 @@ BPF_JNE   0x5    any  PC += offset if dst != src
 BPF_JSGT  0x6    any  PC += offset if dst > src                    signed
 BPF_JSGE  0x7    any  PC += offset if dst >= src                   signed
 BPF_CALL  0x8    0x0  call helper function by address              see `Helper functions`_
-BPF_CALL  0x8    0x1  call PC += offset                            see `Program-local functions`_
+BPF_CALL  0x8    0x1  call PC += imm                               see `Program-local functions`_
 BPF_CALL  0x8    0x2  call helper function by BTF ID               see `Helper functions`_
 BPF_EXIT  0x9    0x0  return                                       BPF_JMP only
 BPF_JLT   0xa    any  PC += offset if dst < src                    unsigned
@@ -424,8 +424,8 @@ Program-local functions
 ~~~~~~~~~~~~~~~~~~~~~~~
 Program-local functions are functions exposed by the same BPF program as the
 caller, and are referenced by offset from the call instruction, similar to
-``BPF_JA``.  A ``BPF_EXIT`` within the program-local function will return to
-the caller.
+``BPF_JA``.  The offset is encoded in the imm field of the call instruction.
+A ``BPF_EXIT`` within the program-local function will return to the caller.
 
 Load and store instructions
 ===========================
-- 
2.41.0


