Return-Path: <bpf+bounces-11600-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B67927BC5C9
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 09:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61E441C20ADA
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 07:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B5F14002;
	Sat,  7 Oct 2023 07:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="joZKHjJg"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEC88481;
	Sat,  7 Oct 2023 07:52:52 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19E7A6;
	Sat,  7 Oct 2023 00:52:50 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-533d31a8523so5294767a12.1;
        Sat, 07 Oct 2023 00:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696665169; x=1697269969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FYYo8GR3oiE1tO7of8Zj0AJ+1K2a6alvRcy0hRc5+D0=;
        b=joZKHjJgRJLEAaiqi+g/61Q7wUZkNDC2rPdP/J/g/++zZHTqARZg7CVziDrMEb9NqU
         2yuHRlJ/aGB6zaZWhmOJMGpJ6lRub6OfNcPgA/tG2znMn3j7AdyDcY7PcNuI6Fqtrne/
         BM67BLYO8bM/CuqxPHVrptm2eBM9BAadnjHtKbQ9+9caDcb6x84H00+o+f1WQAMxVpnI
         SpHB3s6nZmfk3I4ojSQ8FLIKsT+WHzWHtrMXFbsjrdgCsPLgagfP6nl+T/JFHOtvPP6U
         8nMV7TnPzXN9rrZF9CSsO0NGA4qUSzU1HI4cWK7vcdP3gLtxEBPK/g7L4qRIZohiFgzz
         gn3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696665169; x=1697269969;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FYYo8GR3oiE1tO7of8Zj0AJ+1K2a6alvRcy0hRc5+D0=;
        b=n2Uy5Tk4ZdpV73L788JGaMXLM5Xehf+oScGNjLVMRhyMNB6voviiQoYPmLk9HuJEIN
         vlnyQJRZaJoSBEr0pD7sEFNFmvAKBJLdCt4BZt8EyTe1HEonzNDAKAswTrHIMgW0Wkbc
         dB9SwdwpUwsBmzfrhRox3L7yKD2qb9XY9ZiT4UEz1DX86Wp9yHjaeqH5f6A2I2Ok9208
         03OEBT2SAWKifkf2RuhMczyqAgYtWclGvx3B9AQZLclFypWLHprFl0C8tJYLabJrxmqK
         2JBMGAWLR2jCnT+DhOd5Y3uBrOlJabuwy0xX/YCjXGXrlfTAHtHMjvFNtl152/0TG42Y
         nVfA==
X-Gm-Message-State: AOJu0YxvosBpb/O+3Z1o3/T/8Q8brmCFDF0Q28FUrqYhbZL6gteo33jG
	tj3FN91Ue2IZQFJyxtK/AZweP8XCFmDFQw==
X-Google-Smtp-Source: AGHT+IEa0d+g1RmX9uc9gMWr0k5mS4QILCecL+NREQqJlgOannZCmyfEkeEcOEKCxv16TAPphXhn1Q==
X-Received: by 2002:a50:ee1a:0:b0:530:a0a9:ee36 with SMTP id g26-20020a50ee1a000000b00530a0a9ee36mr8902769eds.38.1696665168939;
        Sat, 07 Oct 2023 00:52:48 -0700 (PDT)
Received: from localhost.localdomain ([77.222.24.57])
        by smtp.gmail.com with ESMTPSA id n24-20020aa7d058000000b0053331f9094dsm3568685edo.52.2023.10.07.00.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 00:52:44 -0700 (PDT)
From: Andrew Kanner <andrew.kanner@gmail.com>
To: martin.lau@linux.dev,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	aleksander.lobakin@intel.com,
	xuanzhuo@linux.alibaba.com,
	ast@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	daniel@iogearbox.net
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+fae676d3cf469331fc89@syzkaller.appspotmail.com,
	syzbot+b132693e925cbbd89e26@syzkaller.appspotmail.com,
	Andrew Kanner <andrew.kanner@gmail.com>
Subject: [PATCH bpf v4] net/xdp: fix zero-size allocation warning in xskq_create()
Date: Sat,  7 Oct 2023 10:51:49 +0300
Message-Id: <20231007075148.1759-1-andrew.kanner@gmail.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Syzkaller reported the following issue:
 ------------[ cut here ]------------
 WARNING: CPU: 0 PID: 2807 at mm/vmalloc.c:3247 __vmalloc_node_range (mm/vmalloc.c:3361)
 Modules linked in:
 CPU: 0 PID: 2807 Comm: repro Not tainted 6.6.0-rc2+ #12
 Hardware name: Generic DT based system
 unwind_backtrace from show_stack (arch/arm/kernel/traps.c:258)
 show_stack from dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1))
 dump_stack_lvl from __warn (kernel/panic.c:633 kernel/panic.c:680)
 __warn from warn_slowpath_fmt (./include/linux/context_tracking.h:153 kernel/panic.c:700)
 warn_slowpath_fmt from __vmalloc_node_range (mm/vmalloc.c:3361 (discriminator 3))
 __vmalloc_node_range from vmalloc_user (mm/vmalloc.c:3478)
 vmalloc_user from xskq_create (net/xdp/xsk_queue.c:40)
 xskq_create from xsk_setsockopt (net/xdp/xsk.c:953 net/xdp/xsk.c:1286)
 xsk_setsockopt from __sys_setsockopt (net/socket.c:2308)
 __sys_setsockopt from ret_fast_syscall (arch/arm/kernel/entry-common.S:68)

xskq_get_ring_size() uses struct_size() macro to safely calculate the
size of struct xsk_queue and q->nentries of desc members. But the
syzkaller repro was able to set q->nentries with the value initially
taken from copy_from_sockptr() high enough to return SIZE_MAX by
struct_size(). The next PAGE_ALIGN(size) is such case will overflow
the size_t value and set it to 0. This will trigger WARN_ON_ONCE in
vmalloc_user() -> __vmalloc_node_range().

The issue is reproducible on 32-bit arm kernel.

Reported-and-tested-by: syzbot+fae676d3cf469331fc89@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/000000000000c84b4705fb31741e@google.com/T/
Link: https://syzkaller.appspot.com/bug?extid=fae676d3cf469331fc89
Reported-by: syzbot+b132693e925cbbd89e26@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/000000000000e20df20606ebab4f@google.com/T/
Fixes: 9f78bf330a66 ("xsk: support use vaddr as ring")
Signed-off-by: Andrew Kanner <andrew.kanner@gmail.com>
---

Notes (akanner):
    v4:
      - add explanation about SIZE_MAX, suggested by Martin KaFai Lau
        <martin.lau@linux.dev>
    v3: https://lore.kernel.org/all/20231005193548.515-1-andrew.kanner@gmail.com/T/
      - free kzalloc-ed memory before return, the leak was noticed by
        Daniel Borkmann <daniel@iogearbox.net>
    v2: https://lore.kernel.org/all/20231002222939.1519-1-andrew.kanner@gmail.com/raw
      - use unlikely() optimization for the case with SIZE_MAX return from
        struct_size(), suggested by Alexander Lobakin
        <aleksander.lobakin@intel.com>
      - cc-ed 4 more maintainers, mentioned by cc_maintainers patchwork
        test
    
    v1: https://lore.kernel.org/all/20230928204440.543-1-andrew.kanner@gmail.com/T/
      - RFC notes:
        It was found that net/xdp/xsk.c:xsk_setsockopt() uses
        copy_from_sockptr() to get the number of entries (int) for cases
        with XDP_RX_RING / XDP_TX_RING and XDP_UMEM_FILL_RING /
        XDP_UMEM_COMPLETION_RING.
    
        Next in xsk_init_queue() there're 2 sanity checks (entries == 0)
        and (!is_power_of_2(entries)) for which -EINVAL will be returned.
    
        After that net/xdp/xsk_queue.c:xskq_create() will calculate the
        size multipling the number of entries (int) with the size of u64,
        at least.
    
        I wonder if there should be the upper bound (e.g. the 3rd sanity
        check inside xsk_init_queue()). It seems that without the upper
        limit it's quiet easy to overflow the allocated size (SIZE_MAX),
        especially for 32-bit architectures, for example arm nodes which
        were used by the syzkaller.
    
        In this patch I added a naive check for SIZE_MAX which helped to
        skip zero-size allocation after overflow, but maybe it's not quite
        right. Please, suggest if you have any thoughts about the
        appropriate limit for the size of these xdp rings.
    
        PS: the initial number of entries is 0x20000000 in syzkaller
        repro: syscall(__NR_setsockopt, (intptr_t)r[0], 0x11b, 3,
        0x20000040, 0x20);
    
        Link:
        https://syzkaller.appspot.com/text?tag=ReproC&x=10910f18280000

 net/xdp/xsk_queue.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/xdp/xsk_queue.c b/net/xdp/xsk_queue.c
index f8905400ee07..d2c264030017 100644
--- a/net/xdp/xsk_queue.c
+++ b/net/xdp/xsk_queue.c
@@ -34,6 +34,16 @@ struct xsk_queue *xskq_create(u32 nentries, bool umem_queue)
 	q->ring_mask = nentries - 1;
 
 	size = xskq_get_ring_size(q, umem_queue);
+
+	/* size which is overflowing or close to SIZE_MAX will become 0 in
+	 * PAGE_ALIGN(), checking SIZE_MAX is enough due to the previous
+	 * is_power_of_2(), the rest will be handled by vmalloc_user()
+	 */
+	if (unlikely(size == SIZE_MAX)) {
+		kfree(q);
+		return NULL;
+	}
+
 	size = PAGE_ALIGN(size);
 
 	q->ring = vmalloc_user(size);
-- 
2.39.3


