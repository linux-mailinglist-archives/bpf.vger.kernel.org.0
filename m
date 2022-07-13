Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FAF57351B
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 13:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236190AbiGMLPL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jul 2022 07:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236012AbiGMLO5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jul 2022 07:14:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC227100CE4
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 04:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657710885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ef9GXgQuBeTFQaGFOOxbyhfbiGrCHyDokmB4U/+rt5g=;
        b=YikGjR1OYF+luf+qMT6dw0/qaVTR58go7BahLEEfDGldCeCngBm9WEDQpaYj+F7SVMj5CM
        /fEfzO1KQmw6IxZ9aDG4MOw53e04rYa2fzdnhp+T7XFOpz4OlBmzuWZbX8i1EaHnR62Cbi
        lEfFV0ktSEvk5hNgC/FVOAkN89g594w=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-92-svCp4cqHMv20_UsWOYJ2-w-1; Wed, 13 Jul 2022 07:14:44 -0400
X-MC-Unique: svCp4cqHMv20_UsWOYJ2-w-1
Received: by mail-ed1-f72.google.com with SMTP id x21-20020a05640226d500b0043abb7ac086so8135041edd.14
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 04:14:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ef9GXgQuBeTFQaGFOOxbyhfbiGrCHyDokmB4U/+rt5g=;
        b=qAU9ntqfvcKCyjxgQ8kodF921ZnXcCpBSCYtg6cZT22o6YBjc/Z/+xK53CO3nADBsw
         SNjkWhWEpr9xEUvT0hJ3G+A8t2qNs4N3d+NuWVMQFV9gq+jVzsUuq9HPG7ceMCYvV3A5
         7qmqKI9YDsALJ9iyM5FD8OI3mbSov5Cvrz+b+xHjDfmfaXnRKMUJSpWs2KBZsX/HxPG7
         47UrO5vvQ4ZUy2E5/CXkZPpwwRi2s8JNUVi5qGuwonbBBTjHRhpSVOH/XGeyNNDYE/Pz
         ekhzJ5+vku12XzVFpjf/1aPoahgvK9AaOpSawIj0dGMxtkggseb5lC5JQBtEdVLjnvyY
         KM7w==
X-Gm-Message-State: AJIora9dC218azpS65bKCZPoCBAAq6B4eqAzgbFBQ0MkUoNtHyXv39ns
        Arua9Ti0F1KJ79vq465X+/wHUwStSRFHFnKcHXxQ9yrwMGSGLBTclQXfpwSICvteQIfC4LJaP9p
        QqQMFHrZQMmWQ
X-Received: by 2002:a17:907:3f04:b0:6e8:4b0e:438d with SMTP id hq4-20020a1709073f0400b006e84b0e438dmr2910878ejc.391.1657710883349;
        Wed, 13 Jul 2022 04:14:43 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u/+Z9t8vIbQv0pG9ukm9WXsOBRvLEg5K6MZXKEs01Vcfh3GIy0UlwIw32bqf1J7qA2+eRI/Q==
X-Received: by 2002:a17:907:3f04:b0:6e8:4b0e:438d with SMTP id hq4-20020a1709073f0400b006e84b0e438dmr2910845ejc.391.1657710883090;
        Wed, 13 Jul 2022 04:14:43 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id k19-20020a05640212d300b0043a8f5ad272sm7781074edx.49.2022.07.13.04.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 04:14:42 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 603734D9916; Wed, 13 Jul 2022 13:14:39 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        Freysteinn Alfredsson <freysteinn.alfredsson@kau.se>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [RFC PATCH 13/17] libbpf: Add support for dequeue program type and PIFO map type
Date:   Wed, 13 Jul 2022 13:14:21 +0200
Message-Id: <20220713111430.134810-14-toke@redhat.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220713111430.134810-1-toke@redhat.com>
References: <20220713111430.134810-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add support for a 'dequeue' section type to specify dequeue type programs
and add support for dequeue program and PIFO map to probing code.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/lib/bpf/libbpf.c        | 1 +
 tools/lib/bpf/libbpf_probes.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index cb49408eb298..8553bb8369e0 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8431,6 +8431,7 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("xdp/cpumap",		XDP, BPF_XDP_CPUMAP, SEC_ATTACHABLE),
 	SEC_DEF("xdp.frags",		XDP, BPF_XDP, SEC_XDP_FRAGS),
 	SEC_DEF("xdp",			XDP, BPF_XDP, SEC_ATTACHABLE_OPT),
+	SEC_DEF("dequeue",		DEQUEUE, 0, SEC_NONE),
 	SEC_DEF("perf_event",		PERF_EVENT, 0, SEC_NONE),
 	SEC_DEF("lwt_in",		LWT_IN, 0, SEC_NONE),
 	SEC_DEF("lwt_out",		LWT_OUT, 0, SEC_NONE),
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 0b5398786bf3..a9ead2d55264 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -97,6 +97,7 @@ static int probe_prog_load(enum bpf_prog_type prog_type,
 	case BPF_PROG_TYPE_SK_REUSEPORT:
 	case BPF_PROG_TYPE_FLOW_DISSECTOR:
 	case BPF_PROG_TYPE_CGROUP_SYSCTL:
+	case BPF_PROG_TYPE_DEQUEUE:
 		break;
 	default:
 		return -EOPNOTSUPP;
@@ -244,6 +245,10 @@ static int probe_map_create(enum bpf_map_type map_type)
 		key_size = 0;
 		max_entries = 1;
 		break;
+	case BPF_MAP_TYPE_PIFO_GENERIC:
+	case BPF_MAP_TYPE_PIFO_XDP:
+		opts.map_extra = 8;
+		break;
 	case BPF_MAP_TYPE_HASH:
 	case BPF_MAP_TYPE_ARRAY:
 	case BPF_MAP_TYPE_PROG_ARRAY:
-- 
2.37.0

