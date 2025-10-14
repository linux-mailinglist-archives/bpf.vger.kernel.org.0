Return-Path: <bpf+bounces-70871-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BA4BD7656
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 07:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A3D834F7E65
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 05:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E25296BBC;
	Tue, 14 Oct 2025 05:16:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40797291C07
	for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 05:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760419015; cv=none; b=VY6H7oBcQiiyJI2AWoFaYbrQuXNXzDhE3QN2jEdq8KTTaFd702Jv8r6f86MNJRQkhIlpL+60cEhXMbnlPUCQvQU+D2HlRzdldv7bQ1mn4hbHNdgyNd9DRTcY/v1Qe/mem+hqyx5/UcOJ1LLgYn4dwGMI9RgP/qRSggyDhGfW1BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760419015; c=relaxed/simple;
	bh=87z87/XnQoPyB/lAylIyA4Zx72uJkuB4BFtgCggXmHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m4f67F14Rqpp3H8Clhclzx2z8gBfSnQHmOi3awJaLy/03uq+5YO6kSuKZeqeUSexz+b67cBknkECH1JMrEseuOZJ2XPNnMYTw6vCITzkkdzLhI4+ni7oZryWHTRCda4oEvWOJYKXKywPyF+CwAR7XhIt81viOjP6OnnTZhtykdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id DABD21268D146; Mon, 13 Oct 2025 22:16:39 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next] selftests/bpf: Fix selftest verif_scale_strobemeta failure with llvm22
Date: Mon, 13 Oct 2025 22:16:39 -0700
Message-ID: <20251014051639.1996331-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With latest llvm22, I hit the verif_scale_strobemeta selftest failure
below:
  $ ./test_progs -n 618
  libbpf: prog 'on_event': BPF program load failed: -E2BIG
  libbpf: prog 'on_event': -- BEGIN PROG LOAD LOG --
  BPF program is too large. Processed 1000001 insn
  verification time 7019091 usec
  stack depth 488
  processed 1000001 insns (limit 1000000) max_states_per_insn 28 total_st=
ates 33927 peak_states 12813 mark_read 0
  -- END PROG LOAD LOG --
  libbpf: prog 'on_event': failed to load: -E2BIG
  libbpf: failed to load object 'strobemeta.bpf.o'
  scale_test:FAIL:expect_success unexpected error: -7 (errno 7)
  #618     verif_scale_strobemeta:FAIL

But if I increase the verificaiton insn limit from 1M to 10M, the above
test_progs run actually will succeed. The below is the result from verist=
at:
  $ ./veristat strobemeta.bpf.o
  Processing 'strobemeta.bpf.o'...
  File              Program   Verdict  Duration (us)    Insns  States  Pr=
ogram size  Jited size
  ----------------  --------  -------  -------------  -------  ------  --=
----------  ----------
  strobemeta.bpf.o  on_event  success       90250893  9777685  358230    =
     15954       80794
  ----------------  --------  -------  -------------  -------  ------  --=
----------  ----------
  Done. Processed 1 files, 0 programs. Skipped 1 files, 0 programs.

Further debugging shows the llvm commit [1] is responsible for the verifi=
caiton
failure as it tries to convert certain switch statement to if-condition. =
Such
change may cause different transformation compared to original switch sta=
tement.

In bpf program strobemeta.c case, the initial llvm ir for read_int_var() =
function is
  define internal void @read_int_var(ptr noundef %0, i64 noundef %1, ptr =
noundef %2,
      ptr noundef %3, ptr noundef %4) #2 !dbg !535 {
    %6 =3D alloca ptr, align 8
    %7 =3D alloca i64, align 8
    %8 =3D alloca ptr, align 8
    %9 =3D alloca ptr, align 8
    %10 =3D alloca ptr, align 8
    %11 =3D alloca ptr, align 8
    %12 =3D alloca i32, align 4
    ...
    %20 =3D icmp ne ptr %19, null, !dbg !561
    br i1 %20, label %22, label %21, !dbg !562

  21:                                               ; preds =3D %5
    store i32 1, ptr %12, align 4
    br label %48, !dbg !563

  22:
    %23 =3D load ptr, ptr %9, align 8, !dbg !564
    ...

  47:                                               ; preds =3D %38, %22
    store i32 0, ptr %12, align 4, !dbg !588
    br label %48, !dbg !588

  48:                                               ; preds =3D %47, %21
    call void @llvm.lifetime.end.p0(ptr %11) #4, !dbg !588
    %49 =3D load i32, ptr %12, align 4
    switch i32 %49, label %51 [
      i32 0, label %50
      i32 1, label %50
    ]

  50:                                               ; preds =3D %48, %48
    ret void, !dbg !589

  51:                                               ; preds =3D %48
    unreachable
  }

Note that the above 'switch' statement is added by clang frontend.
Without [1], the switch statement will survive until SelectionDag,
so the switch statement acts like a 'barrier' and prevents some
transformation involved with both 'before' and 'after' the switch stateme=
nt.

But with [1], the switch statement will be removed during middle end
optimization and later middle end passes (esp. after inlining) have more
freedom to reorder the code.

The following is the related source code:

  static void *calc_location(struct strobe_value_loc *loc, void *tls_base=
):
        bpf_probe_read_user(&tls_ptr, sizeof(void *), dtv);
        /* if pointer has (void *)-1 value, then TLS wasn't initialized y=
et */
        return tls_ptr && tls_ptr !=3D (void *)-1
                ? tls_ptr + tls_index.offset
                : NULL;

  In read_int_var() func, we have:
        void *location =3D calc_location(&cfg->int_locs[idx], tls_base);
        if (!location)
                return;

        bpf_probe_read_user(value, sizeof(struct strobe_value_generic), l=
ocation);
        ...

The static func calc_location() is called inside read_int_var(). The asm =
code
without [1]:
     77: .123....89 (85) call bpf_probe_read_user#112
     78: ........89 (79) r1 =3D *(u64 *)(r10 -368)
     79: .1......89 (79) r2 =3D *(u64 *)(r10 -8)
     80: .12.....89 (bf) r3 =3D r2
     81: .123....89 (0f) r3 +=3D r1
     82: ..23....89 (07) r2 +=3D 1
     83: ..23....89 (79) r4 =3D *(u64 *)(r10 -464)
     84: ..234...89 (a5) if r2 < 0x2 goto pc+13
     85: ...34...89 (15) if r3 =3D=3D 0x0 goto pc+12
     86: ...3....89 (bf) r1 =3D r10
     87: .1.3....89 (07) r1 +=3D -400
     88: .1.3....89 (b4) w2 =3D 16
In this case, 'r2 < 0x2' and 'r3 =3D=3D 0x0' go to null 'locaiton' place,
so the verifier actually prefers to do verification first at 'r1 =3D r10'=
 etc.

The asm code with [1]:
    119: .123....89 (85) call bpf_probe_read_user#112
    120: ........89 (79) r1 =3D *(u64 *)(r10 -368)
    121: .1......89 (79) r2 =3D *(u64 *)(r10 -8)
    122: .12.....89 (bf) r3 =3D r2
    123: .123....89 (0f) r3 +=3D r1
    124: ..23....89 (07) r2 +=3D -1
    125: ..23....89 (a5) if r2 < 0xfffffffe goto pc+6
    126: ........89 (05) goto pc+17
    ...
    144: ........89 (b4) w1 =3D 0
    145: .1......89 (6b) *(u16 *)(r8 +80) =3D r1
In this case, if 'r2 < 0xfffffffe' is true, the control will go to
non-null 'location' branch, so 'goto pc+17' will actually go to
null 'location' branch. This seems causing tremendous amount of
verificaiton state.

To fix the issue, rewrite the following code
  return tls_ptr && tls_ptr !=3D (void *)-1
                ? tls_ptr + tls_index.offset
                : NULL;
to if/then statement and hopefully these explicit if/then statements
are sticky during middle-end optimizations.

Test with llvm20 and llvm21 as well and all strobemeta related selftests
are passed.

  [1] https://github.com/llvm/llvm-project/pull/161000

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/progs/strobemeta.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

NOTE: I will also check whether we can make changes in llvm to automatica=
lly
 adjust branch statements to minimize verification insns/states.=20

diff --git a/tools/testing/selftests/bpf/progs/strobemeta.h b/tools/testi=
ng/selftests/bpf/progs/strobemeta.h
index a5c74d31a244..6e1918deaf26 100644
--- a/tools/testing/selftests/bpf/progs/strobemeta.h
+++ b/tools/testing/selftests/bpf/progs/strobemeta.h
@@ -330,9 +330,9 @@ static void *calc_location(struct strobe_value_loc *l=
oc, void *tls_base)
 	}
 	bpf_probe_read_user(&tls_ptr, sizeof(void *), dtv);
 	/* if pointer has (void *)-1 value, then TLS wasn't initialized yet */
-	return tls_ptr && tls_ptr !=3D (void *)-1
-		? tls_ptr + tls_index.offset
-		: NULL;
+	if (!tls_ptr || tls_ptr =3D=3D (void *)-1)
+		return NULL;
+	return tls_ptr + tls_index.offset;
 }
=20
 #ifdef SUBPROGS
--=20
2.47.3


