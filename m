Return-Path: <bpf+bounces-20835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DAA8443FB
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 17:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F17D4284526
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 16:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB9912AAFD;
	Wed, 31 Jan 2024 16:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gG/3ROJU"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521971272C2
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 16:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706718033; cv=none; b=aCmEFpuq8XF6FzO9JY6g5Dbv8HAiKJ/i6/LiX/L0kSB7el9M4BP+r+aawyn6cHwncmr6FFuk7Q3TVjmNoomYZRgQrFU259MXo5zbWSwx1Vg+E8H+hmJpaYwhNCw08px84Iz1g8+O26P5OjmYYy5vptmJwWRZsi236ColWLKts1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706718033; c=relaxed/simple;
	bh=G3R9iRde6w1LHyXLHMzwQUl0fg1L9NZ/uTEo/HJmJdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WaHS6zsVLPKBSoTFdK4fiwyHpBL3/edOPdHCX2ap9s44YYeRH2Oh6mzh+eczGYCGNepGDW6PHrrQNHc1b/nDUFEosBNu1/EuveTt0DvftUk94AvJXs/GA+3dkjMpYbxP7Y5vTicgjP7uAxXUtY0EiLGW4N/E2AnatjmoacYejGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gG/3ROJU; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40VEwwWA026733;
	Wed, 31 Jan 2024 16:20:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=mc6YuPytL4xr5qtWoXwQkxFyhPA+iHPEeT8VTEC7b6A=;
 b=gG/3ROJUWAKUecEzHIkYcNZSEaHip/u6Kv++28BlD7C76LW3F5uxHEYRqy7zBt2VEUzi
 xSuh3PDiLvWiBm0jif0XTxGyv6lsHeXRUSToYtaAYwQLXKWhZDKPWgHssvYFxFd4+vZo
 tlHRr8Ni2+tAi9bBZunSumZvbYyQZ7XBT82FdADLMZVCcRtVO52+aQ8v3fhmS6l7TtbL
 444ilQSAaki9oOWz9b3jBQJziKiGjbzOqT3Y1UZimlI0+lmD42Q5IeVcFdJOUgeTkKcT
 75NlhBGIhVOjToUonsbSgxqebh8fZ1+imU0d9tyDmBzj6dMS1W02cywxSQWQeP+/81YF +Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvseuj7he-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 16:20:13 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40VFOCXN025854;
	Wed, 31 Jan 2024 16:20:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr99ax1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 16:20:12 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40VGFbtp033723;
	Wed, 31 Jan 2024 16:20:12 GMT
Received: from bpf.uk.oracle.com (dhcp-10-175-217-87.vpn.oracle.com [10.175.217.87])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3vvr99awvm-2;
	Wed, 31 Jan 2024 16:20:11 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [RFC bpf-next 1/2] libbpf: add support for Userspace Runtime Dynamic Tracing (URDT)
Date: Wed, 31 Jan 2024 16:20:02 +0000
Message-Id: <20240131162003.962665-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240131162003.962665-1-alan.maguire@oracle.com>
References: <20240131162003.962665-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_09,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401310126
X-Proofpoint-ORIG-GUID: x1XOjTYQj83xXZPwWY-JRiMHck-EXMCF
X-Proofpoint-GUID: x1XOjTYQj83xXZPwWY-JRiMHck-EXMCF

Userspace Static Defined Tracing (USDT) provides a means to add
tracepoints to userspace code; these are marked by a no-op and
described in a .notes.stapsdt section, and libbpf provides
mechanisms to support tracing USDT via uprobes and the
USDT manager.

However, in order to be able to add tracepoints to userspace
code in other languages like python or go, a library call
(that can then be wrapped in the runtime-specific glue code)
is required.  One example of how such runtime probes
are supported is libstapsdt [1]; it creates a shared
library and annotations on the fly in order to emulate USDT.
BCC supports this mechanism, and one option would be to
add similar support to libbpf.  However, it would involve
retrieving the ELF notes from the dynamically-created
library, which at first glance looked tricky.

The approach here is simpler; essentially we bootstrap from
USDT to supporting runtime probes.  USDT probes marking runtime
probe firing are added to libbpf itself, and these are
passed the probe arguments along with a hash of provider/probe
names.  For example, to fire a URDT probe, the user simply
calls:

  BPF_URDT_PROBE3("myprovider", "myprobe", arg1, arg2, arg3);

There is no need to declare such probes in advance.

Under the hood, an associated USDT probe then fires, and
this is the triggering mechanism for URDT.  All that is
left to do on the BPF side then is

1. ensure that the probe firing is the one we are tracing;
   this is done by matching the hash of provider/probe
   passed into the USDT probe with the cookie associated
   with the URDT attachment.  The high-order 32 bits are used
   for this; the rest is still available to the user to
   set as a per-attachment cookie value.  A mismatch
   here triggers early exit.
2. map from USDT -> URDT arguments. urdt.bpf.h provides
   means to do this; it is simply a matter of ignoring
   the last USDT hash argument.

BPF_URDT() is a macro similar to BPF_USDT() that handles
probe matching, argument assignment etc.

From the BPF side, a URDT BPF program will look like this:

SEC("urdt:/path:2:myprovider:myprobe")
int BPF_URDT(myprobe, int arg1, const char *arg2)
{
	...
}

Note that prior to provider probe, "2" is specified to
tell auto-attach that we will attach to the equivalent
2-argument URDT probe (which is a 3-argument USDT
probe under the hood).  The path should be the
binary that calls the firing functions itself (if libbpf
is statically linked like test_progs), or the path
to libbpf.so (if libbpf is dynamically linked),
since we want to attach to the USDT probe firings
in libbpf itself.  Future work could add this
URDT firing mechanism to libstapsdt also.

It appears to have a few advantages over the current
libstapsdt method:

- it supports global runtime probes.  As I understand
it, the on-the-fly library creation will be specific
to the process that triggers the probe in libstapsdt,
whereas with the above approach we can instrument
the libbpf shared library such that firings will
appear system-wide.
- it is a bit simpler to fire probes; no prior setup
is required

However, it may be preferable to add support for
the existing libstapsdt approach to libbpf. This RFC
is just intended to start that discussion.

[1] https://github.com/linux-usdt/libstapsdt

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/Build             |   2 +-
 tools/lib/bpf/Makefile          |   2 +-
 tools/lib/bpf/libbpf.c          |  94 +++++++++++++++++++++
 tools/lib/bpf/libbpf.h          |  94 +++++++++++++++++++++
 tools/lib/bpf/libbpf.map        |  13 +++
 tools/lib/bpf/libbpf_internal.h |   2 +
 tools/lib/bpf/urdt.bpf.h        | 103 +++++++++++++++++++++++
 tools/lib/bpf/urdt.c            | 145 ++++++++++++++++++++++++++++++++
 8 files changed, 453 insertions(+), 2 deletions(-)
 create mode 100644 tools/lib/bpf/urdt.bpf.h
 create mode 100644 tools/lib/bpf/urdt.c

diff --git a/tools/lib/bpf/Build b/tools/lib/bpf/Build
index b6619199a706..f196fce86089 100644
--- a/tools/lib/bpf/Build
+++ b/tools/lib/bpf/Build
@@ -1,4 +1,4 @@
 libbpf-y := libbpf.o bpf.o nlattr.o btf.o libbpf_errno.o str_error.o \
 	    netlink.o bpf_prog_linfo.o libbpf_probes.o hashmap.o \
 	    btf_dump.o ringbuf.o strset.o linker.o gen_loader.o relo_core.o \
-	    usdt.o zip.o elf.o features.o
+	    usdt.o urdt.o zip.o elf.o features.o
diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index 4be7144e4803..16aad308ab04 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -239,7 +239,7 @@ install_lib: all_cmd
 
 SRC_HDRS := bpf.h libbpf.h btf.h libbpf_common.h libbpf_legacy.h	     \
 	    bpf_helpers.h bpf_tracing.h bpf_endian.h bpf_core_read.h	     \
-	    skel_internal.h libbpf_version.h usdt.bpf.h
+	    skel_internal.h libbpf_version.h usdt.bpf.h urdt.bpf.h
 GEN_HDRS := $(BPF_GENERATED)
 
 INSTALL_PFX := $(DESTDIR)$(prefix)/include/bpf
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index fa7094ff3e66..0628167d1517 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8975,6 +8975,7 @@ static int attach_kprobe(const struct bpf_program *prog, long cookie, struct bpf
 static int attach_uprobe(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_ksyscall(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_usdt(const struct bpf_program *prog, long cookie, struct bpf_link **link);
+static int attach_urdt(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_tp(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_raw_tp(const struct bpf_program *prog, long cookie, struct bpf_link **link);
 static int attach_trace(const struct bpf_program *prog, long cookie, struct bpf_link **link);
@@ -9003,6 +9004,7 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("kretsyscall+",		KPROBE, 0, SEC_NONE, attach_ksyscall),
 	SEC_DEF("usdt+",		KPROBE,	0, SEC_USDT, attach_usdt),
 	SEC_DEF("usdt.s+",		KPROBE,	0, SEC_USDT | SEC_SLEEPABLE, attach_usdt),
+	SEC_DEF("urdt+",		KPROBE, 0, SEC_USDT , attach_urdt),
 	SEC_DEF("tc/ingress",		SCHED_CLS, BPF_TCX_INGRESS, SEC_NONE), /* alias for tcx */
 	SEC_DEF("tc/egress",		SCHED_CLS, BPF_TCX_EGRESS, SEC_NONE),  /* alias for tcx */
 	SEC_DEF("tcx/ingress",		SCHED_CLS, BPF_TCX_INGRESS, SEC_NONE),
@@ -11884,6 +11886,98 @@ static int attach_usdt(const struct bpf_program *prog, long cookie, struct bpf_l
 	return err;
 }
 
+/* 2 less than USDT_MAX_ARG_CNT */
+#define URDT_MAX_ARG_CNT	11
+
+struct bpf_link *bpf_program__attach_urdt(const struct bpf_program *prog, pid_t pid,
+					  const char *binary_path,
+					  const char *urdt_provider, const char *urdt_name,
+					  const struct bpf_urdt_opts *opts)
+{
+	DECLARE_LIBBPF_OPTS(bpf_usdt_opts, usdt_opts);
+	char resolved_path[512];
+	struct bpf_link *link;
+	char probename[16];
+	unsigned short nargs = 0;
+	int err;
+
+	if (!OPTS_VALID(opts, bpf_urdt_opts))
+		return libbpf_err_ptr(-EINVAL);
+
+	if (bpf_program__fd(prog) < 0) {
+		pr_warn("prog '%s': can't attach BPF program w/o FD (did you load it?)\n",
+			prog->name);
+		return libbpf_err_ptr(-EINVAL);
+	}
+	if (!binary_path)
+		return libbpf_err_ptr(-EINVAL);
+
+	if (!strchr(binary_path, '/')) {
+		err = resolve_full_path(binary_path, resolved_path, sizeof(resolved_path));
+		if (err) {
+			pr_warn("prog '%s': failed to resolve full path for '%s': %d\n",
+				prog->name, binary_path, err);
+			return libbpf_err_ptr(err);
+		}
+		binary_path = resolved_path;
+	}
+
+	/* High-order 32 bits of cookie identify the provider/probe.
+	 * When the shared USDT probe fires, we use these bits to
+	 * compare to final USDT arg to identify probe firing.
+	 */
+	usdt_opts.usdt_cookie = ((long)urdt_probe_hash(urdt_provider, urdt_name)) << 32;
+
+	if (opts) {
+		/* low-order 32 bits can be specified by user */
+		usdt_opts.usdt_cookie |= opts->urdt_cookie;
+		nargs = opts->urdt_nargs;
+		if (nargs > URDT_MAX_ARG_CNT)
+			return libbpf_err_ptr(-EINVAL);
+	}
+	snprintf(probename, sizeof(probename), "probe%hu", nargs);
+
+	/* attach to USDT probe urdt:probeN */
+	link = bpf_program__attach_usdt(prog, pid, binary_path, "urdt", probename,
+					&usdt_opts);
+	err = libbpf_get_error(link);
+	if (err)
+		return libbpf_err_ptr(err);
+	return link;
+}
+
+static int attach_urdt(const struct bpf_program *prog, long cookie, struct bpf_link **link)
+{
+	char *path = NULL, *provider = NULL, *name = NULL;
+	const char *sec_name;
+	short nargs = 0;
+	int n, err;
+
+	sec_name = bpf_program__section_name(prog);
+	if (strcmp(sec_name, "urdt") == 0) {
+		/* no auto-attach for just SEC("urdt") */
+		*link = NULL;
+		return 0;
+	}
+	n = sscanf(sec_name, "urdt/%m[^:]:%hd:%m[^:]:%m[^:]", &path, &nargs, &provider, &name);
+	if (n != 4) {
+		pr_warn("invalid section '%s', expected SEC(\"urdt/<path>:<nargs>:<provider>:<name>\")\n",
+			sec_name);
+		err = -EINVAL;
+	} else {
+		DECLARE_LIBBPF_OPTS(bpf_urdt_opts, urdt_opts);
+
+		urdt_opts.urdt_nargs = nargs;
+		*link = bpf_program__attach_urdt(prog, -1 /* any process */, path,
+						 provider, name, &urdt_opts);
+		err = libbpf_get_error(*link);
+	}
+	free(path);
+	free(provider);
+	free(name);
+	return err;
+}
+
 static int determine_tracepoint_id(const char *tp_category,
 				   const char *tp_name)
 {
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 5723cbbfcc41..eb2efe675d33 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -742,6 +742,100 @@ bpf_program__attach_usdt(const struct bpf_program *prog,
 			 const char *usdt_provider, const char *usdt_name,
 			 const struct bpf_usdt_opts *opts);
 
+struct bpf_urdt_opts {
+	/* size of this struct, for forward/backward compatibility */
+	size_t sz;
+	__u32 urdt_cookie;
+	unsigned short urdt_nargs;
+	size_t :0;
+};
+#define bpf_urdt_opts__last_field urdt_nargs
+
+/* API functions to dynamically fire URDT probes. */
+LIBBPF_API void bpf_urdt__probe0(const char *provider, const char *probe);
+LIBBPF_API void bpf_urdt__probe1(const char *provider, const char *probe, long arg1);
+LIBBPF_API void bpf_urdt__probe2(const char *provider, const char *probe, long arg1, long arg2);
+LIBBPF_API void bpf_urdt__probe3(const char *provider, const char *probe, long arg1, long arg2,
+		      long arg3);
+LIBBPF_API void bpf_urdt__probe4(const char *provider, const char *probe, long arg1, long arg2,
+		      long arg3, long arg4);
+LIBBPF_API void bpf_urdt__probe5(const char *provider, const char *probe, long arg1, long arg2,
+		      long arg3, long arg4, long arg5);
+LIBBPF_API void bpf_urdt__probe6(const char *provider, const char *probe, long arg1, long arg2,
+		      long arg3, long arg4, long arg5, long arg6);
+LIBBPF_API void bpf_urdt__probe7(const char *provider, const char *probe, long arg1, long arg2,
+		      long arg3, long arg4, long arg5, long arg6, long arg7);
+LIBBPF_API void bpf_urdt__probe8(const char *provider, const char *probe, long arg1, long arg2,
+		      long arg3, long arg4, long arg5, long arg6, long arg7, long arg8);
+LIBBPF_API void bpf_urdt__probe9(const char *provider, const char *probe, long arg1, long arg2,
+		      long arg3, long arg4, long arg5, long arg6, long arg7, long arg8,
+		      long arg9);
+LIBBPF_API void bpf_urdt__probe10(const char *provider, const char *probe, long arg1, long arg2,
+		      long arg3, long arg4, long arg5, long arg6, long arg7, long arg8,
+		      long arg9, long arg10);
+LIBBPF_API void bpf_urdt__probe11(const char *provider, const char *probe, long arg1, long arg2,
+		       long arg3, long arg4, long arg5, long arg6, long arg7, long arg8,
+		       long arg9, long arg10, long arg11);
+
+#define BPF_URDT_PROBE0(provider, probe)						\
+	bpf_urdt__probe0(provider, probe)
+#define BPF_URDT_PROBE1(provider, probe, arg1)						\
+	bpf_urdt__probe1(provider, probe, (long)arg1)
+#define BPF_URDT_PROBE2(provider, probe, arg1, arg2)					\
+	bpf_urdt__probe2(provider, probe, (long)arg1, (long)arg2)
+#define BPF_URDT_PROBE3(provider, probe, arg1, arg2, arg3)				\
+	bpf_urdt__probe3(provider, probe, (long)arg1, (long)arg2, (long)arg3)
+#define BPF_URDT_PROBE4(provider, probe, arg1, arg2, arg3, arg4)			\
+	bpf_urdt__probe4(provider, probe, (long)arg1, (long)arg2, (long)arg3, (long)arg4)
+#define BPF_URDT_PROBE5(provider, probe, arg1, arg2, arg3, arg4, arg5)			\
+	bpf_urdt__probe5(provider, probe, (long)arg1, (long)arg2, (long)arg3, (long)arg4, \
+			 (long)arg5)
+#define BPF_URDT_PROBE6(provider, probe, arg1, arg2, arg3, arg4, arg5, arg6)		\
+	bpf_urdt__probe6(provider, probe, (long)arg1, (long)arg2, (long)arg3, (long)arg4, \
+			 (long)arg5, (long)arg6)
+#define BPF_URDT_PROBE7(provider, probe, arg1, arg2, arg3, arg4, arg5, arg6, arg7)	\
+	bpf_urdt__probe7(provider, probe, (long)arg1, (long)arg2, (long)arg3, (long)arg4, \
+			 (long)arg5, (long)arg6, (long)arg7)
+#define BPF_URDT_PROBE8(provider, probe, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8) \
+	bpf_urdt__probe8(provider, probe, (long)arg1, (long)arg2, (long)arg3, (long)arg4, \
+			 (long)arg5, (long)arg6, (long)arg7, (long)arg8)
+#define BPF_URDT_PROBE9(provider, probe, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9) \
+	bpf_urdt__probe9(provider, probe, (long)arg1, (long)arg2, (long)arg3, (long)arg4, \
+			 (long)arg5, (long)arg6, (long)arg7, (long)arg8, (long)arg9)
+#define BPF_URDT_PROBE10(provider, probe, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, \
+			 arg10) \
+	bpf_urdt__probe10(provider, probe, (long)arg1, (long)arg2, (long)arg3, (long)arg4, \
+			 (long)arg5, (long)arg6, (long)arg7, (long)arg8, (long)arg9, \
+			 (long)arg10)
+#define BPF_URDT_PROBE11(provider, probe, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, \
+			 arg10, arg11) \
+	bpf_urdt__probe11(provider, probe, (long)arg1, (long)arg2, (long)arg3, (long)arg4, \
+			 (long)arg5, (long)arg6, (long)arg7, (long)arg8, (long)arg9, \
+			 (long)arg10, (long)arg11)
+
+
+
+/**
+ * @brief **bpf_program__attach_urdt()** is just like
+ * bpf_program__attach_usdt() except it covers URDT (User-space
+ * Runtime-Defined Tracepoint) attachment, instead of attaching to
+ * statically defined tracepoints.
+ *
+ * @param prog BPF program to attach
+ * @param pid Process ID to attach the uprobe to, 0 for self (own process),
+ * -1 for all processes
+ * @param urdt_provider USDT provider name
+ * @param urdt_name USDT probe name
+ * @param opts Options for altering program attachment
+ * @return Reference to the newly created BPF link; or NULL is returned on error,
+ * error code is stored in errno
+ */
+LIBBPF_API struct bpf_link *
+bpf_program__attach_urdt(const struct bpf_program *prog,
+			 pid_t pid, const char *binary_path,
+			 const char *urdt_provider, const char *urdt_name,
+			 const struct bpf_urdt_opts *opts);
+
 struct bpf_tracepoint_opts {
 	/* size of this struct, for forward/backward compatibility */
 	size_t sz;
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index d9e1f57534fa..1afcfbcc81a5 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -412,4 +412,17 @@ LIBBPF_1.3.0 {
 
 LIBBPF_1.4.0 {
 		bpf_token_create;
+		bpf_program__attach_urdt;
+		bpf_urdt__probe0;
+		bpf_urdt__probe1;
+		bpf_urdt__probe2;
+		bpf_urdt__probe3;
+		bpf_urdt__probe4;
+		bpf_urdt__probe5;
+		bpf_urdt__probe6;
+		bpf_urdt__probe7;
+		bpf_urdt__probe8;
+		bpf_urdt__probe9;
+		bpf_urdt__probe10;
+		bpf_urdt__probe11;
 } LIBBPF_1.3.0;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 930cc9616527..661967c0de2c 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -624,6 +624,8 @@ struct bpf_link * usdt_manager_attach_usdt(struct usdt_manager *man,
 					   const char *usdt_provider, const char *usdt_name,
 					   __u64 usdt_cookie);
 
+unsigned int urdt_probe_hash(const char *provider, const char *probe);
+
 static inline bool is_pow_of_2(size_t x)
 {
 	return x && (x & (x - 1)) == 0;
diff --git a/tools/lib/bpf/urdt.bpf.h b/tools/lib/bpf/urdt.bpf.h
new file mode 100644
index 000000000000..fb9bac89db10
--- /dev/null
+++ b/tools/lib/bpf/urdt.bpf.h
@@ -0,0 +1,103 @@
+/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
+/* Copyright (c) 2024, Oracle and/or its affiliates. */
+
+#ifndef __URDT_BPF_H__
+#define __URDT_BPF_H__
+
+#include "usdt.bpf.h"
+
+/* Return number of URDT arguments defined; these are 1 less then the USDT-defined
+ * number, as we have provider/probe hash after actual arguments.
+ */
+__weak __hidden
+int bpf_urdt_arg_cnt(struct pt_regs *ctx)
+{
+	int cnt = bpf_usdt_arg_cnt(ctx);
+
+	if (cnt < 0)
+		return cnt;
+	if (cnt < 1)
+		return -ENOENT;
+	return cnt - 1;
+}
+
+/* Fetch URDT argument #*arg_num* (zero-indexed) and put its value into *res.
+ * Returns 0 on success; negative error, otherwise.
+ * On error *res is guaranteed to be set to zero.
+ */
+__weak __hidden
+int bpf_urdt_arg(struct pt_regs *ctx, __u64 arg_num, long *res)
+{
+	if (arg_num >= bpf_urdt_arg_cnt(ctx))
+		return -ENOENT;
+	return bpf_usdt_arg(ctx, arg_num, res);
+}
+
+/* Retrieve user-specified cookie value provided during attach as
+ * bpf_urdt_opts.urdt_cookie.  This corresponds to the low 32 bits of
+ * the 64-bit USDT cookie; the higher-order bits are a hash identifying
+ * the provider/probe.
+ */
+__weak __hidden
+int bpf_urdt_cookie(struct pt_regs *ctx)
+{
+	long cookie = bpf_usdt_cookie(ctx);
+
+	return (int)cookie;
+}
+
+/* Return 0 if last USDT argument (provider/probe hash) matches high-order
+ * 32 bits of USDT cookie; this tells us the probe is for us in cases
+ * where the same USDT probe is shared among multiple URDT probes.
+ */
+static __always_inline int bpf_urdt_check_hash(struct pt_regs *ctx)
+{
+	int cnt = bpf_urdt_arg_cnt(ctx);
+	long h = 0, cookie = bpf_usdt_cookie(ctx);
+
+	if (cnt < 0)
+		return cnt;
+	if (bpf_usdt_arg(ctx, cnt, &h) || (int)h != (int)(cookie >> 32))
+		return -ENOENT;
+	return 0;
+}
+
+/* we rely on ___bpf_apply() and ___bpf_narg() macros already defined in bpf_tracing.h;
+ * urdt args start at arg 3 (args 0, 1 and 2 are provider, probe and hash respectively)
+ */
+#define ___bpf_urdt_args0() ctx
+#define ___bpf_urdt_args1(x) ___bpf_urdt_args0(), ({ long _x; bpf_urdt_arg(ctx, 0, &_x); (void *)_x; })
+#define ___bpf_urdt_args2(x, args...) ___bpf_urdt_args1(args), ({ long _x; bpf_urdt_arg(ctx, 1, &_x); (void *)_x; })
+#define ___bpf_urdt_args3(x, args...) ___bpf_urdt_args2(args), ({ long _x; bpf_urdt_arg(ctx, 2, &_x); (void *)_x; })
+#define ___bpf_urdt_args4(x, args...) ___bpf_urdt_args3(args), ({ long _x; bpf_urdt_arg(ctx, 3, &_x); (void *)_x; })
+#define ___bpf_urdt_args5(x, args...) ___bpf_urdt_args4(args), ({ long _x; bpf_urdt_arg(ctx, 4, &_x); (void *)_x; })
+#define ___bpf_urdt_args6(x, args...) ___bpf_urdt_args5(args), ({ long _x; bpf_urdt_arg(ctx, 5, &_x); (void *)_x; })
+#define ___bpf_urdt_args7(x, args...) ___bpf_urdt_args6(args), ({ long _x; bpf_urdt_arg(ctx, 6, &_x); (void *)_x; })
+#define ___bpf_urdt_args8(x, args...) ___bpf_urdt_args7(args), ({ long _x; bpf_urdt_arg(ctx, 7, &_x); (void *)_x; })
+#define ___bpf_urdt_args9(x, args...) ___bpf_urdt_args8(args), ({ long _x; bpf_urdt_arg(ctx, 8, &_x); (void *)_x; })
+#define ___bpf_urdt_args10(x, args...) ___bpf_urdt_args9(args), ({ long _x; bpf_urdt_arg(ctx, 9, &_x); (void *)_x; })
+#define ___bpf_urdt_args11(x, args...) ___bpf_urdt_args10(args), ({ long _x; bpf_urdt_arg(ctx, 10, &_x); (void *)_x; })
+#define ___bpf_urdt_args(args...) ___bpf_apply(___bpf_urdt_args, ___bpf_narg(args))(args)
+
+/*
+ * BPF_URDT serves the same purpose for URDT handlers as BPF_PROG for
+ * tp_btf/fentry/fexit BPF programs and BPF_KPROBE for kprobes.
+ * Original struct pt_regs * context is preserved as 'ctx' argument.
+ */
+#define BPF_URDT(name, args...)						    \
+name(struct pt_regs *ctx);						    \
+static __always_inline typeof(name(0))					    \
+____##name(struct pt_regs *ctx, ##args);				    \
+typeof(name(0)) name(struct pt_regs *ctx)				    \
+{									    \
+	if (bpf_urdt_check_hash(ctx))					    \
+		return 0;						    \
+	_Pragma("GCC diagnostic push")					    \
+	_Pragma("GCC diagnostic ignored \"-Wint-conversion\"")		    \
+	return ____##name(___bpf_usdt_args(args));			    \
+	_Pragma("GCC diagnostic pop")					    \
+}									    \
+static __always_inline typeof(name(0))					    \
+____##name(struct pt_regs *ctx, ##args)
+
+#endif /* __URDT_BPF_H__ */
diff --git a/tools/lib/bpf/urdt.c b/tools/lib/bpf/urdt.c
new file mode 100644
index 000000000000..0c2459bd9d71
--- /dev/null
+++ b/tools/lib/bpf/urdt.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+/* Copyright (c) 2024, Oracle and/or its affiliates. */
+
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+#include <ctype.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <stdbool.h>
+#include <unistd.h>
+#include <linux/bpf.h>
+
+#include "libbpf.h"
+#include "libbpf_internal.h"
+
+/* sdt.h warns if __STDC_VERSION__ is not set. */
+#ifndef __STDC_VERSION__
+#define __STDC_VERSION__	199901L
+#endif
+
+#include "sdt.h"
+
+/*
+ * User-space Runtime-Defined Tracing - URDT.
+ */
+
+/*
+ * URDT allows a program to define runtime probes in a similar
+ * manner to the compile-time USDT.
+ *
+ * A probe can be fired by calling the BPF_URDT_PROBE[N]() function,
+ * where N is the number of arguments; for example
+ *
+ * BPF_URDT_PROBE2("myprovider", "myprobe", 1, "helloworld");
+ *
+ * This will trigger firing of the USDT probe urdt:probe2
+ * within libbpf itself.  Once this probe fires, a BPF program
+ * attached to it will fire.  URDT probes use the high-order
+ * 32 bits of the USDT cookie to identify the provider/probe
+ * by hashing the provider/probe name - see urdt.bpf.h for
+ * details.  If the upper 32 bits of the cookie match the
+ * hash passed into the probe, we know the probe firing is
+ * for us.
+ */
+static unsigned int hash_combine(unsigned int hash, const char *str)
+{
+	const char *s;
+
+	if (!str)
+		return hash;
+
+	for (s = str; *s != '\0'; s++)
+		hash = hash * 31 + *s;
+	return hash;
+}
+
+unsigned int urdt_probe_hash(const char *provider, const char *probe)
+{
+	unsigned int hash = 0;
+
+	hash = hash_combine(hash, provider);
+	return hash_combine(hash, probe);
+}
+
+void bpf_urdt__probe0(const char *provider, const char *probe)
+{
+	STAP_PROBE1(urdt, probe0, urdt_probe_hash(provider, probe));
+}
+
+void bpf_urdt__probe1(const char *provider, const char *probe, long arg1)
+{
+	STAP_PROBE2(urdt, probe1, arg1, urdt_probe_hash(provider, probe));
+}
+
+void bpf_urdt__probe2(const char *provider, const char *probe, long arg1, long arg2)
+{
+	STAP_PROBE3(urdt, probe2, arg1, arg2, urdt_probe_hash(provider, probe));
+}
+
+void bpf_urdt__probe3(const char *provider, const char *probe, long arg1, long arg2, long arg3)
+{
+	STAP_PROBE4(urdt, probe3, arg1, arg2, arg3, urdt_probe_hash(provider, probe));
+}
+
+void bpf_urdt__probe4(const char *provider, const char *probe, long arg1, long arg2, long arg3,
+		      long arg4)
+{
+	STAP_PROBE5(urdt, probe4, arg1, arg2, arg3, arg4, urdt_probe_hash(provider, probe));
+}
+
+void bpf_urdt__probe5(const char *provider, const char *probe, long arg1, long arg2, long arg3,
+		      long arg4, long arg5)
+{
+	STAP_PROBE6(urdt, probe5, arg1, arg2, arg3, arg4, arg5,
+		    urdt_probe_hash(provider, probe));
+}
+
+void bpf_urdt__probe6(const char *provider, const char *probe, long arg1, long arg2, long arg3,
+		      long arg4, long arg5, long arg6)
+{
+	STAP_PROBE7(urdt, probe6, arg1, arg2, arg3, arg4, arg5, arg6,
+		    urdt_probe_hash(provider, probe));
+}
+
+void bpf_urdt__probe7(const char *provider, const char *probe, long arg1, long arg2, long arg3,
+		      long arg4, long arg5, long arg6, long arg7)
+{
+	STAP_PROBE8(urdt, probe7, arg1, arg2, arg3, arg4, arg5, arg6, arg7,
+		    urdt_probe_hash(provider, probe));
+}
+
+void bpf_urdt__probe8(const char *provider, const char *probe, long arg1, long arg2, long arg3,
+		      long arg4, long arg5, long arg6, long arg7, long arg8)
+{
+	STAP_PROBE9(urdt, probe8, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8,
+		    urdt_probe_hash(provider, probe));
+}
+
+void bpf_urdt__probe9(const char *provider, const char *probe, long arg1, long arg2, long arg3,
+		      long arg4, long arg5, long arg6, long arg7, long arg8, long arg9)
+{
+	STAP_PROBE10(urdt, probe9, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9,
+		     urdt_probe_hash(provider, probe));
+}
+
+void bpf_urdt__probe10(const char *provider, const char *probe, long arg1, long arg2, long arg3,
+		       long arg4, long arg5, long arg6, long arg7, long arg8, long arg9,
+		       long arg10)
+{
+	STAP_PROBE11(urdt, probe10, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9,
+		     arg10, urdt_probe_hash(provider, probe));
+}
+
+void bpf_urdt__probe11(const char *provider, const char *probe, long arg1, long arg2, long arg3,
+		       long arg4, long arg5, long arg6, long arg7, long arg8, long arg9,
+		       long arg10, long arg11)
+{
+	STAP_PROBE12(urdt, probe11, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9,
+		     arg10, arg11, urdt_probe_hash(provider, probe));
+}
+
+
-- 
2.39.3


