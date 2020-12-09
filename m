Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 568272D40EA
	for <lists+bpf@lfdr.de>; Wed,  9 Dec 2020 12:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730354AbgLILUT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Dec 2020 06:20:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20062 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730358AbgLILUP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Dec 2020 06:20:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607512728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vHtRZEbZli1h982vP/LiKLhTpQ4S7yCfLA6svbBiHq8=;
        b=ihcgPzyeDjXEJNdIEsYIUpZCEh+KM3yj5P14vF+GnVt3GgoQHWEzrbkoTPsmwMdnHq/NeH
        eWjxqL9LENWV+nI9WuREbN1RWngGvOJ9QbHWX7cPADfpJFGQvUNfvr6RT0fd2waDgq2cIa
        zTopSukcrpn5VQnCFxian8gLDtTatFU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-jiH1CIa5OY6JEzcBmZW3Ww-1; Wed, 09 Dec 2020 06:18:46 -0500
X-MC-Unique: jiH1CIa5OY6JEzcBmZW3Ww-1
Received: by mail-wm1-f72.google.com with SMTP id z12so423559wmf.9
        for <bpf@vger.kernel.org>; Wed, 09 Dec 2020 03:18:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=vHtRZEbZli1h982vP/LiKLhTpQ4S7yCfLA6svbBiHq8=;
        b=WFFMIbfcW26lzphO5zTHTMj9MjU+dqo3ME/HtxvohA20eZCOka2qXwbQ0rqMB6PWeT
         04rxV6zqinQCLN/FL9yjolTqgcQCg7eND1nD/Iyh7X+Z+LBSDWfB3JH1rmmqzy5kNrQq
         9LERLuqFHnofcRrQFGWv1dEBtKkckQIbn0b83EkY82vrSrZPTGiWZpgwKsBPOAAZhWfN
         WXl2ZcSuNkZ7+QPj+u6dP02FfNPiovxUdDXAuk2cGsBa2SAdjbQlKoP0IV5bthZq39ku
         E5nNG5xoPVBUdFLr3yJYtqs+uCY7dlJDe2eMC88JTzy17EAnjaGV/WLvQj0GCMeTMozp
         YmYQ==
X-Gm-Message-State: AOAM531VT4iHM+WiICjrkwUCpoaprTeBbqP9E8gUWzM5jasPRfXsWK3v
        arEDMEXJJSTxgSkRu+B9Hv3gTyCjfP3YMDK95vkBYh3aX/UyViSY8C9w+K/9MahnzZbuXRsRp8d
        s1FI8hqiK5RU1
X-Received: by 2002:a5d:6105:: with SMTP id v5mr2065771wrt.178.1607512725294;
        Wed, 09 Dec 2020 03:18:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxB6RTggDKWVmluBFuFp8fDNooX99A3rM0VufkhCcyMx9n9rSn9l50zgZfXiRLkF1cVaFOU/Q==
X-Received: by 2002:a5d:6105:: with SMTP id v5mr2065727wrt.178.1607512724896;
        Wed, 09 Dec 2020 03:18:44 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id w12sm3172176wre.57.2020.12.09.03.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 03:18:44 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 6B110180004; Wed,  9 Dec 2020 12:18:42 +0100 (CET)
Subject: [PATCH bpf v3 4/7] selftests/bpf/test_offload.py: only check verifier
 log on verification fails
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Romain Perier <romain.perier@gmail.com>,
        Allen Pais <apais@linux.microsoft.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Simon Horman <simon.horman@netronome.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Jiri Benc <jbenc@redhat.com>, oss-drivers@netronome.com,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Date:   Wed, 09 Dec 2020 12:18:42 +0100
Message-ID: <160751272235.104774.3114776457666871889.stgit@toke.dk>
In-Reply-To: <160751271801.104774.5575431902172553440.stgit@toke.dk>
References: <160751271801.104774.5575431902172553440.stgit@toke.dk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

Since 6f8a57ccf85 ("bpf: Make verifier log more relevant by default"), the
verifier discards log messages for successfully-verified programs. This
broke test_offload.py which is looking for a verification message from the
driver callback. Change test_offload.py to use the toggle in netdevsim to
make the verification fail before looking for the verification message.

Fixes: 6f8a57ccf85 ("bpf: Make verifier log more relevant by default")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/testing/selftests/bpf/test_offload.py |   19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_offload.py b/tools/testing/selftests/bpf/test_offload.py
index becd27b2f4ba..61527b43f067 100755
--- a/tools/testing/selftests/bpf/test_offload.py
+++ b/tools/testing/selftests/bpf/test_offload.py
@@ -911,11 +911,18 @@ try:
 
     sim.tc_flush_filters()
 
+    start_test("Test TC offloads failure...")
+    sim.dfs["dev/bpf_bind_verifier_accept"] = 0
+    ret, _, err = sim.cls_bpf_add_filter(obj, verbose=True, skip_sw=True,
+                                         fail=False, include_stderr=True)
+    fail(ret == 0, "TC filter did not reject with TC offloads enabled")
+    check_verifier_log(err, "[netdevsim] Hello from netdevsim!")
+    sim.dfs["dev/bpf_bind_verifier_accept"] = 1
+
     start_test("Test TC offloads work...")
     ret, _, err = sim.cls_bpf_add_filter(obj, verbose=True, skip_sw=True,
                                          fail=False, include_stderr=True)
     fail(ret != 0, "TC filter did not load with TC offloads enabled")
-    check_verifier_log(err, "[netdevsim] Hello from netdevsim!")
 
     start_test("Test TC offload basics...")
     dfs = simdev.dfs_get_bound_progs(expected=1)
@@ -1032,6 +1039,15 @@ try:
     rm("/sys/fs/bpf/offload")
     sim.wait_for_flush()
 
+    start_test("Test XDP load failure...")
+    sim.dfs["dev/bpf_bind_verifier_accept"] = 0
+    ret, _, err = bpftool_prog_load("sample_ret0.o", "/sys/fs/bpf/offload",
+                                 dev=sim['ifname'], fail=False, include_stderr=True)
+    fail(ret == 0, "verifier should fail on load")
+    check_verifier_log(err, "[netdevsim] Hello from netdevsim!")
+    sim.dfs["dev/bpf_bind_verifier_accept"] = 1
+    sim.wait_for_flush()
+
     start_test("Test XDP offload...")
     _, _, err = sim.set_xdp(obj, "offload", verbose=True, include_stderr=True)
     ipl = sim.ip_link_show(xdp=True)
@@ -1039,7 +1055,6 @@ try:
     progs = bpftool_prog_list(expected=1)
     prog = progs[0]
     fail(link_xdp["id"] != prog["id"], "Loaded program has wrong ID")
-    check_verifier_log(err, "[netdevsim] Hello from netdevsim!")
 
     start_test("Test XDP offload is device bound...")
     dfs = simdev.dfs_get_bound_progs(expected=1)

