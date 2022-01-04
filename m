Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D2A484185
	for <lists+bpf@lfdr.de>; Tue,  4 Jan 2022 13:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbiADMKe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Jan 2022 07:10:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:24253 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232904AbiADMKe (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 4 Jan 2022 07:10:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641298233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=e23GvwFEUXHbUBSCX1HU3wptIv1SCmph2aHQnK4TxcA=;
        b=LbxljXck+0TuwPMqRzBKVxd2zyjYzhj9ceGyeTeZRk+2Em62BcBx7CRYpU96fQmQH2lGZx
        8OYVEpj9zIlBSY9989USTCGf05XqnngYihjYCQken4EfYnN4/vlRCyEPT7X0xzsJ9/1W2R
        M+RWWMz0284eG0Eu3oeYwMNEpBsCuCI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-97sx4oEANCW2Mg3wCiAy_A-1; Tue, 04 Jan 2022 07:10:32 -0500
X-MC-Unique: 97sx4oEANCW2Mg3wCiAy_A-1
Received: by mail-wm1-f70.google.com with SMTP id 187-20020a1c02c4000000b003335872db8dso9373585wmc.2
        for <bpf@vger.kernel.org>; Tue, 04 Jan 2022 04:10:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e23GvwFEUXHbUBSCX1HU3wptIv1SCmph2aHQnK4TxcA=;
        b=yohaKGOgVR6yz27sQ7cR2wxcYQRYJrobDn8vHMvjlwhdX4OJxMlQyoCzNPPZF0FJw6
         veFIBxzvzsTIMtIXvia0I2508wZStCWpcRzYD0xV0oOTQHS0MPUwLmEcQzC9lL8rwCgG
         PDWLMix3MTIaZNisJ598M92bOObdZ0TIdBcQXdZ8yjAhQoR4jA+g9tf1mi5004k9aZ7R
         RRAXo4XZ4UAdnPuhkOQ62RZ4zVlOsBYTDQr0uThAmf7f9U3nonKyysJl4YtsaE3tB64T
         uNa/R7d6s8yAayulGOcLav9dmmdqOj9XF5ybeOtKyP+anUhUXLhSHCA+Ci0oZ8ErFiXE
         8qkQ==
X-Gm-Message-State: AOAM531i22CBDn5FjRDlJqVSNfqixg7lBBdLqYhcfNUcBvvs/f26T2VU
        6sfSsKeN30PLz98VSk5oqGxLPx+CfvX7c3RSzC9uhlvhTt9euWsM2Fmls3bof5ZK/4oU71u44wD
        zjK+AmOsu0Dl8
X-Received: by 2002:a05:600c:3657:: with SMTP id y23mr42035059wmq.160.1641298231346;
        Tue, 04 Jan 2022 04:10:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzoMiXH8X2tDQsRX9319UAmIiBDBaixOkpfg3ScIJMlw9L8taNLaIkYq9NCFQt4cVSN5EKCcQ==
X-Received: by 2002:a05:600c:3657:: with SMTP id y23mr42035045wmq.160.1641298231147;
        Tue, 04 Jan 2022 04:10:31 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id b19sm42835575wmb.38.2022.01.04.04.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 04:10:30 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Jussi Maki <joamaki@gmail.com>, Hangbin Liu <haliu@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: [PATCH] bpf/selftests: Fix namespace mount setup in tc_redirect
Date:   Tue,  4 Jan 2022 13:10:30 +0100
Message-Id: <20220104121030.138216-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The tc_redirect umounts /sys in the new namespace, which can be
mounted as shared and cause global umount. The lazy umount also
takes down mounted trees under /sys like debugfs, which won't be
available after sysfs mounts again and could cause fails in other
tests.

  # cat /proc/self/mountinfo | grep debugfs
  34 23 0:7 / /sys/kernel/debug rw,nosuid,nodev,noexec,relatime shared:14 - debugfs debugfs rw
  # cat /proc/self/mountinfo | grep sysfs
  23 86 0:22 / /sys rw,nosuid,nodev,noexec,relatime shared:2 - sysfs sysfs rw
  # mount | grep debugfs
  debugfs on /sys/kernel/debug type debugfs (rw,nosuid,nodev,noexec,relatime)

  # ./test_progs -t tc_redirect
  #164 tc_redirect:OK
  Summary: 1/4 PASSED, 0 SKIPPED, 0 FAILED

  # mount | grep debugfs
  # cat /proc/self/mountinfo | grep debugfs
  # cat /proc/self/mountinfo | grep sysfs
  25 86 0:22 / /sys rw,relatime shared:2 - sysfs sysfs rw

Making the sysfs private under the new namespace so the umount won't
trigger the global sysfs umount.

Cc: Jussi Maki <joamaki@gmail.com>
Reported-by: Hangbin Liu <haliu@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/tc_redirect.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
index 4b18b73df10b..c2426df58e17 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
@@ -105,6 +105,13 @@ static int setns_by_fd(int nsfd)
 	if (!ASSERT_OK(err, "unshare"))
 		return err;
 
+	/* Make our /sys mount private, so the following umount won't
+	 * trigger the global umount in case it's shared.
+	 */
+	err = mount("none", "/sys", NULL, MS_PRIVATE, NULL);
+	if (!ASSERT_OK(err, "remount private /sys"))
+		return err;
+
 	err = umount2("/sys", MNT_DETACH);
 	if (!ASSERT_OK(err, "umount2 /sys"))
 		return err;
-- 
2.33.1

