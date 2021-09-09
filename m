Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2A140499A
	for <lists+bpf@lfdr.de>; Thu,  9 Sep 2021 13:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237256AbhIILmy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Sep 2021 07:42:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236756AbhIILmj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Sep 2021 07:42:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ABC5E61186;
        Thu,  9 Sep 2021 11:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631187689;
        bh=RUAMjOZ4iyzFD+zmCq7vbst6aJVhbYT3JHlhgRH50ik=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gUyBgAyNnXNwBxnPfLm2fH7n5hL+jNEaAiQ7euv1+FLUrVF7ccuWN0FkN0dUdOmbe
         cwdldzp/sj89uqrrcKsuWzgINDc+t4ibrNLbiCGkAtuf8GpFb9zur21OAmto39TqsT
         rdgpl9ML1SE19EVIpI+8DZgDChQhvJb6V7jAE69ljl1RCzDtusjvwB+GmgG1MDJTKf
         EAVGN5JSUYzxRSXCpNENEfN3SPKmUXOEiFyFiGf2iFOIU8DPMnp544vbDQn9DEhb2c
         /YjWUsoTJNRRsjR2igHFTU6ouW6bQysL4FeOIWqmIN4s2WeEQgJgj07re6urONlrA2
         jWL8Y351vX9Xg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Martynas Pumputis <m@lambda.lt>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH AUTOSEL 5.14 017/252] libbpf: Fix reuse of pinned map on older kernel
Date:   Thu,  9 Sep 2021 07:37:11 -0400
Message-Id: <20210909114106.141462-17-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210909114106.141462-1-sashal@kernel.org>
References: <20210909114106.141462-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Martynas Pumputis <m@lambda.lt>

[ Upstream commit 97eb31384af943d6b97eb5947262cee4ef25cb87 ]

When loading a BPF program with a pinned map, the loader checks whether
the pinned map can be reused, i.e. their properties match. To derive
such of the pinned map, the loader invokes BPF_OBJ_GET_INFO_BY_FD and
then does the comparison.

Unfortunately, on < 4.12 kernels the BPF_OBJ_GET_INFO_BY_FD is not
available, so loading the program fails with the following error:

	libbpf: failed to get map info for map FD 5: Invalid argument
	libbpf: couldn't reuse pinned map at
		'/sys/fs/bpf/tc/globals/cilium_call_policy': parameter
		mismatch"
	libbpf: map 'cilium_call_policy': error reusing pinned map
	libbpf: map 'cilium_call_policy': failed to create:
		Invalid argument(-22)
	libbpf: failed to load object 'bpf_overlay.o'

To fix this, fallback to derivation of the map properties via
/proc/$PID/fdinfo/$MAP_FD if BPF_OBJ_GET_INFO_BY_FD fails with EINVAL,
which can be used as an indicator that the kernel doesn't support
the latter.

Signed-off-by: Martynas Pumputis <m@lambda.lt>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Link: https://lore.kernel.org/bpf/20210712125552.58705-1-m@lambda.lt
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/libbpf.c | 48 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 6f5e2757bb3c..4a30a788d7c8 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -3894,6 +3894,42 @@ static int bpf_map_find_btf_info(struct bpf_object *obj, struct bpf_map *map)
 	return 0;
 }
 
+static int bpf_get_map_info_from_fdinfo(int fd, struct bpf_map_info *info)
+{
+	char file[PATH_MAX], buff[4096];
+	FILE *fp;
+	__u32 val;
+	int err;
+
+	snprintf(file, sizeof(file), "/proc/%d/fdinfo/%d", getpid(), fd);
+	memset(info, 0, sizeof(*info));
+
+	fp = fopen(file, "r");
+	if (!fp) {
+		err = -errno;
+		pr_warn("failed to open %s: %d. No procfs support?\n", file,
+			err);
+		return err;
+	}
+
+	while (fgets(buff, sizeof(buff), fp)) {
+		if (sscanf(buff, "map_type:\t%u", &val) == 1)
+			info->type = val;
+		else if (sscanf(buff, "key_size:\t%u", &val) == 1)
+			info->key_size = val;
+		else if (sscanf(buff, "value_size:\t%u", &val) == 1)
+			info->value_size = val;
+		else if (sscanf(buff, "max_entries:\t%u", &val) == 1)
+			info->max_entries = val;
+		else if (sscanf(buff, "map_flags:\t%i", &val) == 1)
+			info->map_flags = val;
+	}
+
+	fclose(fp);
+
+	return 0;
+}
+
 int bpf_map__reuse_fd(struct bpf_map *map, int fd)
 {
 	struct bpf_map_info info = {};
@@ -3902,6 +3938,8 @@ int bpf_map__reuse_fd(struct bpf_map *map, int fd)
 	char *new_name;
 
 	err = bpf_obj_get_info_by_fd(fd, &info, &len);
+	if (err && errno == EINVAL)
+		err = bpf_get_map_info_from_fdinfo(fd, &info);
 	if (err)
 		return libbpf_err(err);
 
@@ -4381,12 +4419,16 @@ static bool map_is_reuse_compat(const struct bpf_map *map, int map_fd)
 	struct bpf_map_info map_info = {};
 	char msg[STRERR_BUFSIZE];
 	__u32 map_info_len;
+	int err;
 
 	map_info_len = sizeof(map_info);
 
-	if (bpf_obj_get_info_by_fd(map_fd, &map_info, &map_info_len)) {
-		pr_warn("failed to get map info for map FD %d: %s\n",
-			map_fd, libbpf_strerror_r(errno, msg, sizeof(msg)));
+	err = bpf_obj_get_info_by_fd(map_fd, &map_info, &map_info_len);
+	if (err && errno == EINVAL)
+		err = bpf_get_map_info_from_fdinfo(map_fd, &map_info);
+	if (err) {
+		pr_warn("failed to get map info for map FD %d: %s\n", map_fd,
+			libbpf_strerror_r(errno, msg, sizeof(msg)));
 		return false;
 	}
 
-- 
2.30.2

