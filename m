Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6B84F5C22
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2019 01:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbfKIABC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Nov 2019 19:01:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39933 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727233AbfKIABB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Nov 2019 19:01:01 -0500
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8095A4627A
        for <bpf@vger.kernel.org>; Sat,  9 Nov 2019 00:01:00 +0000 (UTC)
Received: by mail-lf1-f71.google.com with SMTP id u28so867501lfl.14
        for <bpf@vger.kernel.org>; Fri, 08 Nov 2019 16:01:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=nbp3QfN0TQNkDe9Q9+yAlcUGzwTWjk7ZLS5MnwIXPgY=;
        b=Td99wTkgAheEHm0Lecv9UOewF08FCpkqxtvlxOnU58qM2UobvGN8dnZNS+V4OECLPJ
         uPzJyb8/ZydMP8t/hatAW5vUDbKTQlnFi1MLoud2os0TxokxhbbFq46jwUExTkXxX7Kl
         dG1n5qlwzLKtRrz6NxD8zdKsyYzAax2JHv9pinOhnklYSBdqMW8dRqRbCKwsUiToBqQu
         m/KGOLjHS5mGQw8XIy9WfIfdPs7GivocjLBfeaztdH5qiHyt2dmtjcYVjBAuzuK98l41
         0HeGX+YXnAzIToY6xQklPrKm8ICPg8o6PQNwMMKyH7i+f963tcYaIjIrI7pM2PasXwo+
         F3tA==
X-Gm-Message-State: APjAAAUvbn214UfkiicB5atSC9NSMsTXa7l+76r92EqmSwlNNXN5dMRh
        qxesYQGa+xmUY6DiqujqAXGGBR6OjxY/3d6rCEWey1hH5h2gsAOrKDZMtwt7zUsr7uIAz1rH8MK
        HTxPtLlz9tpua
X-Received: by 2002:a19:c18d:: with SMTP id r135mr860555lff.75.1573257659030;
        Fri, 08 Nov 2019 16:00:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqxDf1KmgoRL4yrpm3DCosTJB86HPeyRGvRNRw2V6JURy8FvjCLASOTjEdpnFwJ84ef+XrJa9A==
X-Received: by 2002:a19:c18d:: with SMTP id r135mr860537lff.75.1573257658807;
        Fri, 08 Nov 2019 16:00:58 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id l82sm5216038lfd.81.2019.11.08.16.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 16:00:58 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id E98D01800CC; Sat,  9 Nov 2019 01:00:56 +0100 (CET)
Subject: [PATCH bpf-next v3 2/6] selftests/bpf: Add tests for automatic map
 unpinning on load failure
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Date:   Sat, 09 Nov 2019 01:00:56 +0100
Message-ID: <157325765687.27401.1792577441648065280.stgit@toke.dk>
In-Reply-To: <157325765467.27401.1930972466188738545.stgit@toke.dk>
References: <157325765467.27401.1930972466188738545.stgit@toke.dk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

This add tests for the different variations of automatic map unpinning on
load failure.

Acked-by: Andrii Nakryiko <andriin@fb.com>
Acked-by: David S. Miller <davem@davemloft.net>
Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/testing/selftests/bpf/prog_tests/pinning.c |   20 +++++++++++++++++---
 tools/testing/selftests/bpf/progs/test_pinning.c |    2 +-
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/pinning.c b/tools/testing/selftests/bpf/prog_tests/pinning.c
index 525388971e08..041952524c55 100644
--- a/tools/testing/selftests/bpf/prog_tests/pinning.c
+++ b/tools/testing/selftests/bpf/prog_tests/pinning.c
@@ -163,12 +163,15 @@ void test_pinning(void)
 		goto out;
 	}
 
-	/* swap pin paths of the two maps */
+	/* set pin paths so that nopinmap2 will attempt to reuse the map at
+	 * pinpath (which will fail), but not before pinmap has already been
+	 * reused
+	 */
 	bpf_object__for_each_map(map, obj) {
 		if (!strcmp(bpf_map__name(map), "nopinmap"))
+			err = bpf_map__set_pin_path(map, nopinpath2);
+		else if (!strcmp(bpf_map__name(map), "nopinmap2"))
 			err = bpf_map__set_pin_path(map, pinpath);
-		else if (!strcmp(bpf_map__name(map), "pinmap"))
-			err = bpf_map__set_pin_path(map, NULL);
 		else
 			continue;
 
@@ -181,6 +184,17 @@ void test_pinning(void)
 	if (CHECK(err != -EINVAL, "param mismatch load", "err %d errno %d\n", err, errno))
 		goto out;
 
+	/* nopinmap2 should have been pinned and cleaned up again */
+	err = stat(nopinpath2, &statbuf);
+	if (CHECK(!err || errno != ENOENT, "stat nopinpath2",
+		  "err %d errno %d\n", err, errno))
+		goto out;
+
+	/* pinmap should still be there */
+	err = stat(pinpath, &statbuf);
+	if (CHECK(err, "stat pinpath", "err %d errno %d\n", err, errno))
+		goto out;
+
 	bpf_object__close(obj);
 
 	/* test auto-pinning at custom path with open opt */
diff --git a/tools/testing/selftests/bpf/progs/test_pinning.c b/tools/testing/selftests/bpf/progs/test_pinning.c
index f69a4a50d056..f20e7e00373f 100644
--- a/tools/testing/selftests/bpf/progs/test_pinning.c
+++ b/tools/testing/selftests/bpf/progs/test_pinning.c
@@ -21,7 +21,7 @@ struct {
 } nopinmap SEC(".maps");
 
 struct {
-	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(type, BPF_MAP_TYPE_HASH);
 	__uint(max_entries, 1);
 	__type(key, __u32);
 	__type(value, __u64);

