Return-Path: <bpf+bounces-15285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 062687EFCF7
	for <lists+bpf@lfdr.de>; Sat, 18 Nov 2023 02:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A31091F27707
	for <lists+bpf@lfdr.de>; Sat, 18 Nov 2023 01:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6241846;
	Sat, 18 Nov 2023 01:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bECI/DG3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73326D79
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 17:34:11 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9c41e95efcbso359872566b.3
        for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 17:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700271249; x=1700876049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZXRa1/cwLFubHPOo6YRZAtb7YbB9fDg1BZF0J0f+nA=;
        b=bECI/DG3H2yhvX2m3f2HaMJwh7VPWVlogg3n3O/cN0ueimtFKLgW01rouuasDatl+a
         MD7H3YLue8eXPCfMQs5Ruub83hrQu64+ODLhy9tMVVegGDjsmoWGo+OzcYQsLpURdxmF
         WUeMdKb6ctjx8Zvm62ftKvkDh3BS2/PoWH1JZlA4ebBFI+ZleNEO8gs3L7PlQOXf4Rcr
         D24is97LDPlESFw+34FLd0oHcNWdgINsejsz6XK6+4PYX2/stGWd5fkF+V3Zzgv8k9dY
         7d74PkDAcR2hhRCKrE2VbYnPviTnVaG5LGRhZVDI+TEsl2fVX1lwFagH9WQXv4bTG8LA
         iK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700271249; x=1700876049;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PZXRa1/cwLFubHPOo6YRZAtb7YbB9fDg1BZF0J0f+nA=;
        b=jQrs53I3Bjyv1T9EIT2nnXLoPnvMYIfcWnJxurv10fIWbFvyGzFtC9leTrsJ0XojfH
         Wwi4r3UACzlBPfhTySYdJHXnQiXe9/bJq0s42WjlZnJP5MpN1eZ0xPjrRxKndU6bEeYK
         w07CDjks02PtCu7oqUEPMnk4wpMXqz75ldjWM1FAtrxIrbZr4lN/nzllf3StPukddL9h
         kE6XRLY3Z49a4TeHtmS1Av1J5iCQRM0Uyd8xH6pN0uieB42WYmucqYs/MYqsOYc7NSJz
         f7oA5ICdmeKSjhrJ0I93iVZDGAFtupY8F9m7OAud84cozNfOAaDuqpVCURXxPey6/7VI
         Di0A==
X-Gm-Message-State: AOJu0Yx3hi2AlALyoNpqRq+rcok4Z9RfeQV564qvOz669b7Y8y/GbguR
	uJmH5J78VhaWTNii4VoXEBvSHSATZns=
X-Google-Smtp-Source: AGHT+IFOx6EOynNi4tokQJ3VtXcROtiaf6GpJhqwOqMq1LmTnpJA2qJAZIo7FyZY89iibH87IN6s7g==
X-Received: by 2002:a17:907:6d01:b0:9f9:f840:9bba with SMTP id sa1-20020a1709076d0100b009f9f8409bbamr735447ejc.15.1700271249658;
        Fri, 17 Nov 2023 17:34:09 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id v27-20020a170906489b00b009d2eb40ff9dsm1359284ejq.33.2023.11.17.17.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 17:34:09 -0800 (PST)
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
Subject: [PATCH bpf v2 03/11] selftests/bpf: fix bpf_loop_bench for new callback verification scheme
Date: Sat, 18 Nov 2023 03:33:47 +0200
Message-ID: <20231118013355.7943-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231118013355.7943-1-eddyz87@gmail.com>
References: <20231118013355.7943-1-eddyz87@gmail.com>
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


