Return-Path: <bpf+bounces-11476-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CECF07BAAB1
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 21:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 871F62820FB
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 19:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3EF4177A;
	Thu,  5 Oct 2023 19:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4BlTaBF"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C894174F;
	Thu,  5 Oct 2023 19:49:32 +0000 (UTC)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E42F9;
	Thu,  5 Oct 2023 12:49:30 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-50307acd445so1751927e87.0;
        Thu, 05 Oct 2023 12:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696535369; x=1697140169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qPYaRKIDdTM5S6kpvnsOytPvCHdetsXKEErzIEZmPrQ=;
        b=T4BlTaBFwK7y3+VYAETVgSaBeoWkM+4e4bRMbJ9gINri8r9ldWnJCMxmHPtwBJeUdj
         gLH2LTvAUO8ccvXRnH1zQFwrqWgA4/558CKYkK/ZG/XJeh/EF5F77kALamf7t61fvm2B
         98YySvFSxtskCfupBke7nAUcw3zBYSMLpRsUGUJ0xIF85XIFktfCUm212BB7ptcCMSlV
         iWsQxdHbnv5p8lhX+FQwxPSmLF9bHKh+fkYuhmmm2dUpMx82Q+tZWdj4URwq1bAwfTTI
         Cth96ipNh7So36Q5luKTWjQ/pI2Be/X/JkSsKmGmg5tMV1gLZ/2rixf58ceRgm4pPxv5
         3Zmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696535369; x=1697140169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qPYaRKIDdTM5S6kpvnsOytPvCHdetsXKEErzIEZmPrQ=;
        b=t2LMJxEYi44G7e54b7VNil2sjVOfW7eM75awU6Z0WBoAV54OAtzuY8h3tTJxn3htZn
         KwCg6iCfH8fOPPMYhfr7XOujwvaOzL2OBn1ip/gZXK7h0hCSIkPBG6gp3FYWPeg/Bu4L
         QzVtArKcoZOjCKivrDssRAf/+ijygOiZW2+bYyD+U4/BK5Z0QR7NV6MyOAEi2KA9dyER
         U044LoBERLi5sbpjs15DAo/Tu4BL3gtN1rQ6FIXXEhhciuZXFAO1NVcXQxBwHtdA0N0p
         uO9aUpznkTx92dbz2jOVxrzp4QozHHiW1reeDxbsyheKxY8yFFgvDi4J9y0jdsgufSNZ
         tzyA==
X-Gm-Message-State: AOJu0YxBRLeDPy/pvf9UPNFS74KddezP5Y0wdhRegALE4TjXuWMb4aO6
	yFiSSSmkdVcInzxVchmhKlg=
X-Google-Smtp-Source: AGHT+IFcBI1mK2an0Jghnbh8e/bVxELhzBhXb8uEW5u/Me2UPPHFkwieF1bwG3mOh94+4+n6Vm+wFw==
X-Received: by 2002:a19:6518:0:b0:500:acf1:b42f with SMTP id z24-20020a196518000000b00500acf1b42fmr4489663lfb.53.1696535368815;
        Thu, 05 Oct 2023 12:49:28 -0700 (PDT)
Received: from localhost.localdomain ([77.222.24.57])
        by smtp.gmail.com with ESMTPSA id x12-20020a19f60c000000b004fe28e3841bsm415655lfe.267.2023.10.05.12.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 12:49:28 -0700 (PDT)
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
Subject: [PATCH bpf v3] net/xdp: fix zero-size allocation warning in xskq_create()
Date: Thu,  5 Oct 2023 22:35:49 +0300
Message-Id: <20231005193548.515-1-andrew.kanner@gmail.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
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
    v3:
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

 net/xdp/xsk_queue.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/xdp/xsk_queue.c b/net/xdp/xsk_queue.c
index f8905400ee07..c7e8bbb12752 100644
--- a/net/xdp/xsk_queue.c
+++ b/net/xdp/xsk_queue.c
@@ -34,6 +34,11 @@ struct xsk_queue *xskq_create(u32 nentries, bool umem_queue)
 	q->ring_mask = nentries - 1;
 
 	size = xskq_get_ring_size(q, umem_queue);
+	if (unlikely(size == SIZE_MAX)) {
+		kfree(q);
+		return NULL;
+	}
+
 	size = PAGE_ALIGN(size);
 
 	q->ring = vmalloc_user(size);
-- 
2.39.3


