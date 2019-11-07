Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACBAFF350B
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2019 17:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389339AbfKGQwX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Nov 2019 11:52:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35422 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729509AbfKGQwX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Nov 2019 11:52:23 -0500
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1B5ACC056808
        for <bpf@vger.kernel.org>; Thu,  7 Nov 2019 16:52:23 +0000 (UTC)
Received: by mail-lj1-f199.google.com with SMTP id p25so620696lji.23
        for <bpf@vger.kernel.org>; Thu, 07 Nov 2019 08:52:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=coY7ll6zI9iYn6/3XVcHoVcsUowxThFI2UGP9S+O/jc=;
        b=CIqiyhUqNp8/mlUwcLteuf/MLwJLwUJ/cVIwKmyEZav1gy/0YXmQBUN9QPyJuARLrG
         1Gn0/4jNRo7AdjM8XkoZJgD8YPyi0UdSk+FWVSEo/cgl3Mqq1u1lDp7xI1UIfgRGfvbf
         dJNmRIGBEpbIuz38BGiKxDh/rRC7Alpk78JS8yBWNtQO8lCTJeGorX0ifXM86vhtkfwH
         KovrKanWn9WJPUUqEbByBOGduTivBXN2XWMPsKk4P+ew4+/zqOGeDdmyE0fqPieYtZux
         lv+uPYhcqfjRHkSVxCSllLdC4zgOsZe02jhkx6xM7zhNv9i5M18GE6nNyW57es1vipON
         JYnQ==
X-Gm-Message-State: APjAAAU1ZhkhjsSNzC0RyvGaIePELtI7nZcd7mrEAnv8BEm8eBXDdTUR
        43ptUbCfhHeHePk271oNizzjAnv1VQnLPX72hg/sjl9ILSAEt91nWdoIhJIjteUXGcSr24sGpyC
        KaHnBB9Eg/lbW
X-Received: by 2002:a2e:7811:: with SMTP id t17mr3199043ljc.225.1573145541660;
        Thu, 07 Nov 2019 08:52:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqwYhbNCUXFifvZe7gefvzI3qyBsufNepIR14D2koN2xOGrU96FmJ6xbrgCdsg974Et3TUp1MA==
X-Received: by 2002:a2e:7811:: with SMTP id t17mr3199027ljc.225.1573145541473;
        Thu, 07 Nov 2019 08:52:21 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id c12sm1408451ljk.77.2019.11.07.08.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 08:52:20 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 655F61818B5; Thu,  7 Nov 2019 17:52:20 +0100 (CET)
Subject: [PATCH bpf-next 2/6] selftests/bpf: Add tests for automatic map
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
Date:   Thu, 07 Nov 2019 17:52:20 +0100
Message-ID: <157314554027.693412.3764267220990589755.stgit@toke.dk>
In-Reply-To: <157314553801.693412.15522462897300280861.stgit@toke.dk>
References: <157314553801.693412.15522462897300280861.stgit@toke.dk>
User-Agent: StGit/0.20
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

