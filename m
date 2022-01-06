Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66BA2486CBE
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 22:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244511AbiAFVvY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jan 2022 16:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244453AbiAFVvY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Jan 2022 16:51:24 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597D6C061245
        for <bpf@vger.kernel.org>; Thu,  6 Jan 2022 13:51:24 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 66-20020a251245000000b0060d05da9c4eso7532234ybs.10
        for <bpf@vger.kernel.org>; Thu, 06 Jan 2022 13:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bFDryb9jb8NTEZANKT/JVNtftTgumdYcR8KASxgiLpk=;
        b=DZDMMcm4aLYN4nGEEuSRdgn5Zf2Um7p5Kwt4LEe7V4S17hBpCXazRi2MpObyVg8Vlt
         cW6PyjTwoSAMVAJMmed6/+q/RqVCz0HLfx9LuwlFlmupD4g0gAH7oyWZFRh5zFmLCEKl
         s4fScyzZAG3TVwvfb4VgiitKm5fRSfblbn4Y+r5D9zI0xUMjPyGk+rBGhm7QLlJRPB61
         6nhB/TD4OfjqO2tiBEza+ZST8HMetnk+eTUf2WzqZ1LNAbUlRGSFsW4tEO37e3Mnerhl
         2hVQTS4LJMBSTyc64RWnKUctBw0WzwW13d2cOULtieBohxdnnqT7QDoXUhjut+S2ldp/
         eb5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bFDryb9jb8NTEZANKT/JVNtftTgumdYcR8KASxgiLpk=;
        b=In81J3iMuu06kVIg6SvfsFX356jBZ08ks9ycVtzZ5YrO9M61r/41zVhQcyh/W3sZ5q
         HTXQ/XHuQvU9sP3TizHB5/gb8edoOjFV/aZ3ikNZet3xd407QIcQwbHR6aMTBOrmOZtC
         YJKtGCqz+LgXTNBMm+0gkd0s/3unYlAbVu5J06VBBHCDnfWGKx352bC4excbLS1YA+Mo
         /+YqXwUvHe99JEOfXhHnqD8VZoJN9ZIzHXYXursgi5qPRs0/22uf0fDtlHj7r23UqAtw
         lL6Zi1g1p8lfZbnlSMY7BA1SDVQyTAD13GJeg22Bt3xwXLYEKeew4zwruTxblo0loOrL
         EgkA==
X-Gm-Message-State: AOAM533LRuHGpfceB6I7akX1S7mTckU7dujOJZbzTEIaLvvzjXdQQ/Nr
        j7ktePfgw0JiEq/gKbZdtVBUm9GUBjw=
X-Google-Smtp-Source: ABdhPJydxKV2xcGerXmc5STbVnaWxR8txJKeY17EFr1JeItSx+KJ2AaHWbNSwwHptzc0ZFKR7yQIF3i4RNA=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2cd:202:3a2:a76c:b77f:b671])
 (user=haoluo job=sendgmr) by 2002:a25:640a:: with SMTP id y10mr62277073ybb.189.1641505883601;
 Thu, 06 Jan 2022 13:51:23 -0800 (PST)
Date:   Thu,  6 Jan 2022 13:50:57 -0800
In-Reply-To: <20220106215059.2308931-1-haoluo@google.com>
Message-Id: <20220106215059.2308931-7-haoluo@google.com>
Mime-Version: 1.0
References: <20220106215059.2308931-1-haoluo@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH RFC bpf-next v1 6/8] libbpf: Support of bpf_view prog type.
From:   Hao Luo <haoluo@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org,
        Hao Luo <haoluo@google.com>
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

