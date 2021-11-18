Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2003455A2B
	for <lists+bpf@lfdr.de>; Thu, 18 Nov 2021 12:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343901AbhKRL3a (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Nov 2021 06:29:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:55984 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343913AbhKRL23 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Nov 2021 06:28:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637234729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FziBM/Abk38ZsIcsX8WUe178lP8av41CXsWZwffEWF4=;
        b=dp87VThlV8r38SECUmklwAN0ziYusydSUGvtDFJO2XkUQkujqk3WC6C38LFfiH1jlyLHlY
        HnYBxNyBYa+ZW8nfgPT93fLtGOCV0+AA1EI6utX2dJc39jHoOAMTKbo15gc8A4loBZlYPC
        ZB6iZiNl6CqpNP84ZBeJc19qus2ldO4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-245--45ydm3vPyiB2WNPWV_pjQ-1; Thu, 18 Nov 2021 06:25:28 -0500
X-MC-Unique: -45ydm3vPyiB2WNPWV_pjQ-1
Received: by mail-ed1-f69.google.com with SMTP id f4-20020a50e084000000b003db585bc274so4958657edl.17
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 03:25:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FziBM/Abk38ZsIcsX8WUe178lP8av41CXsWZwffEWF4=;
        b=QVzt8iTtCc4foVCWvnghZD/fOPCvlYUk8phyh8NxOJOy11u1IpxlmWjxgHBmUZmt0C
         odW05F5fdQoBsAh3lIBTFzjU+SlbrDbR0bpuqPNkWYtNvULCmnnMvQ8dFiif6dVURTFM
         0ASomCAALjm2UEH0S3IVN2h8yjTAwZhYEIwv/H8FW5kBnhOQRqRG0gK2q1NN7ZjTRrnn
         af2jxdO9m+v95wCX1J3vQt622gRnCU13ts7zp4cbJ2TTRLELkxRvqOJbvJNCbwvXvZBC
         hxxjIE7neeD792l9VQcbRBMz9JHbgmpGMXe+3ly+796ASZE3S+0U9GVf1WDrLWHPuXVp
         nWyQ==
X-Gm-Message-State: AOAM531Es+ZJIySCvuDiszhlIb1yJBwaGsvd6XaJrqiUc33v1dIL3fBe
        sPMDCrFdVVbnYwWfhARIpj3F5aFzYK/55Q4qoyqffi5XNePFtF3LH9MlLVgUzqPRQBx7JZ/hePx
        R6vLEMQCR1FKR
X-Received: by 2002:a50:ef02:: with SMTP id m2mr10171528eds.172.1637234727230;
        Thu, 18 Nov 2021 03:25:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwibvICcLQ2tYVo+N7H3O2OA40ycE0Lvf9i8jybkUJAsfZom/RYr7fy5OAjx+XkJ8L5+N/sOw==
X-Received: by 2002:a50:ef02:: with SMTP id m2mr10171509eds.172.1637234727119;
        Thu, 18 Nov 2021 03:25:27 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id d3sm1443289edx.79.2021.11.18.03.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 03:25:26 -0800 (PST)
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
Subject: [PATCH bpf-next 05/29] bpf: Add bpf_check_attach_model function
Date:   Thu, 18 Nov 2021 12:24:31 +0100
Message-Id: <20211118112455.475349-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211118112455.475349-1-jolsa@kernel.org>
References: <20211118112455.475349-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding bpf_check_attach_model function that returns
model for function specified by btf_id. It will be
used in following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf_verifier.h |  4 ++++
 kernel/bpf/verifier.c        | 29 +++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index c8a78e830fca..b561c0b08e68 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -527,6 +527,10 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			    const struct bpf_prog *tgt_prog,
 			    u32 btf_id,
 			    struct bpf_attach_target_info *tgt_info);
+int bpf_check_attach_model(const struct bpf_prog *prog,
+			   const struct bpf_prog *tgt_prog,
+			   u32 btf_id,
+			   struct btf_func_model *fmodel);
 void bpf_free_kfunc_btf_tab(struct bpf_kfunc_btf_tab *tab);
 
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index cbbbf47e1832..fac0c3518add 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13749,6 +13749,35 @@ static int __bpf_check_attach_target(struct bpf_verifier_log *log,
 	return 0;
 }
 
+int bpf_check_attach_model(const struct bpf_prog *prog,
+			   const struct bpf_prog *tgt_prog,
+			   u32 btf_id,
+			   struct btf_func_model *fmodel)
+{
+	struct attach_target target = { };
+	int ret;
+
+	ret = __bpf_check_attach_target(NULL, prog, tgt_prog, btf_id, &target);
+	if (ret)
+		return ret;
+
+	switch (prog->expected_attach_type) {
+	case BPF_TRACE_RAW_TP:
+		break;
+	case BPF_TRACE_ITER:
+		ret = btf_distill_func_proto(NULL, target.btf, target.t, target.tname, fmodel);
+		break;
+	default:
+	case BPF_MODIFY_RETURN:
+	case BPF_LSM_MAC:
+	case BPF_TRACE_FENTRY:
+	case BPF_TRACE_FEXIT:
+		ret = btf_distill_func_proto(NULL, target.btf, target.t, target.tname, fmodel);
+	}
+
+	return ret;
+}
+
 int bpf_check_attach_target(struct bpf_verifier_log *log,
 			    const struct bpf_prog *prog,
 			    const struct bpf_prog *tgt_prog,
-- 
2.31.1

