Return-Path: <bpf+bounces-62553-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 236D5AFBBC8
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 21:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 091A03A6DD8
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 19:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D95264F9C;
	Mon,  7 Jul 2025 19:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oFD9RQxo"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5278B13D503
	for <bpf@vger.kernel.org>; Mon,  7 Jul 2025 19:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751916999; cv=none; b=kceYhscI563e1wcxFBerPBuHA/ZAZJjHJ9CWxQcmeOyER0XcTcAoWaKKV3/lqI3WfyBMYS7jc989VIc+ddd7aksfihm84T2meoU02fOJcYJCxHxiYUGvA502cgu2cqXkIGUPu4nfOscVvZBZdLZBidj2TRuCM9MM/aAKSi0ye/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751916999; c=relaxed/simple;
	bh=TrLTiwlF0Wf07e2lz86PEpXxOC8UWVgE1D/eE9Kpggg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hOAXW6nNCfMqhxFNTvuc2OjUEj9R/k9McblmDOq2JO2JLF0eXvSDMMaUrqrsml+Q7unLIKyX1ASiAK1V00lfCxgWJz+iR1JhrBxOBY6Pux+syXVV7K9cBmqqIKVOBct3nXhCk1zv2TJgY/kZ2pbNyV8m12Ny2PN+WthWn3FY7jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oFD9RQxo; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d26bb031-e88c-4d4b-8ce2-439aedc7a4a8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751916994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/sFmXTIjjAia35F8WO4yUmRUuNa3ruhUnQVqpCKns9w=;
	b=oFD9RQxoBIITcN48qot81LamWT87VmRieqfXSMI2EOkEse+5NWG7LQkKKuFfI01SLoHFD4
	LbHHKiOFjckKvGgl5na3ZetBKnJn9OId3A8Am5sm9gUvS8Rs1QPmzV8AYUPYIssdHBTzLw
	C31npqu0LBF4X5LqVn6odmpIWh39JeM=
Date: Mon, 7 Jul 2025 12:36:26 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/3] tests: add some tests validating skipped functions
 due to uncertain arg location
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 dwarves@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@fb.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>, ebpf@linuxfoundation.org
References: <20250707-btf_skip_structs_on_stack-v3-0-29569e086c12@bootlin.com>
 <20250707-btf_skip_structs_on_stack-v3-2-29569e086c12@bootlin.com>
 <DB5VWHU0N27I.3ETC4G47KB9Q@bootlin.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <DB5VWHU0N27I.3ETC4G47KB9Q@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 7/7/25 7:14 AM, Alexis LothorÃ© wrote:
> On Mon Jul 7, 2025 at 4:02 PM CEST, Alexis Lothoré (eBPF Foundation) wrote:
>> Add a small binary representing specific cases likely absent from
>> standard vmlinux or kernel modules files. As a starter, the introduced
>> binary exposes a few functions consuming structs passed by value, some
>> passed by register, some passed on the stack:
>>
>>    int main(void);
>>    int test_bin_func_struct_on_stack_ko(int, void *, char, short int, int, \
>>      void *, char, short int, struct test_bin_struct_packed);
>>    int test_bin_func_struct_on_stack_ok(int, void *, char, short int, int, \
>>      void *, char, short int, struct test_bin_struct);
>>    int test_bin_func_struct_ok(int, void *, char, struct test_bin_struct);
>>    int test_bin_func_ok(int, void *, char, short int);
>>
>> Then enrich btf_functions.sh to make it perform the following steps:
>> - build the binary
>> - generate BTF info and pfunct listing, both with dwarf and the
>>    generated BTF
>> - check that any function encoded in BTF is found in DWARF
>> - check that any function announced as skipped is indeed absent from BTF
>> - check that any skipped function has been skipped due to uncertain
>>    parameter location
>>
>> Example of the new test execution:
>>    Encoding...Matched 4 functions exactly.
>>    Ok
>>    Validation of skipped function logic...
>>    Skipped encoding 1 functions in BTF.
>>    Ok
>>    Validating skipped functions have uncertain parameter location...
>>    pahole: /home/alexis/src/pahole/tests/bin/test_bin: Invalid argument
> 
> A word about this specific error: I may have missed it in the previous
> iteration, but I systematically get this error when running the following
> command:
>    $ pahole -C test_bin_struct_packed tests/bin/test_bin
> 
> I initially thought that it would be something related to the binary being
> a userspace program and not a kernel module, but I observe the following:
> - the issue is observed even on a .ko file (tested on the previous series
>    iteration with kmod.ko)
> - the issue does not appear if there is no class filtering (ie the `-C`
>    arg) provided to pahole
> - the issue occurs as well with the packaged pahole version on my host (v1.30)
> - the struct layout is still displayed correctly despite the error
> 
> A quick bisect shows that the error log has started appearing with
> 59f5409f1357 ("dwarf_loader: Fix termination on BTF encoding error"). This
> commit has "enforced" error propagation if dwfl_getmodules returns
> something different than 0 (before, it was propagating an error only if the
> error code was negative, but dwfl_getmodules seems to be able to return
> values > 0 as well). As is sound unrelated to this series, I pushed this
> new revision anyway. [1] seems to hint that the issue is known, but in my
> case I don't get any additional log about unhandled DWARF operation. The
> issue is pretty repeatable on my side, feel free to ask for any additional
> detail or manipulation that could help.

I looked into this...

pahole_stealer may return LSK__STOP_LOADING in normal case, for example
when a class filter is provided [1]:

	if (list_empty(&class_names)) {
dump_and_stop:
		ret = LSK__STOP_LOADING;
	}

And in the dwarf_loader we abort (as with error) in case of 
LSK__STOP_LOADING [2]:

	if (cus__steal_now(dcus->cus, job->cu, dcus->conf) == LSK__STOP_LOADING)
		goto out_abort;

This was not an issue before 59f5409f1357 because of how errors were
propagated to dwfl_getmodules(), as mentioned in the other thread.

I think a proper fix for this is differentiating two variants of 
LSK__STOP_LOADING: stop because of an error, and stop because there is
nothing else to do. That would require a bit of refactoring.

Alan, Arnaldo, what do you think?

[1] https://github.com/acmel/dwarves/blob/master/pahole.c#L3390-L3392
[2] https://github.com/acmel/dwarves/blob/master/dwarf_loader.c#L3678-L3679

> 
> [1] https://lore.kernel.org/dwarves/933e199997949c0ac8a71551830f1e6c98d8bff0@linux.dev/
>>    Found 1 legitimately skipped function due to uncertain loc
>>    Ok
>>
>> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
>> ---
>> Changes in v3:
>> - bring a userspace binary instead of an OoT kernel module
>> - remove test dependency to a kernel directory being provided
>> - improve test dir detection
>>
>> Changes in v2:
>> - new patch
>> ---
>>   tests/bin/Makefile     | 10 ++++++
>>   tests/bin/test_bin.c   | 66 ++++++++++++++++++++++++++++++++++++
>>   tests/btf_functions.sh | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 167 insertions(+)
>>
>> diff --git a/tests/bin/Makefile b/tests/bin/Makefile
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..70bcf57ac4744f30fe03ea12908e42c69390f14a
>> --- /dev/null
>> +++ b/tests/bin/Makefile
>> @@ -0,0 +1,10 @@
>> +CC=${CROSS_COMPILE}gcc
>> +
>> +test_bin: test_bin.c
>> +	${CC} $^ -Wall -Wextra -Werror -g -o $@
>> +
>> +clean:
>> +	rm -rf test_bin
>> +
>> +.PHONY: clean
>> +
>> diff --git a/tests/bin/test_bin.c b/tests/bin/test_bin.c
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..ca6a4852cc511243925db905e55e040519af9cfd
>> --- /dev/null
>> +++ b/tests/bin/test_bin.c
>> @@ -0,0 +1,66 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#include <stdio.h>
>> +
>> +#define noinline __attribute__((noinline))
>> +#define __packed __attribute__((__packed__))
>> +
>> +struct test_bin_struct {
>> +	char a;
>> +	short b;
>> +	int c;
>> +	unsigned long long d;
>> +};
>> +
>> +struct test_bin_struct_packed {
>> +	char a;
>> +	short b;
>> +	int c;
>> +	unsigned long long d;
>> +}__packed;
>> +
>> +int test_bin_func_ok(int a, void *b, char c, short d);
>> +int test_bin_func_struct_ok(int a, void *b, char c, struct test_bin_struct d);
>> +int test_bin_func_struct_on_stack_ok(int a, void *b, char c, short d, int e,
>> +                                      void *f, char g, short h,
>> +                                      struct test_bin_struct i);
>> +int test_bin_func_struct_on_stack_ko(int a, void *b, char c, short d, int e,
>> +                                      void *f, char g, short h,
>> +                                      struct test_bin_struct_packed i);
>> +
>> +noinline int test_bin_func_ok(int a, void *b, char c, short d)
>> +{
>> +	return a + (long)b + c + d;
>> +}
>> +
>> +noinline int test_bin_func_struct_ok(int a, void *b, char c,
>> +                                      struct test_bin_struct d)
>> +{
>> +	return a + (long)b + c + d.a + d.b + d.c + d.d;
>> +}
>> +
>> +noinline int test_bin_func_struct_on_stack_ok(int a, void *b, char c, short d,
>> +                                               int e, void *f, char g, short h,
>> +                                               struct test_bin_struct i)
>> +{
>> +	return a + (long)b + c + d + e + (long)f + g + h + i.a + i.b + i.c + i.d;
>> +}
>> +
>> +noinline int test_bin_func_struct_on_stack_ko(int a, void *b, char c, short d,
>> +                                               int e, void *f, char g, short h,
>> +                                               struct test_bin_struct_packed i)
>> +{
>> +	return a + (long)b + c + d + e + (long)f + g + h + i.a + i.b + i.c + i.d;
>> +}
>> +
>> +int main()
>> +{
>> +	struct test_bin_struct test;
>> +	struct test_bin_struct_packed test_bis;
>> +
>> +	test_bin_func_ok(0, NULL, 0, 0);
>> +	test_bin_func_struct_ok(0, NULL, 0, test);
>> +	test_bin_func_struct_on_stack_ok(0, NULL, 0, 0, 0, NULL, 0, 0, test);
>> +	test_bin_func_struct_on_stack_ko(0, NULL, 0, 0, 0, NULL, 0, 0, test_bis);
>> +	return 0;
>> +}
>> +
>> diff --git a/tests/btf_functions.sh b/tests/btf_functions.sh
>> index c92e5ae906f90badfede86eb530108894fbc8c93..fb62b0b56662bb2ae58f7adc0a022c400cba5e0f 100755
>> --- a/tests/btf_functions.sh
>> +++ b/tests/btf_functions.sh
>> @@ -193,4 +193,95 @@ if [[ -n "$VERBOSE" ]]; then
>>   fi
>>   echo "Ok"
>>   
>> +# Some specific cases can not  be tested directly with a standard kernel.
>> +# We can use the small binary in bin/ to test those cases, like packed
>> +# structs passed on the stack.
>> +
>> +echo -n "Validation of BTF encoding corner cases with test_bin functions; this may take some time: "
>> +
>> +test -n "$VERBOSE" && printf "\nBuilding test_bin..."
>> +tests_dir=$(realpath $(dirname $0))
>> +make -C ${tests_dir}/bin
>> +
>> +test -n "$VERBOSE" && printf "\nEncoding..."
>> +pahole --btf_features=default --lang_exclude=rust --btf_encode_detached=$outdir/test_bin.btf \
>> +	--verbose ${tests_dir}/bin/test_bin | grep "skipping BTF encoding of function" \
>> +	> ${outdir}/test_bin_skipped_fns
>> +
>> +funcs=$(pfunct --format_path=btf $outdir/test_bin.btd 2>/dev/null|sort)
>> +pfunct --all --no_parm_names --format_path=dwarf bin/test_bin | \
>> +	sort|uniq > $outdir/test_bin_dwarf.funcs
>> +pfunct --all --no_parm_names --format_path=btf $outdir/test_bin.btf 2>/dev/null|\
>> +	awk '{ gsub("^(bpf_kfunc |bpf_fastcall )+",""); print $0}'|sort|uniq > $outdir/test_bin_btf.funcs
>> +
>> +exact=0
>> +while IFS= read -r btf ; do
>> +	# Matching process can be kept simpler as the tested binary is
>> +	# specifically tailored for tests
>> +	dwarf=$(grep -F "$btf" $outdir/test_bin_dwarf.funcs)
>> +	if [[ "$btf" != "$dwarf" ]]; then
>> +		echo "ERROR: mismatch : BTF '$btf' not found; DWARF '$dwarf'"
>> +		fail
>> +	else
>> +		exact=$((exact+1))
>> +	fi
>> +done < $outdir/test_bin_btf.funcs
>> +
>> +if [[ -n "$VERBOSE" ]]; then
>> +	echo "Matched $exact functions exactly."
>> +	echo "Ok"
>> +	echo "Validation of skipped function logic..."
>> +fi
>> +
>> +skipped_cnt=$(wc -l ${outdir}/test_bin_skipped_fns | awk '{ print $1}')
>> +if [[ "$skipped_cnt" == "0" ]]; then
>> +	echo "No skipped functions.  Done."
>> +	exit 0
>> +fi
>> +
>> +skipped_fns=$(awk '{print $1}' $outdir/test_bin_skipped_fns)
>> +for s in $skipped_fns ; do
>> +	# Ensure the skipped function are not in BTF
>> +	inbtf=$(grep " $s(" $outdir/test_bin_btf.funcs)
>> +	if [[ -n "$inbtf" ]]; then
>> +		echo "ERROR: '${s}()' was added incorrectly to BTF: '$inbtf'"
>> +		fail
>> +	fi
>> +done
>> +
>> +if [[ -n "$VERBOSE" ]]; then
>> +	echo "Skipped encoding $skipped_cnt functions in BTF."
>> +	echo "Ok"
>> +	echo "Validating skipped functions have uncertain parameter location..."
>> +fi
>> +
>> +uncertain_loc=$(awk '/due to uncertain parameter location/ { print $1 }' $outdir/test_bin_skipped_fns)
>> +legitimate_skip=0
>> +
>> +for f in $uncertain_loc ; do
>> +	# Extract parameters types
>> +	raw_params=$(grep ${f} $outdir/test_bin_dwarf.funcs|sed -n 's/^[^(]*(\([^)]*\)).*/\1/p')
>> +	IFS=',' read -ra params <<< "${raw_params}"
>> +	for param in "${params[@]}"
>> +	do
>> +		# Search any param that could be a struct
>> +		struct_type=$(echo ${param}|grep -E '^struct [^*]' | sed -E 's/^struct //')
>> +		if [ -n "${struct_type}" ]; then
>> +			# Check with pahole if the struct is detected as
>> +			# packed
>> +			if pahole -F dwarf -C "${struct_type}" ${tests_dir}/bin/test_bin|tail -n 2|grep -q __packed__
>> +			then
>> +				legitimate_skip=$((legitimate_skip+1))
>> +				continue 2
>> +			fi
>> +		fi
>> +	done
>> +	echo "ERROR: '${f}()' should not have been skipped; it has no parameter with uncertain location"
>> +	fail
>> +done
>> +
>> +if [[ -n "$VERBOSE" ]]; then
>> +	echo "Found ${legitimate_skip} legitimately skipped function due to uncertain loc"
>> +fi
>> +echo "Ok"
>>   exit 0
> 
> 
> 
> 


