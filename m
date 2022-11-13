Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530C4627045
	for <lists+bpf@lfdr.de>; Sun, 13 Nov 2022 16:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235360AbiKMPnb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 13 Nov 2022 10:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235318AbiKMPnY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 13 Nov 2022 10:43:24 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C64EDFA4;
        Sun, 13 Nov 2022 07:43:20 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id c15-20020a17090a1d0f00b0021365864446so8517903pjd.4;
        Sun, 13 Nov 2022 07:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glNV3HDqHMzCoh8Ah4WEKW8nahUdxNcLvcBYViX0gZ8=;
        b=nNZNx9+rD9hhlxFWnzjwqye866AAw4Zp9rfcLne1PPKJKIsmuvbbvYL62tp5H3nXqm
         4pSLeCsdqgY/LAGUXMdTM/dCX7B4Meu7R2VOZo/j7b0x+z71eLuTCaMzHMFSmdys3ruc
         Wz7QBgNipSs93wmCgki5OLgre/O/235tsQB1GncwwXhHANIMoFtyH5PPkxL/Lep7PyVM
         8sVPYlGRnZH8bNJTICvUZX5xPwQhekOW3OOnHtfY1juN+eEPMmi0fxwHLXsUXHTBRo7I
         mXOp17yj3D7vdIDTkJZLF6HsCvQUsHvMF+ChOlPjsZjtJoJSmimwDGdEXui6iXS7LAqq
         bdrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=glNV3HDqHMzCoh8Ah4WEKW8nahUdxNcLvcBYViX0gZ8=;
        b=11BsM0Adz3JhRCdaWNs+LHVGg47rpJhMWrN92RldCQu8HiQDowCALdTYdwVczEleMq
         TqNK8xhFWOtRXoju/pVYoJNQ01dJmduDmZeaCze6Jq0Z4Emk8W/bQUWnIixGJviAghxb
         5pNAfXjjLW68zrNgYEtw4fQCvX/z9GwiNb2dhEZp7ltwfo3Oqo4lFoo3zjy8yknftr3E
         BypnbbdYsvdUcLL4xCeqdhOTp3IYe1Vg/KWR0BozeYuZitqYUHKqbSGsgklM7uM2Zxu8
         BKu65YfvznAGBTb7n1cm2erC+93FImBwxONSlqm7WZ3H2yI6Oe0gMv18NOaoK/GVtY5j
         9qsQ==
X-Gm-Message-State: ANoB5pkOwLdbYrYjH0eMgvKH4NT32UmSsnk15ypan4YSa3igPYdpmlRK
        Ea8MmRUSXMH8oN/jlp5A97Y=
X-Google-Smtp-Source: AA0mqf6VfitcdIjlZsT+T8nDdotvNZgjQQQ8Bls9q2b+jZE60c2iaxZTeNiQZi5U+I9I7oprhePu8g==
X-Received: by 2002:a17:90a:fb92:b0:212:d9fe:a94 with SMTP id cp18-20020a17090afb9200b00212d9fe0a94mr10469741pjb.58.1668354199677;
        Sun, 13 Nov 2022 07:43:19 -0800 (PST)
Received: from localhost.localdomain ([14.5.161.132])
        by smtp.gmail.com with ESMTPSA id w8-20020a1709026f0800b0018544ad1e8esm5304550plk.238.2022.11.13.07.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 07:43:19 -0800 (PST)
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
Subject: [PATCH 3/3] libbpf: checkpatch: Fixed code alignments in ringbuf.c
Date:   Mon, 14 Nov 2022 00:42:58 +0900
Message-Id: <20221113154258.36560-4-tegongkang@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221113154258.36560-1-tegongkang@gmail.com>
References: <20221113154258.36560-1-tegongkang@gmail.com>
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

