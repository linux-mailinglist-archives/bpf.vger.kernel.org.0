Return-Path: <bpf+bounces-16985-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B5D807F6F
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 05:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEE81B20EAC
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 04:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667B35694;
	Thu,  7 Dec 2023 04:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ku5hG8Mk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0190AD5C
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 20:12:15 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-67acdcb3ccdso3606196d6.1
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 20:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701922334; x=1702527134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plujwPOWwzBNVBTx6fQ8sSzojYinlDykJ3bgicn6ZrA=;
        b=Ku5hG8MkpFPEpzrZRpuayyzxBBFPoksK8sVGqlwpetmJklKWoKkAh+jcgK8ufEUw5z
         JDcSxpyZtM+WEdl9zAdzNKRDxvvSKhstPWm9Tm+fv1ZxTPlsIj+YjuRqQMyPAJ6TZEL7
         79CbZev+vgauQgFLYQPSMOKkVhb7lJYmsaF5Ovy7BNinPOwpLZms+0WyYsl2FXQK/FEB
         PBK6ZpKfBN+jdLGSnmv0a3RQ6tchxy1OWe4wuGxdJkmtbddSo9D+0vq0wt+Gd0yCl69F
         Dw+wi7yJmJHkTpeUJMHp7VHvNIrZb+I98/pyYTboic5Sz9Zp65c+qB9m/JOOkRSyK8dX
         jSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701922334; x=1702527134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=plujwPOWwzBNVBTx6fQ8sSzojYinlDykJ3bgicn6ZrA=;
        b=TVenxlTh7k8fXpcmTVxOrL/D1U4BHQyzmk7mR6FeXdYI+AnNaTjzODwb55vNYOg94M
         TmfktIIRhPk9SibZdnOKZsfhsV7ewklxnwnJJ9pe7tMytLZQmzGtgIQuV/PXzlnIVAwT
         c3dGSisFXa9NmR0RO/GERoxg3pP9ygov/HZ/Jbn02iNr1NWL/vK1mASY6wCGcG2G1pDr
         pXJGziziI1i6KFIy60GQ6s9CFl4FbwHMYy8Oa/Wz9Acnvx0E6jaF6SqBMLykYKmXdBDf
         h4AS/dVDRw2lPyzIOQKy2tmKNhW05SmW1u77ZcT/e7MS6vizA0rtkM4OJMdJczWN0wmG
         E4Yg==
X-Gm-Message-State: AOJu0YyJMxaxdqlzPhaIwhRnT4iQ2baPHA+lvnllry0g7PpR8tg0gkAc
	oSjIOIDd8+W4P3YVwtejmOZ4WguETaNTFQ==
X-Google-Smtp-Source: AGHT+IH1/Vb9Yrt9/G1wWmDQwnFML6U2Hj55bXe8tQ6gAVWnifeld/AfPrZjAEVEGne8Q4Vv0Sv+eg==
X-Received: by 2002:a05:6214:511:b0:67a:97ec:7426 with SMTP id px17-20020a056214051100b0067a97ec7426mr2239112qvb.42.1701922333679;
        Wed, 06 Dec 2023 20:12:13 -0800 (PST)
Received: from andrei-framework.verizon.net ([2600:4041:599b:1100:225d:9ebb:8c9b:7326])
        by smtp.gmail.com with ESMTPSA id o6-20020a056214108600b0066cf4fa7b47sm172808qvr.4.2023.12.06.20.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 20:12:13 -0800 (PST)
From: Andrei Matei <andreimatei1@gmail.com>
To: bpf@vger.kernel.org
Cc: sunhao.th@gmail.com,
	andrii.nakryiko@gmail.com,
	eddyz87@gmail.com,
	Andrei Matei <andreimatei1@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v5 1/3] bpf: fix verification of indirect var-off stack access
Date: Wed,  6 Dec 2023 23:11:48 -0500
Message-Id: <20231207041150.229139-2-andreimatei1@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231207041150.229139-1-andreimatei1@gmail.com>
References: <20231207041150.229139-1-andreimatei1@gmail.com>
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
possible value. The patch also simplifies how the max offset is checked;
the check is now simpler than for min offset.

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
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/bpf/verifier.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e5ce530641ba..137240681fa9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6620,10 +6620,7 @@ static int check_stack_access_within_bounds(
 
 	if (tnum_is_const(reg->var_off)) {
 		min_off = reg->var_off.value + off;
-		if (access_size > 0)
-			max_off = min_off + access_size - 1;
-		else
-			max_off = min_off;
+		max_off = min_off + access_size;
 	} else {
 		if (reg->smax_value >= BPF_MAX_VAR_OFF ||
 		    reg->smin_value <= -BPF_MAX_VAR_OFF) {
@@ -6632,15 +6629,12 @@ static int check_stack_access_within_bounds(
 			return -EACCES;
 		}
 		min_off = reg->smin_value + off;
-		if (access_size > 0)
-			max_off = reg->smax_value + off + access_size - 1;
-		else
-			max_off = min_off;
+		max_off = reg->smax_value + off + access_size;
 	}
 
 	err = check_stack_slot_within_bounds(min_off, state, type);
-	if (!err)
-		err = check_stack_slot_within_bounds(max_off, state, type);
+	if (!err && max_off > 0)
+		err = -EINVAL; /* out of stack access into non-negative offsets */
 
 	if (err) {
 		if (tnum_is_const(reg->var_off)) {
-- 
2.40.1


