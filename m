Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764614BEAFC
	for <lists+bpf@lfdr.de>; Mon, 21 Feb 2022 20:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbiBUSOo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Feb 2022 13:14:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbiBUSMe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Feb 2022 13:12:34 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF26B53
        for <bpf@vger.kernel.org>; Mon, 21 Feb 2022 10:04:01 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id v22so13935602ljh.7
        for <bpf@vger.kernel.org>; Mon, 21 Feb 2022 10:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+O4j0r4gRZpPCC8vALOAdAGm1/r/gDtTHQV3KxQb75o=;
        b=hMDjfRGCkPpKr/qoVL2ISwgEhL7XHbwSHkuOVbOkfEvQIItZIMyqkvVY3oNaShng6t
         DtKhIIfplZEczrJLSGiT0Q4+NDlhYkUlvmBfc9SnIDxxeBVaWYoeMEWBJNURAH74RBXG
         KdSDV4oAqK1Nt4ost+MoqCzUAJkqta0+exQVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+O4j0r4gRZpPCC8vALOAdAGm1/r/gDtTHQV3KxQb75o=;
        b=PkVceQzBVGjpkbXd9eeCjjXBxfuG0GJLWLYQXozYsqy7y4AGg9FmkijKS2SPjNno7z
         sat6IDl30vtQuKZADo3vp4sc0XwKiaaVd8W6OpmuNQPJk2GEmB7otAwDEOqNrMPIqDyw
         xo8SfWM5sCLWkCgXIaMAXjCYczlVEnad3i/BMpgLKOsARtBfTLVZWaATXnpfq01ltJAu
         tS460lj9oOcjeRYNLuH1YsQjx3t2U05ywrGjvxdo9Yd2TgkSlwWjRYcdsVfKteADqg1q
         MXCbGicQ4yGQoi0H1nyohFE8QSNNk63Pd2/GE2lH7TONV4wOl0K+dpGRyE//5/boCZH4
         7U1Q==
X-Gm-Message-State: AOAM533Kg7x4YWzcvZjAKdf3DXt2AKY1srsf74crSoZeUD3wX+RrUeFy
        +rEdOyccsa4XSL5bK3xRR65hK5b9F5li5g==
X-Google-Smtp-Source: ABdhPJy0DjD64G+W06eKaFMzPMV8XzVyWeWdSC363fNMhbt/ShgJf0U2HYmm+FnTMBu4YzHlloB/5g==
X-Received: by 2002:a2e:8681:0:b0:246:3f2f:20d with SMTP id l1-20020a2e8681000000b002463f2f020dmr4358540lji.321.1645466639800;
        Mon, 21 Feb 2022 10:03:59 -0800 (PST)
Received: from cloudflare.com (2a01-110f-4809-d800-0000-0000-0000-0f9c.aa.ipv6.supernova.orange.pl. [2a01:110f:4809:d800::f9c])
        by smtp.gmail.com with ESMTPSA id o12sm1172961lfo.69.2022.02.21.10.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 10:03:59 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        kernel-team@cloudflare.com,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH bpf-next] selftests/bpf: Fix implementation-defined behavior in sk_lookup test
Date:   Mon, 21 Feb 2022 19:03:58 +0100
Message-Id: <20220221180358.169101-1-jakub@cloudflare.com>
X-Mailer: git-send-email 2.35.1
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

Shifting 16-bit type by 16 bits is implementation-defined for BPF programs.
Don't rely on it in case it is causing the test failures we are seeing on
s390x z15 target.

Fixes: 2ed0dc5937d3 ("selftests/bpf: Cover 4-byte load from remote_port in bpf_sk_lookup")
Reported-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---

I don't have a dev env for s390x/z15 set up yet, so can't definitely confirm the fix.
That said, it seems worth fixing either way.

 tools/testing/selftests/bpf/progs/test_sk_lookup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/test_sk_lookup.c b/tools/testing/selftests/bpf/progs/test_sk_lookup.c
index bf5b7caefdd0..7d47276a8964 100644
--- a/tools/testing/selftests/bpf/progs/test_sk_lookup.c
+++ b/tools/testing/selftests/bpf/progs/test_sk_lookup.c
@@ -65,6 +65,7 @@ static const __u32 KEY_SERVER_A = SERVER_A;
 static const __u32 KEY_SERVER_B = SERVER_B;
 
 static const __u16 SRC_PORT = bpf_htons(8008);
+static const __u32 SRC_PORT_U32 = bpf_htonl(8008U << 16);
 static const __u32 SRC_IP4 = IP4(127, 0, 0, 2);
 static const __u32 SRC_IP6[] = IP6(0xfd000000, 0x0, 0x0, 0x00000002);
 
@@ -421,7 +422,7 @@ int ctx_narrow_access(struct bpf_sk_lookup *ctx)
 
 	/* Load from remote_port field with zero padding (backward compatibility) */
 	val_u32 = *(__u32 *)&ctx->remote_port;
-	if (val_u32 != bpf_htonl(bpf_ntohs(SRC_PORT) << 16))
+	if (val_u32 != SRC_PORT_U32)
 		return SK_DROP;
 
 	/* Narrow loads from local_port field. Expect DST_PORT. */
-- 
2.35.1

