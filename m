Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBACD468D40
	for <lists+bpf@lfdr.de>; Sun,  5 Dec 2021 21:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238456AbhLEUgV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sun, 5 Dec 2021 15:36:21 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:15836 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238658AbhLEUgU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 5 Dec 2021 15:36:20 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B59WPh6031816
        for <bpf@vger.kernel.org>; Sun, 5 Dec 2021 12:32:52 -0800
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3crqwjtqh0-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 05 Dec 2021 12:32:52 -0800
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sun, 5 Dec 2021 12:32:51 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 2E43BBFD779C; Sun,  5 Dec 2021 12:32:42 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 02/11] libbpf: allow passing preallocated log_buf when loading BTF into kernel
Date:   Sun, 5 Dec 2021 12:32:25 -0800
Message-ID: <20211205203234.1322242-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211205203234.1322242-1-andrii@kernel.org>
References: <20211205203234.1322242-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: AKa4zCKibDLZSiyXHd1N4s2Ish2NhoKG
X-Proofpoint-ORIG-GUID: AKa4zCKibDLZSiyXHd1N4s2Ish2NhoKG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-05_10,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 spamscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112050123
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add libbpf-internal btf_load_into_kernel() that allows to pass
preallocated log_buf and custom log_level to be passed into kernel
during BPF_BTF_LOAD call. When custom log_buf is provided,
btf_load_into_kernel() won't attempt an retry with automatically
allocated internal temporary buffer to capture BTF validation log.

It's important to note the relation between log_buf and log_level, which
slightly deviates from stricter kernel logic. From kernel's POV, if
log_buf is specified, log_level has to be > 0, and vice versa. While
kernel has good reasons to request such "sanity, this, in practice, is
a bit unconvenient and restrictive for libbpf's high-level bpf_object APIs.

So libbpf will allow to set non-NULL log_buf and log_level == 0. This is
fine and means to attempt to load BTF without logging requested, but if
it failes, retry the load with custom log_buf and log_level 1. Similar
logic will be implemented for program loading. In practice this means
that users can provide custom log buffer just in case error happens, but
not really request slower verbose logging all the time. This is also
consistent with libbpf behavior when custom log_buf is not set: libbpf
first tries to load everything with log_level=0, and only if error
happens allocates internal log buffer and retries with log_level=1.

Also, while at it, make BTF validation log more obvious and follow the log
pattern libbpf is using for dumping BPF verifier log during
BPF_PROG_LOAD. BTF loading resulting in an error will look like this:

libbpf: BTF loading error: -22
libbpf: -- BEGIN BTF LOAD LOG ---
magic: 0xeb9f
version: 1
flags: 0x0
hdr_len: 24
type_off: 0
type_len: 1040
str_off: 1040
str_len: 2063598257
btf_total_size: 1753
Total section length too long
-- END BTF LOAD LOG --
libbpf: Error loading .BTF into kernel: -22. BTF is optional, ignoring.

This makes it much easier to find relevant parts in libbpf log output.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/btf.c             | 78 +++++++++++++++++++++++----------
 tools/lib/bpf/libbpf_internal.h |  1 +
 2 files changed, 56 insertions(+), 23 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 0d7b16eab569..b0d08a28b260 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1124,54 +1124,86 @@ struct btf *btf__parse_split(const char *path, struct btf *base_btf)
 
 static void *btf_get_raw_data(const struct btf *btf, __u32 *size, bool swap_endian);
 
-int btf__load_into_kernel(struct btf *btf)
+int btf_load_into_kernel(struct btf *btf, char *log_buf, size_t log_sz, __u32 log_level)
 {
-	__u32 log_buf_size = 0, raw_size;
-	char *log_buf = NULL;
+	LIBBPF_OPTS(bpf_btf_load_opts, opts);
+	__u32 buf_sz = 0, raw_size;
+	char *buf = NULL, *tmp;
 	void *raw_data;
 	int err = 0;
 
 	if (btf->fd >= 0)
 		return libbpf_err(-EEXIST);
+	if (log_sz && !log_buf)
+		return libbpf_err(-EINVAL);
 
-retry_load:
-	if (log_buf_size) {
-		log_buf = malloc(log_buf_size);
-		if (!log_buf)
-			return libbpf_err(-ENOMEM);
-
-		*log_buf = 0;
-	}
-
+	/* cache native raw data representation */
 	raw_data = btf_get_raw_data(btf, &raw_size, false);
 	if (!raw_data) {
 		err = -ENOMEM;
 		goto done;
 	}
-	/* cache native raw data representation */
 	btf->raw_size = raw_size;
 	btf->raw_data = raw_data;
 
-	btf->fd = bpf_load_btf(raw_data, raw_size, log_buf, log_buf_size, false);
+retry_load:
+	/* if log_level is 0, we won't provide log_buf/log_size to the kernel,
+	 * initially. Only if BTF loading fails, we bump log_level to 1 and
+	 * retry, using either auto-allocated or custom log_buf. This way
+	 * non-NULL custom log_buf provides a buffer just in case, but hopes
+	 * for successful load and no need for log_buf.
+	 */
+	if (log_level) {
+		/* if caller didn't provide custom log_buf, we'll keep
+		 * allocating our own progressively bigger buffers for BTF
+		 * verification log
+		 */
+		if (!log_buf) {
+			buf_sz = max((__u32)BPF_LOG_BUF_SIZE, buf_sz * 2);
+			tmp = realloc(buf, buf_sz);
+			if (!tmp) {
+				err = -ENOMEM;
+				goto done;
+			}
+			buf = tmp;
+			buf[0] = '\0';
+		}
+
+		opts.log_buf = log_buf ? log_buf : buf;
+		opts.log_size = log_buf ? log_sz : buf_sz;
+		opts.log_level = log_level;
+	}
+
+	btf->fd = bpf_btf_load(raw_data, raw_size, &opts);
 	if (btf->fd < 0) {
-		if (!log_buf || errno == ENOSPC) {
-			log_buf_size = max((__u32)BPF_LOG_BUF_SIZE,
-					   log_buf_size << 1);
-			free(log_buf);
+		/* time to turn on verbose mode and try again */
+		if (log_level == 0) {
+			log_level = 1;
 			goto retry_load;
 		}
+		/* only retry if caller didn't provide custom log_buf, but
+		 * make sure we can never overflow buf_sz
+		 */
+		if (!log_buf && errno == ENOSPC && buf_sz < UINT_MAX / 2)
+			goto retry_load;
 
 		err = -errno;
-		pr_warn("Error loading BTF: %s(%d)\n", strerror(errno), errno);
-		if (*log_buf)
-			pr_warn("%s\n", log_buf);
-		goto done;
+		pr_warn("BTF loading error: %d\n", err);
+		/* don't print out contents of custom log_buf */
+		if (!log_buf && buf[0])
+			pr_warn("-- BEGIN BTF LOAD LOG ---\n%s\n-- END BTF LOAD LOG --\n", buf);
 	}
 
 done:
-	free(log_buf);
+	free(buf);
 	return libbpf_err(err);
 }
+
+int btf__load_into_kernel(struct btf *btf)
+{
+	return btf_load_into_kernel(btf, NULL, 0, 0);
+}
+
 int btf__load(struct btf *) __attribute__((alias("btf__load_into_kernel")));
 
 int btf__fd(const struct btf *btf)
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 6f143e9e810c..355c41019aed 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -277,6 +277,7 @@ int parse_cpu_mask_str(const char *s, bool **mask, int *mask_sz);
 int parse_cpu_mask_file(const char *fcpu, bool **mask, int *mask_sz);
 int libbpf__load_raw_btf(const char *raw_types, size_t types_len,
 			 const char *str_sec, size_t str_len);
+int btf_load_into_kernel(struct btf *btf, char *log_buf, size_t log_sz, __u32 log_level);
 
 struct btf *btf_get_from_fd(int btf_fd, struct btf *base_btf);
 void btf_get_kernel_prefix_kind(enum bpf_attach_type attach_type,
-- 
2.30.2

