Return-Path: <bpf+bounces-15485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 189CD7F2399
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 03:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48F9A1C218E1
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 02:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C932114296;
	Tue, 21 Nov 2023 02:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUb3+44X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABE992
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 18:07:28 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5446c9f3a77so7341523a12.0
        for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 18:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700532445; x=1701137245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZXRa1/cwLFubHPOo6YRZAtb7YbB9fDg1BZF0J0f+nA=;
        b=FUb3+44XqdiHdTB/MycfOoPyiHnwig6vglkVX7tQWUt9NafCtHwKJnxbC/ZAvAeJtc
         nQ+TzF+L6uzZmpFreI1Rxsiu6VS5PomWwHJNcHm2lZ6SF3oGFGYwnUtYne214nKxj5Mb
         NSsZQuM0U7sAPWlBTTtqyFEhbjgEL42gGauikn/z++rv1bZNkGmFcJ5rQgOSHrWA8iF7
         EhWlwEO/KBA0X4iUurUQo98+kgaacUR7dMdBag1tOOL2cM0rkjYHkQtqSbjndtPm8UA8
         FAWQLkV330fY9PAC6kpPnwkqOHtmsM/+lG1mUc6MdkBHFyPbnbJ5siTW74MrS9kBUpNU
         zqHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700532445; x=1701137245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PZXRa1/cwLFubHPOo6YRZAtb7YbB9fDg1BZF0J0f+nA=;
        b=rtnaRgw7LK5oO5TGZ9GiheWwTl2CkRE+7MPBAbSanbF6X4HLh0fwuzsZX7BzVUVsJ7
         BLFbB9FvMxIoljiUwgtvSlEkzfBjhAWJ3TubSKO9axei+EsRnfagTkQNgBs372w2f0Mh
         gBKIyJvgydhuYoS57kftYhAF+Wi3DAqxkJJlceWRBGF6qQwInS+kMOlGgR/iLPgAv5N/
         V4gJAj1PX3gvkDu7wp9o9jKm15J0A02WcW8JFaDoDkvbEdwdsjuD5+uikXpcOxbncdFu
         1+qVv/lEAS26oT0uW38t5SiJH+pxcYtxzkTZL+U92e/M1HucoHykjjhkvZZB8jX5VCmB
         gf8A==
X-Gm-Message-State: AOJu0Yy1Parw9c6Mr7mXFRELOO7hn6d/RNwglAtij5rr24nqJN7oAtdX
	Mcgwh+LBK802iMRkGr88K5orCsJU4tYL7A==
X-Google-Smtp-Source: AGHT+IFM1lS5Vrlf9cDSgr3gIERoy3AJtTb1B88cyF6ek3YFtrJbB1xcWYr4EvbUfUc0zwumTI/RwA==
X-Received: by 2002:a17:906:a243:b0:9d4:2042:775b with SMTP id bi3-20020a170906a24300b009d42042775bmr7528789ejb.30.1700532445494;
        Mon, 20 Nov 2023 18:07:25 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id ha7-20020a170906a88700b009fc990d9edbsm2426668ejb.192.2023.11.20.18.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 18:07:23 -0800 (PST)
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
Subject: [PATCH bpf v4 03/11] selftests/bpf: fix bpf_loop_bench for new callback verification scheme
Date: Tue, 21 Nov 2023 04:06:53 +0200
Message-ID: <20231121020701.26440-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231121020701.26440-1-eddyz87@gmail.com>
References: <20231121020701.26440-1-eddyz87@gmail.com>
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


