Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6CD4430C47
	for <lists+bpf@lfdr.de>; Sun, 17 Oct 2021 23:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344644AbhJQVRT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 17 Oct 2021 17:17:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50695 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344643AbhJQVRS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 17 Oct 2021 17:17:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634505308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4VzWi77FQT/0Gb/rWzZ26Ywd1gYA6zkvj3gNqaGZ5jw=;
        b=WHnlRO+IENdO16S6GuBk4duPL/X9lIldUc5/+AOxyt4QsidiU4IDghdy1HXzCXp78khQd/
        lxdOSGyOubYin8xVYf58djJw++0ouIOfmMvriCys7vvXSPH7rsp4TK4MgyDqFoV8HtQs4A
        CEJEPslGwVyY0eatXfedRfcOAa9fKMk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-I-l2jO1BP-ioxmRyU4-zww-1; Sun, 17 Oct 2021 17:15:05 -0400
X-MC-Unique: I-l2jO1BP-ioxmRyU4-zww-1
Received: by mail-wr1-f69.google.com with SMTP id r25-20020adfab59000000b001609ddd5579so7853155wrc.21
        for <bpf@vger.kernel.org>; Sun, 17 Oct 2021 14:15:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4VzWi77FQT/0Gb/rWzZ26Ywd1gYA6zkvj3gNqaGZ5jw=;
        b=y1kdis6MOxiakE4CAn+AyHMUJLR004qQFl01dqQRyIsobyXRNwsHeN6np48A6CqgoB
         YOJgI17YyTbZOV5LofueUdFaSmmZzO1L4PIEqO2i+a+Kcobfh/1ZA8rlDC2/Qd4S/9MG
         XUBDs/j0RD1pm8WoN6eyUXEqQBq4NjWvRbGRTEiDJ/Q7LfBxBrfR3D611O/dJ+YloFR7
         90lfp2wXBbcYKi0yM583k7CrqFwYHqzyD57PLIJfAldipmuI4hxWnGiQXAfE9DJS9x+e
         XvNBqNhuaZsWMC5RJ5Cm7BrFzLTD1BLCrw6m1sArkvMLJM+L2Qadu1zAJLcWl+JNPiYi
         TX3A==
X-Gm-Message-State: AOAM532P6/jB3nRtqwoUyBnJf8of0884sIpk3sFoFhpMPSI5Rjax/WyO
        EH73g2iJxdglavFu9l3EtWhf4gGDkGnq2n0AI4E2/U6/WyctdeAkRCxP1fy18T0HzaOH2nSM19V
        +a0AoEmZ3jCPJ
X-Received: by 2002:a5d:64ed:: with SMTP id g13mr30883730wri.193.1634505304492;
        Sun, 17 Oct 2021 14:15:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynkdPbLe3xnBsnIKZAqezb81hDHLi4pSZ4wTjDBBXJV/n9svsTwoVCbq2oOd45i+EK4oHrpA==
X-Received: by 2002:a5d:64ed:: with SMTP id g13mr30883716wri.193.1634505304336;
        Sun, 17 Oct 2021 14:15:04 -0700 (PDT)
Received: from krava.cust.in.nbox.cz ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id c185sm10847927wma.8.2021.10.17.14.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 14:15:04 -0700 (PDT)
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
Subject: [PATCH bpf-next 2/3] selftests/bpf: Fix possible/online index mismatch in perf_buffer test
Date:   Sun, 17 Oct 2021 23:14:56 +0200
Message-Id: <20211017211457.343768-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211017211457.343768-1-jolsa@kernel.org>
References: <20211017211457.343768-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The perf_buffer fails on system with offline cpus:

  # test_progs -t perf_buffer
  serial_test_perf_buffer:PASS:nr_cpus 0 nsec
  serial_test_perf_buffer:PASS:nr_on_cpus 0 nsec
  serial_test_perf_buffer:PASS:skel_load 0 nsec
  serial_test_perf_buffer:PASS:attach_kprobe 0 nsec
  serial_test_perf_buffer:PASS:perf_buf__new 0 nsec
  serial_test_perf_buffer:PASS:epoll_fd 0 nsec
  skipping offline CPU #4
  serial_test_perf_buffer:PASS:perf_buffer__poll 0 nsec
  serial_test_perf_buffer:PASS:seen_cpu_cnt 0 nsec
  serial_test_perf_buffer:PASS:buf_cnt 0 nsec
  ...
  serial_test_perf_buffer:PASS:fd_check 0 nsec
  serial_test_perf_buffer:PASS:drain_buf 0 nsec
  serial_test_perf_buffer:PASS:consume_buf 0 nsec
  serial_test_perf_buffer:FAIL:cpu_seen cpu 5 not seen
  #88 perf_buffer:FAIL
  Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED

If the offline cpu is from the middle of the possible set,
we get mismatch with possible and online cpu buffers.

The perf buffer test calls perf_buffer__consume_buffer for
all 'possible' cpus, but the library holds only 'online'
cpu buffers and perf_buffer__consume_buffer returns them
based on index.

Adding extra (online) index to keep track of online buffers,
we need the original (possible) index to trigger trace on
proper cpu.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../testing/selftests/bpf/prog_tests/perf_buffer.c  | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/perf_buffer.c b/tools/testing/selftests/bpf/prog_tests/perf_buffer.c
index 877600392851..0b0cd045979b 100644
--- a/tools/testing/selftests/bpf/prog_tests/perf_buffer.c
+++ b/tools/testing/selftests/bpf/prog_tests/perf_buffer.c
@@ -45,7 +45,7 @@ int trigger_on_cpu(int cpu)
 
 void serial_test_perf_buffer(void)
 {
-	int err, on_len, nr_on_cpus = 0, nr_cpus, i;
+	int err, on_len, nr_on_cpus = 0, nr_cpus, i, j;
 	struct perf_buffer_opts pb_opts = {};
 	struct test_perf_buffer *skel;
 	cpu_set_t cpu_seen;
@@ -111,15 +111,15 @@ void serial_test_perf_buffer(void)
 		  "got %zu, expected %d\n", perf_buffer__buffer_cnt(pb), nr_on_cpus))
 		goto out_close;
 
-	for (i = 0; i < nr_cpus; i++) {
+	for (i = 0, j = 0; i < nr_cpus; i++) {
 		if (i >= on_len || !online[i])
 			continue;
 
-		fd = perf_buffer__buffer_fd(pb, i);
+		fd = perf_buffer__buffer_fd(pb, j);
 		CHECK(fd < 0 || last_fd == fd, "fd_check", "last fd %d == fd %d\n", last_fd, fd);
 		last_fd = fd;
 
-		err = perf_buffer__consume_buffer(pb, i);
+		err = perf_buffer__consume_buffer(pb, j);
 		if (CHECK(err, "drain_buf", "cpu %d, err %d\n", i, err))
 			goto out_close;
 
@@ -127,12 +127,13 @@ void serial_test_perf_buffer(void)
 		if (trigger_on_cpu(i))
 			goto out_close;
 
-		err = perf_buffer__consume_buffer(pb, i);
-		if (CHECK(err, "consume_buf", "cpu %d, err %d\n", i, err))
+		err = perf_buffer__consume_buffer(pb, j);
+		if (CHECK(err, "consume_buf", "cpu %d, err %d\n", j, err))
 			goto out_close;
 
 		if (CHECK(!CPU_ISSET(i, &cpu_seen), "cpu_seen", "cpu %d not seen\n", i))
 			goto out_close;
+		j++;
 	}
 
 out_free_pb:
-- 
2.31.1

