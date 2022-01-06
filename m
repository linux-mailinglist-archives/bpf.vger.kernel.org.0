Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A30486AD2
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 21:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243560AbiAFUDc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jan 2022 15:03:32 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:37234 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S243552AbiAFUDb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 6 Jan 2022 15:03:31 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 206HV9va021652
        for <bpf@vger.kernel.org>; Thu, 6 Jan 2022 12:03:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=OCzB++jq5wbxY7UmBuL438Y58HZYnxkiX0UWFaLHpts=;
 b=jGheaivWUuLnT9pA3JrEthdABFBQi+q0dwYNmcmD4yTAXRZPSKyukczFk1QWM/66bDlb
 qIlSyghJavZJ2VEeNiy0YbQCkaOIFMtzj7ETcaGZmD6YxamYqvgQ1PfqG7VqVJIVgWRC
 OFr3JE+yvpAzyxLnULefeE4n94KUgvZ3f0Q= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3de4w2s1tf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 06 Jan 2022 12:03:30 -0800
Received: from twshared10140.39.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 6 Jan 2022 12:03:29 -0800
Received: by devbig921.prn2.facebook.com (Postfix, from userid 132113)
        id 95EF915AB151; Thu,  6 Jan 2022 12:00:44 -0800 (PST)
From:   Christy Lee <christylee@fb.com>
To:     <andrii@kernel.org>, <acme@kernel.org>, <jolsa@redhat.com>
CC:     <christylee@fb.com>, <christyc.y.lee@gmail.com>,
        <bpf@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <kernel-team@fb.com>, <wangnan0@huawei.com>,
        <bobo.shaobowang@huawei.com>, <yuehaibing@huawei.com>
Subject: [PATCH bpf-next v2 2/2] perf: stop using deprecated bpf__object_next() API
Date:   Thu, 6 Jan 2022 12:00:32 -0800
Message-ID: <20220106200032.3067127-3-christylee@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220106200032.3067127-1-christylee@fb.com>
References: <20220106200032.3067127-1-christylee@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 0iSm33h_LgL2Kb4hHutzJcDrtUuEcL2m
X-Proofpoint-ORIG-GUID: 0iSm33h_LgL2Kb4hHutzJcDrtUuEcL2m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-06_08,2022-01-06_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201060126
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Previously libbpf maintained a list of bpf_objects, and bpf_objects
can be added to the list via bpf__object__next() API. Libbpf has
deprecated the ability to keep track of object list inside libbpf,
so we need to hoist the tracking logic to perf.

Committer note:

This is tested by following the committer's note in the original commit
"aa3abf30bb28addcf593578d37447d42e3f65fc3".

I ran 'perf test -v LLVM' and used it's output to generate a script for
compiling the perf test object:

--------------------------------------------------
$ cat ~/bin/hello-ebpf
INPUT_FILE=3D/tmp/test.c
OUTPUT_FILE=3D/tmp/test.o

export KBUILD_DIR=3D/lib/modules/5.12.0-0_fbk2_3390_g7ecb4ac46d7f/build
export NR_CPUS=3D56
export LINUX_VERSION_CODE=3D0x50c00
export CLANG_EXEC=3D/data/users/christylee/devtools/llvm/latest/bin/clang
export CLANG_OPTIONS=3D-xc
export KERNEL_INC_OPTIONS=3D"KERNEL_INC_OPTIONS=3D -nostdinc \
-isystem /usr/lib/gcc/x86_64-redhat-linux/8/include -I./arch/x86/include =
\
-I./arch/x86/include/generated  -I./include -I./arch/x86/include/uapi \
-I./arch/x86/include/generated/uapi -I./include/uapi \
-I./include/generated/uapi -include ./include/linux/compiler-version.h \
-include ./include/linux/kconfig.h"
export PERF_BPF_INC_OPTIONS=3D-I/usr/lib/perf/include/bpf
export WORKING_DIR=3D/lib/modules/5.12.0-0_fbk2_3390_g7ecb4ac46d7f/build
export CLANG_SOURCE=3D-

rm -f $OUTPUT_FILE
cat $INPUT_FILE | /data/users/christylee/devtools/llvm/latest/bin/clang \
-D__KERNEL__ -D__NR_CPUS__=3D56 -DLINUX_VERSION_CODE=3D0x50c00 -xc  \
-I/usr/lib/perf/include/bpf -nostdinc \
-isystem /usr/lib/gcc/x86_64-redhat-linux/8/include -I./arch/x86/include =
\
-I./arch/x86/include/generated  -I./include -I./arch/x86/include/uapi \
-I./arch/x86/include/generated/uapi -I./include/uapi \
-I./include/generated/uapi -include ./include/linux/compiler-version.h \
-include ./include/linux/kconfig.h -Wno-unused-value -Wno-pointer-sign \
-working-directory /lib/modules/5.12.0-0_fbk2_3390_g7ecb4ac46d7f/build \
-c - -target bpf -O2 -o $OUTPUT_FILE
--------------------------------------------------

I then wrote and compiled a script that ask to get asks to put a probe
at a function that
does not exists in the kernel, it errors out as expected:

$ cat /tmp/test.c
__attribute__((section("probe_point=3Dnot_exist"), used))
int probe_point(void *ctx) {
    return 0;
}
char _license[] __attribute__((section("license"), used)) =3D "GPL";
int _version __attribute__((section("version"), used)) =3D 0x40100;

$ cd ~/bin && ./hello-ebpf
$ ./perf record --event /tmp/test.o sleep 1

Using perf wrapper that supports hot-text. Try perf.real if you
encounter any issues.
Probe point 'not_exist' not found.
event syntax error: '/tmp/test.o'
                     \___ You need to check probing points in BPF file

(add -v to see detail)
Run 'perf list' for a list of valid events

 Usage: perf record [<options>] [<command>]
    or: perf record [<options>] -- <command> [<options>]

    -e, --event <event>   event selector. use 'perf list' to list
available events

---------------------------------------------------

Next I changed the attribute to something that exists in the kernel.
As expected, it errors out
with permission problem:
$ cat /tmp/test.c
__attribute__((section("probe_point=3Dkernel_execve"), used))
int probe_point(void *ctx) {
    return 0;
}
char _license[] __attribute__((section("license"), used)) =3D "GPL";
int _version __attribute__((section("version"), used)) =3D 0x40100;

$ grep kernel_execve /proc/kallsyms
ffffffff812dc210 T kernel_execve

$ cd ~/bin && ./hello-ebpf
$ ./perf record --event /tmp/test.o sleep 1

Using perf wrapper that supports hot-text. Try perf.real if you
encounter any issues.
Failed to open kprobe_events: Permission denied
event syntax error: '/tmp/test.o'
                     \___ You need to be root

(add -v to see detail)
Run 'perf list' for a list of valid events

 Usage: perf record [<options>] [<command>]
    or: perf record [<options>] -- <command> [<options>]

    -e, --event <event>   event selector. use 'perf list' to list
available events

---------------------------------------------------

Reran as root, see that the probe point worked as intended.

$ sudo -i
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.018 MB perf.data ]
perf_bpf_probe:probe_point
perf_bpf_probe:probe_point: type: 2, size: 128, config: 0x8e9, \
{ sample_period, sample_freq }: 1, \
sample_type: IP|TID|TIME|CPU|PERIOD|RAW, read_format: ID, disabled: 1, \
inherit: 1, mmap: 1, comm: 1, enable_on_exec: 1, task: 1, \
sample_id_all: 1, exclude_guest: 1, mmap2: 1, comm_exec: 1, ksymbol: 1, \
bpf_event: 1

---------------------------------------------------

Signed-off-by: Christy Lee <christylee@fb.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/perf/util/bpf-loader.c | 72 +++++++++++++++++++++++++++---------
 tools/perf/util/bpf-loader.h |  1 +
 2 files changed, 55 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 528aeb0ab79d..9e3988fd719a 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -29,9 +29,6 @@
=20
 #include <internal/xyarray.h>
=20
-/* temporarily disable libbpf deprecation warnings */
-#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
-
 static int libbpf_perf_print(enum libbpf_print_level level __attribute__=
((unused)),
 			      const char *fmt, va_list args)
 {
@@ -49,6 +46,36 @@ struct bpf_prog_priv {
 	int *type_mapping;
 };
=20
+struct bpf_perf_object {
+	struct bpf_object *obj;
+	struct list_head list;
+};
+
+static LIST_HEAD(bpf_objects_list);
+
+struct bpf_perf_object *bpf_perf_object__next(struct bpf_perf_object *pr=
ev)
+{
+	struct bpf_perf_object *next;
+
+	if (!prev)
+		next =3D list_first_entry(&bpf_objects_list,
+					struct bpf_perf_object, list);
+	else
+		next =3D list_next_entry(prev, list);
+
+	/* Empty list is noticed here so don't need checking on entry. */
+	if (&next->list =3D=3D &bpf_objects_list)
+		return NULL;
+
+	return next;
+}
+
+#define bpf_perf_object__for_each(perf_obj, tmp, obj)                   =
       \
+	for ((perf_obj) =3D bpf_perf_object__next(NULL),                       =
  \
+	    (tmp) =3D bpf_perf_object__next(perf_obj), (obj) =3D NULL;         =
    \
+	     (perf_obj) !=3D NULL; (perf_obj) =3D (tmp),                       =
    \
+	    (tmp) =3D bpf_perf_object__next(tmp), (obj) =3D (perf_obj)->obj)
+
 static bool libbpf_initialized;
=20
 struct bpf_object *
@@ -113,9 +140,10 @@ struct bpf_object *bpf__prepare_load(const char *fil=
ename, bool source)
=20
 void bpf__clear(void)
 {
-	struct bpf_object *obj, *tmp;
+	struct bpf_perf_object *perf_obj, *tmp;
+	struct bpf_object *obj;
=20
-	bpf_object__for_each_safe(obj, tmp) {
+	bpf_perf_object__for_each(perf_obj, tmp, obj) {
 		bpf__unprobe(obj);
 		bpf_object__close(obj);
 	}
@@ -621,8 +649,12 @@ static int hook_load_preprocessor(struct bpf_program=
 *prog)
 	if (err)
 		return err;
=20
+/* temporarily disable libbpf deprecation warnings */
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
 	err =3D bpf_program__set_prep(prog, priv->nr_types,
 				    preproc_gen_prologue);
+#pragma GCC diagnostic pop
 	return err;
 }
=20
@@ -776,7 +808,11 @@ int bpf__foreach_event(struct bpf_object *obj,
 			if (priv->need_prologue) {
 				int type =3D priv->type_mapping[i];
=20
+/* temporarily disable libbpf deprecation warnings */
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
 				fd =3D bpf_program__nth_fd(prog, type);
+#pragma GCC diagnostic pop
 			} else {
 				fd =3D bpf_program__fd(prog);
 			}
@@ -1498,10 +1534,11 @@ apply_obj_config_object(struct bpf_object *obj)
=20
 int bpf__apply_obj_config(void)
 {
-	struct bpf_object *obj, *tmp;
+	struct bpf_perf_object *perf_obj, *tmp;
+	struct bpf_object *obj;
 	int err;
=20
-	bpf_object__for_each_safe(obj, tmp) {
+	bpf_perf_object__for_each(perf_obj, tmp, obj) {
 		err =3D apply_obj_config_object(obj);
 		if (err)
 			return err;
@@ -1510,26 +1547,25 @@ int bpf__apply_obj_config(void)
 	return 0;
 }
=20
-#define bpf__for_each_map(pos, obj, objtmp)	\
-	bpf_object__for_each_safe(obj, objtmp)	\
-		bpf_object__for_each_map(pos, obj)
+#define bpf__perf_for_each_map(perf_obj, tmp, obj, map)                 =
       \
+	bpf_perf_object__for_each(perf_obj, tmp, obj)                          =
\
+		bpf_object__for_each_map(map, obj)
=20
-#define bpf__for_each_map_named(pos, obj, objtmp, name)	\
-	bpf__for_each_map(pos, obj, objtmp) 		\
-		if (bpf_map__name(pos) && 		\
-			(strcmp(name, 			\
-				bpf_map__name(pos)) =3D=3D 0))
+#define bpf__perf_for_each_map_named(perf_obj, tmp, obj, map, name)     =
       \
+	bpf__perf_for_each_map(perf_obj, tmp, obj, map)                        =
\
+		if (bpf_map__name(map) && (strcmp(name, bpf_map__name(map)) =3D=3D 0))
=20
 struct evsel *bpf__setup_output_event(struct evlist *evlist, const char =
*name)
 {
 	struct bpf_map_priv *tmpl_priv =3D NULL;
-	struct bpf_object *obj, *tmp;
+	struct bpf_perf_object *perf_obj, *tmp;
+	struct bpf_object *obj;
 	struct evsel *evsel =3D NULL;
 	struct bpf_map *map;
 	int err;
 	bool need_init =3D false;
=20
-	bpf__for_each_map_named(map, obj, tmp, name) {
+	bpf__perf_for_each_map_named(perf_obj, tmp, obj, map, name) {
 		struct bpf_map_priv *priv =3D bpf_map__priv(map);
=20
 		if (IS_ERR(priv))
@@ -1565,7 +1601,7 @@ struct evsel *bpf__setup_output_event(struct evlist=
 *evlist, const char *name)
 		evsel =3D evlist__last(evlist);
 	}
=20
-	bpf__for_each_map_named(map, obj, tmp, name) {
+	bpf__perf_for_each_map_named(perf_obj, tmp, obj, map, name) {
 		struct bpf_map_priv *priv =3D bpf_map__priv(map);
=20
 		if (IS_ERR(priv))
diff --git a/tools/perf/util/bpf-loader.h b/tools/perf/util/bpf-loader.h
index 5d1c725cea29..95262b7e936f 100644
--- a/tools/perf/util/bpf-loader.h
+++ b/tools/perf/util/bpf-loader.h
@@ -53,6 +53,7 @@ typedef int (*bpf_prog_iter_callback_t)(const char *gro=
up, const char *event,
=20
 #ifdef HAVE_LIBBPF_SUPPORT
 struct bpf_object *bpf__prepare_load(const char *filename, bool source);
+struct bpf_perf_object *bpf_perf_object__next(struct bpf_perf_object *pr=
ev);
 int bpf__strerror_prepare_load(const char *filename, bool source,
 			       int err, char *buf, size_t size);
=20
--=20
2.30.2

