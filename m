Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D116A4AA3C5
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 23:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359413AbiBDW6c (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 17:58:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41560 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1377743AbiBDW62 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Feb 2022 17:58:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644015507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mbIIMwTtHOK23EwwQeYMceH1azwmVKWfuX9oObuKyeQ=;
        b=VHDgkptulo/cGYPfID8D2UMrlrYZG9O2zGNfyMRj3ujoZ754gughxyG6p3I3n6UVCegA3D
        FYEDUr19Dt16a9gqvbFIv573VOkl+3R5A0oQnXabhYFawNUpWDRFDs1Mt8a4UoTlpzdx0K
        cuRQmb2JS175qGMjx8ihEY/1DtJ46Ms=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-482-9ACKAKIIOvKjm_zUYGTgoA-1; Fri, 04 Feb 2022 17:58:26 -0500
X-MC-Unique: 9ACKAKIIOvKjm_zUYGTgoA-1
Received: by mail-ed1-f71.google.com with SMTP id o25-20020a056402039900b0040631c2a67dso3944237edv.19
        for <bpf@vger.kernel.org>; Fri, 04 Feb 2022 14:58:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mbIIMwTtHOK23EwwQeYMceH1azwmVKWfuX9oObuKyeQ=;
        b=lxq3vZZOiy1IyrkraF6Pw6ew6HneJexdn2VvtHuzlVj6T2L77kcP0u69cpcQcUXSr1
         kv5YZlb84SP2s02x47BRXqmXNISeHFpnr+HV8WnWku93I4cZMz1cL+HOxhJ8n1XCXyNq
         ktJCDqYP/r+zcRZYJ5sKEXgjLzkWvVOH1ub7IkSf5RrZZ3whOZ9Hkz/pdDLwz82x6iVW
         sV4q7E+t1kGvycFQqEex1eQ0jeO6Wk3zpSLk50dWzZqAr0B6YfG+rTXPyCuC5zK/68P5
         ynBBgEq2PH3YztWwOvpHylV03+mv7DM/M4h3gQoSL95JjyZWCBUk6qAarnIZcbfY0aeg
         OXWw==
X-Gm-Message-State: AOAM530hN2PCzQgeJ/1hiGEr1CLNHv89VKOnRXBdhQehyBWwJQpgiywC
        Ym+jCqbV+CC/dqW3wCpk/e1H7qYpeUlatKxrDBncn9KaqGU1m/4oZDYL1z9hJkAupjz7HPPGhcR
        /QzR/u60EztKE
X-Received: by 2002:a05:6402:51cd:: with SMTP id r13mr1484385edd.381.1644015505106;
        Fri, 04 Feb 2022 14:58:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw6tau51Apvgacqbwdn4SWF8Jr0PsmIu6xyu/W/a+95B28zPUpQ9oEEbT8VgbdxwucI7AZomQ==
X-Received: by 2002:a05:6402:51cd:: with SMTP id r13mr1484378edd.381.1644015504962;
        Fri, 04 Feb 2022 14:58:24 -0800 (PST)
Received: from krava.redhat.com ([83.240.63.12])
        by smtp.gmail.com with ESMTPSA id u1sm1064907ejj.215.2022.02.04.14.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 14:58:24 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Pirko <jiri@mellanox.com>
Subject: [PATCH bpf-next 1/3] libbpf: Add names for auxiliary maps
Date:   Fri,  4 Feb 2022 23:58:21 +0100
Message-Id: <20220204225823.339548-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding names for maps that bpftool uses for various detections.
These maps can appear in final map show output (due to deferred
removal in kernel) so some tests (like test_offload.py) needs
to filter them out.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/libbpf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 904cdf83002b..38294ce935d6 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4412,7 +4412,7 @@ static int probe_kern_global_data(void)
 	};
 	int ret, map, insn_cnt = ARRAY_SIZE(insns);
 
-	map = bpf_map_create(BPF_MAP_TYPE_ARRAY, NULL, sizeof(int), 32, 1, NULL);
+	map = bpf_map_create(BPF_MAP_TYPE_ARRAY, "global_data", sizeof(int), 32, 1, NULL);
 	if (map < 0) {
 		ret = -errno;
 		cp = libbpf_strerror_r(ret, errmsg, sizeof(errmsg));
@@ -4545,7 +4545,7 @@ static int probe_kern_array_mmap(void)
 	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = BPF_F_MMAPABLE);
 	int fd;
 
-	fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, NULL, sizeof(int), sizeof(int), 1, &opts);
+	fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, "array_mmap", sizeof(int), sizeof(int), 1, &opts);
 	return probe_fd(fd);
 }
 
@@ -4592,7 +4592,7 @@ static int probe_prog_bind_map(void)
 	};
 	int ret, map, prog, insn_cnt = ARRAY_SIZE(insns);
 
-	map = bpf_map_create(BPF_MAP_TYPE_ARRAY, NULL, sizeof(int), 32, 1, NULL);
+	map = bpf_map_create(BPF_MAP_TYPE_ARRAY, "bind_map_detect", sizeof(int), 32, 1, NULL);
 	if (map < 0) {
 		ret = -errno;
 		cp = libbpf_strerror_r(ret, errmsg, sizeof(errmsg));
-- 
2.34.1

