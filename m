Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9075E405977
	for <lists+bpf@lfdr.de>; Thu,  9 Sep 2021 16:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240777AbhIIOqN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Sep 2021 10:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345197AbhIIOqD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Sep 2021 10:46:03 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B7EC05BD2F
        for <bpf@vger.kernel.org>; Thu,  9 Sep 2021 07:33:23 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id g22so2933278edy.12
        for <bpf@vger.kernel.org>; Thu, 09 Sep 2021 07:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XfMLrua0MdTHFZoz901/cpqoFG6QjfNV3NlQ/D/QR3U=;
        b=0KPvJhRv5+Q9Wa/mLPFEkj4+tuCNRTUVOUirnNXJlnQMttNlVuITyduMTRoCad2hcw
         Wc+nUahSElbfLJxOE7eDRiRaG83GpaQPkhpHmxvLP9E7Hydaw1JLkVll7FXJqt13EQgo
         uyChnh498a49Z5dGheT8R5ZrMWqYbmP7MX9jMv9S3l8emKNl9WJ4dPfYA4iGUjX6d441
         p3lFAJwknXRB3CazY7jOVBlf4KEtazQJRTJbOD2vef8CLExn+trCV3yeX1Qk7GBLqjA4
         /3XCzaAONP6Zc6zkGhG0N45nXh8K5aYDRqD4IueFKQS9+9dfY8RYP2ejU+UUY1ds9ODc
         PViw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XfMLrua0MdTHFZoz901/cpqoFG6QjfNV3NlQ/D/QR3U=;
        b=q7zJ4TJ2DD7Xg5MTaJ18YWl1GtV6/AJvpcz5QvNYHFbghOwXZn88HUiMdWUhCtxpJd
         DYPk3aEAju95ZDf8MO94YJCGLwR4jVC4G7UIjVzL5m69Nw0qwGRJLXyhfeuU60Qtscgc
         yZY/+yJosNBe6Yb1X6FRpeGEg+jPA1qv7XgY9rrr7pTg5d+oe45/z3HIpZBTVYfDwr1R
         3Dlzq8flr+Qx1fNpOEY6BfgY7rEuft9e+c+K4vzDZAjTOo1o68QOCMd/hUfRGs/vsdwk
         1s0DBkm8ZiHbcXjnIfT763SOul58pFfLdnLK8RpgDlemDqWbxCMzyNFpnKHO39pHVNQW
         yw3A==
X-Gm-Message-State: AOAM5308MmNlXrnaNWQX+owzP4J/rYgrdDs0aqBWSi0ht1TPsyczIODv
        LGK1b1hNNQSpWs1mBsudlSuw6g==
X-Google-Smtp-Source: ABdhPJyGTRQVFnswNEwqITlB1YkEkuKin0eZC2VnQvU7840ZuslIUG5mt6HaPbuDSq3SeRoqk11rTA==
X-Received: by 2002:aa7:c744:: with SMTP id c4mr3577741eds.0.1631198001581;
        Thu, 09 Sep 2021 07:33:21 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id bj10sm1030909ejb.17.2021.09.09.07.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 07:33:21 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, iii@linux.ibm.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH bpf-next v3 08/13] bpf/tests: Add test case flag for verifier zero-extension
Date:   Thu,  9 Sep 2021 16:32:58 +0200
Message-Id: <20210909143303.811171-9-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210909143303.811171-1-johan.almbladh@anyfinetworks.com>
References: <20210909143303.811171-1-johan.almbladh@anyfinetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch adds a new flag to indicate that the verified did insert
zero-extensions, even though the verifier is not being run for any
of the tests.

Signed-off-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
---
 lib/test_bpf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index 6a04447171c7..26f7c244c78a 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -52,6 +52,7 @@
 #define FLAG_NO_DATA		BIT(0)
 #define FLAG_EXPECTED_FAIL	BIT(1)
 #define FLAG_SKB_FRAG		BIT(2)
+#define FLAG_VERIFIER_ZEXT	BIT(3)
 
 enum {
 	CLASSIC  = BIT(6),	/* Old BPF instructions only. */
@@ -11280,6 +11281,8 @@ static struct bpf_prog *generate_filter(int which, int *err)
 		fp->type = BPF_PROG_TYPE_SOCKET_FILTER;
 		memcpy(fp->insnsi, fptr, fp->len * sizeof(struct bpf_insn));
 		fp->aux->stack_depth = tests[which].stack_depth;
+		fp->aux->verifier_zext = !!(tests[which].aux &
+					    FLAG_VERIFIER_ZEXT);
 
 		/* We cannot error here as we don't need type compatibility
 		 * checks.
-- 
2.30.2

