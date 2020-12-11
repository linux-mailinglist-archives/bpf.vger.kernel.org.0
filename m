Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 995052D7CC3
	for <lists+bpf@lfdr.de>; Fri, 11 Dec 2020 18:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394870AbgLKRZ3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Dec 2020 12:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395180AbgLKRZA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Dec 2020 12:25:00 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF515C0613D3
        for <bpf@vger.kernel.org>; Fri, 11 Dec 2020 09:24:19 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id 91so3552021wrk.17
        for <bpf@vger.kernel.org>; Fri, 11 Dec 2020 09:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=APHaC7n4fJLD3RZO8AClrrDhtpxAUE0wAg5Ep4XGGU0=;
        b=qq7A2rqPzveYYXRI9N2jY2DGTRvg8n9VwK+k+N7hTbyEoBTUXCM+OI8LMsazJ5pFPQ
         YCV20vYcOxLziH9Ir48s1vBJ9vF+5nyJkwf3Gw67Gdh8r5rumur9HMhO4TRjg2Rr+DsW
         1L2oPOsRyjwpUWKhWv0+vjQtUVwq/zLpZX9gfzsZIgsPWvHWCuOv2Rvjeu6qxoHv9Od/
         yNQnvNVqkdoPw87GUYgHWI6ZTvIUk2ty5rAFa+0+cDQMvENdXpWsKq1gppOcjNRhTgq3
         hIq0bmtwTaRcbkTZmHuYQoOZg2XRVlgl3dx6YZfMuC9vJJw77tSLkX5sEDZsluyJe8zR
         ty7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=APHaC7n4fJLD3RZO8AClrrDhtpxAUE0wAg5Ep4XGGU0=;
        b=UQqLwwyc/zu+6/JeVBeLozX1MVzSRPS6GMFsxV8JCgpLgdvEtQFVLubJQ8tZurPT6C
         OKiyHRHaltOBXeAhtS9dJfq3WYK31c1CB70+rThXn+mPOrTL8Pu/55iQpysKpPWWq48n
         ePAi5o0zLlHDyz4GSKHnPmUnYVhRtNxl6ExbOhYUat/DZcH07Ks22a0uHXg3hsGia9H8
         hnSURc+gAsX7qUftpY6zG7JgnhUxESpce49kmWFL+FZ2mSYbXk/XtNl+WmfnxsMOKRNK
         sJsN6I43e8BPHDCHfsCoBtC9PrL9mkr0g/maY3SHkWQep6tK6dF7yEe5Nh3casTismM6
         KkrA==
X-Gm-Message-State: AOAM533C95YCD8aTY0XPsp6mCwyCxYKAbW85PMGRVUZ11ANu+IZW648n
        upSD9geFFV+ER23rCTxWX/Jg38BXYSkdGVRp9jZK8dEBSLWXlkx34qcool9scM1IkO/emEWkLvX
        t/JNQtp0FafFz29wUAJy2fdoR4cMy6+BY6VZFLclyMlb8bsvSHhRseQOMnNn3Kqo=
X-Google-Smtp-Source: ABdhPJyWfQvwgEnC9j8cMIC0WkCfewAlRRlIoL37izfTOAmQzWAl7i6PUwezm7LezdzsGUAfiaufxQ4v121LRA==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a1c:e10b:: with SMTP id
 y11mr15012503wmg.65.1607707458151; Fri, 11 Dec 2020 09:24:18 -0800 (PST)
Date:   Fri, 11 Dec 2020 17:24:09 +0000
Message-Id: <20201211172409.1918341-1-jackmanb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH bpf-next] libbpf: Expose libbpf ringbufer epoll_fd
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This allows the user to do their own manual polling in more
complicated setups.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/lib/bpf/libbpf.h  | 1 +
 tools/lib/bpf/ringbuf.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 6909ee81113a..cde07f64771e 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -536,6 +536,7 @@ LIBBPF_API int ring_buffer__add(struct ring_buffer *rb, int map_fd,
 				ring_buffer_sample_fn sample_cb, void *ctx);
 LIBBPF_API int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms);
 LIBBPF_API int ring_buffer__consume(struct ring_buffer *rb);
+LIBBPF_API int ring_buffer__epoll_fd(struct ring_buffer *rb);
 
 /* Perf buffer APIs */
 struct perf_buffer;
diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index 5c6522c89af1..45a36648b403 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -282,3 +282,9 @@ int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms)
 	}
 	return cnt < 0 ? -errno : res;
 }
+
+/* Get an fd that can be used to sleep until data is available in the ring(s) */
+int ring_buffer__epoll_fd(struct ring_buffer *rb)
+{
+	return rb->epoll_fd;
+}

base-commit: b4fe9fec51ef48011f11c2da4099f0b530449c92
-- 
2.29.2.576.ga3fc446d84-goog

