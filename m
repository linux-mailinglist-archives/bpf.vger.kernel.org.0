Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE15B32277B
	for <lists+bpf@lfdr.de>; Tue, 23 Feb 2021 10:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbhBWJHA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Feb 2021 04:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbhBWJF3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Feb 2021 04:05:29 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFEAC06174A
        for <bpf@vger.kernel.org>; Tue, 23 Feb 2021 01:04:48 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id l12so21742938wry.2
        for <bpf@vger.kernel.org>; Tue, 23 Feb 2021 01:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ubique-spb-ru.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ptsTFhwB0aq1B1RCQnsP6frxftaPj8VXVsvH9pKlJbc=;
        b=Uv8Tnd7oURIQuCwPOLvy0Y4cBVC0P/Km+xtCzrtFCHxXDVvY8UWB5v/USAIogJzBPp
         z0HFN8SaxYFXrAdrs0ySVdQgj6IfXUAhnJMfDxwZ7G7UX4/7UvmJ56pv0HBRj8BOzL74
         V7Q/E9QoGI6NaVRzxpemHXd3Q+896weJnkD3j8FhYHou28MG/VQ3+UrA7CbzQm5/hjBB
         ec1JO1SvUicNBUtuQbJbLmvCVd+y0+xsueLTOh1M8+tjnbNugWWsAWN5STbS6Z8WjMkG
         x2Tuh57IZnl2h8/E5cE8LzddLMCLviZzbEkVFtXeYJF9uZQpTsILDtt+L7FP6h43v6eN
         IBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ptsTFhwB0aq1B1RCQnsP6frxftaPj8VXVsvH9pKlJbc=;
        b=I8LuULxkTpbLeQO0BKIiSsfIa6NkHM7ZQUOVX2LRLq9GDW8BlcVAnD9dr18MwVc3wn
         qA5pkep5kXKZHV70S8g0EqInpTEj+LJk0bcny0z6/ayyGEXHl4fnqWIiTeMR8u85k9Tj
         zMOmbw4A3JtyPSd25TxhQc5qNi1S7e0jCTI0oILZrAKhwVXxyvHQNlh1HQA6Npg/YSW2
         Excy6PLygSzs/ukdfZvIl3fwyUNi5xOs860nY3IkOMiV633c5q4PcMZIu9zzQzeg0rCf
         z9PK+ToT1ODCsfNt8u09t2e/yVSxOgV//UMpnpEIZ3AJcRHRH8rczDvasJ07AZYpJK8t
         xUsw==
X-Gm-Message-State: AOAM533Xsb97JF3q6aNlBV6huc9HZpKVeb/LNWdLr+Y6MrIbaeWGFUta
        EshtDidbGqsV/lMQa9NJtvmPgssBgr0R2vEWEso=
X-Google-Smtp-Source: ABdhPJyd7OfcUJgRU43yxJ1Oc4W4mgwTO4haRJgIP0XXSqvIVbYyEJAgFUTB9/M+ik4m2S8CiwuL4Q==
X-Received: by 2002:adf:92c4:: with SMTP id 62mr25524773wrn.245.1614071087297;
        Tue, 23 Feb 2021 01:04:47 -0800 (PST)
Received: from localhost ([154.21.15.43])
        by smtp.gmail.com with ESMTPSA id o15sm1883849wmh.39.2021.02.23.01.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 01:04:46 -0800 (PST)
From:   Dmitrii Banshchikov <me@ubique.spb.ru>
To:     bpf@vger.kernel.org
Cc:     Dmitrii Banshchikov <me@ubique.spb.ru>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, rdna@fb.com
Subject: [PATCH v2] bpf: Drop imprecise log message
Date:   Tue, 23 Feb 2021 13:04:16 +0400
Message-Id: <20210223090416.333943-1-me@ubique.spb.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210222193111.3koc5bo3czetwltx@kafai-mbp.dhcp.thefacebook.com>
References: <20210222193111.3koc5bo3czetwltx@kafai-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now it is possible for global function to have a pointer argument that
points to something different than struct. Drop the irrelevant log
message and keep the logic same.

Fixes: e5069b9c23b3 ("bpf: Support pointers in global func args")
Signed-off-by: Dmitrii Banshchikov <me@ubique.spb.ru>
Acked-by: Martin KaFai Lau <kafai@fb.com>
---
 v1 -> v2:
  * mention correct commit by hash
  * bpf-next -> bpf

 v0 -> v1: drop redundant commit hash mention

 kernel/bpf/btf.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 2efeb5f4b343..b1a76fe046cb 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4321,8 +4321,6 @@ btf_get_prog_ctx_type(struct bpf_verifier_log *log, struct btf *btf,
 		 * is not supported yet.
 		 * BPF_PROG_TYPE_RAW_TRACEPOINT is fine.
 		 */
-		if (log->level & BPF_LOG_LEVEL)
-			bpf_log(log, "arg#%d type is not a struct\n", arg);
 		return NULL;
 	}
 	tname = btf_name_by_offset(btf, t->name_off);
-- 
2.25.1

