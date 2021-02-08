Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC9C6313261
	for <lists+bpf@lfdr.de>; Mon,  8 Feb 2021 13:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbhBHMcW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Feb 2021 07:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbhBHMcT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Feb 2021 07:32:19 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423CEC061756
        for <bpf@vger.kernel.org>; Mon,  8 Feb 2021 04:31:39 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id c1so13060872wrx.2
        for <bpf@vger.kernel.org>; Mon, 08 Feb 2021 04:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=Tz3EEiGtqhAZQlBh+d9mhoi0ASY5WVHpqxEBNOrbNmA=;
        b=hn5osd+w4b+f6msnUJ7+kJz24A0jojRgXS2mYqMSj5xpjKVBeGXCXLzCKt8Ftf+lbY
         qpX4gJ0J1dO4lVRVA79nS9baDTjvoIAoXY//eu52wzA7QQodvWNW6r0xlkSfQq7cA0xZ
         Wgb8z3+33aVi1AS0syr/5HGj2aXCwlz6yzfbR6yumylmsQVWaySmoDY0pArCp0T5H0/3
         kNsZG8j22tkEsScalnGkV5qHqthq03zkM+nqh+/KjJRiIlmCQy4QKtmh/ZYPSp5JuBNs
         SjKDcFhB+25GY/A2MuGmRjCBA5TplWJHyEowV6ZUaHvwP9707N0YcvoFVS7sfJrxGCLi
         HjQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=Tz3EEiGtqhAZQlBh+d9mhoi0ASY5WVHpqxEBNOrbNmA=;
        b=Ywqi8fPx2+wlkCTMVugNNPOFjqYCMoRCkhSiTqW14yk3zvPorJY+Rt4db7gPmH6fJE
         /vT39xfxuN85RWH3T8grQjXJB0D2WtGL0FCAWqihYSassYfgt80zOqgOEs2kSjn007UG
         fmdZ9n7k9QPKDTvI2D1g8kD2mFdSzyoivjaeKG9muafxUHu5Np8bDqMOAaiEGLenPi6c
         nk9jY49Ngid/S0s1ExSuJddtGgZoHOD5ys/6m8hd1RYXPO0GlvYUus44HN2mu6vdaZHh
         g5f8GYBsHHCFYMYmgKtGujwY3/PkbdV/VKUUxEE++KnSzqXiiiYXW0EVjjhOYyQlZwFs
         RtNw==
X-Gm-Message-State: AOAM5339JLoZIwImnxmxYjpA3OMQLR18z47J2AStajgpW8TO7YhRQGBR
        r/EvpH7MIW2e+4iLr+W77mlIwRT27wSs/E7tPsSYOcCRGQsRWqMm0t69hg6ENpkREy83/d21Mlu
        CoZ+kOUiKmSiWDUx9RsZiCj1F3BgEUo45abgTsKAJOIa0tOy1xfiuNvQngsOGE6I=
X-Google-Smtp-Source: ABdhPJw3Kbgr6vQqx5hgrlT75XJqxVXpDt3t2CfAv4kQvno+YIfbJIKofJ/HAfi1W8RZlOeCSMfNWpAB9Pomcg==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:adf:8523:: with SMTP id
 32mr6576804wrh.275.1612787497636; Mon, 08 Feb 2021 04:31:37 -0800 (PST)
Date:   Mon,  8 Feb 2021 12:31:22 +0000
Message-Id: <20210208123122.956545-1-jackmanb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH bpf-next] selftests/bpf: Add missing cleanup in atomic_bounds test
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        Yonghong Song <yhs@fb.com>, linux-kernel@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add missing skeleton destroy call.

Reported-by: Yonghong Song <yhs@fb.com>
Fixes: 37086bfdc737 ("bpf: Propagate stack bounds to registers in atomics w/ BPF_FETCH")
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/selftests/bpf/prog_tests/atomic_bounds.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/atomic_bounds.c b/tools/testing/selftests/bpf/prog_tests/atomic_bounds.c
index addf127068e4..290506fa1c38 100644
--- a/tools/testing/selftests/bpf/prog_tests/atomic_bounds.c
+++ b/tools/testing/selftests/bpf/prog_tests/atomic_bounds.c
@@ -12,4 +12,6 @@ void test_atomic_bounds(void)
 	skel = atomic_bounds__open_and_load();
 	if (CHECK(!skel, "skel_load", "couldn't load program\n"))
 		return;
+
+	atomic_bounds__destroy()
 }

base-commit: 23a2d70c7a2f28eb1a8f6bc19d68d23968cad0ce
-- 
2.30.0.478.g8a0d178c01-goog

