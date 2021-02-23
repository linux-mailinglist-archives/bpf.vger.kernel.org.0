Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6520A32270D
	for <lists+bpf@lfdr.de>; Tue, 23 Feb 2021 09:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbhBWIXF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Feb 2021 03:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbhBWIXB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Feb 2021 03:23:01 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B0FC061574
        for <bpf@vger.kernel.org>; Tue, 23 Feb 2021 00:22:20 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id u14so21649675wri.3
        for <bpf@vger.kernel.org>; Tue, 23 Feb 2021 00:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ubique-spb-ru.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VE6cDzWl4H7fCtBOfyOCRn4CvbYpzWAZUSTzHceFnyw=;
        b=s7n56XLZDc5hEme9rL8WaTG6qcH1j4kkfgHjkMlJ6dMwMBAAdCUbtZrytyZXEuYFmS
         RKJzqJW4/iOrg7c1kONd6fccuNTXVukm9xmwfgt1xjYGU25eScoB8PCudKNGjFcxmgBK
         Hn5Aq249tCI/dYI/OXm34cYBqYxio/9jVQl3npK9Gd69CNGSUumNpNJyKIvSM5LEatKk
         iO/rPLFU20vE+pUZ9nm/eTxpm+g+1xTp8z89LvkfvIMvd4gVtT07pBYFT320iDmxej3N
         xmNEj8UFPXDB4oIZcuU0vQp5gQtusFgI37Fjrb3pUpNI1FEQP/lIsRFi7qwjfqPZNDeF
         Eu3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VE6cDzWl4H7fCtBOfyOCRn4CvbYpzWAZUSTzHceFnyw=;
        b=dEzzffRI04+qSRYgxbF9ZjHX5Iato8/donitUTqsGmGOReVCuSXBub1sMKlAUN/PEE
         u+xsY3dCRoOQMfMfrluFgZemusKDLBpgJ7VXi0RsX50egJ8goO32YVVAyocRq2cFiUUP
         sN6oNNBkL3V2+YSuPu7tK/C8QE51dMc1B3Mo7LjW9I3LQPCLLeoQ83OL8fYClXzIIEzo
         6qCJWsJpFccpBnc23m1Bxkw970ZvtTKVN5duMyrfqmSMMpQX6wbPbvBq8K1kjkOJVn/a
         1LWPAwUEHAlOyjILYZFhHAulyTnnUPNr9p7Y6C30PwIfNrdhxfXz8ss7A6sDNPG4bGUe
         ki0A==
X-Gm-Message-State: AOAM533Pp7J0DEPfZOwPdb4DERM7Jkza7FVmPl0KFIVDEbgNFWx91hIc
        QGYJVOTzSYyOHtVGwrdFKMi7b0yUKR1PHMDm1Lo=
X-Google-Smtp-Source: ABdhPJyL3X4cF/qQ6GkgATaeSJKeGdPSKf5vLi4T61AgLpvrl2WvwrAkY+j+bD7f8Z6DaTl45B7T3w==
X-Received: by 2002:a5d:6392:: with SMTP id p18mr12311483wru.426.1614068538902;
        Tue, 23 Feb 2021 00:22:18 -0800 (PST)
Received: from localhost ([154.21.15.43])
        by smtp.gmail.com with ESMTPSA id y1sm31278523wrr.41.2021.02.23.00.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 00:22:18 -0800 (PST)
From:   Dmitrii Banshchikov <me@ubique.spb.ru>
To:     bpf@vger.kernel.org
Cc:     Dmitrii Banshchikov <me@ubique.spb.ru>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, rdna@fb.com
Subject: [PATCH] selftests/bpf: Fix a compiler warning in global func test
Date:   Tue, 23 Feb 2021 12:22:11 +0400
Message-Id: <20210223082211.302596-1-me@ubique.spb.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAEf4BzbbwTeVqP0D_UmYMamfWqp0JSO6TSr_TS-7aoxa-xW3Jg@mail.gmail.com>
References: <CAEf4BzbbwTeVqP0D_UmYMamfWqp0JSO6TSr_TS-7aoxa-xW3Jg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add an explicit 'const void *' cast to pass program ctx pointer type into
a global function that expects pointer to structure.

warning: incompatible pointer types
passing 'struct __sk_buff *' to parameter of type 'const struct S *'
[-Wincompatible-pointer-types]
        return foo(skb);
                   ^~~
progs/test_global_func11.c:10:36: note: passing argument to parameter 's' here
__noinline int foo(const struct S *s)
                                   ^

Fixes: 8b08807d039a ("selftests/bpf: Add unit tests for pointers in global functions")
Signed-off-by: Dmitrii Banshchikov <me@ubique.spb.ru>
---
 tools/testing/selftests/bpf/progs/test_global_func11.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/test_global_func11.c b/tools/testing/selftests/bpf/progs/test_global_func11.c
index 28488047c849..ef5277d982d9 100644
--- a/tools/testing/selftests/bpf/progs/test_global_func11.c
+++ b/tools/testing/selftests/bpf/progs/test_global_func11.c
@@ -15,5 +15,5 @@ __noinline int foo(const struct S *s)
 SEC("cgroup_skb/ingress")
 int test_cls(struct __sk_buff *skb)
 {
-	return foo(skb);
+	return foo((const void *)skb);
 }
-- 
2.25.1

