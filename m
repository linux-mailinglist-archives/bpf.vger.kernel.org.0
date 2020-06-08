Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9811F1D2B
	for <lists+bpf@lfdr.de>; Mon,  8 Jun 2020 18:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730485AbgFHQW7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Jun 2020 12:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730475AbgFHQW6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Jun 2020 12:22:58 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1600C08C5C2
        for <bpf@vger.kernel.org>; Mon,  8 Jun 2020 09:22:56 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j10so18075590wrw.8
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2020 09:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hs1EELNtgkaMondyRtgQ/6Z9mw2fYYd1xiptMHkTtFA=;
        b=ndOHGLTaByr9ofdCBK5UVRXpqyxBmcTEBUOqz/laTHtMlkelV5nMDGwIxHLn+n7LAx
         6AG+1gPjhoqT0/eGqnxXkMs+4kwhXHbdLD51zfWNha64FIlC5WiZ3l/VfS2224OY1pP5
         oqOnyaC2rND5M+dX4Nqp3MLtFrp1wWjZnDDbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hs1EELNtgkaMondyRtgQ/6Z9mw2fYYd1xiptMHkTtFA=;
        b=rUuCHoellxyXnDFai/wcSLptSxHKCnsigluIahhj3i+zwE4YoDVzXYfCZaJFw07m58
         x/Or4ta7LcMQ09hwR7gDL6GMSr7ilfWaEwBQ5qw2kChqSFOoiNbTe/tfrY1/MAf0uHQk
         CKBQySvbxgAr9yDIaCVyf1hZJdF2MRqvMuHVELx8MjPpkwiVGv2d4rUx/kp1eoLfb/wt
         /u3/s0HOGmwqcbwW7WsM3fX0WmjbRaFb3uL7ZbBm50ekc5bb1yWSFovepgRTtpOpCgrZ
         gR0Cnh1kLwkxxmoKsv3XfY/JDhH+4MZtvhhNc4OMNlSo1qkvZQN3xPo/IkhIv85rJsys
         bR1Q==
X-Gm-Message-State: AOAM531qYSfudrJIflLZQRkwc3fEYL2qgHtqsCB+tHzz8wHV/hxT2l6N
        0iH9X21JECPChJog04Z2wjaVRg==
X-Google-Smtp-Source: ABdhPJzP+Yico773WoQLz8PnS8XimH0eOsVTKoFbV8W6LsSuKSkEQnAXSFPDmG0XSmY2ceDAtZiaaA==
X-Received: by 2002:adf:9c12:: with SMTP id f18mr26206857wrc.105.1591633375425;
        Mon, 08 Jun 2020 09:22:55 -0700 (PDT)
Received: from antares.lan (f.7.9.4.f.9.a.d.f.4.a.3.6.5.1.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:156:3a4f:da9f:497f])
        by smtp.gmail.com with ESMTPSA id w3sm50929wmg.44.2020.06.08.09.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 09:22:54 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Shuah Khan <shuah@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Roman Gushchin <guro@fb.com>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH bpf] bpf: cgroup: allow multi-attach program to replace itself
Date:   Mon,  8 Jun 2020 17:22:01 +0100
Message-Id: <20200608162202.94002-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When using BPF_PROG_ATTACH to attach a program to a cgroup in
BPF_F_ALLOW_MULTI mode, it is not possible to replace a program
with itself. This is because the check for duplicate programs
doesn't take the replacement program into account.

Replacing a program with itself might seem weird, but it has
some uses: first, it allows resetting the associated cgroup storage.
Second, it makes the API consistent with the non-ALLOW_MULTI usage,
where it is possible to replace a program with itself. Third, it
aligns BPF_PROG_ATTACH with bpf_link, where replacing itself is
also supported.

Sice this code has been refactored a few times this change will
only apply to v5.7 and later. Adjustments could be made to
commit 1020c1f24a94 ("bpf: Simplify __cgroup_bpf_attach") and
commit d7bf2c10af05 ("bpf: allocate cgroup storage entries on attaching bpf programs")
as well as commit 324bda9e6c5a ("bpf: multi program support for cgroup+bpf")

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Fixes: af6eea57437a ("bpf: Implement bpf_link-based cgroup BPF program attachment")
---
 kernel/bpf/cgroup.c                                        | 2 +-
 .../testing/selftests/bpf/prog_tests/cgroup_attach_multi.c | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index fdf7836750a3..4d76f16524cc 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -378,7 +378,7 @@ static struct bpf_prog_list *find_attach_entry(struct list_head *progs,
 	}
 
 	list_for_each_entry(pl, progs, node) {
-		if (prog && pl->prog == prog)
+		if (prog && pl->prog == prog && prog != replace_prog)
 			/* disallow attaching the same prog twice */
 			return ERR_PTR(-EINVAL);
 		if (link && pl->link == link)
diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
index 139f8e82c7c6..b549fcfacc0b 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
@@ -230,6 +230,13 @@ void test_cgroup_attach_multi(void)
 		  "prog_replace", "errno=%d\n", errno))
 		goto err;
 
+	/* replace program with itself */
+	attach_opts.replace_prog_fd = allow_prog[6];
+	if (CHECK(bpf_prog_attach_xattr(allow_prog[6], cg1,
+					BPF_CGROUP_INET_EGRESS, &attach_opts),
+		  "prog_replace", "errno=%d\n", errno))
+		goto err;
+
 	value = 0;
 	CHECK_FAIL(bpf_map_update_elem(map_fd, &key, &value, 0));
 	CHECK_FAIL(system(PING_CMD));
-- 
2.25.1

