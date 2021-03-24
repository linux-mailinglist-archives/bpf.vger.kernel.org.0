Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA0A346F6B
	for <lists+bpf@lfdr.de>; Wed, 24 Mar 2021 03:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbhCXCXW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Mar 2021 22:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234866AbhCXCXI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Mar 2021 22:23:08 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DB7C0613D8
        for <bpf@vger.kernel.org>; Tue, 23 Mar 2021 19:23:08 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id z2so22854671wrl.5
        for <bpf@vger.kernel.org>; Tue, 23 Mar 2021 19:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3lrwN5zbcO+2TddxRTzc39cDIK+QrZIGvDOM+43GgDs=;
        b=cU4PgYGKJxnC/dVpyJquzDxdzvr7W+eqCMo/RJW7908NZKOC+sAy2Y7owcWF+nEQOp
         9hZ+p+L1m2rcxoiBnZALagohq0UwX6pPWO8dbzrTa64e447MZ0tfuqHVLeBpy0j26dh6
         sIy42r019xG7jGb0ownF/WRcBcDw4u3A1qhDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3lrwN5zbcO+2TddxRTzc39cDIK+QrZIGvDOM+43GgDs=;
        b=RMtzuV3OjwV4VRpKQyXwAn8Q7qaaqDxRz5Mx1whVQO0jT9HCfFcZKuKM9LcaUHdnKu
         UB6Oh+cfezMijaSRiChOziVNdUYQ96aSU35y6dJ445jesQ1iG7wFRpPI18h7JCdMEjaH
         V/4ZMAzbYuDV7NEUzqLsPNwS1StkEDRLt3DzqPBcKPcLQd0uj06UYVXeFc0+JdmsoMyT
         BS4Mm7KzDWhLcFjL0I0OyE8uXFgINhgtiTN6L22RJ5A6QNBG67ki45nM07wrA13HmBsG
         E1ytZCfyfdGCn6ADf94FuEK6kn+vJAR8QicLBdTShjP60R5OcH+jRyPsrk87vayGSt+l
         6vuA==
X-Gm-Message-State: AOAM530L3levyp0fbRBMH8U+AIdY55XSTFeSOh5jbW5N8L0iAf+t11Pz
        ZNdz2FTz2jjZNHGRjd+E+uBf/JEkgHMFLQ==
X-Google-Smtp-Source: ABdhPJzdkEYVWUng8GcKTofYeqJqug0FfQv2A5TGjfbYLxWmF2rEmATFSjTZnIv+NNY3hm+p8EWOTg==
X-Received: by 2002:a05:6000:c7:: with SMTP id q7mr864818wrx.356.1616552586705;
        Tue, 23 Mar 2021 19:23:06 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:ccba:9601:929c:dbcb])
        by smtp.gmail.com with ESMTPSA id n9sm74219wrx.46.2021.03.23.19.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 19:23:06 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, jackmanb@chromium.org,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v2 2/6] bpf: Add a ARG_PTR_TO_CONST_STR argument type
Date:   Wed, 24 Mar 2021 03:22:07 +0100
Message-Id: <20210324022211.1718762-3-revest@chromium.org>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
In-Reply-To: <20210324022211.1718762-1-revest@chromium.org>
References: <20210324022211.1718762-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This type provides the guarantee that an argument is going to be a const
pointer to somewhere in a read-only map value. It also checks that this
pointer is followed by a zero character before the end of the map value.

Signed-off-by: Florent Revest <revest@chromium.org>
---
 include/linux/bpf.h   |  1 +
 kernel/bpf/verifier.c | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a25730eaa148..7b5319d75b3e 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -308,6 +308,7 @@ enum bpf_arg_type {
 	ARG_PTR_TO_PERCPU_BTF_ID,	/* pointer to in-kernel percpu type */
 	ARG_PTR_TO_FUNC,	/* pointer to a bpf program function */
 	ARG_PTR_TO_STACK_OR_NULL,	/* pointer to stack or NULL */
+	ARG_PTR_TO_CONST_STR,	/* pointer to a null terminated read-only string */
 	__BPF_ARG_TYPE_MAX,
 };
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e26c5170c953..9e03608725b4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4601,6 +4601,7 @@ static const struct bpf_reg_types spin_lock_types = { .types = { PTR_TO_MAP_VALU
 static const struct bpf_reg_types percpu_btf_ptr_types = { .types = { PTR_TO_PERCPU_BTF_ID } };
 static const struct bpf_reg_types func_ptr_types = { .types = { PTR_TO_FUNC } };
 static const struct bpf_reg_types stack_ptr_types = { .types = { PTR_TO_STACK } };
+static const struct bpf_reg_types const_str_ptr_types = { .types = { PTR_TO_MAP_VALUE } };
 
 static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
 	[ARG_PTR_TO_MAP_KEY]		= &map_key_value_types,
@@ -4631,6 +4632,7 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
 	[ARG_PTR_TO_PERCPU_BTF_ID]	= &percpu_btf_ptr_types,
 	[ARG_PTR_TO_FUNC]		= &func_ptr_types,
 	[ARG_PTR_TO_STACK_OR_NULL]	= &stack_ptr_types,
+	[ARG_PTR_TO_CONST_STR]		= &const_str_ptr_types,
 };
 
 static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
@@ -4881,6 +4883,42 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
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
+		if (err)
+			return err;
+
+		str_ptr = (char *)(long)(map_addr);
+		if (!strnchr(str_ptr + map_off,
+			     map->value_size - reg->off - map_off, 0))
+			verbose(env, "string is not zero-terminated\n");
 	}
 
 	return err;
-- 
2.31.0.291.g576ba9dcdaf-goog

