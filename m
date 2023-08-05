Return-Path: <bpf+bounces-7067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A69A3770D69
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 05:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61B172821B9
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 03:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0384F1864;
	Sat,  5 Aug 2023 03:09:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A911851
	for <bpf@vger.kernel.org>; Sat,  5 Aug 2023 03:09:53 +0000 (UTC)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F315E4EFF
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 20:09:30 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-63d23473ed5so16198986d6.1
        for <bpf@vger.kernel.org>; Fri, 04 Aug 2023 20:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1691204970; x=1691809770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amt6f6/FgCcgvOgQNxpLD0P8oG8ReutuJ8nyhf1LrBE=;
        b=tXHlw2yJ+8k/V/OAWXj9OHXpcPCetNaBoqcYqfOE+b5I+3DrpWxH99dEzEF3lZ1I5P
         qnksgKijML7LccpwMcByUPu1KhgHlUJHDf2VbTCjOYZRAKG+yfSyNqalv/Vhsm6ABJE6
         PjNBHkhTQ9dCHgynl0aBkafnBq0bnvBkGbiphVGnrzFa243UIGoCTK6vrnuyfwPkYSIs
         4drIkkqyo365+kibMB1X469/CfzlCYMQYuZv1rJ9VhU6a1hbk0QmlREgvGk+P1dYFpMe
         0UTUygxfJiLjgu9LgxsVYSuCqUXM6O2nW0bi6ZPop+N8MlHgOHdTYh2JjOATPMkkCA8T
         nwDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691204970; x=1691809770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=amt6f6/FgCcgvOgQNxpLD0P8oG8ReutuJ8nyhf1LrBE=;
        b=cK01ucT2cp8qI0UYo1juhbpKFJapLJadD2bKIdN57C8ZdHh+c1V1sk97dZ500IbIj1
         gu7xgiw2Vjn9DCl/g413LAUg3nLOZCnsfWQbB6JolDhUXx1Ad41T3Hk3cV/yygcG3qAm
         uZ0ifIf5zbQghLiyrgxffE9BrY/AaX8sHQGzGi3NKayRhx/DN6+YpevCRCyean8/MUA9
         0z9mi9bog00wHTi2IpxynCTFNYK9iTwinjaYeGuwJBEDiiW+c6AlrAZZ+vXn4p6H4fT5
         QtS/3XoT4YCb52mNMXLGhQYG//fwDONfWP/g7gWhstO5JNDkmasKKCG8ZzhnCvmVJB8c
         M9zw==
X-Gm-Message-State: AOJu0YwwGQ6++/E0gd+xt8M/r/g+C2YZgDXf+7jp1/KoEgNFvIqrgQIw
	SdQ1jvfAf+PSP/yPf/fbar5nPMpxq+ikdc/3keI=
X-Google-Smtp-Source: AGHT+IE1pg65MnSF3gWfkSMHnSrm5658vv5iU6p7qtqY4H7dqd90NDxjyNxtzlak+tyFqnZSS8HZGQ==
X-Received: by 2002:ad4:4506:0:b0:62d:fe06:3e17 with SMTP id k6-20020ad44506000000b0062dfe063e17mr3611044qvu.22.1691204969880;
        Fri, 04 Aug 2023 20:09:29 -0700 (PDT)
Received: from borderland.rhod.uc.edu ([129.137.96.2])
        by smtp.gmail.com with ESMTPSA id k20-20020a0cf594000000b0063cbb29731dsm1124501qvm.66.2023.08.04.20.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 20:09:29 -0700 (PDT)
From: Will Hawkins <hawkinsw@obs.cr>
To: bpf@vger.kernel.org,
	bpf@ietf.org
Cc: Will Hawkins <hawkinsw@obs.cr>
Subject: [PATCH v3 2/2] bpf, docs: Fix small typo and define semantics of sign extension
Date: Fri,  4 Aug 2023 23:09:19 -0400
Message-ID: <20230805030921.52035-2-hawkinsw@obs.cr>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230805030921.52035-1-hawkinsw@obs.cr>
References: <20230805030921.52035-1-hawkinsw@obs.cr>
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

Signed-off-by: Will Hawkins <hawkinsw@obs.cr>
---
 .../bpf/standardization/instruction-set.rst   | 31 ++++++++++++++++---
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
index fe296f35e5a7..6f3b34ef7b7c 100644
--- a/Documentation/bpf/standardization/instruction-set.rst
+++ b/Documentation/bpf/standardization/instruction-set.rst
@@ -73,6 +73,27 @@ Functions
   format and returns the equivalent number with the same bit width but
   opposite endianness.
 
+
+Definitions
+-----------
+
+.. glossary::
+
+  Sign Extend
+    To `sign extend an` ``X`` `-bit number, A, to a` ``Y`` `-bit number, B  ,` means to
+
+    #. Copy all ``X`` bits from `A` to the lower ``X`` bits of `B`.
+    #. Set the value of the remaining ``Y`` - ``X`` bits of `B` to the value of
+       the  most-significant bit of `A`.
+
+.. admonition:: Example
+
+  Sign extend an 8-bit number ``A`` to a 16-bit number ``B`` on a big-endian platform:
+  ::
+
+    A:          10000110
+    B: 11111111 10000110
+
 Registers and calling convention
 ================================
 
@@ -263,17 +284,17 @@ where '(u32)' indicates that the upper 32 bits are zeroed.
 Note that most instructions have instruction offset of 0. Only three instructions
 (``BPF_SDIV``, ``BPF_SMOD``, ``BPF_MOVSX``) have a non-zero offset.
 
-The devision and modulo operations support both unsigned and signed flavors.
+The division and modulo operations support both unsigned and signed flavors.
 
 For unsigned operations (``BPF_DIV`` and ``BPF_MOD``), for ``BPF_ALU``,
 'imm' is interpreted as a 32-bit unsigned value. For ``BPF_ALU64``,
-'imm' is first sign extended from 32 to 64 bits, and then interpreted as
-a 64-bit unsigned value.
+'imm' is first :term:`sign extended<Sign Extend>` from 32 to 64 bits, and then
+interpreted as a 64-bit unsigned value.
 
 For signed operations (``BPF_SDIV`` and ``BPF_SMOD``), for ``BPF_ALU``,
 'imm' is interpreted as a 32-bit signed value. For ``BPF_ALU64``, 'imm'
-is first sign extended from 32 to 64 bits, and then interpreted as a
-64-bit signed value.
+is first :term:`sign extended<Sign Extend>` from 32 to 64 bits, and then
+interpreted as a 64-bit signed value.
 
 The ``BPF_MOVSX`` instruction does a move operation with sign extension.
 ``BPF_ALU | BPF_MOVSX`` sign extends 8-bit and 16-bit operands into 32
-- 
2.41.0


