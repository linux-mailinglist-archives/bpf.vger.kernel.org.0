Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C4447E403
	for <lists+bpf@lfdr.de>; Thu, 23 Dec 2021 14:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348615AbhLWNRr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Dec 2021 08:17:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42109 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348613AbhLWNRr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 23 Dec 2021 08:17:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640265466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vNaSb3OMoRE9wcAdQ3zOWspvi+wy5zT/zyfsdS3SflI=;
        b=C5hna6SnlQROrCAH+UjgS+1N0/Xvls8jSR0K79G+sCBwNbAZCiQc3qttHHViGdemXtCxxD
        +T5ekAEom/mCovcS9j8agKM1JkmdgEMZNXBCAHzcwZF1Rdn3UX4HThTwQMMRz8hwrgqQDP
        pm0dwVh9oaVo1M5F+3vneUjg02CWKu0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-550-KVORy1S_P4yLptkPIPXebg-1; Thu, 23 Dec 2021 08:17:45 -0500
X-MC-Unique: KVORy1S_P4yLptkPIPXebg-1
Received: by mail-ed1-f70.google.com with SMTP id l14-20020aa7cace000000b003f7f8e1cbbdso4460457edt.20
        for <bpf@vger.kernel.org>; Thu, 23 Dec 2021 05:17:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vNaSb3OMoRE9wcAdQ3zOWspvi+wy5zT/zyfsdS3SflI=;
        b=fJJCAjUoKryqRfZuM8ueGVQ3HzNixVwQ2e6W1G8rag8K1R2MwMFhOq/NLw3TPfJ5s7
         kRmsIp/SEW4OQ+OvTb824epASxGiSAmcckoifgLQaxA/Y85JkneFfEm2zUYF2tdwI8CX
         q6W+egswX7GkWk6imCVYkWkCs+NurApGvouzgPHgvK7jc7vdbMzXVIWrhT3bvRPOBwwe
         jzsU3NXYu15m/gMFFeMRli5mAMS9KNrFNxZ9NEEKnu56p/tvl1Op6ubeSzLYgY4NafPY
         ZGrA0BE3JtZ0bvLxTJaQoqUD9Z0qny+6RpHewuoF82m1uWDethKYU1jzORsGzkTa3Kjt
         QtjQ==
X-Gm-Message-State: AOAM530MZQF86R9SJ4X7MVpfetV/oDWoco69eIByCQOfxMcxLqx1TF9u
        RfFmPxns07rBvnEQsAlpokkePfLIEoG4VdncWo7y7yI0047g8QMzmy0VUI/w5QthKPGjry7Driz
        swYwkyAworaQu
X-Received: by 2002:a17:906:b18c:: with SMTP id w12mr1840143ejy.645.1640265464176;
        Thu, 23 Dec 2021 05:17:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwC8968YE5ZR7LaPJnT75CxVmirtTVTSYzqV7G4OHSGq9VKb4UBEdVcbZQ/RxmUk787d2O6lw==
X-Received: by 2002:a17:906:b18c:: with SMTP id w12mr1840136ejy.645.1640265464048;
        Thu, 23 Dec 2021 05:17:44 -0800 (PST)
Received: from krava.redhat.com ([83.240.60.218])
        by smtp.gmail.com with ESMTPSA id 6sm1743743ejj.164.2021.12.23.05.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 05:17:43 -0800 (PST)
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
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add btf_dump__new to test_cpp
Date:   Thu, 23 Dec 2021 14:17:36 +0100
Message-Id: <20211223131736.483956-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211223131736.483956-1-jolsa@kernel.org>
References: <20211223131736.483956-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding btf_dump__new call to test_cpp, so we can
test C++ compilation with that.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/test_cpp.cpp | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_cpp.cpp b/tools/testing/selftests/bpf/test_cpp.cpp
index a8d2e9a87fbf..e00201de2890 100644
--- a/tools/testing/selftests/bpf/test_cpp.cpp
+++ b/tools/testing/selftests/bpf/test_cpp.cpp
@@ -7,9 +7,15 @@
 
 /* do nothing, just make sure we can link successfully */
 
+static void dump_printf(void *ctx, const char *fmt, va_list args)
+{
+}
+
 int main(int argc, char *argv[])
 {
+	struct btf_dump_opts opts = { };
 	struct test_core_extern *skel;
+	struct btf *btf;
 
 	/* libbpf.h */
 	libbpf_set_print(NULL);
@@ -18,7 +24,8 @@ int main(int argc, char *argv[])
 	bpf_prog_get_fd_by_id(0);
 
 	/* btf.h */
-	btf__new(NULL, 0);
+	btf = btf__new(NULL, 0);
+	btf_dump__new(btf, dump_printf, nullptr, &opts);
 
 	/* BPF skeleton */
 	skel = test_core_extern__open_and_load();
-- 
2.33.1

