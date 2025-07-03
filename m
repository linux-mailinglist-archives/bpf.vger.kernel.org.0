Return-Path: <bpf+bounces-62243-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B52AF6E16
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 11:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D69E4E5A4C
	for <lists+bpf@lfdr.de>; Thu,  3 Jul 2025 09:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391F92D4B68;
	Thu,  3 Jul 2025 09:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SV4Xdrj4"
X-Original-To: bpf@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3A92D46CD;
	Thu,  3 Jul 2025 09:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751533376; cv=none; b=thSvH96tHGvOzso5W0cACjV6UJhFGWNwA2bcanWtygUfXMFG/6p8Dm5TgpdJheHhvQ1aS0rse8TXbM3pBBuhuBXNsM5vRh8Z7vtwKZO+WEkHZfJ7IhoJYytiHzpTss4HG3X3mq21QwuwjJKO3Abrmf8ts+QfqF9iDSPuro6dk6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751533376; c=relaxed/simple;
	bh=Q1POodz7dllwe8vvwG8grYps3LcNyhZgW0DzbG1guYc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kMcOgQxdULE13mZhMruQ5Ak10tSr8jx5m26i6kd6oHQCGJA/DhWCkYAYd8F5mTeeXJ5hfn6zbL2uVin4Dx1RXhel/otEtxM6uN0EA8Q0wbpDliRVHK2wzyJVqU8svrI2pHC1qEubgR0m8jFMeuZ1C9hzfZQOqDhe4ADkrie+HRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SV4Xdrj4; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 786374330B;
	Thu,  3 Jul 2025 09:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751533366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ayPNbL5QX+qOWU/VUJ5uupCiMhgvljlrpugUZ5x/Xs=;
	b=SV4Xdrj4aFxbWQig/AiujlT0gVjgahKMOOnMD3yeOmvBAULDHqnM2k5tUWokQln9NExKce
	Yq7sGYKSuZmEIpl2nBbJf7CU3/S0MXWSGhQNXhqJbdDWW+yoQ/nGrPlUOwaGIuIFI48cxM
	nfSbEiS1kBmHMLkk+3agspgdNOpxRQjukzoqriz9cGrqQFQMnMkSGcPz2H1JsaK0vj7w+H
	RPWLTXurtnBPaxG6CGElA8BpZc9XEZNlkOgOTMTmQItD8bZIc9gFwRRSAKBo/BtYhH3zUY
	zCtAJjkIt4lfERKh63zGDHWiObjsr48VeW5Wx+LXKrZfLsHuMKMq1mb4YJS32Q==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Thu, 03 Jul 2025 11:02:33 +0200
Subject: [PATCH v2 2/3] tests: add some tests validating skipped functions
 due to uncertain arg location
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250703-btf_skip_structs_on_stack-v2-2-4767e3ba10c9@bootlin.com>
References: <20250703-btf_skip_structs_on_stack-v2-0-4767e3ba10c9@bootlin.com>
In-Reply-To: <20250703-btf_skip_structs_on_stack-v2-0-4767e3ba10c9@bootlin.com>
To: dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, Alexei Starovoitov <ast@fb.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, ebpf@linuxfoundation.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleekjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpeetlhgvgihishcunfhothhhohhrroculdgvuefrhfcuhfhouhhnuggrthhiohhnmdcuoegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepleejkeetffefveelgeeklefhtefhgfeigeduveffjeehleeifeefjedtudejgeeunecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrtddrvddungdpmhgrihhlfhhrohhmpegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepledprhgtphhtthhopegvsghpfheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegsphhfsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepugifrghrvhgvshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrtghmvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghsthesf
 hgsrdgtohhmpdhrtghpthhtohepsggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegrlhgrnhdrmhgrghhuihhrvgesohhrrggtlhgvrdgtohhm
X-GND-Sasl: alexis.lothore@bootlin.com

Add a small kernel module representing specific cases likely absent from
standard vmlinux files. As a starter, the introduced module exposes a
few functions consuming structs passed by value, some passed by
register, some passed on the stack:

  int kmod_test_init(void);
  int test_kmod_func_ok(int, void *, char, short int);
  int test_kmod_func_struct_ok(int, void *, char, struct kmod_struct);
  int test_kmod_func_struct_on_stack_ok(int, void *, char, short int, int, \
    void *, char, short int, struct kmod_struct);
  int test_kmod_func_struct_on_stack_ko(int, void *, char, short int, int, \
    void *, char, short int, struct kmod_struct_packed);

Then enrich btf_functions.sh to make it perform the following steps:
- build the module
- generate BTF info and pfunct listing, both with dwarf and the
  generated BTF
- check that any function encoded in BTF is found in DWARF
- check that any function announced as skipped is indeed absent from BTF
- check that any skipped function has been skipped due to uncertain
  parameter location

Those new tests are executed only if a kernel directory is provided as
script's second argument, they are otherwise skipped.

Example of the new test execution:
  Encoding...Matched 4 functions exactly.
  Ok
  Validation of skipped function logic...
  Skipped encoding 1 functions in BTF.
  Ok
  Validating skipped functions have uncertain parameter location...
  Found 1 legitimately skipped function due to uncertain loc
  Ok

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v2:
- new patch
---
 tests/btf_functions.sh | 99 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/kmod/Makefile    |  1 +
 tests/kmod/kmod.c      | 69 +++++++++++++++++++++++++++++++++++
 3 files changed, 169 insertions(+)

diff --git a/tests/btf_functions.sh b/tests/btf_functions.sh
index c92e5ae906f90badfede86eb530108894fbc8c93..64810b7eb51e7f2693929fbf66e0641a9d4e0277 100755
--- a/tests/btf_functions.sh
+++ b/tests/btf_functions.sh
@@ -193,4 +193,103 @@ if [[ -n "$VERBOSE" ]]; then
 fi
 echo "Ok"
 
+# Some specific cases can not  be tested directly with a standard kernel.
+# We can use the kernel module in kmod/ to test those cases, like packed
+# structs passed on the stack. Run this test only if we have the needed
+# dependencies (eg: some kernel sources directory passed as argument; those
+# must match the used vmlinux file)
+
+KDIR=${KDIR:-$2}
+if [ -z "$KDIR" ] ; then
+	echo "Skipping kmod tests"
+	exit 0
+fi
+
+echo -n "Validation of BTF encoding corner cases with kmod functions; this may take some time: "
+
+test -n "$VERBOSE" && printf "\nBuilding kmod..."
+tests_dir=$(dirname $0)
+make -C ${KDIR} M=${tests_dir}/kmod
+
+test -n "$VERBOSE" && printf "\nEncoding..."
+pahole --btf_features=default --lang_exclude=rust --btf_encode_detached=$outdir/kmod.btf \
+	--verbose ${tests_dir}/kmod/kmod.ko | grep "skipping BTF encoding of function" \
+	> ${outdir}/kmod_skipped_fns
+
+funcs=$(pfunct --format_path=btf $outdir/kmod.btf 2>/dev/null|sort)
+pfunct --all --no_parm_names --format_path=dwarf kmod/kmod.ko | \
+	sort|uniq > $outdir/kmod_dwarf.funcs
+pfunct --all --no_parm_names --format_path=btf $outdir/kmod.btf 2>/dev/null|\
+	awk '{ gsub("^(bpf_kfunc |bpf_fastcall )+",""); print $0}'|sort|uniq > $outdir/kmod_btf.funcs
+
+exact=0
+while IFS= read -r btf ; do
+	# Matching process can be kept simpler as the tested binary is
+	# specifically tailored for tests
+	dwarf=$(grep -F "$btf" $outdir/kmod_dwarf.funcs)
+	if [[ "$btf" != "$dwarf" ]]; then
+		echo "ERROR: mismatch : BTF '$btf' not found; DWARF '$dwarf'"
+		fail
+	else
+		exact=$((exact+1))
+	fi
+done < $outdir/kmod_btf.funcs
+
+if [[ -n "$VERBOSE" ]]; then
+	echo "Matched $exact functions exactly."
+	echo "Ok"
+	echo "Validation of skipped function logic..."
+fi
+
+skipped_cnt=$(wc -l ${outdir}/kmod_skipped_fns | awk '{ print $1}')
+if [[ "$skipped_cnt" == "0" ]]; then
+	echo "No skipped functions.  Done."
+	exit 0
+fi
+
+skipped_fns=$(awk '{print $1}' $outdir/kmod_skipped_fns)
+for s in $skipped_fns ; do
+	# Ensure the skipped function are not in BTF
+	inbtf=$(grep " $s(" $outdir/kmod_btf.funcs)
+	if [[ -n "$inbtf" ]]; then
+		echo "ERROR: '${s}()' was added incorrectly to BTF: '$inbtf'"
+		fail
+	fi
+done
+
+if [[ -n "$VERBOSE" ]]; then
+	echo "Skipped encoding $skipped_cnt functions in BTF."
+	echo "Ok"
+	echo "Validating skipped functions have uncertain parameter location..."
+fi
+
+uncertain_loc=$(awk '/due to uncertain parameter location/ { print $1 }' $outdir/kmod_skipped_fns)
+legitimate_skip=0
+
+for f in $uncertain_loc ; do
+	# Extract parameters types
+	raw_params=$(grep ${f} $outdir/kmod_dwarf.funcs|sed -n 's/^[^(]*(\([^)]*\)).*/\1/p')
+	IFS=',' read -ra params <<< "${raw_params}"
+	for param in "${params[@]}"
+	do
+		# Search any param that could be a struct
+		struct_type=$(echo ${param}|grep -E '^struct [^*]' | sed -E 's/^struct //')
+		if [ -n "${struct_type}" ]; then
+			# Check with pahole if the struct is detected as
+			# packed
+			if pahole -C "${struct_type}" kmod/kmod.ko|grep -q __packed__
+			then
+				legitimate_skip=$((legitimate_skip+1))
+				continue 2
+			fi
+		fi
+	done
+	echo "ERROR: '${f}()' should not have been skipped; it has no parameter with uncertain location"
+	fail
+done
+
+if [[ -n "$VERBOSE" ]]; then
+	echo "Found ${legitimate_skip} legitimately skipped function due to uncertain loc"
+fi
+echo "Ok"
 exit 0
diff --git a/tests/kmod/Makefile b/tests/kmod/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..e7c2ed929eaf81e91429f744c3778156ed2be2d2
--- /dev/null
+++ b/tests/kmod/Makefile
@@ -0,0 +1 @@
+obj-m += kmod.o
diff --git a/tests/kmod/kmod.c b/tests/kmod/kmod.c
new file mode 100644
index 0000000000000000000000000000000000000000..5b93614b6156b05925a6cb48809ad63533ccba3e
--- /dev/null
+++ b/tests/kmod/kmod.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/module.h>
+#include <linux/printk.h>
+
+struct kmod_struct {
+	char a;
+	short b;
+	int c;
+	unsigned long long d;
+};
+
+struct kmod_struct_packed {
+	char a;
+	short b;
+	int c;
+	unsigned long long d;
+}__packed;
+
+int test_kmod_func_ok(int a, void *b, char c, short d);
+int test_kmod_func_struct_ok(int a, void *b, char c, struct kmod_struct d);
+int test_kmod_func_struct_on_stack_ok(int a, void *b, char c, short d, int e,
+                                      void *f, char g, short h,
+                                      struct kmod_struct i);
+int test_kmod_func_struct_on_stack_ko(int a, void *b, char c, short d, int e,
+                                      void *f, char g, short h,
+                                      struct kmod_struct_packed i);
+
+noinline int test_kmod_func_ok(int a, void *b, char c, short d)
+{
+	return a + (long)b + c + d;
+}
+
+noinline int test_kmod_func_struct_ok(int a, void *b, char c,
+                                      struct kmod_struct d)
+{
+	return a + (long)b + c + d.a + d.b + d.c + d.d;
+}
+
+noinline int test_kmod_func_struct_on_stack_ok(int a, void *b, char c, short d,
+                                               int e, void *f, char g, short h,
+                                               struct kmod_struct i)
+{
+	return a + (long)b + c + d + e + (long)f + g + h + i.a + i.b + i.c + i.d;
+}
+
+noinline int test_kmod_func_struct_on_stack_ko(int a, void *b, char c, short d,
+                                               int e, void *f, char g, short h,
+                                               struct kmod_struct_packed i)
+{
+	return a + (long)b + c + d + e + (long)f + g + h + i.a + i.b + i.c + i.d;
+}
+
+static int kmod_test_init(void)
+{
+	struct kmod_struct test;
+	struct kmod_struct_packed test_bis;
+
+	test_kmod_func_ok(0, NULL, 0, 0);
+	test_kmod_func_struct_ok(0, NULL, 0, test);
+	test_kmod_func_struct_on_stack_ok(0, NULL, 0, 0, 0, NULL, 0, 0, test);
+	test_kmod_func_struct_on_stack_ko(0, NULL, 0, 0, 0, NULL, 0, 0, test_bis);
+	return 0;
+}
+
+module_init(kmod_test_init);
+
+MODULE_AUTHOR("Alexis Lothoré");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Pahole testing module");

-- 
2.50.0


