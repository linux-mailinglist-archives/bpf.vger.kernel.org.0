Return-Path: <bpf+bounces-11075-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F057B26CB
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 22:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 0454E1C20B38
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 20:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8772F9CA73;
	Thu, 28 Sep 2023 20:46:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE94715BA;
	Thu, 28 Sep 2023 20:46:35 +0000 (UTC)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C43180;
	Thu, 28 Sep 2023 13:46:33 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-504a7f9204eso3170888e87.3;
        Thu, 28 Sep 2023 13:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695933992; x=1696538792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hPgUe9lX4McMY8NXu/5cUyHU5+8iuToZI/13QzjOzwU=;
        b=gHp6ZGRRyrpPAAIoIDqy4zR7OMQGU3m/Jz1PUvgLP5hVRJu16MZjlc14NefR/u530k
         5ENoefhL7cs6vSyzQo5G3p/P8my8CpUeR+Az/wnpFwubWR3IBm/m+odzuZRI3tTFIbX1
         z3rguvmSB2koYZHAbIWV71Ze1+WXZFSX0HzW2PmmTo7tBuJOD/wgtGyOcddUfUo6gFDG
         hr5dt3RpmK+LHZdniTcFrcrpMlvIytv1oTQtvem0omLUwzJ9XD21Hw+mp4nDQMQ8sQ3L
         PzEQEOpj8Aq2L76btCr6JAfNfInZMHbXx+OHCPFnf3QinQkq/jM7tUn9FpV+5bijaUYd
         aJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695933992; x=1696538792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hPgUe9lX4McMY8NXu/5cUyHU5+8iuToZI/13QzjOzwU=;
        b=eX6dxRTuhC48DTmWg0t4QfAc7L16+d+t2DXbwS50u76cWrfw16mFuDlpCxg7uWtQVQ
         sruAs57Kj+5S9+1Qmt3iyjGvqy9ZkpyzRItdNpzEMmUCmNVXBdBkXVEsiM3NNllZnDR4
         PRZFWBDNFt203jHV63brC22mZ/F/AQE5YW/pX4fGiuLtaZ5gIpj9mS8wM2VrvrFjQXTW
         d9H9Ibk/UTeEU+IZwPhXCVgtaYoMPl3v54wn3Sb2dFoMZ/9arXjjmEGDnNYuFXC2uSKO
         YXXMn+OIPEEqQUK5drWwNvzLlBK+Zoxr/E1C7rpUoUG8Eq5mulJ5uuXbAkzPyrdllXBY
         ZPQw==
X-Gm-Message-State: AOJu0Yy7erSpjaHWfladBs0kjgA5uFP0VTBgEeV91xunBKTka9VQM4KX
	3gfUacqbaoSKwphZaoQm2OU=
X-Google-Smtp-Source: AGHT+IEwlsak/7zZhDaoy1I+l4SeZz0Oi1OVAIyi21U3apsnncFv9qsbL+yC9kNOSWGBmjk+/qX2vA==
X-Received: by 2002:a05:6512:3451:b0:500:8f65:c624 with SMTP id j17-20020a056512345100b005008f65c624mr1822930lfr.53.1695933991637;
        Thu, 28 Sep 2023 13:46:31 -0700 (PDT)
Received: from localhost.localdomain ([154.133.201.230])
        by smtp.gmail.com with ESMTPSA id l23-20020a19c217000000b00501c77ad909sm3233139lfc.208.2023.09.28.13.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 13:46:31 -0700 (PDT)
From: Andrew Kanner <andrew.kanner@gmail.com>
To: bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	aleksander.lobakin@intel.com,
	xuanzhuo@linux.alibaba.com
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+fae676d3cf469331fc89@syzkaller.appspotmail.com,
	Andrew Kanner <andrew.kanner@gmail.com>
Subject: [PATCH net-next v1] net/xdp: fix zero-size allocation warning in xskq_create()
Date: Thu, 28 Sep 2023 23:44:40 +0300
Message-Id: <20230928204440.543-1-andrew.kanner@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <000000000000c84b4705fb31741e@google.com>
References: <000000000000c84b4705fb31741e@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
Fixes: 9f78bf330a66 ("xsk: support use vaddr as ring")
Signed-off-by: Andrew Kanner <andrew.kanner@gmail.com>
---
RFC notes:

It was found that net/xdp/xsk.c:xsk_setsockopt() uses
copy_from_sockptr() to get the number of entries (int) for cases with
XDP_RX_RING/XDP_TX_RING and XDP_UMEM_FILL_RING/XDP_UMEM_COMPLETION_RING.

Next in xsk_init_queue() there're 2 sanity checks (entries == 0) and
(!is_power_of_2(entries)) for which -EINVAL will be returned.

After that net/xdp/xsk_queue.c:xskq_create() will calculate the size
multipling the number of entries (int) with the size of u64, at least.

I wonder if there should be the upper bound (e.g. the 3rd sanity check
inside xsk_init_queue()). It seems that without the upper limit it's
quiet easy to overflow the allocated size (SIZE_MAX), especially for
32-bit architectures, for example arm nodes which were used by the
syzkaller.

In this patch I added a naive check for SIZE_MAX which helped to
skip zero-size allocation after overflow, but maybe it's not quite
right. Please, suggest if you have any thoughts about the appropriate
limit for the size of these xdp rings.

PS: the initial number of entries is 0x20000000 in syzkaller repro:
syscall(__NR_setsockopt, (intptr_t)r[0], 0x11b, 3, 0x20000040, 0x20);

Link: https://syzkaller.appspot.com/text?tag=ReproC&x=10910f18280000

 net/xdp/xsk_queue.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/xdp/xsk_queue.c b/net/xdp/xsk_queue.c
index f8905400ee07..1bc7fb1f14ae 100644
--- a/net/xdp/xsk_queue.c
+++ b/net/xdp/xsk_queue.c
@@ -34,6 +34,9 @@ struct xsk_queue *xskq_create(u32 nentries, bool umem_queue)
 	q->ring_mask = nentries - 1;
 
 	size = xskq_get_ring_size(q, umem_queue);
+	if (size == SIZE_MAX)
+		return NULL;
+
 	size = PAGE_ALIGN(size);
 
 	q->ring = vmalloc_user(size);
-- 
2.39.3


