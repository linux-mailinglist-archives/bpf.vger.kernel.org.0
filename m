Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FC8691530
	for <lists+bpf@lfdr.de>; Fri, 10 Feb 2023 01:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjBJANE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Feb 2023 19:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjBJAND (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Feb 2023 19:13:03 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1EA5D3EE
        for <bpf@vger.kernel.org>; Thu,  9 Feb 2023 16:13:02 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 319NmcXG015385;
        Fri, 10 Feb 2023 00:12:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=HCaz2I83FjHUVnYK+ML/WLIQQNmHdDgfk3utS2mzK7g=;
 b=lmlk3WVky5MtkAd/kP+EDQ4f/X58d4v4tcqrQyTfAmoxj1ivhx34tN7/PzD73Un7cnni
 CyipoFIu/PuX42LGZBBUYPlwLiDhEpoMsD2iFnCz7AoDM9I2RIGzGK660s0T5nKIpKS+
 TcaiZFT7KIqfK9fiBDCV95DksYFJQni8VwpOXHEn0C+8LKoGbBrNJ+OY1E6FmZ4QL2aB
 g5/xukwZJsLkYp+Nbcmh70EI8hPA/wB97p+MTh/Lp234xCX0HDlupWEoPga9O5cKc4ad
 GMtJ0/m43fAmoOfDEvAjC35/iZXBujGhzVh2CGvQXGV+nBjd2Cs5XFr0ugzJLeMvQkCf sQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nnau4gvh2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 00:12:45 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 319Cl4Jb020985;
        Fri, 10 Feb 2023 00:12:43 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3nhemfptr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 00:12:43 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31A0CdDp43909612
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 00:12:39 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9BF7420043;
        Fri, 10 Feb 2023 00:12:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1546620040;
        Fri, 10 Feb 2023 00:12:39 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.171.74.186])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 10 Feb 2023 00:12:38 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 09/16] libbpf: Use bpf_{btf,link,map,prog}_get_info_by_fd()
Date:   Fri, 10 Feb 2023 01:12:03 +0100
Message-Id: <20230210001210.395194-10-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230210001210.395194-1-iii@linux.ibm.com>
References: <20230210001210.395194-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: G3NBe5z4FPgWw7JN2VqIsuTyCoBekXmj
X-Proofpoint-GUID: G3NBe5z4FPgWw7JN2VqIsuTyCoBekXmj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-09_16,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302090217
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use the new type-safe wrappers around bpf_obj_get_info_by_fd().

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/lib/bpf/btf.c     |  8 ++++----
 tools/lib/bpf/libbpf.c  | 14 +++++++-------
 tools/lib/bpf/netlink.c |  2 +-
 tools/lib/bpf/ringbuf.c |  4 ++--
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 64841117fbb2..9181d36118d2 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1350,9 +1350,9 @@ struct btf *btf_get_from_fd(int btf_fd, struct btf *base_btf)
 	void *ptr;
 	int err;
 
-	/* we won't know btf_size until we call bpf_obj_get_info_by_fd(). so
+	/* we won't know btf_size until we call bpf_btf_get_info_by_fd(). so
 	 * let's start with a sane default - 4KiB here - and resize it only if
-	 * bpf_obj_get_info_by_fd() needs a bigger buffer.
+	 * bpf_btf_get_info_by_fd() needs a bigger buffer.
 	 */
 	last_size = 4096;
 	ptr = malloc(last_size);
@@ -1362,7 +1362,7 @@ struct btf *btf_get_from_fd(int btf_fd, struct btf *base_btf)
 	memset(&btf_info, 0, sizeof(btf_info));
 	btf_info.btf = ptr_to_u64(ptr);
 	btf_info.btf_size = last_size;
-	err = bpf_obj_get_info_by_fd(btf_fd, &btf_info, &len);
+	err = bpf_btf_get_info_by_fd(btf_fd, &btf_info, &len);
 
 	if (!err && btf_info.btf_size > last_size) {
 		void *temp_ptr;
@@ -1380,7 +1380,7 @@ struct btf *btf_get_from_fd(int btf_fd, struct btf *base_btf)
 		btf_info.btf = ptr_to_u64(ptr);
 		btf_info.btf_size = last_size;
 
-		err = bpf_obj_get_info_by_fd(btf_fd, &btf_info, &len);
+		err = bpf_btf_get_info_by_fd(btf_fd, &btf_info, &len);
 	}
 
 	if (err || btf_info.btf_size > last_size) {
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 35a698eb825d..05c4db355f28 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4345,7 +4345,7 @@ int bpf_map__reuse_fd(struct bpf_map *map, int fd)
 	char *new_name;
 
 	memset(&info, 0, len);
-	err = bpf_obj_get_info_by_fd(fd, &info, &len);
+	err = bpf_map_get_info_by_fd(fd, &info, &len);
 	if (err && errno == EINVAL)
 		err = bpf_get_map_info_from_fdinfo(fd, &info);
 	if (err)
@@ -4729,7 +4729,7 @@ static int probe_module_btf(void)
 	 * kernel's module BTF support coincides with support for
 	 * name/name_len fields in struct bpf_btf_info.
 	 */
-	err = bpf_obj_get_info_by_fd(fd, &info, &len);
+	err = bpf_btf_get_info_by_fd(fd, &info, &len);
 	close(fd);
 	return !err;
 }
@@ -4892,7 +4892,7 @@ static bool map_is_reuse_compat(const struct bpf_map *map, int map_fd)
 	int err;
 
 	memset(&map_info, 0, map_info_len);
-	err = bpf_obj_get_info_by_fd(map_fd, &map_info, &map_info_len);
+	err = bpf_map_get_info_by_fd(map_fd, &map_info, &map_info_len);
 	if (err && errno == EINVAL)
 		err = bpf_get_map_info_from_fdinfo(map_fd, &map_info);
 	if (err) {
@@ -5437,7 +5437,7 @@ static int load_module_btfs(struct bpf_object *obj)
 		info.name = ptr_to_u64(name);
 		info.name_len = sizeof(name);
 
-		err = bpf_obj_get_info_by_fd(fd, &info, &len);
+		err = bpf_btf_get_info_by_fd(fd, &info, &len);
 		if (err) {
 			err = -errno;
 			pr_warn("failed to get BTF object #%d info: %d\n", id, err);
@@ -9030,9 +9030,9 @@ static int libbpf_find_prog_btf_id(const char *name, __u32 attach_prog_fd)
 	int err;
 
 	memset(&info, 0, info_len);
-	err = bpf_obj_get_info_by_fd(attach_prog_fd, &info, &info_len);
+	err = bpf_prog_get_info_by_fd(attach_prog_fd, &info, &info_len);
 	if (err) {
-		pr_warn("failed bpf_obj_get_info_by_fd for FD %d: %d\n",
+		pr_warn("failed bpf_prog_get_info_by_fd for FD %d: %d\n",
 			attach_prog_fd, err);
 		return err;
 	}
@@ -11741,7 +11741,7 @@ static struct perf_buffer *__perf_buffer__new(int map_fd, size_t page_cnt,
 	/* best-effort sanity checks */
 	memset(&map, 0, sizeof(map));
 	map_info_len = sizeof(map);
-	err = bpf_obj_get_info_by_fd(map_fd, &map, &map_info_len);
+	err = bpf_map_get_info_by_fd(map_fd, &map, &map_info_len);
 	if (err) {
 		err = -errno;
 		/* if BPF_OBJ_GET_INFO_BY_FD is supported, will return
diff --git a/tools/lib/bpf/netlink.c b/tools/lib/bpf/netlink.c
index cb082a04ffa8..1653e7a8b0a1 100644
--- a/tools/lib/bpf/netlink.c
+++ b/tools/lib/bpf/netlink.c
@@ -689,7 +689,7 @@ static int tc_add_fd_and_name(struct libbpf_nla_req *req, int fd)
 	int len, ret;
 
 	memset(&info, 0, info_len);
-	ret = bpf_obj_get_info_by_fd(fd, &info, &info_len);
+	ret = bpf_prog_get_info_by_fd(fd, &info, &info_len);
 	if (ret < 0)
 		return ret;
 
diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
index 47855af25f3b..02199364db13 100644
--- a/tools/lib/bpf/ringbuf.c
+++ b/tools/lib/bpf/ringbuf.c
@@ -83,7 +83,7 @@ int ring_buffer__add(struct ring_buffer *rb, int map_fd,
 
 	memset(&info, 0, sizeof(info));
 
-	err = bpf_obj_get_info_by_fd(map_fd, &info, &len);
+	err = bpf_map_get_info_by_fd(map_fd, &info, &len);
 	if (err) {
 		err = -errno;
 		pr_warn("ringbuf: failed to get map info for fd=%d: %d\n",
@@ -359,7 +359,7 @@ static int user_ringbuf_map(struct user_ring_buffer *rb, int map_fd)
 
 	memset(&info, 0, sizeof(info));
 
-	err = bpf_obj_get_info_by_fd(map_fd, &info, &len);
+	err = bpf_map_get_info_by_fd(map_fd, &info, &len);
 	if (err) {
 		err = -errno;
 		pr_warn("user ringbuf: failed to get map info for fd=%d: %d\n", map_fd, err);
-- 
2.39.1

