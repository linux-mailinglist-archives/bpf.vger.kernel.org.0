Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7034E2D9786
	for <lists+bpf@lfdr.de>; Mon, 14 Dec 2020 12:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgLNLjN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Dec 2020 06:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729649AbgLNLi7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Dec 2020 06:38:59 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC89C0613D3
        for <bpf@vger.kernel.org>; Mon, 14 Dec 2020 03:38:19 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id b11so11496208qtj.11
        for <bpf@vger.kernel.org>; Mon, 14 Dec 2020 03:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=uG9hUyn2l1hT7e+Msb6nBQLe6pVUc/Tidhzusbc3Z5E=;
        b=ZTznCCQdNCgK7E2pAMIcNbbA7wJKQTUvxOpa22aA1+jPwk96Q6ybn5x0Hlewl1BV+M
         rdm2A5IYo22MuIYm2ayvtprzP14QUHxfL2YaEuKws1KAxNUZKm+sb0p6O++oaRNlltYl
         9fJru+O7IVxaWdY7nsTgVYiaano6f3uFs1K8qvLOEWXkwm1MrQjDj9azwrQIsONxou1C
         HGAMcoq5m53BjAIoHoGl/dCrsQzpuCUhwTjSEklHB4K9EQb3Ly94fkYQy9fb8fUALq5w
         od0leQyMDFwrwzbMMVf1xlNh1t4EPwBdnDZsw7MrtVu57cDs653DfJXbUMb1WPPrQh60
         Qomg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=uG9hUyn2l1hT7e+Msb6nBQLe6pVUc/Tidhzusbc3Z5E=;
        b=KtfvxV+wFWOUI9o+5/bxZcQ/tjHKOSGGDAcGnJPlXZ/66Lg6nwaOQDSRLSke9XeMNa
         Jac0DOv7Yeed25m/CDFRyOa2DuRlkcFEy83/nft7ekbWxCXWCfn8FAu2T29lAQcaWGHu
         RXMrcloGZ7kez9ooBdgbMXUTKcraQvnsqNlQrhR/SUpBGJ0dp1qnozLXHp4eOzeND8v1
         P8mH4r240uBNi/nqHo+FAWhh9BixMG/sKQd7AurIGjN2IOdI9r33x63cmq5cozXuaQe0
         ZCRZqbFPpzN+Xm++3BincuUjLO9kQdRZYUPonYG8q4uWx24PlnOfZGMG63fV5pOk5DrM
         pnDQ==
X-Gm-Message-State: AOAM533EV+fiCmNzAbu4g6EWNgGbLHwVC0TYQxz8CG0mDAw0CabJvIQc
        f23Ydjry9/c9mJtbfRpl0hHLLTszZkYByTPqjM/Iw8N5mrY74mvExo7r3pWrGk8SXQUPC7EJI4F
        UV/dAZQjd2rOlrXaMlaVE8ByDzmZ2QVyPwNhvF+WnxtH5w4DGHWBshkEicnfLDWc=
X-Google-Smtp-Source: ABdhPJxHwGmlZQ28Xrpp+ClKhqzlEFvlg574xO6+LQM9eMJO9G054bEQyV8VMrMOXnK4L4JwkFMWXhYkqJ8pkQ==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a05:6214:302:: with SMTP id
 i2mr15763177qvu.14.1607945898242; Mon, 14 Dec 2020 03:38:18 -0800 (PST)
Date:   Mon, 14 Dec 2020 11:38:12 +0000
Message-Id: <20201214113812.305274-1-jackmanb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH bpf-next v2] libbpf: Expose libbpf ringbufer epoll_fd
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This provides a convenient perf ringbuf -> libbpf ringbuf migration
path for users of external polling systems. It is analogous to
perf_buffer__epoll_fd.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
Difference from v1: Added entry to libbpf.map.

 tools/lib/bpf/libbpf.h   | 1 +
 tools/lib/bpf/libbpf.map | 1 +
 tools/lib/bpf/ringbuf.c  | 6 ++++++
 3 files changed, 8 insertions(+)

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
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 7c4126542e2b..7be850271be6 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -348,4 +348,5 @@ LIBBPF_0.3.0 {
 		btf__new_split;
 		xsk_setup_xdp_prog;
 		xsk_socket__update_xskmap;
+                ring_buffer__epoll_fd;
 } LIBBPF_0.2.0;
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

