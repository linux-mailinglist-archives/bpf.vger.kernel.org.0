Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D087D3BE685
	for <lists+bpf@lfdr.de>; Wed,  7 Jul 2021 12:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbhGGKsZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Jul 2021 06:48:25 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:58009 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230354AbhGGKsY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 7 Jul 2021 06:48:24 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 8E51C32004E7;
        Wed,  7 Jul 2021 06:45:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 07 Jul 2021 06:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=spe32FZRmT1bOTG/e
        CuW5GLUkc5hSUB1VHOlRpBR5J4=; b=ITQyheFxIhOp8qWfTaTVGfGjSVH+A4A/u
        LbsRL+Qn1Dtko+GJay1OUlRFHNrdQmQc0KqquVzhZs9V584/DsDGYpDNM8Y9Dc6T
        bXBYxB9soejNxMaRdmOO4gq1M4oNh5kOmJDv0ilOqn9PCz5zvnldp/Tr/YLOQ2k8
        yfnDQud/k0G12dVcuQQ8u/3SPR1D3Y+RMwlCnDbzI6HIwqYa9cQ10D45obFsTsJD
        n5FRgGL1yA2qhnqFV9qOFhLs7AjWJ6M8Sq2c7ETRWLGTrxHLtYe1VpReF+4eiirm
        HfeSvocZSSEMhjnB9FVcm5xTFxKrXwcBAV/TLcQV94Dbf1LPhV9yQ==
X-ME-Sender: <xms:14XlYJdv8cQ2W874v2IFFkBk5x3NZz293W24izhAyYN2oi9j3_B_Rw>
    <xme:14XlYHNJON6v6D2Sjp_99CJOREcwucwjI3c5GwREBrSdo98zAwayhuxI2W2fJZz3T
    R8-yZBAzDTECsQEemA>
X-ME-Received: <xmr:14XlYCjwWJfr-HmUcAU24IJ9cqhVbQCOb9M-8uLSbIQl_9tsHeY94zoTzYFkefJCPP9mlg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrtddvgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeforghrthihnhgrshcurfhumhhpuhhtihhsuceomheslhgrmhgsuggr
    rdhltheqnecuggftrfgrthhtvghrnhepuefhfedvheelieduhedvveeiffdtleehieduue
    ehjeejtdekuddvtdffheeuleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepmheslhgrmhgsuggrrdhlth
X-ME-Proxy: <xmx:14XlYC-dZbK2iIRPJtRvXcJsoCEAoYRx5gsAOi4BdUXQkThNQQuQ0A>
    <xmx:14XlYFvrEybjEmFdhbgIhtJyCJndttaACJ8VnFdC7X7hj7UhVsxfAw>
    <xmx:14XlYBGUuX76MLYskg64fBxRmQS2NGbAQsJA_haigKjSvqsMShwA7g>
    <xmx:2IXlYO7osI1Sfg169MNdvQevCHDCqZP4ne75dzmOdZOySwpCbmNjKQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jul 2021 06:45:42 -0400 (EDT)
From:   Martynas Pumputis <m@lambda.lt>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        m@lambda.lt
Subject: [PATCH v2 bpf] libbpf: fix reuse of pinned map on older kernel
Date:   Wed,  7 Jul 2021 12:47:36 +0200
Message-Id: <20210707104736.637312-1-m@lambda.lt>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

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

To fix this, probe the kernel for BPF_OBJ_GET_INFO_BY_FD support. If it
doesn't support, then fallback to derivation of the map properties via
/proc/$PID/fdinfo/$MAP_FD.

Signed-off-by: Martynas Pumputis <m@lambda.lt>
---
 tools/lib/bpf/libbpf.c | 103 +++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 92 insertions(+), 11 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index ac882e1..f3daed3 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -193,6 +193,8 @@ enum kern_feature_id {
 	FEAT_MODULE_BTF,
 	/* BTF_KIND_FLOAT support */
 	FEAT_BTF_FLOAT,
+	/* BPF_OBJ_GET_INFO_BY_FD support */
+	FEAT_OBJ_GET_INFO_BY_FD,
 	__FEAT_CNT,
 };
 
@@ -3920,14 +3922,54 @@ static int bpf_map_find_btf_info(struct bpf_object *obj, struct bpf_map *map)
 	return 0;
 }
 
-int bpf_map__reuse_fd(struct bpf_map *map, int fd)
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
+static int bpf_map__reuse_fd_safe(struct bpf_object *obj, struct bpf_map *map,
+				  int fd)
 {
 	struct bpf_map_info info = {};
 	__u32 len = sizeof(info);
 	int new_fd, err;
 	char *new_name;
 
-	err = bpf_obj_get_info_by_fd(fd, &info, &len);
+	if (!obj || kernel_supports(obj, FEAT_OBJ_GET_INFO_BY_FD))
+		err = bpf_obj_get_info_by_fd(fd, &info, &len);
+	else
+		err = bpf_get_map_info_from_fdinfo(fd, &info);
 	if (err)
 		return libbpf_err(err);
 
@@ -3974,6 +4016,11 @@ err_free_new_name:
 	return libbpf_err(err);
 }
 
+int bpf_map__reuse_fd(struct bpf_map *map, int fd)
+{
+	return bpf_map__reuse_fd_safe(NULL, map, fd);
+}
+
 __u32 bpf_map__max_entries(const struct bpf_map *map)
 {
 	return map->def.max_entries;
@@ -4320,6 +4367,27 @@ static int probe_module_btf(void)
 	return !err;
 }
 
+static int probe_kern_bpf_get_info_by_fd(void)
+{
+	int fd, err;
+	__u32 len;
+	struct bpf_map_info info;
+	struct bpf_create_map_attr attr = {
+		.map_type = BPF_MAP_TYPE_ARRAY,
+		.key_size = sizeof(int),
+		.value_size = sizeof(int),
+		.max_entries = 1,
+	};
+
+	fd = bpf_create_map_xattr(&attr);
+	if (fd < 0)
+		return 0;
+
+	err = bpf_obj_get_info_by_fd(fd, &info, &len);
+	close(fd);
+	return !err;
+}
+
 enum kern_feature_result {
 	FEAT_UNKNOWN = 0,
 	FEAT_SUPPORTED = 1,
@@ -4370,6 +4438,9 @@ static struct kern_feature_desc {
 	[FEAT_BTF_FLOAT] = {
 		"BTF_KIND_FLOAT support", probe_kern_btf_float,
 	},
+	[FEAT_OBJ_GET_INFO_BY_FD] = {
+		"BPF_OBJ_GET_INFO_BY_FD support", probe_kern_bpf_get_info_by_fd,
+	},
 };
 
 static bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id feat_id)
@@ -4398,7 +4469,8 @@ static bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id f
 	return READ_ONCE(feat->res) == FEAT_SUPPORTED;
 }
 
-static bool map_is_reuse_compat(const struct bpf_map *map, int map_fd)
+static bool map_is_reuse_compat(struct bpf_object *obj,
+				const struct bpf_map *map, int map_fd)
 {
 	struct bpf_map_info map_info = {};
 	char msg[STRERR_BUFSIZE];
@@ -4406,10 +4478,19 @@ static bool map_is_reuse_compat(const struct bpf_map *map, int map_fd)
 
 	map_info_len = sizeof(map_info);
 
-	if (bpf_obj_get_info_by_fd(map_fd, &map_info, &map_info_len)) {
-		pr_warn("failed to get map info for map FD %d: %s\n",
-			map_fd, libbpf_strerror_r(errno, msg, sizeof(msg)));
-		return false;
+	if (kernel_supports(obj, FEAT_OBJ_GET_INFO_BY_FD)) {
+		if (bpf_obj_get_info_by_fd(map_fd, &map_info, &map_info_len)) {
+			pr_warn("failed to get map info for map FD %d: %s\n",
+				map_fd,
+				libbpf_strerror_r(errno, msg, sizeof(msg)));
+			return false;
+		}
+	} else {
+		if (bpf_get_map_info_from_fdinfo(map_fd, &map_info)) {
+			pr_warn("failed to get map info for fdinfo: %s\n",
+				libbpf_strerror_r(errno, msg, sizeof(msg)));
+			return false;
+		}
 	}
 
 	return (map_info.type == map->def.type &&
@@ -4420,7 +4501,7 @@ static bool map_is_reuse_compat(const struct bpf_map *map, int map_fd)
 }
 
 static int
-bpf_object__reuse_map(struct bpf_map *map)
+bpf_object__reuse_map(struct bpf_object *obj, struct bpf_map *map)
 {
 	char *cp, errmsg[STRERR_BUFSIZE];
 	int err, pin_fd;
@@ -4440,14 +4521,14 @@ bpf_object__reuse_map(struct bpf_map *map)
 		return err;
 	}
 
-	if (!map_is_reuse_compat(map, pin_fd)) {
+	if (!map_is_reuse_compat(obj, map, pin_fd)) {
 		pr_warn("couldn't reuse pinned map at '%s': parameter mismatch\n",
 			map->pin_path);
 		close(pin_fd);
 		return -EINVAL;
 	}
 
-	err = bpf_map__reuse_fd(map, pin_fd);
+	err = bpf_map__reuse_fd_safe(obj, map, pin_fd);
 	if (err) {
 		close(pin_fd);
 		return err;
@@ -4643,7 +4724,7 @@ bpf_object__create_maps(struct bpf_object *obj)
 		map = &obj->maps[i];
 
 		if (map->pin_path) {
-			err = bpf_object__reuse_map(map);
+			err = bpf_object__reuse_map(obj, map);
 			if (err) {
 				pr_warn("map '%s': error reusing pinned map\n",
 					map->name);
-- 
2.32.0

