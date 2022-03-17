Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435C34DCBEE
	for <lists+bpf@lfdr.de>; Thu, 17 Mar 2022 17:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiCQRAA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Mar 2022 13:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236721AbiCQQ7y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Mar 2022 12:59:54 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF0D7B130
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 09:58:31 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id c15so8022497ljr.9
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 09:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yyhmXH0ljoyJvF+kjYeXv2UO7/DU5nKztxlGiJM8hxg=;
        b=PTOvHVtpuLQi0CwBA0t9oqnhI8C8poXFldON3mWhPP2SfVlqPcOW9uTA5fMjOgG58C
         xaNoFNtc8dnkNphs8mc6mEv7BZ5oqwsp0ma6HtPwNbLbnaiNanYgyRKv5xrwbcH0Ertr
         prL8Gxy75Ad/IZkrPEYGOa3eDM1i3cldHzyNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yyhmXH0ljoyJvF+kjYeXv2UO7/DU5nKztxlGiJM8hxg=;
        b=w20OrLooC/UCNBbK6X2XGvm6wcroqIWjd31iL2u4BiD2vzT30LZsadJo4dsm8s4v+Q
         wmnqbJapcEzDQclvB2LGGNMBc6DfGqWsNpxf0bZsSJVDIFMxTczdCnlizmQ+LFM7w564
         MU6jvXlrRPUnNlb1B+rZTnqWe82p+eJHbPQqvFg06Vt1JCu7eHhdRSCHtiubFSabQ+hu
         es2alPB/pRPpKcMMN7WWOqsUY8RRODI9CDRYVI2+w0+NnasSJ//zZo5WTJSkfk/rs6qD
         C8PZhU+wHQIda/O2mQs2H6m+V7K7M95EiYL3ggcYpMnoInJuziGi4Kq7187NFasBEDZj
         qjRQ==
X-Gm-Message-State: AOAM530YieBKQk/cHweyUfzoBYMcYRmPx0roTWAu7J0kII9ZeRdEA0/9
        j15jqkos/+mbZo7SFO/HKHcn+rij16Vjwg==
X-Google-Smtp-Source: ABdhPJx9qo8Ds4dZ3isff6DWWFAHUDIyM7arJ3R845qI+lI+yXlQH4ky+1wXILhubgtGbGu452+9iw==
X-Received: by 2002:a05:651c:1544:b0:248:39d:207f with SMTP id y4-20020a05651c154400b00248039d207fmr3683622ljp.151.1647536309238;
        Thu, 17 Mar 2022 09:58:29 -0700 (PDT)
Received: from cloudflare.com ([2a01:110f:4809:d800::f9c])
        by smtp.gmail.com with ESMTPSA id q12-20020a19f20c000000b00448309614b8sm488246lfh.183.2022.03.17.09.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 09:58:28 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        kernel-team@cloudflare.com, Ilya Leoshkevich <iii@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH bpf-next 2/3] selftests/bpf: Fix u8 narrow load checks for bpf_sk_lookup remote_port
Date:   Thu, 17 Mar 2022 17:58:25 +0100
Message-Id: <20220317165826.1099418-3-jakub@cloudflare.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220317165826.1099418-1-jakub@cloudflare.com>
References: <20220317165826.1099418-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In commit 9a69e2b385f4 ("bpf: Make remote_port field in struct
bpf_sk_lookup 16-bit wide") ->remote_port field changed from __u32 to
__be16.

However, narrow load tests which exercise 1-byte sized loads from
offsetof(struct bpf_sk_lookup, remote_port) were not adopted to reflect the
change.

As a result, on little-endian we continue testing loads from addresses:

 - (__u8 *)&ctx->remote_port + 3
 - (__u8 *)&ctx->remote_port + 4

which map to the zero padding following the remote_port field, and don't
break the tests because there is no observable change.

While on big-endian, we observe breakage because tests expect to see zeros
for values loaded from:

 - (__u8 *)&ctx->remote_port - 1
 - (__u8 *)&ctx->remote_port - 2

Above addresses map to ->remote_ip6 field, which precedes ->remote_port,
and are populated during the bpf_sk_lookup IPv6 tests.

Unsurprisingly, on s390x we observe:

  #136/38 sk_lookup/narrow access to ctx v4:OK
  #136/39 sk_lookup/narrow access to ctx v6:FAIL

Fix it by removing the checks for 1-byte loads from offsets outside of the
->remote_port field.

Fixes: 9a69e2b385f4 ("bpf: Make remote_port field in struct bpf_sk_lookup 16-bit wide")
Suggested-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/testing/selftests/bpf/progs/test_sk_lookup.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_sk_lookup.c b/tools/testing/selftests/bpf/progs/test_sk_lookup.c
index bf5b7caefdd0..38b7a1fe67b6 100644
--- a/tools/testing/selftests/bpf/progs/test_sk_lookup.c
+++ b/tools/testing/selftests/bpf/progs/test_sk_lookup.c
@@ -413,8 +413,7 @@ int ctx_narrow_access(struct bpf_sk_lookup *ctx)
 
 	/* Narrow loads from remote_port field. Expect SRC_PORT. */
 	if (LSB(ctx->remote_port, 0) != ((SRC_PORT >> 0) & 0xff) ||
-	    LSB(ctx->remote_port, 1) != ((SRC_PORT >> 8) & 0xff) ||
-	    LSB(ctx->remote_port, 2) != 0 || LSB(ctx->remote_port, 3) != 0)
+	    LSB(ctx->remote_port, 1) != ((SRC_PORT >> 8) & 0xff))
 		return SK_DROP;
 	if (LSW(ctx->remote_port, 0) != SRC_PORT)
 		return SK_DROP;
-- 
2.35.1

