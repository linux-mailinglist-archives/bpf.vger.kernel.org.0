Return-Path: <bpf+bounces-6068-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 827E37652BF
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 13:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B407E1C2148C
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 11:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5E216409;
	Thu, 27 Jul 2023 11:43:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D142A156C8
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 11:43:18 +0000 (UTC)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E181FDA
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 04:43:17 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bb8a89b975so4582715ad.1
        for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 04:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690458197; x=1691062997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KSdNIEoWyxN64G3PuLCbHAuu2HXfBkfthuEftdLRkGg=;
        b=bTAxdUAGLlz58yVgYY49vsBbym3SrJ/RUSuNMjBoOQ6F20CwyTKfRmjLXbqsjFx6pK
         GupcswAbxXrqhkd/Mi1o6abY5e89m4H10Y10lUX0ZWyXVLOr0Rv9V8OyYPRJx7BADBCz
         4mLeClw6mRVSx2Wrcx+GNMqjF4jhd1ranifnPuNIVPpOqeVMb2AJdPasdeO5g2D53LOb
         DKhvfPUu/bRi36NpXfIsbI8QIT2xBRJmBG2E069F2Hlh2g2d2wxhPO+w/Hx6VoTTx8Av
         3M2VigkzawP6KeLDdAmUPPHNqJ2TVqnHZbl11w6f5oHKZP8UX374EKzgXEpltELQRj8U
         RNTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690458197; x=1691062997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KSdNIEoWyxN64G3PuLCbHAuu2HXfBkfthuEftdLRkGg=;
        b=T5J96lvlt2hH7iqZ8X+po9aAscAfQre1KSj3FW+Ko8m8Dz5VzZNeGz31oQ9LYPW1Xm
         9SQ1pF01Dk/bZ+AbtFjVeHZGrlReC6SqGKLPTeAIhwgm1CtrYTqO/UZsYjKaPS+IwoLT
         Alzu3NJ83gvYmViV99/tfAkPmBR6g/kHueHodrNIvoWJlR89Msv526c1s8lwEgLl13iX
         vWxNDmn1R+rNSQ/A5ROfIi4NHzXkTKmJ3zmM20s2vlV5NAuqQIOxRM/67fofmQbf4g1k
         r029gQ6bXvmLHlMQQ6NS5yshV29wzskO3AMrPm8tImFmVRN+RN6M2eHudeqZt2gl50Ev
         Zc9A==
X-Gm-Message-State: ABy/qLb2HgZG27MgurGIr+AuMgDSnLpGFGOoZb85UYWdidk2jvvmPxP9
	PiMXR/UUESVDWcbMJjOVjQ0=
X-Google-Smtp-Source: APBJJlFFP7ZHuo4v6b4n3QP5jO6/CSDnWZ5DA5KVSPtxaJzNhxD/RiMkRDyUJlTZF4CB3KVXSrHTFQ==
X-Received: by 2002:a17:902:b68f:b0:1b8:a7ec:38c5 with SMTP id c15-20020a170902b68f00b001b8a7ec38c5mr3582951pls.57.1690458196939;
        Thu, 27 Jul 2023 04:43:16 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:1e6:5400:4ff:fe85:7796])
        by smtp.gmail.com with ESMTPSA id z1-20020a170903018100b001b6a27dff99sm1419106plg.159.2023.07.27.04.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 04:43:16 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v2 bpf-next 1/2] bpf: Fix uninitialized symbol in bpf_perf_link_fill_kprobe()
Date: Thu, 27 Jul 2023 11:43:08 +0000
Message-Id: <20230727114309.3739-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230727114309.3739-1-laoar.shao@gmail.com>
References: <20230727114309.3739-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The patch 1b715e1b0ec5: "bpf: Support ->fill_link_info for
perf_event" from Jul 9, 2023, leads to the following Smatch static
checker warning:

    kernel/bpf/syscall.c:3416 bpf_perf_link_fill_kprobe()
    error: uninitialized symbol 'type'.

That can happens when uname is NULL. So fix it by verifying the uname
when we really need to fill it.

Fixes: 1b715e1b0ec5 ("bpf: Support ->fill_link_info for perf_event")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/bpf/85697a7e-f897-4f74-8b43-82721bebc462@kili.mountain/
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/syscall.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 7f4e8c3..ad9360d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3376,16 +3376,16 @@ static int bpf_perf_link_fill_common(const struct perf_event *event,
 	size_t len;
 	int err;
 
-	if (!ulen ^ !uname)
-		return -EINVAL;
-	if (!uname)
-		return 0;
-
 	err = bpf_get_perf_event_info(event, &prog_id, fd_type, &buf,
 				      probe_offset, probe_addr);
 	if (err)
 		return err;
 
+	if (!ulen ^ !uname)
+		return -EINVAL;
+	if (!uname)
+		return 0;
+
 	if (buf) {
 		len = strlen(buf);
 		err = bpf_copy_to_user(uname, buf, ulen, len);
-- 
1.8.3.1


