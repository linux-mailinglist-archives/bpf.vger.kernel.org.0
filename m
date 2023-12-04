Return-Path: <bpf+bounces-16593-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D955803907
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 16:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B31FB20C09
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 15:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6FB2C872;
	Mon,  4 Dec 2023 15:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCmtGOdX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47997B6
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 07:39:30 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-4254adc1f1cso14762591cf.1
        for <bpf@vger.kernel.org>; Mon, 04 Dec 2023 07:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701704368; x=1702309168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EFUopMaGW2QmVRXuBuK+Ibv/Fn05quDhtUSDlsn2Imo=;
        b=SCmtGOdXa/xWT6V4IbX7mk/mp0T6L2cpllMNB8/yrT4B7hO4+Roz0AvUDUtR/y8Cbr
         r316gZfUYsdNCtorqI4sTPnV1rjXNifg3FyAu3s7nvgOZZCqo/YPTL4aEepeVsKE/gvL
         dKJB3L3ZG3FJx3sWOnb5Rlw2qvb3MCUhO+iLp8drD940R1Hr0ILADQHknBCc1nDiX21I
         OhCBE5GQAujylNIzlkZLCFCDBMBvo5zZageW2hpP/RpZfk+/3ldbxM0GAl7kiJz1gAB/
         IloCFYIdxeRhWCGw+Q4DNKheWxjnL4WATGZgnYetwNpvxM7pjuEVaRYawdLIEoFz0qv/
         bPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701704368; x=1702309168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EFUopMaGW2QmVRXuBuK+Ibv/Fn05quDhtUSDlsn2Imo=;
        b=kfGMK3Y9zgGlIB4QISdtl0dp8JXHRHlrsu2nee6K8TxYsxYXLLjnD4Ug/ShOC7ecz1
         Rp3ioGiq80aoQu01tWLmD+mHL8QtyjokoxvyLcB1SbPqNzPdUdsGYo2Qnj8Ka3Xrk0x7
         4c/PHd75LG+sRHQG4Xth1L1d81BILls4AKS6VRpw6wmHMTAUZmNlSqerVyB6jKII/Xtm
         jrU+NLxbtO2DakiHhgS9CjrNlLEWTjG/E/NblrAcHE972O/NtZVwFwXAaXWOosvlS53C
         sIeX3De1EQRQu5nUvfNyRgSrsfQMsczSlieXIJIMBQPLZNEi1KRPDQnSWV9cOR8qYeCI
         epbQ==
X-Gm-Message-State: AOJu0YxwvK/lND0451Y/1XNpBZGQgy4Bhc/uKy/Fll+1YsK0MDNnZsSA
	HKeeJmA8k67Cr73lylmojmy3OmvrrKEl1A==
X-Google-Smtp-Source: AGHT+IHQvEUdOsu857O2ysAivRm6VbwGFsFCPWJD+FlJV6bue712LJwN3vM7M51rcG5IOOsE5fdlGg==
X-Received: by 2002:a05:622a:4cc:b0:425:4043:5f33 with SMTP id q12-20020a05622a04cc00b0042540435f33mr6489919qtx.113.1701704368427;
        Mon, 04 Dec 2023 07:39:28 -0800 (PST)
Received: from andrei-framework.verizon.net ([2600:4041:599b:1100:332b:1ae7:497f:f030])
        by smtp.gmail.com with ESMTPSA id o26-20020ac86d1a000000b00423f1f9a76esm4387386qtt.38.2023.12.04.07.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 07:39:28 -0800 (PST)
From: Andrei Matei <andreimatei1@gmail.com>
To: bpf@vger.kernel.org
Cc: sunhao.th@gmail.com,
	andrii.nakryiko@gmail.com,
	Andrei Matei <andreimatei1@gmail.com>
Subject: [PATCH bpf V2 1/1] bpf: fix verification of indirect var-off stack access
Date: Mon,  4 Dec 2023 10:39:19 -0500
Message-Id: <20231204153919.11967-1-andreimatei1@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes a bug around the verification of possibly-zero-sized
stack accesses. When the access was done through a var-offset stack
pointer, check_stack_access_within_bounds was incorrectly computing the
maximum-offset of a zero-sized read to be the same as the register's min
offset. Instead, we have to take in account the register's maximum
possible value.

The bug was allowing accesses to erroneously pass the
check_stack_access_within_bounds() checks, only to later crash in
check_stack_range_initialized() when all the possibly-affected stack
slots are iterated (this time with a correct max offset).
check_stack_range_initialized() is relying on
check_stack_access_within_bounds() for its accesses to the
stack-tracking vector to be within bounds; in the case of zero-sized
accesses, we were essentially only verifying that the lowest possible
slot was within bounds. We would crash when the max-offset of the stack
pointer was >= 0 (which shouldn't pass verification, and hopefully is
not something anyone's code attempts to do in practice).

Thanks Hao for reporting!

Reported-by: Hao Sun <sunhao.th@gmail.com>
Fixes: 01f810ace9ed3 ("bpf: Allow variable-offset stack access")
Closes: https://lore.kernel.org/bpf/CACkBjsZGEUaRCHsmaX=h-efVogsRfK1FPxmkgb0Os_frnHiNdw@mail.gmail.com/
Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
---
 kernel/bpf/verifier.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index af2819d5c8ee..b646bdde09cd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6816,10 +6816,9 @@ static int check_stack_access_within_bounds(
 			return -EACCES;
 		}
 		min_off = reg->smin_value + off;
+		max_off = reg->smax_value + off;
 		if (access_size > 0)
-			max_off = reg->smax_value + off + access_size - 1;
-		else
-			max_off = min_off;
+			max_off += access_size - 1;
 	}
 
 	err = check_stack_slot_within_bounds(min_off, state, type);
-- 
2.40.1


