Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33FDA430C49
	for <lists+bpf@lfdr.de>; Sun, 17 Oct 2021 23:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344643AbhJQVRX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 17 Oct 2021 17:17:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56450 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232561AbhJQVRX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 17 Oct 2021 17:17:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634505312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=srAxXppIvHz+myMAl+rb3OMXLAjwG2sT2dL0Sifr8SY=;
        b=bN5SSSssFaoaLgOmQRU/VrHfBvwpKHnQ1CDH0WlcA7gFRGi/v/21DWDU84kYsh9770bAs3
        H05dcILiXc2Kz/9v7ZpK6FQeOWuPDsLi6ky30r9yVyhiwcUgUkjCrLrUKUMr+FmZcUWxwN
        nVXeIX0YHkND2ZRRqD1nG5HyIAt1P3Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-6IfnMLzOP9GJda4LAsMLkg-1; Sun, 17 Oct 2021 17:15:11 -0400
X-MC-Unique: 6IfnMLzOP9GJda4LAsMLkg-1
Received: by mail-wr1-f72.google.com with SMTP id r16-20020adfb1d0000000b00160bf8972ceso7889309wra.13
        for <bpf@vger.kernel.org>; Sun, 17 Oct 2021 14:15:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=srAxXppIvHz+myMAl+rb3OMXLAjwG2sT2dL0Sifr8SY=;
        b=uI/Z/npeCMYj5nrN2CvAiYGISX6th0aK4gAK6kiRv2VkjBhlpJLrxRvj853LJ9VQQP
         7IO7krBTk0ADguMGPF1L0CnjKMe9kTaENKkKpF27QkmAte6/KqiBbAgl8Dz7a0hsUETy
         O7xdMXMYzDhGVTTqfKLe8NQtf2VzB6mpiCR7M/3cwuvQvGpUVilIzynCrOZzlBEYy/Od
         MyOPoraWdGWoZpZ+DqizQPz252pOeIJzfPGYaEM0JPiuindD2+mKAgWjHrTq0XAmYWRY
         OFL9jfqxCgxIwveHaa8uJf7h07DtcW5h8Q9/XZehbnZOoxRWZTQ1T+HN8yh5SH7lgq3s
         +efg==
X-Gm-Message-State: AOAM530RomRIEQFLue/j7np1XUYgtMYars1MwBO9ZJpcZUQeKlNFjain
        ZhwisvtSHwPryzI8v2V7DaIrLmYZWKEoHpOofQM3fJdERc+mN9R6XaA8GEPaF7lwCtRbAsiT7jz
        vbr7dShpb+6Wu
X-Received: by 2002:a5d:4563:: with SMTP id a3mr30702554wrc.198.1634505310422;
        Sun, 17 Oct 2021 14:15:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8GDujnnlYrDZ6vz0cWuCOjpMhoco6bgO3eFsSttDzPYk0xUFvblndr4yRkPOE120t1DCMtQ==
X-Received: by 2002:a5d:4563:: with SMTP id a3mr30702543wrc.198.1634505310287;
        Sun, 17 Oct 2021 14:15:10 -0700 (PDT)
Received: from krava.cust.in.nbox.cz ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id c132sm16905985wma.22.2021.10.17.14.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 14:15:10 -0700 (PDT)
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
Subject: [PATCH bpf-next 3/3] selftests/bpf: Use nanosleep tracepoint in perf buffer test
Date:   Sun, 17 Oct 2021 23:14:57 +0200
Message-Id: <20211017211457.343768-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211017211457.343768-1-jolsa@kernel.org>
References: <20211017211457.343768-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The perf buffer tests triggers trace with nanosleep syscall,
but monitors all syscalls, which results in lot of data in the
buffer and makes it harder to debug. Let's lower the trace
traffic and monitor just nanosleep syscall.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/progs/test_perf_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/test_perf_buffer.c b/tools/testing/selftests/bpf/progs/test_perf_buffer.c
index d37ce29fd393..a08874c5bdf2 100644
--- a/tools/testing/selftests/bpf/progs/test_perf_buffer.c
+++ b/tools/testing/selftests/bpf/progs/test_perf_buffer.c
@@ -12,7 +12,7 @@ struct {
 	__type(value, int);
 } perf_buf_map SEC(".maps");
 
-SEC("tp/raw_syscalls/sys_enter")
+SEC("tp/syscalls/sys_enter_nanosleep")
 int handle_sys_enter(void *ctx)
 {
 	int cpu = bpf_get_smp_processor_id();
-- 
2.31.1

