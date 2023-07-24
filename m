Return-Path: <bpf+bounces-5717-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD5E75F84A
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 15:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B603D1C20B1F
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 13:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A90F8C13;
	Mon, 24 Jul 2023 13:28:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47148BF2
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 13:28:31 +0000 (UTC)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C729137
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 06:28:30 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-7672073e7b9so305062185a.0
        for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 06:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690205309; x=1690810109;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IlNpaxFs24JkrT4qXDiloEZnXId6m1K1hKVBnwEGxVM=;
        b=d/fl2XWN5PlrHz+pBr0Ppz+0wByeN/8IEIGFj3y8CSf0XU1BPd09kCd+Y5F+AlcWjJ
         nYFpR94Npuey+370JC4NWYmn92XrWDGXjHg6v5RmpbdD14cnFR08nadE9jCudoHV4+nf
         LQRfcyjiGexN5OfHOu/GdvUzJLN7j3ZMVG7kLdmAbrndzQ1zw1OBebQ4GIbQ06dWLTBu
         +9KsiZJCkqgrp1TBXw9g+eZFDIiwZ0m/c68424TuPI3aHzjjv/jv4qtAEA6B93CktiQg
         /PU8X4aTSzXmOVrpGDzz5AHMv7mijehHed8CWZnuPxo99ZrxzHFKUX7SLPdxqbsHPygL
         n9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690205309; x=1690810109;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IlNpaxFs24JkrT4qXDiloEZnXId6m1K1hKVBnwEGxVM=;
        b=Z3DvWEbtcUw+qXNKtJa2z8rfXJlyt5U5FO+jzPJBgDtvXhvxCDsLKtsi4FSNcOaSCm
         wEs2cuaWnOXNqDA2T/wVa9R1aBVK65TtmWkZAN0QwBzmOq2mdnSCuXUst+9WPZwvKwpk
         SleqBI5xYkeo2LhKLFJfIcy2UmojGCRPtlgRzxkWt2kB50v7hM+7lLmKxjdbx8FAfO8Y
         LFEsyqmWzn5JoiHZQ6s5lpg7zxEYqPtM7MZnVb+Nms5MmlVGfHluFlV+60BVm2ufIyGB
         8EW1WisJAuA/3MNGrYas8hyrrmo5nx1zUNqD6y59WvKEwKfoiHCsbZdMCsjb2fcocfFB
         m18w==
X-Gm-Message-State: ABy/qLa6MyWmfQYaFDupz7CBSl2qtIk1voTcjnVfTVB65r20cao0r7ob
	2LZdAL7Qymgeti2OnyNO9jHOlBNsEVTL6g==
X-Google-Smtp-Source: APBJJlH6fOlg1C4j91GMxJ6sLZRqwRhapR/11tpAM+P1cOS0/Xv1hC8Luo0Y0dIsdKmGuA3g9HL2QQ==
X-Received: by 2002:a05:620a:3901:b0:765:4d55:e715 with SMTP id qr1-20020a05620a390100b007654d55e715mr7499717qkn.8.1690205308711;
        Mon, 24 Jul 2023 06:28:28 -0700 (PDT)
Received: from pc.tail5bae4.ts.net ([71.125.252.241])
        by smtp.gmail.com with ESMTPSA id s26-20020a05620a031a00b0076827ce13f6sm2963342qkm.10.2023.07.24.06.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 06:28:28 -0700 (PDT)
From: Andrew Werner <awerner32@gmail.com>
To: bpf@vger.kernel.org
Cc: kernel-team@dataexmachina.dev,
	Andrew Werner <awerner32@gmail.com>
Subject: [PATCH bpf-next v2] libbpf: handle producer position overflow
Date: Mon, 24 Jul 2023 09:25:45 -0400
Message-Id: <20230724132543.1282645-1-awerner32@gmail.com>
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
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
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

v1->v2:
 - Fixed comment grammar.
 - Properly formatted subject line.

Reference:
[v1]: https://lore.kernel.org/bpf/20230724132404.1280848-1-awerner32@gmail.com/T/#u

Signed-off-by: Andrew Werner <awerner32@gmail.com>
---
 tools/lib/bpf/ringbuf.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index 02199364db13..2055f3099843 100644
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
+	/* Note that this formulation is valid in the face of overflow of
+	 * prod_pos so long as the delta between prod_pos and cons_pos is
+	 * no greater than max_size.
+	 */
 	avail_size = max_size - (prod_pos - cons_pos);
 	/* Round up total size to a multiple of 8. */
 	total_size = (size + BPF_RINGBUF_HDR_SZ + 7) / 8 * 8;
-- 
2.39.2


