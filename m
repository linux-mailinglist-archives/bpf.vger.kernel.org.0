Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C2B6CD368
	for <lists+bpf@lfdr.de>; Wed, 29 Mar 2023 09:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjC2Hht (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Mar 2023 03:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjC2Hh2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Mar 2023 03:37:28 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87AF4228
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 00:36:13 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id cn12so59581221edb.4
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 00:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680075371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ztd0KgIXeQoTeQt8kH2BMoSJXaFYVg5c2Jzxu9WIvSo=;
        b=SRq4EOpBxfTcm3Gp7II/58p1MRvThz+N+dd50h8frg6M9v8S7O4ugwKP3jgS6ssXPS
         yCtjrYVJh408/UX5HYENcht4BZhVzwWR8qP/qbZj2VOvWu7VH09Fm1eUlwRjCRP2yZra
         5PXYVknv/SEAISoohuuBcnro7gaHG+kObezT4/ZM86GImdjNEz4wDkvd3gnm+Q1oAmnn
         rt6RP38i+aU6iJuI8c82AeJcyL+ix+BdcyjPUW7H++Q40Ott2jGYm2OozeFGUTC/35Jc
         x83QDgy1YY9dO9dED61pXW4ERf5tACUdSt8OT3kgy2ffv6M5GoWaHgJkIEOTCrKLEAkX
         o9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680075371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ztd0KgIXeQoTeQt8kH2BMoSJXaFYVg5c2Jzxu9WIvSo=;
        b=V3Xdi8poAhPlQW/gRQSZHQjcHTz0IvsKxMoagq5OrxWJxE7BfwGw+E7y04HaKfvIxB
         9vOZWoBzPLP4VdzF2ble5vfxn5Qkuo1VyvYUAafeRNXRfL+Qf9QbgvZab+hMUfYEfrZP
         aple0bYuFwruBcISC03HwmnKer9USF08SlJEcQsu5Lgfs9p49tU1qYd5vS9HxGXms7SO
         xSg79LHABzqxdQXXh1805lqw6GPxuXIdgR24VjuQSV8bOFtEunLh/evWKh8NtLpIcMnX
         Pt9OndsnZHA5/8YnBrZPPY9ecVUmEq5YnYpKwwufZ/CmCOOSmui8yVNz0acXIDYq26Kj
         pf+Q==
X-Gm-Message-State: AAQBX9ek1jNYh7Me0MotdI/aedAsWfYWUNBF7rtpzWlpz75358DBkVaq
        xVezogyfANnDlq3Hl8KvyGHuNxn+agvyAJh507I=
X-Google-Smtp-Source: AKy350YEnWZzV9wRW02sTS48HvqRGGTDtqGEXUCUvI/gyIiMGurukLMZLfEPcrrTs05ZxxfTFiNN6A==
X-Received: by 2002:a17:906:2cc8:b0:93d:cbf8:ca14 with SMTP id r8-20020a1709062cc800b0093dcbf8ca14mr17394187ejr.75.1680075371463;
        Wed, 29 Mar 2023 00:36:11 -0700 (PDT)
Received: from localhost.localdomain ([45.35.56.2])
        by smtp.gmail.com with ESMTPSA id g10-20020a17090670ca00b0093b8c0952e4sm9719041ejk.219.2023.03.29.00.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 00:36:11 -0700 (PDT)
From:   Yixin Shen <bobankhshen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, song@kernel.org, yhs@fb.com,
        bobankhshen@gmail.com
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: test a BPF CC writing app_limited
Date:   Wed, 29 Mar 2023 07:35:58 +0000
Message-Id: <20230329073558.8136-3-bobankhshen@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230329073558.8136-1-bobankhshen@gmail.com>
References: <20230329073558.8136-1-bobankhshen@gmail.com>
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

Test whether a TCP CC implemented in BPF is allowed to write
app_limited in struct tcp_sock. This is already allowed for
the built-in TCP CC.

Signed-off-by: Yixin Shen <bobankhshen@gmail.com>
---
 .../selftests/bpf/progs/tcp_ca_write_sk_pacing.c    | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/tcp_ca_write_sk_pacing.c b/tools/testing/selftests/bpf/progs/tcp_ca_write_sk_pacing.c
index 43447704cf0e..0724a79cec78 100644
--- a/tools/testing/selftests/bpf/progs/tcp_ca_write_sk_pacing.c
+++ b/tools/testing/selftests/bpf/progs/tcp_ca_write_sk_pacing.c
@@ -16,6 +16,16 @@ static inline struct tcp_sock *tcp_sk(const struct sock *sk)
 	return (struct tcp_sock *)sk;
 }
 
+static inline unsigned int tcp_left_out(const struct tcp_sock *tp)
+{
+	return tp->sacked_out + tp->lost_out;
+}
+
+static inline unsigned int tcp_packets_in_flight(const struct tcp_sock *tp)
+{
+	return tp->packets_out - tcp_left_out(tp) + tp->retrans_out;
+}
+
 SEC("struct_ops/write_sk_pacing_init")
 void BPF_PROG(write_sk_pacing_init, struct sock *sk)
 {
@@ -31,11 +41,12 @@ SEC("struct_ops/write_sk_pacing_cong_control")
 void BPF_PROG(write_sk_pacing_cong_control, struct sock *sk,
 	      const struct rate_sample *rs)
 {
-	const struct tcp_sock *tp = tcp_sk(sk);
+	struct tcp_sock *tp = tcp_sk(sk);
 	unsigned long rate =
 		((tp->snd_cwnd * tp->mss_cache * USEC_PER_SEC) << 3) /
 		(tp->srtt_us ?: 1U << 3);
 	sk->sk_pacing_rate = min(rate, sk->sk_max_pacing_rate);
+	tp->app_limited = (tp->delivered + tcp_packets_in_flight(tp)) ?: 1;
 }
 
 SEC("struct_ops/write_sk_pacing_ssthresh")
-- 
2.25.1

