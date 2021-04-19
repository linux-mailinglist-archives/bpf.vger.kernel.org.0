Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36190364773
	for <lists+bpf@lfdr.de>; Mon, 19 Apr 2021 17:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241794AbhDSPxY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Apr 2021 11:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241761AbhDSPxX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Apr 2021 11:53:23 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A96C061761
        for <bpf@vger.kernel.org>; Mon, 19 Apr 2021 08:52:52 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h4so25537807wrt.12
        for <bpf@vger.kernel.org>; Mon, 19 Apr 2021 08:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A4prSaPXsIfocjS9vBcbwfUJs+fTkQpMJPY7QshZYnA=;
        b=SYMBctwIixz91pOrELSI9mnSbxbZ4TGxeFeL/FuvMsJrkapdaBGB1cD/+Pg6EyjElR
         nX86jlyD5oA+I/V9Fr8khgVoGAgl41mM29gfLN8HUktbIOxv82mYh/ulxtIicumRq0dY
         mKkgg+jJoYK5ILMGfFutLU6r/vG1KpsUwDQHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A4prSaPXsIfocjS9vBcbwfUJs+fTkQpMJPY7QshZYnA=;
        b=q+LzmqY94JxJtbT/71VmIDXFpvWxdiwbGYzt4IP52KSpF8ZFpaed70dO27gUBNtg2V
         /We52QqfSuiOYt/S9W/Kh/nGzpaDQzcXTvK6TfDIOhAgMQPNPvulwqB/GNZ9DYpXXFv0
         CkAwPO1PKryDe4SEVPVPd8UEOnefnvSsNuU/ssNtJTKvM3Kl2QmwhW01clEjXnECDybI
         GP0pGmDPfs7wwk0xKlQemfACSZCdTYyRq2c+SV6gLeU3aF1gflueoxOpHDQeimTD+QEl
         r2slzRlLlDgWN7ESOE6N1k/9hCuSVqKuRTGtZ82EuPAnPkT+5jHPbp1Rdsv9RZNiA8kn
         dZrA==
X-Gm-Message-State: AOAM532mgziR9821q4dRhTkDXcEw600k2kjGBfKvrDg9tv5Kii9DOr8l
        KeKdmqgOqEFbn72tvwTPCpxnElEsEApVrQ==
X-Google-Smtp-Source: ABdhPJzDvyL1PRYkRS8WdR7BeyPqL2oUEcQzvx5PEZ6ileHlgabFkE1AcMvilHns/QM26VAUrqqgOQ==
X-Received: by 2002:adf:9011:: with SMTP id h17mr13740493wrh.384.1618847571492;
        Mon, 19 Apr 2021 08:52:51 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:61:302:3bbb:3f8f:826f:7f55])
        by smtp.gmail.com with ESMTPSA id l9sm22868669wrz.7.2021.04.19.08.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 08:52:51 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, jackmanb@chromium.org,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v5 2/6] bpf: Add a ARG_PTR_TO_CONST_STR argument type
Date:   Mon, 19 Apr 2021 17:52:39 +0200
Message-Id: <20210419155243.1632274-3-revest@chromium.org>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
In-Reply-To: <20210419155243.1632274-1-revest@chromium.org>
References: <20210419155243.1632274-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This type provides the guarantee that an argument is going to be a const
pointer to somewhere in a read-only map value. It also checks that this
pointer is followed by a zero character before the end of the map value.

Signed-off-by: Florent Revest <revest@chromium.org>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf.h   |  1 +
 kernel/bpf/verifier.c | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 77d1d8c65b81..c160526fc8bf 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -309,6 +309,7 @@ enum bpf_arg_type {
 	ARG_PTR_TO_PERCPU_BTF_ID,	/* pointer to in-kernel percpu type */
 	ARG_PTR_TO_FUNC,	/* pointer to a bpf program function */
 	ARG_PTR_TO_STACK_OR_NULL,	/* pointer to stack or NULL */
+	ARG_PTR_TO_CONST_STR,	/* pointer to a null terminated read-only string */
 	__BPF_ARG_TYPE_MAX,
 };
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 852541a435ef..5f46dd6f3383 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4787,6 +4787,7 @@ static const struct bpf_reg_types spin_lock_types = { .types = { PTR_TO_MAP_VALU
 static const struct bpf_reg_types percpu_btf_ptr_types = { .types = { PTR_TO_PERCPU_BTF_ID } };
 static const struct bpf_reg_types func_ptr_types = { .types = { PTR_TO_FUNC } };
 static const struct bpf_reg_types stack_ptr_types = { .types = { PTR_TO_STACK } };
+static const struct bpf_reg_types const_str_ptr_types = { .types = { PTR_TO_MAP_VALUE } };
 
 static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
 	[ARG_PTR_TO_MAP_KEY]		= &map_key_value_types,
@@ -4817,6 +4818,7 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
 	[ARG_PTR_TO_PERCPU_BTF_ID]	= &percpu_btf_ptr_types,
 	[ARG_PTR_TO_FUNC]		= &func_ptr_types,
 	[ARG_PTR_TO_STACK_OR_NULL]	= &stack_ptr_types,
+	[ARG_PTR_TO_CONST_STR]		= &const_str_ptr_types,
 };
 
 static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
@@ -5067,6 +5069,45 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		if (err)
 			return err;
 		err = check_ptr_alignment(env, reg, 0, size, true);
+	} else if (arg_type == ARG_PTR_TO_CONST_STR) {
+		struct bpf_map *map = reg->map_ptr;
+		int map_off;
+		u64 map_addr;
+		char *str_ptr;
+
+		if (reg->type != PTR_TO_MAP_VALUE || !map ||
+		    !bpf_map_is_rdonly(map)) {
+			verbose(env, "R%d does not point to a readonly map'\n", regno);
+			return -EACCES;
+		}
+
+		if (!tnum_is_const(reg->var_off)) {
+			verbose(env, "R%d is not a constant address'\n", regno);
+			return -EACCES;
+		}
+
+		if (!map->ops->map_direct_value_addr) {
+			verbose(env, "no direct value access support for this map type\n");
+			return -EACCES;
+		}
+
+		err = check_map_access(env, regno, reg->off,
+				       map->value_size - reg->off, false);
+		if (err)
+			return err;
+
+		map_off = reg->off + reg->var_off.value;
+		err = map->ops->map_direct_value_addr(map, &map_addr, map_off);
+		if (err) {
+			verbose(env, "direct value access on string failed\n");
+			return err;
+		}
+
+		str_ptr = (char *)(long)(map_addr);
+		if (!strnchr(str_ptr + map_off, map->value_size - map_off, 0)) {
+			verbose(env, "string is not zero-terminated\n");
+			return -EINVAL;
+		}
 	}
 
 	return err;
-- 
2.31.1.368.gbe11c130af-goog

