Return-Path: <bpf+bounces-15138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3147ED932
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 03:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44E6CB20A75
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 02:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F166363A6;
	Thu, 16 Nov 2023 02:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYUIxyQN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31C81B2
	for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 18:18:35 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9f27af23443so46510366b.0
        for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 18:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700101114; x=1700705914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUL+bN8yHv3wOzc18L9Q7ZjkJM89Tjd4Zeep3So1oiE=;
        b=hYUIxyQN9Dn6T6bofR93c4YMqLctt+KLQsvd94ZZ02fqXqbCCGNGYkFI4tEn1wj2jJ
         LdtWhiBOG1mKzR2H7cK/7QBkbZ496PUh+9JclaeDzIQOmgGmFN5akJcaq++kS/QTbzAh
         HORMgTm73zFI5aTDLCvGjQY2HDAAjRuyWqB/g1yjUU2l9cHXihcxewt+9f4eCxQcJZN/
         oGCT6o48NMeFJLXNP9Wsql8xgqbcmsep2VmlxfwIXqE5vqsl7G/LOWVxX4/ghfrVDt6x
         sy88StZ52cDWDmGajsmUJjJGXgMbbcYAhq8ogb+B6k7NDP3XEAdsTUUMgoSBb8BAdPyk
         WdMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700101114; x=1700705914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LUL+bN8yHv3wOzc18L9Q7ZjkJM89Tjd4Zeep3So1oiE=;
        b=av8lPSgynYz7IBoXX1fO4OhtoX6gdKWU/BuIuVOF9gO0rO2ffswZNGiVt5QvMOyG14
         kcAMYW0fSvJ9DAhogWd2Vak+7EpuRRe8b8cWsmZdCsJx5jmz+t8Wmm3+LEEpEvNLhPK8
         QBsGqP4/xKvbtfbZO3RcW6p1G2DzMIRsjBggUhpCGnGkFBIsKGNdq9nDIH4kVsZzDjzu
         CvOL/ydhjqK8ONvTlXvhwukwLyVn9Wt3KcvBj06L1AiJSuDoMpQ2Ji+osgJZrK25AjSZ
         0z4KqsZuPt/Rz9Y3XqoTzRNq5LpqVJrcLb0OeIlrJ/L402pehqO1oG0bhI1he4Ee/h3U
         XSoQ==
X-Gm-Message-State: AOJu0YzvW+mPmoNAYBT636gtKz6OkezPBWg0m3lR6xUnDpMhNUQVsnZK
	k6r7vcg/IeXvEuZKajugbQV9G5nKFyKxWg==
X-Google-Smtp-Source: AGHT+IFXBF46tpHVsIbr2Jb+NhQQJ5rvi4+BYzu5n4JFFyKN/CmMcFRKboTA4mM/4H3Ee70oIHWZDw==
X-Received: by 2002:a17:906:840e:b0:9bf:4e0b:fb11 with SMTP id n14-20020a170906840e00b009bf4e0bfb11mr10134935ejx.8.1700101113776;
        Wed, 15 Nov 2023 18:18:33 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id ay1-20020a170906d28100b009dd606ce80fsm7774064ejb.31.2023.11.15.18.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 18:18:33 -0800 (PST)
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
Subject: [PATCH bpf 03/12] selftests/bpf: fix bpf_loop_bench for new callback verification scheme
Date: Thu, 16 Nov 2023 04:17:54 +0200
Message-ID: <20231116021803.9982-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231116021803.9982-1-eddyz87@gmail.com>
References: <20231116021803.9982-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch a few patches from this one changes logic for callbacks
handling. While previously callbacks were verified as a single
function call, new scheme takes into account that callbacks could be
executed unknown number of times.

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

W/o callbacks change for verifier it merely represents 1000 calls to
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
2.42.0


