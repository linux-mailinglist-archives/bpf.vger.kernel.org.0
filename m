Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2F436CA13
	for <lists+bpf@lfdr.de>; Tue, 27 Apr 2021 19:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235647AbhD0RKT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Apr 2021 13:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235593AbhD0RKR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Apr 2021 13:10:17 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5177C061574
        for <bpf@vger.kernel.org>; Tue, 27 Apr 2021 10:09:31 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id q18-20020adfc5120000b029010c2bdd72adso3080733wrf.16
        for <bpf@vger.kernel.org>; Tue, 27 Apr 2021 10:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=mu8pX+qKetUtW12TmI9eJNbJjh/oUdlMUUsluEXLfvw=;
        b=WCpOjzlkH6FzzoyCziZGd4rXEDGbXBj/lLhRUgVLmERfRaWHFdc+72dNdyUlitF6ya
         Nh8THY92dUXL/RvjEgqfQZ9SErCn8xmPd3WWoYF+5/4Rra53oi45hgR/ApWgIePwMj55
         ysdigqlMn0S1XDUQBMGGBjgKFgl4WU13YwTB3jrJ62wP35NPLYqeb0tZ75jA0bTU1xLw
         DCiMn9dWs10Ozf9ohr0Ciwl4AFL37PuqEvcTkXuXcrRVdmsvTXuX1P/7hgR83jRv9f3x
         rv8y0fNjNI53NJp90tYLcd4w+M1F8i4BUZrlucc/19+VxwtTC5OuMonAPcACXvOsshed
         ArNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=mu8pX+qKetUtW12TmI9eJNbJjh/oUdlMUUsluEXLfvw=;
        b=MvL1GhU4aWiERcnb2R6RBS/NSoo4z2jz2bSujkbAb2x/aMBDk1+5arJpr9mW2RXH00
         oZIB7RGbdlcKEnaOy5gs/M0HHkM/ESRw8x5kzznCK+KJJfo7P5bSRSB42djHccpn1Se8
         koK+/TD7UO2iVfhVjYqeRcS35C9aAeJR9y/PQZYRIyI/y4aaitmUMMca5cfxOgiUA6MR
         yQr/iS+go0QvGe7CevLYE6RoqSW5EhdvlFdaHy8SltA9t4akAF/ATrSvLx6gVThhdN9H
         WYlADK/tg3XNRecbsPuzt6wMg4kiH1TKuZpHtRuG+aMaevqbqcvTGaBn/8PQ6OvAwls3
         qcog==
X-Gm-Message-State: AOAM530oG3sK9S9YBwv3e0Cxc5QmJoIi7mI3eh1Q9WJhMyaDPILMHvqy
        qeJTWH8pGE+EEFkP8nhmo7eUuH/j33jtDU9jQy2E22e47KXRXCvVLXZJOg502QledoccCRD5p//
        8UKOY55eQUOJEFLLUiXIfzkE4B73u04ld7wD6U3wOjGXEmLknDrZR4OOpBgppacA=
X-Google-Smtp-Source: ABdhPJyefHhcmwYReiM2A2TwzgIWtD0xJux9CmXCPPb97LV9WTjsEUBW+WDFYB4DSs6Bi2ggVQYpKTRblq6tYg==
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a7b:c5c1:: with SMTP id
 n1mr5257391wmk.83.1619543369004; Tue, 27 Apr 2021 10:09:29 -0700 (PDT)
Date:   Tue, 27 Apr 2021 17:08:59 +0000
Message-Id: <20210427170859.579924-1-jackmanb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH bpf-next] libbpf: Fix signed overflow in ringbuf_process_ring
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

One of our benchmarks running in (Google-internal) CI pushes data
through the ringbuf faster than userspace is able to consume
it. In this case it seems we're actually able to get >INT_MAX entries
in a single ringbuf_buffer__consume call. ASAN detected that cnt
overflows in this case.

Fix by just setting a limit on the number of entries that can be
consumed.

Fixes: bf99c936f947 (libbpf: Add BPF ring buffer support)
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/lib/bpf/ringbuf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index e7a8d847161f..445a21df0934 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -213,8 +213,8 @@ static int ringbuf_process_ring(struct ring* r)
 	do {
 		got_new_data = false;
 		prod_pos = smp_load_acquire(r->producer_pos);
-		while (cons_pos < prod_pos) {
+		/* Don't read more than INT_MAX, or the return vale won't make sense. */
+		while (cons_pos < prod_pos && cnt < INT_MAX) {
 			len_ptr = r->data + (cons_pos & r->mask);
 			len = smp_load_acquire(len_ptr);

--
2.31.1.498.g6c1eba8ee3d-goog

