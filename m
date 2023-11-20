Return-Path: <bpf+bounces-15441-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 438997F2111
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 00:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F08E92823B2
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 23:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9003AC1D;
	Mon, 20 Nov 2023 23:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkJgWQ1f"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431E0F5
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 15:00:07 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9ff26d7c0a6so172711666b.2
        for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 15:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700521204; x=1701126004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZXRa1/cwLFubHPOo6YRZAtb7YbB9fDg1BZF0J0f+nA=;
        b=kkJgWQ1fwPtR0r1HlqtjMxHW2yR4GZNdFkx4pxv02w+O2p0Bk8d82d1gxsR+lkxep1
         OZIBqWCWrmnyLVni9uHqTmMSODOFsobIH5doGcw3BjxxUEJ0kPHpCGJtB5wYj/uFnwMZ
         dFDuoYRQRcWS2pJC0eh5ZbfdteE+sOvw5T9SKVRGKSqCD8u0XH9eGUJ4CEcVvNNqkuAQ
         KWHufRlCziCk4pz+Smfq6QNxMX81RMTZBp9RmjADBEhvhJAN+CzPlTmU+xwBiw5qaakz
         0j3DTMfrbjPMOgAOvPH7vAk2pGJeijmlihSrAqDzILjVi7et71TekMajIE49qm0mBR8d
         0OTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700521204; x=1701126004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PZXRa1/cwLFubHPOo6YRZAtb7YbB9fDg1BZF0J0f+nA=;
        b=Af2GAP2U4lJlN6YtfD9tm7hXaoneoKMA0qz4wYEl+j/wxc07isD0DFKsREltR8EQJQ
         M9BZoiNoYPbtJjJVljBWaif38i9jqbBCt5RtwvS8YKwG2wCzAI2CZIfoB4nvm4EPzV8J
         PRyeh5Ep2f2eqrvKzH+eHBP6eCis2oj1h5zqLWhQ9PGHQhlKEW6rqopBAkv4CZ+ucp6G
         XO/k+8w9skIRRXb/NmhoL9MzvXVp5NOLa16s7eJQPbyk1HJUwcGvLJ5XIQLgc41RbzqZ
         d6z6Vj64Rs4Mi1MsAxHd6IfR45dRAELv/ZecUlkMpBWNm8AFicTEzjYIk37Qh0kQJmVj
         ariA==
X-Gm-Message-State: AOJu0Yzdx6U4Kle+hRRq/EQBVjGNjZc99HZ5qvLEakb65sPbGmtAY29k
	6vqBdga+yqyEiWhOQBpXf10ZwvBzyJ6qmA==
X-Google-Smtp-Source: AGHT+IFeBIYsURkZVWbpJSvNx8j9XRepqMiou/uN6M4ToM+TLkcn4Op7G3PrJJlaRr5Xs1xr1gVmDw==
X-Received: by 2002:a17:906:535b:b0:a01:cb1b:f13f with SMTP id j27-20020a170906535b00b00a01cb1bf13fmr101413ejo.43.1700521204064;
        Mon, 20 Nov 2023 15:00:04 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id a9-20020a170906468900b009fd6a22c2e9sm1968039ejr.138.2023.11.20.15.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 15:00:03 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	memxor@gmail.com,
	awerner32@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf v3 03/11] selftests/bpf: fix bpf_loop_bench for new callback verification scheme
Date: Tue, 21 Nov 2023 00:59:37 +0200
Message-ID: <20231120225945.11741-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231120225945.11741-1-eddyz87@gmail.com>
References: <20231120225945.11741-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is a preparatory change. A follow-up patch "bpf: verify callbacks
as if they are called unknown number of times" changes logic for
callbacks handling. While previously callbacks were verified as a
single function call, new scheme takes into account that callbacks
could be executed unknown number of times.

This has dire implications for bpf_loop_bench:

    SEC("fentry/" SYS_PREFIX "sys_getpgid")
    int benchmark(void *ctx)
    {
            for (int i = 0; i < 1000; i++) {
                    bpf_loop(nr_loops, empty_callback, NULL, 0);
                    __sync_add_and_fetch(&hits, nr_loops);
            }
            return 0;
    }

W/o callbacks change verifier sees it as a 1000 calls to
empty_callback(). However, with callbacks change things become
exponential:
- i=0: state exploring empty_callback is scheduled with i=0 (a);
- i=1: state exploring empty_callback is scheduled with i=1;
  ...
- i=999: state exploring empty_callback is scheduled with i=999;
- state (a) is popped from stack;
- i=1: state exploring empty_callback is scheduled with i=1;
  ...

Avoid this issue by rewriting outer loop as bpf_loop().
Unfortunately, this adds a function call to a loop at runtime, which
negatively affects performance:

            throughput               latency
   before:  149.919 ± 0.168 M ops/s, 6.670 ns/op
   after :  137.040 ± 0.187 M ops/s, 7.297 ns/op

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/bpf_loop_bench.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_loop_bench.c b/tools/testing/selftests/bpf/progs/bpf_loop_bench.c
index 4ce76eb064c4..d461746fd3c1 100644
--- a/tools/testing/selftests/bpf/progs/bpf_loop_bench.c
+++ b/tools/testing/selftests/bpf/progs/bpf_loop_bench.c
@@ -15,13 +15,16 @@ static int empty_callback(__u32 index, void *data)
 	return 0;
 }
 
+static int outer_loop(__u32 index, void *data)
+{
+	bpf_loop(nr_loops, empty_callback, NULL, 0);
+	__sync_add_and_fetch(&hits, nr_loops);
+	return 0;
+}
+
 SEC("fentry/" SYS_PREFIX "sys_getpgid")
 int benchmark(void *ctx)
 {
-	for (int i = 0; i < 1000; i++) {
-		bpf_loop(nr_loops, empty_callback, NULL, 0);
-
-		__sync_add_and_fetch(&hits, nr_loops);
-	}
+	bpf_loop(1000, outer_loop, NULL, 0);
 	return 0;
 }
-- 
2.42.1


