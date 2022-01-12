Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F79448CC12
	for <lists+bpf@lfdr.de>; Wed, 12 Jan 2022 20:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344980AbiALTfg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Jan 2022 14:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345037AbiALTei (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Jan 2022 14:34:38 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C975C06175D
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 11:34:37 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id s7-20020a5b0447000000b005fb83901511so6455101ybp.11
        for <bpf@vger.kernel.org>; Wed, 12 Jan 2022 11:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bFDryb9jb8NTEZANKT/JVNtftTgumdYcR8KASxgiLpk=;
        b=bR+DLsaq9kSX33xNRUHjrYaQ6qufxnkmK5pN16WDYuMAQnGQaUcWFwgH2aogVLm/c7
         ay86ib8+WKUE+4OhsdbCPW3kr/MCWpCaZbo7VVksfbZ/S2YrD7f+c6l5ZAVXrwaoxCuL
         cdlDy//YjymqQVrIiYaXYbZIVuLEf3mF+WTXxie+OwZecI2Bexvrjue6U+e+vZWcPIwK
         TdqxXyHqxzZIaYOqqY1L6a/SL5c7z8IuDXxPNbsvs03fnHsw+60wU2Wble+tJD7lTPoD
         dSSEhvYbIvvQVmXAH7MxypL1K4QhjAFsJtNOZBkRHG8Zg51Oh73+3u+oMB35vysIJhE7
         nZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bFDryb9jb8NTEZANKT/JVNtftTgumdYcR8KASxgiLpk=;
        b=ADziLVJxdxiFC7AZO8rIUU6w8q/xJth69E3PpcdhBLC1fT381TDeDq2egvSjmsBC6z
         xmKCBkwyt8nICXwVyiRZDGyrb3+29bkk6uzasT30KETwkbyw5N+5ABLA4cMWY946DZKq
         sVlMjSJczD4wmTmGB00ja4T3Mgyu4mj6tt501DyJB4X8ok8JznQjHrrwfdmDV0/sE2iv
         ztgufSn4IopcbsYo/MrgFY6jIq0/8gcEExe2dovAT/R/qTFUZ482yCZpL1CN1FsoVk0P
         TBa58Yf0VcQxfseRHyxIabHMUdT3dxft0qWdsNk16KDijOkLvjfHh1eGA/vq0MDYMita
         MqGg==
X-Gm-Message-State: AOAM53282fXV8ceq91jNNajlhS0gYYKCqXZkgQ8lVn7N/yCzoJ+t+eK1
        lekyEymMCAN94/MDJVEyUUX4zYazb1A=
X-Google-Smtp-Source: ABdhPJzFuYFVq3J+/T5SXF1WhAQS0ayfrMP1JMGYicdMFrSs4pBd/5Jewu2HAT9K/32HE09uzT6azwbZeU4=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:ddf2:9aea:6994:df79])
 (user=haoluo job=sendgmr) by 2002:a25:8b0e:: with SMTP id i14mr1527309ybl.218.1642016076868;
 Wed, 12 Jan 2022 11:34:36 -0800 (PST)
Date:   Wed, 12 Jan 2022 11:31:50 -0800
In-Reply-To: <20220112193152.3058718-1-haoluo@google.com>
Message-Id: <20220112193152.3058718-7-haoluo@google.com>
Mime-Version: 1.0
References: <20220112193152.3058718-1-haoluo@google.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH RESEND RFC bpf-next v1 6/8] libbpf: Support of bpf_view prog type.
From:   Hao Luo <haoluo@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The previous patch introdued a new program type bpf_view. This
patch adds support for bpf_view in libbpf.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 tools/lib/bpf/libbpf.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 7f10dd501a52..0d458e34d82c 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8570,6 +8570,7 @@ static struct bpf_link *attach_raw_tp(const struct bpf_program *prog, long cooki
 static struct bpf_link *attach_trace(const struct bpf_program *prog, long cookie);
 static struct bpf_link *attach_lsm(const struct bpf_program *prog, long cookie);
 static struct bpf_link *attach_iter(const struct bpf_program *prog, long cookie);
+static struct bpf_link *attach_view(const struct bpf_program *prog, long cookie);
 
 static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("socket",		SOCKET_FILTER, 0, SEC_NONE | SEC_SLOPPY_PFX),
@@ -8599,6 +8600,7 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("lsm/",			LSM, BPF_LSM_MAC, SEC_ATTACH_BTF, attach_lsm),
 	SEC_DEF("lsm.s/",		LSM, BPF_LSM_MAC, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_lsm),
 	SEC_DEF("iter/",		TRACING, BPF_TRACE_ITER, SEC_ATTACH_BTF, attach_iter),
+	SEC_DEF("view/",		TRACING, BPF_TRACE_VIEW, SEC_ATTACH_BTF, attach_view),
 	SEC_DEF("syscall",		SYSCALL, 0, SEC_SLEEPABLE),
 	SEC_DEF("xdp_devmap/",		XDP, BPF_XDP_DEVMAP, SEC_ATTACHABLE),
 	SEC_DEF("xdp_cpumap/",		XDP, BPF_XDP_CPUMAP, SEC_ATTACHABLE),
@@ -8896,6 +8898,7 @@ static int bpf_object__collect_st_ops_relos(struct bpf_object *obj,
 #define BTF_TRACE_PREFIX "btf_trace_"
 #define BTF_LSM_PREFIX "bpf_lsm_"
 #define BTF_ITER_PREFIX "bpf_iter_"
+#define BTF_VIEW_PREFIX "bpf_view_"
 #define BTF_MAX_NAME_SIZE 128
 
 void btf_get_kernel_prefix_kind(enum bpf_attach_type attach_type,
@@ -8914,6 +8917,10 @@ void btf_get_kernel_prefix_kind(enum bpf_attach_type attach_type,
 		*prefix = BTF_ITER_PREFIX;
 		*kind = BTF_KIND_FUNC;
 		break;
+	case BPF_TRACE_VIEW:
+		*prefix = BTF_VIEW_PREFIX;
+		*kind = BTF_KIND_FUNC;
+		break;
 	default:
 		*prefix = "";
 		*kind = BTF_KIND_FUNC;
@@ -10575,6 +10582,20 @@ struct bpf_link *bpf_program__attach_freplace(const struct bpf_program *prog,
 	}
 }
 
+static struct bpf_link *attach_view(const struct bpf_program *prog, long cookie)
+{
+	const char *target_name;
+	const char *prefix = "view/";
+	int btf_id;
+
+	target_name = prog->sec_name + strlen(prefix);
+	btf_id = libbpf_find_vmlinux_btf_id(target_name, BPF_TRACE_VIEW);
+	if (btf_id < 0)
+		return libbpf_err_ptr(btf_id);
+
+	return bpf_program__attach_fd(prog, 0, btf_id, "view");
+}
+
 struct bpf_link *
 bpf_program__attach_iter(const struct bpf_program *prog,
 			 const struct bpf_iter_attach_opts *opts)
-- 
2.34.1.448.ga2b2bfdf31-goog

