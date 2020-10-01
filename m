Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52615280A97
	for <lists+bpf@lfdr.de>; Fri,  2 Oct 2020 00:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733165AbgJAWyp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Oct 2020 18:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgJAWyp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Oct 2020 18:54:45 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5E8C0613D0
        for <bpf@vger.kernel.org>; Thu,  1 Oct 2020 15:54:43 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id w3so52823qtn.16
        for <bpf@vger.kernel.org>; Thu, 01 Oct 2020 15:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=8NDHpbgsPNM+iNp/uNoQ+501O5J56BypM4WtDS2Nd1Y=;
        b=eOkCW6T+L2aH17IRHXFo4AT2PE5ym0MzNKpGLyFKgcr8xskaO5g8XLF5GRpdl+bnsv
         JU9/XEtaeeoRrWEMJb8fplf7YpCQb+MzE9lkVhcR8IEL73TtG9aOBvEedlX8NtyGAJy1
         VZI28F4MLRvY+wK56qmBIP6VR8d/c0L6Poau2sZxdBu6kXpkoTvCttq0BFEnnOn68gyo
         qkxPCyZSSDShB3bEVbJhbrj/ezjI87YBdDQKnUbFXxvj9FTmbqDN/VwapSjApzWdNNNz
         vqHpI1tNEWqunhvrq9T/IUGNtw/f7tOIu1i0y3VWHI8Jo+AvDAhzBCE5RuDE/Fd51ko6
         9rPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=8NDHpbgsPNM+iNp/uNoQ+501O5J56BypM4WtDS2Nd1Y=;
        b=TWfQJyaXZBs2OTBsik9U82WVGpw7YIQuThV1KqNpQ5FuCfCFjUebe/bn84InDgsSaj
         aXb6jcMfEkJnRjnYSZZe08ZpICcs8e6YEjdxz4i7YLJL6TWtnvIzsKVgJ6YgBDBqVpmm
         zcCfzHbwQygy/XyyqpV4RyLBsNYTHNaPCANRTQp+1MdT3kI78NTckb2MTFi1ogiOYGjK
         P2tjC3GHM+zrD6o8yr4U4fZZ1lug9HOoNEJZpEbtm+ZWX5Q+K7bBwAeYGpsW3RtqB/OQ
         Ng1LYgLi2cwJn4Ze/8wiLz9EOyJRdyJ9s2H4UVXgMm9zwMIgSKmSKJ080AeifqIi4w8z
         TYXw==
X-Gm-Message-State: AOAM5304MCSM0EqCzFOy5CHvdTRe/QL/ax06r86NHR/o/zM+U1Iy0WL+
        nrHzSoe7SzywSK+O1zFffkSkxe8=
X-Google-Smtp-Source: ABdhPJz1ugT0jI+7txOBsRSdiSxMIueL4oJqrTxiUo0LWqkB2m4duvqlL6Vu8iEA6/FbPinWsC8/8RQ=
Sender: "sdf via sendgmr" <sdf@sdf2.svl.corp.google.com>
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:1:7220:84ff:fe09:7732])
 (user=sdf job=sendgmr) by 2002:a0c:f0d1:: with SMTP id d17mr10086089qvl.34.1601592882388;
 Thu, 01 Oct 2020 15:54:42 -0700 (PDT)
Date:   Thu,  1 Oct 2020 15:54:40 -0700
Message-Id: <20201001225440.1373233-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH bpf-next] selftests/bpf: initialize duration in xdp_noinline.c
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fixes clang error:
tools/testing/selftests/bpf/prog_tests/xdp_noinline.c:35:6: error: variable 'duration' is uninitialized when used here [-Werror,-Wuninitialized]
        if (CHECK(!skel, "skel_open_and_load", "failed\n"))
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/prog_tests/xdp_noinline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_noinline.c b/tools/testing/selftests/bpf/prog_tests/xdp_noinline.c
index a1f06424cf83..0281095de266 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_noinline.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_noinline.c
@@ -25,7 +25,7 @@ void test_xdp_noinline(void)
 		__u8 flags;
 	} real_def = {.dst = MAGIC_VAL};
 	__u32 ch_key = 11, real_num = 3;
-	__u32 duration, retval, size;
+	__u32 duration = 0, retval, size;
 	int err, i;
 	__u64 bytes = 0, pkts = 0;
 	char buf[128];
-- 
2.28.0.709.gb0816b6eb0-goog

