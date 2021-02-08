Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0F74313281
	for <lists+bpf@lfdr.de>; Mon,  8 Feb 2021 13:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbhBHMit (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Feb 2021 07:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbhBHMiZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Feb 2021 07:38:25 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E47C061788
        for <bpf@vger.kernel.org>; Mon,  8 Feb 2021 04:37:45 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id p20so9421514qtn.23
        for <bpf@vger.kernel.org>; Mon, 08 Feb 2021 04:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=loEBbKa5Ndufz/0YdKNALswJPUUf0CuP6QsASXheX1o=;
        b=Sj/6u2t3k3ypU8C8kDoe7HnCdR55zJMrrmG1xeTBcCvNTJC5efYH56ucfavpLg2XOJ
         9AckL7Ceh0qr7NQMTAWaHA1ATX+njnAvTVHIh/OUeJ0/9dFZIpeaZs9xkxqyX00up7Is
         67fUA60LqD7cmdxfd2IxQc1Pcuz5jIlF6Gmbk998zQNhNprTyZOe0U+DUWq6fojZNbkh
         5jrq5vPDpWNfVJd4tktAcWTkyK72/gQOMI19uwl5kAG0UnKq5YWRt9G1OTmuDVqDUBqO
         4odIaUALMJbPInUFkz8EXEwtLHi/Un47HZZCMfPzR6uxV7lDXdv0EOlyOsXpY+frdjPS
         ap2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=loEBbKa5Ndufz/0YdKNALswJPUUf0CuP6QsASXheX1o=;
        b=gnC8sONu03+r8vb6soUXFBtsCxvboSaNzpziIzxIzqyLl2N2yv2kM9ennDsSjP+ZdQ
         En7n6EiTuWg3TyQfqeMuhUfy8E/szxkXtQuLpsljpEyWGf0n37eEH7Vz+wmfCjUA+FO4
         zlNoRluLHD+JI+G5+wlTYmEgfrbiJR03GsN8JjEcQ7PuFZniav9NZJjX2UacKDJv1h1K
         sjKAtfHJVYBURrQtXKI5/XCvJzDsj4/JWW914gwIXZLJ/uhJdb5UTWjCNYlVKv6Urr4u
         QtS2g4NUsP7tumOhIffdCoHz7oWAmcvu9ZgPcvLmnel4GvWSUYq6uXO+KCdYuddMGxXV
         q88g==
X-Gm-Message-State: AOAM53322YiLWPEX/KGDuC4y7TSr8SgdsSNAt5D8+XAfPqSKf3kxan7K
        9d0kgcgJytZxwyIPa3Rbc4DyipPGbAJUC4OfeflrJnnoVgF6Q3H22jQFI3Ppy2ymWjx6Y5win2V
        ylCkFBjFxaVcy1C5oJjtNwshGnOIl2tYQRrAeU2ahqeKpl9BC8+MzZGrxSizzdFY=
X-Google-Smtp-Source: ABdhPJyXLZ/NX2/0tyD5Vmr71iIcpYBLiXRQYku1uepql6hAHvWTX6HNsZbuPGpJ0dx7IfhwC6CYOs9g4J4E5Q==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:ad4:41c5:: with SMTP id
 a5mr15763127qvq.41.1612787864180; Mon, 08 Feb 2021 04:37:44 -0800 (PST)
Date:   Mon,  8 Feb 2021 12:37:37 +0000
Message-Id: <20210208123737.963172-1-jackmanb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v2 bpf-next] selftests/bpf: Add missing cleanup in
 atomic_bounds test
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

Differences from v1: this actually builds.

 tools/testing/selftests/bpf/prog_tests/atomic_bounds.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/atomic_bounds.c b/tools/testing/selftests/bpf/prog_tests/atomic_bounds.c
index addf127068e4..69bd7853e8f1 100644
--- a/tools/testing/selftests/bpf/prog_tests/atomic_bounds.c
+++ b/tools/testing/selftests/bpf/prog_tests/atomic_bounds.c
@@ -12,4 +12,6 @@ void test_atomic_bounds(void)
 	skel = atomic_bounds__open_and_load();
 	if (CHECK(!skel, "skel_load", "couldn't load program\n"))
 		return;
+
+	atomic_bounds__destroy(skel);
 }

base-commit: 23a2d70c7a2f28eb1a8f6bc19d68d23968cad0ce
--
2.30.0.478.g8a0d178c01-goog

