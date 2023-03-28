Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735916CC08C
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 15:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjC1NW0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 09:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjC1NWZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 09:22:25 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BE07285
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 06:22:24 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id eg48so49560978edb.13
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 06:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680009742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8REp+dJGISwjQuVnV1roiWjyseKbhIjCh7zbQ9vkvVQ=;
        b=bfbs4wwC9TYDt+5DrLY4TzolTtlTFpFcav2VoghglfLtuEdq+VFq/kTTI7DRSCkFNB
         yhgriZieFtCuFOULRnfycNmbtyk8P7+k70GYn4LL0BfAR6X4NLEYFLzwN09IbqIJl5EP
         flvtAbCZvGvW50mFm2oJ0cufSNBDla/4e4LsJHXn1RKbyz1tBdr2mPyzPq10xTpKXB2y
         qbqpCCYr1TEUsesK2KM76Aqv07W1Kad5ssKw9hSX3wtw5lWTYJxe2IyEYSoP3J2KndGV
         c5LZErtrvThARW/Ay/P3aniQ0z4jjGzRpTkXYxlGHdGeoQel5OPL53qUmpYVVYWh0XWY
         ey7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680009742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8REp+dJGISwjQuVnV1roiWjyseKbhIjCh7zbQ9vkvVQ=;
        b=OoLFuFp+m6xlnIuDDRsEfMpiEcMo2KuwZloeYZhQoFXtb1498g0ubIRtqKaOXfm8Qy
         1YkFaMz12ouzOe227tE2QLUCMOrebP8RoUtGToOTcX7ZgJfhlSKMH+O84UiPWPfnR9Up
         vRf3k83IQUOu+HQiFkxsGvZ6cs40VykSb0z96X7DILz10bIaSSC4GDZCxDGatJUbFUfM
         DqN0MUJgSszYGN2d+z1qNvMQb0xNw6CUOmfvaZKe9J4FKvdBslqz5lfgKbVYaru3QfPl
         Pq4gp5fmZfsVf5ZHEGMHU9sCnyaXqPrtI3MUV2+22G6tnA4eHXhnazGTqUPaj2xFUit0
         FKxQ==
X-Gm-Message-State: AAQBX9fx9foMEjOOMREI6OzFJvdXGRBjjyYz43/KX1HaarwTo7wz4r6X
        fXR+eOkyRmAwoGcMcy8JmOpL1KTE9NoP/+ms69Dzjw==
X-Google-Smtp-Source: AKy350YKiAl1jd7/Jstgf6CAYTxxcYBtfXWI2Mhy4SBeMJwj780SfbOUX+OZduxNbdNrpJjLkWAA8w==
X-Received: by 2002:a17:906:39d6:b0:92f:48f0:736d with SMTP id i22-20020a17090639d600b0092f48f0736dmr16379142eje.62.1680009741984;
        Tue, 28 Mar 2023 06:22:21 -0700 (PDT)
Received: from localhost.localdomain ([45.35.56.2])
        by smtp.gmail.com with ESMTPSA id h19-20020a1709070b1300b008ec4333fd65sm15240170ejl.188.2023.03.28.06.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 06:22:21 -0700 (PDT)
From:   Yixin Shen <bobankhshen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, song@kernel.org, yhs@fb.com,
        bobankhshen@gmail.com
Subject: [PATCH 1/2] bpf: allow a TCP CC to write app_limited
Date:   Tue, 28 Mar 2023 13:20:34 +0000
Message-Id: <20230328132035.50839-2-bobankhshen@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230328132035.50839-1-bobankhshen@gmail.com>
References: <20230328132035.50839-1-bobankhshen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A CC that implements tcp_congestion_ops.cong_control() should be able to
write app_limited. A built-in CC or one from a kernel module is already
able to write to this member of struct tcp_sock.
For a BPF program, write access has not been allowed, yet.

Signed-off-by: Yixin Shen <bobankhshen@gmail.com>
---
 net/ipv4/bpf_tcp_ca.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index e8b27826283e..d5952c09aaf2 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -113,6 +113,9 @@ static int bpf_tcp_ca_btf_struct_access(struct bpf_verifier_log *log,
 	case offsetof(struct tcp_sock, ecn_flags):
 		end = offsetofend(struct tcp_sock, ecn_flags);
 		break;
+	case offsetof(struct tcp_sock, app_limited):
+		end = offsetofend(struct tcp_sock, app_limited);
+		break;
 	default:
 		bpf_log(log, "no write support to tcp_sock at off %d\n", off);
 		return -EACCES;
-- 
2.25.1

