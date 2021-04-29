Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84EA936EB19
	for <lists+bpf@lfdr.de>; Thu, 29 Apr 2021 15:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237249AbhD2NGJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Apr 2021 09:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbhD2NGJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Apr 2021 09:06:09 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB357C06138C
        for <bpf@vger.kernel.org>; Thu, 29 Apr 2021 06:05:21 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i201-20020a25d1d20000b02904ed4c01f82bso23641217ybg.20
        for <bpf@vger.kernel.org>; Thu, 29 Apr 2021 06:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=dBDPUd6OEZUbveW3fcmwIajvKcq5g8Z72TTKCSfESO0=;
        b=nRh86q6+YSD5vdlfgm97OOyL3sWvNGVQZuU5Fp4lJkrtv8saGQ537qpzdPmQ6mzJN9
         W+wyyUPl1emjGz5Sce2KO1DNGkXGVECrq6hgD9uelgFh81LrPnc7C+ukhgsV9lfNlOdr
         N5br/ybBGs+90Kg0AQK76eExLy8eZCBNb3p7wVqDE7rw73TkGMKF4Iny6vETrv1o/9wl
         8JJFUA6PpqOHobLIkG2cNZrJptP0Jxl3bDTkYUAkRO+Fg33dO5qCAdJDmY5NRMuU/tGU
         FZlvUPZJk/C/VlLDXCrGzsDkRmqIsnwiNXwhVAz2Or2ZYju8ZS7taBx6ne4pDe6YmvS1
         aiTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=dBDPUd6OEZUbveW3fcmwIajvKcq5g8Z72TTKCSfESO0=;
        b=V/Ko60ffEgzxJ640mi3wJWXlR/hM8VggKKAuUlvqf3iSWpLV4RwILid7RyvoS8iT74
         +HupJtARXatTR83NuYk6V7+K/deDJPrmDzRLL+quQIzksCrlcvC/9efjokDWckBB3gm3
         Obb3POj1FxOqv69WmnwUlOoPSpby4akuZev6IRDXPmwbpjCIT6DzdnR7gc9XDcOo5M7x
         tncREQ3Oqeo8cbu4X0iTLCWL2v+b8vDV6IqyufOdUBUvYhMo6OFqhph/Vugx+MmCWMSH
         wDOpoZ9oh43jmygiQCiEKP1v80RJYWZij8ZoDd2KWxn3U9DYQYtrura37g9mt3Qadnza
         zyjQ==
X-Gm-Message-State: AOAM530yWWu/DP3KkNeQF1Swi//xkswgwRmdJJPAktfUfZVRUSzuYYIs
        nWmXGZ754a3cpb29kpLVW1+fqHAyzDmk93JmK/7+LlDZijDzy47npLIcRfx8andmDEtZFKf6xBB
        cH4LRjD28aEKcY2yEDSLJzqObXXE08SACDaGws36H0IWwABIU2Jw2HM+l7aNvFCE=
X-Google-Smtp-Source: ABdhPJy8mvO1vCbW824a5Lt9RNNd1uTOm5bVBNwdxx+J9QO0FZuPU3BUQs4IO5oNUEfhO0AmL4+Ajj8PvP0A/g==
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a05:6902:4e2:: with SMTP id
 w2mr17353469ybs.79.1619701520798; Thu, 29 Apr 2021 06:05:20 -0700 (PDT)
Date:   Thu, 29 Apr 2021 13:05:10 +0000
Message-Id: <20210429130510.1621665-1-jackmanb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH v2 bpf-next] libbpf: Fix signed overflow in ringbuf_process_ring
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        linux-kernel@vger.kernel.org, kpsingh@kernel.org,
        revest@chromium.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

One of our benchmarks running in (Google-internal) CI pushes data
through the ringbuf faster htan than userspace is able to consume
it. In this case it seems we're actually able to get >INT_MAX entries
in a single ringbuf_buffer__consume call. ASAN detected that cnt
overflows in this case.

Fix by using 64-bit counter internally and then capping the result to
INT_MAX before converting to the int return type.

Fixes: bf99c936f947 (libbpf: Add BPF ring buffer support)
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---

diff v1->v2: Now we don't break the loop at INT_MAX, we just cap the reported
entry count.

Note: I feel a bit guilty about the fact that this makes the reader
think about implicit conversions. Nobody likes thinking about that.

But explicit casts don't really help with clarity:

  return (int)min(cnt, (int64_t)INT_MAX); // ugh

shrug..

 tools/lib/bpf/ringbuf.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index e7a8d847161f..2e114c2d0047 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -204,7 +204,9 @@ static inline int roundup_len(__u32 len)

 static int ringbuf_process_ring(struct ring* r)
 {
-	int *len_ptr, len, err, cnt = 0;
+	int *len_ptr, len, err;
+	/* 64-bit to avoid overflow in case of extreme application behavior */
+	int64_t cnt = 0;
 	unsigned long cons_pos, prod_pos;
 	bool got_new_data;
 	void *sample;
@@ -240,7 +242,7 @@ static int ringbuf_process_ring(struct ring* r)
 		}
 	} while (got_new_data);
 done:
-	return cnt;
+	return min(cnt, INT_MAX);
 }

 /* Consume available ring buffer(s) data without event polling.
@@ -263,8 +265,8 @@ int ring_buffer__consume(struct ring_buffer *rb)
 }

 /* Poll for available data and consume records, if any are available.
- * Returns number of records consumed, or negative number, if any of the
- * registered callbacks returned error.
+ * Returns number of records consumed (or INT_MAX, whichever is less), or
+ * negative number, if any of the registered callbacks returned error.
  */
 int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms)
 {
--
2.31.1.498.g6c1eba8ee3d-goog

