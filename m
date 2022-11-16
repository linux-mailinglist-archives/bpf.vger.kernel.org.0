Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA8862B375
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 07:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiKPGql (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 01:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiKPGqk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 01:46:40 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1C8286DA;
        Tue, 15 Nov 2022 22:46:39 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id v28so16592944pfi.12;
        Tue, 15 Nov 2022 22:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l9EiJ25n++7znh9J7WxtOwiU22GdLesWLAuGdvSt8Mk=;
        b=fXKYH+vM/bjons48DuHzNEYQqS6Kn8v+CpylJCKVpmNNjeoTWJ4ndYmHca05b3HEj6
         QZijJKvtNLL09lgcDSK+U2IEwRcLbWkAS3ReVY7gV4/0+e25MEJ1zWsxjSH4bZzjXH3G
         AKsRDBBHkL2IcqmP2j0qB9I+TovwOE4RmrRL3rkKlYtTbzlh0BnFRjU9BoMAsnd3ACYD
         yAnvSfftOtiFKL3AZCCdvSs3k6U1j4cMkgT5J0Swy2CysQmpNz+C0PZNQytoSPvxnbBm
         kX45aPrGhXjs0vc8toSYZrfKwT3AlM8H4sQmXlIAdD2HLdgLRz92LitFQoXIuCU0P1Hb
         ZXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l9EiJ25n++7znh9J7WxtOwiU22GdLesWLAuGdvSt8Mk=;
        b=e8RHn/ma/88NFvsusLIh8sWyYXWWDRmqRp9HSOUxUR3CnblI5t40l87F7U8yUqSbTA
         5zZEFQ7nSC1oLY4fPw7nsa0XO461HELrd1+LIzBleWGNS0z+9IXAiTjakG0VUTDLmYzO
         BpJsSRl22edFVf5E60QiaQg4YMCFbrG2hZGfxlL6jEcyPm3O7W40vt8o2E5pkMRbQ+iw
         6VLLMTREYx7WNIr1JaL22u63qvWXjKH6DoERQy1K9Gvm9zyEuoosWJFDN86lOvx9XHtJ
         zcWNCv4p9MjTIQIDKLDXB+N2H2EXswsSiBqHHHvn4RVP+d7hFQ1jSYmEMEFqStAYlnvf
         pGwA==
X-Gm-Message-State: ANoB5pn/iI0qZAKMdMv+jkHTdIRECNI0LDn/bZ7ZEOAwTHkV+VTij4Zx
        yf00AkS1AI2BPq3F0iLHAKE=
X-Google-Smtp-Source: AA0mqf6ggRaXMeqRzBAY6BeqyR6T4ZDEU0UWbcwnNbGSk0R4lnaO0o3uB8vu5/AIVP1byFnz1O8CRA==
X-Received: by 2002:a05:6a00:4009:b0:56e:7b62:bba with SMTP id by9-20020a056a00400900b0056e7b620bbamr21786967pfb.55.1668581198601;
        Tue, 15 Nov 2022 22:46:38 -0800 (PST)
Received: from localhost.localdomain ([14.5.161.132])
        by smtp.gmail.com with ESMTPSA id g190-20020a6252c7000000b0057255b82bd1sm3820012pfb.217.2022.11.15.22.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 22:46:38 -0800 (PST)
From:   Kang Minchul <tegongkang@gmail.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kang Minchul <tegongkang@gmail.com>
Subject: [PATCH] samples, bpf: Add duration option D for sampleip
Date:   Wed, 16 Nov 2022 15:46:31 +0900
Message-Id: <20221116064631.16224-1-tegongkang@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Although sampleip program can handle three options,
(-F for frequency, duration, and -h for help)
currently there is no independent option for duration.

This patch adds option -D for duration like below:

$ sudo ./samples/bpf/sampleip -h
USAGE: sampleip [-F freq] [-D duration]
       -F freq       # sample frequency (Hertz), default 99
       -D duration   # sampling duration (seconds), default 5

$ sudo ./samples/bpf/sampleip -F 120
Sampling at 120 Hertz for 5 seconds. Ctrl-C also ends.
ADDR                KSYM                          COUNT
...

$ sudo ./samples/bpf/sampleip -D 7
Sampling at 99 Hertz for 7 seconds. Ctrl-C also ends.
ADDR                KSYM                          COUNT
...

$ sudo ./samples/bpf/sampleip -F 120 -D 7
Sampling at 120 Hertz for 7 seconds. Ctrl-C also ends.
ADDR                KSYM                          COUNT
...

Signed-off-by: Kang Minchul <tegongkang@gmail.com>
---
 samples/bpf/sampleip_user.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/samples/bpf/sampleip_user.c b/samples/bpf/sampleip_user.c
index 921c505bb567..ce6aadd496e1 100644
--- a/samples/bpf/sampleip_user.c
+++ b/samples/bpf/sampleip_user.c
@@ -28,9 +28,9 @@ static int nr_cpus;
 
 static void usage(void)
 {
-	printf("USAGE: sampleip [-F freq] [duration]\n");
-	printf("       -F freq    # sample frequency (Hertz), default 99\n");
-	printf("       duration   # sampling duration (seconds), default 5\n");
+	printf("USAGE: sampleip [-F freq] [-D duration]\n");
+	printf("       -F freq       # sample frequency (Hertz), default 99\n");
+	printf("       -D duration   # sampling duration (seconds), default 5\n");
 }
 
 static int sampling_start(int freq, struct bpf_program *prog,
@@ -145,19 +145,20 @@ int main(int argc, char **argv)
 	char filename[256];
 
 	/* process arguments */
-	while ((opt = getopt(argc, argv, "F:h")) != -1) {
+	while ((opt = getopt(argc, argv, "F:D:h")) != -1) {
 		switch (opt) {
 		case 'F':
 			freq = atoi(optarg);
 			break;
+		case 'D':
+			secs = atoi(optarg);
+			break;
 		case 'h':
 		default:
 			usage();
 			return 0;
 		}
 	}
-	if (argc - optind == 1)
-		secs = atoi(argv[optind]);
 	if (freq == 0 || secs == 0) {
 		usage();
 		return 1;
-- 
2.34.1

