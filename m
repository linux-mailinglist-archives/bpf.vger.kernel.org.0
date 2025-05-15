Return-Path: <bpf+bounces-58355-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E80D6AB9086
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 22:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74D0F16DEEC
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 20:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05DC27A461;
	Thu, 15 May 2025 20:06:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B059B4B1E44
	for <bpf@vger.kernel.org>; Thu, 15 May 2025 20:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747339612; cv=none; b=nO+GbZiWV9zwK9Sp/pZf4+5zHnKIZPQQP7ZPq/5BugEvy02e83JcoT3qjmzTy04a9mRdkhWhLfHUeDcvZgCMHeHsGzhLNL5YQI3dNiQxaKI8w/isAmgSuHXizrWFxXhIvIwobl/roRar4BoKV5EtwXqALtjBLw68+xGkFzwTPrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747339612; c=relaxed/simple;
	bh=M8fcoe+JVRHp/hE0r0L2yiJwCwjIF97PS6MehdLQzQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ouMq6Of3OTcQzMYMFgExg3dYxSHVpVn4YZsp+KZJ0o53hujQ9oaytpQKE42t+f2jZQG3PVvFktWVskEKMUaAO6t2JDb/n3+47H/ffF4GgCYpLhHmPVrApn7drELWUBQj4vHy8uJ1OdZPUaN0qw52UsC4+5caA2YeUdu1m8Y4aj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id DBC39786E074; Thu, 15 May 2025 13:06:40 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Add a test with bpf_unreachable() kfunc
Date: Thu, 15 May 2025 13:06:40 -0700
Message-ID: <20250515200640.3428248-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250515200635.3427478-1-yonghong.song@linux.dev>
References: <20250515200635.3427478-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The test case is from [1] reported by Marc Su=C3=B1=C3=A9. When compiled =
with [2],
the object code looks like:

  0000000000000000 <repro>:
  ; {
       0:       bf 16 00 00 00 00 00 00 r6 =3D r1
  ;       bpf_printk("Start");
       1:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 =3D 0x=
0 ll
                0000000000000008:  R_BPF_64_64  .rodata
       3:       b4 02 00 00 06 00 00 00 w2 =3D 0x6
       4:       85 00 00 00 06 00 00 00 call 0x6
  ; DEFINE_FUNC_CTX_POINTER(data)
       5:       61 61 4c 00 00 00 00 00 w1 =3D *(u32 *)(r6 + 0x4c)
  ;       bpf_printk("pre ipv6_hdrlen_offset");
       6:       18 01 00 00 06 00 00 00 00 00 00 00 00 00 00 00 r1 =3D 0x=
6 ll
                0000000000000030:  R_BPF_64_64  .rodata
       8:       b4 02 00 00 17 00 00 00 w2 =3D 0x17
       9:       85 00 00 00 06 00 00 00 call 0x6
      10:       85 10 00 00 ff ff ff ff call -0x1
                0000000000000050:  R_BPF_64_32  bpf_unreachable

You can see the last insn is bpf_unreachable() func and bpf verifier
can take advantage of such information and emits the following error
message:
  (85) call bpf_unreachable#74465
  last insn is bpf_unreachable, due to uninitialized var?

Three other tests are naked functions. They test
  - bpf_unreachable() at the end of the func,
  - bpf_unreachable() in the middle of the func and verification didn't h=
it it, and
  - bpf_unreachable() in the middle of the func and verification hit it

  [1] https://github.com/msune/clang_bpf/blob/main/Makefile#L3
  [2] https://github.com/llvm/llvm-project/pull/131731

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_uninit_var.c | 248 ++++++++++++++++++
 2 files changed, 250 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_uninit_var=
.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
index e66a57970d28..bc2765d130c0 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -87,6 +87,7 @@
 #include "verifier_tailcall_jit.skel.h"
 #include "verifier_typedef.skel.h"
 #include "verifier_uninit.skel.h"
+#include "verifier_uninit_var.skel.h"
 #include "verifier_unpriv.skel.h"
 #include "verifier_unpriv_perf.skel.h"
 #include "verifier_value_adj_spill.skel.h"
@@ -220,6 +221,7 @@ void test_verifier_subreg(void)               { RUN(v=
erifier_subreg); }
 void test_verifier_tailcall_jit(void)         { RUN(verifier_tailcall_ji=
t); }
 void test_verifier_typedef(void)              { RUN(verifier_typedef); }
 void test_verifier_uninit(void)               { RUN(verifier_uninit); }
+void test_verifier_uninit_var(void)           { RUN(verifier_uninit_var)=
; }
 void test_verifier_unpriv(void)               { RUN(verifier_unpriv); }
 void test_verifier_unpriv_perf(void)          { RUN(verifier_unpriv_perf=
); }
 void test_verifier_value_adj_spill(void)      { RUN(verifier_value_adj_s=
pill); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_uninit_var.c b/to=
ols/testing/selftests/bpf/progs/verifier_uninit_var.c
new file mode 100644
index 000000000000..a1a45b46e99e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_uninit_var.c
@@ -0,0 +1,248 @@
+#include <linux/bpf.h>
+#include <linux/pkt_cls.h>
+#include <linux/if_ether.h>
+#include <linux/in.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+#include <linux/udp.h>
+#include <linux/tcp.h>
+#include <stdbool.h>
+#include <linux/icmpv6.h>
+#include <linux/in.h>
+
+#include <bpf/bpf_endian.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+
+union macaddr {
+	struct {
+		__u32 p1;
+		__u16 p2;
+	};
+	__u8 addr[6];
+};
+
+union v6addr {
+	struct {
+		__u32 p1;
+		__u32 p2;
+		__u32 p3;
+		__u32 p4;
+	};
+	struct {
+		__u64 d1;
+		__u64 d2;
+	};
+	__u8 addr[16];
+};
+
+/* Number of extension headers that can be skipped */
+#define IPV6_MAX_HEADERS 4
+
+#define NEXTHDR_HOP             0       /* Hop-by-hop option header. */
+#define NEXTHDR_TCP             6       /* TCP segment. */
+#define NEXTHDR_UDP             17      /* UDP message. */
+#define NEXTHDR_IPV6            41      /* IPv6 in IPv6 */
+#define NEXTHDR_ROUTING         43      /* Routing header. */
+#define NEXTHDR_FRAGMENT        44      /* Fragmentation/reassembly head=
er. */
+#define NEXTHDR_GRE             47      /* GRE header. */
+#define NEXTHDR_ESP             50      /* Encapsulating security payloa=
d. */
+#define NEXTHDR_AUTH            51      /* Authentication header. */
+#define NEXTHDR_ICMP            58      /* ICMP for IPv6. */
+#define NEXTHDR_NONE            59      /* No next header */
+#define NEXTHDR_DEST            60      /* Destination options header. *=
/
+#define NEXTHDR_SCTP            132     /* SCTP message. */
+#define NEXTHDR_MOBILITY        135     /* Mobility header. */
+
+#define NEXTHDR_MAX             255
+
+#define IPV6_SADDR_OFF		offsetof(struct ipv6hdr, saddr)
+#define IPV6_DADDR_OFF		offsetof(struct ipv6hdr, daddr)
+
+#define NEXTHDR_ICMP 58
+#define ICMP6_NS_MSG_TYPE		135
+
+#define DROP_INVALID		-134
+#define DROP_INVALID_EXTHDR	-156
+#define DROP_FRAG_NOSUPPORT	-157
+
+#define ctx_load_bytes		skb_load_bytes
+
+#define DEFINE_FUNC_CTX_POINTER(FIELD)						\
+static __always_inline void *							\
+ctx_ ## FIELD(const struct __sk_buff *ctx)					\
+{										\
+	void *ptr;								\
+										\
+	/* LLVM may generate u32 assignments of ctx->{data,data_end,data_meta}.=
	\
+	 * With this inline asm, LLVM loses track of the fact this field is on	=
\
+	 * 32 bits.								\
+	 */									\
+	asm volatile("%0 =3D *(u32 *)(%1 + %2)"					\
+		     : "=3Dr"(ptr)						\
+		     : "r"(ctx), "i"(offsetof(struct __sk_buff, FIELD)));	\
+	return ptr;								\
+}
+/* This defines ctx_data(). */
+DEFINE_FUNC_CTX_POINTER(data)
+#undef DEFINE_FUNC_CTX_POINTER
+
+
+static __always_inline int ipv6_optlen(const struct ipv6_opt_hdr *opthdr=
)
+{
+	return (opthdr->hdrlen + 1) << 3;
+}
+
+static __always_inline int ipv6_authlen(const struct ipv6_opt_hdr *opthd=
r)
+{
+	return (opthdr->hdrlen + 2) << 2;
+}
+
+static __always_inline int ipv6_hdrlen_offset(struct __sk_buff *ctx,
+					      __u8 *nexthdr, int l3_off)
+{
+	int i, len =3D sizeof(struct ipv6hdr);
+	struct ipv6_opt_hdr opthdr __attribute__((aligned(8)));
+	__u8 nh =3D *nexthdr;
+
+#pragma unroll
+	for (i =3D 0; i < IPV6_MAX_HEADERS; i++) {
+		switch (nh) {
+		case NEXTHDR_NONE:
+			return DROP_INVALID_EXTHDR;
+
+		case NEXTHDR_FRAGMENT:
+			return DROP_FRAG_NOSUPPORT;
+
+		case NEXTHDR_HOP:
+		case NEXTHDR_ROUTING:
+		case NEXTHDR_AUTH:
+		case NEXTHDR_DEST:
+			if (bpf_skb_load_bytes(ctx, l3_off + len, &opthdr,
+					   sizeof(opthdr)) < 0)
+				return DROP_INVALID;
+
+			if (nh =3D=3D NEXTHDR_AUTH)
+				len +=3D ipv6_authlen(&opthdr);
+			else
+				len +=3D ipv6_optlen(&opthdr);
+
+			nh =3D opthdr.nexthdr;
+			break;
+
+		default:
+			bpf_printk("OKOK %d, len: %d", *nexthdr, len);
+			*nexthdr =3D nh;
+			return len;
+		}
+	}
+
+	bpf_printk("KO INVALID EXTHDR");
+
+	/* Reached limit of supported extension headers */
+	return DROP_INVALID_EXTHDR;
+}
+static __always_inline
+bool icmp6_ndisc_validate(struct __sk_buff *ctx, struct ipv6hdr *ip6,
+			  union macaddr *mac, union macaddr *smac,
+			  union v6addr *sip, union v6addr *tip)
+{
+	__u8 nexthdr;
+	struct icmp6hdr *icmp;
+	int l3_off, l4_off;
+
+	l3_off =3D (__u8 *)ip6 - (__u8 *)ctx_data(ctx);
+	bpf_printk("pre ipv6_hdrlen_offset");
+	l4_off =3D ipv6_hdrlen_offset(ctx, &nexthdr, l3_off);
+	bpf_printk("post ipv6_hdrlen_offset");
+
+	if (l4_off < 0 || nexthdr !=3D NEXTHDR_ICMP) {
+		bpf_printk("KO 1");
+		return false;
+	}
+
+	icmp =3D (struct icmp6hdr *)((__u8 *)ctx_data(ctx) + l4_off);
+	if (icmp->icmp6_type !=3D ICMP6_NS_MSG_TYPE) {
+		bpf_printk("KO 2");
+		return false;
+	}
+
+	/* Extract fields */
+#if 0
+	eth_load_saddr(ctx, &smac->addr[0], 0);
+	eth_load_daddr(ctx, &mac->addr[0], 0);
+	ipv6_load_saddr(ctx, l3_off, sip);
+	ipv6_load_daddr(ctx, l3_off, tip);
+#endif
+	bpf_printk("ACK ");
+
+	return true;
+}
+
+SEC("classifier")
+__description("agressive optimization due to uninitialized variable")
+#if __clang_major__ >=3D 21
+__failure __msg("last insn is bpf_unreachable, due to uninitialized var"=
)
+#else
+__failure __msg("last insn is not an exit or jmp")
+#endif
+int classifier_uninit_var(struct __sk_buff *skb)
+{
+	struct ipv6hdr *ip6 =3D NULL;
+	union macaddr mac, smac;
+	union v6addr sip, tip;
+
+	bpf_printk("Start");
+	icmp6_ndisc_validate(skb, ip6, &mac, &smac, &sip, &tip);
+	bpf_printk("End");
+
+	return 0;
+}
+
+extern void bpf_unreachable(void) __weak __ksym;
+
+SEC("socket")
+__description("bpf_unreachable as the last func insn")
+__failure __msg("last insn is bpf_unreachable, due to uninitialized var"=
)
+__naked void bpf_unreachable_at_func_end(void)
+{
+	asm volatile (
+	"r0 =3D 0;"
+	"call %[bpf_unreachable];"
+	:
+	: __imm(bpf_unreachable)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("dead code bpf_unreachable in the middle of code")
+__success
+__naked void dead_bpf_unreachable_in_middle(void)
+{
+	asm volatile (
+	"r0 =3D 0;"
+	"if r0 =3D=3D 0 goto +1;"
+	"call %[bpf_unreachable];"
+	"exit;"
+	:
+	: __imm(bpf_unreachable)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("reachable bpf_unreachable in the middle of code")
+__failure __msg("unexpected hit bpf_unreachable, due to uninit var or in=
correct verification?")
+__naked void live_bpf_unreachable_in_middle(void)
+{
+	asm volatile (
+	"r0 =3D 0;"
+	"if r0 =3D=3D 1 goto +1;"
+	"call %[bpf_unreachable];"
+	"exit;"
+	:
+	: __imm(bpf_unreachable)
+	: __clobber_all);
+}
+
+char _license[] SEC("license") =3D "GPL";
--=20
2.47.1


