Return-Path: <bpf+bounces-6890-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0E576F334
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 21:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E1F61C21611
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 19:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6FC2591F;
	Thu,  3 Aug 2023 19:05:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4DB1F934;
	Thu,  3 Aug 2023 19:05:19 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17143A93;
	Thu,  3 Aug 2023 12:04:49 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5230f8da574so1159539a12.3;
        Thu, 03 Aug 2023 12:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691089488; x=1691694288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjWDL2QftxnG9c5+Vha2qoI437XfBQWXN8yDWNa47PQ=;
        b=mV4KTN0ysT5hTWu9K8Zc31QqIGOV7LQ1dwH4El6DJSEHE1FtI7dZUuEczg74YLrZOT
         0EgbOxFz3pD9xeAK9hkbHYdc8Xx8xR/Jo2aomITNvTm6y5PWIfWVNZ7l789Ld8GZfjkn
         cp4c/v4/D4O4XC6+Vv7CEJUb/sh3D+as1ZZeJUk3990UkQT0Oimc1u4ElS7CwkE8Mitx
         wdGw5o06v4xn2IF1MTnG1qHGxULGuI60c4DVaUMCJe2mKVippAQQW2EH3ek6G/QW+Z7p
         9OK01xzemoCiwbDcj3oFZwFVfOHejPB+7PLomRQ4Iir8StXjxNo+DnXSjRaLPwgcbKB0
         KM1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691089488; x=1691694288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OjWDL2QftxnG9c5+Vha2qoI437XfBQWXN8yDWNa47PQ=;
        b=N7gXFKXhB7defZ4+7b6SbBBp9LJCsrY9V2FfA0YJV+bUVOhfpscORrh0i1u7LNSzeo
         3XSCAkXSwwLjcP+XhW7TpB6fMO7CDBrCudlPuFNrmtuh5UGwCR8h1uotdyaiK/rwKnhY
         ABTKlRNlrj3632GgO055rTZMnM+ZX/VuFRb4bv/x5Cazdo+TkKm+0FZiS2uV9bX7bjXG
         EkUOT8UttUaIwWVN+yDC3FxTjFtcyr2V01itaGrLgBvkMKQm1+ehXdtfnQnCT3o4D9JA
         uUofZtuOUAXJPm6710j0pJdG7YQaxt3hcM6vOME9fvWoeWdIgoeTiA1F4jwKJwZS0400
         onbg==
X-Gm-Message-State: ABy/qLYIQySqtHb5EIjN5qu3W14DI8/Q8LasK7MSSDWiIw5s96/gW4vh
	n+6yTR27tzOpDar7YXy2BwA=
X-Google-Smtp-Source: APBJJlGddjj+hpSRgOCDARjrmWpd5r3t7GFMF97AXlxC73gVDE7QpmUeSSqOWqDM6EPTtAa0eyyQ2w==
X-Received: by 2002:aa7:c251:0:b0:522:3410:de23 with SMTP id y17-20020aa7c251000000b005223410de23mr7929054edo.3.1691089487896;
        Thu, 03 Aug 2023 12:04:47 -0700 (PDT)
Received: from dev7.kernelcare.com ([2a01:4f8:201:23::2])
        by smtp.gmail.com with ESMTPSA id g8-20020a056402180800b005227ead61d0sm158232edy.83.2023.08.03.12.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 12:04:47 -0700 (PDT)
From: Andrew Kanner <andrew.kanner@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	mw@semihalf.com,
	shayagr@amazon.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jasowang@redhat.com,
	hawk@kernel.org,
	jbrouer@redhat.com,
	dsahern@gmail.com,
	john.fastabend@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	syzbot+f817490f5bd20541b90a@syzkaller.appspotmail.com,
	Andrew Kanner <andrew.kanner@gmail.com>
Subject: [PATCH net-next v5 2/2] net: core: remove unnecessary frame_sz check in bpf_xdp_adjust_tail()
Date: Thu,  3 Aug 2023 21:03:18 +0200
Message-Id: <20230803190316.2380231-1-andrew.kanner@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230803185947.2379988-1-andrew.kanner@gmail.com>
References: <20230803185947.2379988-1-andrew.kanner@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Syzkaller reported the following issue:
=======================================
Too BIG xdp->frame_sz = 131072
WARNING: CPU: 0 PID: 5020 at net/core/filter.c:4121
  ____bpf_xdp_adjust_tail net/core/filter.c:4121 [inline]
WARNING: CPU: 0 PID: 5020 at net/core/filter.c:4121
  bpf_xdp_adjust_tail+0x466/0xa10 net/core/filter.c:4103
...
Call Trace:
 <TASK>
 bpf_prog_4add87e5301a4105+0x1a/0x1c
 __bpf_prog_run include/linux/filter.h:600 [inline]
 bpf_prog_run_xdp include/linux/filter.h:775 [inline]
 bpf_prog_run_generic_xdp+0x57e/0x11e0 net/core/dev.c:4721
 netif_receive_generic_xdp net/core/dev.c:4807 [inline]
 do_xdp_generic+0x35c/0x770 net/core/dev.c:4866
 tun_get_user+0x2340/0x3ca0 drivers/net/tun.c:1919
 tun_chr_write_iter+0xe8/0x210 drivers/net/tun.c:2043
 call_write_iter include/linux/fs.h:1871 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x650/0xe40 fs/read_write.c:584
 ksys_write+0x12f/0x250 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

xdp->frame_sz > PAGE_SIZE check was introduced in commit c8741e2bfe87
("xdp: Allow bpf_xdp_adjust_tail() to grow packet size"). But Jesper
Dangaard Brouer <jbrouer@redhat.com> noted that after introducing the
xdp_init_buff() which all XDP driver use - it's safe to remove this
check. The original intend was to catch cases where XDP drivers have
not been updated to use xdp.frame_sz, but that is not longer a concern
(since xdp_init_buff).

Running the initial syzkaller repro it was discovered that the
contiguous physical memory allocation is used for both xdp paths in
tun_get_user(), e.g. tun_build_skb() and tun_alloc_skb(). It was also
stated by Jesper Dangaard Brouer <jbrouer@redhat.com> that XDP can
work on higher order pages, as long as this is contiguous physical
memory (e.g. a page).

Reported-and-tested-by: syzbot+f817490f5bd20541b90a@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/000000000000774b9205f1d8a80d@google.com/T/
Link: https://syzkaller.appspot.com/bug?extid=f817490f5bd20541b90a
Link: https://lore.kernel.org/all/20230725155403.796-1-andrew.kanner@gmail.com/T/
Fixes: 43b5169d8355 ("net, xdp: Introduce xdp_init_buff utility routine")
Signed-off-by: Andrew Kanner <andrew.kanner@gmail.com>
Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
Acked-by: Jason Wang <jasowang@redhat.com>
---

Notes (akanner):
    v5:
      - same as v4, but cc-ed bpf@vger.kernel.org according to v3->v4
        change
    v4: https://lore.kernel.org/all/20230801220710.464-1-andrew.kanner@gmail.com/T/
      - remove bpf_xdp_adjust_tail() check for frame_sz instead.
    v3: https://lore.kernel.org/all/20230725155403.796-1-andrew.kanner@gmail.com/T/
    v2: https://lore.kernel.org/all/20230725153941.653-1-andrew.kanner@gmail.com/T/
    v1: https://lore.kernel.org/all/20230724221326.384-1-andrew.kanner@gmail.com/T/
      - initial attempts to fix drivers/net/tun.c:tun_get_user(),
        e.g. tun_build_skb() or tun_alloc_skb(), to not exceed
        xdp->frame_sz check from net/core/filter.c

 net/core/filter.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 06ba0e56e369..28a59596987a 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4116,12 +4116,6 @@ BPF_CALL_2(bpf_xdp_adjust_tail, struct xdp_buff *, xdp, int, offset)
 	if (unlikely(data_end > data_hard_end))
 		return -EINVAL;
 
-	/* ALL drivers MUST init xdp->frame_sz, chicken check below */
-	if (unlikely(xdp->frame_sz > PAGE_SIZE)) {
-		WARN_ONCE(1, "Too BIG xdp->frame_sz = %d\n", xdp->frame_sz);
-		return -EINVAL;
-	}
-
 	if (unlikely(data_end < xdp->data + ETH_HLEN))
 		return -EINVAL;
 
-- 
2.39.3


