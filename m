Return-Path: <bpf+bounces-5716-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED34375F82A
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 15:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 296861C20AFC
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 13:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3538C0F;
	Mon, 24 Jul 2023 13:24:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9878F8BF2
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 13:24:20 +0000 (UTC)
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292F6E4F
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 06:24:08 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-799a451ca9cso1320880241.2
        for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 06:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690205046; x=1690809846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aP2Yq5QQUBbNBzJrjrdiY4LsqQDXdcr9afv5HtmLNso=;
        b=X4ZSD3mc3EloWWwrwZ/55KYKVBa1lbnfXdYgRrrlcAIr97TG6DsoL9+2uEg1tP+7Z4
         buuqOQmqZzDJxXfADHzZbQyVlBppj+qzvDX4trcUPj2f2QVhXg1lsDEZ5fG/4Z2rNQBH
         YamkUD3ZT4n3y7SPCgwvFsAsAwfQXtP05bCcaLitJqSDZ+8NisQqQ/JROX6kZMjXjHdw
         ZZlp7zGkOfDHcChnVddKSAFFEhvpQ2PleJMdIGvXgZFDWETQa/yRjFHksrBV4htKqvZG
         zeNIK92gfuSj99v8dQ0eNlsJtJZcAKCNJhAAKcBsy0DFvHGlKMQic0MQ+ayDByAMmSLz
         IM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690205046; x=1690809846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aP2Yq5QQUBbNBzJrjrdiY4LsqQDXdcr9afv5HtmLNso=;
        b=Tai7rtmtfxeJFPO/DHq2VQ7mAeYwkDTikYHYCvmm8+mb6KnQ+BVgCRhzUAcWj2wDJJ
         C/5ppLD4Q1Jh4avLKW9+WfSTI9ZaQu/2uS/Gz8pfqgyeC8E4d7i/fyCqmkGgCq2VxGCJ
         BJbq+KJftFIHATnWTYDBwF+/XmixYh4oYN97M7dCxo1n/93ByOQXuv32ZdYwd9nlSn/Y
         pWRVm3ERzt9D0M8AK/GBqzB9FkHxWqQKRJWTDEs6jCKG2HVK0H8ZdrueYBiwqwEBAKlm
         SpZ7jdn3VZiuaIYatONgCvDixN/5PQEEUiMRm1mM/5Qu5xk/UEsPlN68Uh0Bu62ehY9z
         JPfA==
X-Gm-Message-State: ABy/qLZfzBQK5+XtODSweH2bWzJsT0IvDAcsKkV4qnh1qxgdc2bKwVmP
	t0ivJPqecwBqzX3h/YLJUS/qb9xgSiJIag==
X-Google-Smtp-Source: APBJJlGtkPqyfiWgzNMn4YWaGF94m9uRdrh2JJxrM/xcejywkFTmS3MT+/yWGqpIU0yP0qjzJGYJxg==
X-Received: by 2002:a67:e910:0:b0:445:20ba:fb2a with SMTP id c16-20020a67e910000000b0044520bafb2amr2475588vso.16.1690205046109;
        Mon, 24 Jul 2023 06:24:06 -0700 (PDT)
Received: from pc.tail5bae4.ts.net ([71.125.252.241])
        by smtp.gmail.com with ESMTPSA id s17-20020a05620a031100b00767f5c70b3dsm2971501qkm.96.2023.07.24.06.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 06:24:05 -0700 (PDT)
From: Andrew Werner <awerner32@gmail.com>
To: bpf@vger.kernel.org
Cc: kernel-team@dataexmachina.dev,
	Andrew Werner <awerner32@gmail.com>
Subject: [PATCH] libbpf: handle producer position overflow
Date: Mon, 24 Jul 2023 09:24:04 -0400
Message-Id: <20230724132404.1280848-1-awerner32@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Before this patch, the producer position could overflow `unsigned
long`, in which case libbpf would forever stop processing new writes to
the ringbuf. This patch addresses that bug by avoiding ordered
comparison between the consumer and producer position. If the consumer
position is greater than the producer position, the assumption is that
the producer has overflowed.

A more defensive check could be to ensure that the delta is within
the allowed range, but such defensive checks are neither present in
the kernel side code nor in libbpf. The overflow that this patch
handles can occur while the producer and consumer follow a correct
protocol.

A selftest was written to demonstrate the bug, and indeed this patch
allows the test to continue to make progress past the overflow.
However, the author was unable to create a testing environment on a
32-bit machine, and the test requires substantial memory and over 4
hours to hit the overflow point on a 64-bit machine. Thus, the test
is not included in this patch because of the impracticality of running
it.

Additionally, this patch adds commentary around a separate point to note
that the modular arithmetic is valid in the face of overflows, as that
fact may not be obvious to future readers.

Signed-off-by: Andrew Werner <awerner32@gmail.com>
---
 tools/lib/bpf/ringbuf.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index 02199364db13..6271757bc3d2 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -237,7 +237,11 @@ static int64_t ringbuf_process_ring(struct ring *r)
 	do {
 		got_new_data = false;
 		prod_pos = smp_load_acquire(r->producer_pos);
-		while (cons_pos < prod_pos) {
+
+		/* Avoid signed comparisons between the positions; the producer
+		 * position can overflow before the consumer position.
+		 */
+		while (cons_pos != prod_pos) {
 			len_ptr = r->data + (cons_pos & r->mask);
 			len = smp_load_acquire(len_ptr);
 
@@ -498,6 +502,11 @@ void *user_ring_buffer__reserve(struct user_ring_buffer *rb, __u32 size)
 	prod_pos = smp_load_acquire(rb->producer_pos);
 
 	max_size = rb->mask + 1;
+
+	/* Note that this formulation in the face of overflow of prod_pos
+	 * so long as the delta between prod_pos and cons_pos remains no
+	 * greater than max_size.
+	 */
 	avail_size = max_size - (prod_pos - cons_pos);
 	/* Round up total size to a multiple of 8. */
 	total_size = (size + BPF_RINGBUF_HDR_SZ + 7) / 8 * 8;
-- 
2.39.2


