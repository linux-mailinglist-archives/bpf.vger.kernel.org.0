Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDB983829
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2019 19:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731659AbfHFRpk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Aug 2019 13:45:40 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:39491 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730191AbfHFRpk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Aug 2019 13:45:40 -0400
Received: by mail-ua1-f73.google.com with SMTP id 43so8338548uaj.6
        for <bpf@vger.kernel.org>; Tue, 06 Aug 2019 10:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Syn2kmKTSOjtRrVDj8mWBubeTcnhNGvS/pcOIOQ1G0I=;
        b=Lc4TBYDy145EfpdwoHd3+qVUW9vx/OajBhmXsNYl1x/bDRHitv8dA0mMfyySPaYKXH
         975qWNmj130XSzoduPz7q10Zi2F+urTEZNhDmRqPZlsMbaAIpFfBR/CuhVah11t7V2FU
         Vf4QKh8s9TqwJKFGC1LgkO6/PTa4SMGWeAxfxcLFehDBSTe+plBqWBoe260uWYnVGQ+j
         qcGQLEr9/Zhk2sm51p3FmMsMiq1hUGw/FmVdfXxPrAGW9UGot+EeF/IurRRewMPsKVxy
         gH6xq7MPC58BbZc1V7FsOWenNIpaxxn13ZitgGicfeYH+BmQ/5tCOUaZisgKvPwHDySn
         e52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Syn2kmKTSOjtRrVDj8mWBubeTcnhNGvS/pcOIOQ1G0I=;
        b=JiP5FpyyhCq3gvZVHPc98By14LCU/QNs5hcvysG3DyKxfe/xRym0R6oNyLmWHwE8cc
         xdcXfERyWSzJLVthgr1MXxO4xyHcbvdfigp2KSJHtKKn3FqmDTsE1btj1laNyzyyGCHw
         clBdH/53/gUOih2ZBGtsVbT6BJNtYyz+6W1Sj+g2KuViQhcpCOxQzjeyAEN/kV1ND1L6
         y4JsOymkk1RHBjXmGqI3UmDSLbmn4Cff/VtKBWzR12feRamqh8EngyhygaExpLaM2UrV
         gVJa3WHnuGDGWnuHxah5QvroPt18OH2XfxGXBYt6TPIr5gW3EYncRrExsIG4fezZzrwZ
         k0YQ==
X-Gm-Message-State: APjAAAVM2ggX3A+PGEBqoNQpNC2FrAb6f1OFmKZJ9vUcWOZoc1ALvSEz
        8FJQaNNpXIxOIz/Qk58KG3UTDsE=
X-Google-Smtp-Source: APXvYqwB3S78p/LBqd6JOWdZvvOw25/wrhY6kCK+GSk9Ba0Dz6KBFkF8QZvjk7R6pBUm5E9OnM7H67A=
X-Received: by 2002:a67:1787:: with SMTP id 129mr3137768vsx.64.1565113539295;
 Tue, 06 Aug 2019 10:45:39 -0700 (PDT)
Date:   Tue,  6 Aug 2019 10:45:29 -0700
In-Reply-To: <20190806174529.8341-1-sdf@google.com>
Message-Id: <20190806174529.8341-4-sdf@google.com>
Mime-Version: 1.0
References: <20190806174529.8341-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH bpf-next v5 3/3] selftests/bpf: test_progs: drop extra
 trailing tab
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Andrii Nakryiko <andriin@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Small (un)related cleanup.

Cc: Andrii Nakryiko <andriin@fb.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/test_progs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 6c11c796ea1f..12895d03d58b 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -278,7 +278,7 @@ enum ARG_KEYS {
 	ARG_VERIFIER_STATS = 's',
 	ARG_VERBOSE = 'v',
 };
-	
+
 static const struct argp_option opts[] = {
 	{ "num", ARG_TEST_NUM, "NUM", 0,
 	  "Run test number NUM only " },
-- 
2.22.0.770.g0f2c4a37fd-goog

