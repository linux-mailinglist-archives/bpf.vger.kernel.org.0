Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5173C5CAE
	for <lists+bpf@lfdr.de>; Mon, 12 Jul 2021 14:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbhGLM5x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Jul 2021 08:57:53 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:40985 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234098AbhGLM5x (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 12 Jul 2021 08:57:53 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id A53D15C01A8;
        Mon, 12 Jul 2021 08:55:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 12 Jul 2021 08:55:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Eaqf+mQPb0CqgNn2L
        8o/sO7Y2ipNcfWsZn6yLFoG/dc=; b=npunvrrrpVqGisHITrAbWtCK4GGr1G4GY
        6tPhpPIyxjnSRp1N4DIQE5TfC3lxiBVcjX2otGkt6qnrYaNSNKsR9EZWPMWufP4Q
        GhHptBq/1R31Wcbx50DoKOEflRq1fydQ0EtBU8kabz20jLclg9SXOymVt5uJkbXt
        Ti9im6Exlj9qptjSWBJ/fCQoJFq03SGXmAlouTTRegiL5z+qSjYchwNv2TQGsN5F
        ACzekPuCOuBmhClpFiO4qt5NopI9gUIAN1I1WwRZHQB6p0mKAi2lMh7VbnCCsbSX
        yABqajnx+UBX6JBW2bj2QKv8uTr1TOB0di+CAM73wBIbHSJcz6VEA==
X-ME-Sender: <xms:pjvsYHTB85nQn4k32lMyR4DmaNPFoMrbZ60Qtt4p0i14DLBWjP_CZA>
    <xme:pjvsYIyyfcMqtvAjP_9GRm93uk9TUAoWJgS6lMZfI35VOKxVzp3ELEgbPS5sg1-ut
    HBEEvLV1uowgKLHmkE>
X-ME-Received: <xmr:pjvsYM0lXyMICXVtrmpRlJe36xz4obC9N1F3eIBbWxy7KMK0yb2efIx3UXD_mK2eMcOofA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvgdehjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeforghrthihnhgrshcurfhumhhpuhhtihhsuceomheslhgrmhgsuggr
    rdhltheqnecuggftrfgrthhtvghrnhepuefhfedvheelieduhedvveeiffdtleehieduue
    ehjeejtdekuddvtdffheeuleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepmheslhgrmhgsuggrrdhlth
X-ME-Proxy: <xmx:pjvsYHCyWG-Uf5V1Th-vmvethyx5USdkGCAivM_q2EqL4uME5qWl2g>
    <xmx:pjvsYAhemPSCxRWesX-PlRMj4cUEOmggOf3-iMOzlnlEBGs-EY2OcA>
    <xmx:pjvsYLrVoSk4n9kgF5903U-8I-SIzJKK-i9bJhKTtkubhESkJ4K6mw>
    <xmx:pzvsYDsk_nVmgYPsNGZ_LB_Qbk6IE4xr8QOHCx0YYWc3wHOz7xP8Hw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jul 2021 08:55:00 -0400 (EDT)
From:   Martynas Pumputis <m@lambda.lt>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        m@lambda.lt
Subject: [PATCH v2 bpf-next] libbpf: fix reuse of pinned map on older kernel
Date:   Mon, 12 Jul 2021 14:55:51 +0200
Message-Id: <20210712125552.58705-1-m@lambda.lt>
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

To fix this, fallback to derivation of the map properties via
/proc/$PID/fdinfo/$MAP_FD if BPF_OBJ_GET_INFO_BY_FD fails with EINVAL,
which can be used as an indicator that the kernel doesn't support
the latter.

Signed-off-by: Martynas Pumputis <m@lambda.lt>
---
 tools/lib/bpf/libbpf.c | 48 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 1e04ce724240..a952acd6cd77 100644
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
2.32.0

