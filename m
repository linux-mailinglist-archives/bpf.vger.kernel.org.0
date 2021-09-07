Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7AFA4030EC
	for <lists+bpf@lfdr.de>; Wed,  8 Sep 2021 00:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348393AbhIGWZK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Sep 2021 18:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348363AbhIGWZF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Sep 2021 18:25:05 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D60C061757
        for <bpf@vger.kernel.org>; Tue,  7 Sep 2021 15:23:58 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g8so62308edt.7
        for <bpf@vger.kernel.org>; Tue, 07 Sep 2021 15:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VrYufPGtjCUT0dky9yDhI8t1ufTvbEptWesm+ao/2u0=;
        b=M6rYgPcRM/XxNtbSMsd5L2c+ztWnOku7cmwqnr5o4ezFRiBhmANsKRbLs2Idz47LH7
         lLlT2KcAIvWgC1I0kHtR1lRkga1dB38a5UvLA+zGCpC3wMmDLTWHxvrewgyoR3GXTkGk
         8fSIiUcnHLwrO8HZ67mU9Rg1Lu50TwDS27pKyHADMvPev4vlWXFw5ec5LtoN18gGukor
         6O7Xm4dAHW2ht8/eJa+xyvNe/XjseR+zfe2OyHObFIu+hV7+YHjON7z4opoG+Y63iGpo
         6KoadOA9BZB9EU+x80AXoOWO/C5+3D/HvG0iWeOL1zzh2zk0LKB11f9LrDrJKaj65WM7
         i9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VrYufPGtjCUT0dky9yDhI8t1ufTvbEptWesm+ao/2u0=;
        b=Ss1BwVoeO9g0ZBCUk8FMXSXOp8Hbe/VcOwTV28b3xnEeFhyTQkLD3nDPRJOrVOdBjn
         tfXqHjq37XaSnn6MJQ2ijv0b6I4Xf0rbldul2vS/CfX+a6U1a67a+oXpR3UPEGWNOobM
         7+S3f2oK9Vb8dveeNkcv0Ac//y/ZRjlGJols5K70FR6PgFJU8Hb9tXnH4Bl9lEz++e4V
         N8qPJybW1deb83P79woNhUzds29cyBthVbJl7/pNV5la53iVrb6CkDeDElPhn3IRyz9U
         x1dcLrUtfx5YWw0tYXhnLTGbegxR6TstWO4cJO/DbXDW/QzDt9J6sSgU8EZt1qHY/CLK
         FyrA==
X-Gm-Message-State: AOAM53188SeYoG606g74iJnyBj6Yv0X40N81IgDQUsFtJgA1NjnO/UsB
        LTFkeJlelHHSDWs82heVz5RLMw==
X-Google-Smtp-Source: ABdhPJxq/zVCKO+LcvpT4BOmvbBvObpGjqgAxUwKWfiwxPoRvleMXb4blJuA/NcsIQTueqQlLCDvMA==
X-Received: by 2002:a05:6402:40ce:: with SMTP id z14mr560238edb.28.1631053437078;
        Tue, 07 Sep 2021 15:23:57 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id gb24sm71772ejc.53.2021.09.07.15.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 15:23:56 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, iii@linux.ibm.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH bpf-next v2 08/13] bpf/tests: Add test case flag for verifier zero-extension
Date:   Wed,  8 Sep 2021 00:23:34 +0200
Message-Id: <20210907222339.4130924-9-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210907222339.4130924-1-johan.almbladh@anyfinetworks.com>
References: <20210907222339.4130924-1-johan.almbladh@anyfinetworks.com>
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
2.25.1

