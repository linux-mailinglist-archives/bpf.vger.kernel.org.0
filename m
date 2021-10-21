Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0637E436070
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 13:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhJULn6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Oct 2021 07:43:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29415 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229765AbhJULn5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 21 Oct 2021 07:43:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634816501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FRy9bwvZsJvWv4Af9Z5HsgohV/baKvxzAPxWjKJBPXI=;
        b=FClAsCVq3+KP/HYXDxgBYKpwhEOQfv6qwRZza/q2LenDk/xc/tAjHzgJb0LPpleUwy/OoQ
        DFnUTPFSvJEXxFOIeKOKz+P3d6746s0Cy3ljD5zYiu7FqU2PdWiOtaqHbsf2aZiSSL7pwr
        zFu6yIzHdYDF9M6qADYf9pON0sX4Wak=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190--iGnoXjpPGaGbnDfVuQuMA-1; Thu, 21 Oct 2021 07:41:40 -0400
X-MC-Unique: -iGnoXjpPGaGbnDfVuQuMA-1
Received: by mail-ed1-f69.google.com with SMTP id p20-20020a50cd94000000b003db23619472so24099096edi.19
        for <bpf@vger.kernel.org>; Thu, 21 Oct 2021 04:41:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FRy9bwvZsJvWv4Af9Z5HsgohV/baKvxzAPxWjKJBPXI=;
        b=vYcuf9ZofuRygcILXJiYQGi1LIHOvhAo9BTWE87CKcivG357SuYqHn0w3OMs7AprfR
         vrNvd5q5l80gTgFVg6+Y1/bt1fXQwm1LHQfe99h0H3v6k5HU3aUpQ+/NpC03L/52lRLz
         2WbdML2M7msWbgjEs/EAeJavC6KBrxjTVsAAhl7ejQ3eBpN5UHMO9+EDvzmLP0giGHyS
         /p+926LndyZ7HrJ8w5PvB3BFkqzKYB6uswV3sjIp1Z+dGz8bJflGk9/sJDGTyijdoUa0
         Q4jCXKl2bs9x7WPUpKsZTqMlFdjykOZNjm0I+qrxS/hs+OKPjO/Sv1WndyQXxaIb8Owa
         XbWw==
X-Gm-Message-State: AOAM532WVBugoH02S12gSJpeGnBhlWktvozXLyKeZWVB4flNJIb1kW+V
        1n1wOFRsFRUQ+fAq9VJiyXq28Fu1DGiFz9n8r9X9J7Uln/rmgRc2EC62CZixjLhLjqNoomDQ9XB
        oz6Rfk4XMuZJO
X-Received: by 2002:a17:906:c20e:: with SMTP id d14mr6766034ejz.207.1634816499342;
        Thu, 21 Oct 2021 04:41:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCiK8vnQe735HJG2AsvUb8pzqXp9/UxXfuLbE+ngwtWOz6xlrSMSW1U8CS+XtEkWHYTx0ssg==
X-Received: by 2002:a17:906:c20e:: with SMTP id d14mr6766007ejz.207.1634816499159;
        Thu, 21 Oct 2021 04:41:39 -0700 (PDT)
Received: from krava.cust.in.nbox.cz ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id j3sm2373941ejy.65.2021.10.21.04.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 04:41:38 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: [PATCH bpf-next 1/3] selftests/bpf: Fix perf_buffer test on system with offline cpus
Date:   Thu, 21 Oct 2021 13:41:30 +0200
Message-Id: <20211021114132.8196-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211021114132.8196-1-jolsa@kernel.org>
References: <20211021114132.8196-1-jolsa@kernel.org>
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

