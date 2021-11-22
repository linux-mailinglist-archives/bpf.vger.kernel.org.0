Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282A745899D
	for <lists+bpf@lfdr.de>; Mon, 22 Nov 2021 08:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbhKVHJd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Nov 2021 02:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbhKVHJd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Nov 2021 02:09:33 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32484C061714
        for <bpf@vger.kernel.org>; Sun, 21 Nov 2021 23:06:27 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id p18-20020a17090ad31200b001a78bb52876so16065813pju.3
        for <bpf@vger.kernel.org>; Sun, 21 Nov 2021 23:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rhg9TzsQGoRy8u1OLujkUnb4ClXkAMqCNEBp1eYj7W4=;
        b=WKXNZRlrfWoEvbd3Mt43sBZcp9wgXb3skAh5izBElWBnr0tpnYwGDQC+yAADHI2lDp
         guE2Q2gc52+yEiuMw1pHyyFssT+vqM8WQpQ1NipliQseEEXYaAPQ01jYM4WAzUkOM0Fy
         uPH0xcHFEHECpzFVJUX5i8n7bSrSOiL8lQVRlWutemDwWH5VeL4Qvsxux45xeaPtw0Pz
         /Dgi9MKBk5NBcCloWvcxKqtDvQExoEq4tsvTryTf6bUOzwEQAfkBGhoBtFN3i/mUTzgZ
         difrDbraEYN5ybP1wVX4W+049BvzleSGzETJWQPx86KyvMwQZM73EYtZ47AJn8pT+L30
         Oc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rhg9TzsQGoRy8u1OLujkUnb4ClXkAMqCNEBp1eYj7W4=;
        b=Ch8eFMdHlzSEXDXVMd922MqROZd/T6OZKv/FKswTY82lkd/+AWefMd6bm5OHgNeVNb
         yg5IWv0kbn/9tXv8/3PIJheY34Ko35bKTOsVhmpfoz+0Q3y36nOts/qdbYReGOOs+a53
         VDP2gmQMUekuNoG5DB8RwNshwbBUUWpmj6p5PgG8rnIQp8FJLKoPTnc5nltsgoVnWEig
         clPI/5gfg5oQTNI9hWkPyEFWeXhkPNA7CrozqpUe7cS8namxmw9Qy/AQOJcukrUyg+eD
         Qose6hr4lXwC7O5gIieJg9qb3/P3ctsrb91EvGFoJy7hoHX0TT5ySYmNuk4kJdPghZXL
         rP5w==
X-Gm-Message-State: AOAM533o2CRuTyL+4LOPOEiOHxicIAhsKWLUsGiSkEfkvzJt/e3RHlSY
        owU89TjK7e1qlw0cm9JMAnEfYw==
X-Google-Smtp-Source: ABdhPJwAGuNBy2ut5ulgnJSYyO0MNQHn/zLEJfG36fGPimpq7gsDYUwwU4YvFRXGfyX0qYRyqpqKnQ==
X-Received: by 2002:a17:90a:3009:: with SMTP id g9mr28516847pjb.205.1637564786708;
        Sun, 21 Nov 2021 23:06:26 -0800 (PST)
Received: from localhost.localdomain ([156.146.34.70])
        by smtp.gmail.com with ESMTPSA id d9sm14281305pjs.2.2021.11.21.23.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Nov 2021 23:06:26 -0800 (PST)
From:   Drew Fustini <dfustini@baylibre.com>
To:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Drew Fustini <dfustini@baylibre.com>,
        Hengqi Chen <hengqi.chen@gmail.com>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Gustavo A . R . Silva" <gustavoars@kernel.org>
Subject: [PATCH] selftests/bpf: Fix trivial typo
Date:   Sun, 21 Nov 2021 23:05:30 -0800
Message-Id: <20211122070528.837806-1-dfustini@baylibre.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix trivial typo in comment from 'oveflow' to 'overflow'.

Reported-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 tools/testing/selftests/bpf/prog_tests/btf_dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
index aa76360d8f49..87e907add701 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
@@ -761,7 +761,7 @@ static void test_btf_dump_struct_data(struct btf *btf, struct btf_dump *d,
 	/* overflow bpf_sock_ops struct with final element nonzero/zero.
 	 * Regardless of the value of the final field, we don't have all the
 	 * data we need to display it, so we should trigger an overflow.
-	 * In other words oveflow checking should trump "is field zero?"
+	 * In other words overflow checking should trump "is field zero?"
 	 * checks because if we've overflowed, it shouldn't matter what the
 	 * field is - we can't trust its value so shouldn't display it.
 	 */
-- 
2.27.0

