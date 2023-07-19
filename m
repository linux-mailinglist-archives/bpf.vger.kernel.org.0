Return-Path: <bpf+bounces-5231-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D03758AED
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 03:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F96D1C20E68
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 01:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD1217D1;
	Wed, 19 Jul 2023 01:39:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2942115D1
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 01:39:43 +0000 (UTC)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28F31BCD
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 18:39:40 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-403b6b7c0f7so45392781cf.0
        for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 18:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689730779; x=1690335579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=17CaRWOeKWaeLOQNpynBfkVXjl5Xx4mFGA3aKSeMDQI=;
        b=SskjWDg5HTlqm0vE4X+PUlfCHe0fsiYV7xTrKRh6y7xMC+0NOSQC3sq3F3yQtFYIVT
         I+XU1dS1qmFdFwhANM0smC+6wuy8hVczSOD2HoER/Sf3nbvwtqxPnX9sNNnpkPfK8IA6
         Lt1RPTqbjaoUksHVYkOLrvyvpeTKF8ztv2ouaz0fhkHIIvxioPPP3ZOe7I8MeV/hpsZp
         gX1gLgbx+Xybs3rIWaffchKtxZFknWzBFHUXCVNtV80ZQZn8IU0QP/drocqc5yr1Kaj0
         Zbzp18OBLHqCDlp5OrBUJTPiN6Qj0EDMqEe3WqDBmKVs8TmMO2Miknv1DErAIKbOBO97
         r1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689730779; x=1690335579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=17CaRWOeKWaeLOQNpynBfkVXjl5Xx4mFGA3aKSeMDQI=;
        b=i4xPwnwmFHyo6iZ9gU46IXD0U6gBfN2D7R4Mh4rROv9w3D2fHLTdA8qGjxLmMWgOGn
         DiEbOqaHezMz6MtTSb7OLmousysGthViJ1Nl7eyFro41w+NyXTNoRojc2DLRPJA/eTJf
         HdJEPKAj/O8XO/ydiZAyJ/qfs7FN3dN2VzLAGgWsPoPTERSL5cwWsj7tZoYC8maTsxC2
         w4yupY8ZVexzqxbIzXH0ql3a0LAZMmGHcw97PXcv9mF3XAAWV8gFMYZEvDP8XMqXYvYt
         25dSqEnG9eUozMu0SzMZUsfgx8dmTc2cbrDcYN/vh8kG8Bm8f0iRZLhhp2dEKxmkZK6f
         nZYg==
X-Gm-Message-State: ABy/qLZO4R1WT6zU4YJ9h/y+XSLtkQPTOxDf5TwzmgkTY0zsNzovDB+8
	zUy2V4vTSliGgsu1H462GaPMURW/o0eCDIKr
X-Google-Smtp-Source: APBJJlEuZ+jrAAkzX0oW/oOd8a2EEJxs1ldyXD/wysucyOnJJ99IECogPQNDxuBkWo5CdjHicCUcjw==
X-Received: by 2002:a05:622a:1191:b0:403:2da2:cc65 with SMTP id m17-20020a05622a119100b004032da2cc65mr22001961qtk.62.1689730779259;
        Tue, 18 Jul 2023 18:39:39 -0700 (PDT)
Received: from pc.tail5bae4.ts.net ([71.125.252.241])
        by smtp.gmail.com with ESMTPSA id h26-20020ac8777a000000b003f3937c16c4sm1045974qtu.5.2023.07.18.18.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 18:39:38 -0700 (PDT)
From: Andrew Werner <awerner32@gmail.com>
To: bpf@vger.kernel.org
Cc: kernel-team@dataexmachina.dev,
	ishitatsuyuki@gmail.com,
	andrii.nakryiko@gmail.com,
	Andrew Werner <awerner32@gmail.com>
Subject: [PATCH bpf-next] libbpf: fix ringbuf atomics, use EPOLLET
Date: Tue, 18 Jul 2023 21:35:54 -0400
Message-Id: <20230719013552.3476856-1-awerner32@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch fixes enhances the synchronization between libbpf and
the producer in the kernel so that notifications cannot be lost
because the producer reads a stale view of the consumer position
while the consumer also reads a stale view of either the producer
position or the header.

The problem before this change was that nothing enforced a happens
before relationship between either of the writes and the subsequent
reads.

The use of a sequentially consistent write ensures that the write
to the consumer position is either ordered before the producer
clears the busy bit, in which case the producer will see that
the consumer caught up, or the write will occur after the producer
has cleared the busy bit, in which case the new message will be
visible.

All of this is in service of using EPOLLET, which will perform
fewer wakeups and generally less work. This is borne out in the
benchmark data below. Note that without the atomics change, the use
of EPOLLET does not work, and the benchmarks and tests show it.

The below raw benchmarks are below (I've omitted the irrelevant
ones for brevity). The benchmarks were run on a 32-thread AMD
Ryzen 9 7950X 16-Core Processor.

The summary of the results is that the producer is that in
almost all cases, the benchmarks are substantially improved.
The only case which seems worse is "Ringbuf sampled,
reserve+commit vs output", for the "reserve" case. I guess this
makes sense because the consumer piece is more expensive, and
the sampled notifications mean there's not a lot of time interacting
with epoll.

Credit for the discovery of the bug[1] and guidance on how to
fix it[2] belong to Tatsuyuki Ishi <ishitatsuyuki@gmail.com>.

New:
```
Single-producer, parallel producer
==================================
rb-libbpf            43.366 ± 0.277M/s (drops 0.848 ± 0.027M/s)

Single-producer, parallel producer, sampled notification
========================================================
rb-libbpf            41.163 ± 0.031M/s (drops 0.000 ± 0.000M/s)

Single-producer, back-to-back mode
==================================
rb-libbpf            60.671 ± 0.274M/s (drops 0.000 ± 0.000M/s)
rb-libbpf-sampled    59.229 ± 0.422M/s (drops 0.000 ± 0.000M/s)

Ringbuf back-to-back, effect of sample rate
===========================================
rb-sampled-1         1.507 ± 0.004M/s (drops 0.000 ± 0.000M/s)
rb-sampled-5         7.095 ± 0.016M/s (drops 0.000 ± 0.000M/s)
rb-sampled-10        13.091 ± 0.046M/s (drops 0.000 ± 0.000M/s)
rb-sampled-25        26.259 ± 0.061M/s (drops 0.000 ± 0.000M/s)
rb-sampled-50        39.831 ± 0.122M/s (drops 0.000 ± 0.000M/s)
rb-sampled-100       51.536 ± 2.984M/s (drops 0.000 ± 0.000M/s)
rb-sampled-250       67.850 ± 1.267M/s (drops 0.000 ± 0.000M/s)
rb-sampled-500       75.257 ± 0.438M/s (drops 0.000 ± 0.000M/s)
rb-sampled-1000      74.939 ± 0.295M/s (drops 0.000 ± 0.000M/s)
rb-sampled-2000      81.481 ± 0.769M/s (drops 0.000 ± 0.000M/s)
rb-sampled-3000      82.637 ± 0.448M/s (drops 0.000 ± 0.000M/s)

Ringbuf back-to-back, reserve+commit vs output
==============================================
reserve              78.142 ± 0.104M/s (drops 0.000 ± 0.000M/s)
output               68.418 ± 0.032M/s (drops 0.000 ± 0.000M/s)

Ringbuf sampled, reserve+commit vs output
=========================================
reserve-sampled      30.577 ± 2.122M/s (drops 0.000 ± 0.000M/s)
output-sampled       30.075 ± 1.089M/s (drops 0.000 ± 0.000M/s)

Single-producer, consumer/producer competing on the same CPU, low batch count
=============================================================================
rb-libbpf            0.570 ± 0.004M/s (drops 0.000 ± 0.000M/s)

Ringbuf, multi-producer contention
==================================
rb-libbpf nr_prod 1  44.359 ± 0.319M/s (drops 0.091 ± 0.027M/s)
rb-libbpf nr_prod 2  23.722 ± 0.024M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 3  14.128 ± 0.011M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 4  14.896 ± 0.020M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 8  6.056 ± 0.061M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 12 4.612 ± 0.042M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 16 4.684 ± 0.040M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 20 5.007 ± 0.046M/s (drops 0.001 ± 0.004M/s)
rb-libbpf nr_prod 24 5.207 ± 0.093M/s (drops 0.006 ± 0.013M/s)
rb-libbpf nr_prod 28 4.951 ± 0.073M/s (drops 0.030 ± 0.069M/s)
rb-libbpf nr_prod 32 4.509 ± 0.069M/s (drops 0.582 ± 0.057M/s)
rb-libbpf nr_prod 36 4.361 ± 0.064M/s (drops 0.733 ± 0.126M/s)
rb-libbpf nr_prod 40 4.261 ± 0.049M/s (drops 0.713 ± 0.116M/s)
rb-libbpf nr_prod 44 4.150 ± 0.207M/s (drops 0.841 ± 0.191M/s)
rb-libbpf nr_prod 48 4.033 ± 0.064M/s (drops 1.009 ± 0.082M/s)
rb-libbpf nr_prod 52 4.025 ± 0.049M/s (drops 1.012 ± 0.069M/s)
```

Old:
```
Single-producer, parallel producer
==================================
rb-libbpf            20.755 ± 0.396M/s (drops 0.000 ± 0.000M/s)

Single-producer, parallel producer, sampled notification
========================================================
rb-libbpf            29.347 ± 0.087M/s (drops 0.000 ± 0.000M/s)

Single-producer, back-to-back mode
==================================
rb-libbpf            60.791 ± 0.188M/s (drops 0.000 ± 0.000M/s)
rb-libbpf-sampled    60.125 ± 0.207M/s (drops 0.000 ± 0.000M/s)

Ringbuf back-to-back, effect of sample rate
===========================================
rb-sampled-1         1.534 ± 0.006M/s (drops 0.000 ± 0.000M/s)
rb-sampled-5         7.062 ± 0.029M/s (drops 0.000 ± 0.000M/s)
rb-sampled-10        13.093 ± 0.107M/s (drops 0.000 ± 0.000M/s)
rb-sampled-25        26.292 ± 0.118M/s (drops 0.000 ± 0.000M/s)
rb-sampled-50        40.230 ± 0.030M/s (drops 0.000 ± 0.000M/s)
rb-sampled-100       54.123 ± 0.334M/s (drops 0.000 ± 0.000M/s)
rb-sampled-250       66.054 ± 0.282M/s (drops 0.000 ± 0.000M/s)
rb-sampled-500       76.130 ± 0.648M/s (drops 0.000 ± 0.000M/s)
rb-sampled-1000      80.531 ± 0.169M/s (drops 0.000 ± 0.000M/s)
rb-sampled-2000      83.170 ± 0.376M/s (drops 0.000 ± 0.000M/s)
rb-sampled-3000      83.702 ± 0.046M/s (drops 0.000 ± 0.000M/s)

Ringbuf back-to-back, reserve+commit vs output
==============================================
reserve              77.829 ± 0.178M/s (drops 0.000 ± 0.000M/s)
output               67.974 ± 0.153M/s (drops 0.000 ± 0.000M/s)

Ringbuf sampled, reserve+commit vs output
=========================================
reserve-sampled      33.925 ± 0.101M/s (drops 0.000 ± 0.000M/s)
output-sampled       30.610 ± 0.070M/s (drops 0.000 ± 0.000M/s)

Single-producer, consumer/producer competing on the same CPU, low batch count
=============================================================================
rb-libbpf            0.565 ± 0.002M/s (drops 0.000 ± 0.000M/s)

Ringbuf, multi-producer contention
==================================
rb-libbpf nr_prod 1  18.486 ± 0.067M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 2  22.009 ± 0.023M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 3  11.908 ± 0.023M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 4  11.302 ± 0.031M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 8  5.799 ± 0.032M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 12 4.296 ± 0.008M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 16 4.248 ± 0.005M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 20 4.530 ± 0.032M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 24 4.607 ± 0.012M/s (drops 0.000 ± 0.000M/s)
rb-libbpf nr_prod 28 4.470 ± 0.017M/s (drops 0.002 ± 0.007M/s)
rb-libbpf nr_prod 32 4.348 ± 0.051M/s (drops 0.703 ± 0.072M/s)
rb-libbpf nr_prod 36 4.248 ± 0.062M/s (drops 0.603 ± 0.102M/s)
rb-libbpf nr_prod 40 4.227 ± 0.051M/s (drops 0.805 ± 0.053M/s)
rb-libbpf nr_prod 44 4.100 ± 0.049M/s (drops 0.828 ± 0.063M/s)
rb-libbpf nr_prod 48 4.056 ± 0.065M/s (drops 0.922 ± 0.083M/s)
rb-libbpf nr_prod 52 4.051 ± 0.053M/s (drops 0.935 ± 0.093M/s)
```

[1]: https://lore.kernel.org/bpf/CANqewP1RFzD9TWgyyZy00ZVQhQr8QjmjUgyaaNK0g0_GJse=KA@mail.gmail.com/#r
[2]: https://github.com/aya-rs/aya/pull/294#issuecomment-1634705909
---
 tools/lib/bpf/ringbuf.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index 02199364db13..32a618b4c4d6 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -148,7 +148,7 @@ int ring_buffer__add(struct ring_buffer *rb, int map_fd,
 	e = &rb->events[rb->ring_cnt];
 	memset(e, 0, sizeof(*e));
 
-	e->events = EPOLLIN;
+	e->events = EPOLLIN|EPOLLET;
 	e->data.fd = rb->ring_cnt;
 	if (epoll_ctl(rb->epoll_fd, EPOLL_CTL_ADD, map_fd, e) < 0) {
 		err = -errno;
@@ -260,7 +260,19 @@ static int64_t ringbuf_process_ring(struct ring *r)
 				cnt++;
 			}
 
-			smp_store_release(r->consumer_pos, cons_pos);
+			/* This ordering is critical to ensure that an epoll
+			 * notification gets sent in the case where the next
+			 * iteration of this loop discovers that the consumer is
+			 * caught up. If this store were performed using
+			 * RELEASE, it'd be possible for the consumer to fail to
+			 * see an updated producer position and for that
+			 * producer to fail to see this write. By making this
+			 * write SEQ_CST, we know that either the newly produced
+			 * message will be visible to theconsumer, or the
+			 * producer will discover that the consumer is caught
+			 * up, and will ensure a notification is sent.
+			 */
+			__atomic_store_n(r->consumer_pos, cons_pos, __ATOMIC_SEQ_CST);
 		}
 	} while (got_new_data);
 done:
-- 
2.39.2


