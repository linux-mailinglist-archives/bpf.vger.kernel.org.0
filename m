Return-Path: <bpf+bounces-16782-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D31805EAC
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 20:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D365AB21103
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 19:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEE16AB8A;
	Tue,  5 Dec 2023 19:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afMQgWT/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B4DAB
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 11:33:30 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-423e95c2d54so59431cf.3
        for <bpf@vger.kernel.org>; Tue, 05 Dec 2023 11:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701804809; x=1702409609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GbRqrgH8VyqKtobRYe59P+dsXRiu9wPR5YICgxB87x8=;
        b=afMQgWT/5u0OXvLcLLE3YTH4ksPNL5bV+SCiaQsICDN9V+5f542AgC181cQI42nFUo
         LSZxQOjPtt/QNX/9mYPyYNmQh0/OJNTCgwJXhTe5an+LnIMb6KTRCTOinsuXMhe7mdAi
         gtDUSDJ8EwZEx2lXsyCIw22a/LE4k1Qux4T3QAugAbcKHVtMJKMn0q1MSWTwRSL0BtBP
         5YPODA9d0jnjMiN/kwTgRtrixE/ch2+0L3pyzW4mNlU1f8neHl8N4gxwpytcd9iM/42a
         6eMr0KnA2hGmMs5jGCiv8Hd4jNNU5vmvFVwAnz4E/qelWbtuJ3SJ5FDwLnVipTZ51da9
         aX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701804809; x=1702409609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GbRqrgH8VyqKtobRYe59P+dsXRiu9wPR5YICgxB87x8=;
        b=I67XIGFADYboh6kx0e8qj43Rln1ix5/1kf1aCYta/ssX3XLXCeViko5rpdKYW5EhXS
         Z515ZfHto2N20yWseE2H/IPGYmgWXzezGYmofK2YF4wHKeqB7JBPaBINuu9Ox8j9556m
         KxK0mNVLkrB6yxQ7Xvp6u2j/u9q5qtkDITvzioiEt6uXDwyDAYmRlpRXiUdUqBEGdVie
         DD7eZiFO909RgLHtVLfVCDCLhHrbjB89HVtPvgGw2JFJnGsDE6gM96rwehQJ1t9cW5QH
         iZ9zbv1Q499PiIjpvzmCV+ZE+eODBcI4W9EqR9UbgJK7PUJMD2CXglRpltoy07K40uPH
         gHYQ==
X-Gm-Message-State: AOJu0YxdOsQn2tDTT9x+0d4M3ITcD5LVGQezqS57Br8Q1d9iXvIDdMGV
	C8/S+ydixPLS3uLHM37OUtSUpkYQfpc=
X-Google-Smtp-Source: AGHT+IHRPmfFAs3NJDaaGK6APb50kCtInZ7nQQE8A/u0SyKsondA/W9oSJvV6wltVpreHuRFrfZnqQ==
X-Received: by 2002:a05:622a:609:b0:425:4043:8d44 with SMTP id z9-20020a05622a060900b0042540438d44mr1617460qta.95.1701804808830;
        Tue, 05 Dec 2023 11:33:28 -0800 (PST)
Received: from andrei-desktop.taildd130.ts.net ([71.125.252.241])
        by smtp.gmail.com with ESMTPSA id kg18-20020a05622a761200b00421c272bcbasm5334588qtb.11.2023.12.05.11.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 11:33:28 -0800 (PST)
From: Andrei Matei <andreimatei1@gmail.com>
To: bpf@vger.kernel.org,
	andrii.nakryiko@gmail.com,
	sunhao.th@gmail.com
Cc: Andrei Matei <andreimatei1@gmail.com>
Subject: [PATCH bpf v3 1/2] bpf: fix verification of indirect var-off stack access
Date: Tue,  5 Dec 2023 14:32:49 -0500
Message-Id: <20231205193250.260862-2-andreimatei1@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231205193250.260862-1-andreimatei1@gmail.com>
References: <20231205193250.260862-1-andreimatei1@gmail.com>
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
 kernel/bpf/verifier.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index af2819d5c8ee..29d39ebac196 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6804,10 +6804,7 @@ static int check_stack_access_within_bounds(
 
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
@@ -6816,15 +6813,12 @@ static int check_stack_access_within_bounds(
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
2.39.2


