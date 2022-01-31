Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8624A5202
	for <lists+bpf@lfdr.de>; Mon, 31 Jan 2022 23:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiAaWFe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 31 Jan 2022 17:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiAaWFe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 31 Jan 2022 17:05:34 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AC8C061714
        for <bpf@vger.kernel.org>; Mon, 31 Jan 2022 14:05:34 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id r59so15253902pjg.4
        for <bpf@vger.kernel.org>; Mon, 31 Jan 2022 14:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kp/qZI7ABVWIc8r6VAMU4dL8spjPGtGcgh4LRGbNcFE=;
        b=Z+g0hfk0Huz/XW8fgj0Yu7P1nCdriV3c9rVDnppk/5ZyKaFm2/yCXi+CvEPyKL12oE
         ZV3wDt2H53AIl+yeua+mLMMJkb7RDJ+BNi5WmXHbCBlwRLcC0gke/udj4GFbc7ValXuQ
         4gFW3GFvdKUoTMd5r59eIOA6GcCLgjhb3cx5zqZRaN7JzR/ytBEW95Y7XdMoAIUMDVLR
         ok70H38Qk1LfJRGsIeoCGlU4OmParqT+MzIMnftq6ZDKt8gayGYl+whS9YpLbD+Qrixv
         lxWb02Q/1KCl5zUYTf8/gFbGsEwOQywCPY6DOUrWhjYM13mnwSefDQ5TcXGAXsZq0KkW
         Z+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kp/qZI7ABVWIc8r6VAMU4dL8spjPGtGcgh4LRGbNcFE=;
        b=AiRzNjrRnKoGaAYoZFhEbO5FEC8zyvCTOVaCMpGymg11Wz5Ifoen4mXeQfeM9jr8zQ
         TbG4QPP3kIp7PUGk1V7KDgPqnlSlv+JlxFWNRjrFHnsf2380WpXDJQ/Dt2gIyXoLRP5U
         yCNqEu9YiH6jHzqF1VDaB4UXjxJm7ys9EMW8+DeEm17tYW8PzlwNaYzlGxL//erUlMeu
         gwOtKGOaTrzB8NUGUX8pp8FcoFVMOTTfRWwFb/553VUAzRKKkZLkVlJA134jBU7ledQw
         ZTYYvi57dxQgNbbnEZ7vi0inltbL6S12nCPSrUMmMoZxRNnFtxQjxqRBks/DBkjzF268
         CPKw==
X-Gm-Message-State: AOAM5324edT6DRTQXUWzV/eHGvMVXkeqwMo9kraNHWhrEHA+82W7hkLG
        pEcz657rY52WYhe+9WGhzR0=
X-Google-Smtp-Source: ABdhPJz+GQh9DfZJCIJjKpvJtkg7zsBjmQYUJ9qkX2nOal+UiOOOTX6iBPUQTm+vdfCHldY2bpZb7Q==
X-Received: by 2002:a17:902:bb83:: with SMTP id m3mr22661166pls.114.1643666733862;
        Mon, 31 Jan 2022 14:05:33 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:78b6])
        by smtp.gmail.com with ESMTPSA id t9sm272417pjg.44.2022.01.31.14.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 14:05:33 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH bpf-next 1/7] libbpf: Add support for bpf iter in light skeleton.
Date:   Mon, 31 Jan 2022 14:05:22 -0800
Message-Id: <20220131220528.98088-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220131220528.98088-1-alexei.starovoitov@gmail.com>
References: <20220131220528.98088-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

bpf iterator programs should use bpf_link_create to attach instead of
bpf_raw_tracepoint_open like other tracing programs.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/bpf/bpftool/gen.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 8f78c27d41f0..8eacfc79ec43 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -384,7 +384,10 @@ static void codegen_attach_detach(struct bpf_object *obj, const char *obj_name)
 			printf("\tint fd = bpf_raw_tracepoint_open(\"%s\", prog_fd);\n", tp_name);
 			break;
 		case BPF_PROG_TYPE_TRACING:
-			printf("\tint fd = bpf_raw_tracepoint_open(NULL, prog_fd);\n");
+			if (bpf_program__expected_attach_type(prog) == BPF_TRACE_ITER)
+				printf("\tint fd = bpf_link_create(prog_fd, 0, BPF_TRACE_ITER, NULL);\n");
+			else
+				printf("\tint fd = bpf_raw_tracepoint_open(NULL, prog_fd);\n");
 			break;
 		default:
 			printf("\tint fd = ((void)prog_fd, 0); /* auto-attach not supported */\n");
-- 
2.30.2

