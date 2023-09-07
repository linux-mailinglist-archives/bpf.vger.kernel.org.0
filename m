Return-Path: <bpf+bounces-9458-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD91A797DA6
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 23:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 946682817C9
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 21:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DF41427B;
	Thu,  7 Sep 2023 21:00:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CA613AD7
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 21:00:28 +0000 (UTC)
Received: from mail-oi1-x24a.google.com (mail-oi1-x24a.google.com [IPv6:2607:f8b0:4864:20::24a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1651990
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 14:00:27 -0700 (PDT)
Received: by mail-oi1-x24a.google.com with SMTP id 5614622812f47-3ab3059eb0cso1522779b6e.3
        for <bpf@vger.kernel.org>; Thu, 07 Sep 2023 14:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694120426; x=1694725226; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JhMzm+KbEst9kEn5FMItaBx+JYFlB6NLMmMQizjB7e8=;
        b=IpyNQ4EbyCBpbexprQB5/5wQRqulj0ZsAdqvlO5EpZ7PGlWEYm4B6X5S2+4lh0exgF
         mGlGkljx4ggqGM/R8NIEkVRmirCy9fwSjiK4NcdNRXYMVelaj1CQOsuWN7uJfDWw65mR
         rw+r67KEyq5/STen8joTpJRo8DVTmlSMkMOEgGY1tLpoF9MiSreXEECMp08ihDEG/NCR
         DzD+WFZGyhx/1360s6UsUHG9vL4/ZnFWekGfUIGFHnVti5Tcm72ssjrT4oof3sVRQzJT
         lOmST1w/zdnTVvpWSqIs6IYI9bvW3U+LmxGy9n1AWSSZGoSOkrBvQL9knEidcwYLpdMb
         +8CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694120426; x=1694725226;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JhMzm+KbEst9kEn5FMItaBx+JYFlB6NLMmMQizjB7e8=;
        b=ABSpAzbNbvQHNvBM473QsLQsHPCWc4yeTit2tVrLd3W0vXUzWtqbIqbz7iqMwORMPv
         0eih24MtrZZ52jDDGZ2o6YTN1XHLqqwNg+gOSKJYnfLQgJJ8Nds7OjKRwCqELpjyF15z
         7Pv+eoKlUfBh5RgKktJGVDwg34sBY/yj/yVS6MLbxMp4quyQTVB+gDolHaOvG4U9ff+P
         Z1HG/SuSvPov6cDgOuRB5Yrb3ZXhqSupm/omY2IMViWAi1jp3HhLfI3Av4uS5a8Mef0Y
         lt6VHGQQHzFFq0+HGI+C5rJM7BZpnenuBaiBqThm9EQckx2JNUUWCI5FfQJFADn7n1WP
         12Gw==
X-Gm-Message-State: AOJu0YwCBl6th4vuZXWx9WXYrMWGQUOkyM/N9yB+4KmYyC6vaEXhgL5e
	abfK/2NWk6K7+kB6SbpTbWIJO91JHI5vO//Oqs1d0QpuRjtq9EOt2t+X7sN7qjEiAcbEhtV/80r
	TywzepK6weqotXtLrpiLBSj0bGGMAvZrkne2tU5iRwWBKVeUFrQ==
X-Google-Smtp-Source: AGHT+IGJA0/8ucRxm1+PbMQc5GmL+pquY3KCwQ2gGjwF1g7OXRuRDQkuhcna3PPNR32hJ0RmmGg4pIE=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6808:1405:b0:3a4:1e93:8988 with SMTP id
 w5-20020a056808140500b003a41e938988mr16320oiv.10.1694120426077; Thu, 07 Sep
 2023 14:00:26 -0700 (PDT)
Date: Thu,  7 Sep 2023 14:00:23 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230907210023.2467151-1-sdf@google.com>
Subject: [PATCH bpf-next] selftests/bpf: Future-proof connect4_prog.c
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

With the new internal clang version I see the following optimization
that makes connect4 program unverifiable.

The following code:

	int do_bind()
	{
		if (bpf_bind() != 0)
			return 0;
		return 1;
	}
	int connect_v4_prog()
	{
		return do_bind() ? 1 : 0;
	}

Becomes:

	int do_bind()
	{
		if (bpf_bind() != 0)
			return 0;
		return 1;
	}
	int connect_v4_prog()
	{
		return do_bind();
	}

IOW, looks like clang is able to see that do_bind returns only 0 and
1 and the extra branch around 'return do_bind' is not needed.
This, however, seems to break the verifier, which assumes that
bpf2bpf calls can return 0-0xffffffff.

Note, I can produce those programs only with the internal fork of clang.
The latest one from git still produced correct bytecode. It might be
some options/optimizations that we enable and that are still
disabled for the general upstream users, not sure. I've desided
to send this patch out anyway since it seems like a correct optimization
the compiler might do.

So to be future-proof, reshape the code a bit to return bpf_bind
result directly. This will not give any hint to the clang about
the return value and will force it generate that '? 1: 0' branch
at the callee.

Good program:

0000000000000000 <do_bind>:
       0:       b4 02 00 00 7f 00 00 04 w2 = 0x400007f
       1:       63 2a f4 ff 00 00 00 00 *(u32 *)(r10 - 0xc) = r2
       2:       b4 02 00 00 02 00 00 00 w2 = 0x2
       3:       63 2a f0 ff 00 00 00 00 *(u32 *)(r10 - 0x10) = r2
       4:       b7 02 00 00 00 00 00 00 r2 = 0x0
       5:       63 2a fc ff 00 00 00 00 *(u32 *)(r10 - 0x4) = r2
       6:       63 2a f8 ff 00 00 00 00 *(u32 *)(r10 - 0x8) = r2
       7:       bf a2 00 00 00 00 00 00 r2 = r10
       8:       07 02 00 00 f0 ff ff ff r2 += -0x10
       9:       b4 03 00 00 10 00 00 00 w3 = 0x10
      10:       85 00 00 00 40 00 00 00 call 0x40
      11:       bf 01 00 00 00 00 00 00 r1 = r0
      12:       b4 00 00 00 01 00 00 00 w0 = 0x1
      13:       15 01 01 00 00 00 00 00 if r1 == 0x0 goto +0x1 <LBB0_2>
      14:       b4 00 00 00 00 00 00 00 w0 = 0x0

00000000000001b0 <LBB1_30>:
      54:       bc 60 00 00 00 00 00 00 w0 = w6
      55:       95 00 00 00 00 00 00 00 exit

0000000000000578 <LBB1_28>:
     ...
     180:       85 10 00 00 ff ff ff ff call -0x1
     181:       b4 06 00 00 01 00 00 00 w6 = 0x1
     182:       56 00 7f ff 00 00 00 00 if w0 != 0x0 goto -0x81 <LBB1_30>
     183:       b4 06 00 00 00 00 00 00 w6 = 0x0
     184:       05 00 7d ff 00 00 00 00 goto -0x83 <LBB1_30>

Bad program:
0000000000000000 <do_bind>:
       0:       b4 02 00 00 7f 00 00 04 w2 = 0x400007f
       1:       63 2a f4 ff 00 00 00 00 *(u32 *)(r10 - 0xc) = r2
       2:       b4 02 00 00 02 00 00 00 w2 = 0x2
       3:       63 2a f0 ff 00 00 00 00 *(u32 *)(r10 - 0x10) = r2
       4:       b7 02 00 00 00 00 00 00 r2 = 0x0
       5:       63 2a fc ff 00 00 00 00 *(u32 *)(r10 - 0x4) = r2
       6:       63 2a f8 ff 00 00 00 00 *(u32 *)(r10 - 0x8) = r2
       7:       bf a2 00 00 00 00 00 00 r2 = r10
       8:       07 02 00 00 f0 ff ff ff r2 += -0x10
       9:       b4 03 00 00 10 00 00 00 w3 = 0x10
      10:       85 00 00 00 40 00 00 00 call 0x40
      11:       bf 01 00 00 00 00 00 00 r1 = r0
      12:       b4 00 00 00 01 00 00 00 w0 = 0x1
      13:       15 01 01 00 00 00 00 00 if r1 == 0x0 goto +0x1 <LBB0_2>
      14:       b4 00 00 00 00 00 00 00 w0 = 0x0

00000000000001b0 <LBB1_3>:
      54:       bc 60 00 00 00 00 00 00 w0 = w6
      55:       95 00 00 00 00 00 00 00 exit

0000000000000578 <LBB1_28>:
     ...
     180:       85 10 00 00 ff ff ff ff call -0x1
     181:       bc 06 00 00 00 00 00 00 w6 = w0
     182:       05 00 7f ff 00 00 00 00 goto -0x81 <LBB1_3>

Cc: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/progs/connect4_prog.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/connect4_prog.c b/tools/testing/selftests/bpf/progs/connect4_prog.c
index 7ef49ec04838..b7fc46a0787b 100644
--- a/tools/testing/selftests/bpf/progs/connect4_prog.c
+++ b/tools/testing/selftests/bpf/progs/connect4_prog.c
@@ -41,10 +41,7 @@ int do_bind(struct bpf_sock_addr *ctx)
 	sa.sin_port = bpf_htons(0);
 	sa.sin_addr.s_addr = bpf_htonl(SRC_REWRITE_IP4);
 
-	if (bpf_bind(ctx, (struct sockaddr *)&sa, sizeof(sa)) != 0)
-		return 0;
-
-	return 1;
+	return bpf_bind(ctx, (struct sockaddr *)&sa, sizeof(sa));
 }
 
 static __inline int verify_cc(struct bpf_sock_addr *ctx,
@@ -194,7 +191,7 @@ int connect_v4_prog(struct bpf_sock_addr *ctx)
 	ctx->user_ip4 = bpf_htonl(DST_REWRITE_IP4);
 	ctx->user_port = bpf_htons(DST_REWRITE_PORT4);
 
-	return do_bind(ctx) ? 1 : 0;
+	return do_bind(ctx) ? 0 : 1;
 }
 
 char _license[] SEC("license") = "GPL";
-- 
2.42.0.283.g2d96d420d3-goog


