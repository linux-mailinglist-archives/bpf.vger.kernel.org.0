Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555724DCBEB
	for <lists+bpf@lfdr.de>; Thu, 17 Mar 2022 17:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236715AbiCQQ77 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Mar 2022 12:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236714AbiCQQ7y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Mar 2022 12:59:54 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213F97B55D
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 09:58:32 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 25so8027292ljv.10
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 09:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LwPiq0aOP34Qyg6rVQlymRAJ3+fiKOCehhtJ/fLH+0Q=;
        b=ZXwmYAJpocVs+zNgytE9eJ8NaB21z8nL/WSOwkErfEgHXBvCoCWK0Dcc15H8WiS3zj
         BnNbmECGbtSiJiwResAnkHdcKok/net5IBj7xhPpxs1GLlsE5NeSuWxonAGe8fo88A9E
         dXV+3dYN+QDYRNIwQl2bBTbeNqWW2LwMTXMN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LwPiq0aOP34Qyg6rVQlymRAJ3+fiKOCehhtJ/fLH+0Q=;
        b=H5K4MlBtsrelCv1IksaKWgsr5NRQ3cvh2/33u+mUxdiLiZdRYyfwu126PcRF5sc3sq
         zAujNMJtgvfO3NLk+4juh0DmjeAbCP7XdPtXBXDMkI+tpUXBasBis+evStxPF0+RMFSC
         Emn9QCvUm5Dk9A3mAbFfR0A41beCqrne3unEL/p6C4b1XkM3ww4xc47Fjks6EQmTggdU
         i/E91/ajTR1pT05jm4ugptyWJPtu0OtcIpxF0a0Y9YP+UdSuvx7hAhIPH7iNQiFvwZ4a
         BZrzgiAMKrxXlmDuConYbku+dHiri/fy/QCwXI/Jn/BC9rwh9/9cr55H8gV1WqxAexw3
         aqRA==
X-Gm-Message-State: AOAM532ljSdjShm/Frocl/4aes61HoYLn68oWdyg0Whnmr4v3BbHFW6T
        QVH/eZAMRApB5AUGvs8NS0gofb9ec031zg==
X-Google-Smtp-Source: ABdhPJxlHTxernOQ5RXtusjHurF794ZK8sfGX58mtDyrWHi3Tm1wvaargTP+OKZjCjsY0AcEWYPUPA==
X-Received: by 2002:a05:651c:90a:b0:249:5d82:fe9c with SMTP id e10-20020a05651c090a00b002495d82fe9cmr3387251ljq.300.1647536310229;
        Thu, 17 Mar 2022 09:58:30 -0700 (PDT)
Received: from cloudflare.com ([2a01:110f:4809:d800::f9c])
        by smtp.gmail.com with ESMTPSA id j7-20020a2e3c07000000b00247fd2f7f46sm474083lja.47.2022.03.17.09.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 09:58:29 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        kernel-team@cloudflare.com, Ilya Leoshkevich <iii@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH bpf-next 3/3] selftests/bpf: Fix test for 4-byte load from remote_port on big-endian
Date:   Thu, 17 Mar 2022 17:58:26 +0100
Message-Id: <20220317165826.1099418-4-jakub@cloudflare.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220317165826.1099418-1-jakub@cloudflare.com>
References: <20220317165826.1099418-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The context access converter rewrites the 4-byte load from
bpf_sk_lookup->remote_port to a 2-byte load from bpf_sk_lookup_kern
structure.

It means that we cannot treat the destination register contents as a 32-bit
value, or the code will not be portable across big- and little-endian
architectures.

This is exactly the same case as with 4-byte loads from bpf_sock->dst_port
so follow the approach outlined in [1] and treat the register contents as a
16-bit value in the test.

[1]: https://lore.kernel.org/bpf/20220317113920.1068535-5-jakub@cloudflare.com/

Fixes: 2ed0dc5937d3 ("selftests/bpf: Cover 4-byte load from remote_port in bpf_sk_lookup")
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/testing/selftests/bpf/progs/test_sk_lookup.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_sk_lookup.c b/tools/testing/selftests/bpf/progs/test_sk_lookup.c
index 38b7a1fe67b6..6058dcb11b36 100644
--- a/tools/testing/selftests/bpf/progs/test_sk_lookup.c
+++ b/tools/testing/selftests/bpf/progs/test_sk_lookup.c
@@ -418,9 +418,15 @@ int ctx_narrow_access(struct bpf_sk_lookup *ctx)
 	if (LSW(ctx->remote_port, 0) != SRC_PORT)
 		return SK_DROP;
 
-	/* Load from remote_port field with zero padding (backward compatibility) */
+	/*
+	 * NOTE: 4-byte load from bpf_sk_lookup at remote_port offset
+	 * is quirky. It gets rewritten by the access converter to a
+	 * 2-byte load for backward compatibility. Treating the load
+	 * result as a be16 value makes the code portable across
+	 * little- and big-endian platforms.
+	 */
 	val_u32 = *(__u32 *)&ctx->remote_port;
-	if (val_u32 != bpf_htonl(bpf_ntohs(SRC_PORT) << 16))
+	if (val_u32 != SRC_PORT)
 		return SK_DROP;
 
 	/* Narrow loads from local_port field. Expect DST_PORT. */
-- 
2.35.1

