Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4F274879AB
	for <lists+bpf@lfdr.de>; Fri,  7 Jan 2022 16:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348081AbiAGP03 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Jan 2022 10:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbiAGP02 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Jan 2022 10:26:28 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A372AC061574
        for <bpf@vger.kernel.org>; Fri,  7 Jan 2022 07:26:28 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id a8so351406qvx.2
        for <bpf@vger.kernel.org>; Fri, 07 Jan 2022 07:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vGt+owIlTcGsf36iCyr2fuZ50uj0j7pktyV5lENxl60=;
        b=BsSs3Sf0PUcYCsfnc2cET0b7KSTLKjqELvqmmkYXLRIU7I0n0/CBH2fMqbYPc6y3ut
         Qf5aXIX0x7U/CuVi0682ceKeM85KIzxTGH5Zx4AxhpQjpseKLqVBC6LllOzwdVpYfkcX
         etxOGMz7MpDURFO3WXYXvKFtAnYkHFFPa6u4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vGt+owIlTcGsf36iCyr2fuZ50uj0j7pktyV5lENxl60=;
        b=AkFNTJw84mSMF5SZmIkwEwuXq8OebZaz/IxE1oUVMYinbDXF8P/JGKefxdlO2Xw12a
         BgJkJRhVYiayJSgT/TCoX+rEEKkKz6q2YWaEIERw5Ex7pT5NZUGl4mTOmspEBjRCk3av
         zZqSyj8QPo+zy161OgCrVJOj85m58rN8pjQMPwXz687F4UaKIPiFm1AoulfC7KIrLN82
         1Yanof5poI65CBhH8eOYjtuQw/rchqgbi+s1WgOgM9Fb+GS3ooJMIxLUgF744e/5e6Mc
         I1h6ya7cRHaPh8trMzyiryRqUwrGg+9023FC0mlorCuwGYVJl7dnX+RbCd9pHvnLZ7Gu
         Pi2g==
X-Gm-Message-State: AOAM5328h5rugY4NUT0ZHGHbciCj6mW8DHlydgBSp7b8/PK0wON6+Zov
        K2e463EBaxvHrwDdKjOe5O8o4w==
X-Google-Smtp-Source: ABdhPJwVk7agXiz7QnVNq9n1H0hekc/TGGK4YAap4uIyx26BeWy/IoJ1LN2f3uQ1HovNcFME09MT1Q==
X-Received: by 2002:ad4:5b8f:: with SMTP id 15mr32201544qvp.112.1641569186094;
        Fri, 07 Jan 2022 07:26:26 -0800 (PST)
Received: from localhost.localdomain ([181.136.110.101])
        by smtp.gmail.com with ESMTPSA id h9sm3441494qkp.106.2022.01.07.07.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 07:26:25 -0800 (PST)
From:   =?UTF-8?q?Mauricio=20V=C3=A1squez?= <mauricio@kinvolk.io>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next 1/2] libbpf: Use IS_ERR_OR_NULL() in hashmap__free()
Date:   Fri,  7 Jan 2022 10:26:19 -0500
Message-Id: <20220107152620.192327-1-mauricio@kinvolk.io>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

hashmap__new() uses ERR_PTR() to return an error so it's better to
use IS_ERR_OR_NULL() in order to check the pointer before calling
free(). This will prevent freeing an invalid pointer if somebody calls
hashmap__free() with the result of a failed hashmap__new() call.

Signed-off-by: Mauricio Vásquez <mauricio@kinvolk.io>
---
 tools/lib/bpf/hashmap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/lib/bpf/hashmap.c b/tools/lib/bpf/hashmap.c
index 3c20b126d60d..aeb09c288716 100644
--- a/tools/lib/bpf/hashmap.c
+++ b/tools/lib/bpf/hashmap.c
@@ -75,7 +75,7 @@ void hashmap__clear(struct hashmap *map)
 
 void hashmap__free(struct hashmap *map)
 {
-	if (!map)
+	if (IS_ERR_OR_NULL(map))
 		return;
 
 	hashmap__clear(map);
@@ -238,4 +238,3 @@ bool hashmap__delete(struct hashmap *map, const void *key,
 
 	return true;
 }
-
-- 
2.25.1

