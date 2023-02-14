Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F81269719B
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 00:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbjBNXM7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Feb 2023 18:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbjBNXM4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Feb 2023 18:12:56 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E266A271
        for <bpf@vger.kernel.org>; Tue, 14 Feb 2023 15:12:53 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31ELjtWh027876;
        Tue, 14 Feb 2023 23:12:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=HCaz2I83FjHUVnYK+ML/WLIQQNmHdDgfk3utS2mzK7g=;
 b=jZw9l+/wyBloEF1xzX4gs+IhiSjIE51fPB/mattGlBUJVhGUps3kHeNMURD9E1Il9pQI
 cz6LLhwEcCgR7+W0LzXj1fEN42jcb1r/TLH/NZZJJAyCTxFw0uprmFmHI+GkSBq0I71c
 wyJnUG5EDax+l9I2E4ikuhGe+S+FUi8AD6ZSgkpjdGeTQm6IZgbJLCYsRaNpSiRky2fP
 5+xSHmczkogPPqT2zPsZjP3OCLHGO1ySjTe48y142G3sEc8TSBL4QVLTkUl2SSZz+SsY
 hRSYmjPgnqY3FiEF+mXhLrgqJi4Qb89S/cJfOCCdPnePzNOy9LuSMboz6QNiQStvDSWs mA== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nrh2c56c6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 23:12:37 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31E77CEP008616;
        Tue, 14 Feb 2023 23:12:30 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3np2n6be15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 23:12:30 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31ENCQHT46006560
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Feb 2023 23:12:26 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E03620040;
        Tue, 14 Feb 2023 23:12:26 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF82120043;
        Tue, 14 Feb 2023 23:12:25 +0000 (GMT)
Received: from heavy.lan (unknown [9.171.53.135])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 14 Feb 2023 23:12:25 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v3 2/8] libbpf: Use bpf_{btf,link,map,prog}_get_info_by_fd()
Date:   Wed, 15 Feb 2023 00:12:15 +0100
Message-Id: <20230214231221.249277-3-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230214231221.249277-1-iii@linux.ibm.com>
References: <20230214231221.249277-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IB1dxYGg-HjCu1B7PIASdGO5yf_AaSYX
X-Proofpoint-ORIG-GUID: IB1dxYGg-HjCu1B7PIASdGO5yf_AaSYX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_15,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 impostorscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 phishscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140198
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

