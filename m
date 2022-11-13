Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F44F6271EF
	for <lists+bpf@lfdr.de>; Sun, 13 Nov 2022 20:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235415AbiKMTHP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 13 Nov 2022 14:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235521AbiKMTHK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 13 Nov 2022 14:07:10 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF98101FB;
        Sun, 13 Nov 2022 11:07:10 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 130so8515793pgc.5;
        Sun, 13 Nov 2022 11:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glNV3HDqHMzCoh8Ah4WEKW8nahUdxNcLvcBYViX0gZ8=;
        b=hSpA6O/1bAppadSdY5CwcwJXT1oMMlDyuNvNxsYN+n4RIH37EWvdtlQmIgoDfiV3rW
         noDkWXvH9gbH7e3NzDFjD8UQa79GHmHFBATN2R+rPG4MCBAo2GweWh+7REUi2iyE9ZtB
         f2Gd48Pjgab6FGb67Ytp2S2eoQkHydUYSo+RS2x81U6AVdSnBkaL9q4GphYEA3wSpyak
         2XT7XfYB1APeYM8BcS9259vrfr/ZrL/ZjxCp83OTTe9//UjwAeGf0noLl7mLg49kATCN
         QYq++ZHNxj9fRG/1K3UQK6afEGltLIsUBqVq3w71mKws/K3SkqzlMDFLy48xdvUZbHLz
         iVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=glNV3HDqHMzCoh8Ah4WEKW8nahUdxNcLvcBYViX0gZ8=;
        b=sD+hph57cbBJfA6KQMFWTwKjcKbpgJZ4aRay3zEw0qJ0Ztjy2EG8Tq5b6utW/8GK7h
         IlDO2Dafo1Feky5nf11G6Ij7s3PclUTwtSao7hmVJjhw8Sut0YoySjEt5H9jbWInyNWU
         oD7spvlvJIch8/ZdITbw3f3wh24KAjgroa29AIBD2o1o8KdllowqtinxUqGzsI9py0W3
         RrSrb4G4UIUzNA1Kck5lKCwxHjX3mK+rqovXLVZAdm9GiGI7kZdMR2cgY1EcbcZtgcZZ
         g4zjv3uKbU6GJRpow0sSBL7nNXQdXcJjje+tRA7x0lCTUxkOqc3umoWJUz8vYuU3U3M0
         Y2fg==
X-Gm-Message-State: ANoB5pnO4txIF7uc3RnZ9t4pKpgZ1CjrxHmwuSsi/YCSMvNEBmUwGjc+
        +qGEGUJIYhiotAlS9QRC1oc=
X-Google-Smtp-Source: AA0mqf48KXUJPalT+LHRERflG9UpnnvyVGNnKnvdHceDMS85RRQLDUS3mYOUlkC3gzjbKKX9m9wTLA==
X-Received: by 2002:a63:5725:0:b0:451:c1b3:2708 with SMTP id l37-20020a635725000000b00451c1b32708mr9486182pgb.233.1668366429671;
        Sun, 13 Nov 2022 11:07:09 -0800 (PST)
Received: from localhost.localdomain ([14.5.161.132])
        by smtp.gmail.com with ESMTPSA id a4-20020a170902ecc400b001869f2120a5sm5549604plh.34.2022.11.13.11.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 11:07:09 -0800 (PST)
From:   Kang Minchul <tegongkang@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kang Minchul <tegongkang@gmail.com>
Subject: [PATCH v2 3/3] libbpf: checkpatch: Fixed code alignments in ringbuf.c
Date:   Mon, 14 Nov 2022 04:06:48 +0900
Message-Id: <20221113190648.38556-4-tegongkang@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221113190648.38556-1-tegongkang@gmail.com>
References: <20221113190648.38556-1-tegongkang@gmail.com>
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

Fixed some checkpatch issues in ringbuf.c

Signed-off-by: Kang Minchul <tegongkang@gmail.com>
---
 tools/lib/bpf/ringbuf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index d285171d4b69..51808c5f0014 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -128,7 +128,7 @@ int ring_buffer__add(struct ring_buffer *rb, int map_fd,
 	/* Map read-only producer page and data pages. We map twice as big
 	 * data size to allow simple reading of samples that wrap around the
 	 * end of a ring buffer. See kernel implementation for details.
-	 * */
+	 */
 	tmp = mmap(NULL, rb->page_size + 2 * info.max_entries, PROT_READ,
 		   MAP_SHARED, map_fd, rb->page_size);
 	if (tmp == MAP_FAILED) {
@@ -220,7 +220,7 @@ static inline int roundup_len(__u32 len)
 	return (len + 7) / 8 * 8;
 }
 
-static int64_t ringbuf_process_ring(struct ring* r)
+static int64_t ringbuf_process_ring(struct ring *r)
 {
 	int *len_ptr, len, err;
 	/* 64-bit to avoid overflow in case of extreme application behavior */
-- 
2.34.1

