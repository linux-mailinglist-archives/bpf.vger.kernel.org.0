Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7CE430C45
	for <lists+bpf@lfdr.de>; Sun, 17 Oct 2021 23:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344633AbhJQVRM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 17 Oct 2021 17:17:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41659 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344623AbhJQVRL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 17 Oct 2021 17:17:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634505301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=FRy9bwvZsJvWv4Af9Z5HsgohV/baKvxzAPxWjKJBPXI=;
        b=VUe63/6vBW4yKCithghUgvx5UIq5r/bbkkfFd9eC9yF/IOTDtswzGQR0ygKLGCud3lHD/L
        nW8WazoFqpt8SN0JMHwas87KAMqaATV5RmNf6MU34Z1+YQYdQiy1eIPt2o3ztFaAP+65MT
        baFEKAEh/iNjBU3lXIbBJC8R85pgbqg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-Ue27udSBOuqM5W_bNi-4QA-1; Sun, 17 Oct 2021 17:14:59 -0400
X-MC-Unique: Ue27udSBOuqM5W_bNi-4QA-1
Received: by mail-wr1-f71.google.com with SMTP id r21-20020adfa155000000b001608162e16dso7853869wrr.15
        for <bpf@vger.kernel.org>; Sun, 17 Oct 2021 14:14:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FRy9bwvZsJvWv4Af9Z5HsgohV/baKvxzAPxWjKJBPXI=;
        b=5dcFXF1OPkfOozVDZL/OCyhY6LkezJOFxAiLUnVTkzI3LJICysc5KOGyJXXFkP5ww8
         RfO8gQjkXpk6JuN1mMQaXcQNLDq7r6GRMnOMzQkHDEJfA5DcjNv2GyiaztoWh5aQAqWe
         V3tErKPS5HO4+YQyqzxeDF1T6OeIfxwBNTOqXQMFulsig1UGDRSMpigqM2lkdEvrqPNY
         uCGgVta0QCM9JcLYRJnUTa+D93dAwbPjrVLYXD6gOWjTHUBwyPYDq9yk4PbxIJz8+2YZ
         49xqpO+YczRF2lZrpVvNF9cS7HvOTwAiwt013plaJoT9QRfggeCJttDylBpv6L+zE5Pw
         epDA==
X-Gm-Message-State: AOAM531pUPNvGPo438o/K3xuJPVd20XTgqcij3JeXnsAXFw60W8zTyCr
        wZLYjnRo46Mu8shj5tJBNX8SN8qhG1TjxvrQBwsGJP+mpx69XprWb7lnJHN2WEwwr7i9oN2VdDR
        wIph4vNVadgs0
X-Received: by 2002:adf:9791:: with SMTP id s17mr30276204wrb.122.1634505298404;
        Sun, 17 Oct 2021 14:14:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0JZXfKOigWsN3W5rdhjJNq/c+D3QKjRn7R5w5HK6ebUis5XeuRhpaedp/NVgzsSOO7QhOfQ==
X-Received: by 2002:adf:9791:: with SMTP id s17mr30276191wrb.122.1634505298233;
        Sun, 17 Oct 2021 14:14:58 -0700 (PDT)
Received: from krava.cust.in.nbox.cz ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id t11sm10788829wrz.65.2021.10.17.14.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 14:14:57 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: [PATCH bpf-next 1/3] selftests/bpf: Fix perf_buffer test on system with offline cpus
Date:   Sun, 17 Oct 2021 23:14:55 +0200
Message-Id: <20211017211457.343768-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The perf_buffer fails on system with offline cpus:

  # test_progs -t perf_buffer
  test_perf_buffer:PASS:nr_cpus 0 nsec
  test_perf_buffer:PASS:nr_on_cpus 0 nsec
  test_perf_buffer:PASS:skel_load 0 nsec
  test_perf_buffer:PASS:attach_kprobe 0 nsec
  test_perf_buffer:PASS:perf_buf__new 0 nsec
  test_perf_buffer:PASS:epoll_fd 0 nsec
  skipping offline CPU #24
  skipping offline CPU #25
  skipping offline CPU #26
  skipping offline CPU #27
  skipping offline CPU #28
  skipping offline CPU #29
  skipping offline CPU #30
  skipping offline CPU #31
  test_perf_buffer:PASS:perf_buffer__poll 0 nsec
  test_perf_buffer:PASS:seen_cpu_cnt 0 nsec
  test_perf_buffer:FAIL:buf_cnt got 24, expected 32
  Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED

Changing the test to check online cpus instead of possible.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/perf_buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/perf_buffer.c b/tools/testing/selftests/bpf/prog_tests/perf_buffer.c
index 6979aff4aab2..877600392851 100644
--- a/tools/testing/selftests/bpf/prog_tests/perf_buffer.c
+++ b/tools/testing/selftests/bpf/prog_tests/perf_buffer.c
@@ -107,8 +107,8 @@ void serial_test_perf_buffer(void)
 		  "expect %d, seen %d\n", nr_on_cpus, CPU_COUNT(&cpu_seen)))
 		goto out_free_pb;
 
-	if (CHECK(perf_buffer__buffer_cnt(pb) != nr_cpus, "buf_cnt",
-		  "got %zu, expected %d\n", perf_buffer__buffer_cnt(pb), nr_cpus))
+	if (CHECK(perf_buffer__buffer_cnt(pb) != nr_on_cpus, "buf_cnt",
+		  "got %zu, expected %d\n", perf_buffer__buffer_cnt(pb), nr_on_cpus))
 		goto out_close;
 
 	for (i = 0; i < nr_cpus; i++) {
-- 
2.31.1

