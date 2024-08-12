Return-Path: <bpf+bounces-36869-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8769594E6BC
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 08:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE671B22488
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 06:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549061509A0;
	Mon, 12 Aug 2024 06:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="WhITIHNA"
X-Original-To: bpf@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B2A14F135;
	Mon, 12 Aug 2024 06:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723444368; cv=none; b=KCe2pf7r87s8s5XYgNYv8C0cJbDaeoEsLUctlfyuWti/p/d2xmHJHIig/t0gr9r691ghASpJaOt6O4onEcPKDPlE/gEr1Fo++jKDLaPxBbHyWEM8DwMOs1tMlonZvUJyDKksAxGCKqQOey/FMPSzoZsVS58uYxGILTKVUAD8PZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723444368; c=relaxed/simple;
	bh=TJOoobYGSW3H4edXdGbulYQFmYkg6+AOIBTFPRwQy6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ddDz7IFrWWIuXjSknCMU1CYm5xoWMucBblRlpq951ECmWRiKd4gJYAyemo2YJnbMfFJhbyT7jQwKUtbVbaMLk30YSyu/b/WE3EtwDhDg3Pimfbu+FNMKa81M1HiMyuWGapACKwBirTmUfEP7iEz7Q6GhblW26oJipyTFg2aQEqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=WhITIHNA; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=wa9jzSCY5wF6mfUNv9dnR1b7uV0Ddg193RhLTXnVfAE=; t=1723444366;
	x=1723876366; b=WhITIHNAnW9Rq9uBEDCj+QaWX9R1A3+mkRex3Sxz9fwq4ai61i6gkcU2YphrL
	MoCYE68DjDFBf7jsd1/CZStccOO0UT+4v1wDZqvQuyb43H9NDy+SMpysYF1xvd0WeKVEdIxu9Vyps
	Ig+ghBlW81ZTkid7qiszk5ZusKKKYE3MVw/zk3bNRe1xIXdcpWujq8aZRAzvzvqkaqHm3yXwaWPXz
	EGg+qXSlHr+e1Wq1wZwhnuz8jJMY3lNqOSliBHH43oqfPsHGCqUxP0iiw4s19VOU1pZpWVmPZ5io9
	uPiybkdWFxGdFtcD9UnAxKqydSfDMDTaPy0uVF3SDZQ++fdJVA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sdObX-0000Qe-Iw; Mon, 12 Aug 2024 08:32:33 +0200
Message-ID: <99ae0d34-ed76-4ca0-a9fd-c337da33c9f9@leemhuis.info>
Date: Mon, 12 Aug 2024 08:32:29 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] tools build: Avoid circular .fixdep-in.o.cmd
 issues
To: Brian Norris <briannorris@chromium.org>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Thomas Richter <tmricht@linux.ibm.com>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
 bpf@vger.kernel.org, linux-kbuild@vger.kernel.org
References: <20240715203325.3832977-1-briannorris@chromium.org>
 <20240715203325.3832977-3-briannorris@chromium.org>
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: en-US, de-DE
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 n7RI
In-Reply-To: <20240715203325.3832977-3-briannorris@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1723444366;972cc73e;
X-HE-SMSGID: 1sdObX-0000Qe-Iw

On 15.07.24 22:32, Brian Norris wrote:
> The 'fixdep' tool is used to post-process dependency files for various
> reasons, and it runs after every object file generation command. This
> even includes 'fixdep' itself.

Lo! TWIMC, this change broke my daily arm64 and x86_64 Fedora vanilla RPM
builds on all Fedora releases when it hit -next a few days ago. Reverting
it fixes the problem.

The problem is related to the RPM magic somehow, as building worked fine
when when I omitted stuff like "-specs=/usr/lib/rpm/redhat/redhat-
hardened-cc1 -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1" from the
make call. So the real problem might be that space somewhere.


This is how the build fails on x86_64:

+ /usr/bin/make -s 'HOSTCFLAGS=-O2  -fexceptions -g -grecord-gcc-switches -pipe -Wall -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1  -m64 -march=x86-64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection   ' 'HOSTLDFLAGS=-Wl,-z,relro -Wl,--as-needed  -Wl,-z,pack-relative-relocs -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1  -Wl,--build-id=sha1 -specs=/usr/lib/rpm/redhat/redhat-package-notes ' ARCH=x86_64 'KCFLAGS= ' WITH_GCOV=0 -j2 bzImage
/usr/bin/ld: /tmp/ccMoR0Wr.o: relocation R_X86_64_32 against `.rodata' can not be used when making a PIE object; recompile with -fPIE
/usr/bin/ld: failed to set dynamic section sizes: bad value
collect2: error: ld returned 1 exit status
make[4]: *** [Makefile:47: /builddir/build/BUILD/kernel-next-20240812/linux-6.11.0-0.0.next.20240812.329.vanilla.fc40.x86_64/tools/objtool/fixdep] Error 1
make[3]: *** [/builddir/build/BUILD/kernel-next-20240812/linux-6.11.0-0.0.next.20240812.329.vanilla.fc40.x86_64/tools/build/Makefile.include:15: fixdep] Error 2
make[2]: *** [Makefile:73: objtool] Error 2
make[1]: *** [/builddir/build/BUILD/kernel-next-20240812/linux-6.11.0-0.0.next.20240812.329.vanilla.fc40.x86_64/Makefile:1361: tools/objtool] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:226: __sub-make] Error 2
error: Bad exit status from /var/tmp/rpm-tmp.ZQfBFY (%build)


This is how it fails on arm64:

+ /usr/bin/make -s 'HOSTCFLAGS=-O2  -fexceptions -g -grecord-gcc-switches -pipe -Wall -Werror=format-security -Wp,-U_FORTIFY_SOURCE,-D_FORTIFY_SOURCE=3 -Wp,-D_GLIBCXX_ASSERTIONS -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1  -mbranch-protection=standard -fasynchronous-unwind-tables -fstack-clash-protection   ' 'HOSTLDFLAGS=-Wl,-z,relro -Wl,--as-needed   -Wl,-z,now -specs=/usr/lib/rpm/redhat/redhat-hardened-ld -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1  -Wl,--build-id=sha1 -specs=/usr/lib/rpm/redhat/redhat-package-notes ' ARCH=arm64 'KCFLAGS= ' WITH_GCOV=0 -j4 vmlinuz.efi
/usr/bin/ld: /tmp/ccRCv9ot.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `stderr@@GLIBC_2.17' which may bind externally can not be used when making a shared object; recompile with -fPIC
/usr/bin/ld: /tmp/ccRCv9ot.o(.text+0x8): unresolvable R_AARCH64_ADR_PREL_PG_HI21 relocation against symbol `stderr@@GLIBC_2.17'
/usr/bin/ld: final link failed: bad value
collect2: error: ld returned 1 exit status
make[4]: *** [Makefile:47: /builddir/build/BUILD/kernel-next-20240812/linux-6.11.0-0.0.next.20240812.329.vanilla.fc40.aarch64/tools/bpf/resolve_btfids/fixdep] Error 1
make[3]: *** [/builddir/build/BUILD/kernel-next-20240812/linux-6.11.0-0.0.next.20240812.329.vanilla.fc40.aarch64/tools/build/Makefile.include:15: fixdep] Error 2
make[2]: *** [Makefile:76: bpf/resolve_btfids] Error 2
make[1]: *** [/builddir/build/BUILD/kernel-next-20240812/linux-6.11.0-0.0.next.20240812.329.vanilla.fc40.aarch64/Makefile:1362: tools/bpf/resolve_btfids] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:226: __sub-make] Error 2
error: Bad exit status from /var/tmp/rpm-tmp.60qjsr (%build)


Full logs:
https://download.copr.fedorainfracloud.org/results/@kernel-vanilla/next/fedora-40-x86_64/07900504-next-next-all/builder-live.log.gz
https://download.copr.fedorainfracloud.org/results/@kernel-vanilla/next/fedora-40-aarch64/07900504-next-next-all/builder-live.log.gz

My ppc64le builds worked fine.
 
Ciao, Thorsten

> In Kbuild, this isn't actually a problem, because it uses a single
> command to generate fixdep (a compile-and-link command on fixdep.c), and
> afterward runs the fixdep command on the accompanying .fixdep.cmd file.
> 
> In tools/ builds (which notably is maintained separately from Kbuild),
> fixdep is generated in several phases:
> 
>  1. fixdep.c -> fixdep-in.o
>  2. fixdep-in.o -> fixdep
> 
> Thus, fixdep is not available in the post-processing for step 1, and
> instead, we generate .cmd files that look like:
> 
>   ## from tools/objtool/libsubcmd/.fixdep.o.cmd
>   # cannot find fixdep (/path/to/linux/tools/objtool/libsubcmd//fixdep)
>   [...]
> 
> These invalid .cmd files are benign in some respects, but cause problems
> in others (such as the linked reports).
> 
> Because the tools/ build system is rather complicated in its own right
> (and pointedly different than Kbuild), I choose to simply open-code the
> rule for building fixdep, and avoid the recursive-make indirection that
> produces the problem in the first place.
> 
> Link: https://lore.kernel.org/all/Zk-C5Eg84yt6_nml@google.com/
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> 
> (no changes since v3)
> 
> Changes in v3:
>  - Drop unnecessary tools/build/Build
> 
>  tools/build/Build    |  3 ---
>  tools/build/Makefile | 11 ++---------
>  2 files changed, 2 insertions(+), 12 deletions(-)
>  delete mode 100644 tools/build/Build
> 
> diff --git a/tools/build/Build b/tools/build/Build
> deleted file mode 100644
> index 76d1a4960973..000000000000
> --- a/tools/build/Build
> +++ /dev/null
> @@ -1,3 +0,0 @@
> -hostprogs := fixdep
> -
> -fixdep-y := fixdep.o
> diff --git a/tools/build/Makefile b/tools/build/Makefile
> index 17cdf01e29a0..fea3cf647f5b 100644
> --- a/tools/build/Makefile
> +++ b/tools/build/Makefile
> @@ -43,12 +43,5 @@ ifneq ($(wildcard $(TMP_O)),)
>  	$(Q)$(MAKE) -C feature OUTPUT=$(TMP_O) clean >/dev/null
>  endif
>  
> -$(OUTPUT)fixdep-in.o: FORCE
> -	$(Q)$(MAKE) $(build)=fixdep
> -
> -$(OUTPUT)fixdep: $(OUTPUT)fixdep-in.o
> -	$(QUIET_LINK)$(HOSTCC) $(KBUILD_HOSTLDFLAGS) -o $@ $<
> -
> -FORCE:
> -
> -.PHONY: FORCE
> +$(OUTPUT)fixdep: $(srctree)/tools/build/fixdep.c
> +	$(QUIET_CC)$(HOSTCC) $(KBUILD_HOSTLDFLAGS) -o $@ $<

