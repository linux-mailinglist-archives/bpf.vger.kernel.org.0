Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD24535F889
	for <lists+bpf@lfdr.de>; Wed, 14 Apr 2021 18:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352553AbhDNP5F (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Apr 2021 11:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351078AbhDNP5E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Apr 2021 11:57:04 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D488C061756
        for <bpf@vger.kernel.org>; Wed, 14 Apr 2021 08:56:41 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id y204so9497672wmg.2
        for <bpf@vger.kernel.org>; Wed, 14 Apr 2021 08:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hakvSth19CwFZlwh3YMNFY/spXWwZoBmln8dVIngfeE=;
        b=kqd1G5z0GmuSbfpQML2emAiJnZ8ErF4Ml3gO7hMACxJU7U4LODHnQGoipPcWW8wQvc
         t/bSuv3k42mx0hV7BXldowWUR2grG4rkTgSr0GMFBbvo3j+omXvQz0lYr80og2Amrev8
         ZavAVJ3n8d4ioH+Sjf1NK6IKpVeYKG7vTXwQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hakvSth19CwFZlwh3YMNFY/spXWwZoBmln8dVIngfeE=;
        b=KnZRJgieToKfsbYOOlmc6tSPQWqFyA/H6GXEe2KnbRhXI300sNt2fV1iE2CkqCIUqP
         gtLU5JB3SYyKdfmN1ycDQRj0P7qBnBQyLJxXU/qXgGKOtOXCnMBAFVkhmf+70NDAcQVT
         OTzPnXdygm4u4oZHtYPTRkiGJkxbcQGpJ/Kw5TfH8rA1jKbI47MkhJN1PA1pqUGV1g3A
         AgBZdD1NUeDlVVmiBWhN2oW6MMwJ+YLVVHS2khBHq6T++VLWKDbhwJ50a51GDflLi6ch
         aGjOSkMOVsYCcjxownl4TGNn3bdKUXJYwXXv9tSuU99JX0nUnSW9oQ31+StDxMPElaQv
         DJDA==
X-Gm-Message-State: AOAM530j8rn2VccS2Tz5bKR9zeMRrjLY73U/j6iiQK8+lcIMa8GjCiRq
        Xb3vO4lDkIOpeWFnsQnLz+kPcaVYgsjuAg==
X-Google-Smtp-Source: ABdhPJxDm4ArJeDTutVnC8hE1110UxbwPKrqMSxmdnsugIhkHTlRMAJAsLUSvTL933ggj4XLnddwGg==
X-Received: by 2002:a7b:c1c5:: with SMTP id a5mr3670803wmj.54.1618415799574;
        Wed, 14 Apr 2021 08:56:39 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:8b2a:41bd:9d62:10d5])
        by smtp.gmail.com with ESMTPSA id s14sm20545578wrm.51.2021.04.14.08.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 08:56:39 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@kernel.org, jackmanb@chromium.org,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>
Subject: [PATCH] selftests/bpf: Fix the ASSERT_ERR_PTR macro
Date:   Wed, 14 Apr 2021 17:56:32 +0200
Message-Id: <20210414155632.737866-1-revest@chromium.org>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It is just missing a ';'. This macro is not used by any test yet.

Signed-off-by: Florent Revest <revest@chromium.org>
---
 tools/testing/selftests/bpf/test_progs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/selftests/bpf/test_progs.h
index e87c8546230e..ee7e3b45182a 100644
--- a/tools/testing/selftests/bpf/test_progs.h
+++ b/tools/testing/selftests/bpf/test_progs.h
@@ -210,7 +210,7 @@ extern int test__join_cgroup(const char *path);
 #define ASSERT_ERR_PTR(ptr, name) ({					\
 	static int duration = 0;					\
 	const void *___res = (ptr);					\
-	bool ___ok = IS_ERR(___res)					\
+	bool ___ok = IS_ERR(___res);					\
 	CHECK(!___ok, (name), "unexpected pointer: %p\n", ___res);	\
 	___ok;								\
 })
-- 
2.31.1.295.g9ea45b61b8-goog

