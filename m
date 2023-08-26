Return-Path: <bpf+bounces-8736-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 767CB7893F0
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 07:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FA672819ED
	for <lists+bpf@lfdr.de>; Sat, 26 Aug 2023 05:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C4A819;
	Sat, 26 Aug 2023 05:33:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519E862E
	for <bpf@vger.kernel.org>; Sat, 26 Aug 2023 05:33:31 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EF82691
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 22:33:28 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id E8DEDC1526F7
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 22:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1693028007; bh=6hjMO+nUCZwXymE01LiSLKU1s825qoLG3yKPRt6b/3U=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe;
	b=mliPC9w3JECacRlJAQVeJ2rE/6QOEMpBIY0yDNz0fq5tFOG67gOpGo18tFI+6lopC
	 4r+RCK8Ee8p/FeLh7gah5rKphRrY+gmocHx2T+xHAP5/AobvW+9cUKBTPiG41kxqtZ
	 YNFKiozyCoRdYryVr/DKLNQ5k8RC9wOJOHiAXuj8=
X-Mailbox-Line: From bpf-bounces@ietf.org  Fri Aug 25 22:33:27 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id A9791C151985;
	Fri, 25 Aug 2023 22:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1693028007; bh=6hjMO+nUCZwXymE01LiSLKU1s825qoLG3yKPRt6b/3U=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe;
	b=mliPC9w3JECacRlJAQVeJ2rE/6QOEMpBIY0yDNz0fq5tFOG67gOpGo18tFI+6lopC
	 4r+RCK8Ee8p/FeLh7gah5rKphRrY+gmocHx2T+xHAP5/AobvW+9cUKBTPiG41kxqtZ
	 YNFKiozyCoRdYryVr/DKLNQ5k8RC9wOJOHiAXuj8=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id DBC1FC151085
 for <bpf@ietfa.amsl.com>; Fri, 25 Aug 2023 22:33:26 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -1.907
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=obs-cr.20221208.gappssmtp.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Gc9ppK0v6AxB for <bpf@ietfa.amsl.com>;
 Fri, 25 Aug 2023 22:33:24 -0700 (PDT)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id B31B9C151985
 for <bpf@ietf.org>; Fri, 25 Aug 2023 22:33:19 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-64ccdf8820dso7566306d6.1
 for <bpf@ietf.org>; Fri, 25 Aug 2023 22:33:19 -0700 (PDT)
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
 b=kX295f3LKMhgEAweUEIbVdYh1Z37i6O7uRtjLho/8/4C2pr5fkyrpThu/8DxP25NCz
 DS1Bpfc3lYUzN2BPWsEQuDX9OJU9r3x5EXfuRrvxYj9KUpeQtAIDrfvEJMXrZEnARiWf
 m7WG2wjm6PzfkUecZ2qxiIthDsHEcD1Q7zx4Ax0t/4nzk5QAUnNWw6BIpoybLYpB1sw9
 Hspl/aFl7LEAMqh2wnMiyJr5f9a41JjhlNQyTMyabycjavmeg+6I9ReJ8Y4Wdm+VzXj/
 P8HC9doDGmHAkzxJm1WSrl+DzXlOMjQvFRCexzr/QYC/R2ripyKFM9p82oqWQG50uUsB
 RYzQ==
X-Gm-Message-State: AOJu0Yxx3nnOIKlBkMONnVY4NrFhhFxtEbAri9g5mKHQhzWkC3PVlzYh
 puXu9NAr5Wy9+ZhGtXDFro37dw==
X-Google-Smtp-Source: AGHT+IHs/AjVRWPSAemAeYdpRvSBGayaFsGzxnb3sD3GrlYAfhTt3diiyzdnJ4Ed4CoWpm0sji9UVw==
X-Received: by 2002:ad4:4eaa:0:b0:63d:753:fc4 with SMTP id
 ed10-20020ad44eaa000000b0063d07530fc4mr31134524qvb.4.1693027998327; 
 Fri, 25 Aug 2023 22:33:18 -0700 (PDT)
Received: from borderland.rhod.uc.edu ([129.137.96.2])
 by smtp.gmail.com with ESMTPSA id
 d14-20020a0cf0ce000000b006472e0dfe80sm1024785qvl.66.2023.08.25.22.33.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 22:33:17 -0700 (PDT)
From: Will Hawkins <hawkinsw@obs.cr>
To: bpf@vger.kernel.org,
	bpf@ietf.org
Cc: Will Hawkins <hawkinsw@obs.cr>
Date: Sat, 26 Aug 2023 01:32:54 -0400
Message-ID: <20230826053258.1860167-1-hawkinsw@obs.cr>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/uMwucO4gjaIP-Pr3CR8UQOVjXew>
Subject: [Bpf] [PATCH] bpf,
 docs: Correct source of offset for program-local call
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: Discussion of BPF/eBPF standardization efforts within the IETF
 <bpf.ietf.org>
List-Unsubscribe: <https://www.ietf.org/mailman/options/bpf>,
 <mailto:bpf-request@ietf.org?subject=unsubscribe>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Subscribe: <https://www.ietf.org/mailman/listinfo/bpf>,
 <mailto:bpf-request@ietf.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
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

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

