Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDC6F175DA2
	for <lists+bpf@lfdr.de>; Mon,  2 Mar 2020 15:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgCBOyM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 Mar 2020 09:54:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26727 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727308AbgCBOyM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 2 Mar 2020 09:54:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583160851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZTkROsrUTdzNCh0BfP2A3pspJU0Gn3G6vf5gKcgh6ic=;
        b=Cnnse+BnOT+eRziBqitgIwxvXV+5+qYn1cGUXz9FpL3+dFe7spJIC8ISxRMA9k4CXwUupi
        /5FiTjfvN1DWZ19nibqZZzpiGe/6GC5jxzXbVYZkCES0EBTY3bGnPzhY/tpaVtiuyR0/kz
        HJJLdmK9suyANNXzMQhPm12/tvKVdKY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-t9cyw7SnP6OYZhhq9rL4DQ-1; Mon, 02 Mar 2020 09:54:09 -0500
X-MC-Unique: t9cyw7SnP6OYZhhq9rL4DQ-1
Received: by mail-wm1-f70.google.com with SMTP id 7so2411957wmo.7
        for <bpf@vger.kernel.org>; Mon, 02 Mar 2020 06:54:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZTkROsrUTdzNCh0BfP2A3pspJU0Gn3G6vf5gKcgh6ic=;
        b=DD7/eulxJvVZ0G5aoGxWdiCaPT9LqV6gj7oY0VaOh6crZXmBpDdeM+LAHrrwa/HlQP
         7Vm9nPV6TLNj77n++onjvvONN5DFbKkchZxNITnTQxZOOSo4qoQMIJawCK8xnY589BGA
         frs/7pxGuSF5FxreJNNd37k0/2BVi1avfxpVBP61f5SZQjUj95in8Q6OJyAupXWXtLSm
         O/G2zeOBE7yD26QPcxD2chRe6sz+7MuXnRiGFEs+URkUVaKTjlVNn8XTQbSfeAYZq+5F
         i7sW5C610PEOnZ6ifcM9QhhpUmnHPShOOBveTKhztdKIM/5yhJ6OcAoG4vZEjFXSjaGQ
         fclQ==
X-Gm-Message-State: ANhLgQ2WIRGxNU+873D3PYVJ9Ywf6Jv1FnasMILfIAn34H9OFPjzyaFh
        anx3ow7kFkwF15kKhQvYe/Q9kcW4UCn5QzVpdeQQcwXgEtH2/fjrvVhcd7l6JhfF+NqUMNDSTjJ
        sLRq6UwST47EL
X-Received: by 2002:adf:e5d1:: with SMTP id a17mr2557wrn.412.1583160848130;
        Mon, 02 Mar 2020 06:54:08 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvf8Xk8oDca8+rjR4ZesAQxWjFtwuxOEnlT6X1h5GQF5BXAG+hD6IlWC37uYrSFSYkWOZpfXw==
X-Received: by 2002:adf:e5d1:: with SMTP id a17mr2536wrn.412.1583160847943;
        Mon, 02 Mar 2020 06:54:07 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id u185sm16632096wmg.6.2020.03.02.06.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 06:54:07 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 7B1B7180362; Mon,  2 Mar 2020 15:54:05 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     daniel@iogearbox.net, ast@fb.com
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        Andrey Ignatov <rdna@fb.com>
Subject: [PATCH bpf] selftests/bpf: Declare bpf_log_buf variables as static
Date:   Mon,  2 Mar 2020 15:53:48 +0100
Message-Id: <20200302145348.559177-1-toke@redhat.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The cgroup selftests did not declare the bpf_log_buf variable as static, leading
to a linker error with GCC 10 (which defaults to -fno-common). Fix this by
adding the missing static declarations.

Fixes: 257c88559f36 ("selftests/bpf: Convert test_cgroup_attach to prog_tests")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 .../testing/selftests/bpf/prog_tests/cgroup_attach_autodetach.c | 2 +-
 tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c    | 2 +-
 tools/testing/selftests/bpf/prog_tests/cgroup_attach_override.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_attach_autodetach.c b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_autodetach.c
index 5b13f2c6c402..70e94e783070 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_attach_autodetach.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_autodetach.c
@@ -6,7 +6,7 @@
 
 #define PING_CMD	"ping -q -c1 -w1 127.0.0.1 > /dev/null"
 
-char bpf_log_buf[BPF_LOG_BUF_SIZE];
+static char bpf_log_buf[BPF_LOG_BUF_SIZE];
 
 static int prog_load(void)
 {
diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
index 2ff21dbce179..139f8e82c7c6 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_multi.c
@@ -6,7 +6,7 @@
 
 #define PING_CMD	"ping -q -c1 -w1 127.0.0.1 > /dev/null"
 
-char bpf_log_buf[BPF_LOG_BUF_SIZE];
+static char bpf_log_buf[BPF_LOG_BUF_SIZE];
 
 static int map_fd = -1;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_attach_override.c b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_override.c
index 9d8cb48b99de..9e96f8d87fea 100644
--- a/tools/testing/selftests/bpf/prog_tests/cgroup_attach_override.c
+++ b/tools/testing/selftests/bpf/prog_tests/cgroup_attach_override.c
@@ -8,7 +8,7 @@
 #define BAR		"/foo/bar/"
 #define PING_CMD	"ping -q -c1 -w1 127.0.0.1 > /dev/null"
 
-char bpf_log_buf[BPF_LOG_BUF_SIZE];
+static char bpf_log_buf[BPF_LOG_BUF_SIZE];
 
 static int prog_load(int verdict)
 {
-- 
2.25.1

