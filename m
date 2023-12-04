Return-Path: <bpf+bounces-16557-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0878029AC
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 02:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA3E91F20FE4
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 01:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E44819;
	Mon,  4 Dec 2023 01:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKbtan0C"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B19D7
	for <bpf@vger.kernel.org>; Sun,  3 Dec 2023 17:02:04 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-77db736aae5so222340985a.0
        for <bpf@vger.kernel.org>; Sun, 03 Dec 2023 17:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701651723; x=1702256523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HJPtUmVy+q3cqDHZTtXumZPFK+LVOZz/3b2pt7ZsSbM=;
        b=QKbtan0C0bdCMQolTDlciDoYhIShU7h/sfZZj2LWFlPo0976kkx9MyN9TY95xpGpPc
         0bfmAeuL4fi0BhFx29jTpVYP0MMKDauuR3RkM2RJBLB8xYsXq65ml1RzgwSXpqYfrgqS
         //fQutbPALIeZAIdWbCSDkq0F3e3KWA6Yw6Ul/Y/icRJC4HnVRL3BJ7UJ5+QQhCb3xV3
         OlMNo4V8o3XfbBoL/XB+fOG+13SrjI8A5WIsOb7n27/4PSx3SGqkLc/eI1u7xrJyRdgS
         oD/Zu5TJSJcZ0N8ncfZCBMCgjOEvxfiqujG0fBw3ElKW7JAbotrgjGFrsAC+O2ZwWknf
         fQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701651723; x=1702256523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HJPtUmVy+q3cqDHZTtXumZPFK+LVOZz/3b2pt7ZsSbM=;
        b=isjj8S0grC7LSNhaIKDYMsPKYb/0e+MjnwKIM2gvDhaw/9e5Nbi7Kx5fzlmOzSpwhp
         ZYeQ9BIqVaxXYiS43x5l4wVoebEMY74FrxzzTfwQJuyN6pnP3WfODOuOztlwdPOkwvCr
         DyrmPf0m/R05MZ+juWhVTsFify4DLbPiTRxe49wo/yKG8JpWg0khzdz/3Jozsv5YvXx8
         TuMP0mr9PVEDUhsCubn099zDUEEiTQRI4CZR4+Fv3wE6sIgxqpW5WfWFcso+YBkKD+Eu
         W5hniig/38bmOQiU6o9AP5ASGV5ZflMuZXYYl2btQG2lI78iYHbmVpyQPbmCNjw4LGz6
         tqaw==
X-Gm-Message-State: AOJu0YwimFPaooNrjs1jMkqJUMb8o5eTMW2C2kaJLc9L8wyYULGzQqRB
	xgEN/SjhHNxLZhDHDHrE1sMXknJcESs9SA==
X-Google-Smtp-Source: AGHT+IFKmKiQp3hbD82IRI7aNpHjyzNeMzJq56qVlCsE74fuAeA0oknvoCQ3+MIg2HIek3WvbUhmhQ==
X-Received: by 2002:a05:622a:13d4:b0:417:b269:4689 with SMTP id p20-20020a05622a13d400b00417b2694689mr5254173qtk.53.1701651722939;
        Sun, 03 Dec 2023 17:02:02 -0800 (PST)
Received: from andrei-framework.taildd130.ts.net ([2600:4041:599b:1100:b3d4:94c:3d56:e9ef])
        by smtp.gmail.com with ESMTPSA id ks24-20020ac86218000000b004238a0bca27sm3798953qtb.4.2023.12.03.17.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 17:02:02 -0800 (PST)
From: Andrei Matei <andreimatei1@gmail.com>
To: bpf@vger.kernel.org,
	andrii.nakryiko@gmail.com
Cc: sunhao.th@gmail.com,
	kernel-team@dataexmachina.dev,
	Andrei Matei <andreimatei1@gmail.com>
Subject: [PATCH bpf] bpf: fix verification of indirect var-off stack access
Date: Sun,  3 Dec 2023 20:01:39 -0500
Message-Id: <20231204010139.2038464-1-andreimatei1@gmail.com>
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
 kernel/bpf/verifier.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index af2819d5c8ee..a428735d232e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6816,10 +6816,7 @@ static int check_stack_access_within_bounds(
 			return -EACCES;
 		}
 		min_off = reg->smin_value + off;
-		if (access_size > 0)
-			max_off = reg->smax_value + off + access_size - 1;
-		else
-			max_off = min_off;
+		max_off = reg->smax_value + off + access_size - 1;
 	}
 
 	err = check_stack_slot_within_bounds(min_off, state, type);
-- 
2.40.1


