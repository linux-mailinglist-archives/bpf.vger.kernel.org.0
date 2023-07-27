Return-Path: <bpf+bounces-6047-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 603937648DA
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 09:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 914B71C214F0
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 07:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036DEC2FF;
	Thu, 27 Jul 2023 07:37:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45CBBE72
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 07:37:54 +0000 (UTC)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F564200
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 00:37:28 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3a38953c928so601644b6e.1
        for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 00:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690443447; x=1691048247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uv3OYCgolDRnDe8sjWn08GTjavdgRys1P8gpfRFXymU=;
        b=GPxKU1wLA/ico6qT1nEEu7gHQfgASi8rquE1AHhcXYJT1YIgQWCl0gYkO+q7Q4Ajd8
         ZGhT1ge1OlP7dnRkKC9NzY2sUvhgM/h6rPXqBu3xK1S9r98sHCrdmoTvcTfANYWZBoLd
         xfVIwZRmn2yWUEfGaYPS4U465p+g49PadC9fcYd0hx5ojquQUhWVeEKTqP+pZ9xvinLc
         bNKbsys0ZIGHmQCTT0vWBHPadAdI12u2RXt8ygcYMQkFpLj8uIdMWG4xFoQS93HgAPsT
         PwYp3/fy/qrx1r2C2MV0kCEoJMDJandD7xo85GeTJRyvBJxZslJGlHE1vTxBwPd27657
         T+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690443447; x=1691048247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uv3OYCgolDRnDe8sjWn08GTjavdgRys1P8gpfRFXymU=;
        b=ll7KkfTqLHDd5JQJbjHTChLGIVYVpQR14nA2r3SEolDnRNYQ+r0YKGorTJLZJl4ZJn
         GvHBA9+zTnMymG+1R+H2aXVB2WX/l9asCCIunupJNYjjV19CPnqM+rQ4tIp6OcR7spO3
         eFPCgCbrHcDc4mmRDMkKuCpum/SlChR8eBWRrQQCtGMy9Bq5byCkXJZ2wqUpS/qHWDxH
         vLi31DGEXUXDpjeu5FAOaKYR6S36K1BF6c5/u6PfivCieVDuKn6hpjiSktPKQmOKRm94
         5NRlTmABgnTO/Nn9ueyUp7m0uQUf3pcsFfRej5EjySefkFk+MEC12JS276yCdU4Ds9iy
         Al9A==
X-Gm-Message-State: ABy/qLa3OY39a+G97tOfRVsrn3aqEV31zPwsObfGiZDnqkY5trIWMntS
	/IDMrXr8p576xlWSbEXXEHxQ7w==
X-Google-Smtp-Source: APBJJlGHqT5qPjTtSbXoYNJy1i+7DtwD7lYrnGBfTg7InyflfRjIZJ5jUGAx6rk7oi3Ui6choddTkw==
X-Received: by 2002:a05:6808:1393:b0:3a5:ca93:fb69 with SMTP id c19-20020a056808139300b003a5ca93fb69mr2618037oiw.55.1690443447035;
        Thu, 27 Jul 2023 00:37:27 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.134])
        by smtp.gmail.com with ESMTPSA id s196-20020a6377cd000000b005638a70110bsm733919pgc.65.2023.07.27.00.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 00:37:26 -0700 (PDT)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wuyun.abel@bytedance.com,
	robin.lu@bytedance.com,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [RFC PATCH 4/5] bpf: Add a new bpf helper to get cgroup ino
Date: Thu, 27 Jul 2023 15:36:31 +0800
Message-Id: <20230727073632.44983-5-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230727073632.44983-1-zhouchuyi@bytedance.com>
References: <20230727073632.44983-1-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch adds a new bpf helper bpf_get_ino_from_cgroup_id, so that
we can get the inode number once we know the cgroup id.

Cgroup_id is used to identify a cgroup in BPF prog. However we can't
get the cgroup id directly in userspace applications. In userspace,
we are used to identifying cgroups by their paths or their inodes.
However, cgroup id is not always equal to the inode number, depending
on the sizeof ino_t.

For example, given some cgroup paths, we only care about the events
related to those cgroups. We can only do this by updating these paths
in a map and doing string comparison in BPF prog, which is not very
convenient. However with this new helper, we just need to record
the inode in a map and lookup a inode number in BPF prog.

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 include/uapi/linux/bpf.h       |  7 +++++++
 kernel/bpf/core.c              |  1 +
 kernel/bpf/helpers.c           | 17 +++++++++++++++++
 tools/include/uapi/linux/bpf.h |  7 +++++++
 4 files changed, 32 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 9da0d61cf703..01efb289fa14 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5575,6 +5575,12 @@ union bpf_attr {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ *
+ * u64 bpf_get_ino_from_cgroup_id(u64 id)
+ *	Description
+ *		Get inode number from a *cgroup id*.
+ *	Return
+ *		Inode number.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -5789,6 +5795,7 @@ union bpf_attr {
 	FN(user_ringbuf_drain, 209, ##ctx)		\
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
+	FN(get_ino_from_cgroup_id, 212, ##ctx)		\
 	/* */
 
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index dc85240a0134..49dfdb2dd336 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2666,6 +2666,7 @@ const struct bpf_func_proto bpf_snprintf_btf_proto __weak;
 const struct bpf_func_proto bpf_seq_printf_btf_proto __weak;
 const struct bpf_func_proto bpf_set_retval_proto __weak;
 const struct bpf_func_proto bpf_get_retval_proto __weak;
+const struct bpf_func_proto bpf_get_ino_from_cgroup_id_proto __weak;
 
 const struct bpf_func_proto * __weak bpf_get_trace_printk_proto(void)
 {
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 9e80efa59a5d..e87328b008d3 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -433,6 +433,21 @@ const struct bpf_func_proto bpf_get_current_ancestor_cgroup_id_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_ANYTHING,
 };
+
+BPF_CALL_1(bpf_get_ino_from_cgroup_id, u64, id)
+{
+	u64 ino = kernfs_id_ino(id);
+
+	return ino;
+}
+
+const struct bpf_func_proto bpf_get_ino_from_cgroup_id_proto = {
+	.func		= bpf_get_ino_from_cgroup_id,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_ANYTHING,
+};
+
 #endif /* CONFIG_CGROUPS */
 
 #define BPF_STRTOX_BASE_MASK 0x1F
@@ -1767,6 +1782,8 @@ bpf_base_func_proto(enum bpf_func_id func_id)
 		return &bpf_get_current_cgroup_id_proto;
 	case BPF_FUNC_get_current_ancestor_cgroup_id:
 		return &bpf_get_current_ancestor_cgroup_id_proto;
+	case BPF_FUNC_get_ino_from_cgroup_id:
+		return &bpf_get_ino_from_cgroup_id_proto;
 #endif
 	default:
 		break;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 9da0d61cf703..661d97aacb85 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5575,6 +5575,12 @@ union bpf_attr {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ *
+ * u64 bpf_get_ino_from_cgroup_id(u64 id)
+ *	Description
+ *		Get inode number from a *cgroup id*.
+ *	Return
+ *		Inode number.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -5789,6 +5795,7 @@ union bpf_attr {
 	FN(user_ringbuf_drain, 209, ##ctx)		\
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
+	FN(get_ino_from_cgroup_id, 212, ##ctx)  \
 	/* */
 
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
-- 
2.20.1


