Return-Path: <bpf+bounces-62502-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F187AFB587
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 16:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10B2F3B0C97
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 14:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261862BE027;
	Mon,  7 Jul 2025 14:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Xp1Ks6o5"
X-Original-To: bpf@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691BF1FCF41;
	Mon,  7 Jul 2025 14:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751896934; cv=none; b=Ke2gwpyrvw8fosIPakHYx/SNIVyCqU7WNWuEiFBTA/EGrhn6N8RgdiYDGjwi+dGvgdRTB2apDJZ2bAZbPAKY3HeT4iTr8AXDSjjT06rKpotYyvbIi4wRPrkomPw+QjttMW67sfruytGMJo8yv36dZXjnLXxmglRgSgq4Zwt2tKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751896934; c=relaxed/simple;
	bh=Ui0SVBAF9ZOOCGT2pgDGK3fz7RgnUEizMhpIhHdPW6Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gMF5iGj7EKGEC7i08iDxnJqkbBImuDw1QfGhPJOv4zpAWsvwD8khShQyv5N+jHBW5Q/DG7MogUUGpWr0k3oKH8WoIBHFf1byIzfJryiOJ4eqxTVP+wxuoAUtAAA3yf4I0CI0s/ZdrtydN10pfMy8JdOqPKVDjix7A90WMgQPS4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Xp1Ks6o5; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3A676443B1;
	Mon,  7 Jul 2025 14:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751896930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=40NAIMtjpvdSKHdzmcfQA9UKomJZG7cKSHLRYBGNLJQ=;
	b=Xp1Ks6o5Uf1BiOawub/QE6BZfAS7mKmzFXNAi882ft4mrYHreEPyq64uT+7vQHhgquNvTS
	2PQ4/APoSJmRWDE0QbPYXyUzWCEHo9ckQd6ojbZgpNlGhnAnZ6H7pCMec3Wa0lveSTrhk8
	mCc8jmXvRAUpmn+aOWa9asj29/V1tL4A0TG0vQS5BJ8MWvJjb5g125xNtkQBuEsND96h5m
	+pJMLwuDLa7OopCpHdEcQJwZK4OS2qfAZErwpbqVkzTRGnCMOPF30chzed/QoCRzeq3B05
	fzUNM0y5AHiKiLkVfbcF0pHojI8X3lGLi9qvrktLVp3tFpZlrY4wIQFveIwXPw==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Mon, 07 Jul 2025 16:02:04 +0200
Subject: [PATCH v3 2/3] tests: add some tests validating skipped functions
 due to uncertain arg location
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250707-btf_skip_structs_on_stack-v3-2-29569e086c12@bootlin.com>
References: <20250707-btf_skip_structs_on_stack-v3-0-29569e086c12@bootlin.com>
In-Reply-To: <20250707-btf_skip_structs_on_stack-v3-0-29569e086c12@bootlin.com>
To: dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, Alexei Starovoitov <ast@fb.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, ebpf@linuxfoundation.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefudellecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpeetlhgvgihishcunfhothhhohhrroculdgvuefrhfcuhfhouhhnuggrthhiohhnmdcuoegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepleejkeetffefveelgeeklefhtefhgfeigeduveffjeehleeifeefjedtudejgeeunecukfhppedvrgdtvdemkeegvdekmehfleegtgemvgdttdemmehfkeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeekgedvkeemfhelgegtmegvtddtmeemfhekhedphhgvlhhopegludelvddrudeikedruddrudeljegnpdhmrghilhhfrhhomheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeelpdhrtghpthhtoheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheprghlrghnrdhmrghguhhirhgvsehorhgrtghlvgdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtp
 hhtthhopegrtghmvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvggsphhfsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepugifrghrvhgvshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheprghsthesfhgsrdgtohhm
X-GND-Sasl: alexis.lothore@bootlin.com

Add a small binary representing specific cases likely absent from
standard vmlinux or kernel modules files. As a starter, the introduced
binary exposes a few functions consuming structs passed by value, some
passed by register, some passed on the stack:

  int main(void);
  int test_bin_func_struct_on_stack_ko(int, void *, char, short int, int, \
    void *, char, short int, struct test_bin_struct_packed);
  int test_bin_func_struct_on_stack_ok(int, void *, char, short int, int, \
    void *, char, short int, struct test_bin_struct);
  int test_bin_func_struct_ok(int, void *, char, struct test_bin_struct);
  int test_bin_func_ok(int, void *, char, short int);

Then enrich btf_functions.sh to make it perform the following steps:
- build the binary
- generate BTF info and pfunct listing, both with dwarf and the
  generated BTF
- check that any function encoded in BTF is found in DWARF
- check that any function announced as skipped is indeed absent from BTF
- check that any skipped function has been skipped due to uncertain
  parameter location

Example of the new test execution:
  Encoding...Matched 4 functions exactly.
  Ok
  Validation of skipped function logic...
  Skipped encoding 1 functions in BTF.
  Ok
  Validating skipped functions have uncertain parameter location...
  pahole: /home/alexis/src/pahole/tests/bin/test_bin: Invalid argument
  Found 1 legitimately skipped function due to uncertain loc
  Ok

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v3:
- bring a userspace binary instead of an OoT kernel module
- remove test dependency to a kernel directory being provided
- improve test dir detection

Changes in v2:
- new patch
---
 tests/bin/Makefile     | 10 ++++++
 tests/bin/test_bin.c   | 66 ++++++++++++++++++++++++++++++++++++
 tests/btf_functions.sh | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 167 insertions(+)

diff --git a/tests/bin/Makefile b/tests/bin/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..70bcf57ac4744f30fe03ea12908e42c69390f14a
--- /dev/null
+++ b/tests/bin/Makefile
@@ -0,0 +1,10 @@
+CC=${CROSS_COMPILE}gcc
+
+test_bin: test_bin.c
+	${CC} $^ -Wall -Wextra -Werror -g -o $@
+
+clean:
+	rm -rf test_bin
+
+.PHONY: clean
+
diff --git a/tests/bin/test_bin.c b/tests/bin/test_bin.c
new file mode 100644
index 0000000000000000000000000000000000000000..ca6a4852cc511243925db905e55e040519af9cfd
--- /dev/null
+++ b/tests/bin/test_bin.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+
+#define noinline __attribute__((noinline))
+#define __packed __attribute__((__packed__))
+
+struct test_bin_struct {
+	char a;
+	short b;
+	int c;
+	unsigned long long d;
+};
+
+struct test_bin_struct_packed {
+	char a;
+	short b;
+	int c;
+	unsigned long long d;
+}__packed;
+
+int test_bin_func_ok(int a, void *b, char c, short d);
+int test_bin_func_struct_ok(int a, void *b, char c, struct test_bin_struct d);
+int test_bin_func_struct_on_stack_ok(int a, void *b, char c, short d, int e,
+                                      void *f, char g, short h,
+                                      struct test_bin_struct i);
+int test_bin_func_struct_on_stack_ko(int a, void *b, char c, short d, int e,
+                                      void *f, char g, short h,
+                                      struct test_bin_struct_packed i);
+
+noinline int test_bin_func_ok(int a, void *b, char c, short d)
+{
+	return a + (long)b + c + d;
+}
+
+noinline int test_bin_func_struct_ok(int a, void *b, char c,
+                                      struct test_bin_struct d)
+{
+	return a + (long)b + c + d.a + d.b + d.c + d.d;
+}
+
+noinline int test_bin_func_struct_on_stack_ok(int a, void *b, char c, short d,
+                                               int e, void *f, char g, short h,
+                                               struct test_bin_struct i)
+{
+	return a + (long)b + c + d + e + (long)f + g + h + i.a + i.b + i.c + i.d;
+}
+
+noinline int test_bin_func_struct_on_stack_ko(int a, void *b, char c, short d,
+                                               int e, void *f, char g, short h,
+                                               struct test_bin_struct_packed i)
+{
+	return a + (long)b + c + d + e + (long)f + g + h + i.a + i.b + i.c + i.d;
+}
+
+int main()
+{
+	struct test_bin_struct test;
+	struct test_bin_struct_packed test_bis;
+
+	test_bin_func_ok(0, NULL, 0, 0);
+	test_bin_func_struct_ok(0, NULL, 0, test);
+	test_bin_func_struct_on_stack_ok(0, NULL, 0, 0, 0, NULL, 0, 0, test);
+	test_bin_func_struct_on_stack_ko(0, NULL, 0, 0, 0, NULL, 0, 0, test_bis);
+	return 0;
+}
+
diff --git a/tests/btf_functions.sh b/tests/btf_functions.sh
index c92e5ae906f90badfede86eb530108894fbc8c93..fb62b0b56662bb2ae58f7adc0a022c400cba5e0f 100755
--- a/tests/btf_functions.sh
+++ b/tests/btf_functions.sh
@@ -193,4 +193,95 @@ if [[ -n "$VERBOSE" ]]; then
 fi
 echo "Ok"
 
+# Some specific cases can not  be tested directly with a standard kernel.
+# We can use the small binary in bin/ to test those cases, like packed
+# structs passed on the stack. 
+
+echo -n "Validation of BTF encoding corner cases with test_bin functions; this may take some time: "
+
+test -n "$VERBOSE" && printf "\nBuilding test_bin..."
+tests_dir=$(realpath $(dirname $0))
+make -C ${tests_dir}/bin
+
+test -n "$VERBOSE" && printf "\nEncoding..."
+pahole --btf_features=default --lang_exclude=rust --btf_encode_detached=$outdir/test_bin.btf \
+	--verbose ${tests_dir}/bin/test_bin | grep "skipping BTF encoding of function" \
+	> ${outdir}/test_bin_skipped_fns
+
+funcs=$(pfunct --format_path=btf $outdir/test_bin.btd 2>/dev/null|sort)
+pfunct --all --no_parm_names --format_path=dwarf bin/test_bin | \
+	sort|uniq > $outdir/test_bin_dwarf.funcs
+pfunct --all --no_parm_names --format_path=btf $outdir/test_bin.btf 2>/dev/null|\
+	awk '{ gsub("^(bpf_kfunc |bpf_fastcall )+",""); print $0}'|sort|uniq > $outdir/test_bin_btf.funcs
+
+exact=0
+while IFS= read -r btf ; do
+	# Matching process can be kept simpler as the tested binary is
+	# specifically tailored for tests
+	dwarf=$(grep -F "$btf" $outdir/test_bin_dwarf.funcs)
+	if [[ "$btf" != "$dwarf" ]]; then
+		echo "ERROR: mismatch : BTF '$btf' not found; DWARF '$dwarf'"
+		fail
+	else
+		exact=$((exact+1))
+	fi
+done < $outdir/test_bin_btf.funcs
+
+if [[ -n "$VERBOSE" ]]; then
+	echo "Matched $exact functions exactly."
+	echo "Ok"
+	echo "Validation of skipped function logic..."
+fi
+
+skipped_cnt=$(wc -l ${outdir}/test_bin_skipped_fns | awk '{ print $1}')
+if [[ "$skipped_cnt" == "0" ]]; then
+	echo "No skipped functions.  Done."
+	exit 0
+fi
+
+skipped_fns=$(awk '{print $1}' $outdir/test_bin_skipped_fns)
+for s in $skipped_fns ; do
+	# Ensure the skipped function are not in BTF
+	inbtf=$(grep " $s(" $outdir/test_bin_btf.funcs)
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
+uncertain_loc=$(awk '/due to uncertain parameter location/ { print $1 }' $outdir/test_bin_skipped_fns)
+legitimate_skip=0
+
+for f in $uncertain_loc ; do
+	# Extract parameters types
+	raw_params=$(grep ${f} $outdir/test_bin_dwarf.funcs|sed -n 's/^[^(]*(\([^)]*\)).*/\1/p')
+	IFS=',' read -ra params <<< "${raw_params}"
+	for param in "${params[@]}"
+	do
+		# Search any param that could be a struct
+		struct_type=$(echo ${param}|grep -E '^struct [^*]' | sed -E 's/^struct //')
+		if [ -n "${struct_type}" ]; then
+			# Check with pahole if the struct is detected as
+			# packed
+			if pahole -F dwarf -C "${struct_type}" ${tests_dir}/bin/test_bin|tail -n 2|grep -q __packed__
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

-- 
2.50.0


