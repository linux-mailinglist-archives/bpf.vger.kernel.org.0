Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6BB124BCE3
	for <lists+bpf@lfdr.de>; Thu, 20 Aug 2020 14:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbgHTJnL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Aug 2020 05:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729148AbgHTJmS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Aug 2020 05:42:18 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98723C061384
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2020 02:42:17 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id t13so1073683ile.9
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2020 02:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0XhET/ai5wSKKXh3cFzu4ZBlJaRyJ/PNOqZCslgOEFw=;
        b=HtiWPmUCe0pxTJB/SOJ8cYs8y5/GIENAlUIeUZG44yjlJyVfD01zNgG/y8IgVK7K4U
         no8LZjHw/TNpvvJFTVSg+cDynz6LYs6W+gzzbJFfxOMGbcBBRwmavCCiXukvy+fpWcyb
         7thtA8gYe0kRnvhIxNty4TI42hXDT7IKV8KH0LJEMaDg2l7om3qluNwHBBmJ/A8alHAz
         1FnND/Xhaw0d8/EXL+BQ6BqqBd81VnuUPJWvJfiWPcu05/S20vu16CuUNpdNyoNI/TYx
         X/o6aAkh3O8x+4b3hhzqcnvXSEqz3kHoXV9GYBMox0UNeqy1zMwtD1EEZzBnK6GB2GaT
         Kr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0XhET/ai5wSKKXh3cFzu4ZBlJaRyJ/PNOqZCslgOEFw=;
        b=OKnH5wqDJ7KZOrYI0vSZEhyG0aD8GmwQF36fGY7zJNcSQ5wfIqc8HTaw0eX69oy7P7
         JHKbTwmt630IGmK856Uj1qCjZ9l+8+G9fUF4xXrlGuEMTYr5VJnRMcudmFUko6P35DaK
         +3GkCXZa//OD/UBTY3YVkyWxhR9VZmjrro0oNRDkhTVqe9V0SONxWVDsl7dILpK5UO2o
         4gs+pne7YBj1loPszIgwnFzqn2rOBqBa14Y5tHBT+lrXibzshNnQtnGdtyK2MJpulS2z
         OB0De2xM/5HXCMKp77PbIoONVb7/W/23QJjq1qewduJBsFu9JPWpZWoF8gMc0f3ATRGO
         AqTA==
X-Gm-Message-State: AOAM531vfbSPGPgO81Up2PaGcKjAf9llWXeX4yHbJO3E5bzbKsPttXLI
        ZVX0ZNwJBpXzNbZXFklSSg53l9lVoL/505Ab
X-Google-Smtp-Source: ABdhPJzlW1wNoimvbaCEZdGRnn9H3TvPmLjkgZah6zWsh7xhCqwyNKsacrk5t5Evm2v4MtpCfSIqxA==
X-Received: by 2002:a05:6e02:13ec:: with SMTP id w12mr2012048ilj.196.1597916536763;
        Thu, 20 Aug 2020 02:42:16 -0700 (PDT)
Received: from localhost.localdomain (host-173-230-99-219.tnkngak.clients.pavlovmedia.com. [173.230.99.219])
        by smtp.gmail.com with ESMTPSA id r3sm1145597iov.22.2020.08.20.02.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 02:42:16 -0700 (PDT)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        YiFei Zhu <zhuyifei@google.com>
Subject: [PATCH bpf-next 2/5] bpf: Add BPF_PROG_BIND_MAP syscall
Date:   Thu, 20 Aug 2020 04:42:08 -0500
Message-Id: <8ef54583bd3e57af53f3e4f16198907465f7c3c8.1597915265.git.zhuyifei@google.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1597915265.git.zhuyifei@google.com>
References: <cover.1597915265.git.zhuyifei@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: YiFei Zhu <zhuyifei@google.com>

This syscall binds a map to a program. -EEXIST if the map is
already bound to the program.

Signed-off-by: YiFei Zhu <zhuyifei@google.com>
---
 include/uapi/linux/bpf.h       |  7 ++++
 kernel/bpf/syscall.c           | 65 ++++++++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  7 ++++
 3 files changed, 79 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 0480f893facd..d11b2ee62148 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -124,6 +124,7 @@ enum bpf_cmd {
 	BPF_ENABLE_STATS,
 	BPF_ITER_CREATE,
 	BPF_LINK_DETACH,
+	BPF_PROG_BIND_MAP,
 };
 
 enum bpf_map_type {
@@ -649,6 +650,12 @@ union bpf_attr {
 		__u32		flags;
 	} iter_create;
 
+	struct { /* struct used by BPF_PROG_BIND_MAP command */
+		__u32		prog_fd;
+		__u32		map_fd;
+		__u32		flags;		/* extra flags */
+	} prog_bind_map;
+
 } __attribute__((aligned(8)));
 
 /* The description below is an attempt at providing documentation to eBPF
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index f49fd709ccd5..f3e0457819a0 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4141,6 +4141,68 @@ static int bpf_iter_create(union bpf_attr *attr)
 	return err;
 }
 
+#define BPF_PROG_BIND_MAP_LAST_FIELD prog_bind_map.flags
+
+static int bpf_prog_bind_map(union bpf_attr *attr)
+{
+	struct bpf_prog *prog;
+	struct bpf_map *map;
+	struct bpf_map **used_maps_old, **used_maps_new;
+	int i, ret = 0;
+
+	if (CHECK_ATTR(BPF_PROG_BIND_MAP))
+		return -EINVAL;
+
+	if (attr->prog_bind_map.flags)
+		return -EINVAL;
+
+	prog = bpf_prog_get(attr->prog_bind_map.prog_fd);
+	if (IS_ERR(prog))
+		return PTR_ERR(prog);
+
+	map = bpf_map_get(attr->prog_bind_map.map_fd);
+	if (IS_ERR(map)) {
+		ret = PTR_ERR(map);
+		goto out_prog_put;
+	}
+
+	mutex_lock(&prog->aux->used_maps_mutex);
+
+	used_maps_old = prog->aux->used_maps;
+
+	for (i = 0; i < prog->aux->used_map_cnt; i++)
+		if (used_maps_old[i] == map) {
+			ret = -EEXIST;
+			goto out_unlock;
+		}
+
+	used_maps_new = kmalloc_array(prog->aux->used_map_cnt + 1,
+				      sizeof(used_maps_new[0]),
+				      GFP_KERNEL);
+	if (!used_maps_new) {
+		ret = -ENOMEM;
+		goto out_unlock;
+	}
+
+	memcpy(used_maps_new, used_maps_old,
+	       sizeof(used_maps_old[0]) * prog->aux->used_map_cnt);
+	used_maps_new[prog->aux->used_map_cnt] = map;
+
+	prog->aux->used_map_cnt++;
+	prog->aux->used_maps = used_maps_new;
+
+	kfree(used_maps_old);
+
+out_unlock:
+	mutex_unlock(&prog->aux->used_maps_mutex);
+
+	if (ret)
+		bpf_map_put(map);
+out_prog_put:
+	bpf_prog_put(prog);
+	return ret;
+}
+
 SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, size)
 {
 	union bpf_attr attr;
@@ -4274,6 +4336,9 @@ SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, siz
 	case BPF_LINK_DETACH:
 		err = link_detach(&attr);
 		break;
+	case BPF_PROG_BIND_MAP:
+		err = bpf_prog_bind_map(&attr);
+		break;
 	default:
 		err = -EINVAL;
 		break;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 0480f893facd..d11b2ee62148 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -124,6 +124,7 @@ enum bpf_cmd {
 	BPF_ENABLE_STATS,
 	BPF_ITER_CREATE,
 	BPF_LINK_DETACH,
+	BPF_PROG_BIND_MAP,
 };
 
 enum bpf_map_type {
@@ -649,6 +650,12 @@ union bpf_attr {
 		__u32		flags;
 	} iter_create;
 
+	struct { /* struct used by BPF_PROG_BIND_MAP command */
+		__u32		prog_fd;
+		__u32		map_fd;
+		__u32		flags;		/* extra flags */
+	} prog_bind_map;
+
 } __attribute__((aligned(8)));
 
 /* The description below is an attempt at providing documentation to eBPF
-- 
2.28.0

