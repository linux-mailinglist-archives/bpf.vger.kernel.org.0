Return-Path: <bpf+bounces-46768-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE249F009B
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 00:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0817285ACF
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 23:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366BB1DEFCD;
	Thu, 12 Dec 2024 23:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b="TH9ZtsyJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056051547F5
	for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 23:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734047910; cv=none; b=VCjCb0Sf6EL4qJfZ5V5UNxWBqXl8CunObiQgZ7iz4xAUZV7nv/NKtsF0bDUK3Iqf0ngPeE8Adtky9BSxcDCb05lUlEbgERFvuE8duDtuLuIJ9nkPUsxzLR7wRMv7QmxCf0+yfk3TSfhhbgsmXwzuxqZ5UgtW9oQJ0gVAbnwGgko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734047910; c=relaxed/simple;
	bh=yMTxl+3KWzj8ysM+Sw89HaO7qv1o6/DAk+dssdkkNO0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Pc8Zb6It8jM8uvw3gGTPwlv1FeIdmmME+posX8BhELOaaCDIfRo8snn+4iC4R/LIjt4hGn8EqOl3j2oCSfhKjwLMBLc/KRjbFgbwUFrYIlWbSgDhawPq70JklJNrMUlJiyAH0KzqQP4xhF4jAE5m9guSBANdetyNFf0ANEBpM2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu; spf=pass smtp.mailfrom=uci.edu; dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b=TH9ZtsyJ; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uci.edu
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b6e9317a2aso202208585a.0
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 15:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci.edu; s=google; t=1734047908; x=1734652708; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6E92/KX3z99SLO9Nv94Sz5LEx+SJIhTdIT1o1/rtxWc=;
        b=TH9ZtsyJE36nb2kilUNJCuW0guGqdW9VqvqgV8b4UaAb/homJhzKcGveSOHNENmxUl
         P5LQHw+/TldprdCt9IKBqSGTd13pIjj7yNGywptL7jZovnD5nxx4XLkRSSteNdKexJar
         y2GTd3O6+QG6VXgOH/LHGo0H3bSCjgERRnoUoB5FuHtbRLZMJ5RJBBz+aFjznN3vD2/0
         /SW+h5jDwvII+NeXCKSg3uTSmtt9ZmSdAYh1aI5Y3v8SwwZF0mQbL83tJcvuDpk/uE5f
         9N22VxuQPGi6yJvJlIRf8w+b+PKoiCRpXVuyLcEZCExmhNyoOCy6GBrGeBOQT0DR5PtX
         11rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734047908; x=1734652708;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6E92/KX3z99SLO9Nv94Sz5LEx+SJIhTdIT1o1/rtxWc=;
        b=EgVdLlHkZtdsAcG8gA9P9s6hKT8CB7Yf16RWYW6rlyUP0/nfv/WP4PtWiUTj/EEuL8
         AfW3UmHCyTvShZMkAnEo2/UWYYq91SW/LAruVdPT8QdGkFlScbP6NewirEvWykkdbWrY
         8GBtdDlNqkIWBwyMoc3kirlotlhiKKxvtGrcMCQt1LjQf5tFe/b6cVVLHygack0sPqlb
         /Z4J66NcuLG0m9ZMrq9vtZUow7bW8Hdx69udaEiVA5KS5U0TeYQ5xJJjHrdRnkrDPoS1
         7gaLHDPlLCoE843q94lc7Y7Uj5Fym/fx8BKpE12tirvVgL7AIwlQ+vkn7Ek5b/pBF81X
         JCpg==
X-Gm-Message-State: AOJu0YzhU0qJN6ArOsNV8OsbSOMr5PHeNrIk6vKaa7y30RNeH0u0ebYQ
	fGcx9w1C2YLhj3WQvFD4b2BTAY8jGPRjXSkK8NraYJfy6BPj4w2Yiv5gtQ2Ix5R6SiWxlIimDS7
	rrzqUQ09f4aelozmxC4P3NaZvidOWVNTpdwbqtA==
X-Gm-Gg: ASbGncswC6qexZDo3WI8v6aomrhMpbl/oACO4SMyiux2ZtIhvHl3iQfXRDH14m5t9Ox
	1qYZPFldfA1P/wZzCCL4hnhxo4Rxscw2Fm94Ea7w=
X-Google-Smtp-Source: AGHT+IFGtN9FKg+oxnvk7Zv2q8+gkAS/PboYww6jXV0CUMo0rpBtPW+SqcDIDpD47Wv6F0BwsAJfl63nJqhW1nGpjB0=
X-Received: by 2002:a05:6214:21eb:b0:6d8:7a52:5d5 with SMTP id
 6a1803df08f44-6dcb01d38famr6552646d6.6.1734047907887; Thu, 12 Dec 2024
 15:58:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Priya Bala Govindasamy <pgovind2@uci.edu>
Date: Thu, 12 Dec 2024 15:58:16 -0800
Message-ID: <CAPPBnEYn-CiWVTuRq_Fq=TP0f-W+_hcJVU61xwnxqpFr3jRcyQ@mail.gmail.com>
Subject: [PATCH] bpf: Avoid deadlock caused by nested kprobe and fentry bpf programs
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Ardalan Amiri Sani <ardalan@uci.edu>
Content-Type: text/plain; charset="UTF-8"

BPF program types like kprobe and fentry can cause deadlocks in certain
situations. If a function takes a lock and one of these bpf programs is
hooked to some point in the function's critical section, and if the
bpf program tries to call the same function and take the same lock it will
lead to deadlock. These situations have been reported in the following
bug reports.

In percpu_freelist -
Link: https://lore.kernel.org/bpf/CAADnVQLAHwsa+2C6j9+UC6ScrDaN9Fjqv1WjB1pP9AzJLhKuLQ@mail.gmail.com/T/
Link: https://lore.kernel.org/bpf/CAPPBnEYm+9zduStsZaDnq93q1jPLqO-PiKX9jy0MuL8LCXmCrQ@mail.gmail.com/T/
In bpf_lru_list -
Link: https://lore.kernel.org/bpf/CAPPBnEajj+DMfiR_WRWU5=6A7KKULdB5Rob_NJopFLWF+i9gCA@mail.gmail.com/T/
Link: https://lore.kernel.org/bpf/CAPPBnEZQDVN6VqnQXvVqGoB+ukOtHGZ9b9U0OLJJYvRoSsMY_g@mail.gmail.com/T/
Link: https://lore.kernel.org/bpf/CAPPBnEaCB1rFAYU7Wf8UxqcqOWKmRPU1Nuzk3_oLk6qXR7LBOA@mail.gmail.com/T/

Similar bugs have been reported by syzbot.
In queue_stack_maps -
Link: https://lore.kernel.org/lkml/0000000000004c3fc90615f37756@google.com/
Link: https://lore.kernel.org/all/20240418230932.2689-1-hdanton@sina.com/T/
In lpm_trie -
Link: https://lore.kernel.org/linux-kernel/00000000000035168a061a47fa38@google.com/T/
In ringbuf -
Link: https://lore.kernel.org/bpf/20240313121345.2292-1-hdanton@sina.com/T/

Prevent kprobe and fentry bpf programs from attaching to these critical
sections by removing CC_FLAGS_FTRACE for percpu_freelist.o,
bpf_lru_list.o, queue_stack_maps.o, lpm_trie.o, ringbuf.o files.

The bugs reported by syzbot are due to tracepoint bpf programs being
called in the critical sections. This patch does not aim to fix deadlocks
caused by tracepoint programs. However, it does prevent deadlocks from
occurring in similar situations due to kprobe and fentry programs.

Signed-off-by: Priya Bala Govindasamy <pgovind2@uci.edu>
---
 kernel/bpf/Makefile | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 7eb9ad3a3ae6..121ebcdc26cc 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -52,3 +52,10 @@ obj-$(CONFIG_BPF_PRELOAD) += preload/
 obj-$(CONFIG_BPF_SYSCALL) += relo_core.o
 $(obj)/relo_core.o: $(srctree)/tools/lib/bpf/relo_core.c FORCE
        $(call if_changed_rule,cc_o_c)
+
+CFLAGS_REMOVE_percpu_freelist.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_bpf_lru_list.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_queue_stack_maps.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_lpm_trie.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_ringbuf.o = $(CC_FLAGS_FTRACE)
+
--
2.34.1

