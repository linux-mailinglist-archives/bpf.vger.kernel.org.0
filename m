Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCA7334AE0
	for <lists+bpf@lfdr.de>; Wed, 10 Mar 2021 23:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbhCJWDP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Mar 2021 17:03:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234372AbhCJWCw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Mar 2021 17:02:52 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79729C061761
        for <bpf@vger.kernel.org>; Wed, 10 Mar 2021 14:02:29 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id y124-20020a1c32820000b029010c93864955so11990655wmy.5
        for <bpf@vger.kernel.org>; Wed, 10 Mar 2021 14:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QHAXRp5cjvFe5tOwLQufuvHj4q8NvqNGvXDx3zXkaA4=;
        b=U6+Nq610gcxHKdFeY47vS8PPCzFV27nnVAtzLR5quvgbjkblFoy39EvLscG8l+5OW2
         7kmeEhaSLd7HWtOv4Bbb8LUN1Lsr83xGKQbtgJ8Xj/vfC2bMF/33OBQwV63KKhSPsKXJ
         zOinN93ztMiP14oQrofxLGxVNBg6u1IZEXQxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QHAXRp5cjvFe5tOwLQufuvHj4q8NvqNGvXDx3zXkaA4=;
        b=HYSQSgfvM82z/xsycu6P2K4waMZVczsVc5tiLPKIq2wH2Wc+hXRqe4CYklBVvK0n33
         mnuYVG1U9lU7f5ihqz6RyfQX0Wgsk1srVcudjY+F6Q0htoq3nl5rcoudXQYmBBjrS0VG
         ghNItYK0ENYJwNxJO/gLDF82IwO97HhTOjvcbWdW01i06/jIZoj9W0EzdrVdT90QEqvJ
         /IAHgDYATV9JkwVHRAiM0vKPniDaNCTQypfBpoo8MUCKH0fPNytLvMjM+aYPD+NTjgm8
         iclfrwGqMUjTZIhky2qluLyuSuaiPvVNw2EKZGX4au6NkXsT5yBDBfj6LqHvTuYF+X4x
         lTUw==
X-Gm-Message-State: AOAM533IaQW6hxExxuzs6E+/UrYbW/pP0DD3dHsnOknjEHV7B7zjZQWm
        7LweCKdX8jYYUDLDd5cYADyy1gJgfeRvpA==
X-Google-Smtp-Source: ABdhPJzpWpebzf0c61H/lJ2zQRw60kkX/cWWJoDKfBhbV797QkHfXd98E21ocytgVprI4DCdLyjfuw==
X-Received: by 2002:a1c:2857:: with SMTP id o84mr5238166wmo.181.1615413747789;
        Wed, 10 Mar 2021 14:02:27 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:e08c:1e90:4e6b:365a])
        by smtp.gmail.com with ESMTPSA id y16sm699234wrh.3.2021.03.10.14.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 14:02:27 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, jackmanb@chromium.org,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next 1/5] bpf: Add a ARG_PTR_TO_CONST_STR argument type
Date:   Wed, 10 Mar 2021 23:02:07 +0100
Message-Id: <20210310220211.1454516-2-revest@chromium.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210310220211.1454516-1-revest@chromium.org>
References: <20210310220211.1454516-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This type provides the guarantee that an argument is going to be a const
pointer to somewhere in a read-only map value. It also checks that this
pointer is followed by a NULL character before the end of the map value.

Signed-off-by: Florent Revest <revest@chromium.org>
---
 include/linux/bpf.h   |  1 +
 kernel/bpf/verifier.c | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

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
index f9096b049cd6..c99b2b67dc8d 100644
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
@@ -4881,6 +4883,45 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		if (err)
 			return err;
 		err = check_ptr_alignment(env, reg, 0, size, true);
+	} else if (arg_type == ARG_PTR_TO_CONST_STR) {
+		struct bpf_map *map = reg->map_ptr;
+		int map_off, i;
+		u64 map_addr;
+		char *map_ptr;
+
+		if (!map || !bpf_map_is_rdonly(map)) {
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
+		err = check_helper_mem_access(env, regno,
+					      map->value_size - reg->off,
+					      false, meta);
+		if (err)
+			return err;
+
+		map_off = reg->off + reg->var_off.value;
+		err = map->ops->map_direct_value_addr(map, &map_addr, map_off);
+		if (err)
+			return err;
+
+		map_ptr = (char *)(map_addr);
+		for (i = map_off; map_ptr[i] != '\0'; i++) {
+			if (i == map->value_size - 1) {
+				verbose(env, "map does not contain a NULL-terminated string\n");
+				return -EACCES;
+			}
+		}
 	}
 
 	return err;
-- 
2.30.1.766.gb4fecdf3b7-goog

