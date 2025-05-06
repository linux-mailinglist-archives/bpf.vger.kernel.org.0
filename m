Return-Path: <bpf+bounces-57575-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B75EAAD108
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 00:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F83C3B04EA
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 22:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BAF21ABA4;
	Tue,  6 May 2025 22:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c++79TcM"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80223218ADD
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 22:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746570902; cv=none; b=oB1BomXjmglHl8I5pDudBUews6YuzIGc5epbVJIfddyEimcHZrjQTsLmom8bvOwxVfKhyAtgmo3Bbyhi/7C/Pxw6bhmnLueSwDgzKz349x5ZEOG2KtCNExGz2nCUBD8yTNMalhJGxaAmcoffNMfqfjMRE3uNTNp4eYSbfpB7DRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746570902; c=relaxed/simple;
	bh=7FiQFw0htw/k7PeAFWnJY445mbkU+AWLhZMUElnjbDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TD4/+ROkyW27Kw9MsSyAVMFKvbgkxlQqTz82YJQ0xnLw3cmouhS9TUN48c91co5rxTdXFqrykk/fJEQp14+d7sc0QUh4yKoDZPV3AeErCEN2hvlhHiWlZ7yxaD5rbbDHj32Ha/9fHgKyAm60/VchGiEgya+PIgt2oR2flaDs1Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c++79TcM; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f5084334-d3d4-4e4c-94aa-30afc9e87a11@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746570888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h07s3C6UB1DBwL0iC2nHUyp7lKmxW6PTQ955Zo+K6l8=;
	b=c++79TcMhoJjZx8bmIDRUtrR3egHBDg/oh641dQqZljpaxrc1vqjWEHpE4OMeK/mwvtmh9
	L4TkvugNYnug019+Qhwh+6mCU6rCaiUAFoJ9CeCzkLkqzZvz3PIJncGc0zLyRYxMlkCI/v
	QXYI8GSOQ+o192A2kSCpjdz/Miqq7ZU=
Date: Tue, 6 May 2025 15:34:35 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpftool: build bpf bits with -std=gnu11
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <20250502085710.3980-1-holger@applied-asynchrony.com>
 <7326223e-0cb9-4d22-872f-cbf1ff42227d@kernel.org>
 <913f66a8-6745-0e30-b5b8-96d23bf05b90@applied-asynchrony.com>
 <CAADnVQLpyNiyghWLMq5AxkBgZX4J9VfX5j4ToNh6UsrQ=4yndg@mail.gmail.com>
 <2a8208af-bc4b-f1bd-af0b-f5db485ed1f0@applied-asynchrony.com>
 <CAEf4BzYLYJtcehZhB22YsxRXZBcVnunNx-rm9CfTcDZFiY10jQ@mail.gmail.com>
 <e5122286-68f0-4173-8549-a0705c4ca4b1@linux.dev>
 <CAEf4BzZKKd+0Hwok=BxyBsWMUnBBTUGj-ZfJK-voMXowRKPgNQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAEf4BzZKKd+0Hwok=BxyBsWMUnBBTUGj-ZfJK-voMXowRKPgNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2025-05-06 3:23 p.m., Andrii Nakryiko wrote:
> On Tue, May 6, 2025 at 2:41 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> On 2025-05-06 2:04 p.m., Andrii Nakryiko wrote:
>>   > On Sun, May 4, 2025 at 3:24 AM Holger Hoffstätte
>>   > <holger@applied-asynchrony.com> wrote:
>>   >>
>>   >> On 2025-05-03 04:36, Alexei Starovoitov wrote:
>>   >>> On Fri, May 2, 2025 at 2:53 AM Holger Hoffstätte
>>   >>> <holger@applied-asynchrony.com> wrote:
>>   >>>>
>>   >>>> On 2025-05-02 11:26, Quentin Monnet wrote:
>>   >>>>> On 02/05/2025 09:57, Holger Hoffstätte wrote:
>>   >>>>>> A gcc-15-based bpf toolchain defaults to C23 and fails to
>> compile various
>>   >>>>>> kernel headers due to their use of a custom 'bool' type.
>>   >>>>>> Explicitly using -std=gnu11 works with both clang and bpf-toolchain.
>>   >>>>>>
>>   >>>>>> Signed-off-by: Holger Hoffstätte <holger@applied-asynchrony.com>
>>   >>>>>
>>   >>>>> Thanks! I tested that it still works with clang.
>>   >>>>>
>>   >>>>> Acked-by: Quentin Monnet <qmo@kernel.org>
>>   >>>>
>>   >>>> Thanks!
>>   >>>>
>>   >>>>> I didn't manage to compile with gcc, though. I tried with gcc
>> 15.1.1 but
>>   >>>>> option '--target=bpf' is apparently unrecognised by the gcc
>> version on
>>   >>>>> my setup.
>>   >>>>>
>>   >>>>> Out of curiosity, how did you build using gcc for the skeleton?
>> Was it
>>   >>>>> enough to run "CLANG=gcc make"? Does it pass the clang-bpf-co-re
>> build
>>   >>>>> probe successfully?
>>   >>>>
>>   >>>> I'm on Gentoo where we have a gcc-14/15 based "bpf-toolchain" package,
>>   >>>> which is just gcc configured & packaged for the bpf target.
>>   >>>> Our bpftool package can be built with clang (default) or without, in
>>   >>>> which case it depend on the bpf-toolchain. The idea is to gradually
>>   >>>> allow bpf/xdp tooling to build/run without requiring clang.
>>   >>>>
>>   >>>> The --target definition is conditional and removed when not using
>> clang:
>>   >>>>
>> https://gitweb.gentoo.org/repo/gentoo.git/tree/dev-util/bpftool/bpftool-7.5.0.ebuild?id=bf70fbf7b0dc97fbc97af579954ea81a8df36113#n94
>>   >>>>
>>   >>>> The bug for building with the new gcc-15 based toolchain where this
>>   >>>> patch originated is here: https://bugs.gentoo.org/955156
>>   >>>
>>   >>> So you're fixing this build error:
>>   >>>
>>   >>> bpf-unknown-none-gcc \
>>   >>>           -I. \
>>   >>>
>> -I/var/tmp/portage/dev-util/bpftool-7.5.0/work/bpftool-libbpf-v7.5.0-sources/include/uapi/
>>   >>> \
>>   >>>
>> -I/var/tmp/portage/dev-util/bpftool-7.5.0/work/bpftool-libbpf-v7.5.0-sources/src/bootstrap/libbpf/include
>>   >>> \
>>   >>>           -g -O2 -Wall -fno-stack-protector \
>>   >>>            -c skeleton/profiler.bpf.c -o profiler.bpf.o
>>   >>> In file included from skeleton/profiler.bpf.c:3:
>>   >>> ./vmlinux.h:5: warning: ignoring '#pragma clang attribute'
>> [-Wunknown-pragmas]
>>   >>>       5 | #pragma clang attribute push
>>   >>> (__attribute__((preserve_access_index)), apply_to = record)
>>   >>> ./vmlinux.h:9845:9: error: cannot use keyword 'false' as
>> enumeration constant
>>   >>>    9845 |         false = 0,
>>   >>>         |         ^~~~~
>>   >>> ./vmlinux.h:9845:9: note: 'false' is a keyword with '-std=c23' onwards
>>   >>> ./vmlinux.h:31137:15: error: 'bool' cannot be defined via 'typedef'
>>   >>> 31137 | typedef _Bool bool;
>>   >>>         |               ^~~~
>>   >>>
>>   >>> with -std=gnu11 flag and
>>   >>
>>   >> Yes, correct. This is the same as all over the kernel or the bpf tests
>>   >> for handling C23. I fully understand that this particular patch is only
>>   >> one piece of the puzzle.
>>   >>
>>   >
>>   > What's the best way to detect (at compile time) whether bool, false,
>>   > and true are treated as reserved keywords? To solve this properly
>>   > vmlinux.h would have to be adjusted by vmlinux.h to avoid emitting
>>   > bool/false/true *iff* compiler version/mode doesn't like that
>>
>> I ran into this when adding GCC BPF to CI [1].
>>
>> One can do something like:
>>
>>        #if __STDC_VERSION__ < 202311L
>>        enum {
>>            false = 0,
>>            true = 1,
>>        };
>>        #endif
>>
>> But in case of vmlinux.h this would require hacking bpftool, and so for
>> selftests/bpf we decided to pass -std=gnu11 [2].
> 
> We can adjust btf_dump_is_blacklisted() to ignore bool typedef
> (unconditionally), and we'll need to ignore anon enum with false/true
> (which is annoying), and then bpftool will unconditionally add the
> above block plus typedef _Bool bool.
> 
> Would that work?

I think yes, but then the question is why do all this work in bpftool 
instead of passing -std=gnu11 to the compiler? Especially given that 
kernel is built with such flags:

$ grep -r --include="[Mm]akefile" 'std=gnu'

     arch/arm64/kernel/vdso32/Makefile:               -std=gnu11
     arch/loongarch/vdso/Makefile:   -std=gnu11 -O2 -g 
-fno-strict-aliasing -fno-common -fno-builtin \
     arch/s390/Makefile:KBUILD_CFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) 
-m64 -O2 -mpacked-stack -std=gnu11
     arch/s390/purgatory/Makefile:KBUILD_CFLAGS := -std=gnu11 
-fno-strict-aliasing -Wall -Wstrict-prototypes
     arch/x86/Makefile:REALMODE_CFLAGS       := -std=gnu11 -m16 -g -Os 
-DDISABLE_BRANCH_PROFILING -D__DISABLE_EXPORTS \
     arch/x86/boot/compressed/Makefile:KBUILD_CFLAGS += -std=gnu11
     drivers/firmware/efi/libstub/Makefile:cflags-$(CONFIG_X86) 
     += -m$(BITS) -D__KERNEL__ -std=gnu11 \
     tools/build/feature/Makefile:   $(BUILDXX) -std=gnu++11
     tools/build/feature/Makefile:   $(BUILDXX) -std=gnu++17 
                     \
     tools/build/feature/Makefile:   $(BUILDXX) -std=gnu++17 
                     \
     tools/build/feature/Makefile:   $(BUILDXX) -std=gnu++17 
                     \
     tools/lib/api/Makefile:CFLAGS += -ggdb3 -Wall -Wextra -std=gnu99 
-U_FORTIFY_SOURCE -fPIC
     tools/lib/bpf/Makefile:override CFLAGS += -std=gnu89
     tools/lib/subcmd/Makefile:CFLAGS := -ggdb3 -Wall -Wextra -std=gnu99 
-fPIC
     tools/lib/symbol/Makefile:CFLAGS += -ggdb3 -Wall -Wextra -std=gnu11 
-U_FORTIFY_SOURCE -fPIC
     tools/net/ynl/generated/Makefile:CFLAGS += -std=gnu11 -O2 -W -Wall 
-Wextra -Wno-unused-parameter -Wshadow \
     tools/net/ynl/lib/Makefile:CFLAGS += -std=gnu11 -O2 -W -Wall 
-Wextra -Wno-unused-parameter -Wshadow
     tools/net/ynl/samples/Makefile:CFLAGS += -std=gnu11 -O2 -W -Wall 
-Wextra -Wno-unused-parameter -Wshadow \
     tools/testing/selftests/arm64/gcs/Makefile:             -std=gnu99 
-I../.. -g \
     tools/testing/selftests/arm64/mte/Makefile:CFLAGS += -std=gnu99 -I. 
-pthread
     tools/testing/selftests/arm64/signal/Makefile:CFLAGS += -std=gnu99 -I.
     tools/testing/selftests/bpf/Makefile:CFLAGS += -g $(OPT_FLAGS) 
-rdynamic -std=gnu11                             \
     tools/testing/selftests/bpf/Makefile:        -std=gnu11 
                                     \
     tools/testing/selftests/bpf/Makefile:CXXFLAGS := $(subst 
-std=gnu11,-std=gnu++11,$(CXXFLAGS))
     tools/testing/selftests/capabilities/Makefile:CFLAGS += -O2 -g 
-std=gnu99 -Wall $(KHDR_INCLUDES)
     tools/testing/selftests/clone3/Makefile:CFLAGS += -g -std=gnu99 
$(KHDR_INCLUDES)
     tools/testing/selftests/riscv/mm/Makefile:CFLAGS += -std=gnu99 -I.
     tools/testing/selftests/sync/Makefile:CFLAGS += -O2 -g -std=gnu89 
-pthread -Wall -Wextra
     tools/testing/selftests/vDSO/Makefile:CFLAGS := -std=gnu99 -O2
     tools/testing/selftests/wireguard/qemu/Makefile:        $(CC) -o $@ 
$(CFLAGS) $(LDFLAGS) -std=gnu11 $<
     tools/testing/selftests/x86/Makefile:CFLAGS := -O2 -g -std=gnu99 
-pthread -Wall $(KHDR_INCLUDES)
     Makefile:                        -O2 -fomit-frame-pointer -std=gnu11
     Makefile:KBUILD_CFLAGS += -std=gnu11

> 
>>
>> [1]
>> https://lore.kernel.org/bpf/CAADnVQKNqdLW1bpvCpVV3yNizwra0cCkBnAbsNp3rTmi8WFcvQ@mail.gmail.com/
>> [2]
>> https://lore.kernel.org/bpf/20250107235813.2964472-1-ihor.solodrai@pm.me/
>>
>>   >
>>   >>> ignoring an important warning ?
>>   >>
>>   >> Nobody is (or was) ignoring the warning - it was under discussion when
>>   >> I posted the patch. After reaching out to Oracle to verify, we have now
>>   >> added the BPF_NO_PRESERVE_ACCESS_INDEX define when building with
>> gcc-bpf;
>>   >> this resolves the warning, just like in the bpf self-tests.
>>   >>
>>   >> You are right that such an addition to the in-kernel bpftool build is
>>   >> still missing. If you have a suggestion on how best to do that via the
>>   >> existing Makefile I'm all ears.
>>   >>
>>   >> As for the remaining warnings - we are also very aware of the ongoing
>>   >> upstream work to support btf_type_tag:
>>   >> https://gcc.gnu.org/pipermail/gcc-patches/2025-April/682340.html.
>>   >>
>>   >>> End result: partially functional bpftool,
>>   >>> and users will have no idea why some features of bpftool are not
>> working.
>>   >>
>>   >> First of all this is never shipped to any users; using gcc-bpf requires
>>   >> active opt-in by developers or users, and now also warns that such a
>> setup
>>   >> may result in unexpected bugs due to ongoing work in both Linux and
>> bpftool.
>>   >> Like I said before, by default everyone builds with clang and that
>> is also
>>   >> true for our distributed binaries.
>>   >>
>>   >> If you think adding the -std=gnu11 bit is inappropriate at this time
>> then
>>   >> just ignore this patch for now. Sooner or later the bpftool build
>> will have
>>   >> to be adapted with BPF_CFLAGS (liek in the selftests) and hopefuilly an
>>   >> abstracted BPF_CC so that we no longer have to pretend to be clang when
>>   >> using gcc.
>>   >>
>>   >> cheers
>>   >> Holger


