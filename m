Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85E1462653
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2019 18:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbfGHQcX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Jul 2019 12:32:23 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55937 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391205AbfGHQcA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Jul 2019 12:32:00 -0400
Received: by mail-wm1-f67.google.com with SMTP id a15so137172wmj.5
        for <bpf@vger.kernel.org>; Mon, 08 Jul 2019 09:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VlE58to9TTVfrjMnyVImg3zsIB7+2ppqPmsgEMdOy2c=;
        b=Grr8WxQhCPvZ332TotGRFDiZwOd7++mipYJuZveUuYIYr3Nb3dlUDfvUIR/OWbsURt
         7STlhQFB4hrXA2V4zM06BYJrnpA2MU16hbxTHrgFOy3/2hT0pkfqS2p9/NRD3aD8CHMr
         1p4r3q0Cnpr5bPsfSUMGJo3af8t29aw2h5zcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VlE58to9TTVfrjMnyVImg3zsIB7+2ppqPmsgEMdOy2c=;
        b=VoNiVBZ6TZZXbY5gJOI9aGS2xRLcZKOHvM6SfJH13szDJySoHBVumL8mxLZtDlU8Mo
         TtBALYCeEcbGH7JNnel2kVk7I1poylc0f5NAkXqiLOhp4NTgMY9OW3x+UC2zpe92TA3B
         8+CnF17t/diCMKkGy3ceBNMZTMW1d+Zql98mqzvXtgNwwed22Dfqboz68AGwL6Tsqkds
         b7K8ceKiexaUlGc9MoOUAR3q5XhchTjGXwzfL+k6ksaqCYZp8h2DYgMlGW1eu++6/WKa
         WZhoGJTybkwu0iLfCdoKc/QuxXKz8HLjPHLoLXWuoa/K8BMoma1P/WaOpQiPa7pobo20
         HwVg==
X-Gm-Message-State: APjAAAUJxzS2sK8ipu6b3iiChbQRLf22iotwDfmgLCWIqTn27rnfx3Qa
        Ob0nVIub5Zylm4CR+IqDzvW/rw==
X-Google-Smtp-Source: APXvYqwKuFWHwgF4G2XeMIYuCGrmTeqp3ayh9AABUaNBLK83crwPIJSbXnYHsMfKfIGI3EQm869tKA==
X-Received: by 2002:a1c:2015:: with SMTP id g21mr17048889wmg.33.1562603518883;
        Mon, 08 Jul 2019 09:31:58 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aedbe.dynamic.kabel-deutschland.de. [95.90.237.190])
        by smtp.gmail.com with ESMTPSA id e6sm18255086wrw.23.2019.07.08.09.31.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 09:31:58 -0700 (PDT)
From:   Krzesimir Nowak <krzesimir@kinvolk.io>
To:     linux-kernel@vger.kernel.org
Cc:     Alban Crequy <alban@kinvolk.io>,
        =?UTF-8?q?Iago=20L=C3=B3pez=20Galeiras?= <iago@kinvolk.io>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, xdp-newbies@vger.kernel.org,
        Krzesimir Nowak <krzesimir@kinvolk.io>
Subject: [bpf-next v3 10/12] bpf: Implement bpf_prog_test_run for perf event programs
Date:   Mon,  8 Jul 2019 18:31:19 +0200
Message-Id: <20190708163121.18477-11-krzesimir@kinvolk.io>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190708163121.18477-1-krzesimir@kinvolk.io>
References: <20190708163121.18477-1-krzesimir@kinvolk.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

As an input, test run for perf event program takes struct
bpf_perf_event_data as ctx_in and struct bpf_perf_event_value as
data_in. For an output, it basically ignores ctx_out and data_out.

The implementation sets an instance of struct bpf_perf_event_data_kern
in such a way that the BPF program reading data from context will
receive what we passed to the bpf prog test run in ctx_in. Also BPF
program can call bpf_perf_prog_read_value to receive what was passed
in data_in.

Changes since v2:
- drop the changes in perf event verifier test - they are not needed
  anymore after reworked ctx size handling

Signed-off-by: Krzesimir Nowak <krzesimir@kinvolk.io>
---
 kernel/trace/bpf_trace.c | 60 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index ca1255d14576..b870fc2314d0 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -19,6 +19,8 @@
 #include "trace_probe.h"
 #include "trace.h"
 
+#include <trace/events/bpf_test_run.h>
+
 #define bpf_event_rcu_dereference(p)					\
 	rcu_dereference_protected(p, lockdep_is_held(&bpf_event_mutex))
 
@@ -1160,7 +1162,65 @@ const struct bpf_verifier_ops perf_event_verifier_ops = {
 	.convert_ctx_access	= pe_prog_convert_ctx_access,
 };
 
+static int pe_prog_test_run(struct bpf_prog *prog,
+			    const union bpf_attr *kattr,
+			    union bpf_attr __user *uattr)
+{
+	struct bpf_perf_event_data_kern real_ctx = {0, };
+	struct perf_sample_data sample_data = {0, };
+	struct bpf_perf_event_data *fake_ctx;
+	struct bpf_perf_event_value *value;
+	struct perf_event event = {0, };
+	u32 retval = 0, duration = 0;
+	int err;
+
+	if (kattr->test.data_size_out || kattr->test.data_out)
+		return -EINVAL;
+	if (kattr->test.ctx_size_out || kattr->test.ctx_out)
+		return -EINVAL;
+
+	fake_ctx = bpf_receive_ctx(kattr, sizeof(struct bpf_perf_event_data));
+	if (IS_ERR(fake_ctx))
+		return PTR_ERR(fake_ctx);
+
+	value = bpf_receive_data(kattr, sizeof(struct bpf_perf_event_value));
+	if (IS_ERR(value)) {
+		kfree(fake_ctx);
+		return PTR_ERR(value);
+	}
+
+	real_ctx.regs = &fake_ctx->regs;
+	real_ctx.data = &sample_data;
+	real_ctx.event = &event;
+	perf_sample_data_init(&sample_data, fake_ctx->addr,
+			      fake_ctx->sample_period);
+	event.cpu = smp_processor_id();
+	event.oncpu = -1;
+	event.state = PERF_EVENT_STATE_OFF;
+	local64_set(&event.count, value->counter);
+	event.total_time_enabled = value->enabled;
+	event.total_time_running = value->running;
+	/* make self as a leader - it is used only for checking the
+	 * state field
+	 */
+	event.group_leader = &event;
+	err = bpf_test_run(prog, &real_ctx, kattr->test.repeat,
+			   BPF_TEST_RUN_PLAIN, &retval, &duration);
+	if (err) {
+		kfree(value);
+		kfree(fake_ctx);
+		return err;
+	}
+
+	err = bpf_test_finish(uattr, retval, duration);
+	trace_bpf_test_finish(&err);
+	kfree(value);
+	kfree(fake_ctx);
+	return err;
+}
+
 const struct bpf_prog_ops perf_event_prog_ops = {
+	.test_run	= pe_prog_test_run,
 };
 
 static DEFINE_MUTEX(bpf_event_mutex);
-- 
2.20.1

