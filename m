Return-Path: <bpf+bounces-15250-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CAD07EF6D6
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 18:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4124BB209AD
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 17:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FB53D3BB;
	Fri, 17 Nov 2023 17:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF429D68
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 09:14:26 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AHF5nTH026654
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 09:14:26 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ue785t72s-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 09:14:25 -0800
Received: from twshared29647.38.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 17 Nov 2023 09:14:23 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id B78EC3BACE23E; Fri, 17 Nov 2023 09:14:08 -0800 (PST)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH bpf-next] bpf: rename BPF_F_TEST_SANITY_STRICT to BPF_F_TEST_REG_INVARIANTS
Date: Fri, 17 Nov 2023 09:14:04 -0800
Message-ID: <20231117171404.225508-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 472kOJaB90SBA0iHakOyUn9jgy4oNqMf
X-Proofpoint-GUID: 472kOJaB90SBA0iHakOyUn9jgy4oNqMf
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_16,2023-11-17_01,2023-05-22_02

Rename verifier internal flag BPF_F_TEST_SANITY_STRICT to more neutral
BPF_F_TEST_REG_INVARIANTS. This is a follow up to [0].

A few selftests and veristat need to be adjusted in the same patch as
well.

  [0] https://patchwork.kernel.org/project/netdevbpf/patch/20231112010609.8=
48406-5-andrii@kernel.org/

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/bpf_verifier.h                         |  2 +-
 include/uapi/linux/bpf.h                             |  2 +-
 kernel/bpf/syscall.c                                 |  2 +-
 kernel/bpf/verifier.c                                |  6 +++---
 tools/include/uapi/linux/bpf.h                       |  2 +-
 .../selftests/bpf/prog_tests/bpf_verif_scale.c       |  2 +-
 tools/testing/selftests/bpf/prog_tests/reg_bounds.c  |  2 +-
 tools/testing/selftests/bpf/progs/verifier_bounds.c  |  4 ++--
 tools/testing/selftests/bpf/test_loader.c            |  6 +++---
 tools/testing/selftests/bpf/test_sock_addr.c         |  3 +--
 tools/testing/selftests/bpf/test_verifier.c          |  2 +-
 tools/testing/selftests/bpf/testing_helpers.c        |  4 ++--
 tools/testing/selftests/bpf/veristat.c               | 12 ++++++------
 13 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 402b6bc44a1b..52a4012b8255 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -602,7 +602,7 @@ struct bpf_verifier_env {
 	int stack_size;			/* number of states to be processed */
 	bool strict_alignment;		/* perform strict pointer alignment checks */
 	bool test_state_freq;		/* test verifier with different pruning frequency =
*/
-	bool test_sanity_strict;	/* fail verification on sanity violations */
+	bool test_reg_invariants;	/* fail verification on register invariants vio=
lations */
 	struct bpf_verifier_state *cur_state; /* current verifier state */
 	struct bpf_verifier_state_list **explored_states; /* search pruning optim=
ization */
 	struct bpf_verifier_state_list *free_list;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 8a5855fcee69..7a5498242eaa 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1201,7 +1201,7 @@ enum bpf_perf_event_type {
 #define BPF_F_XDP_DEV_BOUND_ONLY	(1U << 6)
=20
 /* The verifier internal test flag. Behavior is undefined */
-#define BPF_F_TEST_SANITY_STRICT	(1U << 7)
+#define BPF_F_TEST_REG_INVARIANTS	(1U << 7)
=20
 /* link_create.kprobe_multi.flags used in LINK_CREATE command for
  * BPF_TRACE_KPROBE_MULTI attach type to create return probe.
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index f266e03ba342..5e43ddd1b83f 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2574,7 +2574,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr=
_t uattr, u32 uattr_size)
 				 BPF_F_TEST_RND_HI32 |
 				 BPF_F_XDP_HAS_FRAGS |
 				 BPF_F_XDP_DEV_BOUND_ONLY |
-				 BPF_F_TEST_SANITY_STRICT))
+				 BPF_F_TEST_REG_INVARIANTS))
 		return -EINVAL;
=20
 	if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) &&
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 59505881e7a7..7c3461b89513 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2608,14 +2608,14 @@ static int reg_bounds_sanity_check(struct bpf_verif=
ier_env *env,
=20
 	return 0;
 out:
-	verbose(env, "REG SANITY VIOLATION (%s): %s u64=3D[%#llx, %#llx] "
+	verbose(env, "REG INVARIANTS VIOLATION (%s): %s u64=3D[%#llx, %#llx] "
 		"s64=3D[%#llx, %#llx] u32=3D[%#x, %#x] s32=3D[%#x, %#x] var_off=3D(%#llx=
, %#llx)\n",
 		ctx, msg, reg->umin_value, reg->umax_value,
 		reg->smin_value, reg->smax_value,
 		reg->u32_min_value, reg->u32_max_value,
 		reg->s32_min_value, reg->s32_max_value,
 		reg->var_off.value, reg->var_off.mask);
-	if (env->test_sanity_strict)
+	if (env->test_reg_invariants)
 		return -EFAULT;
 	__mark_reg_unbounded(reg);
 	return 0;
@@ -20791,7 +20791,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_att=
r *attr, bpfptr_t uattr, __u3
=20
 	if (is_priv)
 		env->test_state_freq =3D attr->prog_flags & BPF_F_TEST_STATE_FREQ;
-	env->test_sanity_strict =3D attr->prog_flags & BPF_F_TEST_SANITY_STRICT;
+	env->test_reg_invariants =3D attr->prog_flags & BPF_F_TEST_REG_INVARIANTS;
=20
 	env->explored_states =3D kvcalloc(state_htab_size(env),
 				       sizeof(struct bpf_verifier_state_list *),
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 8a5855fcee69..7a5498242eaa 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1201,7 +1201,7 @@ enum bpf_perf_event_type {
 #define BPF_F_XDP_DEV_BOUND_ONLY	(1U << 6)
=20
 /* The verifier internal test flag. Behavior is undefined */
-#define BPF_F_TEST_SANITY_STRICT	(1U << 7)
+#define BPF_F_TEST_REG_INVARIANTS	(1U << 7)
=20
 /* link_create.kprobe_multi.flags used in LINK_CREATE command for
  * BPF_TRACE_KPROBE_MULTI attach type to create return probe.
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c b/too=
ls/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
index 3f2d70831873..e770912fc1d2 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
@@ -35,7 +35,7 @@ static int check_load(const char *file, enum bpf_prog_typ=
e type)
 	}
=20
 	bpf_program__set_type(prog, type);
-	bpf_program__set_flags(prog, BPF_F_TEST_RND_HI32 | BPF_F_TEST_SANITY_STRI=
CT);
+	bpf_program__set_flags(prog, BPF_F_TEST_RND_HI32 | BPF_F_TEST_REG_INVARIA=
NTS);
 	bpf_program__set_log_level(prog, 4 | extra_prog_load_log_flags);
=20
 	err =3D bpf_object__load(obj);
diff --git a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c b/tools/te=
sting/selftests/bpf/prog_tests/reg_bounds.c
index fe0cb906644b..7a8b0bf0a7f8 100644
--- a/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
+++ b/tools/testing/selftests/bpf/prog_tests/reg_bounds.c
@@ -838,7 +838,7 @@ static int load_range_cmp_prog(struct range x, struct r=
ange y, enum op op,
 		.log_level =3D 2,
 		.log_buf =3D log_buf,
 		.log_size =3D log_sz,
-		.prog_flags =3D BPF_F_TEST_SANITY_STRICT,
+		.prog_flags =3D BPF_F_TEST_REG_INVARIANTS,
 	);
=20
 	/* ; skip exit block below
diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/te=
sting/selftests/bpf/progs/verifier_bounds.c
index 0c1460936373..ec430b71730b 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -965,7 +965,7 @@ l0_%=3D:	r0 =3D 0;						\
 SEC("xdp")
 __description("bound check with JMP_JSLT for crossing 64-bit signed bounda=
ry")
 __success __retval(0)
-__flag(!BPF_F_TEST_SANITY_STRICT) /* known sanity violation */
+__flag(!BPF_F_TEST_REG_INVARIANTS) /* known invariants violation */
 __naked void crossing_64_bit_signed_boundary_2(void)
 {
 	asm volatile ("					\
@@ -1047,7 +1047,7 @@ l0_%=3D:	r0 =3D 0;						\
 SEC("xdp")
 __description("bound check with JMP32_JSLT for crossing 32-bit signed boun=
dary")
 __success __retval(0)
-__flag(!BPF_F_TEST_SANITY_STRICT) /* known sanity violation */
+__flag(!BPF_F_TEST_REG_INVARIANTS) /* known invariants violation */
 __naked void crossing_32_bit_signed_boundary_2(void)
 {
 	asm volatile ("					\
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/self=
tests/bpf/test_loader.c
index 57e27b1a73a6..a350ecdfba4a 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -179,7 +179,7 @@ static int parse_test_spec(struct test_loader *tester,
 	memset(spec, 0, sizeof(*spec));
=20
 	spec->prog_name =3D bpf_program__name(prog);
-	spec->prog_flags =3D BPF_F_TEST_SANITY_STRICT; /* by default be strict */
+	spec->prog_flags =3D BPF_F_TEST_REG_INVARIANTS; /* by default be strict */
=20
 	btf =3D bpf_object__btf(obj);
 	if (!btf) {
@@ -280,8 +280,8 @@ static int parse_test_spec(struct test_loader *tester,
 				update_flags(&spec->prog_flags, BPF_F_SLEEPABLE, clear);
 			} else if (strcmp(val, "BPF_F_XDP_HAS_FRAGS") =3D=3D 0) {
 				update_flags(&spec->prog_flags, BPF_F_XDP_HAS_FRAGS, clear);
-			} else if (strcmp(val, "BPF_F_TEST_SANITY_STRICT") =3D=3D 0) {
-				update_flags(&spec->prog_flags, BPF_F_TEST_SANITY_STRICT, clear);
+			} else if (strcmp(val, "BPF_F_TEST_REG_INVARIANTS") =3D=3D 0) {
+				update_flags(&spec->prog_flags, BPF_F_TEST_REG_INVARIANTS, clear);
 			} else /* assume numeric value */ {
 				err =3D parse_int(val, &flags, "test prog flags");
 				if (err)
diff --git a/tools/testing/selftests/bpf/test_sock_addr.c b/tools/testing/s=
elftests/bpf/test_sock_addr.c
index 878c077e0fa7..b0068a9d2cfe 100644
--- a/tools/testing/selftests/bpf/test_sock_addr.c
+++ b/tools/testing/selftests/bpf/test_sock_addr.c
@@ -679,8 +679,7 @@ static int load_path(const struct sock_addr_test *test,=
 const char *path)
=20
 	bpf_program__set_type(prog, BPF_PROG_TYPE_CGROUP_SOCK_ADDR);
 	bpf_program__set_expected_attach_type(prog, test->expected_attach_type);
-	bpf_program__set_flags(prog, BPF_F_TEST_RND_HI32);
-	bpf_program__set_flags(prog, BPF_F_TEST_SANITY_STRICT);
+	bpf_program__set_flags(prog, BPF_F_TEST_RND_HI32 | BPF_F_TEST_REG_INVARIA=
NTS);
=20
 	err =3D bpf_object__load(obj);
 	if (err) {
diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/se=
lftests/bpf/test_verifier.c
index 4992022f3137..f36e41435be7 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -1588,7 +1588,7 @@ static void do_test_single(struct bpf_test *test, boo=
l unpriv,
 	if (fixup_skips !=3D skips)
 		return;
=20
-	pflags =3D BPF_F_TEST_RND_HI32 | BPF_F_TEST_SANITY_STRICT;
+	pflags =3D BPF_F_TEST_RND_HI32 | BPF_F_TEST_REG_INVARIANTS;
 	if (test->flags & F_LOAD_WITH_STRICT_ALIGNMENT)
 		pflags |=3D BPF_F_STRICT_ALIGNMENT;
 	if (test->flags & F_NEEDS_EFFICIENT_UNALIGNED_ACCESS)
diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/=
selftests/bpf/testing_helpers.c
index 9786a94a666c..d2458c1b1671 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -276,7 +276,7 @@ int bpf_prog_test_load(const char *file, enum bpf_prog_=
type type,
 	if (type !=3D BPF_PROG_TYPE_UNSPEC && bpf_program__type(prog) !=3D type)
 		bpf_program__set_type(prog, type);
=20
-	flags =3D bpf_program__flags(prog) | BPF_F_TEST_RND_HI32 | BPF_F_TEST_SAN=
ITY_STRICT;
+	flags =3D bpf_program__flags(prog) | BPF_F_TEST_RND_HI32 | BPF_F_TEST_REG=
_INVARIANTS;
 	bpf_program__set_flags(prog, flags);
=20
 	err =3D bpf_object__load(obj);
@@ -299,7 +299,7 @@ int bpf_test_load_program(enum bpf_prog_type type, cons=
t struct bpf_insn *insns,
 {
 	LIBBPF_OPTS(bpf_prog_load_opts, opts,
 		.kern_version =3D kern_version,
-		.prog_flags =3D BPF_F_TEST_RND_HI32 | BPF_F_TEST_SANITY_STRICT,
+		.prog_flags =3D BPF_F_TEST_RND_HI32 | BPF_F_TEST_REG_INVARIANTS,
 		.log_level =3D extra_prog_load_log_flags,
 		.log_buf =3D log_buf,
 		.log_size =3D log_buf_sz,
diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftes=
ts/bpf/veristat.c
index 609fd9753af0..1d418d66e375 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -145,7 +145,7 @@ static struct env {
 	bool debug;
 	bool quiet;
 	bool force_checkpoints;
-	bool strict_range_sanity;
+	bool force_reg_invariants;
 	enum resfmt out_fmt;
 	bool show_version;
 	bool comparison_mode;
@@ -225,8 +225,8 @@ static const struct argp_option opts[] =3D {
 	{ "filter", 'f', "FILTER", 0, "Filter expressions (or @filename for file =
with expressions)." },
 	{ "test-states", 't', NULL, 0,
 	  "Force frequent BPF verifier state checkpointing (set BPF_F_TEST_STATE_=
FREQ program flag)" },
-	{ "test-sanity", 'r', NULL, 0,
-	  "Force strict BPF verifier register sanity behavior (BPF_F_TEST_SANITY_=
STRICT program flag)" },
+	{ "test-reg-invariants", 'r', NULL, 0,
+	  "Force BPF verifier failure on register invariant violation (BPF_F_TEST=
_REG_INVARIANTS program flag)" },
 	{},
 };
=20
@@ -299,7 +299,7 @@ static error_t parse_arg(int key, char *arg, struct arg=
p_state *state)
 		env.force_checkpoints =3D true;
 		break;
 	case 'r':
-		env.strict_range_sanity =3D true;
+		env.force_reg_invariants =3D true;
 		break;
 	case 'n':
 		errno =3D 0;
@@ -1028,8 +1028,8 @@ static int process_prog(const char *filename, struct =
bpf_object *obj, struct bpf
=20
 	if (env.force_checkpoints)
 		bpf_program__set_flags(prog, bpf_program__flags(prog) | BPF_F_TEST_STATE=
_FREQ);
-	if (env.strict_range_sanity)
-		bpf_program__set_flags(prog, bpf_program__flags(prog) | BPF_F_TEST_SANIT=
Y_STRICT);
+	if (env.force_reg_invariants)
+		bpf_program__set_flags(prog, bpf_program__flags(prog) | BPF_F_TEST_REG_I=
NVARIANTS);
=20
 	err =3D bpf_object__load(obj);
 	env.progs_processed++;
--=20
2.34.1


