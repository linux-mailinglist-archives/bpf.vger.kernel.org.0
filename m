Return-Path: <bpf+bounces-62504-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C232CAFB5A6
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 16:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BCA34239C9
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 14:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7312A2BEC3A;
	Mon,  7 Jul 2025 14:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RtYSPJS6"
X-Original-To: bpf@vger.kernel.org
Received: from relay16.mail.gandi.net (relay16.mail.gandi.net [217.70.178.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADD22BEC30;
	Mon,  7 Jul 2025 14:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751897704; cv=none; b=NeAV5rq30yl8kmGFHHcm966qvZueyrMB9nETIe5Ms6p0vorqw/JJ/WMFU5t5Y8gZHUqt1VFCbMdQlE03IQskCZ6PHq02066YgKjD1VibHL4rTahUbUym0GGwtQR9fFXoHcVgslbUazpQEaH5dTYMsShPVnbid9vUakeQdsWYl9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751897704; c=relaxed/simple;
	bh=c/OI+WCb9hPvi/AAQReoLBO7pr3FwlYQFzWTljX8FIE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=SFTt1bQSebiK7YS6Q+hjqkIC+jZJ0LWSImESaQd0zZB4R8DyHRJP2gIaFAmBOibOe4GPFd6PQBCnR034GQ1bpJ4dEV2QmObIHHriQL64lWWtBy+LyOc5Fp7TIqg3o+wnP4K8lAoNjQ2Fx5VHVo5zW424AhThUmz7v8J2D1q0wMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RtYSPJS6; arc=none smtp.client-ip=217.70.178.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D71E04386A;
	Mon,  7 Jul 2025 14:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751897694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g6mwDRAuB66XkbLKZuKUymprWX2WqWt7guT4ebMNQSo=;
	b=RtYSPJS6QNyXvAGmYsVeuO5/zWbmlH2KQPj5VPBzUVx6n4bwlSAV+WBved2Cx59Xkjo3Z/
	N6IvEumtMqsjtyFiPVbxILnuAJujSYa1RsbVBN6fk7pLosO3jaeNY0yqX1AE168d3CTJv0
	iId6tEoNBtzioVb0QWFkBTzgxnKq1zZPNrv++YjL3G/+ao9S39SRPWtrOW+QPYu8IkR1qW
	ctAVU+R52/X+v+owNGW/TJH51SVMpHPkJFrpta/dyeKMvS7YxuSSfbTYdQp/X61cabDdL9
	mmSTGj+fuKxEvtqS5X/d3ZdVaH1gqiPIl2/X5zf93V+uDEB3fUY+COqhIavTww==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 07 Jul 2025 16:14:53 +0200
Message-Id: <DB5VWHU0N27I.3ETC4G47KB9Q@bootlin.com>
Cc: <bpf@vger.kernel.org>, "Alan Maguire" <alan.maguire@oracle.com>,
 "Arnaldo Carvalho de Melo" <acme@kernel.org>, "Alexei Starovoitov"
 <ast@fb.com>, "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Bastien
 Curutchet" <bastien.curutchet@bootlin.com>, <ebpf@linuxfoundation.org>
Subject: Re: [PATCH v3 2/3] tests: add some tests validating skipped
 functions due to uncertain arg location
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>, <dwarves@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250707-btf_skip_structs_on_stack-v3-0-29569e086c12@bootlin.com> <20250707-btf_skip_structs_on_stack-v3-2-29569e086c12@bootlin.com>
In-Reply-To: <20250707-btf_skip_structs_on_stack-v3-2-29569e086c12@bootlin.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefvddtudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggfgtgffkfevuffhvffofhgjsehtqhertdertdejnecuhfhrohhmpeetlhgvgihishcunfhothhhohhrrocuoegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepffdvudffhfeiffehteffgfegueegtdeiudehieelgfduvdehgedvueffueevledtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepvdgrtddvmeekgedvkeemfhelgegtmegvtddtmeemfhekheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemkeegvdekmehfleegtgemvgdttdemmehfkeehpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepledprhgtphhtthhopegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdprhgtphhtthhopegufigrrhhvvghssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghpfhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtt
 hhopegrlhgrnhdrmhgrghhuihhrvgesohhrrggtlhgvrdgtohhmpdhrtghpthhtoheprggtmhgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrshhtsehfsgdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhm

On Mon Jul 7, 2025 at 4:02 PM CEST, Alexis Lothor=C3=A9 (eBPF Foundation) w=
rote:
> Add a small binary representing specific cases likely absent from
> standard vmlinux or kernel modules files. As a starter, the introduced
> binary exposes a few functions consuming structs passed by value, some
> passed by register, some passed on the stack:
>
>   int main(void);
>   int test_bin_func_struct_on_stack_ko(int, void *, char, short int, int,=
 \
>     void *, char, short int, struct test_bin_struct_packed);
>   int test_bin_func_struct_on_stack_ok(int, void *, char, short int, int,=
 \
>     void *, char, short int, struct test_bin_struct);
>   int test_bin_func_struct_ok(int, void *, char, struct test_bin_struct);
>   int test_bin_func_ok(int, void *, char, short int);
>
> Then enrich btf_functions.sh to make it perform the following steps:
> - build the binary
> - generate BTF info and pfunct listing, both with dwarf and the
>   generated BTF
> - check that any function encoded in BTF is found in DWARF
> - check that any function announced as skipped is indeed absent from BTF
> - check that any skipped function has been skipped due to uncertain
>   parameter location
>
> Example of the new test execution:
>   Encoding...Matched 4 functions exactly.
>   Ok
>   Validation of skipped function logic...
>   Skipped encoding 1 functions in BTF.
>   Ok
>   Validating skipped functions have uncertain parameter location...
>   pahole: /home/alexis/src/pahole/tests/bin/test_bin: Invalid argument

A word about this specific error: I may have missed it in the previous
iteration, but I systematically get this error when running the following
command:
  $ pahole -C test_bin_struct_packed tests/bin/test_bin

I initially thought that it would be something related to the binary being
a userspace program and not a kernel module, but I observe the following:
- the issue is observed even on a .ko file (tested on the previous series
  iteration with kmod.ko)
- the issue does not appear if there is no class filtering (ie the `-C`
  arg) provided to pahole
- the issue occurs as well with the packaged pahole version on my host (v1.=
30)
- the struct layout is still displayed correctly despite the error

A quick bisect shows that the error log has started appearing with
59f5409f1357 ("dwarf_loader: Fix termination on BTF encoding error"). This
commit has "enforced" error propagation if dwfl_getmodules returns
something different than 0 (before, it was propagating an error only if the
error code was negative, but dwfl_getmodules seems to be able to return
values > 0 as well). As is sound unrelated to this series, I pushed this
new revision anyway. [1] seems to hint that the issue is known, but in my
case I don't get any additional log about unhandled DWARF operation. The
issue is pretty repeatable on my side, feel free to ask for any additional
detail or manipulation that could help.

[1] https://lore.kernel.org/dwarves/933e199997949c0ac8a71551830f1e6c98d8bff=
0@linux.dev/
>   Found 1 legitimately skipped function due to uncertain loc
>   Ok
>
> Signed-off-by: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@boot=
lin.com>
> ---
> Changes in v3:
> - bring a userspace binary instead of an OoT kernel module
> - remove test dependency to a kernel directory being provided
> - improve test dir detection
>
> Changes in v2:
> - new patch
> ---
>  tests/bin/Makefile     | 10 ++++++
>  tests/bin/test_bin.c   | 66 ++++++++++++++++++++++++++++++++++++
>  tests/btf_functions.sh | 91 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 167 insertions(+)
>
> diff --git a/tests/bin/Makefile b/tests/bin/Makefile
> new file mode 100644
> index 0000000000000000000000000000000000000000..70bcf57ac4744f30fe03ea129=
08e42c69390f14a
> --- /dev/null
> +++ b/tests/bin/Makefile
> @@ -0,0 +1,10 @@
> +CC=3D${CROSS_COMPILE}gcc
> +
> +test_bin: test_bin.c
> +	${CC} $^ -Wall -Wextra -Werror -g -o $@
> +
> +clean:
> +	rm -rf test_bin
> +
> +.PHONY: clean
> +
> diff --git a/tests/bin/test_bin.c b/tests/bin/test_bin.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..ca6a4852cc511243925db905e=
55e040519af9cfd
> --- /dev/null
> +++ b/tests/bin/test_bin.c
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <stdio.h>
> +
> +#define noinline __attribute__((noinline))
> +#define __packed __attribute__((__packed__))
> +
> +struct test_bin_struct {
> +	char a;
> +	short b;
> +	int c;
> +	unsigned long long d;
> +};
> +
> +struct test_bin_struct_packed {
> +	char a;
> +	short b;
> +	int c;
> +	unsigned long long d;
> +}__packed;
> +
> +int test_bin_func_ok(int a, void *b, char c, short d);
> +int test_bin_func_struct_ok(int a, void *b, char c, struct test_bin_stru=
ct d);
> +int test_bin_func_struct_on_stack_ok(int a, void *b, char c, short d, in=
t e,
> +                                      void *f, char g, short h,
> +                                      struct test_bin_struct i);
> +int test_bin_func_struct_on_stack_ko(int a, void *b, char c, short d, in=
t e,
> +                                      void *f, char g, short h,
> +                                      struct test_bin_struct_packed i);
> +
> +noinline int test_bin_func_ok(int a, void *b, char c, short d)
> +{
> +	return a + (long)b + c + d;
> +}
> +
> +noinline int test_bin_func_struct_ok(int a, void *b, char c,
> +                                      struct test_bin_struct d)
> +{
> +	return a + (long)b + c + d.a + d.b + d.c + d.d;
> +}
> +
> +noinline int test_bin_func_struct_on_stack_ok(int a, void *b, char c, sh=
ort d,
> +                                               int e, void *f, char g, s=
hort h,
> +                                               struct test_bin_struct i)
> +{
> +	return a + (long)b + c + d + e + (long)f + g + h + i.a + i.b + i.c + i.=
d;
> +}
> +
> +noinline int test_bin_func_struct_on_stack_ko(int a, void *b, char c, sh=
ort d,
> +                                               int e, void *f, char g, s=
hort h,
> +                                               struct test_bin_struct_pa=
cked i)
> +{
> +	return a + (long)b + c + d + e + (long)f + g + h + i.a + i.b + i.c + i.=
d;
> +}
> +
> +int main()
> +{
> +	struct test_bin_struct test;
> +	struct test_bin_struct_packed test_bis;
> +
> +	test_bin_func_ok(0, NULL, 0, 0);
> +	test_bin_func_struct_ok(0, NULL, 0, test);
> +	test_bin_func_struct_on_stack_ok(0, NULL, 0, 0, 0, NULL, 0, 0, test);
> +	test_bin_func_struct_on_stack_ko(0, NULL, 0, 0, 0, NULL, 0, 0, test_bis=
);
> +	return 0;
> +}
> +
> diff --git a/tests/btf_functions.sh b/tests/btf_functions.sh
> index c92e5ae906f90badfede86eb530108894fbc8c93..fb62b0b56662bb2ae58f7adc0=
a022c400cba5e0f 100755
> --- a/tests/btf_functions.sh
> +++ b/tests/btf_functions.sh
> @@ -193,4 +193,95 @@ if [[ -n "$VERBOSE" ]]; then
>  fi
>  echo "Ok"
> =20
> +# Some specific cases can not  be tested directly with a standard kernel=
.
> +# We can use the small binary in bin/ to test those cases, like packed
> +# structs passed on the stack.=20
> +
> +echo -n "Validation of BTF encoding corner cases with test_bin functions=
; this may take some time: "
> +
> +test -n "$VERBOSE" && printf "\nBuilding test_bin..."
> +tests_dir=3D$(realpath $(dirname $0))
> +make -C ${tests_dir}/bin
> +
> +test -n "$VERBOSE" && printf "\nEncoding..."
> +pahole --btf_features=3Ddefault --lang_exclude=3Drust --btf_encode_detac=
hed=3D$outdir/test_bin.btf \
> +	--verbose ${tests_dir}/bin/test_bin | grep "skipping BTF encoding of fu=
nction" \
> +	> ${outdir}/test_bin_skipped_fns
> +
> +funcs=3D$(pfunct --format_path=3Dbtf $outdir/test_bin.btd 2>/dev/null|so=
rt)
> +pfunct --all --no_parm_names --format_path=3Ddwarf bin/test_bin | \
> +	sort|uniq > $outdir/test_bin_dwarf.funcs
> +pfunct --all --no_parm_names --format_path=3Dbtf $outdir/test_bin.btf 2>=
/dev/null|\
> +	awk '{ gsub("^(bpf_kfunc |bpf_fastcall )+",""); print $0}'|sort|uniq > =
$outdir/test_bin_btf.funcs
> +
> +exact=3D0
> +while IFS=3D read -r btf ; do
> +	# Matching process can be kept simpler as the tested binary is
> +	# specifically tailored for tests
> +	dwarf=3D$(grep -F "$btf" $outdir/test_bin_dwarf.funcs)
> +	if [[ "$btf" !=3D "$dwarf" ]]; then
> +		echo "ERROR: mismatch : BTF '$btf' not found; DWARF '$dwarf'"
> +		fail
> +	else
> +		exact=3D$((exact+1))
> +	fi
> +done < $outdir/test_bin_btf.funcs
> +
> +if [[ -n "$VERBOSE" ]]; then
> +	echo "Matched $exact functions exactly."
> +	echo "Ok"
> +	echo "Validation of skipped function logic..."
> +fi
> +
> +skipped_cnt=3D$(wc -l ${outdir}/test_bin_skipped_fns | awk '{ print $1}'=
)
> +if [[ "$skipped_cnt" =3D=3D "0" ]]; then
> +	echo "No skipped functions.  Done."
> +	exit 0
> +fi
> +
> +skipped_fns=3D$(awk '{print $1}' $outdir/test_bin_skipped_fns)
> +for s in $skipped_fns ; do
> +	# Ensure the skipped function are not in BTF
> +	inbtf=3D$(grep " $s(" $outdir/test_bin_btf.funcs)
> +	if [[ -n "$inbtf" ]]; then
> +		echo "ERROR: '${s}()' was added incorrectly to BTF: '$inbtf'"
> +		fail
> +	fi
> +done
> +
> +if [[ -n "$VERBOSE" ]]; then
> +	echo "Skipped encoding $skipped_cnt functions in BTF."
> +	echo "Ok"
> +	echo "Validating skipped functions have uncertain parameter location...=
"
> +fi
> +
> +uncertain_loc=3D$(awk '/due to uncertain parameter location/ { print $1 =
}' $outdir/test_bin_skipped_fns)
> +legitimate_skip=3D0
> +
> +for f in $uncertain_loc ; do
> +	# Extract parameters types
> +	raw_params=3D$(grep ${f} $outdir/test_bin_dwarf.funcs|sed -n 's/^[^(]*(=
\([^)]*\)).*/\1/p')
> +	IFS=3D',' read -ra params <<< "${raw_params}"
> +	for param in "${params[@]}"
> +	do
> +		# Search any param that could be a struct
> +		struct_type=3D$(echo ${param}|grep -E '^struct [^*]' | sed -E 's/^stru=
ct //')
> +		if [ -n "${struct_type}" ]; then
> +			# Check with pahole if the struct is detected as
> +			# packed
> +			if pahole -F dwarf -C "${struct_type}" ${tests_dir}/bin/test_bin|tail=
 -n 2|grep -q __packed__
> +			then
> +				legitimate_skip=3D$((legitimate_skip+1))
> +				continue 2
> +			fi
> +		fi
> +	done
> +	echo "ERROR: '${f}()' should not have been skipped; it has no parameter=
 with uncertain location"
> +	fail
> +done
> +
> +if [[ -n "$VERBOSE" ]]; then
> +	echo "Found ${legitimate_skip} legitimately skipped function due to unc=
ertain loc"
> +fi
> +echo "Ok"
>  exit 0




--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


