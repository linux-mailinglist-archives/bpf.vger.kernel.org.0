Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6B225C859
	for <lists+bpf@lfdr.de>; Thu,  3 Sep 2020 20:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbgICSBm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Sep 2020 14:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgICSBl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Sep 2020 14:01:41 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44371C061244
        for <bpf@vger.kernel.org>; Thu,  3 Sep 2020 11:01:41 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id c78so3622378ybf.6
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2020 11:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=Kysrwv2vyroocCwa+tcRYatIjOGKit3xRO3evVtQFbc=;
        b=Cq3p3J6MuBLmXs4+BsJhTAo9WFB6do5dQd5DtPvLivFpB+4Ju12w4vUq6lbWXAzjlm
         TbcW3W73CMNquCeiwEyKd9wULH55FwWxBcJpvqcNQcSVJIerstXZYAml83qKstkbK1SU
         okUjrP6TZJ46ow8QUFxy4cJEvShbzmqd/tMJGhc/ubslAQw5E5fKNSN+mDR7fcIMvWkl
         T5OyxJjCB5mabyFXVA/Kv+8UqCZMU/3HwpGbWxy6Qw6coOJcnVywx1qpwbmB4Rg2DxxW
         vRrg6aEM7P7/YB4eK0LrHrEquLEDOltwMIB5NacuCaNG7muP/MqjrNPvcOSChtXfdvOR
         opNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=Kysrwv2vyroocCwa+tcRYatIjOGKit3xRO3evVtQFbc=;
        b=WxP6gLOkpP5yydAD+uKYgqU/alKVyRLETF52l2fIGPe1ZP5SgReJGhnsJyZa0MMWPB
         wXWUXaHLKgJ7qYizLVP/8kllxGSsMpInjSK1/4L5dRLAiwfF+gNN7bydQfWNUQOyXzdB
         EqlkJ3VyYo5MFcpnJM0E4GWKfoz/WTORO/qrF8JjswVKvL/lWu8tcNMQdkQEo0A5DRt6
         WEpDy4YVW3zh2G8H5rmENnSbTeQvFKH+hDWXRxoRzB1CVr7hO588yLh5/ED0Ue5qLON8
         W8iL67oQh7f5p02GZoQwRmWMA5uD7dav4XLccshVCxfrs353oUwHuiEw1/rCM4sMPM+a
         GEOA==
X-Gm-Message-State: AOAM533pbD8tnJRaCo4wDDeveX2G+kdAVMVJChBhKfqWct8UC52BS2RU
        1ij4/r9zLz/NMLiIERt8LPm+9K3U0tw=
X-Google-Smtp-Source: ABdhPJznIT58g0Z8TdpOroAqfZSJEPyQbKcKvYMhot5h+i6tLXl0hXMlUC/qJtrEQeftD65KiOHntPOzGCQ=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:f693:9fff:fef4:e444])
 (user=haoluo job=sendgmr) by 2002:a25:70c6:: with SMTP id l189mr4414948ybc.263.1599156100416;
 Thu, 03 Sep 2020 11:01:40 -0700 (PDT)
Date:   Thu,  3 Sep 2020 11:01:21 -0700
Message-Id: <20200903180121.662887-1-haoluo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [PATCH] selftests/bpf: Fix check in global_data_init.
From:   Hao Luo <haoluo@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        "=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>,
        KP Singh <kpsingh@chromium.org>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The returned value of bpf_object__open_file() should be checked with
IS_ERR() rather than NULL. This fix makes test_progs not crash when
test_global_data.o is not present.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 tools/testing/selftests/bpf/prog_tests/global_data_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/global_data_init.c b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
index 3bdaa5a40744..1ece86d5c519 100644
--- a/tools/testing/selftests/bpf/prog_tests/global_data_init.c
+++ b/tools/testing/selftests/bpf/prog_tests/global_data_init.c
@@ -12,7 +12,7 @@ void test_global_data_init(void)
 	size_t sz;
 
 	obj = bpf_object__open_file(file, NULL);
-	if (CHECK_FAIL(!obj))
+	if (CHECK_FAIL(IS_ERR(obj)))
 		return;
 
 	map = bpf_object__find_map_by_name(obj, "test_glo.rodata");
-- 
2.28.0.402.g5ffc5be6b7-goog

